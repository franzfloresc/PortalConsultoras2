using System;
using System.Collections.Generic;
using System.Linq;
using System.Runtime.Serialization;
using System.Text;
using System.Threading.Tasks;

namespace Portal.Consultoras.Entities
{
    [DataContract]
    public class BEInformacion
    {
        [DataMember]
        public int CodigoInformacion { get; set; }
        [DataMember]
        public string DetalleInformacion { get; set; }
    }
}
