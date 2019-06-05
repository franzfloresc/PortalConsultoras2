using System.Runtime.Serialization;

namespace Portal.Consultoras.BizLogic.CaminoBrillante.Rest
{

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
        public decimal? PorcentajeIncremento { get; set; }
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
        [DataMember(Name = "VTACAMPRET")]
        public decimal? VentaRetail { get; set; }
        [DataMember(Name = "VTAACUMPERICAE")]
        public decimal? VentaAcumulada { get; set; }
        [DataMember(Name = "PUNTACUMPDR")]
        public int? PuntajeAcumulado { get; set; }
    }
}