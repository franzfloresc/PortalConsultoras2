using System.Linq;
using System.Threading.Tasks;
using Portal.Consultoras.Common;
using Portal.Consultoras.Web.Models;
using Portal.Consultoras.Web.Models.Recomendaciones;
using Portal.Consultoras.Web.SessionManager;

namespace Portal.Consultoras.Web.Providers
{
    public class RecomendacionesProvider : BuscadorBaseProvider
    {
        protected RecomendacionesConfiguracionModel _recomendacionesConfiguracion;

        public RecomendacionesProvider()
        {
            _sessionManager = SessionManager.SessionManager.Instance;
            _recomendacionesConfiguracion = _sessionManager.GetRecomendacionesConfig();
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

        public bool ValidarRecomendacionActivo()
        {
            return (from item 
                    in _recomendacionesConfiguracion.ConfiguracionPaisDatos
                    where item.Codigo == Constantes.CodigoConfiguracionRecomendaciones.ActivarRecomendaciones
                    select item.Valor1)
                .FirstOrDefault()
                .ToBool();
        }

        private dynamic GenerarJsonParaConsulta(UsuarioModel usuarioModel, RevistaDigitalModel revistaDigital, string cuv, string codigoProducto)
        {
            var suscripcion = (revistaDigital.EsSuscrita && revistaDigital.EsActiva);
            var personalizaciones = "";
            var buscadorConfig = _sessionManager.GetBuscadorYFiltrosConfig();
            if (buscadorConfig != null)
                personalizaciones = buscadorConfig.PersonalizacionDummy ?? "";
            
            return new
            {
                codigoConsultora = usuarioModel.CodigoConsultora,
                codigoZona = usuarioModel.CodigoZona,
                cuv,
                codigoProducto,
                personalizaciones = personalizaciones,
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