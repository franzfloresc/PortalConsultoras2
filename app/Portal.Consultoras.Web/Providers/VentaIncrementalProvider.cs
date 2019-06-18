using System;
using System.Collections.Generic;
using System.Linq;
using System.Net.Http;
using System.Net.Http.Headers;
using System.Text;
using System.Threading.Tasks;
using System.Web;
using Newtonsoft.Json;
using Portal.Consultoras.Common;
using Portal.Consultoras.Web.Models.ElasticSearch;
using Portal.Consultoras.Web.SessionManager;

namespace Portal.Consultoras.Web.Providers
{
    public class VentaIncrementalProvider : OfertaBaseProvider
    {
        protected static TablaLogicaProvider _tablaLogicaProvider;
        private const string contentType = "application/json";
        private readonly ISessionManager _sessionManager = SessionManager.SessionManager.Instance;

        public VentaIncrementalProvider()
        {
            _tablaLogicaProvider = new TablaLogicaProvider();
        }

        public bool validarActivacion(string tipo)
        {
            //Todo: validacion de carruseles
            return true;
        }

        public virtual async Task<OutputProductosIncremental> ObtenerProductosIncremental(string cuv, string tipo)
        {
            try
            {
                var userData = _sessionManager.GetUserData();
                var path = string.Format(Constantes.PersonalizacionOfertasService.UrlVentaIncremental,
                    userData.CodigoISO,
                    userData.CampaniaID,
                    ObtenerOrigen()
                );
                var jsonData = GenerarJsonParaConsulta(userData.CodigoConsultora, cuv, tipo);

                return await PostAsyncMicroservicioSearch<OutputProductosIncremental>(path, jsonData);
            }
            catch (Exception)
            {
                return new OutputProductosIncremental();
            }
        }

        private dynamic GenerarJsonParaConsulta(string codigoConsultora, string cuv, string tipo)
        {
            return new
            {
                codigoConsultora,
                cuv,
                segmento = new[]{tipo}
            };
        }

        public string ObtenerOrigen()
        {
            return Util.EsDispositivoMovil() ? "sb-mobile" : "sb-desktop";
        }
    }
}