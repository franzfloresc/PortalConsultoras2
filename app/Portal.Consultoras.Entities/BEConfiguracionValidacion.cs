using OpenSource.Library.DataAccess;
using Portal.Consultoras.Common;
using System;
using System.Data;
using System.Runtime.Serialization;

namespace Portal.Consultoras.Entities
{
    [DataContract]
    public class BEConfiguracionValidacion
    {
        [DataMember]
        public int CampaniaID { set; get; }
        [DataMember]
        public int PaisID { set; get; }
        [DataMember]
        public Int16 DiasAntes { set; get; }
        [DataMember]
        public TimeSpan HoraInicio { set; get; }
        [DataMember]
        public TimeSpan HoraFin { set; get; }
        [DataMember]
        public TimeSpan HoraInicioNoFacturable { set; get; }
        [DataMember]
        public TimeSpan HoraCierreNoFacturable { set; get; }
        [DataMember]
        public bool FlagNoValidados { get; set; }
        [DataMember]
        public Int16 ProcesoRegular { get; set; }
        [DataMember]
        public Int16 ProcesoDA { get; set; }
        [DataMember]
        public Int16 ProcesoDAPRD { get; set; }
        [DataMember]
        public bool HabilitarRestriccionHoraria { get; set; }
        [DataMember]
        public string CodigoUsuarioModificacion { get; set; }
        [DataMember]
        public bool TieneProl3 { get; set; }

        public BEConfiguracionValidacion()
        { }

        public BEConfiguracionValidacion(IDataRecord row)
        {
            if (DataRecord.HasColumn(row, "CampaniaID")) CampaniaID = Convert.ToInt32(row["CampaniaID"]);
            if (DataRecord.HasColumn(row, "PaisID")) PaisID = Convert.ToInt32(row["PaisID"]);
            if (DataRecord.HasColumn(row, "DiasAntes")) DiasAntes = Convert.ToInt16(row["DiasAntes"]);
            if (DataRecord.HasColumn(row, "HoraInicio")) HoraInicio = DbConvert.ToTimeSpan(row["HoraInicio"]);
            if (DataRecord.HasColumn(row, "HoraFin")) HoraFin = DbConvert.ToTimeSpan(row["HoraFin"]);
            if (DataRecord.HasColumn(row, "HoraInicioNoFacturable")) HoraInicioNoFacturable = DbConvert.ToTimeSpan(row["HoraInicioNoFacturable"]);
            if (DataRecord.HasColumn(row, "HoraCierreNoFacturable")) HoraCierreNoFacturable = DbConvert.ToTimeSpan(row["HoraCierreNoFacturable"]);
            if (DataRecord.HasColumn(row, "FlagNoValidados")) FlagNoValidados = Convert.ToBoolean(row["FlagNoValidados"]);
            ProcesoRegular = Convert.ToInt16(DataRecord.HasColumn(row, "ProcesoRegular") ? row["ProcesoRegular"] : -1);
            ProcesoDA = Convert.ToInt16(DataRecord.HasColumn(row, "ProcesoDA") ? row["ProcesoDA"] : -1);
            ProcesoDAPRD = Convert.ToInt16(DataRecord.HasColumn(row, "ProcesoDAPRD") ? row["ProcesoDAPRD"] : -1);
            if (DataRecord.HasColumn(row, "HabilitarRestriccionHoraria")) HabilitarRestriccionHoraria = Convert.ToBoolean(row["HabilitarRestriccionHoraria"]);
            if (DataRecord.HasColumn(row, "TieneProl3")) TieneProl3 = Convert.ToBoolean(row["TieneProl3"]);
        }
    }
}
