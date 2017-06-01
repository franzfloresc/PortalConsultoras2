﻿using System;
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
using AutoMapper;

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
                ViewBag.EsMobile = 2;//EPD-1780
                BuildMenuMobile(userData);
                CargarValoresGenerales(userData);

                ShowRoomModel ShowRoom = new ShowRoomModel();

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
                        using (var sv = new PedidoServiceClient())
                        {
                            var result = sv.ValidacionModificarPedidoSelectiva(userData.PaisID, userData.ConsultoraID, userData.CampaniaID, userData.UsuarioPrueba == 1, userData.AceptacionConsultoraDA, false, true, false);
                            if (result.MotivoPedidoLock == Enumeradores.MotivoPedidoLock.Reservado) mostrarBanner = false;
                        }
                    }
                }

                bool mostrarBannerTop = NuncaMostrarBannerTopPL20() || userData.IndicadorGPRSB == 1 ? false : true;

                ViewBag.MostrarBannerTopPL20 = mostrarBannerTop;

                if (mostrarBanner || mostrarBannerTop)
                {
                    ViewBag.PermitirCerrarBannerPL20 = permitirCerrarBanner;
                    ShowRoomBannerLateralModel showRoomBannerLateral = GetShowRoomBannerLateral();
                    ViewBag.ShowRoomBannerLateral = showRoomBannerLateral;
                    ViewBag.MostrarShowRoomBannerLateral = Session["EsShowRoom"].ToString() != "0" &&
                        !showRoomBannerLateral.ConsultoraNoEncontrada && !showRoomBannerLateral.ConsultoraNoEncontrada &&
                        showRoomBannerLateral.BEShowRoomConsultora.EventoConsultoraID != 0 && showRoomBannerLateral.EstaActivoLateral;

                    //if (showRoomBannerLateral.DiasFalta < 1)
                    //{
                    //    //ViewBag.MostrarShowRoomBannerLateral = false;
                    //}

                    if (showRoomBannerLateral.DiasFalta > 0)
                    {
                        if (showRoomBannerLateral.DiasFalta > 1)
                        {
                            showRoomBannerLateral.LetrasDias = "FALTAN " + Convert.ToInt32(showRoomBannerLateral.DiasFalta).ToString() + " DÍAS";
                        }
                        else { showRoomBannerLateral.LetrasDias = "FALTA " + Convert.ToInt32(showRoomBannerLateral.DiasFalta).ToString() + " DÍA"; }
                    }

                    ViewBag.ImagenPopupShowroomIntriga = showRoomBannerLateral.ImagenPopupShowroomIntriga;
                    ViewBag.ImagenBannerShowroomIntriga = showRoomBannerLateral.ImagenBannerShowroomIntriga;
                    ViewBag.ImagenPopupShowroomVenta = showRoomBannerLateral.ImagenPopupShowroomVenta;
                    ViewBag.ImagenBannerShowroomVenta = showRoomBannerLateral.ImagenBannerShowroomVenta;
                    ViewBag.DiasFaltantesLetras = showRoomBannerLateral.LetrasDias;

                    ViewBag.MostrarShowRoomProductos = showRoomBannerLateral.MostrarShowRoomProductos;

                    OfertaDelDiaModel ofertaDelDia = GetOfertaDelDiaModel();
                    ViewBag.OfertaDelDia = ofertaDelDia;

                    ViewBag.MostrarOfertaDelDia =
                        userData.IndicadorGPRSB == 1 || userData.CloseOfertaDelDia
                        ? false
                        : (userData.TieneOfertaDelDia && ofertaDelDia != null && ofertaDelDia.TeQuedan.TotalSeconds > 0);

                    showRoomBannerLateral.EstadoActivo = mostrarBannerTop ? "0" : "1";
                }

                ViewBag.MostrarBannerPL20 = mostrarBanner;
                ViewBag.MostrarBannerOtros = mostrarBannerTop;

                ViewBag.EstadoActivo = mostrarBannerTop ? "0" : "1";

                if (mostrarBanner)
                {
                    if (!(
                        (!userData.ValidacionAbierta && userData.EstadoPedido == 202 && userData.IndicadorGPRSB == 2)
                        || userData.IndicadorGPRSB == 0)
                    )
                    {
                        ViewBag.MostrarBannerPL20 = false;
                        ViewBag.MostrarOfertaDelDia = false;
                    }
                }

                ViewBag.MostrarODD = NoMostrarBannerODD();

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

        public void BuildMenuMobile(UsuarioModel userData)
        {
            var lstModel = new List<MenuMobileModel>();
            
            if (Session["UserData"] == null)
            {
                ViewBag.MenuMobile = lstModel;
                return;
            }

            if (userData.RolID != Constantes.Rol.Consultora || !IsMobile())
            {
                ViewBag.MenuMobile = lstModel;
                return;
            }

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
            else if (menuConsultoraOnlinePadre != null || menuConsultoraOnlineHijo != null)
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

            var listadoMenu = Mapper.Map<List<MenuMobileModel>>(lst);
            var listadoMenuFinal = new List<MenuMobileModel>();
            foreach (var menu in listadoMenu)
            {
                menu.Codigo = Util.Trim(menu.Codigo).ToLower();

                if (menu.Codigo == Constantes.MenuCodigo.RevistaDigital.ToLower())
                {
                    if (!ValidarPermiso(Constantes.MenuCodigo.RevistaDigital))
                        if (!ValidarPermiso("", Constantes.ConfiguracionPais.RevistaDigitalSuscripcion))
                            continue;
                }

                menu.UrlItem = Util.Trim(menu.UrlItem);
                menu.UrlImagen = Util.Trim(menu.UrlImagen);
                menu.Descripcion = Util.Trim(menu.Descripcion);
                menu.MenuPadreDescripcion = Util.Trim(menu.MenuPadreDescripcion);
                menu.Posicion = Util.Trim(menu.Posicion);

                if (menu.Posicion.ToLower() != "menu")
                {
                    listadoMenuFinal.Add(menu);
                    continue;
                }

                menu.ClaseMenu = "";
                menu.ClaseMenuItem = "";

                menu.PageTarget = menu.PaginaNueva ? "_blank" : "_self";
                menu.OnClickFunt = ViewBag.TipoUsuario == 2 && menu.Descripcion.ToLower() == "mi academia" ? "onclick='return messageInfoPostulante();'" : "";
                menu.OnClickFunt = ViewBag.TipoUsuario == 2 && menu.Descripcion.ToLower() == "app de catálogos" ? "onclick='return messageInfoPostulante();'" : menu.OnClickFunt;

                menu.UrlItem = menu.Version == "Completa"
                    ? menu.UrlItem.StartsWith("http") ? menu.UrlItem : string.Format("{0}Mobile/Menu/Ver?url={1}", Util.GetUrlHost(Request), menu.UrlItem)
                    : menu.UrlItem.StartsWith("http") ? menu.UrlItem : string.Format("{0}{1}", Util.GetUrlHost(Request), menu.UrlItem);
                menu.UrlItem = ViewBag.TipoUsuario == 2 && menu.Descripcion.ToLower() == "mi academia" ? "javascript:;" : menu.UrlItem;
                menu.UrlItem = ViewBag.TipoUsuario == 2 && menu.Descripcion.ToLower() == "app de catálogos" ? "javascript:;" : menu.UrlItem;

                if (menu.Descripcion.ToLower() == "VENTA EXCLUSIVA WEB".ToLower())
                {
                    if (Session["EsShowRoom"] != null && Session["EsShowRoom"].ToString() == "1")
                    {
                        menu.OnClickFunt = "";
                        menu.MenuPadreDescripcion = menu.Descripcion;
                        if (Session["MostrarShowRoomProductos"] != null && Session["MostrarShowRoomProductos"].ToString() == "1")
                        {
                            menu.ClaseMenu = " etiqueta_showroom wsventa";
                        }
                        else
                        {
                            menu.ClaseMenu = " etiqueta_showroom wsintriga";
                        }

                        menu.UrlImagen = "";
                        menu.UrlItem = AccionControlador("sr", 1);
                    }
                    else
                    {
                        continue;
                    }
                }
                else if (menu.Codigo == Constantes.MenuCodigo.RevistaDigital.ToLower())
                {
                    if (!ValidarPermiso(Constantes.MenuCodigo.RevistaDigital))
                        if (ValidarPermiso("", Constantes.ConfiguracionPais.RevistaDigitalSuscripcion))
                            if (userData.RevistaDigital.NoVolverMostrar)
                            {
                                if (userData.RevistaDigital.SuscripcionModel.EstadoRegistro == Constantes.EstadoRDSuscripcion.NoPopUp
                                    || userData.RevistaDigital.SuscripcionModel.EstadoRegistro == Constantes.EstadoRDSuscripcion.Desactivo)
                                {
                                    continue;
                                }
                                if (userData.RevistaDigital.SuscripcionModel.EstadoRegistro == Constantes.EstadoRDSuscripcion.SinRegistroDB)
                                {
                                    menu.ClaseMenuItem = "oculto";
                                }
                            }
                            else
                            {
                                menu.ClaseMenuItem = "oculto";
                            }
                }

                listadoMenuFinal.Add(menu);
            }

            //Agregamos los menú Padre
            foreach (var item in listadoMenuFinal.Where(item => item.MenuPadreID == 0).OrderBy(item => item.OrdenItem))
            {
                lstModel.Add(item);
            }

            //Agregamos los items para cada menú Padre
            foreach (var item in lstModel)
            {
                var subItems = listadoMenuFinal.Where(p => p.MenuPadreID == item.MenuMobileID).OrderBy(p => p.OrdenItem);
                foreach (var subItem in subItems)
                {
                    subItem.Codigo = Util.Trim(subItem.Codigo).ToLower();
                    if (subItem.Codigo == Constantes.MenuCodigo.CatalogoPersonalizado.ToLower())
                    {
                        if (ValidarPermiso(Constantes.MenuCodigo.RevistaDigital))
                            continue;
                    }

                    item.SubMenu.Add(subItem);
                }
            }
            
            ViewBag.MenuMobile = lstModel;

        }

        private void CargarValoresGenerales(UsuarioModel userData)
        {
            if (Session["UserData"] != null)
            {
                ViewBag.NombreConsultora = (string.IsNullOrEmpty(userData.Sobrenombre) ? userData.NombreConsultora : userData.Sobrenombre).ToUpper();
                int j = ViewBag.NombreConsultora.Trim().IndexOf(' ');
                if (j >= 0) ViewBag.NombreConsultora = ViewBag.NombreConsultora.Substring(0, j).Trim();

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

            //if (controllerName == "CatalogoPersonalizado" && actionName == "Index") return true;
            //if (controllerName == "CatalogoPersonalizado" && actionName == "Producto") return true;
            //if (controllerName == "ShowRoom") return true;
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
            string controllerName = this.ControllerContext.RouteData.Values["controller"].ToString();
            string actionName = this.ControllerContext.RouteData.Values["action"].ToString();

            //if (controllerName == "CatalogoPersonalizado" && actionName == "Index") return true;
            //if (controllerName == "CatalogoPersonalizado" && actionName == "Producto") return true;
            //if (controllerName == "ShowRoom") return true;
            if (controllerName == "Bienvenida" && actionName == "Index") return true;
            if (controllerName == "Pedido") return true;
            if (controllerName == "CatalogoPersonalizado") return true;
            if (controllerName == "ShowRoom") return true;
            if (controllerName == "SeguimientoPedido") return true;
            if (controllerName == "PedidosFacturados") return true;
            if (controllerName == "OfertaLiquidacion") return true;
            return false;
        }
        
        private bool NoMostrarBannerODD()
        {
            string controllerName = this.ControllerContext.RouteData.Values["controller"].ToString();
            string actionName = this.ControllerContext.RouteData.Values["action"].ToString();

            if (controllerName == "OfertaLiquidacion") return true;
            if (controllerName == "CatalogoPersonalizado") return true;
            //if (controllerName == "MisPedidos") return true;
            if (controllerName == "Pedido") return true;
            if (controllerName == "ShowRoom") return true;
            return false;
        }

    }
}
