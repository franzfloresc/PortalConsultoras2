using System.Collections.Generic;
using Portal.Consultoras.Web.Models.Estrategia.ShowRoom;
using Portal.Consultoras.Web.SessionManager;
using System.Linq;
using AutoMapper;
using Portal.Consultoras.Web.Models;
using Portal.Consultoras.Web.ServiceOferta;

namespace Portal.Consultoras.Web.Providers
{
    /// <summary>
    /// Propiedades y metodos de ShowRoom
    /// </summary>
    public class ShowRoomProvider
    {
        private const string ImageUrlCode = "bar_in_img";
        private const string RedirectCode = "bar_in_url";
        private const string EnabledCode = "bar_in_act";
        private const string NoUrlAllowed = "bar_in_no";
        private const short Pl50Key = 98;

        private readonly TablaLogicaProvider _tablaLogicaProvider;
        public ShowRoomProvider(TablaLogicaProvider tablaLogicaProvider)
        {
            _tablaLogicaProvider = tablaLogicaProvider;
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

        public ShowRoomEventoModel GetShowRoomEventoByCampaniaId(UsuarioModel model)
        {
            using (var osc = new OfertaServiceClient())
            {
                var showRoomEvento = osc.GetShowRoomEventoByCampaniaID(model.PaisID, model.CampaniaID);
                return Mapper.Map<ServiceOferta.BEShowRoomEvento, ShowRoomEventoModel>(showRoomEvento);
            }
        }

        public ShowRoomEventoConsultoraModel GetShowRoomConsultora(UsuarioModel model)
        {
            
            using (var osc = new OfertaServiceClient())
            {
                var  showRoomEventoConsultora = osc.GetShowRoomConsultora(
                    model.PaisID, 
                    model.CampaniaID, 
                    model.GetCodigoConsultora(), 
                    true);
                return Mapper.Map<BEShowRoomEventoConsultora, ShowRoomEventoConsultoraModel>(showRoomEventoConsultora);
            }
        }

        public List<ShowRoomNivelModel> GetShowRoomNivel(UsuarioModel model)
        {
            using (var osc = new OfertaServiceClient())
            {
                var showRoomNiveles = osc.GetShowRoomNivel(model.PaisID).ToList();
                return Mapper.Map<List<BEShowRoomNivel> , List<ShowRoomNivelModel>>(showRoomNiveles);
            }
        }

        public List<ShowRoomPersonalizacionModel> GetShowRoomPersonalizacion(UsuarioModel model)
        {
            using (var osc = new OfertaServiceClient())
            {
                var personalizacion = osc.GetShowRoomPersonalizacion(model.PaisID).ToList();
                return Mapper.Map<IList<ServiceOferta.BEShowRoomPersonalizacion>, List<ShowRoomPersonalizacionModel>>(personalizacion).ToList();
            }
        }

        public List<ShowRoomPersonalizacionNivelModel> GetShowRoomPersonalizacionNivel(UsuarioModel model,int eventoId, int showRoomNivelId,int categoriaId)
        {
            using (var osc = new OfertaServiceClient())
            {
                var personalizacionesNivel = osc.GetShowRoomPersonalizacionNivel(model.PaisID, eventoId, showRoomNivelId, categoriaId).ToList();
                return Mapper.Map<List<ServiceOferta.BEShowRoomPersonalizacionNivel>, List<ShowRoomPersonalizacionNivelModel>>(personalizacionesNivel).ToList();
            }
        }
    }
}
