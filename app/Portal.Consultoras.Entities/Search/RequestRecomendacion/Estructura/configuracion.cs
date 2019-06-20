using System;
using System.Collections.Generic;
using System.Linq;
using System.Runtime.Serialization;
using System.Text;
using System.Threading.Tasks;

namespace Portal.Consultoras.Entities.Search.RequestRecomendacion.Estructura
{
    [DataContract]
    public class Configuracion
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
