using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Runtime.Serialization;

namespace Portal.Consultoras.Entities.ProgramaNuevas
{
    [DataContract]
    public class BEProgramaNuevas
    {
        [DataMember]
        public int PaisID { get; set; }
        [DataMember]
        public int CampaniaID { get; set; }
        [DataMember]
        public string CodigoConsultora { get; set; }
        [DataMember]
        public string CodigorRegion { get; set; }
        [DataMember]
        public string CodigoZona { get; set; }
        [DataMember]
        public string CodigoPrograma { get; set; } 
        [DataMember]
        public int ConsecutivoNueva { get; set; }
        [DataMember]
        public string CodigoISO { get; set; }
        [DataMember]
        public bool EsConsultoraNueva { get; set; }

        public BEProgramaNuevas()
        { }
    }
}
