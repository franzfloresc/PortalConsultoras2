using System;
using System.Collections.Generic;
using System.Linq;
using System.Runtime.Serialization;
using System.Text;
using System.Threading.Tasks;

namespace Portal.Consultoras.Entities
{
    [DataContract]
    public class BELogDetalleEnvioCorreo
    {
        [DataMember]
        public int ID { get; set; }

        [DataMember]
        public int CabeceraID { get; set; }

        [DataMember]
        public string CUV { get; set; }

        [DataMember]
        public int Cantidad { get; set; }

        [DataMember]
        public decimal PrecioUnitario { get; set; }

        [DataMember]
        public DateTime FechaCreacion { get; set; }

        public BELogDetalleEnvioCorreo()
        {
        }

    }
}
