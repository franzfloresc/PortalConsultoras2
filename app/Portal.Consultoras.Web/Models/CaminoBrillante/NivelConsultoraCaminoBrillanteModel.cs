using System.Collections.Generic;
using System.Runtime.Serialization;

namespace Portal.Consultoras.Web.Models.CaminoBrillante
{
    [DataContract]
    public class NivelConsultoraCaminoBrillanteModel
    {
        public string ISOPAIS { get; set; }
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
    }
}