using System;
using System.Collections.Generic;
using System.Threading.Tasks;
using Portal.Consultoras.Common;
using Portal.Consultoras.Web.LogManager;
using Portal.Consultoras.Web.Models;
using Portal.Consultoras.Web.ServicePedido;
using Portal.Consultoras.Web.SessionManager;

namespace Portal.Consultoras.Web.Providers
{
    public class RevistaDigitalProvider : OfertaBaseProvider
    {
        private readonly ILogManager logManager = LogManager.LogManager.Instance;
        private readonly ISessionManager sessionManager = SessionManager.SessionManager.Instance;

        public List<BEEstrategia> ObtenerOfertas(int CampaniaId)
        {
            List<BEEstrategia> model = null;

            var userData = sessionManager.GetUserData();

            try
            {
                if (userData.TipoUsuario != Constantes.TipoUsuario.Consultora)
                    return null;

                string pathRevistaDigital = string.Format(Constantes.PersonalizacionOfertasService.UrlObtenerRevistaDigital, userData.CodigoISO, Constantes.ConfiguracionPais.RevistaDigital, CampaniaId, userData.CodigoConsultora, userData.CodigorRegion, userData.ZonaID);
                var taskApi = Task.Run(() => ObtenerOfertasDesdeApi(pathRevistaDigital));

                Task.WhenAll(taskApi);

                model = taskApi.Result;
            }
            catch (Exception ex)
            {
                logManager.LogErrorWebServicesBusWrap(ex, userData.CodigoUsuario, userData.CodigoISO, "OfertaDelDiaProvider.ObtenerOfertas");
            }

            return model;
        }

        public OfertaDelDiaModel ObtenerTonos()
        {
            OfertaDelDiaModel model = null;
            var userData = sessionManager.GetUserData();
            try
            {
                //var diaInicio = DateTime.Now.Date.Subtract(userData.FechaInicioCampania.Date).Days;
                //var taskApi = Task.Run(() => ObtenerOfertasDesdeApi(userData.CodigoISO, Constantes.ConfiguracionPais.OfertaDelDia, userData.CampaniaID, userData.CodigoConsultora, diaInicio));
                // Task.WhenAll(taskApi);
                //var listOfertasDelDias = taskApi.Result;
                //model = ObtenerOfertaDelDiaModel(userData.PaisID, userData.CodigoISO, listOfertasDelDias);
            }
            catch (Exception ex)
            {
                logManager.LogErrorWebServicesBusWrap(ex, userData.CodigoUsuario, userData.CodigoISO, "RevistaDigitalProvider.ObtenerTonos");
            }

            return model;
        }
    }
}