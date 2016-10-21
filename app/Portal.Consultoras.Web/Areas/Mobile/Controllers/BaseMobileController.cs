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
            }
            catch (Exception ex)
            {
                LogManager.LogManager.LogErrorWebServicesBus(ex, userData.CodigoConsultora, userData.CodigoISO);
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

                    var menuConsultoraOnlinePadre = lst.FirstOrDefault(m => m.Descripcion.ToLower().Trim() == "consultora online" && m.MenuPadreID == 0);
                    var menuConsultoraOnlineHijo = lst.FirstOrDefault(m => m.Descripcion.ToLower().Trim() == "consultora online" && m.MenuPadreID != 0);
                    string mostrarPedidosPendientes = ConfigurationManager.AppSettings.Get("MostrarPedidosPendientes");
                    string strpaises = ConfigurationManager.AppSettings.Get("Permisos_CCC");
                    bool mostrarClienteOnline = (mostrarPedidosPendientes == "1" && strpaises.Contains(userData.CodigoISO));
                    
                    if (!mostrarClienteOnline)
                    {
                        lst.Remove(menuConsultoraOnlinePadre);
                        lst.Remove(menuConsultoraOnlineHijo);
                        ViewBag.TipoMenuConsultoraOnline = 0;
                    }
                    else
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
                        //ViewBag.MenuPadreIDConsultoraOnline = menuConsultoraOnlinePadre.MenuMobileID;
                        //ViewBag.MenuHijoIDConsultoraOnline = menuConsultoraOnlineHijo.MenuMobileID;

                        //if (esConsultoraOnline <= 0)
                        //{
                        //    if (menuConsultoraOnlinePadre != null && menuConsultoraOnlineHijo != null)
                        //    {
                        //        var lstTmp = lst.Where(m => m.MenuPadreID != menuConsultoraOnlinePadre.MenuMobileID).ToList();
                        //        lst = lstTmp.Where(m => m.MenuMobileID != menuConsultoraOnlinePadre.MenuMobileID).ToList();
                        //        //lst.Where(m => m.MenuMobileID == menuh.MenuMobileID).First().Descripcion += " <b>!Afiliate¡</b>";
                        //        ViewBag.TipoMenuConsultoraOnline = 1;
                        //    }
                        //}
                        //else
                        //{
                        //    if (menuConsultoraOnlineHijo != null)
                        //    {
                        //        var lstTmp = lst.Where(m => m.MenuMobileID != menuConsultoraOnlineHijo.MenuMobileID).ToList();
                        //        lst = lstTmp;
                        //        ViewBag.TipoMenuConsultoraOnline = 2;
                        //    }
                        //}
                        if (esConsultoraOnline == -1)
                        {
                            ViewBag.TipoMenuConsultoraOnline = 1;
                            ViewBag.MenuHijoIDConsultoraOnline = menuConsultoraOnlineHijo.MenuMobileID;
                            lst.Remove(menuConsultoraOnlinePadre);
                        }
                        else
                        {
                            ViewBag.TipoMenuConsultoraOnline = 2;
                            ViewBag.MenuPadreIDConsultoraOnline = menuConsultoraOnlinePadre.MenuMobileID;
                            lst.Remove(menuConsultoraOnlineHijo);
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
    }
}
