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
            if (row.HasColumn("Result"))
                Result = Convert.ToInt16(row["Result"]);
            if (row.HasColumn("Mensaje"))
                Mensaje = Convert.ToString(row["Mensaje"]);
            if (row.HasColumn("CodigoUsuario"))
                CodigoUsuario = Convert.ToString(row["CodigoUsuario"]);

            if (row.HasColumn("TipoUsuario"))
                TipoUsuario = Convert.ToInt32(row["TipoUsuario"]);
        }
    }
}