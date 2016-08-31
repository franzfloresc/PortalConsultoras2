namespace Portal.Consultoras.Entities
{
    using System;
    using System.Runtime.Serialization;

    [DataContract]
    public class BEAsistenciaCompartamos
    {
        [DataMember]
        public int AsistenciaID { set; get; }

        [DataMember]
        public int CampaniaID { get; set; }

        [DataMember]
        public int ConsultoraID { get; set; }

        [DataMember]
        public bool IndicadorAsistencia { get; set; }

        [DataMember]
        public string CodigoUsuarioCreacion { get; set; }

        [DataMember]
        public string CodigoUsuarioModificacion { get; set; }

        [DataMember]
        public DateTime? FechaCreacion { get; set; }

        [DataMember]
        public DateTime? FechaModificacion { get; set; }
    }
}
