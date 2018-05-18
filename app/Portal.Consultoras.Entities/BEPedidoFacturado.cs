using Portal.Consultoras.Common;
using System;
using System.Data;
using System.Runtime.Serialization;

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

        [DataMember]
        public int ClienteID { get; set; }

        [DataMember]
        public string NombreCliente { get; set; }

        public BEPedidoFacturado()
        { }

        public BEPedidoFacturado(IDataRecord row, int Tipo)
        {
            if (DataRecord.HasColumn(row, "Campania"))
                Campania = Convert.ToInt32(row["Campania"]);

            if (DataRecord.HasColumn(row, "ImporteTotal"))
                ImporteTotal = Convert.ToDecimal(row["ImporteTotal"]);

            if (DataRecord.HasColumn(row, "EstadoPedido"))
                EstadoPedido = Convert.ToString(row["EstadoPedido"]);

            if (DataRecord.HasColumn(row, "Cantidad"))
                Cantidad = Convert.ToInt32(row["Cantidad"]);

            if (DataRecord.HasColumn(row, "PedidoId"))
                PedidoId = Convert.ToInt32(row["PedidoId"]);
        }

        public BEPedidoFacturado(IDataRecord row)
        {
            if (DataRecord.HasColumn(row, "CodigoConsultora"))
                CodigoConsultora = Convert.ToString(row["CodigoConsultora"]);

            if (DataRecord.HasColumn(row, "MontoDescuento"))
                MontoDescuento = Convert.ToDecimal(row["MontoDescuento"]);

            if (DataRecord.HasColumn(row, "CodigoTerritorio"))
                CodigoTerritorio = Convert.ToString(row["CodigoTerritorio"]);

            if (DataRecord.HasColumn(row, "CUV"))
                CUV = Convert.ToString(row["CUV"]);

            if (DataRecord.HasColumn(row, "CodigoProducto"))
                CodigoProducto = Convert.ToString(row["CodigoProducto"]);

            if (DataRecord.HasColumn(row, "Descripcion"))
                Descripcion = Convert.ToString(row["Descripcion"]);

            if (DataRecord.HasColumn(row, "Cantidad"))
                Cantidad = Convert.ToInt32(row["Cantidad"]);

            if (DataRecord.HasColumn(row, "PrecioUnidad"))
                PrecioUnidad = Convert.ToDecimal(row["PrecioUnidad"]);

            if (DataRecord.HasColumn(row, "ImporteTotal"))
                ImporteTotal = Convert.ToDecimal(row["ImporteTotal"]);

            if (DataRecord.HasColumn(row, "CodigoTipoOferta"))
                CodigoTipoOferta = Convert.ToString(row["CodigoTipoOferta"]);

            if (DataRecord.HasColumn(row, "Origen"))
                Origen = Convert.ToString(row["Origen"]);

            if (DataRecord.HasColumn(row, "FechaUltimaActualizacion"))
                FechaUltimaActualizacion = Convert.ToDateTime(row["FechaUltimaActualizacion"]);

            if (DataRecord.HasColumn(row, "PedidoId"))
                PedidoId = Convert.ToInt32(row["PedidoId"]);

            if (DataRecord.HasColumn(row, "ClienteID"))
                ClienteID = Convert.ToInt32(row["ClienteID"]);

            if (DataRecord.HasColumn(row, "NombreCliente"))
                NombreCliente = Convert.ToString(row["NombreCliente"]);
        }
    }
}
