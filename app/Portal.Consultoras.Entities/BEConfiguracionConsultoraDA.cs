using Portal.Consultoras.Common;
using System;
using System.Data;
using System.Runtime.Serialization;

namespace Portal.Consultoras.Entities
{
    [DataContract]
    public class BEConfiguracionConsultoraDA
    {

        [DataMember]
        public int ConfiguracionConsultoraDAID { get; set; }
        [DataMember]
        public int ZonaID { get; set; }
        [DataMember]
        public int ConsultoraID { get; set; }
        [DataMember]
        public string CampaniaID { get; set; }
        [DataMember]
        public byte TipoConfiguracion { get; set; }
        [DataMember]
        public string CodigoUsuario { set; get; }

        public BEConfiguracionConsultoraDA(IDataRecord row)
        {
            if (DataRecord.HasColumn(row, "ConfiguracionConsultoraDAID"))
                ConfiguracionConsultoraDAID = Convert.ToInt32(row["ConfiguracionConsultoraDAID"]);
            if (DataRecord.HasColumn(row, "ZonaID"))
                ZonaID = Convert.ToInt32(row["ZonaID"]);
            if (DataRecord.HasColumn(row, "ConsultoraID"))
                ConsultoraID = Convert.ToInt32(row["ConsultoraID"]);
            if (DataRecord.HasColumn(row, "CampaniaID"))
                CampaniaID = Convert.ToString(row["CampaniaID"]);
            if (DataRecord.HasColumn(row, "TipoConfiguracion"))
                TipoConfiguracion = Convert.ToByte(row["TipoConfiguracion"]);
            if (DataRecord.HasColumn(row, "CodigoUsuario"))
                CodigoUsuario = Convert.ToString(row["CodigoUsuario"]);
        }


    }
}
