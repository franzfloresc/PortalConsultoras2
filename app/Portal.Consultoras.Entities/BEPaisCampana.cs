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
            if (DataRecord.HasColumn(row, "PrefijoPais"))
                PrefijoPais = Convert.ToString(row["PrefijoPais"]);
            if (DataRecord.HasColumn(row, "AnioCampana"))
                AnoCampana = Convert.ToString(row["AnioCampana"]);
            if (DataRecord.HasColumn(row, "PrefijoPais"))
                PrefijoPais = Convert.ToString(row["PrefijoPais"]);
            if (DataRecord.HasColumn(row, "NroCampanias"))
                AnoCampana = Convert.ToString(row["NroCampanias"]);
        }
    }
}