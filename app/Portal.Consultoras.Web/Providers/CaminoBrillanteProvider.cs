using Newtonsoft.Json;
using System.Collections.Generic;
using System.Net.Http;
using System.Threading.Tasks;
using System.Net.Http.Headers;
using Portal.Consultoras.Web.Models.CaminoBrillante;
using Portal.Consultoras.Common;


namespace Portal.Consultoras.Web.Providers
{
    public class CaminoBrillanteProvider
    {
        public CaminoBrillanteProvider(string url, string usuario, string clave)
        {
            Url = url;
            Token = Util.Base64Encode(usuario + ":" + clave);
        }

        private string Url { get; set; }
        private string Token { get; set; }

        /// <summary>
        /// Obtiene información de los niveles de la Consultora. 
        /// </summary>
        //public async Task<List<NivelConsultoraCaminoBrillanteModel>> GetNivelConsultora(string isoPais, string codigoConsultora, string cantidadCampanias)
        //{
        //    var result = new List<NivelConsultoraCaminoBrillanteModel>();
        //    bool flag = isoPais != "" && codigoConsultora != "" && cantidadCampanias != "";
        //    if (!flag) return result;
        //    string urlParameters = isoPais + "/" + codigoConsultora + "/" + cantidadCampanias;
        //    string jsonString = await CallInformacionComercialServices(Url, urlParameters, Token, Constantes.MetodosInformacionComercial.GetNivelConsultora);
        //    result = JsonConvert.DeserializeObject<List<NivelConsultoraCaminoBrillanteModel>>(jsonString) as List<NivelConsultoraCaminoBrillanteModel>;
        //    return result;
        //}
        public List<NivelConsultoraCaminoBrillanteModel> GetNivelConsultora(string isoPais, string codigoConsultora, string cantidadCampanias)
        {
            var result = new List<NivelConsultoraCaminoBrillanteModel>();
            bool flag = isoPais != "" && codigoConsultora != "" && cantidadCampanias != "";
            if (!flag) return result;
            string urlParameters = isoPais + "/" + codigoConsultora + "/" + cantidadCampanias;
            string jsonString = CallInformacionComercialServices(Url, urlParameters, Token, Constantes.MetodosInformacionComercial.GetNivelConsultora);
            result = JsonConvert.DeserializeObject<List<NivelConsultoraCaminoBrillanteModel>>(jsonString) as List<NivelConsultoraCaminoBrillanteModel>;
            return result;
        }











        /// <summary>
        /// Obtiene información de los Niveles.
        /// </summary>
        //public async Task<List<NivelesCaminoBrillanteModel>> GetNivel(string isoPais)
        //{
        //    var result = new List<NivelesCaminoBrillanteModel>();
        //    bool flag = isoPais != "";
        //    if (!flag) return result;
        //    string urlParameters = isoPais;
        //    string jsonString = await CallInformacionComercialServices(Url, urlParameters, Token, Constantes.MetodosInformacionComercial.GetNivel);
        //    result = JsonConvert.DeserializeObject<List<NivelesCaminoBrillanteModel>>(jsonString) as List<NivelesCaminoBrillanteModel>;
        //    return result;
        //}
        public List<NivelesCaminoBrillanteModel> GetNivel(string isoPais)
        {
            var result = new List<NivelesCaminoBrillanteModel>();
            bool flag = isoPais != "";
            if (!flag) return result;
            string urlParameters = isoPais;
            string jsonString = CallInformacionComercialServices(Url, urlParameters, Token, Constantes.MetodosInformacionComercial.GetNivel);
            result = JsonConvert.DeserializeObject<List<NivelesCaminoBrillanteModel>>(jsonString) as List<NivelesCaminoBrillanteModel>;
            return result;
        }











        ///// <summary>
        ///// Obtiene el listado de Ofertas de acuerdo a la campaña.
        ///// </summary>
        //public async Task<List<BENivelConsultoraCaminoBrillante>> GetOfertas(string campania)
        //{
        //    var result = new List<BENivelConsultoraCaminoBrillante>();
        //    bool flag = campania != "";
        //    if (!flag) return result;
        //    string urlParameters = campania;
        //    string jsonString = await CallInformacionComercialServices(Url, urlParameters, Token);
        //    result = JsonConvert.DeserializeObject<List<BENivelConsultoraCaminoBrillante>>(jsonString) as List<BENivelConsultoraCaminoBrillante>;
        //    return result;
        //}

        ///// <summary>
        ///// Obtiene los datos del periodo de acuerdo a cada País y consultora.
        ///// </summary>
        //public async Task<List<BENivelConsultoraCaminoBrillante>> GetPeriodo(string isoPais)
        //{
        //    var result = new List<BENivelConsultoraCaminoBrillante>();
        //    bool flag = isoPais != "";
        //    if (!flag) return result;
        //    string urlParameters = isoPais;
        //    string jsonString = await CallInformacionComercialServices(Url, urlParameters, Token);
        //    result = JsonConvert.DeserializeObject<List<BENivelConsultoraCaminoBrillante>>(jsonString) as List<BENivelConsultoraCaminoBrillante>;
        //    return result;
        //}

        ///// <summary>
        ///// Obtiene los kits para cada consultora.
        ///// </summary>
        //public async Task<List<BENivelConsultoraCaminoBrillante>> GetKitsConsultora(string isoPais, string campania)
        //{
        //    var result = new List<BENivelConsultoraCaminoBrillante>();
        //    bool flag = isoPais != "" && campania != "";
        //    if (!flag) return result;
        //    string urlParameters = isoPais + "/" + campania;
        //    string jsonString = await CallInformacionComercialServices(Url, urlParameters, Token);
        //    result = JsonConvert.DeserializeObject<List<BENivelConsultoraCaminoBrillante>>(jsonString) as List<BENivelConsultoraCaminoBrillante>;
        //    return result;
        //}

        /// <summary>
        /// Metodo para conectar y obtener la informacion solicitada al servcio de informacion comercial.
        /// </summary>
        //private static async Task<string> CallInformacionComercialServices(string url, string urlParameters, string token, string Method)
        //{
        //    string jsonString = string.Empty;
        //    using (var client = new HttpClient())
        //    {
        //        client.DefaultRequestHeaders.Accept.Add(new MediaTypeWithQualityHeaderValue("application/json"));
        //        client.DefaultRequestHeaders.ConnectionClose = true;
        //        client.DefaultRequestHeaders.Authorization = new AuthenticationHeaderValue("Basic", "QUtJQUlZRVRTUlVKRFZQVUpNVlE6NjN0U05NT1VxUTJ3QUgxNktXTC9uZnpPdS9xV3BrcHo5VEZtMjFUaQ==");
        //        HttpResponseMessage response = await client.GetAsync(url + Method + urlParameters);

        //        HttpContent content = response.Content;

        //        if (response.IsSuccessStatusCode)
        //        {
        //            jsonString = response.Content.ReadAsStringAsync().Result;
        //        }
        //    }
        //    return jsonString;
        //}

        private static string CallInformacionComercialServices(string url, string urlParameters, string token, string Method)
        {
            string jsonString = string.Empty;
            using (var client = new HttpClient())
            {
                client.DefaultRequestHeaders.Accept.Add(new MediaTypeWithQualityHeaderValue("application/json"));
                client.DefaultRequestHeaders.ConnectionClose = true;
                client.DefaultRequestHeaders.Authorization = new AuthenticationHeaderValue("Basic", "QUtJQUlZRVRTUlVKRFZQVUpNVlE6NjN0U05NT1VxUTJ3QUgxNktXTC9uZnpPdS9xV3BrcHo5VEZtMjFUaQ==");
                HttpResponseMessage response = client.GetAsync(url + Method + urlParameters).Result;

                HttpContent content = response.Content;

                if (response.IsSuccessStatusCode)
                {
                    jsonString = response.Content.ReadAsStringAsync().Result;
                }
            }
            return jsonString;
        }
    }
}