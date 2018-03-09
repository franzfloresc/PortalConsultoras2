namespace Portal.Consultoras.Web.Models
{
    public class PercepcionesModel
    {
        public string CodigoConsultora { get; set; }
        public string CodigoTerritorial { get; set; }

        public string IdComprobantePercepcion { get; set; }
        public string RUCAgentePerceptor { get; set; }
        public string FechaEmision { get; set; }
        public string NombreAgentePerceptor { get; set; }
        public string NumeroComprobanteSerie { get; set; }
        public string ImportePercepcion { get; set; }
        public string ImportePercepcionTexto { get; set; }

        public string RazonSocial { get; set; }
        public string Direccion { get; set; }
        public string RUC { get; set; }

    }
}