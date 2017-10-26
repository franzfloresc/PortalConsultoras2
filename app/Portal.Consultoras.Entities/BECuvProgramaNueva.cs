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
            if (DataRecord.HasColumn(row, "Codigo") && row["Codigo"] != DBNull.Value)
                Codigo = Convert.ToString(row["Codigo"]);
        }
    }
}
