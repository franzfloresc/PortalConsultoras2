using Portal.Consultoras.Common;
using Portal.Consultoras.Web.Areas.Mobile.Models;
using Portal.Consultoras.Web.Models;
using Portal.Consultoras.Web.ServiceCliente;
using Portal.Consultoras.Web.ServicePedido;
using Portal.Consultoras.Web.ServiceSAC;
using Portal.Consultoras.Web.ServiceUsuario;
using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Text;
using System.Text.RegularExpressions;
using System.Web.Mvc;
using BEPedidoWeb = Portal.Consultoras.Web.ServicePedido.BEPedidoWeb;
using BEPedidoWebDetalle = Portal.Consultoras.Web.ServicePedido.BEPedidoWebDetalle;

namespace Portal.Consultoras.Web.Areas.Mobile.Controllers
{
    public class PedidoController : BaseMobileController
    {
        #region Acciones

        public ActionResult Index()
        {
            ValidarSesionCuvProductoDestacado();

            var model = new PedidoMobileModel();

            Session["ObservacionesPROL"] = null;
            Session["PedidoWeb"] = null;
            Session["PedidoWebDetalle"] = null;

            var lstPedidoWebDetalle = ObtenerPedidoWebDetalle();

            if (lstPedidoWebDetalle.Count == 0)
            {
                int isInsert;

                using (var sv = new PedidoServiceClient())
                {
                    var bePedidoWeb = new BEPedidoWeb();
                    bePedidoWeb.CampaniaID = userData.CampaniaID;
                    bePedidoWeb.ConsultoraID = userData.ConsultoraID;
                    bePedidoWeb.PaisID = userData.PaisID;
                    bePedidoWeb.IPUsuario = userData.IPUsuario;
                    bePedidoWeb.CodigoUsuarioCreacion = userData.CodigoUsuario;

                    isInsert = sv.GetProductoCUVsAutomaticosToInsert(bePedidoWeb);
                }
                if (isInsert > 0)
                {
                    Session["PedidoWebDetalle"] = null;
                    lstPedidoWebDetalle = ObtenerPedidoWebDetalle();

                    UpdPedidoWebMontosPROL();
                }
            }

            BEPedidoWeb bePedidoWebByCampania = ObtenerPedidoWeb();

            if (bePedidoWebByCampania != null)
            {
                model.MontoAhorroCatalogo = bePedidoWebByCampania.MontoAhorroCatalogo;
                model.MontoAhorroRevista = bePedidoWebByCampania.MontoAhorroRevista;
            }

            if (userData.PedidoID == 0 && lstPedidoWebDetalle.Count > 0)
            {
                userData = UserData();
                userData.PedidoID = lstPedidoWebDetalle[0].PedidoID;
                SetUserData(userData);
            }

            model.PaisId = userData.PaisID;
            model.CodigoIso = userData.CodigoISO;
            model.Simbolo = userData.Simbolo;
            model.CampaniaActual = ViewBag.Campania;
            model.CampaniaNro = userData.CampaniaNro;
            model.Total = lstPedidoWebDetalle.Sum(p => p.ImporteTotal);
            model.DescripcionTotal = Util.DecimalToStringFormat(model.Total, userData.CodigoISO);
            model.TotalMinimo = lstPedidoWebDetalle.Where(p => p.IndicadorMontoMinimo == 1).Sum(p => p.ImporteTotal);
            model.DescripcionTotalMinimo = Util.DecimalToStringFormat(model.TotalMinimo, userData.CodigoISO);
            model.ListaProductos = lstPedidoWebDetalle.ToList();
            model.CantidadProductos = lstPedidoWebDetalle.ToList().Sum(p => p.Cantidad);

            model.GananciaFormat = Util.DecimalToStringFormat(model.MontoAhorroCatalogo + model.MontoAhorroRevista, userData.CodigoISO);

            using (var sv = new ClienteServiceClient())
            {
                model.ListaClientes = sv.SelectByConsultora(userData.PaisID, userData.ConsultoraID).ToList();
            }
            model.ListaClientes.Insert(0, new BECliente { ClienteID = 0, Nombre = userData.NombreConsultora });

            model.NombreConsultora = (string.IsNullOrEmpty(userData.Sobrenombre) ? userData.NombreConsultora : userData.Sobrenombre);

            return View(model);
        }

        [HttpPost]
        public JsonResult ObtenerMarcaEstrategia(ProductoModel model)
        {
            var userData = UserData();
            try
            {
                model.DescripcionMarca = GetDescripcionMarca(model.MarcaID);

                var listaEstrategias = (List<BEEstrategia>)Session["ListadoEstrategiaPedido"] ?? new List<BEEstrategia>();
                var estrategia = listaEstrategias.FirstOrDefault(p => p.CUV2 == model.CUV);

                model.DescripcionEstrategia = estrategia == null ? "Estándar" : estrategia.DescripcionEstrategia;
                model.LimiteVenta = estrategia != null ? estrategia.LimiteVenta : 99;
                model.FlagNueva = estrategia != null ? estrategia.FlagNueva.ToString() : "0";

                return Json(new
                {
                    success = true,
                    message = "",
                    data = model
                });
            }
            catch (Exception ex)
            {
                LogManager.LogManager.LogErrorWebServicesBus(ex, userData.CodigoConsultora, userData.CodigoISO);
                return Json(new
                {
                    success = false,
                    message = "Ocurrió un error al acceder al servicio, intente nuevamente.",
                    data = ""
                });
            }
        }

        [HttpPost]
        public PartialViewResult CargarListaEstrategia(string cuv)
        {
            var userData = UserData();

            var olstPedidoWebDetalle = ObtenerPedidoWebDetalle();

            if (olstPedidoWebDetalle.Count == 0)
            {
                // int isInsert;
                using (var sv = new PedidoServiceClient())
                {
                    var oBEPedidoWeb = new BEPedidoWeb();
                    oBEPedidoWeb.CampaniaID = userData.CampaniaID;
                    oBEPedidoWeb.ConsultoraID = userData.ConsultoraID;
                    oBEPedidoWeb.PaisID = userData.PaisID;
                    oBEPedidoWeb.IPUsuario = userData.IPUsuario;
                    oBEPedidoWeb.CodigoUsuarioCreacion = userData.CodigoUsuario;

                    //isInsert = sv.GetProductoCUVsAutomaticosToInsert(oBEPedidoWeb);
                }
                //if (isInsert > 0)
                //{
                //    Session["PedidoWebDetalle"] = null;
                //    olstPedidoWebDetalle = ObtenerPedidoWebDetalle();
                //}

            }

            var model = new PedidoMobileModel();
            model.ListaEstrategias = ListarEstrategias(cuv ?? "");
            model.ListaProductos = olstPedidoWebDetalle.ToList();

            return PartialView("ListaEstrategias", model);
        }

        [HttpPost]
        public ActionResult CargarListaEstrategias(string cuv)
        {
            var model = new PedidoMobileModel();
            model.ListaEstrategias = ListarEstrategias(cuv ?? "");
            return Json(model);
        }

        [HttpPost]
        public JsonResult RefrescarPedidoOfertaNuevaActual()
        {
            var lstPedidoWebDetalle = ObtenerPedidoWebDetalle();
            var pedidoOfertaNuevaActual = lstPedidoWebDetalle.FirstOrDefault(p => p.TipoEstrategiaID == 1);

            if (pedidoOfertaNuevaActual == null) return Json(null);

            var listaPropiedadesValidas = new[]
            {
                pedidoOfertaNuevaActual.CampaniaID.ToString(),
                pedidoOfertaNuevaActual.PedidoID.ToString(),
                pedidoOfertaNuevaActual.PedidoDetalleID.ToString(),
                pedidoOfertaNuevaActual.TipoOfertaSisID.ToString(),
                pedidoOfertaNuevaActual.CUV,
                pedidoOfertaNuevaActual.Cantidad.ToString(),
                "1",
                pedidoOfertaNuevaActual.ClienteID.ToString()
            };

            return Json(string.Join(";", listaPropiedadesValidas));
        }

        [HttpPost]
        public JsonResult ValidarExistenciaOfertaNuevaAnterior(string cuvActual)
        {
            var lstPedidoWebDetalle = ObtenerPedidoWebDetalle();
            var pedidoOfertaNuevaActual = lstPedidoWebDetalle.FirstOrDefault(p => p.TipoEstrategiaID == 1);

            if (pedidoOfertaNuevaActual == null)
                return Json(new { Existe = false, Mensaje = string.Empty });

            var listaEstrategias = (List<BEEstrategia>)Session["ListadoEstrategiaPedido"] ?? new List<BEEstrategia>();
            var estrategia = listaEstrategias.FirstOrDefault(p => p.CUV2 == cuvActual);

            return Json(new { Existe = true, Mensaje = estrategia.TextoLibre });
        }

        [HttpPost]
        public JsonResult CalcularTotal()
        {
            Session["CUVProductoDesctacado"] = null;

            var userData = UserData();
            try
            {
                var lstPedidoWebDetalle = ObtenerPedidoWebDetalle();

                var model = new PedidoMobileModel();
                model.CodigoIso = userData.CodigoISO;
                model.Total = lstPedidoWebDetalle.Sum(p => p.ImporteTotal);
                model.DescripcionTotal = Util.DecimalToStringFormat(model.Total, model.CodigoIso);
                model.TotalMinimo = lstPedidoWebDetalle.Where(p => p.IndicadorMontoMinimo == 1).Sum(p => p.ImporteTotal);
                model.DescripcionTotalMinimo = Util.DecimalToStringFormat(model.TotalMinimo, model.CodigoIso);
                model.CantidadProductos = lstPedidoWebDetalle.ToList().Sum(p => p.Cantidad);

                return Json(new
                {
                    success = true,
                    message = "",
                    data = model
                });
            }
            catch (Exception ex)
            {
                LogManager.LogManager.LogErrorWebServicesBus(ex, userData.CodigoConsultora, userData.CodigoISO);
                return Json(new
                {
                    success = false,
                    message = "Ocurrió un error al acceder al servicio, intente nuevamente.",
                    data = ""
                });
            }
        }

        public ActionResult Detalle()
        {
            var userData = UserData();

            Session["ObservacionesPROL"] = null;
            Session["PedidoWebDetalle"] = null;

            var model = new PedidoDetalleMobileModel();
            model.CodigoISO = userData.CodigoISO;
            model.Simbolo = userData.Simbolo;
            model.CampaniaActual = userData.CampaniaID.ToString();

            var lstPedidoWebDetalle = ObtenerPedidoWebDetalle();
            model.Total = lstPedidoWebDetalle.Sum(p => p.ImporteTotal);
            model.DescripcionTotal = Util.DecimalToStringFormat(model.Total, model.CodigoISO);
            model.TotalMinimo = lstPedidoWebDetalle.Where(p => p.IndicadorMontoMinimo == 1).Sum(p => p.ImporteTotal);
            model.DescripcionTotalMinimo = Util.DecimalToStringFormat(model.TotalMinimo, model.CodigoISO);
            model.CantidadProductos = lstPedidoWebDetalle.ToList().Sum(p => p.Cantidad);
            model.FechaFacturacionPedido = ViewBag.FechaFacturacionPedido;

            BEPedidoWeb bePedidoWebByCampania = ObtenerPedidoWeb();
            model.GananciaFormat = Util.DecimalToStringFormat(bePedidoWebByCampania.MontoAhorroCatalogo + bePedidoWebByCampania.MontoAhorroRevista, userData.CodigoISO);

            model.PedidoConProductosExceptuadosMontoMinimo = lstPedidoWebDetalle.Any(p => p.IndicadorMontoMinimo == 0);

            BEConfiguracionCampania beConfiguracionCampania;
            using (var sv = new PedidoServiceClient())
            {
                beConfiguracionCampania = sv.GetEstadoPedido(userData.PaisID, userData.CampaniaID, userData.ConsultoraID, userData.ZonaID, userData.RegionID);
            }

            if (beConfiguracionCampania != null)
            {
                if (beConfiguracionCampania.CampaniaID == 0)
                    return RedirectToAction("CampaniaZonaNoConfigurada", "Pedido", new { area = "Mobile" });

                if (beConfiguracionCampania.EstadoPedido == Constantes.EstadoPedido.Procesado
                    && !beConfiguracionCampania.ModificaPedidoReservado
                    && !beConfiguracionCampania.ValidacionAbierta)
                    return RedirectToAction("Validado", "Pedido", new { area = "Mobile" });

                if (!beConfiguracionCampania.ModificaPedidoReservado)
                    model.ModificaPedidoReservado = true;
                else
                    model.ModificaPedidoReservado = false;

                model.FlagValidacionPedido = "0";

                if (beConfiguracionCampania.EstadoPedido == Constantes.EstadoPedido.Procesado
                    && beConfiguracionCampania.ModificaPedidoReservado)
                {
                    model.FlagValidacionPedido = "1";
                }
                model.EstadoPedido = beConfiguracionCampania.EstadoPedido == Constantes.EstadoPedido.Pendiente ? 0 : 1;
            }
            else
            {
                return RedirectToAction("CampaniaZonaNoConfigurada", "Pedido", new { area = "Mobile" });
            }

            ValidarStatusCampania(beConfiguracionCampania);

            if (beConfiguracionCampania.ZonaValida)
            {
                if (userData.PROLSinStock)
                {
                    //PROL Sin Stock
                    model.BotonPROL = "GUARDAR PEDIDO";
                }
                else
                {
                    if (userData.NuevoPROL && userData.ZonaNuevoPROL)
                    {
                        //PROL 2.0
                        model.BotonPROL = "GUARDAR PEDIDO";
                    }
                    else
                    {
                        //PROL 1.0
                        model.BotonPROL = userData.MostrarBotonValidar ? "VALIDAR PEDIDO" : "GUARDAR PEDIDO";
                    }
                }
            }
            else
            {
                //Sin PROL
                model.BotonPROL = "GUARDAR PEDIDO";
            }

            //Se desactiva dado que el mensaje de Guardar por MM no va en países SICC
            if (userData.CodigoISO == Constantes.CodigosISOPais.Colombia)
            {
                BETablaLogicaDatos[] tablaLogicaDatos;
                using (var sac = new SACServiceClient())
                {
                    tablaLogicaDatos = sac.GetTablaLogicaDatos(userData.PaisID, 27);
                }

                if (tablaLogicaDatos != null && tablaLogicaDatos.Length != 0)
                {
                    model.MensajeGuardarCO = tablaLogicaDatos[0].Descripcion;
                }
            }

            return View(model);
        }

        [HttpPost]
        public JsonResult CargarDetallePedido()
        {
            var lstPedidoWebDetalle = ObtenerPedidoWebDetalle();

            if (lstPedidoWebDetalle.Count == 0)
            {
                int isInsert;
                using (var sv = new PedidoServiceClient())
                {
                    var bePedidoWeb = new BEPedidoWeb();
                    bePedidoWeb.CampaniaID = userData.CampaniaID;
                    bePedidoWeb.ConsultoraID = userData.ConsultoraID;
                    bePedidoWeb.PaisID = userData.PaisID;
                    bePedidoWeb.IPUsuario = userData.IPUsuario;
                    bePedidoWeb.CodigoUsuarioCreacion = userData.CodigoUsuario;

                    isInsert = sv.GetProductoCUVsAutomaticosToInsert(bePedidoWeb);
                }
                if (isInsert > 0)
                {
                    Session["PedidoWebDetalle"] = null;
                    lstPedidoWebDetalle = ObtenerPedidoWebDetalle();

                    UpdPedidoWebMontosPROL();
                }
            }

            if (userData.PedidoID == 0 && lstPedidoWebDetalle.Count > 0)
            {
                userData.PedidoID = lstPedidoWebDetalle[0].PedidoID;
                SetUserData(userData);
            }

            var model = new PedidoDetalleMobileModel();
            model.PaisID = userData.PaisID;
            model.CodigoISO = userData.CodigoISO;
            model.Simbolo = userData.Simbolo;
            model.Detalle = lstPedidoWebDetalle;

            model.PedidoConDescuentoCuv = userData.EstadoSimplificacionCUV &&
                                          lstPedidoWebDetalle.Any(p => p.IndicadorOfertaCUV);
            model.PedidoConProductosExceptuadosMontoMinimo = lstPedidoWebDetalle.Any(p => p.IndicadorMontoMinimo == 0);
            model.Total = model.Detalle.Sum(p => p.ImporteTotal);
            model.TotalMinimo = model.Detalle.Where(p => p.IndicadorMontoMinimo == 1).Sum(p => p.ImporteTotal);
            model.CantidadProductos = lstPedidoWebDetalle.ToList().Sum(p => p.Cantidad);
            model.DescripcionTotal = Util.DecimalToStringFormat(model.Total, model.CodigoISO);
            model.DescripcionTotalMinimo = Util.DecimalToStringFormat(model.TotalMinimo, model.CodigoISO);

            BEPedidoWeb bePedidoWebByCampania = ObtenerPedidoWeb();
            model.GananciaFormat = Util.DecimalToStringFormat(bePedidoWebByCampania.MontoAhorroCatalogo + bePedidoWebByCampania.MontoAhorroRevista, userData.CodigoISO);

            model.MensajeCierreCampania = ViewBag.MensajeCierreCampania;

            return Json(new
            {
                success = true,
                message = "OK",
                data = model
            });
        }

        public ActionResult CampaniaZonaNoConfigurada()
        {
            var userData = UserData();
            if (userData.CampaniaID == 0)
                ViewBag.MensajeCampaniaZona = "Campaña";
            else
                ViewBag.MensajeCampaniaZona = "Zona";
            return View();
        }

        [HttpPost]
        [OutputCache(NoStore = true, Duration = 0, VaryByParam = "*")]
        public JsonResult EjecutarServicioPROL()
        {
            Session["ObservacionesPROL"] = null;

            bool botonValidar;
            UsuarioModel usuario = userData;
            usuario.DiaPROL = ValidarPROL(usuario, out botonValidar);
            usuario.MostrarBotonValidar = botonValidar;
            SetUserData(usuario);

            List<BEPedidoWebDetalle> olstPedidoWebDetalle = new List<BEPedidoWebDetalle>();
            List<ObservacionModel> olstObservaciones = new List<ObservacionModel>();
            bool restrictivas = false, informativas = false, errorProl = false, reservaProl = false;
            decimal montoAhorroCatalogo = 0, montoAhorroRevista = 0, montoDescuento = 0, montoEscala = 0;
            string codigoMensaje = "";

            try
            {
                try
                {
                    olstPedidoWebDetalle = olstPedidoWebDetalle.Where(p => p.EstadoItem != 3).ToList();
                    olstPedidoWebDetalle = ObtenerPedidoWebServer();

                    List<BECUVAutomatico> lst;
                    using (SACServiceClient srv = new SACServiceClient())
                    {
                        BECUVAutomatico producto = new BECUVAutomatico { CampaniaID = usuario.CampaniaID };

                        lst = srv.GetProductoCuvAutomatico(usuario.PaisID, producto, "CUV", "asc", 1, 1, 100).ToList();
                    }

                    if (lst.Count > 0)
                    {
                        olstPedidoWebDetalle = olstPedidoWebDetalle.Where(x => !lst.Select(y => y.CUV).Contains(x.CUV)).ToList();
                    }

                    if (usuario.ZonaValida)
                    {
                        if (usuario.ValidacionInteractiva)
                        {
                            if (usuario.NuevoPROL && usuario.ZonaNuevoPROL)
                                olstObservaciones = DevolverObservacionesPROLv2(olstPedidoWebDetalle, out restrictivas, out informativas, out errorProl, out reservaProl, out montoAhorroCatalogo, out montoAhorroRevista, out montoDescuento, out montoEscala, out codigoMensaje);
                            else
                                olstObservaciones = DevolverObservacionesPROL(olstPedidoWebDetalle, out restrictivas, out informativas, out errorProl, out reservaProl, out montoAhorroCatalogo, out montoAhorroRevista, out montoDescuento, out montoEscala, out codigoMensaje);

                            Session["ObservacionesPROL"] = olstObservaciones;
                        }
                    }
                    else
                    {
                        informativas = false;
                        restrictivas = false;
                        errorProl = false;
                        reservaProl = true;
                    }
                }
                catch (Exception ex)
                {
                    LogManager.LogManager.LogErrorWebServicesBus(ex, usuario.CodigoConsultora, usuario.CodigoISO);
                    olstObservaciones.Add(new ObservacionModel() { Descripcion = "Hubo un error al tratar de realizar la validación del pedido, por favor vuelva a intentarlo." });
                    restrictivas = false;
                    informativas = false;
                    errorProl = true;
                    reservaProl = false;
                }

                var model = new PedidoValidacionPROLMobileModel();
                model.ListaObservacionesPROL = olstObservaciones;
                model.ObservacionInformativa = informativas;
                model.ObservacionRestrictiva = restrictivas;
                model.ErrorPROL = errorProl;
                model.Reserva = reservaProl;
                model.ZonaValida = usuario.ZonaValida;
                model.ValidacionInteractiva = usuario.ValidacionInteractiva;
                model.MensajeValidacionInteractiva = usuario.MensajeValidacionInteractiva;
                model.MontoAhorroCatalogo = montoAhorroCatalogo;
                model.MontoAhorroRevista = montoAhorroRevista;
                model.MontoDescuento = montoDescuento;
                model.MontoEscala = montoEscala;
                model.BotonPROL = model.ZonaValida
                    ? usuario.PROLSinStock
                        ? "Guarda tu pedido"
                        : usuario.NuevoPROL && usuario.ZonaNuevoPROL
                            ? "Guarda tu pedido"
                            : usuario.MostrarBotonValidar
                                ? "Valida tu pedido"
                                : "Guarda tu pedido"
                    : "Guarda tu pedido";
                model.EsDiaPROL = usuario.DiaPROL;
                model.PROLSinStock = usuario.PROLSinStock;
                model.ZonaNuevoProlM = usuario.ZonaNuevoPROL;
                model.CodigoISO = usuario.CodigoISO;


                model.ListaProductos = new List<PedidoWebDetalleMobilModel>();

                //var listaEstrategias = ListarEstrategias("");

                //foreach (var item in olstPedidoWebDetalle)
                //{
                //    var estrategia = listaEstrategias.FirstOrDefault(p => p.CUV2 == item.CUV);
                //    item.DescripcionEstrategia = estrategia == null ? "Estándar" : estrategia.DescripcionEstrategia;

                //    model.ListaProductos.Add(new PedidoWebDetalleMobilModel
                //    {
                //        CUV = item.CUV,
                //        DescripcionProd = item.DescripcionProd,
                //        DescripcionLarga = item.DescripcionLarga,
                //        Categoria = item.Categoria,
                //        PrecioUnidad = item.PrecioUnidad,
                //        DescripcionEstrategia = item.DescripcionEstrategia,
                //        Cantidad = item.Cantidad,
                //        MarcaID = item.MarcaID,
                //        DescripcionMarca = GetDescripcionMarca(item.MarcaID)
                //    });
                //}

                if (usuario.ZonaValida)
                {
                    if (usuario.PROLSinStock)
                    {
                        //PROL Sin Stock
                        model.BotonPROL = "GUARDAR PEDIDO";
                        model.TipoProl = 0;
                    }
                    else
                    {
                        if (usuario.NuevoPROL && usuario.ZonaNuevoPROL)
                        {
                            //PROL 2.0
                            model.BotonPROL = "GUARDAR PEDIDO";
                            model.TipoProl = 2;
                        }
                        else
                        {
                            //PROL 1.0
                            model.BotonPROL = usuario.MostrarBotonValidar ? "VALIDAR PEDIDO" : "GUARDAR PEDIDO";
                            model.TipoProl = 1;
                        }
                    }
                }
                else
                {
                    //Sin PROL
                    model.BotonPROL = "GUARDAR PEDIDO";
                    model.TipoProl = 0;
                }

                bool activoEnvioMail = false;
                List<BETablaLogicaDatos> lstLogicaDatos = new List<BETablaLogicaDatos>();
                using (SACServiceClient sv = new SACServiceClient())
                {
                    lstLogicaDatos = sv.GetTablaLogicaDatos(usuario.PaisID, 54).ToList();
                    activoEnvioMail = Int32.Parse(lstLogicaDatos.First().Codigo.Trim()) > 0;
                }

                if (model.Reserva && model.ZonaValida && usuario.ValidacionInteractiva && !model.ObservacionInformativa && usuario.EMail.Trim().Length > 0 && activoEnvioMail)
                {
                    if (EnviarCorreoPedidoValidado(olstPedidoWebDetalle))
                    {
                        using (PedidoServiceClient psv = new PedidoServiceClient())
                        {
                            BELogCabeceraEnvioCorreo beLogCabecera = new BELogCabeceraEnvioCorreo();
                            beLogCabecera.CodigoConsultora = usuario.CodigoConsultora;
                            beLogCabecera.ConsultoraID = usuario.ConsultoraID;
                            beLogCabecera.Email = usuario.EMail;
                            beLogCabecera.FechaFacturacion = usuario.FechaFacturacion;
                            beLogCabecera.Asunto = string.Format("({0}) Confirmación pedido Belcorp", usuario.CodigoISO);
                            beLogCabecera.FechaEnvio = DateTime.Now;

                            List<BELogDetalleEnvioCorreo> listLogDetalleEnvioCorreo = new List<BELogDetalleEnvioCorreo>();
                            foreach (BEPedidoWebDetalle bePedidoWebDetalle in olstPedidoWebDetalle)
                            {
                                BELogDetalleEnvioCorreo beLogDetalle = new BELogDetalleEnvioCorreo();
                                beLogDetalle.CUV = bePedidoWebDetalle.CUV;
                                beLogDetalle.Cantidad = bePedidoWebDetalle.Cantidad;
                                beLogDetalle.PrecioUnitario = bePedidoWebDetalle.PrecioUnidad;
                                listLogDetalleEnvioCorreo.Add(beLogDetalle);
                            }

                            psv.InsLogEnvioCorreoPedidoValidado(usuario.PaisID, beLogCabecera, listLogDetalleEnvioCorreo.ToArray());
                        }
                    }
                }

                var fechaHoy = DateTime.Now.AddHours(usuario.ZonaHoraria).Date;
                if (fechaHoy >= usuario.FechaInicioCampania.Date && fechaHoy <= usuario.FechaFinCampania.Date)
                    model.PeriodoAnalisisPedido = "Facturacion";
                else
                    model.PeriodoAnalisisPedido = "Venta";

                return Json(model);

            }
            catch (Exception ex)
            {
                Portal.Consultoras.Common.LogManager.SaveLog(ex, usuario.CodigoUsuario, "SB Mobile - " + usuario.CodigoISO);

                return Json(new
                {
                    success = false,
                    mensaje = "Por favor, vuelva a intentarlo",
                    message = ex.Message.ToString(),
                }, JsonRequestBehavior.AllowGet);

            }
        }

        public ActionResult Validado()
        {
            var userData = UserData();

            BEConfiguracionCampania beConfiguracionCampania;
            using (var sv = new PedidoServiceClient())
            {
                beConfiguracionCampania = sv.GetEstadoPedido(userData.PaisID, userData.CampaniaID, userData.ConsultoraID, userData.ZonaID, userData.RegionID);
            }
            if (beConfiguracionCampania != null)
            {
                if (beConfiguracionCampania.CampaniaID > userData.CampaniaID)
                    return RedirectToAction("Index");
            }

            List<BEPedidoWebDetalle> lstPedidoWebDetalle;
            using (var sv = new PedidoServiceClient())
            {
                lstPedidoWebDetalle = sv.SelectByPedidoValidado(userData.PaisID, userData.CampaniaID, userData.ConsultoraID, userData.NombreConsultora).ToList();
            }

            var model = new PedidoDetalleMobileModel();
            model.CodigoISO = userData.CodigoISO;
            model.Simbolo = userData.Simbolo;
            model.Detalle = PedidoJerarquico(lstPedidoWebDetalle);

            model.PedidoConDescuentoCuv = userData.EstadoSimplificacionCUV &&
                                          lstPedidoWebDetalle.Any(p => p.IndicadorOfertaCUV);
            model.PedidoConProductosExceptuadosMontoMinimo = lstPedidoWebDetalle.Any(p => p.IndicadorMontoMinimo == 0);

            if (model.PedidoConDescuentoCuv)
            {
                decimal importeProl = lstPedidoWebDetalle[0].MontoTotalProl;

                model.SubTotal = lstPedidoWebDetalle.Where(p => p.PedidoDetalleIDPadre == 0).Sum(p => p.ImporteTotal);
                model.DescripcionSubTotal = Util.DecimalToStringFormat(model.SubTotal, model.CodigoISO);

                model.Descuento = importeProl - model.SubTotal;
                model.DescripcionDescuento = Util.DecimalToStringFormat(model.Descuento, model.CodigoISO);

                model.Total = importeProl;
                model.DescripcionTotal = Util.DecimalToStringFormat(model.Total, model.CodigoISO);
            }
            else
            {
                model.Total = lstPedidoWebDetalle.Where(p => p.PedidoDetalleIDPadre == 0).Sum(p => p.ImporteTotal);
                model.DescripcionTotal = Util.DecimalToStringFormat(model.Total, model.CodigoISO);
            }

            model.TotalMinimo = lstPedidoWebDetalle.Where(p => p.IndicadorMontoMinimo == 1).Sum(p => p.ImporteTotal);
            model.DescripcionTotalMinimo = Util.DecimalToStringFormat(model.TotalMinimo, model.CodigoISO);

            // se calcula la ganancia estimada
            if (lstPedidoWebDetalle.Count > 0)
            {
                ViewBag.GananciaEstimada = CalcularGananciaEstimada(userData.PaisID, userData.CampaniaID, lstPedidoWebDetalle[0].PedidoID, model.Total);

                int valorPedidoProductoMovil = 0;
                foreach (var item in lstPedidoWebDetalle)
                {
                    if (item.TipoPedido.ToUpper().Trim() == "PNV")
                    {
                        valorPedidoProductoMovil = 1;
                        break;
                    }
                }
                ViewBag.PedidoProductoMovil = valorPedidoProductoMovil;
            }
            else
            {
                ViewBag.GananciaEstimada = 0;
                ViewBag.PedidoProductoMovil = 0;
            }

            if (lstPedidoWebDetalle.Count != 0)
            {
                if (userData.PedidoID == 0)
                {
                    UsuarioModel usuario = UserData();
                    usuario.PedidoID = lstPedidoWebDetalle[0].PedidoID;
                    SetUserData(usuario);
                }
                model.Email = userData.EMail;
            }

            BEKitNueva[] kitNueva;
            int esColaborador = 0;
            using (var sv = new UsuarioServiceClient())
            {
                kitNueva = sv.GetValidarConsultoraNueva(userData.PaisID, userData.CodigoConsultora);
                esColaborador = sv.GetValidarColaboradorZona(userData.PaisID, userData.CodigoZona);
            }
            int esKitNueva = 0;
            decimal montoKitNueva = 0;

            //Valida de que la consultora tenga estado registrada y de que el proceso de kit de nueva este activo
            if (kitNueva[0].Estado == 1 && kitNueva[0].EstadoProceso == 1 && esColaborador == 0)
            {
                esKitNueva = 1;
                montoKitNueva = userData.MontoMinimo - kitNueva[0].Monto;
            }
            ViewBag.MontoKitNueva = string.Format("{0:N2}", montoKitNueva);
            ViewBag.EsKitNueva = esKitNueva;

            BEFactorGanancia oBEFactorGanancia = null;
            using (var sv = new SACServiceClient())
            {
                oBEFactorGanancia = sv.GetFactorGananciaSiguienteEscala(model.Total, userData.PaisID);
            }
            ViewBag.EscalaDescuento = 0;
            ViewBag.MontoEscalaDescuento = 0;
            ViewBag.PorcentajeEscala = 0;
            if (oBEFactorGanancia != null && esColaborador == 0)
            {
                ViewBag.EscalaDescuento = 1;
                ViewBag.MontoEscalaDescuento = string.Format("{0:N2}", oBEFactorGanancia.RangoMinimo - model.Total);
                ViewBag.PorcentajeEscala = string.Format("{0:N0}", oBEFactorGanancia.Porcentaje);
            }

            int horaCierre = userData.EsZonaDemAnti;
            TimeSpan sp = horaCierre == 0 ? userData.HoraCierreZonaNormal : userData.HoraCierreZonaDemAnti;

            ViewBag.HoraCierre = new DateTime(sp.Ticks).ToString("HH:mm");

            model.ModificacionPedidoProl = userData.NuevoPROL && userData.ZonaNuevoPROL ? 0 : 1;

            return View(model);
        }

        public ActionResult GuardarCuvSession(string cuv)
        {
            if (!string.IsNullOrEmpty(cuv))
            {
                Session["CUVProductoDesctacado"] = cuv;
            }
            return RedirectToAction("index");
        }

        public ActionResult BorrarCuvSession(string cuv)
        {
            Session["CUVProductoDesctacado"] = null;
            return RedirectToAction("index");
        }

        #endregion

        #region Metodos

        private List<BEEstrategia> ListarEstrategias(string cuv)
        {
            List<BEEstrategia> lst;

            var userData = UserData();

            var entidad = new BEEstrategia();
            entidad.PaisID = userData.PaisID;
            entidad.CampaniaID = userData.CampaniaID;
            entidad.ConsultoraID = userData.ConsultoraID.ToString();
            entidad.CUV2 = cuv ?? "";
            entidad.Zona = userData.ZonaID.ToString();

            var listaTipoEstrategias = ListarTipoEstrategia();
            if (Session["ListadoEstrategiaPedido"] == null)
            {
                using (PedidoServiceClient sv = new PedidoServiceClient())
                {
                    lst = sv.GetEstrategiasPedido(entidad).ToList();
                }

                string carpetapais = Globals.UrlMatriz + "/" + userData.CodigoISO;

                if (lst.Count > 0)
                {
                    lst.Update(x => x.FotoProducto01 = ConfigS3.GetUrlFileS3(carpetapais, x.FotoProducto01, carpetapais));
                    lst.Update(x => x.ImagenURL = ConfigS3.GetUrlFileS3(carpetapais, x.ImagenURL, carpetapais));
                    lst.Update(x => x.Simbolo = userData.Simbolo);
                    lst.Update(x =>
                    {
                        var beTipoEstrategia = listaTipoEstrategias.FirstOrDefault(p => p.TipoEstrategiaID == x.TipoEstrategiaID);
                        x.DescripcionEstrategia = beTipoEstrategia != null ? beTipoEstrategia.DescripcionEstrategia : "Estándar";
                    });
                    lst.Update(x => x.DescripcionMarca = GetDescripcionMarca(x.MarcaID));
                }
                lst.Update(x => x.PrecioString = Util.DecimalToStringFormat(x.Precio2, userData.CodigoISO));

                Session["ListadoEstrategiaPedido"] = lst;
            }
            else
            {
                lst = (List<BEEstrategia>)Session["ListadoEstrategiaPedido"];
            }
            int posicion = 1;
            foreach (var estrategia in lst)
            {
                estrategia.ID = estrategia.ColorFondo != "" ? 0 : posicion++;
                var beTipoEstrategia = listaTipoEstrategias.FirstOrDefault(p => p.TipoEstrategiaID == estrategia.TipoEstrategiaID);
                estrategia.DescripcionEstrategia = beTipoEstrategia != null ? beTipoEstrategia.DescripcionEstrategia : "Estándar";
            }
            return lst;
        }

        private string GetDescripcionMarca(int marcaId)
        {
            string result = string.Empty;

            switch (marcaId)
            {
                case 1:
                    result = "L'Bel";
                    break;
                case 2:
                    result = "Ésika";
                    break;
                case 3:
                    result = "Cyzone";
                    break;
                case 4:
                    result = "S&M";
                    break;
                case 5:
                    result = "Home Collection";
                    break;
                case 6:
                    result = "Finart";
                    break;
                case 7:
                    result = "Generico";
                    break;
                case 8:
                    result = "Glance";
                    break;
                default:
                    result = "NO DISPONIBLE";
                    break;
            }

            return result;
        }

        private List<BETipoEstrategia> ListarTipoEstrategia()
        {
            var userData = UserData();
            List<BETipoEstrategia> lst;
            if (Session["ListaTipoEstrategia"] == null)
            {
                var entidad = new BETipoEstrategia();
                entidad.PaisID = userData.PaisID;
                entidad.TipoEstrategiaID = 0;
                using (var sv = new PedidoServiceClient())
                {
                    lst = sv.GetTipoEstrategias(entidad).ToList();
                }
                Session["ListaTipoEstrategia"] = lst;
            }
            else
            {
                lst = (List<BETipoEstrategia>)Session["ListaTipoEstrategia"];
            }
            return lst;
        }

        private void ValidarStatusCampania(BEConfiguracionCampania beConfiguracionCampania)
        {
            UsuarioModel usuario = UserData();
            usuario.ZonaValida = beConfiguracionCampania.ZonaValida;
            usuario.FechaInicioCampania = beConfiguracionCampania.FechaInicioFacturacion;

            // Se calcula la fecha de fin de campaña sumando la fecha de inicio mas los dias de duración del cronograma
            //usuario.FechaFinCampania = oBEConfiguracionCampania.FechaFinFacturacion;
            usuario.FechaFinCampania = beConfiguracionCampania.FechaFinFacturacion;

            usuario.HoraInicioReserva = beConfiguracionCampania.HoraInicio;
            usuario.HoraFinReserva = beConfiguracionCampania.HoraFin;
            usuario.HoraInicioPreReserva = beConfiguracionCampania.HoraInicioNoFacturable;
            usuario.HoraFinPreReserva = beConfiguracionCampania.HoraCierreNoFacturable;
            usuario.DiasCampania = beConfiguracionCampania.DiasAntes;

            bool mostrarBotonValidar;
            usuario.DiaPROL = ValidarPROL(usuario, out mostrarBotonValidar);
            usuario.MostrarBotonValidar = mostrarBotonValidar;
            usuario.NombreCorto = beConfiguracionCampania.CampaniaDescripcion;
            usuario.CampaniaID = beConfiguracionCampania.CampaniaID;
            usuario.ZonaHoraria = beConfiguracionCampania.ZonaHoraria;
            usuario.HoraCierreZonaDemAnti = beConfiguracionCampania.HoraCierreZonaDemAnti;
            usuario.HoraCierreZonaNormal = beConfiguracionCampania.HoraCierreZonaNormal;
            usuario.ValidacionAbierta = beConfiguracionCampania.ValidacionAbierta;

            if (DateTime.Now.AddHours(beConfiguracionCampania.ZonaHoraria) < beConfiguracionCampania.FechaInicioFacturacion.AddDays(-beConfiguracionCampania.DiasAntes))
            {
                usuario.FechaFacturacion = beConfiguracionCampania.FechaInicioFacturacion.AddDays(-beConfiguracionCampania.DiasAntes);
                usuario.HoraFacturacion = beConfiguracionCampania.HoraInicioNoFacturable;
            }
            else
            {
                usuario.FechaFacturacion = beConfiguracionCampania.FechaFinFacturacion;
                usuario.HoraFacturacion = beConfiguracionCampania.HoraFin;
            }
            SetUserData(usuario);
        }

        private int BuildFechaNoHabil()
        {
            int result = 0;
            if (Session["UserData"] != null)
            {
                var userData = UserData();
                using (var sv = new PedidoServiceClient())
                {
                    result = sv.GetFechaNoHabilFacturacion(userData.PaisID, userData.CodigoZona, DateTime.Today);
                }
            }
            return result;
        }

        private List<BEPedidoWebDetalle> ObtenerPedidoWebServer()
        {
            var userData = UserData();

            List<BEPedidoWebDetalle> lstPedidoWebDetalle;

            using (var sv = new PedidoServiceClient())
            {
                lstPedidoWebDetalle = sv.SelectByCampania(userData.PaisID, userData.CampaniaID, userData.ConsultoraID, userData.NombreConsultora).ToList();
            }

            Session["PedidoWebDetalle"] = lstPedidoWebDetalle;

            return lstPedidoWebDetalle;
        }

        private void ValidarSesionCuvProductoDestacado()
        {
            try
            {
                if (Request.UrlReferrer != null)
                {
                    if (!Request.UrlReferrer.AbsolutePath.ToLower().Contains("productosdestacados"))
                    {
                        Session["CUVProductoDesctacado"] = null;
                    }
                }
            }
            catch (Exception) { }
        }

        #region PROL

        private bool ValidarPROL(UsuarioModel usuario, out bool mostrarBotonValidar)
        {
            DateTime FechaHoraActual = DateTime.Now.AddHours(usuario.ZonaHoraria);
            bool DiaPROL = false;
            mostrarBotonValidar = false;

            if (FechaHoraActual > usuario.FechaInicioCampania.AddDays(-usuario.DiasCampania) &&
                FechaHoraActual < usuario.FechaInicioCampania)
            {
                TimeSpan HoraNow = new TimeSpan(FechaHoraActual.Hour, FechaHoraActual.Minute, 0);
                if (HoraNow > usuario.HoraInicioPreReserva && HoraNow < usuario.HoraFinPreReserva)
                {
                    int cantidad = BuildFechaNoHabil();

                    if (cantidad == 0)
                        mostrarBotonValidar = true;
                    else
                        mostrarBotonValidar = false;

                }
                else
                    mostrarBotonValidar = false;
                DiaPROL = true;
            }
            else
            {
                if (FechaHoraActual > usuario.FechaInicioCampania &&
                    FechaHoraActual < usuario.FechaFinCampania.AddDays(1))
                {
                    DiaPROL = true;
                    TimeSpan HoraNow = new TimeSpan(FechaHoraActual.Hour, FechaHoraActual.Minute, 0);
                    if (HoraNow > usuario.HoraInicioReserva && HoraNow < usuario.HoraFinReserva)
                    {
                        int cantidad = BuildFechaNoHabil();

                        if (cantidad == 0)
                            mostrarBotonValidar = true;
                        else
                            mostrarBotonValidar = false;
                    }
                    else
                        mostrarBotonValidar = false;
                }
            }
            return DiaPROL;
        }

        private List<ObservacionModel> DevolverObservacionesPROL(List<BEPedidoWebDetalle> lstPedidoWebDetalle, out bool restrictivas, out bool informativas, out bool existeError, out bool reserva, out decimal montoAhorroCatalogo, out decimal montoAhorroRevista, out decimal montoDescuento, out decimal montoEscala, out string codigoMensaje)
        {
            restrictivas = false;
            informativas = false;
            existeError = false;
            reserva = false;
            montoAhorroCatalogo = 0;
            montoAhorroRevista = 0;
            montoDescuento = 0;
            montoEscala = 0;
            codigoMensaje = "";

            var userData = UserData();

            DataSet ds = new DataSet();
            DataTable dt = new DataTable();
            dt.Columns.Add("CodConsultora");
            dt.Columns.Add("CodVta");
            dt.Columns.Add("Cantidad", Type.GetType("System.Int32"));
            dt.Columns.Add("TipoOfertaSisID", Type.GetType("System.Int32"));

            decimal montodescontar = 0;
            decimal montoenviar = 0;

            foreach (var item in lstPedidoWebDetalle)
            {
                if (item.TipoOfertaSisID != Constantes.ConfiguracionOferta.Liquidacion)
                {
                    dt.Rows.Add(userData.CodigoConsultora, item.CUV, item.Cantidad, item.TipoOfertaSisID);
                }
                else
                {
                    montodescontar = montodescontar + item.ImporteTotal;
                }
            }

            ds.Tables.Add(dt);

            var kitNueva = new List<BEKitNueva>();

            using (var sv = new UsuarioServiceClient())
            {
                kitNueva = sv.GetValidarConsultoraNueva(userData.PaisID, userData.CodigoConsultora).ToList();
            }

            //Valida de que la consultora tenga estado registrada y de que el proceso de kit de nueva este activo
            if (kitNueva[0].Estado == 1 && kitNueva[0].EstadoProceso == 1)
            {
                montodescontar = montodescontar + kitNueva[0].Monto;
            }

            montoenviar = userData.MontoMinimo - montodescontar;


            if (montoenviar < 0)
            {
                montoenviar = 0;
            }

            ServicePROL.TransferirDatos datos = null;

            if (ds.Tables[0].Rows.Count == 0)
                return new List<ObservacionModel>();

            if (Constantes.CodigosISOPais.Peru.Equals(userData.CodigoISO.ToUpper()) ||
                Constantes.CodigosISOPais.Chile.Equals(userData.CodigoISO.ToUpper()) ||
                Constantes.CodigosISOPais.Ecuador.Equals(userData.CodigoISO.ToUpper()) ||
                Constantes.CodigosISOPais.CostaRica.Equals(userData.CodigoISO.ToUpper()) ||
                Constantes.CodigosISOPais.Salvador.Equals(userData.CodigoISO.ToUpper()) ||
                Constantes.CodigosISOPais.Panama.Equals(userData.CodigoISO.ToUpper()) ||
                Constantes.CodigosISOPais.Guatemala.Equals(userData.CodigoISO.ToUpper()) ||
                Constantes.CodigosISOPais.Venezuela.Equals(userData.CodigoISO.ToUpper()) ||
                Constantes.CodigosISOPais.Colombia.Equals(userData.CodigoISO.ToUpper()) ||
                Constantes.CodigosISOPais.PuertoRico.Equals(userData.CodigoISO.ToUpper()) ||
                Constantes.CodigosISOPais.Dominicana.Equals(userData.CodigoISO.ToUpper()) ||
                Constantes.CodigosISOPais.Mexico.Equals(userData.CodigoISO.ToUpper()) ||
                Constantes.CodigosISOPais.Bolivia.Equals(userData.CodigoISO.ToUpper()))
            {
                using (var sv = new ServicePROL.ServiceStockSsic())
                {
                    if (userData.DiaPROL && userData.MostrarBotonValidar)
                    {
                        sv.Url = ConfigurarUrlServiceProl();
                        sv.wsDesReservarPedido(userData.CodigoConsultora, userData.CodigoISO);
                        datos = sv.wsValidarPedidoEX(ds, montoenviar, userData.CodigoZona, userData.CodigoISO, userData.CampaniaID.ToString(), userData.ConsultoraNueva, userData.MontoMaximo);
                    }
                    else
                    {
                        sv.Url = ConfigurarUrlServiceProl();
                        datos = sv.wsValidarEstrategia(ds, montoenviar, userData.CodigoZona, userData.CodigoISO, userData.CampaniaID.ToString(), userData.ConsultoraNueva, userData.MontoMaximo);
                    }
                }
            }
            else if (Constantes.CodigosISOPais.Argentina.Equals(userData.CodigoISO.ToUpper()))
            {
                using (var svb = new ServicePROLBO.ServiceStockV2())
                {
                    datos = new ServicePROL.TransferirDatos();
                    if (userData.DiaPROL && userData.MostrarBotonValidar)
                    {
                        svb.Url = ConfigurarUrlServiceProl();

                        if (Constantes.CodigosISOPais.Bolivia.Equals(userData.CodigoISO.ToUpper()))
                        {
                            svb.wsDesReservarPedido(userData.CodigoConsultora);
                            datos.data = svb.wsValidarPedido(ds, montoenviar, userData.MontoMaximo);
                        }
                        else
                        {
                            svb.wsDesReservarPedidoPais(userData.CodigoConsultora, userData.CodigoISO);
                            datos.data = svb.wsValidarPedidoPais(ds, montoenviar, userData.MontoMaximo, userData.CodigoZona, userData.CodigoISO);
                        }

                        if (datos.data != null && datos.data.Tables[0] != null && datos.data.Tables[0].Rows.Count != 0)
                        {
                            datos.codigoMensaje = "01";
                        }
                        else
                        {
                            datos.data = new DataSet();
                            datos.data.Tables.Add(new DataTable());
                            datos.codigoMensaje = "00";
                        }
                    }
                    else
                    {
                        datos.data = new DataSet();
                        datos.data.Tables.Add(new DataTable());
                        datos.codigoMensaje = "00";
                    }
                }
            }

            var lstPedidoWebDetalleObsvaciones = new List<ObservacionModel>();

            if (datos != null)
            {
                #region Actualizar montos del servicio de prol a Pedido

                Decimal.TryParse(datos.montoAhorroCatalogo, out montoAhorroCatalogo);
                Decimal.TryParse(datos.montoAhorroRevista, out montoAhorroRevista);
                Decimal.TryParse(datos.montoDescuento, out montoDescuento);
                Decimal.TryParse(datos.montoEscala, out montoEscala);

                codigoMensaje = datos.codigoMensaje;

                using (PedidoServiceClient sv = new PedidoServiceClient())
                {
                    BEPedidoWeb bePedidoWeb = new BEPedidoWeb();
                    bePedidoWeb.PaisID = userData.PaisID;
                    bePedidoWeb.CampaniaID = userData.CampaniaID;
                    bePedidoWeb.ConsultoraID = userData.ConsultoraID;
                    bePedidoWeb.CodigoConsultora = userData.CodigoConsultora;
                    bePedidoWeb.MontoAhorroCatalogo = montoAhorroCatalogo;
                    bePedidoWeb.MontoAhorroRevista = montoAhorroRevista;
                    bePedidoWeb.DescuentoProl = montoDescuento;
                    bePedidoWeb.MontoEscala = montoEscala;

                    sv.UpdateMontosPedidoWeb(bePedidoWeb);

                    Session["PedidoWeb"] = null;
                }

                #endregion

                DataTable dtr = datos.data.Tables[0];
                if (datos.codigoMensaje != "00")
                {
                    foreach (DataRow row in dtr.Rows)
                    {
                        int tipoObservacion = Convert.ToInt32(row.ItemArray.GetValue(0));
                        switch (tipoObservacion)
                        {
                            case 0:
                                if (Constantes.CodigosISOPais.Peru.Equals(userData.CodigoISO.ToUpper()) ||
                                    Constantes.CodigosISOPais.Chile.Equals(userData.CodigoISO.ToUpper()) ||
                                    Constantes.CodigosISOPais.Ecuador.Equals(userData.CodigoISO.ToUpper()) ||
                                    Constantes.CodigosISOPais.CostaRica.Equals(userData.CodigoISO.ToUpper()) ||
                                    Constantes.CodigosISOPais.Salvador.Equals(userData.CodigoISO.ToUpper()) ||
                                    Constantes.CodigosISOPais.Panama.Equals(userData.CodigoISO.ToUpper()) ||
                                    Constantes.CodigosISOPais.Guatemala.Equals(userData.CodigoISO.ToUpper()) ||
                                    Constantes.CodigosISOPais.Venezuela.Equals(userData.CodigoISO.ToUpper()) ||
                                    Constantes.CodigosISOPais.Colombia.Equals(userData.CodigoISO.ToUpper()) ||
                                    Constantes.CodigosISOPais.PuertoRico.Equals(userData.CodigoISO.ToUpper()) ||
                                    Constantes.CodigosISOPais.Dominicana.Equals(userData.CodigoISO.ToUpper()) ||
                                    Constantes.CodigosISOPais.Mexico.Equals(userData.CodigoISO.ToUpper()) ||
                                    Constantes.CodigosISOPais.Bolivia.Equals(userData.CodigoISO.ToUpper()))
                                {
                                    lstPedidoWebDetalleObsvaciones.Add(new ObservacionModel { Caso = 0, CUV = Convert.ToString(row.ItemArray.GetValue(1)), Tipo = 1, Descripcion = string.Format("{0}", Convert.ToString(row.ItemArray.GetValue(3)).Replace("+", "")) });
                                }
                                else if (Constantes.CodigosISOPais.Argentina.Equals(userData.CodigoISO.ToUpper()))
                                {
                                    if (Convert.ToString(row.ItemArray.GetValue(3)) == "-Reemplazo")
                                    {
                                        lstPedidoWebDetalleObsvaciones.Add(new ObservacionModel { Caso = 0, CUV = Convert.ToString(row.ItemArray.GetValue(1)), Tipo = 1, Descripcion = string.Format("{0}", Convert.ToString(row.ItemArray.GetValue(2)).Replace("+", "")) });
                                    }
                                    else
                                    {
                                        lstPedidoWebDetalleObsvaciones.Add(new ObservacionModel { Caso = 0, CUV = Convert.ToString(row.ItemArray.GetValue(1)), Tipo = 1, Descripcion = string.Format("{0} {1}", Convert.ToString(row.ItemArray.GetValue(2)).Replace("+", ""), Convert.ToString(row.ItemArray.GetValue(3)).Replace("+", "")) });
                                    }
                                }
                                informativas = true;
                                break;
                            case 1:
                            case 7:
                                lstPedidoWebDetalleObsvaciones.Add(new ObservacionModel { Caso = 7, CUV = Convert.ToString(row.ItemArray.GetValue(1)), Tipo = 2, Descripcion = string.Format("{0}", Convert.ToString(row.ItemArray.GetValue(3)).Replace("+", "")) });
                                restrictivas = true;
                                break;
                            case 2:
                                lstPedidoWebDetalleObsvaciones.Add(new ObservacionModel { Caso = 2, CUV = Convert.ToString(row.ItemArray.GetValue(1)), Tipo = 2, Descripcion = string.Format("PRODUCTO {0} - {1} {2}", Convert.ToString(row.ItemArray.GetValue(1)), Convert.ToString(row.ItemArray.GetValue(2)).Replace("+", ""), Convert.ToString(row.ItemArray.GetValue(3)).Replace("+", "")) });
                                restrictivas = true;
                                break;
                            case 5:
                                lstPedidoWebDetalleObsvaciones.Add(new ObservacionModel { Caso = 5, CUV = Convert.ToString(row.ItemArray.GetValue(1)), Tipo = 2, Descripcion = string.Format("{0}", Convert.ToString(row.ItemArray.GetValue(3)).Replace("+", "")) });
                                restrictivas = true;
                                break;
                            case 8:
                                lstPedidoWebDetalleObsvaciones.Add(new ObservacionModel { Caso = 8, CUV = string.Empty, Tipo = 2, Descripcion = string.Format("{0} {1}", Convert.ToString(row.ItemArray.GetValue(2)).Replace("+", ""), Convert.ToString(row.ItemArray.GetValue(3)).Replace("+", "")) });
                                restrictivas = true;
                                break;
                            case 9:
                                lstPedidoWebDetalleObsvaciones.Add(new ObservacionModel { Caso = 9, CUV = string.Empty, Tipo = 3, Descripcion = string.Format("{0} {1}", Convert.ToString(row.ItemArray.GetValue(2)).Replace("+", ""), Convert.ToString(row.ItemArray.GetValue(3)).Replace("+", "")) });
                                restrictivas = true;
                                break;
                            case 10:
                                lstPedidoWebDetalleObsvaciones.Add(new ObservacionModel { Caso = 10, CUV = Convert.ToString(row.ItemArray.GetValue(1)), Tipo = 2, Descripcion = string.Format("{0} {1}", Convert.ToString(row.ItemArray.GetValue(2)).Replace("+", ""), Convert.ToString(row.ItemArray.GetValue(3)).Replace("+", "")) });
                                restrictivas = true;
                                break;
                            case 11:
                                lstPedidoWebDetalleObsvaciones.Add(new ObservacionModel { Caso = 11, CUV = string.Empty, Tipo = 3, Descripcion = string.Empty });
                                existeError = true;
                                break;
                            case 16:
                                lstPedidoWebDetalleObsvaciones.Add(new ObservacionModel { Caso = 16, CUV = Convert.ToString(row.ItemArray.GetValue(1)), Tipo = 2, Descripcion = string.Format("PRODUCTO {0} - {1} {2}", Convert.ToString(row.ItemArray.GetValue(1)), Convert.ToString(row.ItemArray.GetValue(2)).Replace("+", ""), Convert.ToString(row.ItemArray.GetValue(3)).Replace("+", "")) });
                                restrictivas = true;
                                break;
                            case 95:
                                lstPedidoWebDetalleObsvaciones.Add(new ObservacionModel { Caso = 95, CUV = string.Empty, Tipo = 2, Descripcion = string.Format("{0}", Convert.ToString(row.ItemArray.GetValue(3)).Replace("+", "")) });
                                restrictivas = true;
                                break;
                            default:
                                lstPedidoWebDetalleObsvaciones.Add(new ObservacionModel { Caso = tipoObservacion, CUV = Convert.ToString(row.ItemArray.GetValue(1)), Tipo = 2, Descripcion = string.Format("{0} {1}", Convert.ToString(row.ItemArray.GetValue(2)).Replace("+", ""), Convert.ToString(row.ItemArray.GetValue(3)).Replace("+", "")) });
                                restrictivas = true;
                                break;
                        }
                    }

                    if (informativas && !restrictivas)
                    {
                        if (userData.DiaPROL && userData.MostrarBotonValidar)
                        {
                            //La reserva sobre el portal se realiza al dar SI en el mensaje.
                            reserva = true;
                        }
                    }
                }
                else
                {
                    if (userData.DiaPROL && userData.MostrarBotonValidar)
                    {
                        decimal MontoTotalPROL = 0;
                        Decimal.TryParse(datos.montototal, out MontoTotalPROL);
                        EjecutarReservaPortal(dtr, lstPedidoWebDetalle, MontoTotalPROL);
                        reserva = true;
                    }
                }
            }
            return lstPedidoWebDetalleObsvaciones;
        }

        private List<ObservacionModel> DevolverObservacionesPROLv2(List<BEPedidoWebDetalle> lstPedidoWebDetalle, out bool restrictivas, out bool informativas, out bool existeError, out bool reserva, out decimal montoAhorroCatalogo, out decimal montoAhorroRevista, out decimal montoDescuento, out decimal montoEscala, out string codigoMensaje)
        {
            restrictivas = false;
            informativas = false;
            existeError = false;
            reserva = false;
            montoAhorroCatalogo = 0;
            montoAhorroRevista = 0;
            montoDescuento = 0;
            montoEscala = 0;
            codigoMensaje = "";

            var userData = UserData();

            DataSet ds = new DataSet();
            DataTable dt = new DataTable();
            dt.Columns.Add("CodConsultora");
            dt.Columns.Add("CodVta");
            dt.Columns.Add("Cantidad", Type.GetType("System.Int32"));
            dt.Columns.Add("TipoOfertaSisID", Type.GetType("System.Int32"));

            decimal montodescontar = 0;
            decimal montoenviar = 0;

            foreach (var item in lstPedidoWebDetalle)
            {
                if (item.TipoOfertaSisID != Constantes.ConfiguracionOferta.Liquidacion)
                {
                    dt.Rows.Add(userData.CodigoConsultora, item.CUV, item.Cantidad, item.TipoOfertaSisID);
                }
                else
                {
                    montodescontar = montodescontar + item.ImporteTotal;
                }
            }

            ds.Tables.Add(dt);

            var kitNueva = new List<BEKitNueva>();

            using (var sv = new UsuarioServiceClient())
            {
                kitNueva = sv.GetValidarConsultoraNueva(userData.PaisID, userData.CodigoConsultora).ToList();
            }

            if (kitNueva[0].Estado == 1 && kitNueva[0].EstadoProceso == 1)
            {
                montodescontar = montodescontar + kitNueva[0].Monto;
            }

            montoenviar = userData.MontoMinimo - montodescontar;

            if (montoenviar < 0)
            {
                montoenviar = 0;
            }

            ServicePROL.TransferirDatos datos;

            if (ds.Tables[0].Rows.Count == 0)
                return new List<ObservacionModel>();

            bool EsReservaPedidoPROL = true;

            using (var sv = new ServicePROL.ServiceStockSsic())
            {
                if (userData.DiaPROL && userData.MostrarBotonValidar)
                {
                    EsReservaPedidoPROL = true;
                    sv.Url = ConfigurarUrlServiceProl();
                    datos = sv.wsValidarPedidoInteractivo(ds, montoenviar, userData.CodigoZona, userData.CodigoISO, userData.CampaniaID.ToString(), userData.ConsultoraNueva, userData.MontoMaximo);
                }
                else
                {
                    EsReservaPedidoPROL = false;
                    sv.Url = ConfigurarUrlServiceProl();
                    datos = sv.wsValidarEstrategia(ds, montoenviar, userData.CodigoZona, userData.CodigoISO, userData.CampaniaID.ToString(), userData.ConsultoraNueva, userData.MontoMaximo);
                }
            }

            var lstPedidoWebDetalleObs = new List<ObservacionModel>();

            if (datos != null)
            {
                DataTable dtr = datos.data.Tables[0];
                bool ValidacionPROLMM = false;
                string CUV_Val = string.Empty;
                int ValidacionReemplazo = 0;
                decimal MontoTotalPROL = 0;
                Decimal.TryParse(datos.montototal, out MontoTotalPROL);

                #region Actualizar montos del servicio de prol a Pedido

                Decimal.TryParse(datos.montoAhorroCatalogo, out montoAhorroCatalogo);
                Decimal.TryParse(datos.montoAhorroRevista, out montoAhorroRevista);
                Decimal.TryParse(datos.montoDescuento, out montoDescuento);
                Decimal.TryParse(datos.montoEscala, out montoEscala);

                codigoMensaje = datos.codigoMensaje;

                using (PedidoServiceClient sv = new PedidoServiceClient())
                {
                    BEPedidoWeb bePedidoWeb = new BEPedidoWeb();
                    bePedidoWeb.PaisID = userData.PaisID;
                    bePedidoWeb.CampaniaID = userData.CampaniaID;
                    bePedidoWeb.ConsultoraID = userData.ConsultoraID;
                    bePedidoWeb.CodigoConsultora = userData.CodigoConsultora;
                    bePedidoWeb.MontoAhorroCatalogo = montoAhorroCatalogo;
                    bePedidoWeb.MontoAhorroRevista = montoAhorroRevista;
                    bePedidoWeb.DescuentoProl = montoDescuento;
                    bePedidoWeb.MontoEscala = montoEscala;

                    sv.UpdateMontosPedidoWeb(bePedidoWeb);

                    Session["PedidoWeb"] = null;
                }

                #endregion

                if (datos.codigoMensaje != "00")
                {
                    foreach (DataRow row in dtr.Rows)
                    {
                        int TipoObs = 0;
                        string CUV = string.Empty;
                        string Observacion = string.Empty;

                        if (EsReservaPedidoPROL)
                        {
                            TipoObs = Convert.ToInt32(row.ItemArray.GetValue(6));
                            CUV = Convert.ToString(row.ItemArray.GetValue(0));
                            Observacion = Convert.ToString(row.ItemArray.GetValue(7)).Replace("+", "");
                        }
                        else
                        {
                            TipoObs = Convert.ToInt32(row.ItemArray.GetValue(0));
                            CUV = Convert.ToString(row.ItemArray.GetValue(1));
                            Observacion = Convert.ToString(row.ItemArray.GetValue(3)).Replace("+", "");
                        }

                        if (TipoObs == 0)
                            ValidacionReemplazo += 1;

                        if (TipoObs == 95)
                        {
                            ValidacionPROLMM = true;
                            CUV_Val = CUV;
                            /*EDP-796 - JICM - INI*/
                            string regex = "(\\#.*\\#)";
                            Observacion = Regex.Replace(Observacion, regex, UserData().MontoMinimo.ToString());
                            /*EDP-796 - JICM - FIN*/
                        }

                        restrictivas = true;
                        lstPedidoWebDetalleObs.Add(new ObservacionModel { Caso = TipoObs, CUV = CUV, Tipo = 2, Descripcion = Observacion });
                    }

                    if (userData.ValidacionAbierta && ValidacionPROLMM && CUV_Val == "XXXXX")
                    {
                        using (var sv = new PedidoServiceClient())
                        {
                            sv.UpdPedidoWebByEstado(userData.PaisID, userData.CampaniaID, userData.PedidoID, Constantes.EstadoPedido.Pendiente, false, true, userData.CodigoUsuario, false);
                        }
                    }

                    if (dtr.Rows.Count == ValidacionReemplazo)
                    {
                        if (userData.DiaPROL && userData.MostrarBotonValidar)
                        {
                            EjecutarReservaPortalv2(dtr, lstPedidoWebDetalle, MontoTotalPROL);
                            reserva = true;
                        }
                    }
                }
                else
                {
                    if (userData.DiaPROL && userData.MostrarBotonValidar)
                    {
                        EjecutarReservaPortalv2(dtr, lstPedidoWebDetalle, MontoTotalPROL);
                        reserva = true;
                    }
                }
            }
            return lstPedidoWebDetalleObs;
        }

        private void EjecutarReservaPortal(DataTable dtr, List<BEPedidoWebDetalle> lstPedidoWebDetalle, decimal MontoTotalProL = 0, decimal descuentoProl = 0)
        {
            var userData = UserData();

            int PaisID = userData.PaisID;
            int CampaniaID = userData.CampaniaID;
            int PedidoID = userData.PedidoID;
            long ConsultoraID = userData.ConsultoraID;
            string CodigoUsuario = userData.CodigoUsuario;

            if (PedidoID == 0)
            {
                using (var sv = new PedidoServiceClient())
                {
                    PedidoID = sv.GetPedidoWebID(PaisID, CampaniaID, ConsultoraID);
                }
                UserData().PedidoID = PedidoID;
            }

            List<BEPedidoWebDetalle> olstPedidoReserva = new List<BEPedidoWebDetalle>();

            foreach (DataRow row in dtr.Rows)
            {
                var temp = lstPedidoWebDetalle.Where(p => p.CUV == Convert.ToString(row.ItemArray.GetValue(0)));
                if (!temp.Any())
                {
                    olstPedidoReserva.Add(new BEPedidoWebDetalle()
                    {
                        CampaniaID = lstPedidoWebDetalle[0].CampaniaID,
                        PedidoID = lstPedidoWebDetalle[0].PedidoID,
                        //Desactivado porque no existe Jerarquia
                        //PedidoDetalleID = PedidoDetalleIDPadre,
                        PedidoDetalleID = 0,
                        MarcaID = lstPedidoWebDetalle[0].MarcaID,
                        ConsultoraID = lstPedidoWebDetalle[0].ConsultoraID,
                        ClienteID = 0,
                        Cantidad = Convert.ToInt32(row.ItemArray.GetValue(3)),
                        //Precio Unidad deberia ser cero pero lo envían
                        //PrecioUnidad = Convert.ToDecimal(row.ItemArray.GetValue(2)),
                        PrecioUnidad = 0,
                        //ImporteTotal = Convert.ToDecimal(row.ItemArray.GetValue(4)),
                        ImporteTotal = 0,
                        CUV = Convert.ToString(row.ItemArray.GetValue(0)),
                        OfertaWeb = false,
                        //Desactivado porque no existe Jerarquia
                        //CUVPadre = CUVPadre
                        CUVPadre = "0",
                        CodigoUsuarioCreacion = CodigoUsuario,
                        CodigoUsuarioModificacion = CodigoUsuario
                    });
                }
            }
            using (var sv = new PedidoServiceClient())
            {
                if (userData.PROLSinStock)
                    sv.InsPedidoWebDetallePROL(PaisID, CampaniaID, PedidoID, Constantes.EstadoPedido.Pendiente, olstPedidoReserva.ToArray(), 0, CodigoUsuario, MontoTotalProL, descuentoProl);
                else
                    sv.InsPedidoWebDetallePROL(PaisID, CampaniaID, PedidoID, Constantes.EstadoPedido.Procesado, olstPedidoReserva.ToArray(), 0, CodigoUsuario, MontoTotalProL, descuentoProl);
            }

            using (var sv = new SACServiceClient())
            {
                //Se reutiliza la lista, pues desde el método origen devuelve la información de los productos del pedido de BD.
                decimal totalPedido = lstPedidoWebDetalle.Sum(p => p.ImporteTotal);
                decimal gananciaEstimada = CalcularGananciaEstimada(PaisID, CampaniaID, PedidoID, totalPedido);
                sv.UpdatePedidoWebEstimadoGanancia(PaisID, CampaniaID, PedidoID, gananciaEstimada);
            }
        }

        private void EjecutarReservaPortalv2(DataTable dtr, List<BEPedidoWebDetalle> lstPedidoWebDetalle, decimal MontoTotalProL = 0, decimal descuentoProl = 0)
        {
            var userData = UserData();

            int PaisID = userData.PaisID;
            int CampaniaID = userData.CampaniaID;
            int PedidoID = userData.PedidoID;
            long ConsultoraID = userData.ConsultoraID;
            string CodigoUsuario = userData.CodigoUsuario;

            if (PedidoID == 0)
            {
                using (var sv = new PedidoServiceClient())
                {
                    PedidoID = sv.GetPedidoWebID(PaisID, CampaniaID, ConsultoraID);
                }
                UserData().PedidoID = PedidoID;
            }

            var olstPedidoReserva = new List<BEPedidoWebDetalle>();

            foreach (DataRow row in dtr.Rows)
            {
                var temp = lstPedidoWebDetalle.Where(p => p.CUV == Convert.ToString(row.ItemArray.GetValue(0)));
                foreach (var item in temp)
                {
                    var detalle = new BEPedidoWebDetalle();
                    detalle.CampaniaID = item.CampaniaID;
                    detalle.PedidoID = item.PedidoID;
                    detalle.PedidoDetalleID = item.PedidoDetalleID;
                    detalle.ObservacionPROL = Convert.ToString(row.ItemArray.GetValue(7));
                    olstPedidoReserva.Add(detalle);
                }
            }
            using (var sv = new PedidoServiceClient())
            {
                if (userData.PROLSinStock)
                    sv.InsPedidoWebDetallePROLv2(PaisID, CampaniaID, PedidoID, Constantes.EstadoPedido.Pendiente, olstPedidoReserva.ToArray(), false, CodigoUsuario, MontoTotalProL, descuentoProl);
                else
                    sv.InsPedidoWebDetallePROLv2(PaisID, CampaniaID, PedidoID, Constantes.EstadoPedido.Procesado, olstPedidoReserva.ToArray(), false, CodigoUsuario, MontoTotalProL, descuentoProl);
            }
            using (var sv = new SACServiceClient())
            {
                //Se reutiliza la lista, pues desde el método origen devuelve la información de los productos del pedido de BD.
                decimal totalPedido = lstPedidoWebDetalle.Sum(p => p.ImporteTotal);
                decimal gananciaEstimada = CalcularGananciaEstimada(PaisID, CampaniaID, PedidoID, totalPedido);
                sv.UpdatePedidoWebEstimadoGanancia(PaisID, CampaniaID, PedidoID, gananciaEstimada);
            }
        }

        private List<BEPedidoWebDetalle> PedidoJerarquico(List<BEPedidoWebDetalle> listadoPedidos)
        {
            List<BEPedidoWebDetalle> result = new List<BEPedidoWebDetalle>();
            List<BEPedidoWebDetalle> padres = listadoPedidos.Where(p => p.PedidoDetalleIDPadre == 0).ToList();
            foreach (var item in padres)
            {
                result.Add(item);
                var items = listadoPedidos.Where(p => p.PedidoDetalleIDPadre == item.PedidoDetalleID);
                if (items.Count() != 0)
                    result.AddRange(items);
            }

            return result;
        }

        private dynamic CalcularGananciaEstimada(int paisId, int campaniaId, int pedidoId, decimal totalPedido)
        {
            // se consultan los indicadores de descuento de los productos del pedido (PedidoWebDetalle)
            BEFactorGanancia FactorGanancia = new BEFactorGanancia();
            List<BEPedidoWebDetalleDescuento> ProductosIndicadorDscto = new List<BEPedidoWebDetalleDescuento>();

            using (SACServiceClient sv = new SACServiceClient())
            {
                ProductosIndicadorDscto = sv.GetIndicadorDescuentoByPedidoWebDetalle(paisId, campaniaId, pedidoId).ToList();
                FactorGanancia = sv.GetFactorGananciaEscalaDescuento(totalPedido, paisId);
                if (FactorGanancia == null)
                    FactorGanancia = new BEFactorGanancia { FactorGananciaID = 0, Porcentaje = 0 };
            }

            // se recorren los productos del pedido y se evalua su indicador de descuento aplicando la logica siguiente:
            ProductosIndicadorDscto.ForEach(delegate(BEPedidoWebDetalleDescuento productoIndicadorDscto)
            {
                string indicador = productoIndicadorDscto.IndicadorDscto.ToLower();
                decimal indicadorNumero;

                // Espacio en blanco: Precio Unitario - Precio Catalogo
                if (indicador == " ")
                {
                    productoIndicadorDscto.MontoDscto = (productoIndicadorDscto.PrecioUnidad - productoIndicadorDscto.PrecioCatalogo2) * productoIndicadorDscto.Cantidad;
                    return;
                }
                // 'C': porcentaje de acuerdo al rango del total
                if (indicador == "c")
                {
                    productoIndicadorDscto.MontoDscto = (productoIndicadorDscto.PrecioUnidad * (FactorGanancia.Porcentaje / 100)) * productoIndicadorDscto.Cantidad;
                    return;
                }
                // numero: porcentaje de descuento
                if (decimal.TryParse(indicador, out indicadorNumero))
                {
                    // debe estar en el rango de 1 a 100
                    if (indicadorNumero >= 0 && indicadorNumero <= 100)
                    {
                        productoIndicadorDscto.MontoDscto = (productoIndicadorDscto.PrecioUnidad * (indicadorNumero / 100)) * productoIndicadorDscto.Cantidad;
                    }
                }
            });

            // se suman todos los montos de descuento para obtener el estimado de ganancia
            decimal estimadoGanancia = ProductosIndicadorDscto.Sum(p => p.MontoDscto);
            return estimadoGanancia;
        }

        public bool EnviarCorreoPedidoValidado(List<BEPedidoWebDetalle> lstPedidoWebDetalle)
        {
            var userData = UserData();
            var fechaHoy = DateTime.Now.AddHours(userData.ZonaHoraria).Date;

            var mailBody = new StringBuilder();
            mailBody.Append("<!DOCTYPE HTML PUBLIC \"-//W3C//DTD HTML 4.0 Transitional//EN\">");
            mailBody.Append("<meta http-equiv='Content-Type' content='Type=text/html; charset=utf-8'>");
            mailBody.Append("<table border='0' cellspacing='0' cellpadding='0' style='width: 100%;'>");
            mailBody.AppendFormat("<tr><td><div style='font-size:12px;'>Hola {0},</div></td></tr>", userData.PrimerNombre);
            mailBody.Append("<tr style='height:12px;'><td><div style='font-size:12px;'></div></td></tr>");
            mailBody.Append("<tr><td><div style='font-size:12px;'>¡Felicitaciones!</div ></td></tr>");
            mailBody.Append("<tr><td><div style='font-size:12px;'>Tu pedido ha sido reservado con éxito.</div></td></tr>");

            if (fechaHoy < userData.FechaInicioCampania.Date)
            {
                mailBody.AppendFormat("<tr><td><div style='font-size:12px;'>Será enviado a Belcorp el {0}, siempre y cuando cumplas con el monto mínimo y no tengas deuda.</div></div></td></tr>", userData.FechaInicioCampania.Day + " de " + NombreMes(userData.FechaInicioCampania.Month));
            }
            else
            {
                mailBody.AppendFormat("<tr><td><div style='font-size:12px;'>Será enviado a Belcorp {0}, siempre y cuando cumplas con el monto mínimo y no tengas deuda.</div></div></td></tr>", "hoy");
            }
            mailBody.Append("<tr style='height:12px;'><td><div style='font-size:12px;'></div></td></tr>");
            mailBody.Append("</table>");
            mailBody.Append("<table border='0' cellspacing='0' cellpadding='0' style='width: 90%; margin-left: 10px;'>");
            mailBody.Append("<tr style='color: #FFFFFF'>");
            mailBody.Append("<td style='font-size:11px; font-weight: bold; text-align: center; width: 70px; background-color: #6c217f;'>");
            mailBody.Append("Cód.<br />Venta</td>");
            mailBody.Append("<td style='font-size:11px; font-weight: bold; text-align: center; width: 347px; background-color: #6c217f; padding-left:5px; padding-right:5px;'>");
            mailBody.Append("Descripción</td>");
            mailBody.Append("<td style='font-size:11px; font-weight: bold; text-align: center; width: 124px; background-color: #6c217f;'>");
            mailBody.Append("Cantidad</td>");
            mailBody.Append("<td style='font-size:11px; font-weight: bold; text-align: center; width: 182px; background-color: #6c217f;'>");
            mailBody.Append("Precio Unit.</td>");
            mailBody.Append("<td style='font-size:11px; font-weight: bold; text-align: center; width: 165px; background-color: #6c217f;'>");
            mailBody.Append("Precio Total</td>");
            mailBody.Append("<td style='font-size:11px; font-weight: bold; text-align: center; width: 165px; background-color: #6c217f;'>");
            mailBody.Append("Cliente</td></tr>");

            foreach (var pedidoDetalle in lstPedidoWebDetalle)
            {
                mailBody.Append("<tr>");
                mailBody.Append("<td style='font-size:11px; width: 56px; text-align: center; border-bottom: 1px solid #6c217f;  border-left: 1px solid #6c217f;'>");
                mailBody.AppendFormat("{0}</td>", pedidoDetalle.CUV);
                mailBody.Append("<td style='font-size:11px; width: 347px; text-align: left; border-bottom: 1px solid #6c217f;'>");
                mailBody.AppendFormat("{0}</td>", pedidoDetalle.DescripcionProd);
                mailBody.Append("<td style='font-size:11px; width: 124px; text-align: center; border-bottom: 1px solid #6c217f;'>");
                mailBody.AppendFormat("{0}</td>", pedidoDetalle.Cantidad);
                if (userData.PaisID == 4) //CO
                {
                    mailBody.Append("<td style='font-size:11px; width: 182px; text-align: center; border-bottom: 1px solid #6c217f;'>");
                    mailBody.Append(userData.Simbolo);
                    mailBody.Append(string.Format("{0:#,##0}", pedidoDetalle.PrecioUnidad).Replace(',', '.'));
                    mailBody.Append("</td>");
                    mailBody.Append("<td style='font-size:11px; width: 165px; text-align: center; border-bottom: 1px solid #6c217f;'>");
                    mailBody.Append(userData.Simbolo);
                    mailBody.Append(string.Format("{0:#,##0}", pedidoDetalle.ImporteTotal).Replace(',', '.'));
                    mailBody.Append("</td>");
                }
                else
                {
                    mailBody.Append("<td style='font-size:11px; width: 182px; text-align: center; border-bottom: 1px solid #6c217f;'>");
                    mailBody.Append(userData.Simbolo);
                    mailBody.AppendFormat("{0:#0.00}", pedidoDetalle.PrecioUnidad);
                    mailBody.Append("</td>");
                    mailBody.Append("<td style='font-size:11px; width: 165px; text-align: center; border-bottom: 1px solid #6c217f;'>");
                    mailBody.Append(userData.Simbolo);
                    mailBody.AppendFormat("{0:#0.00}", pedidoDetalle.ImporteTotal);
                    mailBody.Append("</td>");
                }
                mailBody.Append("<td style='font-size:11px; width: 165px; text-align: center; border-bottom: 1px solid #6c217f;border-right: 1px solid #6c217f;'>");
                mailBody.AppendFormat("{0}</td>", pedidoDetalle.Nombre);
            }
            mailBody.Append("</tr></table><br />");
            mailBody.Append("<table border='0' cellspacing='0' cellpadding='0' style='width: 100%;'>");
            mailBody.Append("<tr><td><div style='font-size:12px;'></div></td></tr>");
            mailBody.Append("<tr><td><div style='font-size:12px;'>Gracias,</div><tr><td><tr><td><div style='font-size:12px;'>Equipo Belcorp.</div></tr></td>");
            mailBody.Append("</table>");

            bool resultado;
            try
            {
                resultado = Util.EnviarMailMobile("no-responder@somosbelcorp.com", userData.EMail, string.Format("({0}) Confirmación pedido Belcorp", userData.CodigoISO), mailBody.ToString(), true, null);
            }
            catch (Exception ex)
            {
                resultado = false;
            }

            return resultado;
        }

        #endregion

        #endregion
    }
}
