﻿using AutoMapper;
using Portal.Consultoras.Common;
using Portal.Consultoras.Web.Models;
using Portal.Consultoras.Web.Providers;
using Portal.Consultoras.Web.ServiceODS;
using Portal.Consultoras.Web.ServicePedido;
using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Web.Mvc;
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
        public async Task<JsonResult> InsertarPedidoCuvBanner(string CUV, int CantCUVpedido)
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

                int outVal;

                var pedidoCrudModel = new PedidoCrudModel();
                pedidoCrudModel.MarcaID = producto.MarcaID;
                pedidoCrudModel.Cantidad = CantCUVpedido.ToString();
                pedidoCrudModel.PrecioUnidad = producto.PrecioCatalogo;
                pedidoCrudModel.CUV = producto.CUV;
                pedidoCrudModel.ConfiguracionOfertaID = producto.ConfiguracionOfertaID;
                pedidoCrudModel.OrigenPedidoWeb = Constantes.OrigenPedidoWeb.DesktopHomeBannersCarrusel;
                pedidoCrudModel.TipoEstrategiaID = Int32.TryParse(producto.TipoEstrategiaID, out outVal) ? Int32.Parse(producto.TipoEstrategiaID) : 0;

                return await PedidoAgregarProductoTransaction(pedidoCrudModel);

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

        //INI HD-4200
        #region Suscripcion SE
        [HttpPost]
        public JsonResult ValidarSuscripcionSE()
        {
            return Json(new { success = ValidarSuscripcionSE() });
        }

        private bool ValidarAgregarSuscripcionSE()
        {
            try
            {

                if (SessionManager.GetProcesoSuscripcionSE()) return true;
                AgregarSuscripcionSE();
                SessionManager.SetProcesoSuscripcionSE(true);
                return true;
            }
            catch (Exception ex)
            {
                LogManager.LogManager.LogErrorWebServicesBus(ex, userData.CodigoConsultora, userData.CodigoISO);
                return false;
            }
        }
        private void AgregarSuscripcionSE()
        {
            if (userData.CodigoISO != Constantes.CodigosISOPais.Colombia || !userData.esConsultoraLider) return;

            if (userData.DiaPROL && !_pedidoWebProvider.EsHoraReserva(userData, DateTime.Now.AddHours(userData.ZonaHoraria))) return;

            List<ServicePedido.BEProducto> olstProducto = _pedidoWebProvider.GetCuvsSuscripcionSE();

            if (olstProducto.Count==0) return;

            var lstPedido = ObtenerPedidoWebDetalle().Where(p => p.PedidoDetalleID > 0 && olstProducto.Any(d => d.CUV == p.CUV)).ToList();
            if (lstPedido.Count == olstProducto.Count) return;

            if (olstProducto.Count > 0) PedidoAgregarProductoTransaction(CreatePedidoCrudModelSuscripcionSE(olstProducto[0]));
        }


        private PedidoCrudModel CreatePedidoCrudModelSuscripcionSE(ServicePedido.BEProducto producto)
        {
            return new PedidoCrudModel
            {
                CUV = producto.CUV,
                Cantidad = producto.Cantidad.ToString(),
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
        //FIN HD-4200


        [HttpPost]
        public async Task<JsonResult> PedidoAgregarProductoTransaction(PedidoCrudModel model)
        {
            try
            {
                string mensaje = "", urlRedireccionar = "";
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
                    var cuvTonos = new StringBuilder();

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

                        cuvTonos.Append((cuvTonos.ToString() == "" ? "" : "|") + cuv);
                        cuvTonos.Append(";" + ficha.MarcaID);
                        cuvTonos.Append(";" + ficha.Precio2);
                        if (!string.IsNullOrEmpty(descTono))
                        {
                            cuvTonos.Append(";" + descTono);
                        }

                    }

                    model.TipoEstrategiaID = ficha.TipoEstrategiaID;
                    model.IndicadorMontoMinimo = ficha.IndicadorMontoMinimo.ToString();
                    model.TipoEstrategiaImagen = ficha.TipoEstrategiaImagenMostrar;
                    model.FlagNueva = ficha.FlagNueva.ToString();
                    model.CuvTonos = cuvTonos.ToString();

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

                var esCaminoBrillante = false;
                #region Camino Brillante
                if (model.OrigenPedidoWeb == Constantes.OrigenPedidoWeb.CaminoBrillanteDesktopPedido ||
                    model.OrigenPedidoWeb == Constantes.OrigenPedidoWeb.CaminoBrillanteMobilePedido)
                {
                    esCaminoBrillante = true;                    
                    SessionManager.SetDemostradoresCaminoBrillante(null);
                }
                #endregion

                #region OfertaFinal/LiquidacionWeb
                if (model.EstrategiaID <= 0 && !pedidoDetalle.EsVirtualCoach && !esCaminoBrillante)
                {
                    pedidoDetalle.Estrategia = new ServicePedido.BEEstrategia();
                    pedidoDetalle.Estrategia.Cantidad = Convert.ToInt32(model.Cantidad);
                    pedidoDetalle.Estrategia.LimiteVenta = model.LimiteVenta;
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
                pedidoDetalle.Producto.Descripcion = model.DescripcionProd ?? "";
                pedidoDetalle.Usuario = Mapper.Map<ServicePedido.BEUsuario>(userData);
                pedidoDetalle.Cantidad = Convert.ToInt32(model.Cantidad);
                pedidoDetalle.PaisID = userData.PaisID;
                pedidoDetalle.IPUsuario = GetIPCliente();
                pedidoDetalle.OrigenPedidoWeb = ProcesarOrigenPedido(model.OrigenPedidoWeb);
                pedidoDetalle.ClienteID = string.IsNullOrEmpty(model.ClienteID) ? (short)0 : Convert.ToInt16(model.ClienteID);
                pedidoDetalle.Identifier = SessionManager.GetTokenPedidoAutentico() != null ? SessionManager.GetTokenPedidoAutentico().ToString() : string.Empty;
                pedidoDetalle.EsCuponNuevas = model.EsCuponNuevas || model.FlagNueva == "1";
                pedidoDetalle.EsSugerido = model.EsSugerido;
                pedidoDetalle.EsKitNueva = model.EsKitNueva;
                pedidoDetalle.EsKitNuevaAuto = model.EsKitNuevaAuto;
                pedidoDetalle.OfertaWeb = model.OfertaWeb;
                pedidoDetalle.EsEditable = model.EsEditable;
                pedidoDetalle.SetID = model.SetId;

                var result = await DeletePremioIfReplace(model);
                if (result != null && !result.Item1)
                {
                    return result.Item2;
                }

                var pedidoDetalleResult = _pedidoWebProvider.InsertPedidoDetalle(pedidoDetalle);
                
                //INI HD-3693
                if (pedidoDetalleResult.CodigoRespuesta == Constantes.PedidoValidacion.Code.ERROR_CONSULTORA_BLOQUEADA)
                    pedidoDetalleResult.MensajeRespuesta = Constantes.TipoPopupAlert.Bloqueado + pedidoDetalleResult.MensajeRespuesta;
                //FIN HD-3693

                if (pedidoDetalleResult.CodigoRespuesta.Equals(Constantes.PedidoValidacion.Code.SUCCESS))
                {
                    SessionManager.SetPedidoWeb(null);
                    SessionManager.SetDetallesPedido(null);
                    SessionManager.SetDetallesPedidoSetAgrupado(null);
                    SessionManager.SetBEEstrategia(Constantes.ConstSession.ListaEstrategia, null);
                    SetMontosProl(pedidoDetalleResult);
                    SessionManager.SetMisPedidosDetallePorCampania(null);

                    var pedidoWebDetalle = ObtenerPedidoWebDetalle();
                    var CantidadTotalProductos = pedidoWebDetalle.Sum(dp => dp.Cantidad);
                    var Total = pedidoWebDetalle.Sum(p => p.ImporteTotal);
                    var FormatoTotal = Util.DecimalToStringFormat(Total, userData.CodigoISO);
                    var mensajeCondicional = pedidoDetalleResult.ListaMensajeCondicional != null && pedidoDetalleResult.ListaMensajeCondicional.Any() ? pedidoDetalleResult.ListaMensajeCondicional[0].MensajeRxP: null;

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
                        listCuvEliminar = pedidoDetalleResult.ListCuvEliminar.ToList(),
                        mensajeCondicional
                }, JsonRequestBehavior.AllowGet);
                }
                else
                {
                    return Json(new
                    {
                        success = false,
                        message = string.IsNullOrEmpty(pedidoDetalleResult.MensajeRespuesta) ? "Ocurrió un error al ejecutar la operación" : pedidoDetalleResult.MensajeRespuesta,
                        tituloMensaje = pedidoDetalleResult.TituloMensaje,
                        mensajeAviso = pedidoDetalleResult.MensajeAviso,
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
                    message = Constantes.MensajesError.ErrorGenerico
                });
            }
        }

        [HttpPost]
        public async Task<JsonResult> AgergarPremioDefault()
        {
            var premios = _programaNuevasProvider.GetListPremioElectivo();
            var premioSelected = GetPremioSelected(premios);

            if (premioSelected != null) return Json(false);

            var premioDefault = premios.FirstOrDefault(p => p.CuponElectivoDefault);

            if (premioDefault == null) return Json(false);

            await PedidoAgregarProductoTransaction(new PedidoCrudModel
            {
                CUV = premioDefault.CUV2,
                TipoEstrategiaID = premioDefault.TipoEstrategiaID,
                Cantidad = "1",
                FlagNueva = "1"
            });

            return Json(true);
        }

        private BEPedidoWebDetalle GetPremioSelected(List<PremioElectivoModel> result)
        {
            var details = ObtenerPedidoWebSetDetalleAgrupado(true);
            if (details == null || details.Count == 0) return null;

            var selected = details.FirstOrDefault(d => result.Any(c => c.CUV2 == d.CUV));
            return selected;
        }

        private async Task<Tuple<bool, JsonResult>> DeletePremioIfReplace(PedidoCrudModel model)
        {
            var premios = _programaNuevasProvider.GetListPremioElectivo();
            var isPremio = premios.Any(p => p.CUV2 == model.CUV);
            if (!isPremio) return null;

            var details = ObtenerPedidoWebSetDetalleAgrupado(true);
            if (details == null || details.Count == 0) return null;

            var premioSelected = details.FirstOrDefault(d => premios.Any(c => c.CUV2 == d.CUV));

            if (premioSelected != null && premioSelected.CUV != model.CUV)
            {
                var result = await DeleteTransactionInternal(
                    premioSelected.PedidoID,
                    premioSelected.PedidoDetalleID,
                    premioSelected.TipoOfertaSisID,
                    premioSelected.CUV,
                    premioSelected.Cantidad,
                    premioSelected.ClienteID.ToString(),
                    premioSelected.EsBackOrder,
                    premioSelected.SetID
                );

                return result;
            }

            return null;
        }

        [HttpPost]
        public JsonResult UpdateTransaction(PedidoWebDetalleModel model)
        {
            var txtBuildCliente = new StringBuilder();
            BEPedidoDetalle pedidoDetalle = new BEPedidoDetalle();
            pedidoDetalle.Producto = new ServicePedido.BEProducto();

            pedidoDetalle.Usuario = Mapper.Map<ServicePedido.BEUsuario>(userData);
            pedidoDetalle.Cantidad = Convert.ToInt32(model.Cantidad);
            pedidoDetalle.Producto.PrecioCatalogo = model.PrecioUnidad;
            pedidoDetalle.Producto.TipoEstrategiaID = model.TipoEstrategiaID == 0 ? model.TipoOfertaSisID.ToString() : model.TipoEstrategiaID.ToString();
            pedidoDetalle.Producto.CUV = model.CUV;
            pedidoDetalle.Producto.Descripcion = model.DescripcionProd;
            pedidoDetalle.PaisID = userData.PaisID;
            pedidoDetalle.EsCuponNuevas = model.EsCuponNuevas;
            pedidoDetalle.SetID = model.SetID;
            pedidoDetalle.PedidoDetalleID = (short)model.PedidoDetalleID;
            pedidoDetalle.ClienteID = (short)model.ClienteID;
            pedidoDetalle.PedidoID = model.PedidoID;
            pedidoDetalle.StockNuevo = model.Stock;
            pedidoDetalle.ClienteDescripcion = model.Nombre;
            pedidoDetalle.IPUsuario = GetIPCliente();
            pedidoDetalle.Identifier = SessionManager.GetTokenPedidoAutentico() != null ? SessionManager.GetTokenPedidoAutentico().ToString() : string.Empty;

            var pedidoDetalleResult = _pedidoWebProvider.UpdatePedidoDetalle(pedidoDetalle);

            if (pedidoDetalleResult.CodigoRespuesta.Equals(Constantes.PedidoValidacion.Code.SUCCESS))
            {
                SessionManager.SetPedidoWeb(null);
                SessionManager.SetDetallesPedido(null);
                SessionManager.SetDetallesPedidoSetAgrupado(null);
                SetMontosProl(pedidoDetalleResult);         
                SessionManager.SetMisPedidosDetallePorCampania(null);

                var pedidoWebDetalle = ObtenerPedidoWebDetalle();
                var CantidadTotalProductos = pedidoWebDetalle.Sum(dp => dp.Cantidad);
                var total = pedidoWebDetalle.Sum(p => p.ImporteTotal);
                var FormatoTotal = Util.DecimalToStringFormat(total, userData.CodigoISO);
                var mensajeCondicional = pedidoDetalleResult.ListaMensajeCondicional != null && pedidoDetalleResult.ListaMensajeCondicional.Any() ? pedidoDetalleResult.ListaMensajeCondicional[0].MensajeRxP: null;

                txtBuildCliente.Append(PedidoWebTotalClienteFormato(model.ClienteID_, pedidoWebDetalle));

                ObtenerPedidoWeb();

                return Json(new
                {
                    success = true,
                    message = pedidoDetalleResult.MensajeRespuesta,
                    Total = total,
                    TotalFormato = FormatoTotal,
                    Total_Cliente = txtBuildCliente.ToString(),
                    model.ClienteID_,
                    userData.Simbolo,
                    extra = "",
                    tipo = "U",
                    modificoBackOrder = pedidoDetalleResult.ModificoBackOrder,
                    DataBarra = GetDataBarra(),
                    cantidadTotalProductos = CantidadTotalProductos,
                    mensajeCondicional
                }, JsonRequestBehavior.AllowGet);

            }
            else
            {
                return Json(new
                {
                    success = false,
                    message = string.IsNullOrEmpty(pedidoDetalleResult.MensajeRespuesta) ? "Ocurrió un error al ejecutar la operación" : pedidoDetalleResult.MensajeRespuesta
                }, JsonRequestBehavior.AllowGet);
            }
        }

        [HttpPost]
        public async Task<JsonResult> DeleteTransaction(int CampaniaID, int PedidoID, short PedidoDetalleID, int TipoOfertaSisID, string CUV, int Cantidad, string ClienteID, string CUVReco, bool EsBackOrder, int setId)
        {
            var result = await DeleteTransactionInternal(PedidoID, PedidoDetalleID, TipoOfertaSisID, CUV, Cantidad, ClienteID, EsBackOrder, setId);

            return result.Item2;
        }

        private async Task<Tuple<bool, JsonResult>> DeleteTransactionInternal(int pedidoId, short pedidoDetalleId, int tipoOfertaSisId, string cuv, int cantidad, string clienteId, bool esBackOrder, int setId)
        {
            var lastResult = new Tuple<bool, JsonResult>(false, Json(new { }));

            BEPedidoDetalle pedidoDetalle = new BEPedidoDetalle();
            pedidoDetalle.SetID = setId;
            pedidoDetalle.PedidoDetalleID = pedidoDetalleId;
            pedidoDetalle.PedidoID = pedidoId;
            pedidoDetalle.Producto = new ServicePedido.BEProducto();
            pedidoDetalle.Producto.TipoOfertaSisID = tipoOfertaSisId;
            pedidoDetalle.Producto.CUV = Util.Trim(cuv);
            pedidoDetalle.Usuario = Mapper.Map<ServicePedido.BEUsuario>(userData);
            pedidoDetalle.Cantidad = Convert.ToInt32(cantidad);
            pedidoDetalle.PaisID = userData.PaisID;
            pedidoDetalle.IPUsuario = GetIPCliente();
            pedidoDetalle.ClienteID = string.IsNullOrEmpty(clienteId) ? (short)0 : Convert.ToInt16(clienteId);
            pedidoDetalle.Identifier = SessionManager.GetTokenPedidoAutentico() != null
                ? SessionManager.GetTokenPedidoAutentico().ToString()
                : string.Empty;
            if (esBackOrder) pedidoDetalle.ObservacionPROL = Constantes.BackOrder.LogAccionCancelar;
            else pedidoDetalle.ObservacionPROL = GetObservacionesProlPorCuv(cuv);

            var listaPedidoWebDetalle = ObtenerPedidoWebDetalle();
            var listaPedidoWebDetalleAgrupado = ObtenerPedidoWebSetDetalleAgrupado();
            var pedidoAgrupado = listaPedidoWebDetalleAgrupado.FirstOrDefault(x => x.CUV == cuv) ?? new BEPedidoWebDetalle();
            var pedidoEliminado = new BEPedidoWebDetalle();

            if (setId == 0)
            {
                pedidoEliminado = listaPedidoWebDetalle.FirstOrDefault(x => x.CUV == cuv);
                if (pedidoEliminado == null)
                    return new Tuple<bool, JsonResult>(false, ErrorJson(Constantes.MensajesError.DeletePedido_CuvNoExiste));
            }

            var result = await _pedidoWebProvider.EliminarPedidoDetalle(pedidoDetalle);

            pedidoEliminado.DescripcionOferta = !string.IsNullOrEmpty(pedidoEliminado.DescripcionOferta)
                ? pedidoEliminado.DescripcionOferta.Replace("[", "").Replace("]", "").Trim()
                : "";

            bool errorServer = false;
            string tipo = string.Empty;

            errorServer = result.CodigoRespuesta != Constantes.PedidoValidacion.Code.SUCCESS;
            tipo = result.MensajeRespuesta;

            if (!errorServer)
            {
                SessionManager.SetPedidoWeb(null);
                SessionManager.SetDetallesPedido(null);
                SessionManager.SetDetallesPedidoSetAgrupado(null);
                SetMontosProl(result);
                SessionManager.SetMisPedidosDetallePorCampania(null);
            }

            var olstPedidoWebDetalle = ObtenerPedidoWebDetalle();

            var total = olstPedidoWebDetalle.Sum(p => p.ImporteTotal);
            var formatoTotal = Util.DecimalToStringFormat(total, userData.CodigoISO);

            SessionManager.SetBEEstrategia(Constantes.ConstSession.ListaEstrategia, null);

            var message = !errorServer ? "OK"
                : tipo.Length > 1 ? tipo : "Ocurrió un error al ejecutar la operación.";

            //Validar si el cuv sigue agregado
            var EsAgregado = ValidarEsAgregado(pedidoAgrupado);

            lastResult = new Tuple<bool, JsonResult>(!errorServer, Json(new
            {
                success = !errorServer,
                message,
                formatoTotal,
                total,
                tipo,
                EsAgregado,
                DataBarra = !errorServer ? GetDataBarra() : new BarraConsultoraModel(),
                data = new
                {
                    DescripcionProducto = pedidoEliminado.DescripcionProd,
                    pedidoEliminado.CUV,
                    Precio = pedidoEliminado.PrecioUnidad.ToString("F"),
                    DescripcionMarca = pedidoEliminado.DescripcionLarga,
                    pedidoEliminado.DescripcionOferta,
                    pedidoEliminado.TipoEstrategiaID,
                    pedidoAgrupado.EstrategiaId,
                    pedidoAgrupado.TipoEstrategiaCodigo
                },
                cantidadTotalProductos = olstPedidoWebDetalle.Sum(x => x.Cantidad)
            }));

            return lastResult;
        }

        private string GetObservacionesProlPorCuv(string cuv)
        {
            if (SessionManager.GetObservacionesProl() != null)
            {
                var observaciones = SessionManager.GetObservacionesProl();
                var obs = observaciones.Where(p => p.CUV == cuv).ToList();
                if (obs.Count != 0)
                {
                    return Util.Trim(obs[0].Descripcion);
                }
            }
            return "";
        }

        [HttpPost]
        public JsonResult DeleteAll()
        {
            string message;
            try
            {
                if (ReservadoEnHorarioRestringido(out message)) return ErrorJson(message, true);

                var usuario = Mapper.Map<ServicePedido.BEUsuario>(userData);
                using (var sv = new PedidoServiceClient())
                {
                    if (!sv.DelPedidoWebDetalleMasivo(usuario, userData.PedidoID)) return ErrorJson(Constantes.MensajesError.Pedido_DeleteAll, true);
                }

                var pedidoWebDetalle = ObtenerPedidoWebSetDetalleAgrupado() ?? new List<BEPedidoWebDetalle>();
                var setIds = pedidoWebDetalle.Select(d => d.SetID);

                var bePedidoWebDetalleParametros = new BEPedidoWebDetalleParametros
                {
                    PaisId = userData.PaisID,
                    CampaniaId = userData.CampaniaID,
                    ConsultoraId = userData.ConsultoraID,
                    Consultora = userData.NombreConsultora,
                    EsBpt = false,   //no se usa
                    CodigoPrograma = userData.CodigoPrograma,
                    NumeroPedido = userData.ConsecutivoNueva,
                    AgruparSet = true
                };
                foreach (var setId in setIds)
                {
                    _pedidoSetProvider.EliminarSet(userData.PaisID, setId, bePedidoWebDetalleParametros);
                }
                List<BEPedidoWebDetalle> listaMarcaciones = ObtenerPedidoWebDetalle() ?? new List<BEPedidoWebDetalle>();
                SessionManager.SetPedidoWeb(null);
                SessionManager.SetDetallesPedido(null);
                SessionManager.SetDetallesPedidoSetAgrupado(null);
                SessionManager.SetBEEstrategia(Constantes.ConstSession.ListaEstrategia, null);
                UpdPedidoWebMontosPROL();

                return Json(new { success = true, DataBarra = GetDataBarra(), ListaMarcaciones = listaMarcaciones }, JsonRequestBehavior.AllowGet);
            }
            catch (Exception ex)
            {
                LogManager.LogManager.LogErrorWebServicesBus(ex, userData.CodigoConsultora, userData.CodigoISO);
                return ErrorJson(Constantes.MensajesError.Pedido_DeleteAll, true);
            }
        }

        private string PedidoWebTotalClienteFormato(string clienteId, List<BEPedidoWebDetalle> olstPedidoWebDetalle)
        {
            string formatoTotalCliente = "";
            if (olstPedidoWebDetalle.Any() && clienteId != "-1")
            {
                var lstTemp = (from item in olstPedidoWebDetalle
                               where item.ClienteID == Convert.ToInt16(clienteId)
                               select item).ToList();

                var totalCliente = lstTemp.Sum(p => p.ImporteTotal);
                formatoTotalCliente = Util.DecimalToStringFormat(totalCliente, userData.CodigoISO);
            }
            return formatoTotalCliente;
        }

        private bool ValidarEsAgregado(BEPedidoWebDetalle pedidoAgrupado)
        {
            var listaPedidoWebDetalleAgrupado = ObtenerPedidoWebSetDetalleAgrupado();
            return listaPedidoWebDetalleAgrupado.Any(x => x.EstrategiaId == pedidoAgrupado.EstrategiaId);
        }
    }
}
