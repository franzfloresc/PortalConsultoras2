using Portal.Consultoras.Common;
using System;
using System.Data;
using System.Runtime.Serialization;

namespace Portal.Consultoras.Entities.CDR
{
    public class BECDROperacion
    {
        [DataMember]
        public int Dias { get; set; }
        [DataMember]
        public string Tipo { get; set; }

        public BECDROperacion()
        { }

        public BECDROperacion(IDataRecord row)
        {
        }
    }
}
