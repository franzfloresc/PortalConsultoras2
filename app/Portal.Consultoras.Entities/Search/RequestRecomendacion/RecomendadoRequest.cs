using Portal.Consultoras.Entities.Search.RequestRecomendacion.Estructura;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Runtime.Serialization;
using System.Text;
using System.Threading.Tasks;

namespace Portal.Consultoras.Entities.Search.RequestRecomendacion
{
    [DataContract]
    public class RecomendadoRequest
    {
        [DataMember]
        public string codigoPais { get; set; }

        [DataMember]
        public string codigocampania { get; set; }

        [DataMember]
        public string origen { get; set; }

        [DataMember]
        public string codigoConsultora { get; set; }

        [DataMember]
        public string codigoZona { get; set; }

        [DataMember]
        public string cuv { get; set; }

        [DataMember]
        public List<string> codigoProducto { get; set; }

        [DataMember]
        public int cantidadProductos { get; set; }

        [DataMember]
        public string personalizaciones { get; set; }

        [DataMember]
        public Configuracion configuracion { get; set; }

        [DataMember]
        public List<ProductoSolicitado> productosSolicitados { get; set; }
    }

}
