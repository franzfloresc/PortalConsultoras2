using System;
using System.Linq;
using System.Web.Mvc;
using System.Collections.Generic;
using Portal.Consultoras.Common;
using Portal.Consultoras.Web.ServiceSeguridad;
using Portal.Consultoras.Web.Controllers;
using Portal.Consultoras.Web.Models;
using Portal.Consultoras.Web.Areas.Mobile.Models;
using System.Configuration;

using Portal.Consultoras.Web.ServiceUsuario;
using Portal.Consultoras.Web.ServicePedido;

namespace Portal.Consultoras.Web.Areas.Mobile.Controllers
{
    public class BaseMobileController : BaseController
    {
        protected override void OnActionExecuting(ActionExecutingContext filterContext)
        {
            base.OnActionExecuting(filterContext);

            if (Session["UserData"] == null) return;

            var userData = UserData();
            ViewBag.CodigoCampania = userData.CampaniaID.ToString();
            try
            {
                BuildMenuMobile(userData);
                CargarValoresGenerales(userData);

                /*INICIO: PL20-1289*/
                bool mostrarBanner, permitirCerrarBanner = false;
                if (SiempreMostrarBannerPL20()) mostrarBanner = true;
                else if (NuncaMostrarBannerPL20()) mostrarBanner = false;
                else
                {
                    mostrarBanner = true;
                    permitirCerrarBanner = true;

                    if (userData.CloseBannerPL20) mostrarBanner = false;
                    else
                    {
                        string message = string.Empty;
                        if (ValidarPedidoReservado(out message)) mostrarBanner = false;
                    }
                }

                if (mostrarBanner)
                {
                    ViewBag.PermitirCerrarBannerPL20 = permitirCerrarBanner;

                    ShowRoomBannerLateralModel showRoomBannerLateral = GetShowRoomBannerLateral();
                    ViewBag.ShowRoomBannerLateral = showRoomBannerLateral;
                    ViewBag.MostrarShowRoomBannerLateral = Session["EsShowRoom"].ToString() != "0" &&
                        !showRoomBannerLateral.ConsultoraNoEncontrada && !showRoomBannerLateral.ConsultoraNoEncontrada &&
                        showRoomBannerLateral.BEShowRoomConsultora.EventoConsultoraID != 0 && showRoomBannerLateral.EstaActivoLateral;

                    OfertaDelDiaModel ofertaDelDia = GetOfertaDelDiaModel();
                    ViewBag.OfertaDelDia = ofertaDelDia;

                    ViewBag.MostrarOfertaDelDia = userData.TieneOfertaDelDia && ofertaDelDia != null && ofertaDelDia.TeQuedan.TotalSeconds > 0;
                }
                ViewBag.MostrarBannerPL20 = mostrarBanner;
                if (mostrarBanner)
                {
                     if (!userData.ValidacionAbierta && userData.EstadoPedido == 202 && userData.IndicadorGPRSB == 2)
                    {
                        ViewBag.MostrarBannerPL20 = mostrarBanner;
                    }else if (userData.IndicadorGPRSB == 0)
                    {
                        ViewBag.MostrarBannerPL20 = mostrarBanner;
                    }
                    else
                    {
                        ViewBag.MostrarBannerPL20 = false;
                        ViewBag.MostrarOfertaDelDia = false;
                    }
                }

                /*FIN: PL20-1289*/
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
                var oddModel = this.GetOfertaDelDiaModel();
                return Json(new {
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

        private void BuildMenuMobile(UsuarioModel userData)
        {
            var lstModel = new List<MenuMobileModel>();

            if (Session["UserData"] != null)
            {
                if (userData.RolID == Constantes.Rol.Consultora)
                {
                    IList<BEMenuMobile> lst;
                    using (var sv = new SeguridadServiceClient())
                    {
                        lst = sv.GetItemsMenuMobile(userData.PaisID).ToList();
                    }

                    if (userData.CatalogoPersonalizado == 0 || !userData.EsCatalogoPersonalizadoZonaValida) lst.Remove(lst.FirstOrDefault(p => p.UrlItem.ToLower() == "mobile/catalogopersonalizado/index"));

                    var menuConsultoraOnlinePadre = lst.FirstOrDefault(m => m.Descripcion.ToLower().Trim() == "app de catálogos" && m.MenuPadreID == 0);
                    var menuConsultoraOnlineHijo = lst.FirstOrDefault(m => m.Descripcion.ToLower().Trim() == "app de catálogos" && m.MenuPadreID != 0);
                    string mostrarPedidosPendientes = ConfigurationManager.AppSettings.Get("MostrarPedidosPendientes");
                    string strpaises = ConfigurationManager.AppSettings.Get("Permisos_CCC");
                    bool mostrarClienteOnline = (mostrarPedidosPendientes == "1" && strpaises.Contains(userData.CodigoISO));
                    
                    if (!mostrarClienteOnline)
                    {
                        lst.Remove(menuConsultoraOnlinePadre);
                        lst.Remove(menuConsultoraOnlineHijo);
                        ViewBag.TipoMenuConsultoraOnline = 0;
                    }
                    else if(menuConsultoraOnlinePadre != null || menuConsultoraOnlineHijo != null)
                    {
                        int esConsultoraOnline = -1;
                        using (var svc = new UsuarioServiceClient())
                        {
                            esConsultoraOnline = svc.GetCantidadPedidosConsultoraOnline(userData.PaisID, userData.ConsultoraID);
                            if (esConsultoraOnline >= 0)
                            {
                                ViewBag.CantPedidosPendientes = svc.GetCantidadSolicitudesPedido(userData.PaisID, userData.ConsultoraID, userData.CampaniaID);
                                ViewBag.TeQuedanConsultoraOnline = svc.GetSaldoHorasSolicitudesPedido(userData.PaisID, userData.ConsultoraID, userData.CampaniaID);
                            }
                        }
                        
                        if (esConsultoraOnline == -1)
                        {
                            ViewBag.TipoMenuConsultoraOnline = 1;
                            ViewBag.MenuHijoIDConsultoraOnline = menuConsultoraOnlineHijo != null ? menuConsultoraOnlineHijo.MenuMobileID : 0;
                            lst.Remove(menuConsultoraOnlinePadre);
                        }
                        else
                        {
                            ViewBag.TipoMenuConsultoraOnline = 2;
                            ViewBag.MenuPadreIDConsultoraOnline = menuConsultoraOnlinePadre != null ? menuConsultoraOnlinePadre.MenuMobileID : 0;
                        }

                        if (menuConsultoraOnlineHijo != null)
                        {
                            string[] arrayUrlConsultoraOnlineHijo = menuConsultoraOnlineHijo.UrlItem.Split(new string[] { "||" }, StringSplitOptions.None);
                            menuConsultoraOnlineHijo.UrlItem = arrayUrlConsultoraOnlineHijo[esConsultoraOnline == -1 ? 0 : arrayUrlConsultoraOnlineHijo.Length - 1];
                        }
                    }

                    //Agregamos los menú Padre
                    foreach (var item in lst.Where(item => item.MenuPadreID == 0).OrderBy(item => item.OrdenItem))
                    {
                        lstModel.Add(new MenuMobileModel
                        {
                            MenuMobileID = item.MenuMobileID,
                            Descripcion = item.Descripcion,
                            MenuPadreID = item.MenuPadreID,
                            MenuPadreDescripcion = item.Descripcion,
                            OrdenItem = item.OrdenItem,
                            UrlItem = item.UrlItem,
                            PaginaNueva = item.PaginaNueva,
                            Posicion = item.Posicion,
                            UrlImagen = item.UrlImagen,
                            Version = item.Version
                        });
                    }

                    //Agregamos los items para cada menú Padre
                    foreach (var item in lstModel)
                    {
                        var subItems = lst.Where(p => p.MenuPadreID == item.MenuMobileID).OrderBy(p=>p.OrdenItem);
                        foreach (var subItem in subItems)
                        {
                            item.SubMenu.Add(new MenuMobileModel
                            {
                                MenuMobileID = subItem.MenuMobileID,
                                Descripcion = subItem.Descripcion,
                                MenuPadreID = subItem.MenuPadreID,
                                MenuPadreDescripcion = item.Descripcion,
                                OrdenItem = subItem.OrdenItem,
                                UrlItem = subItem.UrlItem,
                                PaginaNueva = subItem.PaginaNueva,
                                Posicion = subItem.Posicion,
                                UrlImagen = subItem.UrlImagen,
                                Version = subItem.Version
                            });
                        }
                    }
                }
            }

            ViewBag.MenuMobile = lstModel;
            
        }

        private void CargarValoresGenerales(UsuarioModel userData)
        {
            if (Session["UserData"] != null)
            {
                ViewBag.NombreConsultora = (string.IsNullOrEmpty(userData.Sobrenombre) ? userData.NombreConsultora : userData.Sobrenombre).ToUpper();
                ViewBag.NumeroCampania = userData.NombreCorto.Substring(4);
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
            string controllerName = this.ControllerContext.RouteData.Values["controller"].ToString();
            string actionName = this.ControllerContext.RouteData.Values["action"].ToString();

            if (controllerName == "Bienvenida" && actionName == "Index") return true;
            return false;
        }
        private bool NuncaMostrarBannerPL20()
        {
            string controllerName = this.ControllerContext.RouteData.Values["controller"].ToString();
            string actionName = this.ControllerContext.RouteData.Values["action"].ToString();

            if (controllerName == "CatalogoPersonalizado" && actionName == "Index") return true;
            if (controllerName == "CatalogoPersonalizado" && actionName == "Producto") return true;
            if (controllerName == "ShowRoom") return true;
            if (controllerName == "Pedido") return true;
            return false;
        }
    }
}
