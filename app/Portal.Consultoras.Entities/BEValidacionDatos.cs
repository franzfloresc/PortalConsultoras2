using Portal.Consultoras.Common;
using System;
using System.ComponentModel.DataAnnotations.Schema;
using System.Data;
using System.Runtime.Serialization;

namespace Portal.Consultoras.Entities
{
    [DataContract]
    public class BEValidacionDatos
    {
        [DataMember]
        [Column("ValidacionID")]
        public long ValidacionId { get; set; }

        [DataMember]
        [Column("TipoEnvio")]
        public string TipoEnvio { get; set; }

        [DataMember]
        [Column("DatoAntiguo")]
        public string DatoAntiguo { get; set; }

        [DataMember]
        [Column("DatoNuevo")]
        public string DatoNuevo { get; set; }

        [DataMember]
        [Column("CodigoUsuario")]
        public string CodigoUsuario { get; set; }

        [DataMember]
        [Column("Estado")]
        public string Estado { get; set; }

        [DataMember]
        [Column("CampaniaActivacionEmail")]
        public int CampaniaActivacionEmail { get; set; }

        [DataMember]
        [Column("FechaCreacion")]
        public DateTime FechaCreacion { get; set; }

        [DataMember]
        [Column("UsuarioCreacion")]
        public string UsuarioCreacion { get; set; }

        [DataMember]
        [Column("FechaModificacion")]
        public DateTime FechaModificacion { get; set; }

        [DataMember]
        [Column("UsuarioModificacion")]
        public string UsuarioModificacion { get; set; }

        [DataMember]
        [Column("FechaInicio")]
        public string FechaInicio { get; set; }

        [DataMember]
        [Column("FechaFin")]
        public string FechaFin { get; set; }

        [DataMember]
        [Column("PaisID")]
        public int PaisID { get; set; }

        [DataMember]
        [Column("IpDispositivo")]
        public string IpDispositivo { get; set; }

        [DataMember]
        [Column("Dispositivo")]
        public bool Dispositivo { get; set; }


        [DataMember]
        [Column("DescripcionDispositivo")]
        public string DescripcionDispositivo { get; set; }


    }
}
