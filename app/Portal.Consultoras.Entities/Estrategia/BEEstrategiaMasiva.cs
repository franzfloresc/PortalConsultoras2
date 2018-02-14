namespace Portal.Consultoras.Entities.Estrategia
{
    using System.ComponentModel.DataAnnotations.Schema;
    using System.Runtime.Serialization;
    using System.Xml.Linq;

    public class BEEstrategiaMasiva : BaseEntidad
    {
        [DataMember]
        public XElement EstrategiaXML { get; set; }
        [DataMember]
        [Column("TipoEstrategiaID")]
        public int TipoEstrategiaID { get; set; }
        [DataMember]
        [Column("CampaniaID")]
        public int CampaniaID { get; set; }
        [DataMember]
        public string UsuarioCreacion { get; set; }
        [DataMember]
        public string UsuarioModificacion { get; set; }
    }
}
