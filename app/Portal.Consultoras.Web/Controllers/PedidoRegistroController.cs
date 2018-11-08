using AutoMapper;
using Portal.Consultoras.Common;
using Portal.Consultoras.PublicService.Cryptography;
using Portal.Consultoras.Web.Models;
using Portal.Consultoras.Web.Providers;
using Portal.Consultoras.Web.ServiceCliente;
using Portal.Consultoras.Web.ServiceContenido;
using Portal.Consultoras.Web.ServiceODS;
using Portal.Consultoras.Web.ServicePedido;
using Portal.Consultoras.Web.ServiceSAC;
using Portal.Consultoras.Web.ServicesCalculosPROL;
using Portal.Consultoras.Web.ServiceUsuario;
using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.ServiceModel;
using System.Text;
using System.Text.RegularExpressions;
using System.Threading.Tasks;
using System.Web;
using System.Web.Configuration;
using System.Web.Mvc;
using System.Web.Routing;
using BEPedidoWeb = Portal.Consultoras.Web.ServicePedido.BEPedidoWeb;
using BEPedidoWebDetalle = Portal.Consultoras.Web.ServicePedido.BEPedidoWebDetalle;

namespace Portal.Consultoras.Web.Controllers
{
    public class PedidoRegistroController : BaseController
    {
        private readonly PedidoSetProvider _pedidoSetProvider;
        protected ProductoFaltanteProvider _productoFaltanteProvider;
        private readonly ConfiguracionPaisDatosProvider _configuracionPaisDatosProvider;

        public PedidoRegistroController()
        {
            _pedidoSetProvider = new PedidoSetProvider();
            _productoFaltanteProvider = new ProductoFaltanteProvider();
            _configuracionPaisDatosProvider = new ConfiguracionPaisDatosProvider();
        }

        [HttpPost]
        public JsonResult InsertarPedidoCuvBanner(string CUV, int CantCUVpedido)
        {
            try
            {
                List<ServiceODS.BEProducto> olstProducto;
                using (var sv = new ODSServiceClient())
                {
                    olstProducto = sv.SelectProductoByCodigoDescripcionSearchRegionZona(userData.PaisID, userData.CampaniaID, CUV, userData.RegionID, userData.ZonaID, userData.CodigorRegion, userData.CodigoZona, 1, 1, false).ToList();
                }

                if (olstProducto.Count == 0)
                {
                    return Json(new
                    {
                        success = false,
                        message = "El producto solicitado no existe.",
                        oPedidoDetalle = ""
                    });
                }

                var producto = olstProducto[0];

                var strCuv = CUV;
                int outVal;

                var pedidoCrudModel = new PedidoCrudModel();
                pedidoCrudModel.MarcaID = producto.MarcaID;
                pedidoCrudModel.Cantidad = CantCUVpedido.ToString();
                pedidoCrudModel.PrecioUnidad = producto.PrecioCatalogo;
                pedidoCrudModel.CUV = producto.CUV;
                pedidoCrudModel.ConfiguracionOfertaID = producto.ConfiguracionOfertaID;
                pedidoCrudModel.OrigenPedidoWeb = Constantes.OrigenPedidoWeb.DesktopHomeBannersCarrusel;
                pedidoCrudModel.TipoEstrategiaID = Int32.TryParse(producto.TipoEstrategiaID, out outVal) ? Int32.Parse(producto.TipoEstrategiaID) : 0;

                return PedidoAgregarProductoTransaction(pedidoCrudModel);

            }
            catch (Exception ex)
            {
                LogManager.LogManager.LogErrorWebServicesBus(ex, userData.CodigoConsultora, userData.CodigoISO);
                return Json(new
                {
                    success = false,
                    message = "Ha ocurrido un Error. Vuelva a intentarlo."
                });
            }
        }

        #region Kit Nuevas
        [HttpPost]
        public JsonResult ValidarKitNuevas()
        {
            return Json(new { success = ValidarAgregarKitNuevas() });
        }

        private bool ValidarAgregarKitNuevas()
        {
            try
            {
                if (SessionManager.GetProcesoKitNuevas()) return true;
                AgregarKitNuevas();
                SessionManager.SetProcesoKitNuevas(true);
                return true;
            }
            catch (Exception ex)
            {
                LogManager.LogManager.LogErrorWebServicesBus(ex, userData.CodigoConsultora, userData.CodigoISO);
                return false;
            }
        }

        private void AgregarKitNuevas()
        {
            if (userData.EsConsultoraOficina) return;
            if (userData.DiaPROL && !_pedidoWebProvider.EsHoraReserva(userData, DateTime.Now.AddHours(userData.ZonaHoraria))) return;
            if (_programaNuevasProvider.GetConfiguracion().IndProgObli != "1") return;

            string cuvKitNuevas = _programaNuevasProvider.GetCuvKit();
            if (string.IsNullOrEmpty(cuvKitNuevas)) return;
            if (ObtenerPedidoWebDetalle().Any(d => d.CUV == cuvKitNuevas && d.PedidoDetalleID > 0)) return;

            List<ServiceODS.BEProducto> olstProducto;
            using (var svOds = new ODSServiceClient())
            {
                olstProducto = svOds.SelectProductoToKitInicio(userData.PaisID, userData.CampaniaID, cuvKitNuevas).ToList();
            }
            if (olstProducto.Count > 0) PedidoAgregarProductoTransaction(CreatePedidoCrudModelKitInicio(olstProducto[0]));
        }

        private PedidoCrudModel CreatePedidoCrudModelKitInicio(ServiceODS.BEProducto producto)
        {
            return new PedidoCrudModel
            {
                CUV = producto.CUV,
                Cantidad = "1",
                PrecioUnidad = producto.PrecioCatalogo,
                TipoEstrategiaID = producto.TipoEstrategiaID.ToInt32Secure(),
                MarcaID = producto.MarcaID,
                DescripcionProd = producto.Descripcion,
                TipoOfertaSisID = 0,
                IndicadorMontoMinimo = producto.IndicadorMontoMinimo.ToString(),
                ConfiguracionOfertaID = 0,
                EsKitNueva = true,
                EsKitNuevaAuto = true
            };
        }
        #endregion

        [HttpPost]
        public JsonResult PedidoAgregarProductoTransaction(PedidoCrudModel model)
        {
            try
            {
                string mensaje = "", urlRedireccionar = "", CuvSet = string.Empty;
                BEPedidoDetalle pedidoDetalle = new BEPedidoDetalle();
                pedidoDetalle.Producto = new ServicePedido.BEProducto();
                model.CuvTonos = Util.Trim(model.CuvTonos);

                #region SesiónExpirada
                if (userData == null)
                {
                    mensaje = "Sesión expirada.";
                    urlRedireccionar = Url.Action("Index", "Login");
                    return Json(new
                    {
                        success = false,
                        message = mensaje,
                        urlRedireccionar
                    }, JsonRequestBehavior.AllowGet);
                }
                #endregion

                #region VirtualCoach
                if (model.OrigenPedidoWeb == Constantes.OrigenPedidoWeb.VirtualCoachDesktopPedido ||
                    model.OrigenPedidoWeb == Constantes.OrigenPedidoWeb.VirtualCoachMobilePedido)
                {
                    var ficha = SessionManager.GetFichaProductoTemporal();
                    if (ficha == null)
                    {
                        mensaje = "Estrategia no encontrada.";
                        return Json(new
                        {
                            success = false,
                            message = mensaje
                        }, JsonRequestBehavior.AllowGet);
                    }

                    var descripcion = ficha.FlagNueva == 1 ? ficha.DescripcionCortada : ficha.DescripcionCompleta;
                    if (string.IsNullOrEmpty(model.CuvTonos)) model.CuvTonos = ficha.CUV2;

                    var tonos = model.CuvTonos.Split('|');
                    string cuvTonos = "";
                    foreach (var tono in tonos)
                    {
                        var listSp = tono.Split(';');
                        var cuv = listSp.Length > 0 ? listSp[0] : ficha.CUV2;
                        string descTono = "";
                        if (ficha.CodigoEstrategia == Constantes.TipoEstrategiaSet.CompuestaVariable)
                        {
                            var brother = ficha.Hermanos.Select(m => m.Hermanos.Where(s => s.Cuv == listSp[0])).SingleOrDefault();
                            if (brother != null)
                            {
                                descTono = brother.Select(m => m.DescripcionComercial).SingleOrDefault();
                            }
                        }

                        cuvTonos = cuvTonos + (cuvTonos == "" ? "" : "|") + cuv;
                        cuvTonos = cuvTonos + ";" + ficha.MarcaID;
                        cuvTonos = cuvTonos + ";" + ficha.Precio2;
                        if (!string.IsNullOrEmpty(descTono))
                        {
                            cuvTonos = cuvTonos + ";" + descTono;
                        }
                    }

                    model.TipoEstrategiaID = ficha.TipoEstrategiaID;
                    model.IndicadorMontoMinimo = ficha.IndicadorMontoMinimo.ToString();
                    model.TipoEstrategiaImagen = ficha.TipoEstrategiaImagenMostrar;
                    model.FlagNueva = ficha.FlagNueva.ToString();
                    model.CuvTonos = cuvTonos;

                    pedidoDetalle.EsVirtualCoach = true;
                    pedidoDetalle.Estrategia = new ServicePedido.BEEstrategia();
                    pedidoDetalle.Estrategia.Cantidad = Convert.ToInt32(model.Cantidad);
                    pedidoDetalle.Estrategia.LimiteVenta = ficha.LimiteVenta;
                    pedidoDetalle.Estrategia.DescripcionCUV2 = descripcion;
                    pedidoDetalle.Estrategia.FlagNueva = 0;
                    pedidoDetalle.Estrategia.Precio2 = ficha.Precio2;
                    pedidoDetalle.Estrategia.TipoEstrategiaID = ficha.TipoEstrategiaID;
                    pedidoDetalle.Estrategia.IndicadorMontoMinimo = ficha.IndicadorMontoMinimo;
                    pedidoDetalle.Estrategia.CUV2 = ficha.CUV2;
                }
                #endregion

                #region OfertaFinal/LiquidacionWeb
                if (model.EstrategiaID <= 0 && !pedidoDetalle.EsVirtualCoach)
                {
                    pedidoDetalle.Estrategia = new ServicePedido.BEEstrategia();
                    pedidoDetalle.Estrategia.Cantidad = Convert.ToInt32(model.Cantidad);
                    pedidoDetalle.Estrategia.LimiteVenta = model.LimiteVenta == 0 ? 99 : model.LimiteVenta;
                    pedidoDetalle.Estrategia.DescripcionCUV2 = Util.Trim(model.DescripcionProd);
                    pedidoDetalle.Estrategia.FlagNueva = 0;
                    pedidoDetalle.Estrategia.Precio2 = model.PrecioUnidad;
                    pedidoDetalle.Estrategia.TipoEstrategiaID = model.TipoEstrategiaID;
                    pedidoDetalle.Estrategia.IndicadorMontoMinimo = string.IsNullOrEmpty(model.IndicadorMontoMinimo) ? 0 : Convert.ToInt32(model.IndicadorMontoMinimo);
                    pedidoDetalle.Estrategia.CUV2 = model.CUV;
                    pedidoDetalle.Estrategia.MarcaID = model.MarcaID;
                }
                #endregion

                pedidoDetalle.Producto.EstrategiaID = model.EstrategiaID;
                pedidoDetalle.Producto.TipoEstrategiaID = model.TipoEstrategiaID.ToString();
                pedidoDetalle.Producto.TipoOfertaSisID = model.TipoOfertaSisID;
                pedidoDetalle.Producto.ConfiguracionOfertaID = model.ConfiguracionOfertaID;
                pedidoDetalle.Producto.CUV = Util.Trim(model.CuvTonos);
                pedidoDetalle.Producto.IndicadorMontoMinimo = string.IsNullOrEmpty(model.IndicadorMontoMinimo) ? 0 : Convert.ToInt32(model.IndicadorMontoMinimo);
                pedidoDetalle.Producto.FlagNueva = model.FlagNueva == "" ? "0" : model.FlagNueva;
                pedidoDetalle.Usuario = Mapper.Map<ServicePedido.BEUsuario>(userData);
                pedidoDetalle.Cantidad = Convert.ToInt32(model.Cantidad);
                pedidoDetalle.PaisID = userData.PaisID;
                pedidoDetalle.IPUsuario = GetIPCliente();
                pedidoDetalle.OrigenPedidoWeb = ProcesarOrigenPedido(model.OrigenPedidoWeb);
                pedidoDetalle.ClienteID = string.IsNullOrEmpty(model.ClienteID) ? (short)0 : Convert.ToInt16(model.ClienteID);
                pedidoDetalle.Identifier = SessionManager.GetTokenPedidoAutentico() != null ? SessionManager.GetTokenPedidoAutentico().ToString() : string.Empty;
                pedidoDetalle.EnRangoProgramaNuevas = model.EnRangoProgramaNuevas || model.FlagNueva == "1";
                pedidoDetalle.EsSugerido = model.EsSugerido;
                pedidoDetalle.EsKitNueva = model.EsKitNueva;
                pedidoDetalle.EsKitNuevaAuto = model.EsKitNuevaAuto;
                pedidoDetalle.OfertaWeb = model.OfertaWeb;

                var pedidoDetalleResult = _pedidoWebProvider.InsertPedidoDetalle(pedidoDetalle);

                if (pedidoDetalleResult.CodigoRespuesta.Equals(Constantes.PedidoValidacion.Code.SUCCESS))
                {
                    SessionManager.SetPedidoWeb(null);
                    SessionManager.SetDetallesPedido(null);
                    SessionManager.SetDetallesPedidoSetAgrupado(null);

                    var pedidoWebDetalle = ObtenerPedidoWebDetalle();
                    var CantidadTotalProductos = pedidoWebDetalle.Sum(dp => dp.Cantidad);
                    var Total = pedidoWebDetalle.Sum(p => p.ImporteTotal);
                    var FormatoTotal = Util.DecimalToStringFormat(Total, userData.CodigoISO);

                    ObtenerPedidoWeb();
                    return Json(new
                    {
                        success = true,
                        message = pedidoDetalleResult.MensajeRespuesta,
                        tituloMensaje = pedidoDetalleResult.TituloMensaje,
                        mensajeAviso = pedidoDetalleResult.MensajeAviso,
                        errorInsertarProducto = "0",
                        DataBarra = GetDataBarra(),
                        data = pedidoDetalleResult.PedidoWebDetalle,
                        cantidadTotalProductos = CantidadTotalProductos,
                        total = Total,
                        formatoTotal = FormatoTotal,
                        listCuvEliminar = pedidoDetalleResult.ListCuvEliminar.ToList()
                    }, JsonRequestBehavior.AllowGet);
                }
                else
                {
                    return Json(new
                    {
                        success = false,
                        message = string.IsNullOrEmpty(pedidoDetalleResult.MensajeRespuesta) ? "Ocurrió un error al ejecutar la operación" : pedidoDetalleResult.MensajeRespuesta,
                        tituloMensaje = pedidoDetalleResult.TituloMensaje,
                        errorInsertarProducto = "1"
                    }, JsonRequestBehavior.AllowGet);
                }
            }
            catch (Exception ex)
            {
                LogManager.LogManager.LogErrorWebServicesBus(ex, (userData ?? new UsuarioModel()).CodigoConsultora, (userData ?? new UsuarioModel()).CodigoISO);
                return Json(new
                {
                    success = false,
                    message = "Ocurrió un error, vuelva ha intentarlo."
                });
            }
        }

    }
}
