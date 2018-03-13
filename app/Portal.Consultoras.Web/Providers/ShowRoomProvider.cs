using Portal.Consultoras.Web.Models.Estrategia.ShowRoom;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Portal.Consultoras.Web.Providers
{
    public class ShowRoomProvider
    {
        private const string CookieDoNotShowAgain = "showRoomBannerNotShow";
        private const string ImageUrlCode = "bar_in_img";
        private const string RedirectCode = "bar_in_url";
        private const string EnabledCode = "bar_in_act";
        private const short Pl50Key = 98;

        private readonly TablaLogicaProvider _tablaLogicaProvider;
        public ShowRoomProvider()
        {
            _tablaLogicaProvider = new TablaLogicaProvider();
        }

        public BannerInferiorConfiguracion ObtenerBannerConfiguracion(int paisId)
        {
            var pl50configs = _tablaLogicaProvider.ObtenerConfiguracion(paisId, Pl50Key);
            var enabledObject = pl50configs.FirstOrDefault(c => c.Codigo == EnabledCode);
            var redirectUrlObject = pl50configs.FirstOrDefault(c => c.Codigo == RedirectCode);
            var imageUrlObject = pl50configs.FirstOrDefault(c => c.Codigo == ImageUrlCode);

            return new BannerInferiorConfiguracion
            {
                Activo = bool.Parse(enabledObject.Descripcion),
                UrlImagen = imageUrlObject.Descripcion,
                UrlRedireccion = redirectUrlObject.Descripcion
            };
        }

        /// <summary>
        /// Obtiene la configuracion y evalua la cookie
        /// </summary>
        /// <param name="paisId"></param>
        /// <param name="codigoConsultora"></param>
        /// <param name="request"></param>
        /// <returns></returns>
        public BannerInferiorConfiguracion ObtenerBannerConfiguracion(int paisId, string codigoConsultora, System.Web.HttpRequestBase request)
        {
            var cookie = request.Cookies[paisId.ToString() + codigoConsultora + CookieDoNotShowAgain];
            var mostrarBannerCookie = cookie.Value == "true";

            var configuracion = ObtenerBannerConfiguracion(paisId);
            configuracion.Activo = configuracion.Activo && mostrarBannerCookie;

            return configuracion;
        }
    }
}
