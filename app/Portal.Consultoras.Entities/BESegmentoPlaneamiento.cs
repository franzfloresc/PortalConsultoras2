using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Runtime.Serialization;
using System.Text;
using System.Threading.Tasks;
using Portal.Consultoras.Common;

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
            if (DataRecord.HasColumn(row, "NroOrden") && row["NroOrden"] != DBNull.Value)
                NroOrden = Convert.ToInt32(row["NroOrden"]);

            if (DataRecord.HasColumn(row, "CodigoSegmento") && row["CodigoSegmento"] != DBNull.Value)
                CodigoSegmento = Convert.ToString(row["CodigoSegmento"]);

            if (DataRecord.HasColumn(row, "DescripcionSegmento") && row["DescripcionSegmento"] != DBNull.Value)
                DescripcionSegmento = Convert.ToString(row["DescripcionSegmento"]);

            if (DataRecord.HasColumn(row, "CUVAsociado") && row["CUVAsociado"] != DBNull.Value)
                CUVAsociado = Convert.ToString(row["CUVAsociado"]);

            if (DataRecord.HasColumn(row, "CampaniaID") && row["CampaniaID"] != DBNull.Value)
                CampaniaID = Convert.ToInt32(row["CampaniaID"]);

            if (DataRecord.HasColumn(row, "CUV") && row["CUV"] != DBNull.Value)
                CUV = Convert.ToString(row["CUV"]);

            if (DataRecord.HasColumn(row, "CrossSellingAsociacionID") && row["CrossSellingAsociacionID"] != DBNull.Value)
                CrossSellingAsociacionID = Convert.ToInt32(row["CrossSellingAsociacionID"]);
        }
    }
}
