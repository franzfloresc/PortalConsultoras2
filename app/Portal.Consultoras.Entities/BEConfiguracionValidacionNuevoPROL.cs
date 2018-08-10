using Portal.Consultoras.Common;
using System;
using System.Data;
using System.Runtime.Serialization;

namespace Portal.Consultoras.Entities
{
    [DataContract]
    public class BEConfiguracionValidacionNuevoPROL
    {
        [DataMember]
        public int ZonaID { set; get; }
        [DataMember]
        public string CodigoZona { set; get; }
        [DataMember]
        public string Usuario { set; get; }
        [DataMember]
        public int DiasParametroCarga { set; get; }

        public BEConfiguracionValidacionNuevoPROL()
        { }

        public BEConfiguracionValidacionNuevoPROL(IDataRecord row)
        {
            ZonaID = row.ToInt32("ZonaID");
            CodigoZona = row.ToString("CodigoZona");
        }

    }
}
