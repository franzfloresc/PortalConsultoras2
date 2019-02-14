namespace Portal.Consultoras.Web.Models.Config.ResponseReporte.Estructura
{
    using Newtonsoft.Json;

    public class ReporteValidacionOferta
    {
        public string Pais { get; set; }
        public int Campania { get; set; }
        public string CodigoTO { get; set; }
        public string SAP { get; set; }
        public string CUV { get; set; }
        public string Descripcion { get; set; }
        public double PrecioValorizado { get; set; }
        public double PrecioOferta { get; set; }
        public int UnidadesPermitidas { get; set; }
        public bool EsSubCampania { get; set; }
        public bool HabilitarOferta { get; set; }
        public bool FlagImagenCargada { get; set; }
        public bool FlagImagenMini { get; set; }
    }
}