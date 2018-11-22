using System.Threading.Tasks;
using Portal.Consultoras.Common;
using Portal.Consultoras.Web.Models;
using Portal.Consultoras.Web.Models.Recomendaciones;
using Portal.Consultoras.Web.SessionManager;

namespace Portal.Consultoras.Web.Providers
{
    public class RecomendacionesProvider : BuscadorBaseProvider
    {
        protected ISessionManager _sessionManager;

        public RecomendacionesProvider()
        {
            _sessionManager = SessionManager.SessionManager.Instance;
        }

        public async Task<RecomendacionesModel> ObtenerRecomendaciones(string cuv, string codigoProducto)
        {
            var revistaDigital = _sessionManager.GetRevistaDigital();
            var userData = _sessionManager.GetUserData();
            var pathBuscador = string.Format(Constantes.RutaBuscadorService.UrlBuscador,
                userData.CodigoISO,
                userData.CampaniaID,
                ObtenerOrigen()
            );

            var jsonConsultar = GenerarJsonParaConsulta(userData, revistaDigital, cuv, codigoProducto);
            return await PostAsync<RecomendacionesModel>(pathBuscador, jsonConsultar);
        }

        private dynamic GenerarJsonParaConsulta(UsuarioModel usuarioModel, RevistaDigitalModel revistaDigital, string cuv, string codigoProducto)
        {
            var suscripcion = (revistaDigital.EsSuscrita && revistaDigital.EsActiva);
            return new
            {
                codigoConsultora = usuarioModel.CodigoConsultora,
                codigoZona = usuarioModel.CodigoZona,
                cuv,
                codigoProducto,
                personalizaciones = usuarioModel.PersonalizacionesDummy,
                configuracion = new
                {
                    sociaEmpresaria = usuarioModel.Lider.ToString(),
                    suscripcionActiva = suscripcion.ToString(),
                    mdo = revistaDigital.ActivoMdo.ToString(),
                    rd = revistaDigital.TieneRDC.ToString(),
                    rdi = revistaDigital.TieneRDI.ToString(),
                    rdr = revistaDigital.TieneRDCR.ToString(),
                    diaFacturacion = usuarioModel.DiaFacturacion
                }
            };
        }

    }
}