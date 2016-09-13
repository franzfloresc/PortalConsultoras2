using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Runtime.Serialization;
using System.Text;
using System.Threading.Tasks;
using Portal.Consultoras.Common;
using OpenSource.Library.DataAccess;

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
