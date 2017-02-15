using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Runtime.Serialization;
using System.Data;
using Portal.Consultoras.Common;

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
        }
    }
}