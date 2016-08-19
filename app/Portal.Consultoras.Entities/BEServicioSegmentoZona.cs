using System;
using System.Collections.Generic;
using System.Linq;
using System.Runtime.Serialization;
using System.Text;
using System.Threading.Tasks;

namespace Portal.Consultoras.Entities
{
    //RQ_SB- R2161
    [DataContract]
    public class BEServicioSegmentoZona
    {
        [DataMember]
        public int CampaniaId { set; get; }
        [DataMember]
        public int BannerId { set; get; }
        [DataMember]
        public int PaisId { set; get; }
        [DataMember]
        public int Segmento { set; get; }
        [DataMember]
        public string ConfiguracionZona { set; get; }
        [DataMember]
        public string NombrePais { set; get; }
        [DataMember]
        public string DesCampania { set; get; }
        [DataMember]
        public string SegmentoInternoID { set; get; }/*CGI(RSA) - REQ 2544*/

        public BEServicioSegmentoZona()
        {

        }
    }
}
