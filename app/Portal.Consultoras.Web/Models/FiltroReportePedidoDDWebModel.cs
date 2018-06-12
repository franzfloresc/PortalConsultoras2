namespace Portal.Consultoras.Web.Models
{
    public class FiltroReportePedidoDDWebModel
    {
        public string PaisID { get; set; }
        public string CodigoISO { get; set; }
        public string Campania { get; set; }
        public string Consultora { get; set; }
        public string RegionID { get; set; }
        public string ZonaID { get; set; }
        public string Origen { get; set; }
        public string EstadoValidacion { get; set; }
        public string EsRechazado { get; set; }
        public string FechaInicio { get; set; }
        public string FechaFin { set; get; }
        public string Sidx { get; set; }
        public string Sord { get; set; }
        public int Page { get; set; }
        public int Rows { get; set; }

        public bool EsPrimeraBusqueda { get; set; }
        public string UniqueId
        {
            get { return PaisID + Campania + Consultora + RegionID + ZonaID + Origen + EstadoValidacion + EsRechazado + FechaInicio + FechaFin; }
        }
    }
}