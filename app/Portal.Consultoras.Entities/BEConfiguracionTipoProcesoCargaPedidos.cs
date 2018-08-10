using Portal.Consultoras.Common;
using System;
using System.Data;
using System.Runtime.Serialization;

namespace Portal.Consultoras.Entities
{
    [DataContract]
    public class BEConfiguracionTipoProcesoCargaPedidos
    {
        [DataMember]
        public int ZonaID { set; get; }
        [DataMember]
        public string CodigoZona { set; get; }
        [DataMember]
        public int DiasParametroCarga { set; get; }
        [DataMember]
        public string Usuario { set; get; }

        public BEConfiguracionTipoProcesoCargaPedidos()
        { }

        public BEConfiguracionTipoProcesoCargaPedidos(IDataRecord row)
        {
            ZonaID = row.ToInt32("ZonaID");
            CodigoZona = row.ToString("CodigoZona");
            DiasParametroCarga = row.ToInt16("DiasParametroCarga");
        }
    }
}
