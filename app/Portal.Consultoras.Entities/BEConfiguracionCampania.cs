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
        public BEConfiguracionCampania(IDataRecord datarec)
        {
            if (DataRecord.HasColumn(datarec, "CampaniaID"))
                CampaniaID = DbConvert.ToInt32(datarec["CampaniaID"]);
            if (DataRecord.HasColumn(datarec, "FechaInicioFacturacion"))
                FechaInicioFacturacion = DbConvert.ToDateTime(datarec["FechaInicioFacturacion"]);
            if (DataRecord.HasColumn(datarec, "FechaFinFacturacion"))
                FechaFinFacturacion = DbConvert.ToDateTime(datarec["FechaFinFacturacion"]);
            if (DataRecord.HasColumn(datarec, "CampaniaDescripcion"))
                CampaniaDescripcion = DbConvert.ToString(datarec["CampaniaDescripcion"]);
            if (DataRecord.HasColumn(datarec, "HoraInicio"))
                HoraInicio = DbConvert.ToTimeSpan(datarec["HoraInicio"]);
            if (DataRecord.HasColumn(datarec, "HoraFin"))
                HoraFin = DbConvert.ToTimeSpan(datarec["HoraFin"]);
            if (DataRecord.HasColumn(datarec, "DiasAntes"))
                DiasAntes = DbConvert.ToByte(datarec["DiasAntes"]);
            if (DataRecord.HasColumn(datarec, "ZonaValida"))
                TempZonaValida = Convert.ToInt32(datarec["ZonaValida"]);
            if (DataRecord.HasColumn(datarec, "HoraInicioNoFacturable"))
                HoraInicioNoFacturable = DbConvert.ToTimeSpan(datarec["HoraInicioNoFacturable"]);
            if (DataRecord.HasColumn(datarec, "HoraCierreNoFacturable"))
                HoraCierreNoFacturable = DbConvert.ToTimeSpan(datarec["HoraCierreNoFacturable"]);
            if (DataRecord.HasColumn(datarec, "HoraCierreZonaNormal"))
                HoraCierreZonaNormal = DbConvert.ToTimeSpan(datarec["HoraCierreZonaNormal"]);
            if (DataRecord.HasColumn(datarec, "HoraCierreZonaDemAnti"))
                HoraCierreZonaDemAnti = DbConvert.ToTimeSpan(datarec["HoraCierreZonaDemAnti"]);
            if (DataRecord.HasColumn(datarec, "ZonaHoraria"))
                ZonaHoraria = DbConvert.ToDouble(datarec["ZonaHoraria"]);
            if (DataRecord.HasColumn(datarec, "EsZonaDemAnti"))
                EsZonaDemAnti = DbConvert.ToInt32(datarec["EsZonaDemAnti"]);
            if (DataRecord.HasColumn(datarec, "DiasDuracionCronograma"))
                DiasDuracionCronograma = DbConvert.ToByte(datarec["DiasDuracionCronograma"]);
            if (DataRecord.HasColumn(datarec, "HabilitarRestriccionHoraria"))
                HabilitarRestriccionHoraria = DbConvert.ToBoolean(datarec["HabilitarRestriccionHoraria"]);
            if (DataRecord.HasColumn(datarec, "HorasDuracionRestriccion"))
                HorasDuracionRestriccion = DbConvert.ToInt32(datarec["HorasDuracionRestriccion"]);
            if (DataRecord.HasColumn(datarec, "NroCampanias"))
                NroCampanias = DbConvert.ToInt32(datarec["NroCampanias"]);
            if (DataRecord.HasColumn(datarec, "PROLSinStock"))
                PROLSinStock = Convert.ToBoolean(datarec["PROLSinStock"]);

            if (DataRecord.HasColumn(datarec, "FechaFinFIC")) FechaFinFIC = Convert.ToDateTime(datarec["FechaFinFIC"]);
            else FechaFinFIC = DateTime.Today;
            if (DataRecord.HasColumn(datarec, "IndicadorOfertaFIC")) IndicadorOfertaFIC = Convert.ToInt32(datarec["IndicadorOfertaFIC"]);
            if (DataRecord.HasColumn(datarec, "ImagenUrlOfertaFIC")) ImagenURLOfertaFIC = Convert.ToString(datarec["ImagenUrlOfertaFIC"]);
            else ImagenURLOfertaFIC = string.Empty;

            if (DataRecord.HasColumn(datarec, "FechaInicioReFacturacion"))
                FechaInicioReFacturacion = Convert.ToDateTime(datarec["FechaInicioReFacturacion"]);
            if (DataRecord.HasColumn(datarec, "FactorCierreZonaNormal"))
                FactorCierreZonaNormal = DbConvert.ToTimeSpan(datarec["FactorCierreZonaNormal"]);
            if (DataRecord.HasColumn(datarec, "FactorCierreZonaDemAnti"))
                FactorCierreZonaDemAnti = DbConvert.ToTimeSpan(datarec["FactorCierreZonaDemAnti"]);

            if (DataRecord.HasColumn(datarec, "NuevoPROL"))
                NuevoPROL = DbConvert.ToBoolean(datarec["NuevoPROL"]);

            if (DataRecord.HasColumn(datarec, "ZonaNuevoPROL"))
                ZonaNuevoPROL = DbConvert.ToBoolean(datarec["ZonaNuevoPROL"]);

            if (DataRecord.HasColumn(datarec, "EstadoSimplificacionCUV"))
                EstadoSimplificacionCUV = DbConvert.ToBoolean(datarec["EstadoSimplificacionCUV"]);
            if (DataRecord.HasColumn(datarec, "EsquemaDAConsultora"))
                EsquemaDAConsultora = DbConvert.ToBoolean(datarec["EsquemaDAConsultora"]);
            if (DataRecord.HasColumn(datarec, "HoraCierreZonaDemAntiCierre"))
                HoraCierreZonaDemAntiCierre = DbConvert.ToTimeSpan(datarec["HoraCierreZonaDemAntiCierre"]);

            if (DataRecord.HasColumn(datarec, "ValidacionInteractiva"))
                ValidacionInteractiva = DbConvert.ToBoolean(datarec["ValidacionInteractiva"]);
            if (DataRecord.HasColumn(datarec, "MensajeValidacionInteractiva"))
                MensajeValidacionInteractiva = DbConvert.ToString(datarec["MensajeValidacionInteractiva"]);

            if (DataRecord.HasColumn(datarec, "IndicadorGPRSB")) IndicadorGPRSB = Convert.ToInt32(datarec["IndicadorGPRSB"]);
            if (DataRecord.HasColumn(datarec, "IndicadorEnviado")) IndicadorEnviado = Convert.ToBoolean(datarec["IndicadorEnviado"]);

            if (DataRecord.HasColumn(datarec, "EstadoPedido"))
                EstadoPedido = Convert.ToInt32(datarec["EstadoPedido"]);

            if (DataRecord.HasColumn(datarec, "ModificaPedidoReservado"))
                ModificaPedidoReservado = Convert.ToBoolean(datarec["ModificaPedidoReservado"]);

            if (DataRecord.HasColumn(datarec, "ValidacionAbierta"))
                ValidacionAbierta = Convert.ToBoolean(datarec["ValidacionAbierta"]);

            if (DataRecord.HasColumn(datarec, "FechaActualPais"))
                FechaActualPais = Convert.ToDateTime(datarec["FechaActualPais"]);

            if (DataRecord.HasColumn(datarec, "AceptacionConsultoraDA"))
                AceptacionConsultoraDA = Convert.ToInt32(datarec["AceptacionConsultoraDA"]);
        }
    }
}
