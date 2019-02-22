using AutoMapper;
using Portal.Consultoras.Common;
using Portal.Consultoras.Web.Models;
using Portal.Consultoras.Web.ServiceCDR;
using Portal.Consultoras.Web.Areas.Mobile.Models;
using Portal.Consultoras.Web.CustomHelpers;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web.Mvc;
using Portal.Consultoras.Web.Providers;
using Portal.Consultoras.Web.ServiceSAC;

namespace Portal.Consultoras.Web.Areas.Mobile.Controllers
{
    public class MisReclamosController : BaseMobileController
    {
        readonly CdrProvider _cdrProvider;

        public MisReclamosController()
        {
            _cdrProvider = new CdrProvider();
        }

        public ActionResult Index()
        {
            if (userData.TieneCDR == 0)
                return RedirectToAction("Index", "Bienvenida", new { area = "Mobile" });

            MisReclamosModel model = new MisReclamosModel();
            List<CDRWebModel> listaCdrWebModel;
            var mobileConfiguracion = this.GetUniqueSession<MobileAppConfiguracionModel>("MobileAppConfiguracion");

            try
            {
                SessionManager.SetListaCDRWebCargaInicial(null);//HD-3412 EINCA
                SessionManager.SetCDRPedidoFacturado(null); //HD-3412 EINCA
                listaCdrWebModel = ObtenerCDRWebCargaInicial();//HD-3412 EINCA
                var ObtenerCampaniaPedidos = _cdrProvider.CDRObtenerPedidoFacturadoCargaInicial(userData.PaisID, userData.CampaniaID, userData.ConsultoraID);//HD-3412 EINCA

                string urlPoliticaCdr = _configuracionManagerProvider.GetConfiguracionManager(Constantes.ConfiguracionManager.UrlPoliticasCDR) ?? "{0}";
                model.UrlPoliticaCdr = string.Format(urlPoliticaCdr, userData.CodigoISO);
                model.ListaCDRWeb = listaCdrWebModel.FindAll(p => p.CantidadDetalle > 0);
                model.CantidadReclamosPorPedido = GetNroSolicitudesReclamoPorPedido();

                if (listaCdrWebModel.Any())
                {
                    var resultado = ValidarCantidadSolicitudesPerPedido(model.ListaCDRWeb, ObtenerCampaniaPedidos, model.CantidadReclamosPorPedido);
                    if (resultado)
                    {
                        model.MensajeGestionCdrInhabilitada = Constantes.CdrWebMensajes.ExcedioLimiteReclamo;
                        return View(model);
                    }
                }
                model.MensajeGestionCdrInhabilitada = _cdrProvider.MensajeGestionCdrInhabilitadaYChatEnLinea(userData.EsCDRWebZonaValida, userData.IndicadorBloqueoCDR, userData.FechaInicioCampania, userData.ZonaHoraria, userData.PaisID, userData.CampaniaID, userData.ConsultoraID, mobileConfiguracion.EsAppMobile);
                if (!string.IsNullOrEmpty(model.MensajeGestionCdrInhabilitada)) return View(model);
                if (model.ListaCDRWeb.Count == 0) return RedirectToAction("Reclamo");
            }
            catch (Exception ex)
            {
                LogManager.LogManager.LogErrorWebServicesBus(ex, userData.CodigoConsultora, userData.CodigoISO);
                listaCdrWebModel = new List<CDRWebModel>();
            }

           
            return View(model);
        }

        //HD-3412 EINCA
        private List<CDRWebModel> ObtenerCDRWebCargaInicial()
        {
            if (SessionManager.GetListaCDRWebCargaInicial() != null)
            {
                return SessionManager.GetListaCDRWebCargaInicial();
            }

            List<CDRWebModel> listaCdrWebModel;
            using (CDRServiceClient cdr = new CDRServiceClient())
            {
                var beCdrWeb = new ServiceCDR.BECDRWeb { ConsultoraID = userData.ConsultoraID }; //HD-3412 EINCA

                var listaReclamo = cdr.GetCDRWebMobile(userData.PaisID, beCdrWeb).ToList();

                listaCdrWebModel = Mapper.Map<List<ServiceCDR.BECDRWeb>, List<CDRWebModel>>(listaReclamo);
            }


            SessionManager.SetListaCDRWebCargaInicial(listaCdrWebModel);
            return listaCdrWebModel;
        }

        //HD-3412 EINCA
        private bool ValidarCantidadSolicitudesPerPedido(List<CDRWebModel> ListaCDRWeb, List<ServicePedido.BEPedidoWeb> ListaCampaniaPedido, int? CantidadPedidosConfig)
        {
            bool result = true;

            int[] arrEstadosConteo = { Constantes.EstadoCDRWeb.Enviado, Constantes.EstadoCDRWeb.Aceptado };

            //Obtenemos el nro pedidos campania
            var listaCampaniaPedido = ListaCampaniaPedido.GroupBy(a => new { a.PedidoID, a.CampaniaID })
                .Select(b => new PedidosEstadoCDRWeb { CampaniaID = b.Key.CampaniaID, PedidoID = b.Key.PedidoID, Cantidad = 0 })
                .OrderByDescending(c => c.CampaniaID).ToList();

            //Si no hay PedidoCDR
            if (!listaCampaniaPedido.Any()) { result = false; return result; }

            //Obtenemos el nro de PedidosCDRWeb que contabilizan
            var pedidoscdrestados = ListaCDRWeb.Where(a => arrEstadosConteo.Contains(a.Estado))
                .GroupBy(a => new { a.CampaniaID, a.PedidoID })
                .Select(a => new PedidosEstadoCDRWeb
                {
                    CampaniaID = a.Key.CampaniaID,
                    PedidoID = a.Key.PedidoID,
                    Cantidad = a.Count()
                }).ToList();

            //Resultado final calculando la cantidad de todos las Solicitudes por pedido CDR
            var final = (from c in listaCampaniaPedido
                         join a in pedidoscdrestados on new { c.CampaniaID, c.PedidoID }
                         equals new { a.CampaniaID, a.PedidoID } into g
                         from d in g.DefaultIfEmpty()
                         select new PedidosEstadoCDRWeb
                         {
                             CampaniaID = c.CampaniaID,
                             PedidoID = c.PedidoID,
                             Cantidad = (d == null || d.Cantidad == null) ? 0 : d.Cantidad
                         }).ToList();

            if (final != null)
            {
                foreach (var item in final)
                    if (item.Cantidad < CantidadPedidosConfig) { result = false; break; }
            }
            return result;
        }
        //HD-3412 EINCA
        public class PedidosEstadoCDRWeb
        {
            public int CampaniaID { get; set; }
            public int PedidoID { get; set; }
            public int? Cantidad { get; set; }
        }


        public ActionResult Reclamo(int p = 0, int c = 0)
        {
            var mobileConfiguracion = this.GetUniqueSession<MobileAppConfiguracionModel>("MobileAppConfiguracion");
            var model = new MisReclamosModel
            {
                PedidoID = p,
                MensajeGestionCdrInhabilitada = _cdrProvider.MensajeGestionCdrInhabilitadaYChatEnLinea(userData.EsCDRWebZonaValida, userData.IndicadorBloqueoCDR, userData.FechaInicioCampania, userData.ZonaHoraria, userData.PaisID, userData.CampaniaID, userData.ConsultoraID, mobileConfiguracion.EsAppMobile)
            };
            if (p == 0 && !string.IsNullOrEmpty(model.MensajeGestionCdrInhabilitada)) return RedirectToAction("Index", "MisReclamos", new { area = "Mobile" });

            _cdrProvider.CargarInformacion(userData.PaisID, userData.CampaniaID, userData.ConsultoraID);
            model.ListaCampania = SessionManager.GetCDRCampanias();
            model.CantidadReclamosPorPedido = SessionManager.GetNroPedidosCDRConfig();

            if (model.ListaCampania.Count <= 1) return RedirectToAction("Index", "MisReclamos", new { area = "Mobile" });

            if (p != 0)
            {
                var listaCdr = _cdrProvider.CargarBECDRWeb(new MisReclamosModel { PedidoID = p }, userData.PaisID, userData.ConsultoraID);
                if (listaCdr.Count == 0) return RedirectToAction("Index", "MisReclamos", new { area = "Mobile" });
                //HD-3412 EINCA 
                var listacdrweb = listaCdr.Where(a => a.CDRWebID == c).ToArray();
                if (listacdrweb.Count() == 1)
                {
                    model.CampaniaID = listacdrweb[0].CampaniaID;
                    model.CDRWebID = listacdrweb[0].CDRWebID;
                    model.NumeroPedido = listacdrweb[0].PedidoNumero;
                }
            }

            string urlPoliticaCdr = _configuracionManagerProvider.GetConfiguracionManager(Constantes.ConfiguracionManager.UrlPoliticasCDR) ?? "{0}";
            model.UrlPoliticaCdr = string.Format(urlPoliticaCdr, userData.CodigoISO);
            model.Email = userData.EMail;
            model.Telefono = userData.Celular;
            model.MontoMinimo = userData.MontoMinimo;

            model.TieneCDRExpress = userData.TieneCDRExpress;
            model.EsConsultoraNueva = userData.EsConsecutivoNueva;
            model.FleteDespacho = GetValorFleteExpress();
            model.MensajesExpress = new MensajesCDRExpressModel
            {
                RegularPrincipal = GetMensajeCDRExpress(Constantes.MensajesCDRExpress.RegularPrincipal),
                RegularAdicional = GetMensajeCDRExpress(Constantes.MensajesCDRExpress.RegularAdicional),
                ExpressPrincipal = GetMensajeCDRExpress(Constantes.MensajesCDRExpress.ExpressPrincipal),
                ExpressAdicional = GetMensajeCDRExpress(Constantes.MensajesCDRExpress.ExpressAdicional),
                Nuevas = GetMensajeCDRExpress(Constantes.MensajesCDRExpress.Nuevas),
                ExpressFlete = SetMensajeFleteExpress(model.FleteDespacho)
            };


            int limiteMinimoTelef, limiteMaximoTelef;
            Util.GetLimitNumberPhone(userData.PaisID, out limiteMinimoTelef, out limiteMaximoTelef);
            model.limiteMinimoTelef = limiteMinimoTelef;
            model.limiteMaximoTelef = limiteMaximoTelef;

            return View(model);
        }

        public ActionResult DetalleCDRCulminado(long SolicitudId)
        {

            BECDRWeb cdrWeb;
            List<BECDRWebDetalle> listaCdrWebDetalle;
            using (CDRServiceClient sv = new CDRServiceClient())
            {
                cdrWeb = sv.GetCDRWebByLogCDRWebCulminadoId(userData.PaisID, SolicitudId);

                listaCdrWebDetalle = sv.GetCDRWebDetalleByLogCDRWebCulminadoId(userData.PaisID, SolicitudId).ToList();
                listaCdrWebDetalle.Update(p => p.Solicitud = _cdrProvider.ObtenerDescripcion(p.CodigoOperacion, Constantes.TipoMensajeCDR.Finalizado, userData.PaisID).Descripcion);
                listaCdrWebDetalle.Update(p => p.SolucionSolicitada = _cdrProvider.ObtenerDescripcion(p.CodigoOperacion, Constantes.TipoMensajeCDR.MensajeFinalizado, userData.PaisID).Descripcion);
            }

            var model = Mapper.Map<CDRWebModel>(cdrWeb);
            model.CodigoIso = userData.CodigoISO;
            model.NombreConsultora = userData.NombreConsultora;
            model.Simbolo = userData.Simbolo;
            model.ListaDetalle = listaCdrWebDetalle;
            model.OrigenCDRDetalle = "1";
            if (model.FechaCulminado.HasValue)
            {
                model.FormatoFechaCulminado = string.Format("{0}/{1}/{2}",
                model.FechaCulminado.Value.Day.ToString().PadLeft(2, '0'),
                model.FechaCulminado.Value.Month.ToString().PadLeft(2, '0'),
                model.FechaCulminado.Value.Year);
            }
            model.FormatoCampaniaID = string.Format("{0}-{1}",
            model.CampaniaID.ToString().Substring(0, 4),
            model.CampaniaID.ToString().Substring(4, 2));
            model.CantidadAprobados = listaCdrWebDetalle.Count(f => f.Estado == Constantes.EstadoCDRWeb.Aceptado);
            model.CantidadRechazados = listaCdrWebDetalle.Count(f => f.Estado == Constantes.EstadoCDRWeb.Observado);

            SessionManager.SetListaCDRDetalle(model);
            return RedirectToAction("Detalle", "MisReclamos", new { area = "Mobile" });
        }

        public ActionResult DetalleCDR(long solicitudId)
        {
            BELogCDRWeb logCdrWeb;
            List<BECDRWebDetalle> listaCdrWebDetalle;
            using (CDRServiceClient sv = new CDRServiceClient())
            {
                logCdrWeb = sv.GetLogCDRWebByLogCDRWebId(userData.PaisID, solicitudId);

                listaCdrWebDetalle = sv.GetCDRWebDetalleLog(userData.PaisID, logCdrWeb).ToList();
                listaCdrWebDetalle.Update(p => p.Solicitud = _cdrProvider.ObtenerDescripcion(p.CodigoOperacion, Constantes.TipoMensajeCDR.Finalizado, userData.PaisID).Descripcion);
                listaCdrWebDetalle.Update(p => p.SolucionSolicitada = _cdrProvider.ObtenerDescripcion(p.CodigoOperacion, Constantes.TipoMensajeCDR.MensajeFinalizado, userData.PaisID).Descripcion);
            }

            var model = Mapper.Map<CDRWebModel>(logCdrWeb);
            model.NombreConsultora = userData.NombreConsultora;
            model.CodigoIso = userData.CodigoISO;
            model.Simbolo = userData.Simbolo;
            model.ListaDetalle = listaCdrWebDetalle;
            model.OrigenCDRDetalle = "1";
            if (model.FechaCulminado.HasValue)
            {
                model.FormatoFechaCulminado = string.Format("{0}/{1}/{2}",
                model.FechaCulminado.Value.Day.ToString().PadLeft(2, '0'),
                model.FechaCulminado.Value.Month.ToString().PadLeft(2, '0'),
                model.FechaCulminado.Value.Year);
            }
            model.FormatoCampaniaID = string.Format("{0}-{1}",
            model.CampaniaID.ToString().Substring(0, 4),
            model.CampaniaID.ToString().Substring(4, 2));
            model.CantidadAprobados = listaCdrWebDetalle.Count(f => f.Estado == Constantes.EstadoCDRWeb.Aceptado);
            model.CantidadRechazados = listaCdrWebDetalle.Count(f => f.Estado == Constantes.EstadoCDRWeb.Observado);

            SessionManager.SetListaCDRDetalle(model);
            return RedirectToAction("Detalle", "MisReclamos", new { area = "Mobile" });
        }

        public ActionResult Detalle()
        {
            var objCdr = SessionManager.GetListaCDRDetalle();

            if (objCdr != null)
            {
                MisReclamosModel obj = new MisReclamosModel
                {
                    CDRWebID = objCdr.CDRWebID,
                    PedidoID = objCdr.PedidoID
                };

                SessionManager.SetCDRWebDetalle(null);
                objCdr.ListaDetalle = _cdrProvider.CargarDetalle(obj, userData.PaisID, userData.CodigoISO);

                ViewBag.Origen = objCdr.OrigenCDRDetalle;
                ViewBag.FormatoCampania = objCdr.FormatoCampaniaID;
                ViewBag.FormatoFechaCulminado = objCdr.FormatoFechaCulminado;

                string estadoAprobado = objCdr.CantidadAprobados == 1 ? objCdr.CantidadAprobados + " producto aprobado, " : objCdr.CantidadAprobados + " productos aprobados, ";
                string estadoRechazado = objCdr.CantidadRechazados == 1 ? objCdr.CantidadRechazados + " rechazado" : objCdr.CantidadRechazados + " rechazados";

                ViewBag.EstadoProductos = estadoAprobado + estadoRechazado;
                ViewBag.CDR_ID = objCdr.CDRWebID;
                ViewBag.ListaDetalle = objCdr.ListaDetalle;
            }

            return View();
        }

        public JsonResult ValidarCargaDetalle(CDRWebModel model)
        {
            try
            {
                if (model.OrigenCDRDetalle == "1")
                {
                    SessionManager.SetListaCDRDetalle(model);
                }
                return Json(new
                {
                    success = true,
                    message = "OK"
                }, JsonRequestBehavior.AllowGet);
            }
            catch (Exception ex)
            {
                return Json(new
                {
                    success = false,
                    message = "Error: " + ex.Message
                }, JsonRequestBehavior.AllowGet);
            }
        }

        public JsonResult BuscarMotivo(MisReclamosModel model)
        {
            var lista = _cdrProvider.CargarMotivo(model, userData.FechaActualPais.Date, userData.PaisID, userData.CampaniaID, userData.ConsultoraID);
            return Json(new
            {
                success = true,
                message = "",
                detalle = lista
            }, JsonRequestBehavior.AllowGet);
        }

        private decimal GetValorFleteExpress()
        {
            decimal costoFlete = 0;
            try
            {
                using (CDRServiceClient cdr = new CDRServiceClient())
                {
                    var flete = cdr.GetMontoFletePorZonaId(userData.PaisID, new BECDRWeb() { ZonaID = userData.ZonaID });
                    costoFlete = flete.FleteDespacho;
                }
            }
            catch (Exception ex)
            {
                LogManager.LogManager.LogErrorWebServicesBus(ex, userData.CodigoUsuario, userData.CodigoISO);
            }
            return costoFlete;
        }

        private List<BETablaLogicaDatos> GetListMensajeCDRExpress()
        {
            if (SessionManager.GetCDRExpressMensajes() != null)
            {
                return SessionManager.GetCDRExpressMensajes();
            }

            var listMensaje = new List<BETablaLogicaDatos>();
            try
            {
                using (SACServiceClient sv = new SACServiceClient())
                {
                    listMensaje = sv.GetTablaLogicaDatos(userData.PaisID, Constantes.TablaLogica.CDRExpress).ToList();
                }
            }
            catch (Exception ex)
            {
                LogManager.LogManager.LogErrorWebServicesBus(ex, userData.CodigoConsultora, userData.CodigoISO);
            }
            SessionManager.SetCDRExpressMensajes(listMensaje);
            return listMensaje;
        }

        private string GetMensajeCDRExpress(string key)
        {
            var listMensaje = GetListMensajeCDRExpress();
            var item = listMensaje.FirstOrDefault(i => i.Codigo == key);
            return (item ?? new BETablaLogicaDatos()).Descripcion;
        }

        private string SetMensajeFleteExpress(decimal flete)
        {
            if (flete <= 0) return GetMensajeCDRExpress(Constantes.MensajesCDRExpress.ExpressFleteCero);

            var textoFlete = GetMensajeCDRExpress(Constantes.MensajesCDRExpress.ExpressFlete);
            return string.Format(textoFlete, userData.Simbolo, Util.DecimalToStringFormat(flete, userData.CodigoISO));
        }

        private int? GetNroSolicitudesReclamoPorPedido()
        {
            int result = 0;

            try
            {
                if (SessionManager.GetNroPedidosCDRConfig() != null)
                {
                    return SessionManager.GetNroPedidosCDRConfig();
                }

                using (var sv = new SACServiceClient())
                {
                    var serviceResult = sv.GetTablaLogicaDatos(userData.PaisID, Constantes.TablaLogica.NroReclamosPorPedidoCDR).ToList();
                    var cantidad = serviceResult.Where(a => a.Codigo == "01").FirstOrDefault().Valor;
                    int.TryParse(cantidad, out result);
                }
            }
            catch (Exception ex)
            {
                LogManager.LogManager.LogErrorWebServicesBus(ex, userData.CodigoConsultora, userData.CodigoISO);
            }
            SessionManager.SetNroPedidosCDRConfig(result);
            return result;
        }
    }
}