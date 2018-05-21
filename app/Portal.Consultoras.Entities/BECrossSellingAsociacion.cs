using Portal.Consultoras.Common;
using System;
using System.Data;
using System.Runtime.Serialization;

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
        public string EtiquetaPrecio { get; set; }
        public BECrossSellingAsociacion(IDataRecord row)
        {
            if (DataRecord.HasColumn(row, "CrossSellingAsociacionID"))
                CrossSellingAsociacionID = Convert.ToInt32(row["CrossSellingAsociacionID"]);
            if (DataRecord.HasColumn(row, "NroOrden"))
                NroOrden = Convert.ToInt32(row["NroOrden"]);
            if (DataRecord.HasColumn(row, "CodigoCampania"))
                CodigoCampania = Convert.ToString(row["CodigoCampania"]);
            if (DataRecord.HasColumn(row, "CUV"))
                CUV = Convert.ToString(row["CUV"]);
            if (DataRecord.HasColumn(row, "Descripcion"))
                Descripcion = Convert.ToString(row["Descripcion"]);
            if (DataRecord.HasColumn(row, "PrecioOferta"))
                PrecioOferta = Convert.ToDecimal(row["PrecioOferta"]);
            if (DataRecord.HasColumn(row, "CUVAsociado"))
                CUVAsociado = Convert.ToString(row["CUVAsociado"]);
            if (DataRecord.HasColumn(row, "CUVAsociado2"))
                CUVAsociado2 = Convert.ToString(row["CUVAsociado2"]);
            if (DataRecord.HasColumn(row, "CodigoSegmento"))
                CodigoSegmento = Convert.ToString(row["CodigoSegmento"]);
            if (DataRecord.HasColumn(row, "CampaniaID"))
                CampaniaID = Convert.ToInt32(row["CampaniaID"]);
            if (DataRecord.HasColumn(row, "EtiquetaPrecio"))
                EtiquetaPrecio = Convert.ToString(row["EtiquetaPrecio"]);
            else
                EtiquetaPrecio = string.Empty;
        }
    }
}
