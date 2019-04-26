using Newtonsoft.Json;
using Portal.Consultoras.BizLogic.CaminoBrillante.Rest;
using Portal.Consultoras.Common;
using System.Collections.Generic;
using System.Net.Http;
using System.Net.Http.Headers;
using System.Threading.Tasks;

namespace Portal.Consultoras.BizLogic.CaminoBrillante
{
    /// <summary>
    /// Cualquier modificacion en este Provider debera ser aplicado en el CaminoBrillanteProvider de SomosBelcorp. 
    /// </summary>
    public class CaminoBrillanteProvider
    {
        private readonly string Url;
        private readonly string Token;

        public CaminoBrillanteProvider(string url, string usuario, string clave)
        {
            Url = url;
            Token = Util.Base64Encode(usuario + ":" + clave);
        }

        /// <summary>
        /// Obtiene los datos del periodo de acuerdo a cada País y consultora.
        /// </summary>
        public async Task<List<PeriodoCaminoBrillante>> GetPeriodo(string isoPais)
        {
            var result = new List<PeriodoCaminoBrillante>();
            bool flag = isoPais != "";
            if (!flag) return result;
            string urlParameters = isoPais;
            string jsonString = await CallInformacionComercialServices(Url +Constantes.CaminoBrillante.ServicioComercial.GetPeriodo, urlParameters, Token);
            result = JsonConvert.DeserializeObject<List<PeriodoCaminoBrillante>>(jsonString);
            return result;
        }

        /// <summary>
        /// Obtiene información de los niveles de la Consultora.
        /// </summary>
        public async Task<List<NivelConsultoraCaminoBrillante>> GetNivelConsultora(string isoPais, string codigoConsultora, string cantidadCampanias)
        {
            var result = new List<NivelConsultoraCaminoBrillante>();
            bool flag = !string.IsNullOrEmpty(isoPais) && !string.IsNullOrEmpty(codigoConsultora) && !string.IsNullOrEmpty(cantidadCampanias);
            if (!flag) return result;
            string urlParameters = isoPais + "/" + codigoConsultora + "/" + cantidadCampanias;
            string jsonString = await CallInformacionComercialServices(Url + Constantes.CaminoBrillante.ServicioComercial.GetNivelConsultora, urlParameters, Token);
            result = JsonConvert.DeserializeObject<List<NivelConsultoraCaminoBrillante>>(jsonString);
            return result;
        }

        /// <summary>
        /// Obtiene información de los Niveles.
        /// </summary>
        public async Task<List<NivelCaminoBrillante>> GetNivel(string isoPais)
        {
            var result = new List<NivelCaminoBrillante>();
            bool flag = isoPais != "";
            if (!flag) return result;
            string urlParameters = isoPais;
            string jsonString = await CallInformacionComercialServices(Url + Constantes.CaminoBrillante.ServicioComercial.GetNivel, urlParameters, Token);
            result = JsonConvert.DeserializeObject<List<NivelCaminoBrillante>>(jsonString);
            return result;
        }

        /// <summary>
        /// Obtiene el listado de Ofertas de acuerdo a la campaña.
        /// </summary>
        public async Task<List<OfertaCaminoBrillante>> GetOfertas(string isoPais, int campaniaId)
        {
            string urlParameters = string.Format("{0}/{1}", isoPais, campaniaId);
            string jsonString = await CallInformacionComercialServices(Url + Constantes.CaminoBrillante.ServicioComercial.GetOfertas, urlParameters, Token);
            var result = JsonConvert.DeserializeObject<List<OfertaCaminoBrillante>>(jsonString);
            return result;
        }

        /// <summary>
        /// Obtiene los kits para cada consultora.
        /// </summary>
        public async Task<List<KitsHistoricoConsultora>> GetKitHistoricoConsultora(string isoPais, string consultora, int periodoId)
        {
            var result = new List<KitsHistoricoConsultora>();
            bool flag = isoPais != "";
            if (!flag) return result;

            string urlParameters = string.Format("{0}/{1}/{2}", isoPais, consultora, periodoId);
            string jsonString = await CallInformacionComercialServices(Url + Constantes.CaminoBrillante.ServicioComercial.GetKitsConsultora, urlParameters, Token);
            result = JsonConvert.DeserializeObject<List<KitsHistoricoConsultora>>(jsonString);
            return result;
        }

        /// <summary>
        /// Metodo para conectar y obtener la informacion solicitada al servcio de informacion comercial.
        /// </summary>
        private static async Task<string> CallInformacionComercialServices(string url, string urlParameters, string token)
        {
            string jsonString = string.Empty;
            using (var client = new HttpClient())
            {
                client.DefaultRequestHeaders.Accept.Add(new MediaTypeWithQualityHeaderValue("application/json"));
                client.DefaultRequestHeaders.ConnectionClose = true;
                client.DefaultRequestHeaders.Authorization = new AuthenticationHeaderValue("Basic", token);
                HttpResponseMessage response = await client.GetAsync(url + urlParameters);

                if (response.IsSuccessStatusCode)
                {
                    jsonString = response.Content.ReadAsStringAsync().Result;
                }
            }
            return jsonString;
        }

    }

}
