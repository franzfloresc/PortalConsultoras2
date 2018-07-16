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

            if (DataRecord.HasColumn(row, "IndicadorOferta"))
                this.IndicadorOferta = Convert.ToInt16(row["IndicadorOferta"]);
            if (DataRecord.HasColumn(row, "MontoTotalProl"))
                this.MontoTotalProl = Convert.ToDecimal(row["MontoTotalProl"]);
            if (DataRecord.HasColumn(row, "DescuentoProl"))
                this.DescuentoProl = Convert.ToDecimal(row["DescuentoProl"]);
            if (DataRecord.HasColumn(row, "ImporteTotalPedido"))
                this.ImporteTotalPedido = Convert.ToDecimal(row["ImporteTotalPedido"]);

            if (DataRecord.HasColumn(row, "StockDisponible"))
                StockDisponible = Convert.ToInt32(row["StockDisponible"]);
            if (DataRecord.HasColumn(row, "MontoAhorroCatalogo"))
                MontoAhorroCatalogo = Convert.ToDecimal(row["MontoAhorroCatalogo"]);
            if (DataRecord.HasColumn(row, "MontoAhorroRevista"))
                MontoAhorroRevista = Convert.ToDecimal(row["MontoAhorroRevista"]);
            if (DataRecord.HasColumn(row, "NombreCliente"))
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
            this.DetalleNotificacion = row["DetalleNotificacion"] != DBNull.Value ? Convert.ToString(row["DetalleNotificacion"]) : string.Empty;
            this.NombreCliente = row["NombreCliente"] != DBNull.Value ? Convert.ToString(row["NombreCliente"]) : string.Empty;
            this.CorreoCliente = row["CorreoCliente"] != DBNull.Value ? Convert.ToString(row["CorreoCliente"]) : string.Empty;
            this.TelefonoCliente = row["TelefonoCliente"] != DBNull.Value ? Convert.ToString(row["TelefonoCliente"]) : string.Empty;
        }
    }
}
