namespace Portal.Consultoras.Web.Models
{
    public class FiltroReporteChatBotModel
    {
        public string PaisID { get; set; }
        public string Consultora { get; set; }
        public string NombreOperador { get; set; }
        public string FechaInicio { get; set; }
        public string FechaFin { get; set; } 
        public string Sidx { get; set; }
        public string Sord { get; set; }
        public int Page { get; set; }
        public int Rows { get; set; }

    }
}