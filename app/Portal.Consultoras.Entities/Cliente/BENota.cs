using Portal.Consultoras.Common;
using System;
using System.Data;
using System.Runtime.Serialization;

namespace Portal.Consultoras.Entities.Cliente
{
    [DataContract]
    public class BENota
    {
        /// <summary>
        /// Autogenerado - Identity
        /// </summary>
        [DataMember]
        public long ClienteNotaId { get; set; }

        [DataMember]
        public long ConsultoraId { get; set; }

        [DataMember]
        public short ClienteId { get; set; }

        [DataMember]
        public string Descripcion { get; set; }

        [DataMember]
        public DateTime? Fecha { get; set; }

        public BENota()
        { }

        public BENota(IDataRecord row)
        {
            if (row.HasColumn("ClienteNotaId"))
                ClienteNotaId = row.GetValue<long>("ClienteNotaId");

            if (row.HasColumn("ConsultoraId"))
                ConsultoraId = row.GetValue<long>("ConsultoraId");

            if (row.HasColumn("ClienteId"))
                ClienteId = row.GetValue<short>("ClienteId");

            if (row.HasColumn("Descripcion"))
                Descripcion = row.GetValue<string>("Descripcion");

            if (row.HasColumn("Fecha"))
                Fecha = row.GetValue<DateTime>("Fecha");
        }
    }
}
