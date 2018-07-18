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
            Estado = row.ToInt32("Estado");
            Monto = row.ToDecimal("Monto");
            EstadoProceso = row.ToInt32("EstadoProceso");
        }
    }
}
