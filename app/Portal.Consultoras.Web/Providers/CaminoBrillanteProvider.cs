using Newtonsoft.Json;
using System.Collections.Generic;
using System.Net.Http;
using System.Threading.Tasks;
using System.Net.Http.Headers;
using Portal.Consultoras.Web.Models.CaminoBrillante;
using Portal.Consultoras.Common;
using Portal.Consultoras.Web.ServiceUsuario;
using System.Linq;
using System;
using Portal.Consultoras.Web.SessionManager;
using Portal.Consultoras.Web.Models;

namespace Portal.Consultoras.Web.Providers
{
    public class CaminoBrillanteProvider
    {
        protected ISessionManager sessionManager;
        private UsuarioModel UsuarioDatos
        {
            get { return sessionManager.GetUserData(); }
        }

        public CaminoBrillanteProvider()
        {}
        
        public BENivelCaminoBrillante ObtenerNivelActualConsultora()
        {
            try
            {
                var oResumen = ResumenConsultoraCaminoBrillante();
                if (oResumen == null || oResumen.NivelConsultora.Count() == 0 || oResumen.Niveles.Count() == 0) return null;
                var codNivel = oResumen.NivelConsultora.Where(x => x.Campania == UsuarioDatos.CampaniaID.ToString()).Select(z => z.NivelActual).FirstOrDefault();
                if (string.IsNullOrEmpty(codNivel)) codNivel = oResumen.NivelConsultora[0].NivelActual;
                return oResumen.Niveles.Where(x => x.CodigoNivel == codNivel).FirstOrDefault();
            }
            catch (Exception ex)
            {
                LogManager.LogManager.LogErrorWebServicesBus(ex, UsuarioDatos.CodigoConsultora, UsuarioDatos.CodigoISO);
                return null;
            }
        }

        public BEConsultoraCaminoBrillante ResumenConsultoraCaminoBrillante()
        {
            var usuarioDatos = new ServiceUsuario.BEUsuario();
            usuarioDatos.CodigoConsultora = UsuarioDatos.CodigoConsultora;
            usuarioDatos.CampaniaID = UsuarioDatos.CampaniaID;
            usuarioDatos.Region = UsuarioDatos.CodigorRegion;
            usuarioDatos.Zona = UsuarioDatos.CodigoZona;

            using (var svc = new UsuarioServiceClient())
                return svc.GetConsultoraNivelCaminoBrillante(UsuarioDatos.PaisID, usuarioDatos);
        }






               ///// <summary>
        ///// Obtiene información de los Niveles.
        ///// </summary>
        ////public async Task<List<NivelesCaminoBrillanteModel>> GetNivel(string isoPais)
        ////{
        ////    var result = new List<NivelesCaminoBrillanteModel>();
        ////    bool flag = isoPais != "";
        ////    if (!flag) return result;
        ////    string urlParameters = isoPais;
        ////    string jsonString = await CallInformacionComercialServices(Url, urlParameters, Token, Constantes.MetodosInformacionComercial.GetNivel);
        ////    result = JsonConvert.DeserializeObject<List<NivelesCaminoBrillanteModel>>(jsonString) as List<NivelesCaminoBrillanteModel>;
        ////    return result;
        ////}
        //public List<NivelesCaminoBrillanteModel> GetNivel(string isoPais)
        //{
        //    var result = new List<NivelesCaminoBrillanteModel>();
        //    bool flag = isoPais != "";
        //    if (!flag) return result;
        //    string urlParameters = isoPais;
        //    string jsonString = CallInformacionComercialServices(Url, urlParameters, Token, Constantes.MetodosInformacionComercial.GetNivel);
        //    result = JsonConvert.DeserializeObject<List<NivelesCaminoBrillanteModel>>(jsonString) as List<NivelesCaminoBrillanteModel>;
        //    return result;
        //}











        /////// <summary>
        /////// Obtiene el listado de Ofertas de acuerdo a la campaña.
        /////// </summary>
        ////public async Task<List<BENivelConsultoraCaminoBrillante>> GetOfertas(string campania)
        ////{
        ////    var result = new List<BENivelConsultoraCaminoBrillante>();
        ////    bool flag = campania != "";
        ////    if (!flag) return result;
        ////    string urlParameters = campania;
        ////    string jsonString = await CallInformacionComercialServices(Url, urlParameters, Token);
        ////    result = JsonConvert.DeserializeObject<List<BENivelConsultoraCaminoBrillante>>(jsonString) as List<BENivelConsultoraCaminoBrillante>;
        ////    return result;
        ////}

        /////// <summary>
        /////// Obtiene los datos del periodo de acuerdo a cada País y consultora.
        /////// </summary>
        ////public async Task<List<BENivelConsultoraCaminoBrillante>> GetPeriodo(string isoPais)
        ////{
        ////    var result = new List<BENivelConsultoraCaminoBrillante>();
        ////    bool flag = isoPais != "";
        ////    if (!flag) return result;
        ////    string urlParameters = isoPais;
        ////    string jsonString = await CallInformacionComercialServices(Url, urlParameters, Token);
        ////    result = JsonConvert.DeserializeObject<List<BENivelConsultoraCaminoBrillante>>(jsonString) as List<BENivelConsultoraCaminoBrillante>;
        ////    return result;
        ////}

        /////// <summary>
        /////// Obtiene los kits para cada consultora.
        /////// </summary>
        ////public async Task<List<BENivelConsultoraCaminoBrillante>> GetKitsConsultora(string isoPais, string campania)
        ////{
        ////    var result = new List<BENivelConsultoraCaminoBrillante>();
        ////    bool flag = isoPais != "" && campania != "";
        ////    if (!flag) return result;
        ////    string urlParameters = isoPais + "/" + campania;
        ////    string jsonString = await CallInformacionComercialServices(Url, urlParameters, Token);
        ////    result = JsonConvert.DeserializeObject<List<BENivelConsultoraCaminoBrillante>>(jsonString) as List<BENivelConsultoraCaminoBrillante>;
        ////    return result;
        ////}

        ///// <summary>
        ///// Metodo para conectar y obtener la informacion solicitada al servcio de informacion comercial.
        ///// </summary>
        ////private static async Task<string> CallInformacionComercialServices(string url, string urlParameters, string token, string Method)
        ////{
        ////    string jsonString = string.Empty;
        ////    using (var client = new HttpClient())
        ////    {
        ////        client.DefaultRequestHeaders.Accept.Add(new MediaTypeWithQualityHeaderValue("application/json"));
        ////        client.DefaultRequestHeaders.ConnectionClose = true;
        ////        client.DefaultRequestHeaders.Authorization = new AuthenticationHeaderValue("Basic", "QUtJQUlZRVRTUlVKRFZQVUpNVlE6NjN0U05NT1VxUTJ3QUgxNktXTC9uZnpPdS9xV3BrcHo5VEZtMjFUaQ==");
        ////        HttpResponseMessage response = await client.GetAsync(url + Method + urlParameters);

        ////        HttpContent content = response.Content;

        ////        if (response.IsSuccessStatusCode)
        ////        {
        ////            jsonString = response.Content.ReadAsStringAsync().Result;
        ////        }
        ////    }
        ////    return jsonString;
        ////}

        //private static string CallInformacionComercialServices(string url, string urlParameters, string token, string Method)
        //{
        //    string jsonString = string.Empty;
        //    using (var client = new HttpClient())
        //    {
        //        client.DefaultRequestHeaders.Accept.Add(new MediaTypeWithQualityHeaderValue("application/json"));
        //        client.DefaultRequestHeaders.ConnectionClose = true;
        //        client.DefaultRequestHeaders.Authorization = new AuthenticationHeaderValue("Basic", "QUtJQUlZRVRTUlVKRFZQVUpNVlE6NjN0U05NT1VxUTJ3QUgxNktXTC9uZnpPdS9xV3BrcHo5VEZtMjFUaQ==");
        //        HttpResponseMessage response = client.GetAsync(url + Method + urlParameters).Result;

        //        HttpContent content = response.Content;

        //        if (response.IsSuccessStatusCode)
        //        {
        //            jsonString = response.Content.ReadAsStringAsync().Result;
        //        }
        //    }
        //    return jsonString;
        //}
    }
}