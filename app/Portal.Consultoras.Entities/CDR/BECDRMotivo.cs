using Portal.Consultoras.Common;
using System;
using System.Data;
using System.Runtime.Serialization;

namespace Portal.Consultoras.Entities.CDR
{
    public class BECDRMotivo
    {
        [DataMember]
        public string Tipo { get; set; }

        public BECDRMotivo()
        { }

        public BECDRMotivo(IDataRecord row)
        {
        }
    }
}
