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
    public class BEKitNueva
    {
        [DataMember]
        public int Estado { get; set; }
        [DataMember]
        public decimal Monto { get; set; }
        [DataMember]
        public int EstadoProceso { get; set; }

        public BEKitNueva()
        { }

        public BEKitNueva(IDataRecord row)
        {
            if (DataRecord.HasColumn(row, "Estado") && row["Estado"] != DBNull.Value)
                Estado = Convert.ToInt32(row["Estado"]);
            if (DataRecord.HasColumn(row, "Monto") && row["Monto"] != DBNull.Value)
                Monto = Convert.ToDecimal(row["Monto"]);
            if (DataRecord.HasColumn(row, "EstadoProceso") && row["EstadoProceso"] != DBNull.Value)
                EstadoProceso = Convert.ToInt32(row["EstadoProceso"]);
        }
    }
}
