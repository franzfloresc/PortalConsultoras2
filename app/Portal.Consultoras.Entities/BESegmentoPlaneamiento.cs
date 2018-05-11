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
            if (DataRecord.HasColumn(row, "NroOrden"))
                NroOrden = Convert.ToInt32(row["NroOrden"]);

            if (DataRecord.HasColumn(row, "CodigoSegmento"))
                CodigoSegmento = Convert.ToString(row["CodigoSegmento"]);

            if (DataRecord.HasColumn(row, "DescripcionSegmento"))
                DescripcionSegmento = Convert.ToString(row["DescripcionSegmento"]);

            if (DataRecord.HasColumn(row, "CUVAsociado"))
                CUVAsociado = Convert.ToString(row["CUVAsociado"]);

            if (DataRecord.HasColumn(row, "CampaniaID"))
                CampaniaID = Convert.ToInt32(row["CampaniaID"]);

            if (DataRecord.HasColumn(row, "CUV"))
                CUV = Convert.ToString(row["CUV"]);

            if (DataRecord.HasColumn(row, "CrossSellingAsociacionID"))
                CrossSellingAsociacionID = Convert.ToInt32(row["CrossSellingAsociacionID"]);
        }
    }
}
