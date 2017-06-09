﻿using Portal.Consultoras.Common;
using System;
using System.Data;
using System.Runtime.Serialization;

namespace Portal.Consultoras.Entities
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
        public DateTime Fecha { get; set; }

        [DataMember]
        public string TipoMovimiento { get; set; }

        [DataMember]
        public long ConsultoraId { get; set; }

        [DataMember]
        public int ClienteId { get; set; }

        public BEMovimiento(IDataReader row)
        {
            if (row.HasColumn("ClienteMovimientoId"))
                ClienteMovimientoId = row.GetValue<int>("ClienteMovimientoId");

            if (row.HasColumn("ConsultoraId"))
                ConsultoraId = row.GetValue<long>("ConsultoraId");

            if (row.HasColumn("ClienteId"))
                ClienteId = row.GetValue<int>("ClienteId");

            if (row.HasColumn("Monto"))
                Monto = row.GetValue<decimal>("Monto");

            if (row.HasColumn("TipoMovimiento"))
                TipoMovimiento = row.GetValue<string>("TipoMovimiento");

            if (row.HasColumn("Fecha"))
                Fecha = row.GetValue<DateTime>("Fecha");

            if (row.HasColumn("Descripcion"))
                Descripcion = row.GetValue<string>("Descripcion");
        }
    }
}
