using Portal.Consultoras.Common;
using Portal.Consultoras.Web.Controllers;
using Portal.Consultoras.Web.CustomFilters;
using Portal.Consultoras.Web.Helpers;
using Portal.Consultoras.Web.Infraestructure;
using Portal.Consultoras.Web.Models;
using Portal.Consultoras.Web.ServiceSAC;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using System.Web.Mvc;
using System.Web.Routing;

namespace Portal.Consultoras.Web.Areas.Mobile.Controllers
{
    [UniqueSession("UniqueRoute", UniqueRoute.IdentifierKey, "/g/")]
    [ClearSessionMobileApp(UniqueRoute.IdentifierKey, "MobileAppConfiguracion", "StartSession")]
    public class BaseMobileController : BaseController
    {
        public BaseMobileController():base()
        {
                
        }

        protected override void OnActionExecuting(ActionExecutingContext filterContext)
        {
            base.OnActionExecuting(filterContext);

            if (sessionManager.GetUserData() == null) return;

            if (Request.IsAjaxRequest())
            {
                return;
            }

            ViewBag.CodigoCampania = userData.CampaniaID.ToString();

            try
            {
                ViewBag.EsMobile = 2;
                BuildMenuMobile(userData, revistaDigital);
                CargarValoresGenerales(userData);

                bool mostrarBanner, permitirCerrarBanner = false;
                if (SiempreMostrarBannerPL20()) mostrarBanner = true;
                else if (NuncaMostrarBannerPL20()) mostrarBanner = false;
                else
                {
                    mostrarBanner = true;
                    permitirCerrarBanner = true;

                    if (userData.CloseBannerPL20) mostrarBanner = false;
                }

                bool mostrarBannerTop = !(NuncaMostrarBannerTopPL20() || userData.IndicadorGPRSB == 1);

                ViewBag.MostrarBannerTopPL20 = mostrarBannerTop;

                if (mostrarBanner || mostrarBannerTop)
                {
                    ViewBag.PermitirCerrarBannerPL20 = permitirCerrarBanner;
                    ShowRoomBannerLateralModel showRoomBannerLateral = GetShowRoomBannerLateral();
                    ViewBag.ShowRoomBannerLateral = showRoomBannerLateral;
                    ViewBag.MostrarShowRoomBannerLateral = sessionManager.GetEsShowRoom() &&
                        !showRoomBannerLateral.ConsultoraNoEncontrada && !showRoomBannerLateral.ConsultoraNoEncontrada &&
                        showRoomBannerLateral.BEShowRoomConsultora.EventoConsultoraID != 0 && showRoomBannerLateral.EstaActivoLateral;


                    ViewBag.ImagenPopupShowroomIntriga = showRoomBannerLateral.ImagenPopupShowroomIntriga;
                    ViewBag.ImagenBannerShowroomIntriga = showRoomBannerLateral.ImagenBannerShowroomIntriga;
                    ViewBag.ImagenPopupShowroomVenta = showRoomBannerLateral.ImagenPopupShowroomVenta;
                    ViewBag.ImagenBannerShowroomVenta = showRoomBannerLateral.ImagenBannerShowroomVenta;
                    ViewBag.DiasFaltantesLetras = showRoomBannerLateral.LetrasDias;

                    ViewBag.MostrarShowRoomProductos = showRoomBannerLateral.MostrarShowRoomProductos;

                    OfertaDelDiaModel ofertaDelDia = GetOfertaDelDiaModel();
                    ViewBag.OfertaDelDia = ofertaDelDia;

                    ViewBag.MostrarOfertaDelDia =
                            !(userData.IndicadorGPRSB == 1 || userData.CloseOfertaDelDia)
                            && userData.TieneOfertaDelDia
                            && ofertaDelDia != null
                            && ofertaDelDia.TeQuedan.TotalSeconds > 0;

                    showRoomBannerLateral.EstadoActivo = mostrarBannerTop ? "0" : "1";
                }

                ViewBag.MostrarBannerPL20 = mostrarBanner;
                ViewBag.MostrarBannerOtros = mostrarBannerTop;

                ViewBag.EstadoActivo = mostrarBannerTop ? "0" : "1";

                if (mostrarBanner
                    && !(
                            (!userData.ValidacionAbierta && userData.EstadoPedido == 202 && userData.IndicadorGPRSB == 2)
                            || userData.IndicadorGPRSB == 0
                        )
                )
                {
                    ViewBag.MostrarBannerPL20 = false;
                    ViewBag.MostrarOfertaDelDia = false;

                }

                ViewBag.MostrarODD = NoMostrarBannerODD();

                MostrarBannerApp();
            }
            catch (Exception ex)
            {
                LogManager.LogManager.LogErrorWebServicesBus(ex, userData.CodigoConsultora, userData.CodigoISO);
            }
        }

        public JsonResult GetOfertaDelDia()
        {
            try
            {
                var oddModel = GetOfertaDelDiaModel();
                return Json(new
                {
                    success = oddModel != null,
                    data = oddModel
                }, JsonRequestBehavior.AllowGet);
            }
            catch (Exception ex)
            {
                LogManager.LogManager.LogErrorWebServicesBus(ex, userData.CodigoConsultora, userData.CodigoISO);
                return Json(new
                {
                    success = false,
                    message = "No se pudo procesar la solicitud"
                }, JsonRequestBehavior.AllowGet);
            }
        }

        private void CargarValoresGenerales(UsuarioModel userData)
        {
            if (sessionManager.GetUserData() != null)
            {
                ViewBag.NombreConsultora = (string.IsNullOrEmpty(userData.Sobrenombre) ? userData.NombreConsultora : userData.Sobrenombre).ToUpper();
                int j = ViewBag.NombreConsultora.Trim().IndexOf(' ');
                if (j >= 0) ViewBag.NombreConsultora = ViewBag.NombreConsultora.Substring(0, j).Trim();

                ViewBag.NumeroCampania = (!string.IsNullOrEmpty(userData.NombreCorto) && userData.NombreCorto.Length > 4)
                    ? userData.NombreCorto.Substring(4) : "";
                ViewBag.EsUsuarioComunidad = userData.EsUsuarioComunidad ? 1 : 0;
                ViewBag.AnalyticsCampania = userData.CampaniaID;
                ViewBag.AnalyticsSegmento = string.IsNullOrEmpty(userData.Segmento) ? "(not available)" : userData.Segmento.Trim();
                ViewBag.AnalyticsEdad = Util.Edad(userData.FechaNacimiento);
                ViewBag.AnalyticsZona = userData.CodigoZona;
                ViewBag.AnalyticsPais = userData.CodigoISO;
                ViewBag.AnalyticsRol = "Consultora";
                ViewBag.AnalyticsRegion = userData.CodigorRegion;
                ViewBag.AnalyticsSeccion = string.IsNullOrEmpty(userData.SeccionAnalytics) ? "(not available)" : userData.SeccionAnalytics;
                ViewBag.AnalyticsCodigoConsultora = string.IsNullOrEmpty(userData.CodigoConsultora) ? "(not available)" : userData.CodigoConsultora;

                var fechaHoy = DateTime.Now.AddHours(userData.ZonaHoraria).Date;

                if (fechaHoy >= userData.FechaInicioCampania.Date && fechaHoy <= userData.FechaFinCampania.Date)
                    ViewBag.AnalyticsPeriodo = "Facturacion";
                else
                    ViewBag.AnalyticsPeriodo = "Venta";

                ViewBag.AnalyticsSegmentoConstancia = string.IsNullOrEmpty(userData.SegmentoConstancia) ? "(not available)" : userData.SegmentoConstancia.Trim();
                ViewBag.AnalyticsSociaNivel = string.IsNullOrEmpty(userData.DescripcionNivel) ? "(not available)" : userData.DescripcionNivel;
            }
        }

        private bool SiempreMostrarBannerPL20()
        {
            string controllerName = ControllerContext.RouteData.Values["controller"].ToString();
            string actionName = ControllerContext.RouteData.Values["action"].ToString();

            if (controllerName == "Bienvenida" && actionName == "Index") return true;
            return false;
        }

        private bool NuncaMostrarBannerPL20()
        {
            string controllerName = ControllerContext.RouteData.Values["controller"].ToString();

            if (controllerName == "Pedido") return true;
            if (controllerName == "CatalogoPersonalizado") return true;
            if (controllerName == "ShowRoom") return true;
            if (controllerName == "SeguimientoPedido") return true;
            if (controllerName == "PedidosFacturados") return true;
            if (controllerName == "EstadoCuenta") return true;
            if (controllerName == "Cliente") return true;
            if (controllerName == "OfertaLiquidacion") return true;
            if (controllerName == "ConsultoraOnline") return true;
            if (controllerName == "ProductosAgotados") return true;
            if (controllerName == "Catalogo") return true;
            if (controllerName == "MiAsesorBelleza") return true;
            if (controllerName == "Notificaciones") return true;
            return false;
        }

        private bool NuncaMostrarBannerTopPL20()
        {
            string controllerName = ControllerContext.RouteData.Values["controller"].ToString();
            string actionName = ControllerContext.RouteData.Values["action"].ToString();

            if (controllerName == "Bienvenida" && actionName == "Index") return true;
            if (controllerName == "Pedido") return true;
            if (controllerName == "CatalogoPersonalizado") return true;
            if (controllerName == "ShowRoom") return true;
            if (controllerName == "SeguimientoPedido") return true;
            if (controllerName == "PedidosFacturados") return true;
            if (controllerName == "OfertaLiquidacion") return true;
            if (controllerName == "Ofertas") return true;
            if (controllerName == "OfertaDelDia") return true;

            return false;
        }

        private bool NoMostrarBannerODD()
        {
            string controllerName = ControllerContext.RouteData.Values["controller"].ToString();

            if (controllerName == "OfertaLiquidacion") return true;
            if (controllerName == "CatalogoPersonalizado") return true;
            if (controllerName == "Pedido") return true;
            if (controllerName == "ShowRoom") return true;
            if (controllerName == "Ofertas") return true;
            if (controllerName == "OfertaDelDia") return true;

            return false;
        }

        /// <summary>
        /// Redirect to UniqueSession if it exists, otherwise redirect to default
        /// </summary>
        /// <param name="actionName"></param>
        /// <param name="controllerName"></param>
        /// <param name="routeValues"></param>
        /// <returns></returns>
        protected override RedirectToRouteResult RedirectToAction(string actionName, string controllerName, RouteValueDictionary routeValues)
        {
            var uniqueKey = this.GetUniqueKey();
            var uniqueSessionAttribute = (UniqueSessionAttribute)Attribute.GetCustomAttribute(GetType(), typeof(UniqueSessionAttribute));

            if (uniqueSessionAttribute == null || string.IsNullOrEmpty(uniqueKey))
                return base.RedirectToAction(actionName, controllerName, routeValues);

            if (routeValues.ContainsKey("area"))
                routeValues.Remove("area");

            if (!routeValues.ContainsKey("controller"))
                routeValues.Add("controller", controllerName);

            if (!routeValues.ContainsKey("action"))
                routeValues.Add("action", actionName);


            if (!routeValues.ContainsKey(uniqueSessionAttribute.IdentifierKey))
                routeValues.Add(uniqueSessionAttribute.IdentifierKey, uniqueKey);

            return RedirectToRoute(uniqueSessionAttribute.RouteName, routeValues);
        }

        #region BannerApp
        [HttpGet]
        public JsonResult OcultarBannerApp()
        {
            try
            {
                Session["OcultarBannerApp"] = true;

                return Json(new
                {
                    success = true,
                }, JsonRequestBehavior.AllowGet);
            }
            catch (Exception ex)
            {
                LogManager.LogManager.LogErrorWebServicesBus(ex, userData.CodigoConsultora, userData.CodigoISO);
                return Json(new
                {
                    success = false,
                    message = "No se pudo procesar la solicitud"
                }, JsonRequestBehavior.AllowGet);
            }
        }

        private void MostrarBannerApp()
        {
            if (Session["OcultarBannerApp"] != null)
            {
                Session["BannerApp"] = null;
                return;
            }

            if (Session["BannerApp"] == null)
            {
                var lstComunicados = ObtenerComunicadoPorConsultora();
                Session["BannerApp"] = lstComunicados.FirstOrDefault(x => x.Descripcion == Constantes.Comunicado.AppConsultora);
            }

            var oComunicados = (BEComunicado)Session["BannerApp"];
            if (oComunicados != null)
            {
                ViewBag.MostrarBannerApp = true;
                ViewBag.BannerApp = oComunicados;
            }
        }

        #endregion

        public List<BEComunicado> ObtenerComunicadoPorConsultora()
        {
            using (var sac = new SACServiceClient())
            {
                var lstComunicados = sac.ObtenerComunicadoPorConsultora(UserData().PaisID, UserData().CodigoConsultora,
                        Constantes.ComunicadoTipoDispositivo.Mobile, UserData().CodigorRegion, UserData().CodigoZona, UserData().ConsultoraNueva);

                return lstComunicados.ToList();
            }
        }

        public async Task<List<BEComunicado>> ObtenerComunicadoPorConsultoraAsync()
        {
            using (var sac = new SACServiceClient())
            {
                var lstComunicados = await sac.ObtenerComunicadoPorConsultoraAsync(UserData().PaisID, UserData().CodigoConsultora,
                        Constantes.ComunicadoTipoDispositivo.Mobile, UserData().CodigorRegion, UserData().CodigoZona, UserData().ConsultoraNueva);

                return lstComunicados.ToList();
            }
        }
    }
}
