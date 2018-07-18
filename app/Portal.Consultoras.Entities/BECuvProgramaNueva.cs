using Portal.Consultoras.Common;
using System;
using System.Data;
using System.Runtime.Serialization;

namespace Portal.Consultoras.Entities
{
    [DataContract]
    public class BECuvProgramaNueva
    {
        [DataMember]
        public string Codigo { get; set; }

        public BECuvProgramaNueva(IDataRecord row)
        {
            Codigo = row.ToString("Codigo");
        }
    }
}
