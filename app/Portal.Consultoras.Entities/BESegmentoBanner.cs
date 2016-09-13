using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Runtime.Serialization;
using System.Text;
using System.Threading.Tasks;

namespace Portal.Consultoras.Entities
{
    //RQ_SB - R2133
    [DataContract]
    public class BESegmentoBanner
    {
        [DataMember]
        public int BannerSegmentoId { get; set; }
        [DataMember]
        public string BannerSegmentoDes { get; set; }

        public BESegmentoBanner()
        {

        }

        public BESegmentoBanner(IDataRecord datarec)
        {
            BannerSegmentoId = Convert.ToInt32(datarec["SegmentoID"]);
            BannerSegmentoDes = Convert.ToString(datarec["Descripcion"]);
        }
    }
}
