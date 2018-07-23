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
            CUV = row.ToString("CUV");
            IndicadorDscto = row.ToString("IndicadorDscto");
            PrecioUnidad = row.ToDecimal("PrecioUnidad");
            PrecioCatalogo2 = row.ToDecimal("PrecioCatalogo2");
            Cantidad = row.ToInt32("Cantidad");
        }
    }
}
