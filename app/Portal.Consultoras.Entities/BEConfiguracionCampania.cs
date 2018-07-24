using OpenSource.Library.DataAccess;
using Portal.Consultoras.Common;
using System;
using System.ComponentModel.DataAnnotations.Schema;
using System.Data;
using System.Runtime.Serialization;

namespace Portal.Consultoras.Entities
{
    [DataContract]
    public class BEConfiguracionCampania
    {
        [Column("CampaniaID")]
        public string TempCampaniaId { get; set; }

        [Column("DiasAntes")]
        public int TempDiasAntes { get; set; }

        [Column("ZonaValida")]
        public int TempZonaValida { get; set; }

        [DataMember]
        public int CampaniaID
        {
            get
            {
                int defaultCampania;
                return int.TryParse(TempCampaniaId, out defaultCampania) ? defaultCampania : 0;
            }
            set { TempCampaniaId = value.ToString(); }
        }

        [Column("FechaInicioFacturacion")]
        [DataMember]
        public DateTime FechaInicioFacturacion { get; set; }

        [Column("FechaFinFacturacion")]
        [DataMember]
        public DateTime FechaFinFacturacion { get; set; }

        [Column("CampaniaDescripcion")]
        [DataMember]
        public string CampaniaDescripcion { get; set; }

        [Column("HoraInicio")]
        [DataMember]
        public TimeSpan HoraInicio { get; set; }

        [Column("HoraFin")]
        [DataMember]
        public TimeSpan HoraFin { get; set; }

        [DataMember]
        public byte DiasAntes
        {
            get
            {
                return Convert.ToByte(TempDiasAntes);
            }
            set { TempDiasAntes = Convert.ToInt32(value); }
        }

        [DataMember]
        public bool ZonaValida
        {
            get { return TempZonaValida != -1; }
            set { TempZonaValida = value ? 1 : -1; }
        }

        [Column("HoraInicioNoFacturable")]
        [DataMember]
        public TimeSpan HoraInicioNoFacturable { get; set; }
        [DataMember]
        [Column("HoraCierreNoFacturable")]
        public TimeSpan HoraCierreNoFacturable { get; set; }
        [DataMember]
        [Column("EstadoPedido")]
        public int EstadoPedido { get; set; }
        [DataMember]
        [Column("ModificaPedidoReservado")]
        public bool ModificaPedidoReservado { get; set; }

        [Column("HoraCierreZonaNormal")]
        [DataMember]
        public TimeSpan HoraCierreZonaNormal { get; set; }

        [Column("HoraCierreZonaDemAnti")]
        [DataMember]
        public TimeSpan HoraCierreZonaDemAnti { get; set; }

        [Column("ZonaHoraria")]
        [DataMember]
        public double ZonaHoraria { get; set; }

        [Column("EsZonaDemAnti")]
        [DataMember]
        public int EsZonaDemAnti { get; set; }
        [DataMember]
        public byte DiasDuracionCronograma { get; set; }
        [DataMember]
        public bool HabilitarRestriccionHoraria { get; set; }
        [DataMember]
        public int HorasDuracionRestriccion { get; set; }
        [DataMember]
        [Column("NroCampanias")]
        public int NroCampanias { get; set; }
        [DataMember]
        public DateTime FechaFinFIC { get; set; }
        [DataMember]
        public int IndicadorOfertaFIC { get; set; }
        [DataMember]
        public string ImagenURLOfertaFIC { get; set; }
        [DataMember]
        [Column("PROLSinStock")]
        public bool PROLSinStock { get; set; }
        [DataMember]
        public DateTime FechaInicioReFacturacion { get; set; }
        [DataMember]
        public TimeSpan FactorCierreZonaNormal { get; set; }
        [DataMember]
        public TimeSpan FactorCierreZonaDemAnti { get; set; }
        [DataMember]
        [Column("ValidacionAbierta")]
        public bool ValidacionAbierta { get; set; }

        [Column("NuevoPROL")]
        [DataMember]
        public bool NuevoPROL { get; set; }

        [Column("ZonaNuevoPROL")]
        [DataMember]
        public bool ZonaNuevoPROL { get; set; }
        [DataMember]
        public bool EstadoSimplificacionCUV { get; set; }
        [DataMember]
        public bool EsquemaDAConsultora { get; set; }
        [DataMember]
        public TimeSpan HoraCierreZonaDemAntiCierre { get; set; }
        [DataMember]
        [Column("ValidacionInteractiva")]
        public bool ValidacionInteractiva { get; set; }
        [DataMember]
        public string MensajeValidacionInteractiva { get; set; }

        [Column("IndicadorGPRSB")]
        [DataMember]
        public int IndicadorGPRSB { get; set; }
        [DataMember]
        [Column("FechaActualPais")]
        public DateTime FechaActualPais { get; set; }

        [Column("AceptacionConsultoraDA")]
        [DataMember]
        public int AceptacionConsultoraDA { get; set; }

        [Column("IndicadorEnviado")]
        [DataMember]
        public bool IndicadorEnviado { get; set; }

        public BEConfiguracionCampania()
        {

        }

        [Obsolete("Use MapUtil.MapToCollection")]
        public BEConfiguracionCampania(IDataRecord row)
        {
            CampaniaID = row.ToInt32("CampaniaID");
            FechaInicioFacturacion = row.ToDateTime("FechaInicioFacturacion");
            FechaFinFacturacion = row.ToDateTime("FechaFinFacturacion");
            CampaniaDescripcion = row.ToString("CampaniaDescripcion");
            if (DataRecord.HasColumn(row, "HoraInicio"))
                HoraInicio = DbConvert.ToTimeSpan(row["HoraInicio"]);
            if (DataRecord.HasColumn(row, "HoraFin"))
                HoraFin = DbConvert.ToTimeSpan(row["HoraFin"]);
            DiasAntes = row.ToByte("DiasAntes");
            TempZonaValida = row.ToInt32("ZonaValida");
            if (DataRecord.HasColumn(row, "HoraInicioNoFacturable"))
                HoraInicioNoFacturable = DbConvert.ToTimeSpan(row["HoraInicioNoFacturable"]);
            if (DataRecord.HasColumn(row, "HoraCierreNoFacturable"))
                HoraCierreNoFacturable = DbConvert.ToTimeSpan(row["HoraCierreNoFacturable"]);
            if (DataRecord.HasColumn(row, "HoraCierreZonaNormal"))
                HoraCierreZonaNormal = DbConvert.ToTimeSpan(row["HoraCierreZonaNormal"]);
            if (DataRecord.HasColumn(row, "HoraCierreZonaDemAnti"))
                HoraCierreZonaDemAnti = DbConvert.ToTimeSpan(row["HoraCierreZonaDemAnti"]);
            ZonaHoraria = row.ToDouble("ZonaHoraria");
            EsZonaDemAnti = row.ToInt32("EsZonaDemAnti");
            DiasDuracionCronograma = row.ToByte("DiasDuracionCronograma");
            HabilitarRestriccionHoraria = row.ToBoolean("HabilitarRestriccionHoraria");
            HorasDuracionRestriccion = row.ToInt32("HorasDuracionRestriccion");
            NroCampanias = row.ToInt32("NroCampanias");
            PROLSinStock = row.ToBoolean("PROLSinStock");
            FechaFinFIC = row.ToDateTime("FechaFinFIC", DateTime.Today);
            IndicadorOfertaFIC = row.ToInt32("IndicadorOfertaFIC");
            ImagenURLOfertaFIC = row.ToString("ImagenUrlOfertaFIC", string.Empty);
            FechaInicioReFacturacion = row.ToDateTime("FechaInicioReFacturacion");
            if (DataRecord.HasColumn(row, "FactorCierreZonaNormal"))
                FactorCierreZonaNormal = DbConvert.ToTimeSpan(row["FactorCierreZonaNormal"]);
            if (DataRecord.HasColumn(row, "FactorCierreZonaDemAnti"))
                FactorCierreZonaDemAnti = DbConvert.ToTimeSpan(row["FactorCierreZonaDemAnti"]);
            NuevoPROL = row.ToBoolean("NuevoPROL");
            ZonaNuevoPROL = row.ToBoolean("ZonaNuevoPROL");
            EstadoSimplificacionCUV = row.ToBoolean("EstadoSimplificacionCUV");
            EsquemaDAConsultora = row.ToBoolean("EsquemaDAConsultora");
            if (DataRecord.HasColumn(row, "HoraCierreZonaDemAntiCierre"))
                HoraCierreZonaDemAntiCierre = DbConvert.ToTimeSpan(row["HoraCierreZonaDemAntiCierre"]);
            ValidacionInteractiva = row.ToBoolean("ValidacionInteractiva");
            MensajeValidacionInteractiva = row.ToString("MensajeValidacionInteractiva");
            IndicadorGPRSB = row.ToInt32("IndicadorGPRSB");
            IndicadorEnviado = row.ToBoolean("IndicadorEnviado");
            EstadoPedido = row.ToInt32("EstadoPedido");
            ModificaPedidoReservado = row.ToBoolean("ModificaPedidoReservado");
            ValidacionAbierta = row.ToBoolean("ValidacionAbierta");
            FechaActualPais = row.ToDateTime("FechaActualPais");
            AceptacionConsultoraDA = row.ToInt32("AceptacionConsultoraDA");
        }
    }
}
