using System.Runtime.Serialization;

using Portal.Consultoras.Common;

namespace Portal.Consultoras.Entities.Producto
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
