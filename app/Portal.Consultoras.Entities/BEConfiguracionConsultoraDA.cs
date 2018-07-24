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
            ConfiguracionConsultoraDAID = row.ToInt32("ConfiguracionConsultoraDAID");
            ZonaID = row.ToInt32("ZonaID");
            ConsultoraID = row.ToInt32("ConsultoraID");
            CampaniaID = row.ToString("CampaniaID");
            TipoConfiguracion = row.ToByte("TipoConfiguracion");
            CodigoUsuario = row.ToString("CodigoUsuario");
        }


    }
}
