using Portal.Consultoras.Common;
using System;
using System.Data;
using System.Runtime.Serialization;

namespace Portal.Consultoras.Entities
{
    [DataContract]
    public class BEPedidoWebDetalleDescuento
    {
        [DataMember]
        public string CUV { get; set; }
        [DataMember]
        public string IndicadorDscto { get; set; }
        [DataMember]
        public decimal PrecioUnidad { get; set; }
        [DataMember]
        public decimal PrecioCatalogo2 { get; set; }
        [DataMember]
        public int Cantidad { get; set; }
        [DataMember]
        public decimal MontoDscto { get; set; }

        public BEPedidoWebDetalleDescuento()
        { }

        public BEPedidoWebDetalleDescuento(IDataRecord row)
        {
            if (DataRecord.HasColumn(row, "CUV"))
                CUV = Convert.ToString(row["CUV"]);
            if (DataRecord.HasColumn(row, "IndicadorDscto"))
                IndicadorDscto = Convert.ToString(row["IndicadorDscto"]);
            if (DataRecord.HasColumn(row, "PrecioUnidad"))
                PrecioUnidad = Convert.ToDecimal(row["PrecioUnidad"]);
            if (DataRecord.HasColumn(row, "PrecioCatalogo2"))
                PrecioCatalogo2 = Convert.ToDecimal(row["PrecioCatalogo2"]);
            if (DataRecord.HasColumn(row, "Cantidad"))
                Cantidad = Convert.ToInt32(row["Cantidad"]);
        }
    }
}
