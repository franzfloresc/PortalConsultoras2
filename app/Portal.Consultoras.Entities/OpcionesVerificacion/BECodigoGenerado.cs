using System;
using System.ComponentModel.DataAnnotations.Schema;
using System.Runtime.Serialization;

namespace Portal.Consultoras.Entities.OpcionesVerificacion
{
    [DataContract]
    public class BECodigoGenerado
    {
        [DataMember]
        [Column("CodigoGeneradoID")]
        public int CodigoGeneradoID { get; set; }
        [DataMember]
        [Column("OrigenID")]
        public int OrigenID { get; set; }
        [DataMember]
        [Column("CodigoUsuario")]
        public string CodigoUsuario { get; set; }
        [DataMember]
        [Column("OrigenDescripcion")]
        public string OrigenDescripcion { get; set; }
        [DataMember]
        [Column("TipoEnvio")]
        public string TipoEnvio { get; set; }
        [DataMember]
        [Column("CodigoGenerado")]
        public string CodigoGenerado { get; set; }
        [DataMember]
        [Column("OpcionDesabilitado")]
        public bool OpcionDesabilitado { get; set; }
        [DataMember]
        [Column("FechaRegistro")]
        public DateTime FechaRegistro { get; set; }
        [DataMember]
        [Column("FechaActual")]
        public DateTime FechaActual { get; set; }
        [DataMember]
        [Column("CantidadEnvios")]
        public int CantidadEnvios { get; set; }
    }
}
