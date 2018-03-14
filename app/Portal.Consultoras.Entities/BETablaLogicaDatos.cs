using System.Runtime.Serialization;
using System.ComponentModel.DataAnnotations.Schema;

namespace Portal.Consultoras.Entities
{
    [DataContract]
    public class BETablaLogicaDatos
    {
        [DataMember]
        [Column("TablaLogicaDatosID")]
        public short TablaLogicaDatosID { get; set; }
        [DataMember]
        [Column("TablaLogicaID")]
        public short TablaLogicaID { get; set; }
        [DataMember]
        [Column("Codigo")]
        public string Codigo { get; set; }
        [DataMember]
        [Column("Descripcion")]
        public string Descripcion { get; set; }

        [DataMember]
        [Column("Valor")]
        public string Valor { get; set; }
    }
}
