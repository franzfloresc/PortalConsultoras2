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
        public configuracion configuracion { get; set; }
    }

    [DataContract]
    public class configuracion
    {
        [DataMember]
        public string sociaEmpresaria { get; set; }

        [DataMember]
        public string suscripcionActiva { get; set; }

        [DataMember]
        public string mdo { get; set; }

        [DataMember]
        public string rd { get; set; }

        [DataMember]
        public string rdi { get; set; }

        [DataMember]
        public string rdr { get; set; }

        [DataMember]
        public int diaFacturacion { get; set; }

        [DataMember]
        public string mostrarProductoConsultado { get; set; }
    }
}
