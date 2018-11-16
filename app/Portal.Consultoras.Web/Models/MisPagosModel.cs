namespace Portal.Consultoras.Web.Models
{
    public class MisPagosModel
    {
        public string Simbolo { get; set; }
        public string MontoPagar { get; set; }
        public string FechaVencimiento { get; set; }
        public int TienePagoOnline { get; set; }
        public string UrlPagoOnline { get; set; }
        public int TieneFlexipago { get; set; }
        public string MontoMinimoFlexipago { get; set; }
        public string CorreoConsultora { get; set; }
        public string CodigoISO { get; set; }
        public string UrlChileEncriptada { get; set; }
        public string RutaChile { get; set; }
        public string MostrarFE { get; set; }
        public string PestanhaInicial { get; set; }
        public bool TienePagoEnLinea { get; set; }        
        public bool MostrarPagoEnLinea { get; set; }
    }
}
