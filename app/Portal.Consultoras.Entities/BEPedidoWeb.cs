using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Runtime.Serialization;
using System.Text;
using System.Threading.Tasks;
using Portal.Consultoras.Common;

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

        public BEPedidoWeb()
        { }

        public BEPedidoWeb(IDataRecord row)
        {
            if (DataRecord.HasColumn(row, "CampaniaID"))
                CampaniaID = Convert.ToInt32(row["CampaniaID"]);
            if (DataRecord.HasColumn(row, "PedidoID"))
                PedidoID = Convert.ToInt32(row["PedidoID"]);
            if (DataRecord.HasColumn(row, "ConsultoraID"))
                ConsultoraID = Convert.ToInt64(row["ConsultoraID"]);
            if (DataRecord.HasColumn(row, "Clientes"))
                Clientes = Convert.ToInt16(row["Clientes"]);
            if (DataRecord.HasColumn(row, "ImporteTotal"))
                ImporteTotal = Convert.ToDecimal(row["ImporteTotal"]);
            if (DataRecord.HasColumn(row, "ImporteCredito"))
                ImporteCredito = Convert.ToDecimal(row["ImporteCredito"]);
            if (DataRecord.HasColumn(row, "EstadoPedidoDesc"))
                EstadoPedidoDesc = Convert.ToString(row["EstadoPedidoDesc"]);
            if (DataRecord.HasColumn(row, "MotivoCreditoID"))
                MotivoCreditoID = Convert.ToInt16(row["MotivoCreditoID"]);
            if (DataRecord.HasColumn(row, "PaisID"))
                PaisID = Convert.ToInt32(row["PaisID"]);
            if (DataRecord.HasColumn(row, "CantidadProductos"))
                CantidadProductos = Convert.ToInt32(row["CantidadProductos"]);
            if (DataRecord.HasColumn(row, "Bloqueado") && row["Bloqueado"] != DBNull.Value)
                Bloqueado = Convert.ToInt16(row["Bloqueado"]);
            if (DataRecord.HasColumn(row, "Nombres"))
                Nombres = Convert.ToString(row["Nombres"]);
            if (DataRecord.HasColumn(row, "DescripcionBloqueo") && row["DescripcionBloqueo"] != DBNull.Value)
                DescripcionBloqueo = Convert.ToString(row["DescripcionBloqueo"]);
            if (DataRecord.HasColumn(row, "CodigoZona"))
                CodigoZona = Convert.ToString(row["CodigoZona"]);
            if (DataRecord.HasColumn(row, "CodigoConsultora"))
                CodigoConsultora = Convert.ToString(row["CodigoConsultora"]);
            if (DataRecord.HasColumn(row, "SaldoDeuda"))
                SaldoDeuda = Convert.ToDecimal(row["SaldoDeuda"]);
            if (DataRecord.HasColumn(row, "MontoPedido"))
                MontoPedido = Convert.ToDecimal(row["MontoPedido"]);
            if (DataRecord.HasColumn(row, "CodigoTerritorio"))
                CodigoTerritorio = Convert.ToString(row["CodigoTerritorio"]);
            if (DataRecord.HasColumn(row, "Direccion"))
                Direccion = Convert.ToString(row["Direccion"]);
            if (DataRecord.HasColumn(row, "IndicadorEnviado"))
                IndicadorEnviado = Convert.ToInt32(row["IndicadorEnviado"]);
            if (DataRecord.HasColumn(row, "FechaRegistro"))
                FechaRegistro = Convert.ToDateTime(row["FechaRegistro"]);
            if (DataRecord.HasColumn(row, "FechaModificacion") && row["FechaModificacion"] != DBNull.Value)
                FechaModificacion = Convert.ToDateTime(row["FechaModificacion"]);
            if (DataRecord.HasColumn(row, "FechaProceso") && row["FechaProceso"] != DBNull.Value)
                FechaProceso = Convert.ToDateTime(row["FechaProceso"]);
            if (DataRecord.HasColumn(row, "MontoTotalProl") && row["MontoTotalProl"] != DBNull.Value)
                MontoTotalProl = Convert.ToDecimal(row["MontoTotalProl"]);
            if (DataRecord.HasColumn(row, "MontoAhorroCatalogo") && row["MontoAhorroCatalogo"] != DBNull.Value)
                MontoAhorroCatalogo = Convert.ToDecimal(row["MontoAhorroCatalogo"]);
            if (DataRecord.HasColumn(row, "MontoAhorroRevista") && row["MontoAhorroRevista"] != DBNull.Value)
                MontoAhorroRevista = Convert.ToDecimal(row["MontoAhorroRevista"]);
            if (DataRecord.HasColumn(row, "DescuentoProl") && row["DescuentoProl"] != DBNull.Value)
                DescuentoProl = Convert.ToDecimal(row["DescuentoProl"]);
            if (DataRecord.HasColumn(row, "MontoEscala") && row["MontoEscala"] != DBNull.Value)
                MontoEscala = Convert.ToDecimal(row["MontoEscala"]);
            if (DataRecord.HasColumn(row, "CanalIngreso") && row["CanalIngreso"] != DBNull.Value)
                CanalIngreso = Convert.ToString(row["CanalIngreso"]);
            if (DataRecord.HasColumn(row, "Flete") && row["Flete"] != DBNull.Value)
                Flete = Convert.ToDecimal(row["Flete"]);          
        }
    }
}
