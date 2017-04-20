using AutoMapper;
using Portal.Consultoras.Common;
using Portal.Consultoras.Web.Controllers;
using Portal.Consultoras.Web.Models;
using Portal.Consultoras.Web.ServicePedido;
using System;
using System.Collections.Generic;
using System.Linq;
using System.ServiceModel;
using System.Web.Mvc;
using Portal.Consultoras.Web.ServicePROLConsultas;
using System.Configuration;
using Portal.Consultoras.Web.ServiceSAC;

namespace Portal.Consultoras.Web.Areas.Mobile.Controllers
{
    public class ShowRoomController : BaseShowRoomController
    {
        #region Variables

        private const string keyFechaGetCantidadProductos = "fechaGetCantidadProductos";
        private const string keyCantidadGetCantidadProductos = "cantidadGetCantidadProductos";

        private static readonly string CodigoProceso = ConfigurationManager.AppSettings["EmailCodigoProceso"];
        private int OfertaID = 0;
        private bool blnRecibido = false;
        #endregion

        public ActionResult Index(string query)
        {

            ActionExecutingMobile();
            var showRoomEventoModel = OfertaShowRoom();
            
            if (query != null)
            {
                string param = Util.DesencriptarQueryString(query);
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
                ? (ActionResult) RedirectToAction("Index", "Bienvenida", new {area = "Mobile"})
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
                var listaShowRoomOferta = new List<BEShowRoomOferta>();
                var carpetaPais = Globals.UrlMatriz + "/" + userData.CodigoISO;
                using (PedidoServiceClient sv = new PedidoServiceClient())
                {
                    listaShowRoomOferta = sv.GetShowRoomOfertasConsultora(userData.PaisID, userData.CampaniaID, userData.CodigoConsultora).ToList();
                }

                if (!listaShowRoomOferta.Any())
                {
                    return RedirectToAction("Index", "Bienvenida", new { area = "Mobile" });
                }

                listaShowRoomOferta.Update(x => x.ImagenProducto = string.IsNullOrEmpty(x.ImagenProducto)
                                ? "" : ConfigS3.GetUrlFileS3(carpetaPais, x.ImagenProducto, Globals.UrlMatriz + "/" + userData.CodigoISO));
                listaShowRoomOferta.Update(x => x.ImagenMini = string.IsNullOrEmpty(x.ImagenMini)
                                ? "" : ConfigS3.GetUrlFileS3(carpetaPais, x.ImagenMini, Globals.UrlMatriz + "/" + userData.CodigoISO));

                var listaShowRoomOfertaModel = Mapper.Map<List<BEShowRoomOferta>, List<ShowRoomOfertaModel>>(listaShowRoomOferta);

                var model = listaShowRoomOfertaModel.FirstOrDefault();
                model.Simbolo = userData.Simbolo;

                ShowRoomBannerLateralModel showRoomBannerLateral = GetShowRoomBannerLateral();
                
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
                model.EMail = eventoConsultora.CorreoEnvioAviso == "" ? userData.EMail : eventoConsultora.CorreoEnvioAviso;
                model.EMailActivo = eventoConsultora.CorreoEnvioAviso == userData.EMail ? userData.EMailActivo : true;
                model.Celular = userData.Celular;
                model.Suscripcion = eventoConsultora.Suscripcion;
                model.UrlTerminosCondiciones = ObtenerValorPersonalizacionShowRoom(Constantes.ShowRoomPersonalizacion.Desktop.UrlTerminosCondiciones, Constantes.ShowRoomPersonalizacion.TipoAplicacion.Mobile);
                var pedidoDetalle = ObtenerPedidoWebDetalle();
                model.Agregado = pedidoDetalle.Any(d=>d.CUV == model.CUV) ? "block" : "none";

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
                ? (ActionResult) RedirectToAction("Index", "Bienvenida", new {area = "Mobile"})
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

                var terminosCondiciones = userData.ListaShowRoomPersonalizacionConsultora.FirstOrDefault(
                        p => p.Atributo == Constantes.ShowRoomPersonalizacion.Mobile.UrlTerminosCondiciones);
                showRoomEventoModel.UrlTerminosCondiciones = terminosCondiciones == null
                    ? ""
                    : terminosCondiciones.Valor;

                using (SACServiceClient svc = new SACServiceClient())
                {
                    showRoomEventoModel.FiltersBySorting = svc.GetTablaLogicaDatos(userData.PaisID, 99).ToList();
                }

                ViewBag.PrecioMin = showRoomEventoModel.ListaShowRoomOferta.Min(p => p.PrecioCatalogo);
                ViewBag.PrecioMax = showRoomEventoModel.ListaShowRoomOferta.Max(p => p.PrecioCatalogo);
                ViewBag.BannerImagenVenta = ObtenerValorPersonalizacionShowRoom(Constantes.ShowRoomPersonalizacion.Mobile.BannerImagenVenta, Constantes.ShowRoomPersonalizacion.TipoAplicacion.Mobile);

                return showRoomEventoModel;                
            }
            catch (FaultException ex)
            {
                LogManager.LogManager.LogErrorWebServicesPortal(ex, userData.CodigoConsultora, userData.CodigoISO);
            }

            return null;
        }
        
        public ActionResult DetalleOfertaCUV(string query)
        {
            if (query != null)
            {
                string param = Util.DesencriptarQueryString(query);
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

                    if (Convert.ToInt32(lista[3]) == userData.CampaniaID && blnRecibido == false)
                    {
                        var intID = lista[5] != null ? Convert.ToInt32(lista[5]) : 0;

                        OfertaID = intID;

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
