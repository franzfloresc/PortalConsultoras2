using System.Runtime.Serialization;
using System.ComponentModel.DataAnnotations.Schema;

namespace Portal.Consultoras.Entities.BuscadorYFiltros
{
    [DataContract]
    public class BEFiltroBuscador
    {
        [DataMember]
        [Column("IdFiltroBuscador")]
        public int IdFiltroBuscador { get; set; }
        [DataMember]
        [Column("Codigo")]
        public string Codigo { get; set; }
        [DataMember]
        [Column("Nombre")]
        public string Nombre { get; set; }
        [DataMember]
        [Column("Descripcion")]
        public string Descripcion { get; set; }
        [DataMember]
        [Column("ValorMinimo")]
        public string ValorMinimo { get; set; }
        [DataMember]
        [Column("ValorMaximo")]
        public string ValorMaximo { get; set; }
        [DataMember]
        [Column("OrdenApp")]
        public int OrdenApp { get; set; }
        [DataMember]
        [Column("ColorTextoApp")]
        public string ColorTextoApp { get; set; }
        [DataMember]
        [Column("ColorFondoApp")]
        public string ColorFondoApp { get; set; }
    }
}
