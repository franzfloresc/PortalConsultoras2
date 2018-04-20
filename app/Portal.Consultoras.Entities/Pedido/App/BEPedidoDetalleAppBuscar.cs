using System.Runtime.Serialization;

namespace Portal.Consultoras.Entities.Pedido.App
{
    [DataContract]
    public class BEPedidoDetalleAppBuscar
    {
        [DataMember]
        public int PaisID { get; set; }
        [DataMember]
        public int CampaniaID { get; set; }
        [DataMember]
        public long ConsultoraID { get; set; }
        [DataMember]
        public string NombreConsultora { get; set; }
        [DataMember]
        public string CodigoPrograma { get; set; }
        [DataMember]
        public int ConsecutivoNueva { get; set; }
    }
}
