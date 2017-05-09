using System;
using System.Data;
using System.Runtime.Serialization;
using Portal.Consultoras.Common;

namespace Portal.Consultoras.Entities
{
    [DataContract]
    public class BEConsultoraCliente
    {
        [DataMember]
        public long ConsultoraClienteID { get; set; }

        [DataMember]
        public long ConsultoraID { get; set; }

        [DataMember]
        public long ClienteID { get; set; }

        public BEConsultoraCliente(IDataRecord row)
        {
            if (DataRecord.HasColumn(row, "ConsultoraClienteID"))
                ConsultoraClienteID = Convert.ToInt64(row["ConsultoraClienteID"]);

            if (DataRecord.HasColumn(row, "ConsultoraID"))
                ConsultoraID = Convert.ToInt64(row["ConsultoraID"]);

            if (DataRecord.HasColumn(row, "ClienteID"))
                ClienteID = Convert.ToInt64(row["ClienteID"]);
        }
    }
}
