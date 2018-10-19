using System.Collections.Generic;
using System.Runtime.Serialization;

namespace Portal.Consultoras.Entities.PagoEnLinea
{
    [DataContract]
    public class BEPagoEnLinea
    {
        [DataMember]
        public decimal PorcentajeGastosAdministrativos { get; set; }
        [DataMember]
        public string PagoEnLineaGastosLabel { get; set; }
        [DataMember]
        public List<BEPagoEnLineaTipoPago> ListaTipoPago { get; set; }
        [DataMember]
        public List<BEPagoEnLineaMedioPago> ListaMedioPago { get; set; }
        [DataMember]
        public List<BEPagoEnLineaMedioPagoDetalle> ListaMetodoPago { get; set; }
    }
}