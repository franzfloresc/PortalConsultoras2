using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Runtime.Serialization;
using System.Text;
using System.Threading.Tasks;

// R2073 - Toda la clase
namespace Portal.Consultoras.Entities
{
    [DataContract]
    public class BEPedidoFacturado
    {
        [DataMember]
        public string CodigoConsultora { get; set; }

        [DataMember]
        public decimal MontoDescuento { get; set; }

        [DataMember]
        public string CodigoTerritorio { get; set; }

        [DataMember]
        public string CUV { get; set; }

        [DataMember]
        public string CodigoProducto { get; set; }

        [DataMember]
        public string Descripcion { get; set; }

        [DataMember]
        public int Cantidad { get; set; }

        [DataMember]
        public decimal PrecioUnidad { get; set; }

        [DataMember]
        public decimal ImporteTotal { get; set; }

        [DataMember]
        public string CodigoTipoOferta { get; set; }

        [DataMember]
        public string Origen { get; set; }

        [DataMember]
        public DateTime FechaUltimaActualizacion { get; set; }

        [DataMember]
        public int Campania { get; set; }

        [DataMember]
        public string EstadoPedido { get; set; }

        public BEPedidoFacturado()
        { }

        public BEPedidoFacturado(IDataRecord row, int Tipo)
        {
            Campania = Convert.ToInt32(row["Campania"]);
            ImporteTotal = Convert.ToDecimal(row["ImporteTotal"]);
            EstadoPedido = Convert.ToString(row["EstadoPedido"]);
            Cantidad = Convert.ToInt32(row["Cantidad"]);
        }

        public BEPedidoFacturado(IDataRecord row)
        {
            CodigoConsultora = Convert.ToString(row["CodigoConsultora"]);
            MontoDescuento = Convert.ToDecimal(row["MontoDescuento"]);
            CodigoTerritorio = Convert.ToString(row["CodigoTerritorio"]);
            CUV = Convert.ToString(row["CUV"]);
            CodigoProducto = Convert.ToString(row["CodigoProducto"]);
            Descripcion = Convert.ToString(row["Descripcion"]);
            Cantidad = Convert.ToInt32(row["Cantidad"]);
            PrecioUnidad = Convert.ToDecimal(row["PrecioUnidad"]);
            ImporteTotal = Convert.ToDecimal(row["ImporteTotal"]);
            CodigoTipoOferta = Convert.ToString(row["CodigoTipoOferta"]);
            Origen = Convert.ToString(row["Origen"]);
            FechaUltimaActualizacion = Convert.ToDateTime(row["FechaUltimaActualizacion"]);
        }

    }
}
