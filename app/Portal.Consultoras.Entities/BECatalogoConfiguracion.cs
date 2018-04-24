using System.Runtime.Serialization;
using System.ComponentModel.DataAnnotations.Schema;

namespace Portal.Consultoras.Entities
{
    [DataContract]
    public class BECatalogoConfiguracion
    {
        [DataMember]
        [Column("CatalogoID")]
        public int CatalogoID { get; set; }
        [DataMember]
        [Column("MarcaID")]
        public int MarcaID { get; set; }
        [DataMember]
        [Column("Descripcion")]
        public string Descripcion { get; set; }
        [DataMember]
        [Column("Estado")]
        public int Estado { get; set; }
        [DataMember]
        [Column("CampaniaInicio")]
        public int CampaniaInicio { get; set; }
        [DataMember]
        [Column("CampaniaFin")]
        public int CampaniaFin { get; set; }
    }
}
