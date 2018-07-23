using Portal.Consultoras.Common;
using System;
using System.Data;
using System.Runtime.Serialization;

namespace Portal.Consultoras.Entities.CDR
{
    public class BECDRParametria
    {
        [DataMember]
        public string CodigoParametria { get; set; }
        [DataMember]
        public string DescripcionParametria { get; set; }
        [DataMember]
        public string ValorParametria { get; set; }

        public BECDRParametria()
        { }

        public BECDRParametria(IDataRecord row)
        {
            CodigoParametria = row.ToString("CodigoParametria");
            DescripcionParametria = row.ToString("DescripcionParametria");
            ValorParametria = row.ToString("ValorParametria");
        }
    }
}
