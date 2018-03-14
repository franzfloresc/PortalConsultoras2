using System.Runtime.Serialization;

namespace Portal.Consultoras.Entities.Pedido.App
{
    public class BEProductoApp
    {
        [DataMember]
        public string CodigoRespuesta { get; set; }
        [DataMember]
        public string MensajeRespuesta { get; set; }
        [DataMember]
        public BEProducto Producto { get; set; }
    }
}
