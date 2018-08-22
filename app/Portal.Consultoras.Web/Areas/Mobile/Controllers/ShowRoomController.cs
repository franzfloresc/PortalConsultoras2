using Portal.Consultoras.Common;
using Portal.Consultoras.Web.Controllers;
using Portal.Consultoras.Web.Helpers;
using Portal.Consultoras.Web.Models;
using Portal.Consultoras.Web.Models.Estrategia.ShowRoom;
using System;
using System.Linq;
using System.ServiceModel;
using System.Web.Mvc;
using System.Web.Routing;

namespace Portal.Consultoras.Web.Areas.Mobile.Controllers
{
    public class ShowRoomController : BaseShowRoomController
    {
        public ShowRoomController() : base()
        {

        }

        /// <summary>
        /// Procesa la accion segun se determine si es Intriga o ShowRoom
        /// </summary>
        /// <returns></returns>
        public ActionResult Procesar()
        {
            var model = new ShowRoomBannerLateralModel();
            var zonaHoraria = 0d;
            var fechaInicioCampania = DateTime.Now.Date;

            if (userData != null)
            {
                model.BEShowRoom = configEstrategiaSR.BeShowRoom;
                zonaHoraria = userData.ZonaHoraria;
                fechaInicioCampania = userData.FechaInicioCampania;
            }

            var esShowRoom = false;

            if (model.BEShowRoom != null)
            {
                var fechaHoy = DateTime.Now.AddHours(zonaHoraria).Date;

                if ((fechaHoy >= fechaInicioCampania.AddDays(-model.BEShowRoom.DiasAntes).Date &&
                    fechaHoy <= fechaInicioCampania.AddDays(model.BEShowRoom.DiasDespues).Date))
                {
                    esShowRoom = OfertaShowRoom() != null;
                }
            }

            return esShowRoom ?
                RedirectToRoute("UniqueRoute",
                            new RouteValueDictionary(new
                            {
                                Controller = "ShowRoom",
                                Action = "Index",
                                guid = this.GetUniqueKey()
                            })) :
                RedirectToRoute("UniqueRoute",
                    new RouteValueDictionary(new
                    {
                        Controller = "ShowRoom",
                        Action = "Intriga",
                        guid = this.GetUniqueKey()
                    }));
        }

        public ActionResult Index(string query)
        {
            var mostrarShowRoomProductos = sessionManager.GetMostrarShowRoomProductos();
            var mostrarShowRoomProductosExpiro = sessionManager.GetMostrarShowRoomProductosExpiro();
            var mostrarPopupIntriga = !mostrarShowRoomProductos && !mostrarShowRoomProductosExpiro;

            if (mostrarPopupIntriga) return RedirectToAction("Intriga", "ShowRoom", new { area = "Mobile" });

            ActionExecutingMobile();

            var showRoomEventoModel = OfertaShowRoom();

            var dato = _ofertasViewProvider.ObtenerPerdioTitulo(userData.CampaniaID, IsMobile());
            showRoomEventoModel.ProductosPerdio = dato.Estado;
            showRoomEventoModel.PerdioTitulo = dato.Valor1;
            showRoomEventoModel.PerdioSubTitulo = dato.Valor2;
            showRoomEventoModel.MensajeProductoBloqueado = _ofertasViewProvider.MensajeProductoBloqueado(IsMobile());

            if (!string.IsNullOrEmpty(query))
            {
                var srQsv = new ShowRoomQueryStringValidator(query);

                if (srQsv.CodigoConsultora != userData.CodigoConsultora && srQsv.CodigoIso != userData.CodigoISO ||
                    srQsv.CodigoProceso != CodigoProceso)
                {
                    RedirectToAction("Index", "Bienvenida", new { area = "Mobile" });
                }

                if (srQsv.CampanaId == userData.CampaniaID && !_showRoomProvider.GetEventoConsultoraRecibido(userData))
                {
                    _showRoomProvider.UpdShowRoomEventoConsultoraEmailRecibido(srQsv.CodigoConsultora, srQsv.CampanaId, userData);
                }
            }

            return View(showRoomEventoModel);
        }

        public ActionResult Intriga()
        {
            try
            {
                return RedirectToAction("Index", "Ofertas", new { area = "Mobile" });

                //if (!ValidarIngresoShowRoom(true))
                //{
                //    return RedirectToAction("Index", "Bienvenida", new { area = "Mobile" });
                //}
                //ActionExecutingMobile();

                //var model = ObtenerPrimeraOfertaShowRoom();

                //if (model == null)
                //{
                //    return RedirectToAction("Index", "Bienvenida", new { area = "Mobile" });
                //}

                ////model.Simbolo = userData.Simbolo;
                ////model.CodigoISO = userData.CodigoISO;

                //var showRoomBannerLateral = _showRoomProvider.GetShowRoomBannerLateral(userData.CodigoISO, userData.ZonaHoraria, userData.FechaInicioCampania);
                //ViewBag.ImagenBannerShowroomIntriga = showRoomBannerLateral.ImagenBannerShowroomIntriga;
                //ViewBag.EstadoActivo = showRoomBannerLateral.EstadoActivo;

                //var eventoConsultora = configEstrategiaSR.BeShowRoomConsultora ?? new ShowRoomEventoConsultoraModel();
                //eventoConsultora.CorreoEnvioAviso = Util.Trim(eventoConsultora.CorreoEnvioAviso);

                ////model.Suscripcion = eventoConsultora.Suscripcion;
                ////model.EMail = eventoConsultora.CorreoEnvioAviso == "" ? userData.EMail : eventoConsultora.CorreoEnvioAviso;
                ////model.EMailActivo = (eventoConsultora.CorreoEnvioAviso != userData.EMail) || userData.EMailActivo;
                ////model.Celular = userData.Celular;
                ////model.UrlTerminosCondiciones = ObtenerValorPersonalizacionShowRoom(Constantes.ShowRoomPersonalizacion.Desktop.UrlTerminosCondiciones, Constantes.ShowRoomPersonalizacion.TipoAplicacion.Mobile);
                ////model.Agregado = ObtenerPedidoWebDetalle().Any(d => d.CUV == model.CUV) ? "block" : "none";

                //return View(model);
            }
            catch (FaultException ex)
            {
                LogManager.LogManager.LogErrorWebServicesPortal(ex, userData.CodigoConsultora, userData.CodigoISO);
            }

            return RedirectToAction("Index", "Bienvenida", new { area = "Mobile" });
        }

        public ActionResult DetalleOferta(int id)
        {
            ActionExecutingMobile();

            if (!ValidarIngresoShowRoom(false)) return RedirectToAction("Index", "Bienvenida");

            var modelo = ViewDetalleOferta(id);
            
            ViewBag.ImagenFondoProductPage = _showRoomProvider.ObtenerValorPersonalizacionShowRoom(Constantes.ShowRoomPersonalizacion.Mobile.ImagenFondoProductPage, Constantes.ShowRoomPersonalizacion.TipoAplicacion.Mobile);

            return View("DetalleOferta", modelo);
        }

        #region Metodos Privados

        private ShowRoomEventoModel OfertaShowRoom()
        {
            if (!ValidarIngresoShowRoom(false))
            {
                return null;
            }

            try
            {
                var showRoomEventoModel = CargarValoresModel();

                if (configEstrategiaSR.ListaPersonalizacionConsultora != null)
                {
                    var terminosCondiciones = configEstrategiaSR.ListaPersonalizacionConsultora.FirstOrDefault(
                        p => p.Atributo == Constantes.ShowRoomPersonalizacion.Mobile.UrlTerminosCondiciones);
                    showRoomEventoModel.UrlTerminosCondiciones = terminosCondiciones == null ? "" : terminosCondiciones.Valor;
                }
                
                return showRoomEventoModel;
            }
            catch (Exception ex)
            {
                LogManager.LogManager.LogErrorWebServicesBus(ex, userData.CodigoConsultora, userData.CodigoISO);
            }

            return null;
        }

        #endregion
    }
}
