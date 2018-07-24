using Portal.Consultoras.Common;
using System;
using System.Data;
using System.Runtime.Serialization;

namespace Portal.Consultoras.Entities
{
    [DataContract]
    public class BEValidaLoginSB2
    {
        [DataMember]
        public int Result { get; set; }

        [DataMember]
        public string Mensaje { get; set; }

        [DataMember]
        public string CodigoUsuario { get; set; }

        [DataMember]
        public int TipoUsuario { get; set; }

        public BEValidaLoginSB2()
        { }

        public BEValidaLoginSB2(IDataRecord row)
        {
            Result = row.ToInt16("Result");
            Mensaje = row.ToString("Mensaje");
            CodigoUsuario = row.ToString("CodigoUsuario");
            TipoUsuario = row.ToInt32("TipoUsuario");
        }
    }
}
