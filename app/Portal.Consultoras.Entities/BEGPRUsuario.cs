using System.Runtime.Serialization;

namespace Portal.Consultoras.Entities
{
    [DataContract]
    public class BEGPRUsuario
    {
        [DataMember]
        public int IndicadorGPRSB { get; set; }
        [DataMember]
        public int CampaniaID { get; set; }
        [DataMember]
        public int PaisID { get; set; }
        [DataMember]
        public long ConsultoraID { get; set; }
        [DataMember]
        public decimal MontoDeuda { get; set; }
        [DataMember]
        public string Simbolo { get; set; }
        [DataMember]
        public string CodigoISO { get; set; }
        [DataMember]
        public decimal MontoMinimoPedido { get; set; }
        [DataMember]
        public decimal MontoMaximoPedido { get; set; }
        [DataMember]
        public bool ValidacionAbierta { get; set; }
        [DataMember]
        public int EstadoPedido { get; set; }
    }
}
