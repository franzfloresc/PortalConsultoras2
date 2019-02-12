namespace Portal.Consultoras.Web.Models.Config.ResponseReporte.Estructura
{
    using Newtonsoft.Json;

    public class ReporteValidacionCampania
    {
        public string Pais { get; set; }
        public int Campania { get; set; }
        public string NombreEvento { get; set; }
        public int DiasAntes { get; set; }
        public int DiasDespues { get; set; }
        public int FlagHabilitarEvento { get; set; }
        public int FlagHabilitarCompraXCompra { get; set; }
        public int FlagHabilitarSubCampania { get; set; }
        public int FlagHabilitarPersonalizacion { get; set; }
    }
}