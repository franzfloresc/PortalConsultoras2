using System;
using System.Runtime.Serialization;
using System.ComponentModel.DataAnnotations.Schema;

namespace Portal.Consultoras.Entities.Cupon
{
    [DataContract]
    public class BECuponConsultora
    {
        [DataMember]
        [Column("CuponConsultoraId")]
        public int CuponConsultoraId { get; set; }

        [DataMember]
        [Column("CodigoConsultora")]
        public string CodigoConsultora { get; set; }

        [DataMember]
        [Column("CampaniaId")]
        public int CampaniaId { get; set; }

        [DataMember]
        [Column("CuponId")]
        public int CuponId { get; set; }

        [DataMember]
        [Column("ValorAsociado")]
        public decimal ValorAsociado { get; set; }

        [DataMember]
        [Column("EstadoCupon")]
        public int EstadoCupon { get; set; }

        [DataMember]
        [Column("EnvioCorreo")]
        public bool EnvioCorreo { get; set; }

        [DataMember]
        [Column("FechaCreacion")]
        public DateTime FechaCreacion { get; set; }

        [DataMember]
        [Column("FechaModificacion")]
        public DateTime FechaModificacion { get; set; }

        [DataMember]
        [Column("UsuarioCreacion")]
        public string UsuarioCreacion { get; set; }

        [DataMember]
        [Column("UsuarioModificacion")]
        public string UsuarioModificacion { get; set; }

        [DataMember]
        [Column("TipoCupon")]
        public string TipoCupon { get; set; }

        [DataMember]
        public decimal MontoMaximoDescuento { get; set; }
    }
}
