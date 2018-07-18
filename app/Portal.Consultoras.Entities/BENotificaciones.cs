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
            ProcesoId = Convert.ToInt64(row["ProcesoId"]);
            CampaniaId = Convert.ToInt32(row["CampaniaId"]);
            EstadoPROL = Convert.ToString(row["EstadoPROL"]);
            FechaHoraValidación = Convert.ToDateTime(row["FechaHoraValidación"]);
            EnvioCorreo = Convert.ToBoolean(row["EnvioCorreo"]);
            Proceso = Convert.ToString(row["Proceso"]);
            Estado = Convert.ToInt32(row["Estado"]);
            Observaciones = Convert.ToString(row["Observaciones"]);
            Asunto = Convert.ToString(row["Asunto"]);
            FechaFacturacion = Convert.ToDateTime(row["FechaFacturacion"]);
            FacturaHoy = Convert.ToBoolean(row["FacturaHoy"]);
            EsMontoMinimo = Convert.ToBoolean(row["EsMontoMinino"]);
            Visualizado = row.ToBoolean("Visualizado");
            FlagProcedencia = Convert.ToBoolean(row["FlagProcedencia"]);
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
            CUV = Convert.ToString(row["CUV"]);
            CodigoObservacion = Convert.ToString(row["CodigoObservacion"]);
            MensajePROL = Convert.ToString(row["MensajePROL"]);
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
            CUV = Convert.ToString(row["CUV"]);
            Descripcion = Convert.ToString(row["DescripcionProd"]);
            Cantidad = Convert.ToInt32(row["Cantidad"]);
            PrecioUnidad = Convert.ToDecimal(row["PrecioUnidad"]);
            ImporteTotal = Convert.ToDecimal(row["ImporteTotal"]);
            ObservacionPROL = Convert.ToString(row["ObservacionPROL"]);

            if (DataRecord.HasColumn(row, "IndicadorOferta"))
                IndicadorOferta = Convert.ToInt16(row["IndicadorOferta"]);
            if (DataRecord.HasColumn(row, "MontoTotalProl"))
                MontoTotalProl = Convert.ToDecimal(row["MontoTotalProl"]);
            if (DataRecord.HasColumn(row, "DescuentoProl"))
                DescuentoProl = Convert.ToDecimal(row["DescuentoProl"]);
            if (DataRecord.HasColumn(row, "ImporteTotalPedido"))
                ImporteTotalPedido = Convert.ToDecimal(row["ImporteTotalPedido"]);

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
            DetalleNotificacion = string.Empty;
            NombreCliente = string.Empty;
            CorreoCliente = string.Empty;
            TelefonoCliente = string.Empty;

            if (DataRecord.HasColumn(row, "DetalleNotificacion"))
                DetalleNotificacion = Convert.ToString(row["DetalleNotificacion"]);
            if (DataRecord.HasColumn(row, "NombreCliente"))
                NombreCliente = Convert.ToString(row["NombreCliente"]);
            if (DataRecord.HasColumn(row, "CorreoCliente"))
                CorreoCliente = Convert.ToString(row["CorreoCliente"]);
            if (DataRecord.HasColumn(row, "TelefonoCliente"))
                TelefonoCliente = Convert.ToString(row["TelefonoCliente"]);
        }
    }
}
