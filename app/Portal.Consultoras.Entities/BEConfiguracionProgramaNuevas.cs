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
            if (DataRecord.HasColumn(datarec, "CodigoPrograma"))
                CodigoPrograma = Convert.ToString(datarec["CodigoPrograma"]);
            if (DataRecord.HasColumn(datarec, "CampaniaInicio"))
                CampaniaInicio = Convert.ToString(datarec["CampaniaInicio"]);
            if (DataRecord.HasColumn(datarec, "CampaniaFin"))
                CampaniaFin = Convert.ToString(datarec["CampaniaFin"]);
            if (DataRecord.HasColumn(datarec, "IndExigVent"))
                IndExigVent = Convert.ToString(datarec["IndExigVent"]);
            if (DataRecord.HasColumn(datarec, "IndProgObli"))
                IndProgObli = Convert.ToString(datarec["IndProgObli"]);
            if (DataRecord.HasColumn(datarec, "CuponKit"))
                CuponKit = Convert.ToString(datarec["CuponKit"]);
            if (DataRecord.HasColumn(datarec, "CUVKit"))
                CUVKit = Convert.ToString(datarec["CUVKit"]);
            if (DataRecord.HasColumn(datarec, "CodigoZona"))
                CodigoZona = Convert.ToString(datarec["CodigoZona"]);
            if (DataRecord.HasColumn(datarec, "CodigoRegion"))
                CodigoRegion = Convert.ToString(datarec["CodigoRegion"]);
        }
    }
}
