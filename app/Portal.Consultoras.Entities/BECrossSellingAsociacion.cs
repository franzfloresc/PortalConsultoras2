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
    public class BECrossSellingAsociacion
    {
        [DataMember]
        public int CrossSellingAsociacionID { get; set; }
        [DataMember]
        public int PaisID { get; set; }
        [DataMember]
        public int NroOrden { get; set; }
        [DataMember]
        public string CodigoCampania { get; set; }
        [DataMember]
        public string CUV { get; set; }
        [DataMember]
        public string Descripcion { get; set; }
        [DataMember]
        public decimal PrecioOferta { get; set; }
        [DataMember]
        public string CUVAsociado { get; set; }

        [DataMember]
        public string CUVAsociado2 { get; set; }

        [DataMember]
        public string CodigoSegmento { get; set; }

        [DataMember]
        public int CampaniaID { get; set; }

        [DataMember]
        public string EtiquetaPrecio { get; set; }//1673CC
        public BECrossSellingAsociacion(IDataRecord row)
        {
            if (DataRecord.HasColumn(row, "CrossSellingAsociacionID") && row["CrossSellingAsociacionID"] != DBNull.Value)
                CrossSellingAsociacionID = Convert.ToInt32(row["CrossSellingAsociacionID"]);
            if (DataRecord.HasColumn(row, "NroOrden") && row["NroOrden"] != DBNull.Value)
                NroOrden = Convert.ToInt32(row["NroOrden"]);
            if (DataRecord.HasColumn(row, "CodigoCampania") && row["CodigoCampania"] != DBNull.Value)
                CodigoCampania = Convert.ToString(row["CodigoCampania"]);
            if (DataRecord.HasColumn(row, "CUV") && row["CUV"] != DBNull.Value)
                CUV = Convert.ToString(row["CUV"]);
            if (DataRecord.HasColumn(row, "Descripcion") && row["Descripcion"] != DBNull.Value)
                Descripcion = Convert.ToString(row["Descripcion"]);
            if (DataRecord.HasColumn(row, "PrecioOferta") && row["PrecioOferta"] != DBNull.Value)
                PrecioOferta = Convert.ToDecimal(row["PrecioOferta"]);
            if (DataRecord.HasColumn(row, "CUVAsociado") && row["CUVAsociado"] != DBNull.Value)
                CUVAsociado = Convert.ToString(row["CUVAsociado"]);
            if (DataRecord.HasColumn(row, "CUVAsociado2") && row["CUVAsociado2"] != DBNull.Value)
                CUVAsociado2 = Convert.ToString(row["CUVAsociado2"]);
            if (DataRecord.HasColumn(row, "CodigoSegmento") && row["CodigoSegmento"] != DBNull.Value)
                CodigoSegmento = Convert.ToString(row["CodigoSegmento"]);
            if (DataRecord.HasColumn(row, "CampaniaID") && row["CampaniaID"] != DBNull.Value)
                CampaniaID = Convert.ToInt32(row["CampaniaID"]);
			if (DataRecord.HasColumn(row, "EtiquetaPrecio") && row["EtiquetaPrecio"] != DBNull.Value)//1673CC
                EtiquetaPrecio = Convert.ToString(row["EtiquetaPrecio"]);//1673CC
            else
                EtiquetaPrecio = string.Empty;
        }
    }
}
