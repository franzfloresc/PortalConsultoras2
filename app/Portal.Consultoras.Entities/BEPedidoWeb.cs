using Portal.Consultoras.Common;

using System;
using System.Collections.Generic;
using System.Data;
using System.Runtime.Serialization;

namespace Portal.Consultoras.Entities
{
    [DataContract]
    public class BEPedidoWeb
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
        public Int16 EstadoPedido { get; set; }
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
        public string CodigoUsuarioCreacion { get; set; }
        [DataMember]
        public string CodigoUsuarioModificacion { get; set; }
        [DataMember]
        public DateTime FechaProceso { get; set; }
        [DataMember]
        public decimal MontoTotalProl { get; set; }

        [DataMember]
        public decimal MontoAhorroCatalogo { get; set; }

        [DataMember]
        public decimal MontoAhorroRevista { get; set; }

        [DataMember]
        public decimal DescuentoProl { get; set; }

        [DataMember]
        public decimal MontoEscala { get; set; }

        [DataMember]
        public string CanalIngreso { get; set; }

        [DataMember]
        public string RutaPaqueteDocumentario { get; set; }

        [DataMember]
        public List<BEPedidoWebDetalle> olstBEPedidoWebDetalle { get; set; }

        [DataMember]
        public decimal Flete { get; set; }

        [DataMember]
        public int CDRWebID { get; set; }

        [DataMember]
        public int CDRWebEstado { get; set; }

        [DataMember]
        public int NumeroPedido { get; set; }

        [DataMember]
        public byte VersionProl { get; set; }

        public long PedidoSapId { get; set; }

        [DataMember]
        public int CantidadCuv { get; set; }

        [DataMember]
        public decimal TippingPoint { get; set; }

        [DataMember]
        public bool ValidacionAbierta { get; set; }


        public BEPedidoWeb() { }

        public BEPedidoWeb(IDataRecord row)
        {
            CampaniaID = row.ToInt32("CampaniaID");
            PedidoID = row.ToInt32("PedidoID");
            ConsultoraID = row.ToInt64("ConsultoraID");
            Clientes = row.ToInt16("Clientes");
            ImporteTotal = row.ToDecimal("ImporteTotal");
            ImporteCredito = row.ToDecimal("ImporteCredito");
            EstadoPedido = row.ToInt16("EstadoPedido");
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
            FechaRegistro = row.ToDateTime("FechaRegistro");
            FechaModificacion = row.ToDateTime("FechaModificacion");
            FechaProceso = row.ToDateTime("FechaProceso");
            MontoTotalProl = row.ToDecimal("MontoTotalProl");
            MontoAhorroCatalogo = row.ToDecimal("MontoAhorroCatalogo");
            MontoAhorroRevista = row.ToDecimal("MontoAhorroRevista");
            DescuentoProl = row.ToDecimal("DescuentoProl");
            MontoEscala = row.ToDecimal("MontoEscala");
            CanalIngreso = row.ToString("CanalIngreso");
            Flete = row.ToDecimal("Flete");
            CDRWebID = row.ToInt32("CDRWebID");
            CDRWebEstado = row.ToInt32("CDRWebEstado");
            NumeroPedido = row.ToInt32("NumeroPedido");
            VersionProl = row.ToByte("VersionProl");
            ModificaPedidoReservado = row.ToBoolean("ModificaPedidoReservado");
            ValidacionAbierta = row.ToBoolean("ValidacionAbierta");
        }
    }
}
