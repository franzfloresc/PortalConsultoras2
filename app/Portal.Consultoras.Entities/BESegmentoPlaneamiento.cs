using Portal.Consultoras.Common;
using System;
using System.Data;
using System.Runtime.Serialization;

namespace Portal.Consultoras.Entities
{
    [DataContract]
    public class BESegmentoPlaneamiento
    {

        [DataMember]
        public int CrossSellingAsociacionID { get; set; }


        [DataMember]
        public int NroOrden { get; set; }

        [DataMember]
        public string CodigoSegmento { get; set; }

        [DataMember]
        public string DescripcionSegmento { get; set; }

        [DataMember]
        public string CUVAsociado { get; set; }

        [DataMember]
        public int CampaniaID { get; set; }

        [DataMember]
        public string CUV { get; set; }

        [DataMember]
        public int PaisID { get; set; }

        public BESegmentoPlaneamiento(IDataRecord row)
        {
            NroOrden = row.ToInt32("NroOrden");
            CodigoSegmento = row.ToString("CodigoSegmento");
            DescripcionSegmento = row.ToString("DescripcionSegmento");
            CUVAsociado = row.ToString("CUVAsociado");
            CampaniaID = row.ToInt32("CampaniaID");
            CUV = row.ToString("CUV");
            CrossSellingAsociacionID = row.ToInt32("CrossSellingAsociacionID");
        }
    }
}
