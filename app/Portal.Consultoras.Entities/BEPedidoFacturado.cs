using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Runtime.Serialization;
using System.Text;
using System.Threading.Tasks;
// R2073 - Toda la clase
using Portal.Consultoras.Common;

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

        [DataMember]
        public int PedidoId { get; set; }

        public BEPedidoFacturado()
        { }

        public BEPedidoFacturado(IDataRecord row, int Tipo)
        {
            if (DataRecord.HasColumn(row, "Campania") && row["Campania"] != DBNull.Value)
                Campania = Convert.ToInt32(row["Campania"]);

            if (DataRecord.HasColumn(row, "ImporteTotal") && row["ImporteTotal"] != DBNull.Value)
                ImporteTotal = Convert.ToDecimal(row["ImporteTotal"]);

            if (DataRecord.HasColumn(row, "EstadoPedido") && row["EstadoPedido"] != DBNull.Value)
                EstadoPedido = Convert.ToString(row["EstadoPedido"]);

            if (DataRecord.HasColumn(row, "Cantidad") && row["Cantidad"] != DBNull.Value)
                Cantidad = Convert.ToInt32(row["Cantidad"]);

            if (DataRecord.HasColumn(row, "PedidoId") && row["PedidoId"] != DBNull.Value)
                PedidoId = Convert.ToInt32(row["PedidoId"]);
        }

        public BEPedidoFacturado(IDataRecord row)
        {
            if (DataRecord.HasColumn(row, "CodigoConsultora") && row["CodigoConsultora"] != DBNull.Value)
                CodigoConsultora = Convert.ToString(row["CodigoConsultora"]);

            if (DataRecord.HasColumn(row, "MontoDescuento") && row["MontoDescuento"] != DBNull.Value)
                MontoDescuento = Convert.ToDecimal(row["MontoDescuento"]);

            if (DataRecord.HasColumn(row, "CodigoTerritorio") && row["CodigoTerritorio"] != DBNull.Value)
                CodigoTerritorio = Convert.ToString(row["CodigoTerritorio"]);

            if (DataRecord.HasColumn(row, "CUV") && row["CUV"] != DBNull.Value)
                CUV = Convert.ToString(row["CUV"]);

            if (DataRecord.HasColumn(row, "CodigoProducto") && row["CodigoProducto"] != DBNull.Value)
                CodigoProducto = Convert.ToString(row["CodigoProducto"]);

            if (DataRecord.HasColumn(row, "Descripcion") && row["Descripcion"] != DBNull.Value)
                Descripcion = Convert.ToString(row["Descripcion"]);

            if (DataRecord.HasColumn(row, "Cantidad") && row["Cantidad"] != DBNull.Value)
                Cantidad = Convert.ToInt32(row["Cantidad"]);

            if (DataRecord.HasColumn(row, "PrecioUnidad") && row["PrecioUnidad"] != DBNull.Value)
                PrecioUnidad = Convert.ToDecimal(row["PrecioUnidad"]);

            if (DataRecord.HasColumn(row, "ImporteTotal") && row["ImporteTotal"] != DBNull.Value)
                ImporteTotal = Convert.ToDecimal(row["ImporteTotal"]);

            if (DataRecord.HasColumn(row, "CodigoTipoOferta") && row["CodigoTipoOferta"] != DBNull.Value)
                CodigoTipoOferta = Convert.ToString(row["CodigoTipoOferta"]);

            if (DataRecord.HasColumn(row, "Origen") && row["Origen"] != DBNull.Value)
                Origen = Convert.ToString(row["Origen"]);

            if (DataRecord.HasColumn(row, "FechaUltimaActualizacion") && row["FechaUltimaActualizacion"] != DBNull.Value)
                FechaUltimaActualizacion = Convert.ToDateTime(row["FechaUltimaActualizacion"]);

            if (DataRecord.HasColumn(row, "PedidoId") && row["PedidoId"] != DBNull.Value)
                PedidoId = Convert.ToInt32(row["PedidoId"]);
        }
    }
}
