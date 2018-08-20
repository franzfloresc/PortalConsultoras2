using System.Runtime.Serialization;

namespace Portal.Consultoras.Entities.Pedido
{
    [DataContract]
    public class BEPedidoDetalle
    {
        public BEPedidoDetalle()
        {
            Producto = new BEProducto();
            Usuario = new BEUsuario();
        }

        [DataMember]
        public int PaisID { get; set; }
        [DataMember]
        public int Cantidad { get; set; }
        [DataMember]
        public BEProducto Producto { get; set; }
        [DataMember]
        public string IPUsuario { get; set; }
        [DataMember]
        public int PedidoID { get; set; }
        [DataMember]
        public short ClienteID { get; set; }
        [DataMember]
        public string ClienteDescripcion { get; set; }
        [DataMember]
        public string Identifier { get; set; }
        [DataMember]
        public bool EsKitNueva { get; set; }
        [DataMember]
        public BEUsuario Usuario { get; set; }
        [DataMember]
        public short PedidoDetalleID { get; set; }
        [DataMember]
        public string ObservacionPROL { get; set; }
        [DataMember]
        public int OrigenPedidoWeb { get; set; }
        [DataMember]
        public int SetID { get; set; }
        [DataMember]
        public decimal ImporteTotal { get; set; }
        [DataMember]
        public bool EsSugerido { get; set; }
    }
}
