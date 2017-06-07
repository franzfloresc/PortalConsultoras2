using System.Runtime.Serialization;

namespace Portal.Consultoras.Entities
{
    [DataContract]
    public class BEPedidoWebDetalleInvariant
    {
        [DataMember]
        public int CampaniaID { get; set; }

        [DataMember]
        public int AceptacionConsultoraDA { get; set; }

        [DataMember]
        public string CUV { get; set; }

        [DataMember]
        public int Cantidad { get; set; }

        [DataMember]
        public int OrigenPedidoWeb { get; set; }

        [DataMember]
        public int PaisID { get; set; }
        
        [DataMember]
        public string CodigoUsuario { get; set; }

        [DataMember]
        public string IPUsuario { get; set; }

        [DataMember]
        public bool UsuarioPrueba { get; set; }
    }
}
