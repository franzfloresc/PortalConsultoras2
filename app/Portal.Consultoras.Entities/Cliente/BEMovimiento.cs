using Portal.Consultoras.Common;
using System;
using System.Data;
using System.Runtime.Serialization;

namespace Portal.Consultoras.Entities.Cliente
{
    [DataContract]
    public class BEMovimiento
    {
        /// <summary>
        /// No necesario para la insercion, es identity
        /// </summary>
        [DataMember]
        public int ClienteMovimientoId { get; set; }

        [DataMember]
        public decimal Monto { get; set; }

        [DataMember]
        public string Descripcion { get; set; }

        [DataMember]
        public string Nota { get; set; }

        [DataMember]
        public DateTime Fecha { get; set; }

        [DataMember]
        public string TipoMovimiento { get; set; }

        [DataMember]
        public short ClienteId { get; set; }

        [DataMember]
        public long ConsultoraId { get; set; }

        [DataMember]
        public long? CodigoCliente { get; set; }

        [DataMember]
        public string CodigoCampania { get; set; }

        public BEMovimiento(IDataReader row)
        {
            if (row.HasColumn("ClienteMovimientoId"))
                ClienteMovimientoId = row.GetValue<int>("ClienteMovimientoId");

            if (row.HasColumn("ClienteId"))
                ClienteId = row.GetValue<short>("ClienteId");

            if (row.HasColumn("ConsultoraId"))
                ConsultoraId = row.GetValue<long>("ConsultoraId");

            if (row.HasColumn("CodigoCliente"))
                CodigoCliente = row.GetValue<long>("CodigoCliente");

            if (row.HasColumn("Monto"))
                Monto = row.GetValue<decimal>("Monto");

            if (row.HasColumn("TipoMovimiento"))
                TipoMovimiento = row.GetValue<string>("TipoMovimiento");

            if (row.HasColumn("Fecha"))
                Fecha = row.GetValue<DateTime>("Fecha");

            if (row.HasColumn("Descripcion"))
                Descripcion = row.GetValue<string>("Descripcion");

            if (row.HasColumn("Nota"))
                Nota = row.GetValue<string>("Nota");
            
            if (row.HasColumn("CampaniaCodigo"))
                CodigoCampania = row.GetValue<string>("CampaniaCodigo");
        }
    }
}
