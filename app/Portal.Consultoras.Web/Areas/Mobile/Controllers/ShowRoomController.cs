using Portal.Consultoras.Common;
using Portal.Consultoras.Web.Controllers;
using Portal.Consultoras.Web.Helpers;
using Portal.Consultoras.Web.Models;
using Portal.Consultoras.Web.ServicePedido;
using Portal.Consultoras.Web.ServiceSAC;
using System;
using System.Collections.Generic;
using System.Configuration;
using System.Linq;
using System.ServiceModel;
using System.Web.Mvc;
using System.Web.Routing;

namespace Portal.Consultoras.Web.Areas.Mobile.Controllers
{
    public class ShowRoomController : BaseShowRoomController
    {
        #region Variables

        private const string keyFechaGetCantidadProductos = "fechaGetCantidadProductos";
        private const string keyCantidadGetCantidadProductos = "cantidadGetCantidadProductos";

        private static readonly string CodigoProceso = ConfigurationManager.AppSettings[Constantes.ConfiguracionManager.EmailCodigoProceso];
        private int OfertaID = 0;
        private bool blnRecibido = false;
        #endregion

        /// <summary>
        /// Procesa la accion segun se determine si es Intriga o ShowRoom
        /// </summary>
        /// <returns></returns>
        public ActionResult Procesar()
        {
            var userData = sessionManager.GetUserData();
            if (userData != null)
                CargarEntidadesShowRoom(userData);

            var esShowRoom = false;

            ShowRoomBannerLateralModel model = new ShowRoomBannerLateralModel();
            model.BEShowRoom = userData.BeShowRoom;

            if (model.BEShowRoom == null)
            {
                model.BEShowRoom = new BEShowRoomEvento();
            }

            var fechaHoy = DateTime.Now.AddHours(userData.ZonaHoraria).Date;

            if ((fechaHoy >= userData.FechaInicioCampania.AddDays(-model.BEShowRoom.DiasAntes).Date &&
                fechaHoy <= userData.FechaInicioCampania.AddDays(model.BEShowRoom.DiasDespues).Date))
            {
                esShowRoom = true && OfertaShowRoom() != null;
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

            bool mostrarPopupIntriga = !mostrarShowRoomProductos && !mostrarShowRoomProductosExpiro;

            if (mostrarPopupIntriga)
            {
                return RedirectToAction("Intriga", "ShowRoom", new { area = "Mobile" });
            }

            ActionExecutingMobile();
            var showRoomEventoModel = OfertaShowRoom();

            //if (query != null)
            if(!string.IsNullOrEmpty(query))
            {
                string param = Util.Decrypt(query);
                string[] lista = param.Split(new char[] { ';' });

                if (lista[2] != userData.CodigoConsultora && lista[1] != userData.CodigoISO)
                {
                    RedirectToAction("Index", "Bienvenida", new { area = "Mobile" });
                }

                if (lista[0] == CodigoProceso)
                {
                    using (PedidoServiceClient sv = new PedidoServiceClient())
                    {
                        blnRecibido = Convert.ToBoolean(sv.GetEventoConsultoraRecibido(userData.PaisID, userData.CodigoConsultora, userData.CampaniaID));
                    }

                    if (Convert.ToInt32(lista[3]) == userData.CampaniaID && blnRecibido == false)
                    {
                        BEShowRoomEventoConsultora Entidad = new BEShowRoomEventoConsultora();

                        Entidad.CodigoConsultora = lista[2];
                        Entidad.CampaniaID = Convert.ToInt32(lista[3]);

                        using (PedidoServiceClient sv = new PedidoServiceClient())
                        {
                            sv.UpdShowRoomEventoConsultoraEmailRecibido(userData.PaisID, Entidad);
                        }
                    }
                }
                else
                {
                    RedirectToAction("Index", "Bienvenida", new { area = "Mobile" });
                }
            }

            return showRoomEventoModel == null
                ? (ActionResult)RedirectToAction("Index", "Bienvenida", new { area = "Mobile" })
                : View(showRoomEventoModel);
        }

        public ActionResult Intriga()
        {
            try
            {
                if (!ValidarIngresoShowRoom(true))
                {
                    return RedirectToAction("Index", "Bienvenida", new { area = "Mobile" });
                }
                ActionExecutingMobile();

                var ofertasShowRoom = ObtenerOfertasShowRoom();

                if (!ofertasShowRoom.Any())
                {
                    return RedirectToAction("Index", "Bienvenida", new { area = "Mobile" });
                }

                ActualizarUrlImagenes(ofertasShowRoom);

                var model = ObtenerPrimeraOfertaShowRoom(ofertasShowRoom);

                model.Simbolo = userData.Simbolo;
                model.CodigoISO = userData.CodigoISO;

                var showRoomBannerLateral = GetShowRoomBannerLateral();

                if (showRoomBannerLateral.DiasFaltantes > 1)
                {
                    showRoomBannerLateral.LetrasDias = "FALTAN " + Convert.ToInt32(showRoomBannerLateral.DiasFaltantes).ToString() + " DÍAS";
                }
                else { showRoomBannerLateral.LetrasDias = "FALTA " + Convert.ToInt32(showRoomBannerLateral.DiasFaltantes).ToString() + " DÍA"; }

                ViewBag.LetrasDias = showRoomBannerLateral.LetrasDias;
                ViewBag.ImagenBannerShowroomIntriga = showRoomBannerLateral.ImagenBannerShowroomIntriga;
                ViewBag.EstadoActivo = showRoomBannerLateral.EstadoActivo;

                var eventoConsultora = userData.BeShowRoomConsultora ?? new BEShowRoomEventoConsultora();
                eventoConsultora.CorreoEnvioAviso = Util.Trim(eventoConsultora.CorreoEnvioAviso);

                model.Suscripcion = eventoConsultora.Suscripcion;
                model.EMail = eventoConsultora.CorreoEnvioAviso == "" ? userData.EMail : eventoConsultora.CorreoEnvioAviso;
                model.EMailActivo = eventoConsultora.CorreoEnvioAviso == userData.EMail ? userData.EMailActivo : true;
                model.Celular = userData.Celular;
                model.UrlTerminosCondiciones = ObtenerValorPersonalizacionShowRoom(Constantes.ShowRoomPersonalizacion.Desktop.UrlTerminosCondiciones, Constantes.ShowRoomPersonalizacion.TipoAplicacion.Mobile);
                model.Agregado = ObtenerPedidoWebDetalle().Any(d => d.CUV == model.CUV) ? "block" : "none";

                return View(model);
            }
            catch (FaultException ex)
            {
                LogManager.LogManager.LogErrorWebServicesPortal(ex, userData.CodigoConsultora, userData.CodigoISO);
            }

            return RedirectToAction("Index", "Bienvenida", new { area = "Mobile" });
        }

        public ActionResult ListadoProductoShowRoom(int id = 0)
        {
            var showRoomEventoModel = OfertaShowRoom();
            if (showRoomEventoModel != null)
                showRoomEventoModel.PosicionCarrusel = id;

            return showRoomEventoModel == null
                ? (ActionResult)RedirectToAction("Index", "Bienvenida", new { area = "Mobile" })
                : View("ListadoProductoShowRoom", showRoomEventoModel);
        }

        private ShowRoomEventoModel OfertaShowRoom()
        {
            Session[keyFechaGetCantidadProductos] = null;
            Session[keyCantidadGetCantidadProductos] = null;

            if (!ValidarIngresoShowRoom(false))
            {
                return null;
            }

            try
            {
                var showRoomEventoModel = CargarValoresModel();
                showRoomEventoModel.ListaShowRoomOferta = showRoomEventoModel.ListaShowRoomOferta ?? new List<ShowRoomOfertaModel>();
                if (!showRoomEventoModel.ListaShowRoomOferta.Any())
                    return null;

                var terminosCondiciones = userData.ListaShowRoomPersonalizacionConsultora.FirstOrDefault(
                        p => p.Atributo == Constantes.ShowRoomPersonalizacion.Mobile.UrlTerminosCondiciones);
                showRoomEventoModel.UrlTerminosCondiciones = terminosCondiciones == null
                    ? ""
                    : terminosCondiciones.Valor;

                using (SACServiceClient svc = new SACServiceClient())
                {
                    showRoomEventoModel.FiltersBySorting = svc.GetTablaLogicaDatos(userData.PaisID, 99).ToList();
                }

                var xlistaShowRoom = showRoomEventoModel.ListaShowRoomOferta.Where(x => x.EsSubCampania == false).ToList();
                ViewBag.PrecioMin = xlistaShowRoom.Any() ? xlistaShowRoom.Min(p => p.PrecioOferta) : Convert.ToDecimal(0);
                ViewBag.PrecioMax = xlistaShowRoom.Any() ? xlistaShowRoom.Max(p => p.PrecioOferta) : Convert.ToDecimal(0);

                ViewBag.BannerImagenVenta = ObtenerValorPersonalizacionShowRoom(Constantes.ShowRoomPersonalizacion.Mobile.BannerImagenVenta, Constantes.ShowRoomPersonalizacion.TipoAplicacion.Mobile);

                return showRoomEventoModel;
            }
            catch (Exception ex)
            {
                LogManager.LogManager.LogErrorWebServicesBus(ex, userData.CodigoConsultora, userData.CodigoISO);
            }

            return null;
        }

        public ActionResult DetalleOfertaCUV(string query)
        {
            if (query != null)
            {
                string param = Util.Decrypt(query);
                string[] lista = param.Split(new char[] { ';' });

                if (lista[2] != userData.CodigoConsultora && lista[1] != userData.CodigoISO)
                {
                    return RedirectToAction("Index", "Bienvenida", new { area = "Mobile" });
                }

                if (lista[0] == CodigoProceso)
                {
                    using (PedidoServiceClient sv = new PedidoServiceClient())
                    {
                        blnRecibido = Convert.ToBoolean(sv.GetEventoConsultoraRecibido(userData.PaisID, userData.CodigoConsultora, userData.CampaniaID));
                    }

                    OfertaID = lista[5] != null ? Convert.ToInt32(lista[5]) : 0;

                    if (Convert.ToInt32(lista[3]) == userData.CampaniaID && blnRecibido == false)
                    {
                        BEShowRoomEventoConsultora Entidad = new BEShowRoomEventoConsultora();

                        Entidad.CodigoConsultora = lista[2];
                        Entidad.CampaniaID = Convert.ToInt32(lista[3]);

                        using (PedidoServiceClient sv = new PedidoServiceClient())
                        {
                            sv.UpdShowRoomEventoConsultoraEmailRecibido(userData.PaisID, Entidad);
                        }

                    }
                }
                else
                {
                    return RedirectToAction("Index", "Bienvenida", new { area = "Mobile" });
                }

            }

            return RedirectToAction("DetalleOferta", "ShowRoom", new { area = "Mobile", id = OfertaID });
        }

        public ActionResult DetalleOferta(int id)
        {
            ActionExecutingMobile();
            if (!ValidarIngresoShowRoom(false))
                return RedirectToAction("Index", "Bienvenida");

            var modelo = ViewDetalleOferta(id);

            var fechaHoy = DateTime.Now.AddHours(userData.ZonaHoraria).Date;
            bool esFacturacion = fechaHoy >= userData.FechaInicioCampania.Date;

            var listaCompraPorCompra = GetProductosCompraPorCompra(esFacturacion, userData.BeShowRoom.EventoID,
                        userData.BeShowRoom.CampaniaID);
            modelo.ListaShowRoomCompraPorCompra = listaCompraPorCompra;
            modelo.TieneCompraXcompra = userData.BeShowRoom.TieneCompraXcompra;

            ViewBag.ImagenFondoProductPage = ObtenerValorPersonalizacionShowRoom(Constantes.ShowRoomPersonalizacion.Mobile.ImagenFondoProductPage, Constantes.ShowRoomPersonalizacion.TipoAplicacion.Mobile);

            return View("DetalleOferta", modelo);
        }
    }
}
