
using OpenSource.Library.DataAccess;
using Portal.Consultoras.Common;
using System;
using System.Data;
using System.Runtime.Serialization;
namespace Portal.Consultoras.Entities
{
    [DataContract]
    public class BEConfiguracionProgramaNuevas
    {
        [DataMember]
        public string CodigoPrograma { get; set; }
        [DataMember]
        public string CampaniaInicio { get; set; }
        [DataMember]
        public string CampaniaFin { get; set; }
        [DataMember]
        public string IndExigVent { get; set; }
        [DataMember]
        public string IndProgObli { get; set; }
        [DataMember]
        public string CuponKit { get; set; }
        [DataMember]
        public string CUVKit { get; set; }
        [DataMember]
        public string CodigoZona { get; set; }
        [DataMember]
        public string CodigoRegion { get; set; }
        [DataMember]
        public string CodigoNivel { get; set; }

        public BEConfiguracionProgramaNuevas() { }

        public BEConfiguracionProgramaNuevas(IDataRecord datarec)
        {
            if (DataRecord.HasColumn(datarec, "CodigoPrograma") && datarec["CodigoPrograma"] != DBNull.Value)
                CodigoPrograma = DbConvert.ToString(datarec["CodigoPrograma"]);
            if (DataRecord.HasColumn(datarec, "CampaniaInicio") && datarec["CampaniaInicio"] != DBNull.Value)
                CampaniaInicio = DbConvert.ToString(datarec["CampaniaInicio"]);
            if (DataRecord.HasColumn(datarec, "CampaniaFin") && datarec["CampaniaFin"] != DBNull.Value)
                CampaniaFin = DbConvert.ToString(datarec["CampaniaFin"]);
            if (DataRecord.HasColumn(datarec, "IndExigVent") && datarec["IndExigVent"] != DBNull.Value)
                IndExigVent = DbConvert.ToString(datarec["IndExigVent"]);
            if (DataRecord.HasColumn(datarec, "IndProgObli") && datarec["IndProgObli"] != DBNull.Value)
                IndProgObli = DbConvert.ToString(datarec["IndProgObli"]);
            if (DataRecord.HasColumn(datarec, "CuponKit") && datarec["CuponKit"] != DBNull.Value)
                CuponKit = DbConvert.ToString(datarec["CuponKit"]);
            if (DataRecord.HasColumn(datarec, "CUVKit") && datarec["CUVKit"] != DBNull.Value)
                CUVKit = DbConvert.ToString(datarec["CUVKit"]);
            if (DataRecord.HasColumn(datarec, "CodigoZona") && datarec["CodigoZona"] != DBNull.Value)
                CodigoZona = DbConvert.ToString(datarec["CodigoZona"]);
            if (DataRecord.HasColumn(datarec, "CodigoRegion") && datarec["CodigoRegion"] != DBNull.Value)
                CodigoRegion = DbConvert.ToString(datarec["CodigoRegion"]);
        }
    }
}
