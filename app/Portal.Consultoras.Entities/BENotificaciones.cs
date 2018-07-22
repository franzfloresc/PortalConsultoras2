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
            ProcesoId = row.ToInt64("ProcesoId");
            CampaniaId = row.ToInt32("CampaniaId");
            EstadoPROL = row.ToString("EstadoPROL");
            FechaHoraValidación = row.ToDateTime("FechaHoraValidación");
            EnvioCorreo = row.ToBoolean("EnvioCorreo");
            Proceso = row.ToString("Proceso");
            Estado = row.ToInt32("Estado");
            Observaciones = row.ToString("Observaciones");
            Asunto = row.ToString("Asunto");
            FechaFacturacion = row.ToDateTime("FechaFacturacion");
            FacturaHoy = row.ToBoolean("FacturaHoy");
            EsMontoMinimo = row.ToBoolean("EsMontoMinino");
            Visualizado = row.ToBoolean("Visualizado");
            FlagProcedencia = row.ToBoolean("FlagProcedencia");
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
            CUV = row.ToString("CUV");
            CodigoObservacion = row.ToString("CodigoObservacion");
            MensajePROL = row.ToString("MensajePROL");
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
            CUV = row.ToString("CUV");
            Descripcion = row.ToString("DescripcionProd");
            Cantidad = row.ToInt32("Cantidad");
            PrecioUnidad = row.ToDecimal("PrecioUnidad");
            ImporteTotal = row.ToDecimal("ImporteTotal");
            ObservacionPROL = row.ToString("ObservacionPROL");


                IndicadorOferta = row.ToInt16("IndicadorOferta");

                MontoTotalProl = row.ToDecimal("MontoTotalProl");

                DescuentoProl = row.ToDecimal("DescuentoProl");

                ImporteTotalPedido = row.ToDecimal("ImporteTotalPedido");


                StockDisponible = row.ToInt32("StockDisponible");

                MontoAhorroCatalogo = row.ToDecimal("MontoAhorroCatalogo");

                MontoAhorroRevista = row.ToDecimal("MontoAhorroRevista");

                NombreCliente = row.ToString("NombreCliente");
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


                DetalleNotificacion = row.ToString("DetalleNotificacion");

                NombreCliente = row.ToString("NombreCliente");

                CorreoCliente = row.ToString("CorreoCliente");

                TelefonoCliente = row.ToString("TelefonoCliente");
        }
    }
}
