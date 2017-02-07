using Portal.Consultoras.Common;
using System;
using System.Data;
using System.Runtime.Serialization;

namespace Portal.Consultoras.Entities
{
    [DataContract]
    public class BEEstrategiaProducto
    {
        [DataMember]
        public int PaisID { get; set; }

        [DataMember]
        public int EstrategiaProductoID { get; set; }
        [DataMember]
        public int EstrategiaID { get; set; }
        [DataMember]
        public int Campania { get; set; }
        [DataMember]
        public string CUV { get; set; }
        [DataMember]
        public string Grupo { get; set; }
        [DataMember]
        public int Orden { get; set; }
        [DataMember]
        public string CUV2 { get; set; }
        [DataMember]
        public string SAP { get; set; }
        [DataMember]
        public int Cantidad { get; set; }
        [DataMember]
        public decimal Precio { get; set; }
        [DataMember]
        public decimal PrecioValorizado { get; set; }
        [DataMember]
        public int Digitable { get; set; }
        [DataMember]
        public string CodigoEstrategia { get; set; }
        [DataMember]
        public string CodigoError { get; set; }
        [DataMember]
        public string CodigoErrorObs { get; set; }

        public BEEstrategiaProducto(IDataRecord row)
        {
            if (DataRecord.HasColumn(row, "CUV") && row["CUV"] != DBNull.Value)
                CUV = row["CUV"].ToString();
        }
    }
}
