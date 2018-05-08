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
            if (DataRecord.HasColumn(datarec, "CampaniaID") && datarec["CampaniaID"] != DBNull.Value)
                CampaniaID = DbConvert.ToInt32(datarec["CampaniaID"]);
            if (DataRecord.HasColumn(datarec, "FechaInicioFacturacion") && datarec["FechaInicioFacturacion"] != DBNull.Value)
                FechaInicioFacturacion = DbConvert.ToDateTime(datarec["FechaInicioFacturacion"]);
            if (DataRecord.HasColumn(datarec, "FechaFinFacturacion") && datarec["FechaFinFacturacion"] != DBNull.Value)
                FechaFinFacturacion = DbConvert.ToDateTime(datarec["FechaFinFacturacion"]);
            if (DataRecord.HasColumn(datarec, "CampaniaDescripcion") && datarec["CampaniaDescripcion"] != DBNull.Value)
                CampaniaDescripcion = DbConvert.ToString(datarec["CampaniaDescripcion"]);
            if (DataRecord.HasColumn(datarec, "HoraInicio") && datarec["HoraInicio"] != DBNull.Value)
                HoraInicio = DbConvert.ToTimeSpan(datarec["HoraInicio"]);
            if (DataRecord.HasColumn(datarec, "HoraFin") && datarec["HoraFin"] != DBNull.Value)
                HoraFin = DbConvert.ToTimeSpan(datarec["HoraFin"]);
            if (DataRecord.HasColumn(datarec, "DiasAntes") && datarec["DiasAntes"] != DBNull.Value)
                DiasAntes = DbConvert.ToByte(datarec["DiasAntes"]);
            if (DataRecord.HasColumn(datarec, "ZonaValida") && datarec["ZonaValida"] != DBNull.Value)
                TempZonaValida = Convert.ToInt32(datarec["ZonaValida"]);
            if (DataRecord.HasColumn(datarec, "HoraInicioNoFacturable") && datarec["HoraInicioNoFacturable"] != DBNull.Value)
                HoraInicioNoFacturable = DbConvert.ToTimeSpan(datarec["HoraInicioNoFacturable"]);
            if (DataRecord.HasColumn(datarec, "HoraCierreNoFacturable") && datarec["HoraCierreNoFacturable"] != DBNull.Value)
                HoraCierreNoFacturable = DbConvert.ToTimeSpan(datarec["HoraCierreNoFacturable"]);
            if (DataRecord.HasColumn(datarec, "HoraCierreZonaNormal") && datarec["HoraCierreZonaNormal"] != DBNull.Value)
                HoraCierreZonaNormal = DbConvert.ToTimeSpan(datarec["HoraCierreZonaNormal"]);
            if (DataRecord.HasColumn(datarec, "HoraCierreZonaDemAnti") && datarec["HoraCierreZonaDemAnti"] != DBNull.Value)
                HoraCierreZonaDemAnti = DbConvert.ToTimeSpan(datarec["HoraCierreZonaDemAnti"]);
            if (DataRecord.HasColumn(datarec, "ZonaHoraria") && datarec["ZonaHoraria"] != DBNull.Value)
                ZonaHoraria = DbConvert.ToDouble(datarec["ZonaHoraria"]);
            if (DataRecord.HasColumn(datarec, "EsZonaDemAnti") && datarec["EsZonaDemAnti"] != DBNull.Value)
                EsZonaDemAnti = DbConvert.ToInt32(datarec["EsZonaDemAnti"]);
            if (DataRecord.HasColumn(datarec, "DiasDuracionCronograma") && datarec["DiasDuracionCronograma"] != DBNull.Value)
                DiasDuracionCronograma = DbConvert.ToByte(datarec["DiasDuracionCronograma"]);
            if (DataRecord.HasColumn(datarec, "HabilitarRestriccionHoraria") && datarec["HabilitarRestriccionHoraria"] != DBNull.Value)
                HabilitarRestriccionHoraria = DbConvert.ToBoolean(datarec["HabilitarRestriccionHoraria"]);
            if (DataRecord.HasColumn(datarec, "HorasDuracionRestriccion") && datarec["HorasDuracionRestriccion"] != DBNull.Value)
                HorasDuracionRestriccion = DbConvert.ToInt32(datarec["HorasDuracionRestriccion"]);
            if (DataRecord.HasColumn(datarec, "NroCampanias") && datarec["NroCampanias"] != DBNull.Value)
                NroCampanias = DbConvert.ToInt32(datarec["NroCampanias"]);
            if (DataRecord.HasColumn(datarec, "PROLSinStock") && datarec["PROLSinStock"] != DBNull.Value)
                PROLSinStock = Convert.ToBoolean(datarec["PROLSinStock"]);
            else
                PROLSinStock = false;

            if (DataRecord.HasColumn(datarec, "FechaFinFIC")) FechaFinFIC = Convert.ToDateTime(datarec["FechaFinFIC"]);
            else FechaFinFIC = DateTime.Today;
            if (DataRecord.HasColumn(datarec, "IndicadorOfertaFIC")) IndicadorOfertaFIC = Convert.ToInt32(datarec["IndicadorOfertaFIC"]);
            if (DataRecord.HasColumn(datarec, "ImagenUrlOfertaFIC")) ImagenURLOfertaFIC = Convert.ToString(datarec["ImagenUrlOfertaFIC"]);
            else ImagenURLOfertaFIC = string.Empty;

            if (DataRecord.HasColumn(datarec, "FechaInicioReFacturacion") && datarec["FechaInicioReFacturacion"] != DBNull.Value)
                FechaInicioReFacturacion = Convert.ToDateTime(datarec["FechaInicioReFacturacion"]);
            if (DataRecord.HasColumn(datarec, "FactorCierreZonaNormal") && datarec["FactorCierreZonaNormal"] != DBNull.Value)
                FactorCierreZonaNormal = DbConvert.ToTimeSpan(datarec["FactorCierreZonaNormal"]);
            if (DataRecord.HasColumn(datarec, "FactorCierreZonaDemAnti") && datarec["FactorCierreZonaDemAnti"] != DBNull.Value)
                FactorCierreZonaDemAnti = DbConvert.ToTimeSpan(datarec["FactorCierreZonaDemAnti"]);

            if (DataRecord.HasColumn(datarec, "NuevoPROL") && datarec["NuevoPROL"] != DBNull.Value)
                NuevoPROL = DbConvert.ToBoolean(datarec["NuevoPROL"]);

            if (DataRecord.HasColumn(datarec, "ZonaNuevoPROL") && datarec["ZonaNuevoPROL"] != DBNull.Value)
                ZonaNuevoPROL = DbConvert.ToBoolean(datarec["ZonaNuevoPROL"]);

            if (DataRecord.HasColumn(datarec, "EstadoSimplificacionCUV") && datarec["EstadoSimplificacionCUV"] != DBNull.Value)
                EstadoSimplificacionCUV = DbConvert.ToBoolean(datarec["EstadoSimplificacionCUV"]);
            if (DataRecord.HasColumn(datarec, "EsquemaDAConsultora") && datarec["EsquemaDAConsultora"] != DBNull.Value)
                EsquemaDAConsultora = DbConvert.ToBoolean(datarec["EsquemaDAConsultora"]);
            if (DataRecord.HasColumn(datarec, "HoraCierreZonaDemAntiCierre") && datarec["HoraCierreZonaDemAntiCierre"] != DBNull.Value)
                HoraCierreZonaDemAntiCierre = DbConvert.ToTimeSpan(datarec["HoraCierreZonaDemAntiCierre"]);

            if (DataRecord.HasColumn(datarec, "ValidacionInteractiva") && datarec["ValidacionInteractiva"] != DBNull.Value)
                ValidacionInteractiva = DbConvert.ToBoolean(datarec["ValidacionInteractiva"]);
            if (DataRecord.HasColumn(datarec, "MensajeValidacionInteractiva") && datarec["MensajeValidacionInteractiva"] != DBNull.Value)
                MensajeValidacionInteractiva = DbConvert.ToString(datarec["MensajeValidacionInteractiva"]);

            if (DataRecord.HasColumn(datarec, "IndicadorGPRSB")) IndicadorGPRSB = Convert.ToInt32(datarec["IndicadorGPRSB"]);
            if (DataRecord.HasColumn(datarec, "IndicadorEnviado")) IndicadorEnviado = Convert.ToBoolean(datarec["IndicadorEnviado"]);

            if (DataRecord.HasColumn(datarec, "EstadoPedido") && datarec["EstadoPedido"] != DBNull.Value)
                EstadoPedido = Convert.ToInt32(datarec["EstadoPedido"]);

            if (DataRecord.HasColumn(datarec, "ModificaPedidoReservado") && datarec["ModificaPedidoReservado"] != DBNull.Value)
                ModificaPedidoReservado = Convert.ToBoolean(datarec["ModificaPedidoReservado"]);

            if (DataRecord.HasColumn(datarec, "ValidacionAbierta") && datarec["ValidacionAbierta"] != DBNull.Value)
                ValidacionAbierta = Convert.ToBoolean(datarec["ValidacionAbierta"]);

            if (DataRecord.HasColumn(datarec, "FechaActualPais"))
                FechaActualPais = Convert.ToDateTime(datarec["FechaActualPais"]);

            if (DataRecord.HasColumn(datarec, "AceptacionConsultoraDA") && datarec["AceptacionConsultoraDA"] != DBNull.Value)
                AceptacionConsultoraDA = Convert.ToInt32(datarec["AceptacionConsultoraDA"]);
        }
    }
}
