﻿using Portal.Consultoras.Web.Models.Estrategia.ShowRoom;
using Portal.Consultoras.Web.SessionManager;
using System.Linq;

namespace Portal.Consultoras.Web.Providers
{
    /// <summary>
    /// Propiedades y metodos de ShowRoom
    /// </summary>
    public class ShowRoomProvider
    {
        private const string CookieDoNotShowAgain = "showRoomBannerNotShow";
        private const string ImageUrlCode = "bar_in_img";
        private const string RedirectCode = "bar_in_url";
        private const string EnabledCode = "bar_in_act";
        private const string NoUrlAllowed = "bar_in_no";
        private const short Pl50Key = 98;

        private readonly TablaLogicaProvider _tablaLogicaProvider;
        public ShowRoomProvider()
        {
            _tablaLogicaProvider = new TablaLogicaProvider();
        }

        /// <summary>
        /// Obtiene la configuracion de Base de datos
        /// </summary>
        /// <param name="paisId">Pais Id</param>
        /// <returns>Configuracion de Banner inferior</returns>
        public IBannerInferiorConfiguracion ObtenerBannerConfiguracion(int paisId)
        {
            var pl50configs = _tablaLogicaProvider.ObtenerConfiguracion(paisId, Pl50Key);
            var enabledObject = pl50configs.FirstOrDefault(c => c.Codigo == EnabledCode);
            var redirectUrlObject = pl50configs.FirstOrDefault(c => c.Codigo == RedirectCode);
            var imageUrlObject = pl50configs.FirstOrDefault(c => c.Codigo == ImageUrlCode);
            var NoUrlPermitidasObject = pl50configs.FirstOrDefault(c => c.Codigo == NoUrlAllowed);

            return new BannerInferiorConfiguracion
            {
                Activo = enabledObject != null ? bool.Parse(enabledObject.Valor) : false,
                UrlImagen = imageUrlObject != null ? imageUrlObject.Valor : string.Empty,
                UrlRedireccion = redirectUrlObject != null ? redirectUrlObject.Valor : string.Empty,
                RutasParcialesExcluidas = NoUrlPermitidasObject != null ? NoUrlPermitidasObject.Valor.Split(';') : new string[0]
            };
        }

        /// <summary>
        /// Obtiene y evalua la session (ShowRoom y Banner)
        /// </summary>
        /// <param name="paisId">Pais Id</param>
        /// <param name="session">Session Manager</param>
        /// <returns>Configuracion de Banner Inferior</returns>
        public IBannerInferiorConfiguracion EvaluarBannerConfiguracion(int paisId, ISessionManager session)
        {
            if (session.ShowRoom.BannerInferiorConfiguracion != null)
                return session.ShowRoom.BannerInferiorConfiguracion;

            var configuracion = ObtenerBannerConfiguracion(paisId);
            configuracion.Activo = configuracion.Activo && session.GetEsShowRoom();

            session.ShowRoom.BannerInferiorConfiguracion = configuracion;

            return configuracion;
        }
    }
}
