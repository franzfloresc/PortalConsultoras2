using Portal.Consultoras.Common;
using System;
using System.Data;
using System.Runtime.Serialization;

namespace Portal.Consultoras.Entities
{
    [DataContract]
    public class BEPaisCampana
    {
        [DataMember]
        public string PrefijoPais { get; set; }
        [DataMember]
        public string AnoCampana { get; set; }
        [DataMember]
        public int NroCampanias { get; set; }

        public BEPaisCampana(IDataRecord row)
        {
            PrefijoPais = row.ToString("PrefijoPais");
            AnoCampana = row.ToString("AnioCampana");
            NroCampanias = row.ToInt32("NroCampanias");
        }
    }
}
