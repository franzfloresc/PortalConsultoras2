using AutoMapper;
using Portal.Consultoras.Common;
using Portal.Consultoras.Web.Areas.Mobile.Models;
using Portal.Consultoras.Web.Models;
using Portal.Consultoras.Web.ServiceSeguridad;
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

        public MenuProvider(ConfiguracionManagerProvider configuracionManagerProvider, EventoFestivoProvider eventoFestivo)
        {
            sessionManager = SessionManager.SessionManager.Instance;
            _configuracionManager = configuracionManagerProvider;
            _eventoFestivo = eventoFestivo;
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

        public virtual IList<PermisoModel> GetPermisosByRol(int paisId, int rolId)
        {
            IList<BEPermiso> permisos;

            using (var sv = new SeguridadServiceClient())
            {
                permisos = sv.GetPermisosByRol(paisId, rolId).ToList();
            }

            return Mapper.Map<List<PermisoModel>>(permisos);
        }

        public virtual string GetUrlImagenMenuOfertas(UsuarioModel userData, RevistaDigitalModel revistaDigital)
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
                urlImagen = ConfigCdn.GetUrlFileCdn(Globals.UrlMatriz + "/" + userData.CodigoISO, urlImagen);
                if (tieneEventoFestivoData)
                {
                    urlImagen = _eventoFestivo.EventoFestivoPersonalizacionSegunNombre(Constantes.EventoFestivoNombre.GIF_MENU_OFERTAS, urlImagen);
                }
            }

            if (tieneRevistaDigital && !revistaDigital.EsSuscrita)
            {
                urlImagen = revistaDigital.LogoMenuOfertasNoActiva;
                urlImagen = ConfigCdn.GetUrlFileCdn(Globals.UrlMatriz + "/" + userData.CodigoISO, urlImagen);
                if (tieneEventoFestivoData)
                {
                    urlImagen = _eventoFestivo.EventoFestivoPersonalizacionSegunNombre(Constantes.EventoFestivoNombre.GIF_MENU_OFERTAS_BPT_GANA_MAS, urlImagen);
                }

            }

            if (tieneRevistaDigital && revistaDigital.EsSuscrita)
            {
                urlImagen = revistaDigital.LogoMenuOfertasActiva;
                urlImagen = ConfigCdn.GetUrlFileCdn(Globals.UrlMatriz + "/" + userData.CodigoISO, urlImagen);
                if (tieneEventoFestivoData)
                {
                    urlImagen = _eventoFestivo.EventoFestivoPersonalizacionSegunNombre(Constantes.EventoFestivoNombre.GIF_MENU_OFERTAS_BPT_CLUB_GANA_MAS, urlImagen);
                }
            }

            if (revistaDigital.TieneRDI)
            {
                urlImagen = revistaDigital.LogoMenuOfertasNoActiva;
                urlImagen = ConfigCdn.GetUrlFileCdn(Globals.UrlMatriz + "/" + userData.CodigoISO, urlImagen);
                if (tieneEventoFestivoData)
                {
                    urlImagen = _eventoFestivo.EventoFestivoPersonalizacionSegunNombre(Constantes.EventoFestivoNombre.GIF_MENU_OFERTAS_BPT_GANA_MAS, urlImagen);
                }

            }

            return urlImagen;
        }

        public virtual List<MenuMobileModel> GetMenuMobileModel(int paisId)
        {
            List<BEMenuMobile> lstMenuMobile = null;

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
            }
            finally
            {
                lstMenuMobile = lstMenuMobile ?? new List<BEMenuMobile>();
            }

            return Mapper.Map<List<MenuMobileModel>>(lstMenuMobile);
        }

        public string GetMenuLinkByDescription(string description)
        {
            var userSession = sessionManager.GetUserData();
            var menuItem = userSession.Menu.FirstOrDefault(item => item.Descripcion == description);
            return menuItem == null ? string.Empty : menuItem.UrlItem;
        }
    }
}