using Newtonsoft.Json;
using Portal.Consultoras.Common;
using System.Collections.Generic;
using System.Net.Http;
using System.Net.Http.Headers;
using System.Runtime.Serialization;
using System.Threading.Tasks;

namespace Portal.Consultoras.BizLogic.CaminoBrillante
{
    /// <summary>
    /// Cualquier modificacion en este Provider debera ser aplicado en el CaminoBrillanteProvider de SomosBelcorp. 
    /// </summary>
    public class CaminoBrillanteProvider
    {
        private string Url;
        private string Token;

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
            result = JsonConvert.DeserializeObject<List<PeriodoCaminoBrillante>>(jsonString) as List<PeriodoCaminoBrillante>;
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
            result = JsonConvert.DeserializeObject<List<NivelConsultoraCaminoBrillante>>(jsonString) as List<NivelConsultoraCaminoBrillante>;
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
            result = JsonConvert.DeserializeObject<List<NivelCaminoBrillante>>(jsonString) as List<NivelCaminoBrillante>;
            return result;
        }

        /// <summary>
        /// Obtiene el listado de Ofertas de acuerdo a la campaña.
        /// </summary>
        public async Task<List<OfertaCaminoBrillante>> GetOfertas(string isoPais, string campania)
        {
            var result = new List<OfertaCaminoBrillante>();
            bool flag = campania != "";
            if (!flag) return result;
            string urlParameters = string.Format("{0}/{1}", isoPais, campania);
            string jsonString = await CallInformacionComercialServices(Url, urlParameters, Token);
            result = JsonConvert.DeserializeObject<List<OfertaCaminoBrillante>>(jsonString) as List<OfertaCaminoBrillante>;
            return result;
        }

        /// <summary>
        /// Obtiene los kits para cada consultora.
        /// </summary>
        public async Task<List<KitsHistoricoConsultora>> GetKitHistoricoConsultora(string isoPais, string consultora, string campania)
        {
            var result = new List<KitsHistoricoConsultora>();
            bool flag = isoPais != "" && campania != "";
            if (!flag) return result;
            string urlParameters = string.Format("{0}/{1}/{2}", isoPais, consultora, campania);
            string jsonString = await CallInformacionComercialServices(Url, urlParameters, Token);
            result = JsonConvert.DeserializeObject<List<KitsHistoricoConsultora>>(jsonString) as List<KitsHistoricoConsultora>;
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
                HttpContent content = response.Content;

                if (response.IsSuccessStatusCode)
                {
                    jsonString = response.Content.ReadAsStringAsync().Result;
                }
            }
            return jsonString;
        }

    }

    [DataContract]
    public class NivelCaminoBrillante
    {
        [DataMember(Name = "CODIGONIVEL")]
        public string CodigoNivel { get; set; }
        [DataMember(Name = "DESCRIPCIONNIVEL")]
        public string DescripcionNivel { get; set; }
        [DataMember(Name = "MONTOMINIMO")]
        public string MontoMinimo { get; set; }
        [DataMember(Name = "MONTOMAXIMO")]
        public string MontoMaximo { get; set; }
        [DataMember(Name = "BENEFICIO1")]
        public string Beneficio1 { get; set; }
        [DataMember(Name = "BENEFICIO2")]
        public string Beneficio2 { get; set; }
        [DataMember(Name = "BENEFICIO3")]
        public string Beneficio3 { get; set; }
        [DataMember(Name = "BENEFICIO4")]
        public string Beneficio4 { get; set; }
        [DataMember(Name = "BENEFICIO5")]
        public string Beneficio5 { get; set; }
    }

    [DataContract]
    public class NivelConsultoraCaminoBrillante
    {
        [DataMember(Name = "ISOPAIS")]
        public string IsoPais { get; set; }
        [DataMember(Name = "PERIODOCAE")]
        public string PeriodoCae { get; set; }
        [DataMember(Name = "CAMPANA")]
        public string Campania { get; set; }
        [DataMember(Name = "NIVELACTUAL")]
        public string NivelActual { get; set; }
        [DataMember(Name = "MONTOPEDIDO")]
        public string MontoPedido { get; set; }
        [DataMember(Name = "FECHAINGRESO")]
        public string FechaIngreso { get; set; }
        [DataMember(Name = "KITSOLICITADO")]
        public string KitSolicitado { get; set; }
        [DataMember(Name = "GANANCIACAMPANA")]
        public decimal GananciaCampania { get; set; }
        [DataMember(Name = "GANANCIAPERIODO")]
        public decimal GananciaPeriodo { get; set; }
        [DataMember(Name = "GANANCIAANUAL")]
        public decimal GananciaAnual { get; set; }
        [DataMember(Name = "CAMBIOESCALA")]
        public int CambioEscala { get; set; }
        [DataMember(Name = "CAMBIONIVEL")]
        public int CambioNivel { get; set; }
        [DataMember(Name = "PORCENTAJEINCREMENTO")]
        public int PorcentajeIncremento { get; set; }
        [DataMember(Name = "CONSTANCIA1")]
        public int Constancia1 { get; set; }
        [DataMember(Name = "CONSTANCIA2")]
        public int Constancia2 { get; set; }
        [DataMember(Name = "CONSTANCIA3")]
        public int Constancia3 { get; set; }
        [DataMember(Name = "CONSTANCIA4")]
        public int Constancia4 { get; set; }
        [DataMember(Name = "CONSTANCIA5")]
        public int Constancia5 { get; set; }
        [DataMember(Name = "PERIODO1")]
        public string Periodo1 { get; set; }
        [DataMember(Name = "PERIODO2")]
        public string Periodo2 { get; set; }
        [DataMember(Name = "PERIODO3")]
        public string Periodo3 { get; set; }
        [DataMember(Name = "PERIODO4")]
        public string Periodo4 { get; set; }
        [DataMember(Name = "PERIODO5")]
        public string Periodo5 { get; set; }
    }

    [DataContract]
    public class PeriodoCaminoBrillante
    {
        [DataMember(Name = "ISOPAIS")]
        public string IsoPais { get; set; }
        [DataMember(Name = "PERIODO")]
        public string Periodo { get; set; }
        [DataMember(Name = "CAMPANAINICIAL")]
        public string CampanaInicial { get; set; }
        [DataMember(Name = "CAMPANAFINAL")]
        public string CampanaFinal { get; set; }
        [DataMember(Name = "NROCAMPANA")]
        public string NroCampana { get; set; }

    }

    [DataContract]
    public class OfertaCaminoBrillante
    {
        [DataMember(Name = "ISOPAIS")]
        public string IsoPais { get; set; }
        [DataMember(Name = "CODIGOKIT")]
        public string CodigoKit { get; set; }
        [DataMember(Name = "CUV")]
        public string Cuv { get; set; }
        [DataMember(Name = "CODIGOSAP")]
        public string CodigoSap { get; set; }
        [DataMember(Name = "DESCRIPCION")]
        public string Descripcion { get; set; }
        [DataMember(Name = "PRECIO")]
        public decimal Precio { get; set; }
        [DataMember(Name = "MARCA")]
        public string Marca { get; set; }
        [DataMember(Name = "DIGITABLE")]
        public int Digitable { get; set; }
        [DataMember(Name = "DESCRIPCIONOFERTA")]
        public string DescripcionOferta { get; set; }
        [DataMember(Name = "NIVEL")]
        public string Nivel { get; set; }

    }

    [DataContract]
    public class KitsHistoricoConsultora
    {
        [DataMember(Name = "ISOPAIS")]
        public string IsoPais { get; set; }
        [DataMember(Name = "CODIGOKIT")]
        public string CodigoKit { get; set; }
        [DataMember(Name = "CAMPANAATENCION")]
        public string CampaniaAtencion { get; set; }

    }

}
