namespace Portal.Consultoras.Web.Models.CaminoBrillante
{
    public class NivelConsultoraCaminoBrillanteModel
    {
        public string PeriodoCae { get; set; }
        public string Campania { get; set; }
        public int NivelActual { get; set; }
        public string MontoPedido { get; set; }
        public string FechaIngreso { get; set; }
        public string KitSolicitado { get; set; }
        public decimal GananciaCampania { get; set; }
        public decimal GananciaPeriodo { get; set; }
        public decimal GananciaAnual { get; set; }
    }
}