using System.Runtime.Serialization;

namespace Portal.Consultoras.Entities.Pedido
{
    [DataContract]
    public class BEPedidoBuscar
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

        [DataMember]
        public BEUsuario usuario { get; set; }
    }
}
