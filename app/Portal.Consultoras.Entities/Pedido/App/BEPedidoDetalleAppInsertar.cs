using System;
using System.Runtime.Serialization;

namespace Portal.Consultoras.Entities.Pedido.App
{
    [DataContract]
    public class BEPedidoDetalleAppInsertar
    {
        public BEPedidoDetalleAppInsertar()
        {
            Producto = new BEProducto();
        }

        [DataMember]
        public int PaisID { get; set; }
        [DataMember]
        public string CodigoUsuario { get; set; }
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
        public string CodigosConcursos { get; set; }
    }
}
