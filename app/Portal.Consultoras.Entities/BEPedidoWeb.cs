﻿using System;
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

        [DataMember]
        public int CDRWebID { get; set; }

        [DataMember]
        public int CDRWebEstado { get; set; }

        [DataMember]
        public int NumeroPedido { get; set; }

        public BEPedidoWeb()
        { }

        public BEPedidoWeb(IDataRecord row)
        {
            if (row.HasColumn("CampaniaID"))
                CampaniaID = Convert.ToInt32(row["CampaniaID"]);
            if (row.HasColumn("PedidoID"))
                PedidoID = Convert.ToInt32(row["PedidoID"]);
            if (row.HasColumn("ConsultoraID"))
                ConsultoraID = Convert.ToInt64(row["ConsultoraID"]);
            if (row.HasColumn("Clientes"))
                Clientes = Convert.ToInt16(row["Clientes"]);
            if (row.HasColumn("ImporteTotal"))
                ImporteTotal = Convert.ToDecimal(row["ImporteTotal"]);
            if (row.HasColumn("ImporteCredito"))
                ImporteCredito = Convert.ToDecimal(row["ImporteCredito"]);
            if (row.HasColumn("EstadoPedidoDesc"))
                EstadoPedidoDesc = Convert.ToString(row["EstadoPedidoDesc"]);
            if (row.HasColumn("MotivoCreditoID"))
                MotivoCreditoID = Convert.ToInt16(row["MotivoCreditoID"]);
            if (row.HasColumn("PaisID"))
                PaisID = Convert.ToInt32(row["PaisID"]);
            if (row.HasColumn("CantidadProductos"))
                CantidadProductos = Convert.ToInt32(row["CantidadProductos"]);
            if (row.HasColumn("Bloqueado") && row["Bloqueado"] != DBNull.Value)
                Bloqueado = Convert.ToInt16(row["Bloqueado"]);
            if (row.HasColumn("Nombres"))
                Nombres = Convert.ToString(row["Nombres"]);
            if (row.HasColumn("DescripcionBloqueo") && row["DescripcionBloqueo"] != DBNull.Value)
                DescripcionBloqueo = Convert.ToString(row["DescripcionBloqueo"]);
            if (row.HasColumn("CodigoZona"))
                CodigoZona = Convert.ToString(row["CodigoZona"]);
            if (row.HasColumn("CodigoConsultora"))
                CodigoConsultora = Convert.ToString(row["CodigoConsultora"]);
            if (row.HasColumn("SaldoDeuda"))
                SaldoDeuda = Convert.ToDecimal(row["SaldoDeuda"]);
            if (row.HasColumn("MontoPedido"))
                MontoPedido = Convert.ToDecimal(row["MontoPedido"]);
            if (row.HasColumn("CodigoTerritorio"))
                CodigoTerritorio = Convert.ToString(row["CodigoTerritorio"]);
            if (row.HasColumn("Direccion"))
                Direccion = Convert.ToString(row["Direccion"]);
            if (row.HasColumn("IndicadorEnviado"))
                IndicadorEnviado = Convert.ToInt32(row["IndicadorEnviado"]);
            if (row.HasColumn("FechaRegistro"))
                FechaRegistro = Convert.ToDateTime(row["FechaRegistro"]);
            if (row.HasColumn("FechaModificacion") && row["FechaModificacion"] != DBNull.Value)
                FechaModificacion = Convert.ToDateTime(row["FechaModificacion"]);
            if (row.HasColumn("FechaProceso") && row["FechaProceso"] != DBNull.Value)
                FechaProceso = Convert.ToDateTime(row["FechaProceso"]);
            if (row.HasColumn("MontoTotalProl") && row["MontoTotalProl"] != DBNull.Value)
                MontoTotalProl = Convert.ToDecimal(row["MontoTotalProl"]);
            if (row.HasColumn("MontoAhorroCatalogo") && row["MontoAhorroCatalogo"] != DBNull.Value)
                MontoAhorroCatalogo = Convert.ToDecimal(row["MontoAhorroCatalogo"]);
            if (row.HasColumn("MontoAhorroRevista") && row["MontoAhorroRevista"] != DBNull.Value)
                MontoAhorroRevista = Convert.ToDecimal(row["MontoAhorroRevista"]);
            if (row.HasColumn("DescuentoProl") && row["DescuentoProl"] != DBNull.Value)
                DescuentoProl = Convert.ToDecimal(row["DescuentoProl"]);
            if (row.HasColumn("MontoEscala") && row["MontoEscala"] != DBNull.Value)
                MontoEscala = Convert.ToDecimal(row["MontoEscala"]);
            if (row.HasColumn("CanalIngreso") && row["CanalIngreso"] != DBNull.Value)
                CanalIngreso = Convert.ToString(row["CanalIngreso"]);
            if (row.HasColumn("Flete") && row["Flete"] != DBNull.Value)
                Flete = Convert.ToDecimal(row["Flete"]);
            if (row.HasColumn("CDRWebID") && row["CDRWebID"] != DBNull.Value)
                CDRWebID = Convert.ToInt32(row["CDRWebID"]);
            if (row.HasColumn("CDRWebEstado") && row["CDRWebEstado"] != DBNull.Value)
                CDRWebEstado = Convert.ToInt32(row["CDRWebEstado"]);
            if (row.HasColumn("NumeroPedido") && row["NumeroPedido"] != DBNull.Value)
                NumeroPedido = Convert.ToInt32(row["NumeroPedido"]);            
        }
    }
}
