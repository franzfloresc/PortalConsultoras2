using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Runtime.Serialization;
using System.Text;
using System.Threading.Tasks;
using OpenSource.Library.DataAccess;
using Portal.Consultoras.Common;

namespace Portal.Consultoras.Entities
{
    [DataContract]
    public class BEConfiguracionCampania
    {
        [DataMember]
        public int CampaniaID { get; set; }
        [DataMember]
        public DateTime FechaInicioFacturacion { get; set; }
        [DataMember]
        public DateTime FechaFinFacturacion { get; set; }
        [DataMember]
        public string CampaniaDescripcion { get; set; }

        [DataMember]
        public TimeSpan HoraInicio { get; set; }
        [DataMember]
        public TimeSpan HoraFin { get; set; }
        [DataMember]
        public byte DiasAntes { get; set; }
        [DataMember]
        public bool ZonaValida { get; set; }
        [DataMember]
        public TimeSpan HoraInicioNoFacturable { get; set; }
        [DataMember]
        public TimeSpan HoraCierreNoFacturable { get; set; }
        [DataMember]
        public int EstadoPedido { get; set; }
        [DataMember]
        public bool ModificaPedidoReservado { get; set; }
        [DataMember]
        public TimeSpan HoraCierreZonaNormal { get; set; }
        [DataMember]
        public TimeSpan HoraCierreZonaDemAnti { get; set; }
        [DataMember]
        public double ZonaHoraria { get; set; }
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
        public bool PROLSinStock { get; set; } //1510
        [DataMember]
        public DateTime FechaInicioReFacturacion { get; set; }
        [DataMember]
        public TimeSpan FactorCierreZonaNormal { get; set; }
        [DataMember]
        public TimeSpan FactorCierreZonaDemAnti { get; set; }
        [DataMember]
        public bool ValidacionAbierta { get; set; }//CCSS_JZ_PROL2
        [DataMember]
        public bool NuevoPROL { get; set; }//RQ_NP - R2133
        [DataMember]
        public bool ZonaNuevoPROL { get; set; }//RQ_NP - R2133
        [DataMember]
        public bool EstadoSimplificacionCUV   { get; set; } /*R20150701 - LR*/
        [DataMember]
        public bool EsquemaDAConsultora { get; set; }
        [DataMember]// R20151126
        public TimeSpan HoraCierreZonaDemAntiCierre { get; set; } // R20151126
        [DataMember]// R20150306
        public bool ValidacionInteractiva { get; set; } // R20150306
        [DataMember]// R20150306
        public string MensajeValidacionInteractiva { get; set; } // R20150306
        
        [DataMember]
        public int IndicadorEnviado { get; set; }
        [DataMember]
        public int IndicadorRechazado { get; set; }

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
                ZonaValida = Convert.ToInt32(datarec["ZonaValida"]) == -1 ? false : true;
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
                PROLSinStock = Convert.ToBoolean(datarec["PROLSinStock"]); //1510
            else
                PROLSinStock = false;
            if (DataRecord.HasColumn(datarec, "FechaFinFIC") && datarec["FechaFinFIC"] != DBNull.Value)
                FechaFinFIC = Convert.ToDateTime(datarec["FechaFinFIC"]);
            else
                FechaFinFIC = DateTime.Today;
            if (DataRecord.HasColumn(datarec, "FechaInicioReFacturacion") && datarec["FechaInicioReFacturacion"] != DBNull.Value)
                FechaInicioReFacturacion = Convert.ToDateTime(datarec["FechaInicioReFacturacion"]);
            if (DataRecord.HasColumn(datarec, "FactorCierreZonaNormal") && datarec["FactorCierreZonaNormal"] != DBNull.Value)
                FactorCierreZonaNormal = DbConvert.ToTimeSpan(datarec["FactorCierreZonaNormal"]);
            if (DataRecord.HasColumn(datarec, "FactorCierreZonaDemAnti") && datarec["FactorCierreZonaDemAnti"] != DBNull.Value)
                FactorCierreZonaDemAnti = DbConvert.ToTimeSpan(datarec["FactorCierreZonaDemAnti"]);
            //RQ_NP - R2133
            if (DataRecord.HasColumn(datarec, "NuevoPROL") && datarec["NuevoPROL"] != DBNull.Value)
                NuevoPROL = DbConvert.ToBoolean(datarec["NuevoPROL"]);
            //RQ_NP - R2133
            if (DataRecord.HasColumn(datarec, "ZonaNuevoPROL") && datarec["ZonaNuevoPROL"] != DBNull.Value)
                ZonaNuevoPROL = DbConvert.ToBoolean(datarec["ZonaNuevoPROL"]);
            /*R20150701*/
            if (DataRecord.HasColumn(datarec, "EstadoSimplificacionCUV") && datarec["EstadoSimplificacionCUV"] != DBNull.Value)
                EstadoSimplificacionCUV = DbConvert.ToBoolean(datarec["EstadoSimplificacionCUV"]);
            if (DataRecord.HasColumn(datarec, "EsquemaDAConsultora") && datarec["EsquemaDAConsultora"] != DBNull.Value)
                EsquemaDAConsultora = DbConvert.ToBoolean(datarec["EsquemaDAConsultora"]);
            if (DataRecord.HasColumn(datarec, "HoraCierreZonaDemAntiCierre") && datarec["HoraCierreZonaDemAntiCierre"] != DBNull.Value) //R20151126
                HoraCierreZonaDemAntiCierre = DbConvert.ToTimeSpan(datarec["HoraCierreZonaDemAntiCierre"]); //R20151126

            /*R20160306: INICIO*/
            if (DataRecord.HasColumn(datarec, "ValidacionInteractiva") && datarec["ValidacionInteractiva"] != DBNull.Value)
                ValidacionInteractiva = DbConvert.ToBoolean(datarec["ValidacionInteractiva"]);
            if (DataRecord.HasColumn(datarec, "MensajeValidacionInteractiva") && datarec["MensajeValidacionInteractiva"] != DBNull.Value)
                MensajeValidacionInteractiva = DbConvert.ToString(datarec["MensajeValidacionInteractiva"]);
            /*R20160306: FIN*/

            if (DataRecord.HasColumn(datarec, "IndicadorEnviado") && datarec["IndicadorEnviado"] != DBNull.Value)
                IndicadorEnviado = Convert.ToInt32(datarec["IndicadorEnviado"]);
            if (DataRecord.HasColumn(datarec, "IndicadorRechazado") && datarec["IndicadorRechazado"] != DBNull.Value)
                IndicadorRechazado = Convert.ToInt32(datarec["IndicadorRechazado"]);
        }

    }
}
