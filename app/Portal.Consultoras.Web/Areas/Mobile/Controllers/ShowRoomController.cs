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
            var model = new ShowRoomBannerLateralModel();
            var zonaHoraria = 0d;
            var fechaInicioCampania = DateTime.Now.Date;

            var userData = sessionManager.GetUserData();
            if (userData != null)
            {
                CargarEntidadesShowRoom(userData);

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
            bool mostrarPopupIntriga = !mostrarShowRoomProductos && !mostrarShowRoomProductosExpiro;

            if (mostrarPopupIntriga)
            {
                return RedirectToAction("Intriga", "ShowRoom", new { area = "Mobile" });
            }

            ActionExecutingMobile();
            var showRoomEventoModel = OfertaShowRoom();

            //24-may-2018 (JN)
            var dato = ObtenerPerdio(userData.CampaniaID);
            showRoomEventoModel.ProductosPerdio = dato.Estado;
            showRoomEventoModel.PerdioTitulo = dato.Valor1;
            showRoomEventoModel.PerdioSubTitulo = dato.Valor2;
            showRoomEventoModel.MensajeProductoBloqueado = MensajeProductoBloqueado();

            if (!string.IsNullOrEmpty(query))
            {
                string param = Util.Decrypt(query);
                string[] lista = param.Split(';');

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

                    if (Convert.ToInt32(lista[3]) == userData.CampaniaID && !blnRecibido)
                    {
                        BEShowRoomEventoConsultora entidad = new BEShowRoomEventoConsultora
                        {
                            CodigoConsultora = lista[2],
                            CampaniaID = Convert.ToInt32(lista[3])
                        };

                        using (PedidoServiceClient sv = new PedidoServiceClient())
                        {
                            sv.UpdShowRoomEventoConsultoraEmailRecibido(userData.PaisID, entidad);
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

        public ActionResult Personalizado(string query)
        {

            if (!(sessionManager.GetEsShowRoom() && userData.CodigoISO == Constantes.CodigosISOPais.Peru))
            {
                return RedirectToAction("Index");
            }

            var mostrarShowRoomProductos = sessionManager.GetMostrarShowRoomProductos();
            var mostrarShowRoomProductosExpiro = sessionManager.GetMostrarShowRoomProductosExpiro();

            bool mostrarPopupIntriga = !mostrarShowRoomProductos && !mostrarShowRoomProductosExpiro;

            if (mostrarPopupIntriga)
            {
                return RedirectToAction("Intriga", "ShowRoom", new { area = "Mobile" });
            }

            ActionExecutingMobile();
            var showRoomEventoModel = OfertaShowRoom();

            if (!string.IsNullOrEmpty(query))
            {
                string param = Util.Decrypt(query);
                string[] lista = param.Split(';');

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

                    if (Convert.ToInt32(lista[3]) == userData.CampaniaID && !blnRecibido)
                    {
                        BEShowRoomEventoConsultora entidad = new BEShowRoomEventoConsultora
                        {
                            CodigoConsultora = lista[2],
                            CampaniaID = Convert.ToInt32(lista[3])
                        };

                        using (PedidoServiceClient sv = new PedidoServiceClient())
                        {
                            sv.UpdShowRoomEventoConsultoraEmailRecibido(userData.PaisID, entidad);
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

                var eventoConsultora = configEstrategiaSR.BeShowRoomConsultora ?? new BEShowRoomEventoConsultora();
                eventoConsultora.CorreoEnvioAviso = Util.Trim(eventoConsultora.CorreoEnvioAviso);

                model.Suscripcion = eventoConsultora.Suscripcion;
                model.EMail = eventoConsultora.CorreoEnvioAviso == "" ? userData.EMail : eventoConsultora.CorreoEnvioAviso;
                model.EMailActivo = (eventoConsultora.CorreoEnvioAviso != userData.EMail) || userData.EMailActivo;
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

                if (configEstrategiaSR.ListaPersonalizacionConsultora != null)
                {
                    var terminosCondiciones = configEstrategiaSR.ListaPersonalizacionConsultora.FirstOrDefault(
                        p => p.Atributo == Constantes.ShowRoomPersonalizacion.Mobile.UrlTerminosCondiciones);
                    showRoomEventoModel.UrlTerminosCondiciones = terminosCondiciones == null
                        ? ""
                        : terminosCondiciones.Valor;
                }
                
                using (SACServiceClient svc = new SACServiceClient())
                {
                    showRoomEventoModel.FiltersBySorting = svc.GetTablaLogicaDatos(userData.PaisID, 99).ToList();
                }

                var xlistaShowRoom = showRoomEventoModel.ListaShowRoomOferta.Where(x => !x.EsSubCampania).ToList();
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
                string[] lista = param.Split(';');

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

                    if (Convert.ToInt32(lista[3]) == userData.CampaniaID && !blnRecibido)
                    {
                        BEShowRoomEventoConsultora entidad = new BEShowRoomEventoConsultora
                        {
                            CodigoConsultora = lista[2],
                            CampaniaID = Convert.ToInt32(lista[3])
                        };

                        using (PedidoServiceClient sv = new PedidoServiceClient())
                        {
                            sv.UpdShowRoomEventoConsultoraEmailRecibido(userData.PaisID, entidad);
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
            modelo.EstrategiaId = id;
            var xList = modelo.ListaOfertaShowRoom.Where(x => !x.EsSubCampania).ToList();
            modelo.ListaOfertaShowRoom = xList;
            bool esFacturacion = EsFacturacion();

            var listaCompraPorCompra = GetProductosCompraPorCompra(esFacturacion, configEstrategiaSR.BeShowRoom.EventoID,
                        configEstrategiaSR.BeShowRoom.CampaniaID);
            modelo.ListaShowRoomCompraPorCompra = listaCompraPorCompra;
            modelo.TieneCompraXcompra = configEstrategiaSR.BeShowRoom.TieneCompraXcompra;

            ViewBag.ImagenFondoProductPage = ObtenerValorPersonalizacionShowRoom(Constantes.ShowRoomPersonalizacion.Mobile.ImagenFondoProductPage, Constantes.ShowRoomPersonalizacion.TipoAplicacion.Mobile);

            return View("DetalleOferta", modelo);
        }

        public ActionResult DetalleOfertaPersonalizado(int id)
        {
            ActionExecutingMobile();
            if (!ValidarIngresoShowRoom(false))
                return RedirectToAction("Index", "Bienvenida");

            var modelo = ViewDetalleOferta(id);
            modelo.EstrategiaId = id;
            bool esFacturacion = EsFacturacion();

            var listaCompraPorCompra = GetProductosCompraPorCompra(esFacturacion, configEstrategiaSR.BeShowRoom.EventoID,
                        configEstrategiaSR.BeShowRoom.CampaniaID);
            modelo.ListaShowRoomCompraPorCompra = listaCompraPorCompra;
            modelo.TieneCompraXcompra = configEstrategiaSR.BeShowRoom.TieneCompraXcompra;

            ViewBag.ImagenFondoProductPage = ObtenerValorPersonalizacionShowRoom(Constantes.ShowRoomPersonalizacion.Mobile.ImagenFondoProductPage, Constantes.ShowRoomPersonalizacion.TipoAplicacion.Mobile);

            return View(modelo);
        }
    }
}
