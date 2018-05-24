using Portal.Consultoras.Common;
using System;
using System.Data;
using System.Runtime.Serialization;

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
            if (DataRecord.HasColumn(row, "Estado"))
                Estado = Convert.ToInt32(row["Estado"]);
            if (DataRecord.HasColumn(row, "Monto"))
                Monto = Convert.ToDecimal(row["Monto"]);
            if (DataRecord.HasColumn(row, "EstadoProceso"))
                EstadoProceso = Convert.ToInt32(row["EstadoProceso"]);
        }
    }
}
