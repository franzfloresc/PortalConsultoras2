using Portal.Consultoras.Common;
using System;
using System.Collections.Generic;
using System.Data;
using System.Runtime.Serialization;

namespace Portal.Consultoras.Entities
{
    [DataContract]
    public class BEPedidoFIC
    {
        [DataMember]
        public int CampaniaID { get; set; }
        [DataMember]
        public int PedidoID { get; set; }
        [DataMember]
        public long ConsultoraID { get; set; }
        [DataMember]
        public DateTime FechaRegistro { get; set; }
        [DataMember]
        public DateTime FechaModificacion { get; set; }
        [DataMember]
        public Int16 Clientes { get; set; }
        [DataMember]
        public decimal ImporteTotal { get; set; }
        [DataMember]
        public decimal ImporteCredito { get; set; }
        [DataMember]
        public byte EstadoPedido { get; set; }
        [DataMember]
        public Int16 MotivoCreditoID { get; set; }
        [DataMember]
        public int PaisID { get; set; }
        [DataMember]
        public string EstadoPedidoDesc { get; set; }
        [DataMember]
        public int CantidadProductos { get; set; }
        [DataMember]
        public short Bloqueado { get; set; }
        [DataMember]
        public string DescripcionBloqueo { get; set; }
        [DataMember]
        public string Nombres { get; set; }
        [DataMember]
        public string CodigoZona { get; set; }
        [DataMember]
        public string CodigoTerritorio { get; set; }
        [DataMember]
        public string Direccion { get; set; }
        [DataMember]
        public string CodigoConsultora { get; set; }
        [DataMember]
        public decimal SaldoDeuda { get; set; }
        [DataMember]
        public decimal MontoPedido { get; set; }
        [DataMember]
        public int IndicadorEnviado { get; set; }
        [DataMember]
        public bool ModificaPedidoReservado { get; set; }
        [DataMember]
        public string IPUsuario { get; set; }

        [DataMember]
        public List<BEPedidoWebDetalle> olstBEPedidoWebDetalle { get; set; }

        public BEPedidoFIC()
        { }

        public BEPedidoFIC(IDataRecord row)
        {
            CampaniaID = row.ToInt32("CampaniaID");
            PedidoID = row.ToInt32("PedidoID");
            ConsultoraID = row.ToInt64("ConsultoraID");
            Clientes = row.ToInt16("Clientes");
            ImporteTotal = row.ToDecimal("ImporteTotal");
            ImporteCredito = row.ToDecimal("ImporteCredito");
            EstadoPedidoDesc = row.ToString("EstadoPedidoDesc");
            MotivoCreditoID = row.ToInt16("MotivoCreditoID");
            PaisID = row.ToInt32("PaisID");
            CantidadProductos = row.ToInt32("CantidadProductos");
            Bloqueado = row.ToInt16("Bloqueado");
            Nombres = row.ToString("Nombres");
            DescripcionBloqueo = row.ToString("DescripcionBloqueo");
            CodigoZona = row.ToString("CodigoZona");
            CodigoConsultora = row.ToString("CodigoConsultora");
            SaldoDeuda = row.ToDecimal("SaldoDeuda");
            MontoPedido = row.ToDecimal("MontoPedido");
            CodigoTerritorio = row.ToString("CodigoTerritorio");
            Direccion = row.ToString("Direccion");
            IndicadorEnviado = row.ToInt32("IndicadorEnviado");
        }
    }
}
