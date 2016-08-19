using System;
using System.Collections.Generic;
using System.Linq;
using System.Runtime.Serialization;
using System.Text;
using System.Threading.Tasks;

namespace Portal.Consultoras.Entities
{
    [DataContract]
    public class BELogCabeceraEnvioCorreo
    {
        [DataMember]
        public int CabeceraID { get; set; }

        [DataMember]
        public long ConsultoraID { get; set; }

        [DataMember]
        public string CodigoConsultora { get; set; }

        [DataMember]
        public DateTime FechaFacturacion { get; set; }

        [DataMember]
        public string Email { get; set; }

        [DataMember]
        public string Asunto { get; set; }

        [DataMember]
        public DateTime FechaEnvio { get; set; }
    }
}
