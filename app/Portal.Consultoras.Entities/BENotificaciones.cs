using Portal.Consultoras.Common;
using System;
using System.Data;
using System.Runtime.Serialization;

namespace Portal.Consultoras.Entities
{
    [DataContract]
    public class BENotificaciones
    {
        [DataMember]
        public long ProcesoId { get; set; }
        [DataMember]
        public int CampaniaId { get; set; }
        [DataMember]
        public string EstadoPROL { get; set; }
        [DataMember]
        public DateTime FechaHoraValidación { get; set; }
        [DataMember]
        public bool EnvioCorreo { get; set; }
        [DataMember]
        public string Proceso { get; set; }
        [DataMember]
        public int Estado { get; set; }
        [DataMember]
        public string Observaciones { get; set; }
        [DataMember]
        public string Asunto { get; set; }
        [DataMember]
        public DateTime FechaFacturacion { get; set; }
        [DataMember]
        public bool FacturaHoy { get; set; }
        [DataMember]
        public bool Visualizado { get; set; }
        [DataMember]
        public bool EsMontoMinimo { get; set; }
        [DataMember]
        public bool FlagProcedencia { get; set; }

        public BENotificaciones(IDataRecord row)
        {
            this.ProcesoId = Convert.ToInt64(row["ProcesoId"]);
            this.CampaniaId = Convert.ToInt32(row["CampaniaId"]);
            this.EstadoPROL = Convert.ToString(row["EstadoPROL"]);
            this.FechaHoraValidación = Convert.ToDateTime(row["FechaHoraValidación"]);
            this.EnvioCorreo = Convert.ToBoolean(row["EnvioCorreo"]);
            this.Proceso = Convert.ToString(row["Proceso"]);
            this.Estado = Convert.ToInt32(row["Estado"]);
            this.Observaciones = Convert.ToString(row["Observaciones"]);
            this.Asunto = Convert.ToString(row["Asunto"]);
            this.FechaFacturacion = Convert.ToDateTime(row["FechaFacturacion"]);
            this.FacturaHoy = Convert.ToBoolean(row["FacturaHoy"]);
            this.EsMontoMinimo = Convert.ToBoolean(row["EsMontoMinino"]);

            if (DataRecord.HasColumn(row, "Visualizado"))
                this.Visualizado = Convert.ToBoolean(row["Visualizado"]);

            this.FlagProcedencia = Convert.ToBoolean(row["FlagProcedencia"]);
        }
    }

    [DataContract]
    public class BENotificacionesDetalle
    {
        [DataMember]
        public string CUV { get; set; }
        [DataMember]
        public string CodigoObservacion { get; set; }
        [DataMember]
        public string MensajePROL { get; set; }

        public BENotificacionesDetalle(IDataRecord row)
        {
            this.CUV = Convert.ToString(row["CUV"]);
            this.CodigoObservacion = Convert.ToString(row["CodigoObservacion"]);
            this.MensajePROL = Convert.ToString(row["MensajePROL"]);
        }
    }

    [DataContract]
    public class BENotificacionesDetallePedido
    {
        [DataMember]
        public string CUV { get; set; }
        [DataMember]
        public string Descripcion { get; set; }
        [DataMember]
        public int StockDisponible { get; set; }
        [DataMember]
        public int Cantidad { get; set; }
        [DataMember]
        public decimal PrecioUnidad { get; set; }
        [DataMember]
        public decimal ImporteTotal { get; set; }
        [DataMember]
        public string ObservacionPROL { get; set; }

        [DataMember]
        public int IndicadorOferta { get; set; }
        [DataMember]
        public decimal MontoTotalProl { get; set; }
        [DataMember]
        public decimal DescuentoProl { get; set; }
        [DataMember]
        public decimal ImporteTotalPedido { get; set; }

        [DataMember]
        public decimal MontoAhorroCatalogo { get; set; }
        [DataMember]
        public decimal MontoAhorroRevista { get; set; }
        [DataMember]
        public string NombreCliente { get; set; }

        public BENotificacionesDetallePedido(IDataRecord row)
        {
            this.CUV = Convert.ToString(row["CUV"]);
            this.Descripcion = Convert.ToString(row["DescripcionProd"]);
            this.Cantidad = Convert.ToInt32(row["Cantidad"]);
            this.PrecioUnidad = Convert.ToDecimal(row["PrecioUnidad"]);
            this.ImporteTotal = Convert.ToDecimal(row["ImporteTotal"]);
            this.ObservacionPROL = Convert.ToString(row["ObservacionPROL"]);

            if (DataRecord.HasColumn(row, "IndicadorOferta") && row["IndicadorOferta"] != DBNull.Value)
                this.IndicadorOferta = Convert.ToInt16(row["IndicadorOferta"]);
            if (DataRecord.HasColumn(row, "MontoTotalProl") && row["MontoTotalProl"] != DBNull.Value)
                this.MontoTotalProl = Convert.ToDecimal(row["MontoTotalProl"]);
            if (DataRecord.HasColumn(row, "DescuentoProl") && row["DescuentoProl"] != DBNull.Value)
                this.DescuentoProl = Convert.ToDecimal(row["DescuentoProl"]);
            if (DataRecord.HasColumn(row, "ImporteTotalPedido") && row["ImporteTotalPedido"] != DBNull.Value)
                this.ImporteTotalPedido = Convert.ToDecimal(row["ImporteTotalPedido"]);

            if (DataRecord.HasColumn(row, "StockDisponible") && row["StockDisponible"] != DBNull.Value)
                StockDisponible = Convert.ToInt32(row["StockDisponible"]);
            if (DataRecord.HasColumn(row, "MontoAhorroCatalogo") && row["MontoAhorroCatalogo"] != DBNull.Value)
                MontoAhorroCatalogo = Convert.ToDecimal(row["MontoAhorroCatalogo"]);
            if (DataRecord.HasColumn(row, "MontoAhorroRevista") && row["MontoAhorroRevista"] != DBNull.Value)
                MontoAhorroRevista = Convert.ToDecimal(row["MontoAhorroRevista"]);
            if (DataRecord.HasColumn(row, "NombreCliente") && row["NombreCliente"] != DBNull.Value)
                NombreCliente = Convert.ToString(row["NombreCliente"]);
        }
    }

    [DataContract]
    public class BENotificacionesDetalleCatalogo
    {
        [DataMember]
        public string DetalleNotificacion { get; set; }
        [DataMember]
        public string NombreCliente { get; set; }
        [DataMember]
        public string CorreoCliente { get; set; }
        [DataMember]
        public string TelefonoCliente { get; set; }

        public BENotificacionesDetalleCatalogo(IDataRecord row)
        {
            this.DetalleNotificacion = row["DetalleNotificacion"] != DBNull.Value ? row["DetalleNotificacion"].ToString() : string.Empty;
            this.NombreCliente = row["NombreCliente"] != DBNull.Value ? row["NombreCliente"].ToString() : string.Empty;
            this.CorreoCliente = row["CorreoCliente"] != DBNull.Value ? row["CorreoCliente"].ToString() : string.Empty;
            this.TelefonoCliente = row["TelefonoCliente"] != DBNull.Value ? row["TelefonoCliente"].ToString() : string.Empty;
        }
    }
}
