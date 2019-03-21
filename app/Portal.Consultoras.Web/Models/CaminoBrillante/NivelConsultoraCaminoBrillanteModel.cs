using System;
using System.Runtime.Serialization;

namespace Portal.Consultoras.Web.Models.CaminoBrillante
{
    [Serializable()]
    [DataContract]
    public class NivelConsultoraCaminoBrillanteModel
    {
        [DataMember]
        public string PeriodoCae { get; set; }
        [DataMember]
        public string Campania { get; set; }
        [DataMember]
        public int NivelActual { get; set; }
        [DataMember]
        public string MontoPedido { get; set; }
        [DataMember]
        public string FechaIngreso { get; set; }
        [DataMember]
        public string KitSolicitado { get; set; }
        [DataMember]
        public decimal GananciaCampania { get; set; }
        [DataMember]
        public decimal GananciaPeriodo { get; set; }
        [DataMember]
        public decimal GananciaAnual { get; set; }
    }
}