using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Runtime.Serialization;

namespace Portal.Consultoras.Entities
{
    public class BEProductoCompartido
    {
        [DataMember]
        public int PcCampaniaID { get; set; }

        [DataMember]
        public string PcCuv { get; set; }

        [DataMember]
        public string PcPalanca { get; set; }

        [DataMember]
        public int PcDetalle { get; set; }

        [DataMember]
        public int PcApp { get; set; }

        [DataMember]
        public int PcID { get; set; }

        [DataMember]
        public int PaisID { get; set; }
    }
}
