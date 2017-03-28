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

        #endregion

        public ActionResult Index()
        {

            ActionExecutingMobile();

            var showRoomEventoModel = OfertaShowRoom();

            return showRoomEventoModel == null
                ? (ActionResult) RedirectToAction("Index", "Bienvenida", new {area = "Mobile"})
                : View(showRoomEventoModel);
        }

        public ActionResult Intriga()
        {
            if (ValidarIngresoShowRoom(true))
            {
                var userData = UserData();
                try
                {
                    var model = new ShowRoomOfertaModel();

                    var listaShowRoomOferta = new List<BEShowRoomOferta>();
                    var carpetaPais = Globals.UrlMatriz + "/" + UserData().CodigoISO;
                    using (PedidoServiceClient sv = new PedidoServiceClient())
                    {
                        listaShowRoomOferta = sv.GetShowRoomOfertasConsultora(userData.PaisID, userData.CampaniaID, userData.CodigoConsultora).ToList();
                    }

                    if (listaShowRoomOferta.Any())
                    {
                        listaShowRoomOferta.Update(x => x.ImagenProducto = string.IsNullOrEmpty(x.ImagenProducto)
                                        ? "" : ConfigS3.GetUrlFileS3(carpetaPais, x.ImagenProducto, Globals.UrlMatriz + "/" + userData.CodigoISO));
                        listaShowRoomOferta.Update(x => x.ImagenMini = string.IsNullOrEmpty(x.ImagenMini)
                                        ? "" : ConfigS3.GetUrlFileS3(carpetaPais, x.ImagenMini, Globals.UrlMatriz + "/" + userData.CodigoISO));

                        var listaShowRoomOfertaModel = Mapper.Map<List<BEShowRoomOferta>, List<ShowRoomOfertaModel>>(listaShowRoomOferta);

                        model = listaShowRoomOfertaModel.FirstOrDefault();

                        ViewBag.Descripcion = model.Descripcion;
                        ViewBag.ImagenProducto = model.ImagenProducto;
                        ViewBag.PrecioOferta = model.PrecioOferta;
                        ViewBag.PrecioCatalogo = model.PrecioCatalogo;
                        ViewBag.CUV = model.CUV;
                        ViewBag.CategoriaID = model.CategoriaID;
                        ViewBag.ConfiguracionOfertaID = model.ConfiguracionOfertaID;
                        ViewBag.DescripcionMarca = model.DescripcionMarca;
                        ViewBag.MarcaID = model.MarcaID;
                        ViewBag.CodigoCampania = model.CodigoCampania;
                        ViewBag.Simbolo = userData.Simbolo;

                        ShowRoomBannerLateralModel showRoomBannerLateral = GetShowRoomBannerLateral();

                        
                        if (showRoomBannerLateral.DiasFaltantes > 1)
                        {
                            showRoomBannerLateral.LetrasDias = "FALTAN " + Convert.ToInt32(showRoomBannerLateral.DiasFaltantes).ToString() + " DÍAS";
                        }
                        else { showRoomBannerLateral.LetrasDias = "FALTA " + Convert.ToInt32(showRoomBannerLateral.DiasFaltantes).ToString() + " DÍA"; }

                        ViewBag.LetrasDias = showRoomBannerLateral.LetrasDias;
                        ViewBag.ImagenBannerShowroomIntriga = showRoomBannerLateral.ImagenBannerShowroomIntriga;

                        ViewBag.EstadoActivo = showRoomBannerLateral.EstadoActivo;
                        var showRoomOfertaModel = model;

                    }

                    return model == null
                   ? (ActionResult)RedirectToAction("Index", "Bienvenida", new { area = "Mobile" })
                   : View(model);
                }
                catch (FaultException ex)
                {
                    LogManager.LogManager.LogErrorWebServicesPortal(ex, userData.CodigoConsultora, userData.CodigoISO);
                }
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

            var userData = UserData();

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

                return showRoomEventoModel;                
            }
            catch (FaultException ex)
            {
                LogManager.LogManager.LogErrorWebServicesPortal(ex, userData.CodigoConsultora, userData.CodigoISO);
            }

            return null;
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
