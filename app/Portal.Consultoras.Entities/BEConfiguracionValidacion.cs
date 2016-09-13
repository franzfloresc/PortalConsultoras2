using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Runtime.Serialization;
using System.Text;
using System.Threading.Tasks;
using Portal.Consultoras.Common;
using OpenSource.Library.DataAccess;

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

        public BEConfiguracionValidacion()
        { }

        public BEConfiguracionValidacion(IDataRecord row)
        {
            if (DataRecord.HasColumn(row, "CampaniaID"))
                CampaniaID = Convert.ToInt32(row["CampaniaID"]);
            if (DataRecord.HasColumn(row, "PaisID"))
                PaisID = Convert.ToInt32(row["PaisID"]);
            if (DataRecord.HasColumn(row, "DiasAntes"))
                DiasAntes = Convert.ToInt16(row["DiasAntes"]);
            if (DataRecord.HasColumn(row, "HoraInicio"))
                HoraInicio = DbConvert.ToTimeSpan(row["HoraInicio"]);
            if (DataRecord.HasColumn(row, "HoraFin"))
                HoraFin = DbConvert.ToTimeSpan(row["HoraFin"]);
            if (DataRecord.HasColumn(row, "HoraInicioNoFacturable"))
                HoraInicioNoFacturable = DbConvert.ToTimeSpan(row["HoraInicioNoFacturable"]);
            if (DataRecord.HasColumn(row, "HoraCierreNoFacturable"))
                HoraCierreNoFacturable = DbConvert.ToTimeSpan(row["HoraCierreNoFacturable"]);
            if (DataRecord.HasColumn(row, "FlagNoValidados"))
                FlagNoValidados = Convert.ToBoolean(row["FlagNoValidados"]);
            if (DataRecord.HasColumn(row, "ProcesoRegular"))
                ProcesoRegular = Convert.ToInt16(Convert.IsDBNull(row["ProcesoRegular"]) ? -1 : row["ProcesoRegular"]);
            if (DataRecord.HasColumn(row, "ProcesoDA"))
                ProcesoDA = Convert.ToInt16(Convert.IsDBNull(row["ProcesoDA"]) ? -1 : row["ProcesoDA"]);
            if (DataRecord.HasColumn(row, "ProcesoDAPRD"))
                ProcesoDAPRD = Convert.ToInt16(Convert.IsDBNull(row["ProcesoDAPRD"]) ? -1 : row["ProcesoDAPRD"]);
            if (DataRecord.HasColumn(row, "HabilitarRestriccionHoraria"))
                HabilitarRestriccionHoraria = Convert.ToBoolean(row["HabilitarRestriccionHoraria"]);
        }
    }
}
