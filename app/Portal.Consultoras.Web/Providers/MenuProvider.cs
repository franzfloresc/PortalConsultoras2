using AutoMapper;
using Portal.Consultoras.Common;
using Portal.Consultoras.Web.Areas.Mobile.Models;
using Portal.Consultoras.Web.Models;
using Portal.Consultoras.Web.ServiceSAC;
using Portal.Consultoras.Web.ServiceSeguridad;
using Portal.Consultoras.Web.ServiceUsuario;
using Portal.Consultoras.Web.SessionManager;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace Portal.Consultoras.Web.Providers
{
    public class MenuProvider
    {
        protected ISessionManager sessionManager;
        protected readonly ConfiguracionManagerProvider _configuracionManager;
        protected readonly EventoFestivoProvider _eventoFestivo;

        public MenuProvider(ConfiguracionManagerProvider configuracionManagerProvider, 
            EventoFestivoProvider eventoFestivo) : this(SessionManager.SessionManager.Instance)
        {
            _configuracionManager = configuracionManagerProvider;
            _eventoFestivo = eventoFestivo;
        }

        public MenuProvider(ISessionManager sessionManager)
        {
            this.sessionManager = sessionManager;
        }



        public List<PermisoModel> SepararItemsMenu(List<PermisoModel> menuOriginal)
        {
            var menu = new List<PermisoModel>();

            SepararItemsMenuRecursivo(ref menu, menuOriginal, 0);

            return menu;
        }

        private void SepararItemsMenuRecursivo(ref List<PermisoModel> menu, List<PermisoModel> menuOriginal, int idPadre)
        {
            menu = menuOriginal.Where(x => x.IdPadre == idPadre && (x.Descripcion != "" || x.UrlItem != "" || x.UrlImagen != ""))
                .OrderBy(x => x.Posicion)
                .ToList();

            foreach (var itemMenu in menu)
            {
                var temp = new List<PermisoModel>();

                SepararItemsMenuRecursivo(ref temp, menuOriginal, itemMenu.PermisoID);

                itemMenu.SubMenus = temp;
                itemMenu.SubMenus = itemMenu.SubMenus.OrderBy(p => p.OrdenItem).ToList();
            }
        }

        private IList<PermisoModel> GetPermisosByRolService(int paisId, int rolId)
        {
            IList<BEPermiso> permisos;

            using (var sv = new SeguridadServiceClient())
            {
                permisos = sv.GetPermisosByRol(paisId, rolId).ToList();
            }

            return Mapper.Map<List<PermisoModel>>(permisos);
        }

        public UsuarioModel GetPermisosByRol(UsuarioModel userSession, RevistaDigitalModel revistaDigital)
        {
            var permisos = GetPermisosByRolService(userSession.PaisID, userSession.RolID);
            
            if (!_configuracionManager.GetMostrarOpcionClienteOnline(userSession.CodigoISO) &&
                permisos.Any(p => p.UrlItem.ToLower() == "consultoraonline/index"))
            {
                permisos.Remove(permisos.FirstOrDefault(p => p.UrlItem.ToLower() == "consultoraonline/index"));
            }

            if (!userSession.PedidoFICActivo
                && permisos.Any(m => m.Codigo == Constantes.MenuCodigo.PedidoFIC))
            {
                permisos.Where(m => m.Codigo == Constantes.MenuCodigo.PedidoFIC).ToList().ForEach(m => permisos.Remove(m));
            }

            if (userSession.IndicadorPermisoFIC == 0 &&
                permisos.Any(p => p.UrlItem.ToLower() == "pedidofic/index"))
            {
                permisos.Remove(permisos.FirstOrDefault(p => p.UrlItem.ToLower() == "pedidofic/index"));
            }

            if ((userSession.CatalogoPersonalizado == 0 || !userSession.EsCatalogoPersonalizadoZonaValida) &&
                permisos.Any(p => p.UrlItem.ToLower() == "catalogopersonalizado/index"))
            {
                permisos.Remove(permisos.FirstOrDefault(p => p.UrlItem.ToLower() == "catalogopersonalizado/index"));
            }

            var lstMenuModel = new List<PermisoModel>();

            foreach (var permiso in permisos)
            {
                permiso.Codigo = Util.Trim(permiso.Codigo).ToLower();
                permiso.Descripcion = Util.Trim(permiso.Descripcion);
                permiso.UrlItem = Util.Trim(permiso.UrlItem);
                permiso.UrlImagen = Util.Trim(permiso.UrlImagen);
                permiso.DescripcionFormateada = Util.RemoveDiacritics(permiso.DescripcionFormateada.ToLower()).Replace(" ", "-");

                if (permiso.Codigo == Constantes.MenuCodigo.ContenedorOfertas.ToLower())
                {
                    if (revistaDigital.TieneRevistaDigital())
                    {
                        userSession.ClaseLogoSB = "negro";
                        sessionManager.SetUserData(userSession);
                    }
                    permiso.EsSoloImagen = true;
                    permiso.UrlImagen = GetUrlImagenMenuOfertas(userSession.CodigoISO, revistaDigital);
                }

                if (permiso.Codigo == Constantes.MenuCodigo.CatalogoPersonalizado.ToLower() &&
                    (revistaDigital.TieneRevistaDigital()))
                {
                    continue;
                }

                // por ahora esta en header, ponerlo para tambien para el Footer
                // Objetivo que el Html este limpio, la logica no deberia estar en la vista
                #region header
                if (permiso.Posicion.ToLower() == "header")
                {
                    if (!permiso.Mostrar)
                        continue;

                    if (permiso.Descripcion.ToUpperInvariant() == "SOCIA EMPRESARIA" && permiso.IdPadre == 0
                        && !(userSession.Lider == 1 && userSession.PortalLideres))
                    {
                        continue;
                    }

                    permiso.PageTarget = permiso.PaginaNueva ? "_blank" : "_self";
                    permiso.ClaseSubMenu = permiso.Descripcion == "MI NEGOCIO" ? "sub_menu_home1" : "sub_menu_home2";

                    if (permiso.IdPadre == 0)
                    {
                        permiso.ClaseMenu = "";
                        permiso.ClaseMenuItem = "";
                        var urlSplit = permiso.UrlItem.Split('/');
                        permiso.OnClickFunt = "RedirectMenu('" + (urlSplit.Length > 1 ? urlSplit[1] : "") + "', '" + (urlSplit.Length > 0 ? urlSplit[0] : "") + "' , " + Convert.ToInt32(permiso.PaginaNueva).ToString() + ", '" + permiso.Descripcion + "')";

                        if (permiso.Descripcion.ToUpperInvariant() == "MI COMUNIDAD")
                        {
                            if (!userSession.EsUsuarioComunidad)
                            {
                                permiso.OnClickFunt = "AbrirModalRegistroComunidad()";
                            }
                            else
                            {
                                permiso.OnClickFunt = "RedirectMenu('" + (urlSplit.Length > 1 ? urlSplit[1] : "") + "', '" + (urlSplit.Length > 0 ? urlSplit[0] : "") + "', '' , " + Convert.ToInt32(permiso.PaginaNueva).ToString() + " , '" + permiso.Descripcion + "')";
                            }
                        }

                        if (permiso.Descripcion.ToUpperInvariant() == "SOCIA EMPRESARIA")
                        {
                            permiso.ClaseMenu = "menu_socia_empresaria";
                            if (userSession.Lider == 1 && userSession.PortalLideres)
                            {
                                permiso.OnClickFunt = "RedirectMenu('" + permiso.UrlItem + "', '' , " + Convert.ToInt32(permiso.PaginaNueva).ToString() + " , '" + permiso.Descripcion + "')";
                            }
                        }

                        permiso.UrlImagen = permiso.EsSoloImagen ? permiso.UrlImagen : "";
                    }
                    else
                    {
                        if (permiso.UrlItem != "")
                        {
                            if (permiso.EsDireccionExterior)
                            {
                                permiso.OnClickFunt = "RedirectMenu('" + permiso.UrlItem + "', '' , " + Convert.ToInt32(permiso.PaginaNueva).ToString() + " , '" + permiso.Descripcion + "')";
                            }
                            else
                            {
                                var urlSplit = permiso.UrlItem.Split('/');
                                permiso.OnClickFunt = "RedirectMenu('" + (urlSplit.Length > 1 ? urlSplit[1] : "") + "', '" + (urlSplit.Length > 0 ? urlSplit[0] : "") + "', " + Convert.ToInt32(permiso.PaginaNueva).ToString() + " , '" + permiso.Descripcion + "')";
                            }
                        }
                    }

                    lstMenuModel.Add(permiso);

                    continue;
                }
                #endregion

                lstMenuModel.Add(permiso);
            }
            
            userSession.Menu = lstMenuModel.ToList();
            sessionManager.SetUserData(userSession);
            return userSession;
        }

        public string GetUrlImagenMenuOfertas(string codigoIso, RevistaDigitalModel revistaDigital)
        {
            var urlImagen = string.Empty;
            var tieneRevistaDigital = revistaDigital.TieneRevistaDigital();
            var smEventoFestivo = sessionManager.GetEventoFestivoDataModel();
            var tieneEventoFestivoData = smEventoFestivo != null &&
                smEventoFestivo.ListaGifMenuContenedorOfertas != null &&
                smEventoFestivo.ListaGifMenuContenedorOfertas.Any();

            if (!tieneRevistaDigital)
            {
                urlImagen = _configuracionManager.GetDefaultGifMenuOfertas();
                urlImagen = ConfigCdn.GetUrlFileCdn(Globals.UrlMatriz + "/" + codigoIso, urlImagen);
                if (tieneEventoFestivoData)
                {
                    urlImagen = _eventoFestivo.EventoFestivoPersonalizacionSegunNombre(Constantes.EventoFestivoNombre.GIF_MENU_OFERTAS, urlImagen);
                }
            }

            if (tieneRevistaDigital && !revistaDigital.EsSuscrita)
            {
                urlImagen = revistaDigital.LogoMenuOfertasNoActiva;
                urlImagen = ConfigCdn.GetUrlFileCdn(Globals.UrlMatriz + "/" + codigoIso, urlImagen);
                if (tieneEventoFestivoData)
                {
                    urlImagen = _eventoFestivo.EventoFestivoPersonalizacionSegunNombre(Constantes.EventoFestivoNombre.GIF_MENU_OFERTAS_BPT_GANA_MAS, urlImagen);
                }

            }

            if (tieneRevistaDigital && revistaDigital.EsSuscrita)
            {
                urlImagen = revistaDigital.LogoMenuOfertasActiva;
                urlImagen = ConfigCdn.GetUrlFileCdn(Globals.UrlMatriz + "/" + codigoIso, urlImagen);
                if (tieneEventoFestivoData)
                {
                    urlImagen = _eventoFestivo.EventoFestivoPersonalizacionSegunNombre(Constantes.EventoFestivoNombre.GIF_MENU_OFERTAS_BPT_CLUB_GANA_MAS, urlImagen);
                }
            }

            if (revistaDigital.TieneRDI)
            {
                urlImagen = revistaDigital.LogoMenuOfertasNoActiva;
                urlImagen = ConfigCdn.GetUrlFileCdn(Globals.UrlMatriz + "/" + codigoIso, urlImagen);
                if (tieneEventoFestivoData)
                {
                    urlImagen = _eventoFestivo.EventoFestivoPersonalizacionSegunNombre(Constantes.EventoFestivoNombre.GIF_MENU_OFERTAS_BPT_GANA_MAS, urlImagen);
                }

            }

            return urlImagen;
        }

        public List<MenuMobileModel> GetMenuMobileModelService(int paisId)
        {
            List<BEMenuMobile> lstMenuMobile;

            try
            {
                using (var sv = new SeguridadServiceClient())
                {
                    lstMenuMobile = sv.GetItemsMenuMobile(paisId).ToList();
                }
            }
            catch (Exception ex)
            {
                LogManager.LogManager.LogErrorWebServicesBus(ex, string.Empty, paisId.ToString(), "BaseController.GetMenuMobileModel");
                lstMenuMobile = new List<BEMenuMobile>();
            }

            return Mapper.Map<List<MenuMobileModel>>(lstMenuMobile);
        }

        public UsuarioModel GetMenuMobileModel(UsuarioModel userSession, RevistaDigitalModel revistaDigital, HttpRequestBase request, bool tieneTituloCatalogo)
        {
            var lstMenuMobileModel = GetMenuMobileModelService(userSession.PaisID);
            //

            userSession.ConsultoraOnlineMenuResumen = new ConsultoraOnlineMenuResumenModel();

            if ((userSession.CatalogoPersonalizado == 0 || !userSession.EsCatalogoPersonalizadoZonaValida) &&
                lstMenuMobileModel.Any(p => p.UrlItem.ToLower() == "mobile/catalogopersonalizado/index"))
            {
                lstMenuMobileModel.Remove(lstMenuMobileModel.FirstOrDefault(p => p.UrlItem.ToLower() == "mobile/catalogopersonalizado/index"));
            }

            var menuConsultoraOnlinePadre = lstMenuMobileModel.FirstOrDefault(m => m.Descripcion.ToLower().Trim() == "app de catálogos" && m.MenuPadreID == 0);
            var menuConsultoraOnlineHijo = lstMenuMobileModel.FirstOrDefault(m => m.Descripcion.ToLower().Trim() == "app de catálogos" && m.MenuPadreID != 0);


            if (!_configuracionManager.GetMostrarOpcionClienteOnline(userSession.CodigoISO))
            {
                lstMenuMobileModel.Remove(menuConsultoraOnlinePadre);
                lstMenuMobileModel.Remove(menuConsultoraOnlineHijo);
            }
            else if (menuConsultoraOnlinePadre != null || menuConsultoraOnlineHijo != null)
            {
                int esConsultoraOnline;
                using (var svc = new UsuarioServiceClient())
                {
                    esConsultoraOnline = svc.GetCantidadPedidosConsultoraOnline(userSession.PaisID, userSession.ConsultoraID);
                    if (esConsultoraOnline >= 0)
                    {
                        userSession.ConsultoraOnlineMenuResumen.CantPedidosPendientes = svc.GetCantidadSolicitudesPedido(userSession.PaisID, userSession.ConsultoraID, userSession.CampaniaID);
                        userSession.ConsultoraOnlineMenuResumen.TeQuedanConsultoraOnline = svc.GetSaldoHorasSolicitudesPedido(userSession.PaisID, userSession.ConsultoraID, userSession.CampaniaID);
                        userSession.ConsultoraOnlineMenuResumen.TipoMenuConsultoraOnline = 2;
                        userSession.ConsultoraOnlineMenuResumen.MenuPadreIDConsultoraOnline = menuConsultoraOnlinePadre != null ? menuConsultoraOnlinePadre.MenuMobileID : 0;
                    }
                    else
                    {
                        userSession.ConsultoraOnlineMenuResumen.TipoMenuConsultoraOnline = 1;
                        userSession.ConsultoraOnlineMenuResumen.MenuHijoIDConsultoraOnline = menuConsultoraOnlineHijo != null ? menuConsultoraOnlineHijo.MenuMobileID : 0;
                        lstMenuMobileModel.Remove(menuConsultoraOnlinePadre);
                    }
                }

                if (menuConsultoraOnlineHijo != null)
                {
                    var arrayUrlConsultoraOnlineHijo = menuConsultoraOnlineHijo.UrlItem.Split(new string[] { "||" }, StringSplitOptions.None);
                    menuConsultoraOnlineHijo.UrlItem = arrayUrlConsultoraOnlineHijo[esConsultoraOnline == -1 ? 0 : arrayUrlConsultoraOnlineHijo.Length - 1];
                }
            }

            var listadoMenuFinal = new List<MenuMobileModel>();
            foreach (var menu in lstMenuMobileModel)
            {
                menu.Codigo = Util.Trim(menu.Codigo).ToLower();
                menu.UrlItem = Util.Trim(menu.UrlItem);
                menu.UrlImagen = Util.Trim(menu.UrlImagen);
                menu.Descripcion = Util.Trim(menu.Descripcion);
                menu.MenuPadreDescripcion = Util.Trim(menu.MenuPadreDescripcion);
                menu.Posicion = Util.Trim(menu.Posicion);

                if (menu.MenuMobileID == Constantes.MenuMobileId.NecesitasAyuda)
                {
                    menu.EstiloMenu = "background: url(" + menu.UrlImagen.Replace("~", "") + ") no-repeat; background-position: 7px 16px; background-size: 12px 12px;";
                }
                else if (menu.MenuMobileID == 1002)
                {
                    menu.Descripcion = tieneTituloCatalogo ? menu.Descripcion : "Catálogos";
                }

                if (menu.Posicion.ToLower() != "menu")
                {
                    listadoMenuFinal.Add(menu);
                    continue;
                }

                menu.ClaseMenu = "";
                menu.ClaseMenuItem = "";

                menu.PageTarget = menu.PaginaNueva ? "_blank" : "_self";
                menu.OnClickFunt = userSession.TipoUsuario == 2 && menu.Descripcion.ToLower() == "mi academia" ? "onclick='return messageInfoPostulante();'" : "";
                menu.OnClickFunt = userSession.TipoUsuario == 2 && menu.Descripcion.ToLower() == "app de catálogos" ? "onclick='return messageInfoPostulante();'" : menu.OnClickFunt;

                try
                {
                    menu.UrlItem = menu.Version == "Completa"
                    ? menu.UrlItem.StartsWith("http") ? menu.UrlItem : string.Format("{0}Mobile/Menu/Ver?url={1}", Util.GetUrlHost(request), menu.UrlItem)
                    : menu.UrlItem.StartsWith("http") ? menu.UrlItem : string.Format("{0}{1}", Util.GetUrlHost(request), menu.UrlItem);
                }
                catch
                {
                    // ignored
                }


                menu.UrlItem = userSession.TipoUsuario == 2 && menu.Descripcion.ToLower() == "mi academia" ? "javascript:;" : menu.UrlItem;
                menu.UrlItem = userSession.TipoUsuario == 2 && menu.Descripcion.ToLower() == "app de catálogos" ? "javascript:;" : menu.UrlItem;

                if (menu.Codigo == Constantes.MenuCodigo.ContenedorOfertas.ToLower())
                {
                    menu.UrlImagen = GetUrlImagenMenuOfertas(userSession.CodigoISO, revistaDigital);
                }

                listadoMenuFinal.Add(menu);
            }

            var lstModel = listadoMenuFinal.Where(item => item.MenuPadreID == 0).OrderBy(item => item.OrdenItem).ToList();
            foreach (var item in lstModel)
            {
                var subItems = listadoMenuFinal.Where(p => p.MenuPadreID == item.MenuMobileID).OrderBy(p => p.OrdenItem);
                foreach (var subItem in subItems)
                {
                    subItem.Codigo = Util.Trim(subItem.Codigo).ToLower();
                    if (subItem.Codigo == Constantes.MenuCodigo.CatalogoPersonalizado.ToLower()
                        && (revistaDigital.TieneRevistaDigital()))
                    {
                        continue;
                    }

                    item.SubMenu.Add(subItem);
                }
            }

            if (lstModel.Any(m => m.Codigo == Constantes.MenuCodigo.ContenedorOfertas.ToLower()))
            {
                var menuNego = lstModel.FirstOrDefault(m => m.Codigo == Constantes.MenuCodigo.MiNegocio.ToLower()) ?? new MenuMobileModel();

                if (menuNego.MenuMobileID > 0)
                {
                    lstModel.ForEach(m =>
                    {
                        m.OrdenItem = m.Codigo == Constantes.MenuCodigo.ContenedorOfertas.ToLower()
                            ? menuNego.OrdenItem + 1
                            : m.OrdenItem > menuNego.OrdenItem ? m.OrdenItem + 1 : m.OrdenItem;
                    });
                    lstModel = lstModel.OrderBy(p => p.OrdenItem).ToList();
                }
            }
            //
            userSession.MenuMobile = lstModel;
            sessionManager.SetUserData(userSession);
            return userSession;
        }

        public string GetMenuLinkByDescription(string description)
        {
            var userSession = sessionManager.GetUserData();
            var menuItem = userSession.Menu.FirstOrDefault(item => item.Descripcion == description);
            return menuItem == null ? string.Empty : menuItem.UrlItem;
        }

        public UsuarioModel BuildMenuService(UsuarioModel userSession)
        {
            if (userSession.MenuService != null)
            {
                return userSession;
            }

            var lstTemp1 = new List<BEServicioCampania>();

            try
            {
                using (var sv = new SACServiceClient())
                {
                    lstTemp1 = sv.GetServicioByCampaniaPais(userSession.PaisID, userSession.CampaniaID).ToList();
                }
            }
            catch (Exception ex)
            {
                LogManager.LogManager.LogErrorWebServicesBus(ex, userSession.CodigoConsultora, userSession.CodigoISO);
            }

            int segmentoId;
            if (userSession.TipoUsuario == Constantes.TipoUsuario.Postulante)
            {
                segmentoId = 1;
            }
            else
            {
                if (userSession.CodigoISO == Constantes.CodigosISOPais.Venezuela)
                {
                    segmentoId = userSession.SegmentoID;
                }
                else
                {
                    segmentoId = userSession.SegmentoInternoID ?? userSession.SegmentoID;
                }
            }

            var segmentoServicio = userSession.EsJoven == 1 ? 99 : segmentoId;

            var lstTemp2 = lstTemp1.Where(p => p.ConfiguracionZona == string.Empty || p.ConfiguracionZona.Contains(userSession.ZonaID.ToString())).ToList();
            var lst = lstTemp2.Where(p => p.Segmento == "-1" || p.Segmento == segmentoServicio.ToString()).ToList();

            userSession.MenuService = Mapper.Map<IList<BEServicioCampania>, List<ServicioCampaniaModel>>(lst);
            sessionManager.SetUserData(userSession);
            return userSession;
        }

        public bool FindInMenu<T>(List<PermisoModel> menuWeb, Predicate<PermisoModel> predicate, Converter<PermisoModel, T> select, out T result)
        {
            result = default(T);
            foreach (var item in menuWeb)
            {
                if (predicate(item))
                {
                    result = select(item);
                    return true;
                }
                if (FindInMenu(item.SubMenus, predicate, select, out result)) return true;
            }
            return false;
        }

        public bool FindInMenu<T>(List<MenuMobileModel> menuWeb, Predicate<MenuMobileModel> predicate, Converter<MenuMobileModel, T> select, out T result)
        {
            result = default(T);
            foreach (var item in menuWeb)
            {
                if (predicate(item))
                {
                    result = select(item);
                    return true;
                }
                if (FindInMenu(item.SubMenu.ToList(), predicate, select, out result)) return true;
            }
            return false;
        }

    }
}