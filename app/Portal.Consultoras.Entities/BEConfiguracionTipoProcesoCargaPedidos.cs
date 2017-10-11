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
            ZonaID = Convert.ToInt32(row["ZonaID"]);
            CodigoZona = Convert.ToString(row["CodigoZona"]);
            DiasParametroCarga = Convert.ToInt16(row["DiasParametroCarga"]);
        }
    }
}
