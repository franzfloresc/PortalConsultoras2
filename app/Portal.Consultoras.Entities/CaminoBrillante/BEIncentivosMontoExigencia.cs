using System;
using System.Collections.Generic;
using System.Linq;
using System.Runtime.Serialization;
using System.Text;
using System.Threading.Tasks;

namespace Portal.Consultoras.Entities.CaminoBrillante
{
    [DataContract]
    public class BEIncentivosMontoExigencia
    {
        [DataMember]
        public string CodigoCampania { get; set; }
        [DataMember]
        public string CodigoRegion { get; set; }
        [DataMember]
        public string CodigoZona { get; set; }
        [DataMember]
        public string Monto { get; set; }
        [DataMember]
        public string AlcansoIncentivo { get; set; }
        [DataMember]
        public bool Estado { get; set; }
    }
}
