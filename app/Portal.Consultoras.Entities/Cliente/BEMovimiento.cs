using Portal.Consultoras.Entities.Framework;
using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations.Schema;
using System.Runtime.Serialization;

namespace Portal.Consultoras.Entities.Cliente
{
    /// <summary>
    /// Entidad Movimiento
    /// </summary>
    [DataContract]
    public class BEMovimiento
    {
        /// <summary>
        /// No necesario para la insercion, es identity
        /// </summary>
        [Column("ClienteMovimientoId")]
        [DataMember]
        public int ClienteMovimientoId { get; set; }

        [Column("Monto")]
        [DataMember]
        public decimal Monto { get; set; }

        [Column("Descripcion")]
        [DataMember]
        public string Descripcion { get; set; }

        [Column("Nota")]
        [DataMember]
        public string Nota { get; set; }

        [Column("Fecha")]
        [DataMember]
        public DateTime Fecha { get; set; }

        [Column("TipoMovimiento")]
        [DataMember]
        public string TipoMovimiento { get; set; }

        [Column("ClienteId")]
        [DataMember]
        public short ClienteId { get; set; }

        [Column("ConsultoraId")]
        [DataMember]
        public long ConsultoraId { get; set; }

        [Column("CodigoCliente")]
        [DataMember]
        public long? CodigoCliente { get; set; }

        [Column("CampaniaCodigo")]
        [DataMember]
        public string CodigoCampania { get; set; }

        [DataMember]
        public IEnumerable<BEPedidoDDWebDetalle> Pedidos { get; set; }

        [DataMember]
        public string Code { get; set; }

        [DataMember]
        public string Message { get; set; }


        [DataMember]
        public StatusEnum StatusEnum { get; set; }

        public BEMovimiento()
        {
        }
    }
}
