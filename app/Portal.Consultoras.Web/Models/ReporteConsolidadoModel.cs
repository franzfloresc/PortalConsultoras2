namespace Portal.Consultoras.Web.Models
{
    public class ReporteConsolidadoModel
    {
        public string CodigoIso { get; set; }
        public int PrefijoISOPais { get; set; }

        public string FechaDesde { get; set; }

        public string FechaHasta { get; set; }

        public string Region { get; set; }
        public string Zona { get; set; }
        public string Seccion { get; set; }

        public string sidx { get; set; }

        public string sord { get; set; }

        public int page { get; set; }

        public int rows { get; set; }

    }
}