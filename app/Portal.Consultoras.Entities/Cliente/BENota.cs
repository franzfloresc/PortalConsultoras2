using Portal.Consultoras.Common;
using System;
using System.ComponentModel.DataAnnotations.Schema;
using System.Data;
using System.Runtime.Serialization;
using Portal.Consultoras.Entities.Framework;

namespace Portal.Consultoras.Entities.Cliente
{
    [DataContract]
    public class BENota
    {
        /// <summary>
        /// Autogenerado - Identity
        /// </summary>
        [Column("ClienteNotaId")]
        [DataMember]
        public long ClienteNotaId { get; set; }

        [Column("ConsultoraId")]
        [DataMember]
        public long ConsultoraId { get; set; }

        [Column("ClienteId")]
        [DataMember]
        public short ClienteId { get; set; }

        [Column("Descripcion")]
        [DataMember]
        public string Descripcion { get; set; }

        [Column("FechaRecordatorio")]
        [DataMember]
        public DateTime? FechaRecordatorio { get; set; }

        /// <summary>
        /// Campo auditoria
        /// </summary>
        [Column("Fecha")]
        [DataMember]
        public DateTime? Fecha { get; set; }

        [DataMember]
        public string Code { get; set; }

        [DataMember]
        public string Message { get; set; }

        [DataMember]
        public StatusEnum StatusEnum { get; set; }

        public BENota()
        { }
    }
}
