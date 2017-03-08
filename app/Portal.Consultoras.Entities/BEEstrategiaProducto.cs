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
            EstrategiaProductoID = DataRecord.GetColumn(row, "EstrategiaProductoID", 0);
            EstrategiaID = DataRecord.GetColumn(row, "EstrategiaID", 0);
            Campania = DataRecord.GetColumn(row, "Campania", 0);
            CUV = DataRecord.GetColumn(row, "CUV", "");
            CUV2 = DataRecord.GetColumn(row, "CUV2", "");
            SAP = DataRecord.GetColumn(row, "SAP", "");
            Grupo = DataRecord.GetColumn(row, "Grupo", "");
            Orden = DataRecord.GetColumn(row, "Orden", 0);
            Cantidad = DataRecord.GetColumn(row, "Cantidad", 0);
            Precio = DataRecord.GetColumn(row, "Precio", Convert.ToDecimal(0));
            PrecioValorizado = DataRecord.GetColumn(row, "PrecioValorizado", Convert.ToDecimal(0));
            Digitable = DataRecord.GetColumn(row, "Digitable", 0);
            CodigoEstrategia = DataRecord.GetColumn(row, "CodigoEstrategia", "");
            CodigoError = DataRecord.GetColumn(row, "CodigoError", "");
            CodigoErrorObs = DataRecord.GetColumn(row, "CodigoErrorObs", "");
        }
    }
}
