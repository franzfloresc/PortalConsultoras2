using Portal.Consultoras.Common;
using System;
using System.Data;
using System.Runtime.Serialization;

namespace Portal.Consultoras.Entities
{
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

        public BESegmentoBanner(IDataRecord row)
        {
            BannerSegmentoId = row.ToInt32("SegmentoID");
            BannerSegmentoDes = row.ToString("Descripcion");
        }
    }
}
