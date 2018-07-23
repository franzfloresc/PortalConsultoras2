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
            Campania  = row.ToInt32("Campania");
            ImporteTotal  = row.ToDecimal("ImporteTotal");
            EstadoPedido  = row.ToString("EstadoPedido");
            Cantidad  = row.ToInt32("Cantidad");
            PedidoId  = row.ToInt32("PedidoId");
        }

        public BEPedidoFacturado(IDataRecord row)
        {
            CodigoConsultora  = row.ToString("CodigoConsultora");
            MontoDescuento  = row.ToDecimal("MontoDescuento");
            CodigoTerritorio  = row.ToString("CodigoTerritorio");
            CUV  = row.ToString("CUV");
            CodigoProducto  = row.ToString("CodigoProducto");
            Descripcion  = row.ToString("Descripcion");
            Cantidad  = row.ToInt32("Cantidad");
            PrecioUnidad  = row.ToDecimal("PrecioUnidad");
            ImporteTotal  = row.ToDecimal("ImporteTotal");
            CodigoTipoOferta  = row.ToString("CodigoTipoOferta");
            Origen  = row.ToString("Origen");
            FechaUltimaActualizacion  = row.ToDateTime("FechaUltimaActualizacion");
            PedidoId  = row.ToInt32("PedidoId");
            ClienteID  = row.ToInt32("ClienteID");
            NombreCliente  = row.ToString("NombreCliente");
        }
    }
}
