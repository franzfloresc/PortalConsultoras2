using Portal.Consultoras.Common;
using System.ComponentModel.DataAnnotations.Schema;
using System.Data;
using System.Runtime.Serialization;

namespace Portal.Consultoras.Entities
{
    [DataContract]
    public class BEContenidoAppDetaAct
    {
        [DataMember]
        [Column("IdContenidoAct")]
        public int IdContenidoAct { get; set; }

        [DataMember]
        [Column("Codigo")]
        public string Codigo { get; set; }

        [DataMember]
        [Column("Descripcion")]
        public string Descripcion { get; set; }

        [DataMember]
        [Column("Parent")]
        public int Parent { get; set; }

        [DataMember]
        [Column("Orden")]
        public int Orden { get; set; }

        [DataMember]
        [Column("Activo")]
        public bool Activo { get; set; }

        [DataMember]
        public int PaisID { get; set; }

        public BEContenidoAppDetaAct()
        { }

        public BEContenidoAppDetaAct(IDataRecord row)
        {
            IdContenidoAct = row.ToInt32("IdContenidoAct");
            Codigo = row.ToString("Codigo");
            Descripcion = row.ToString("Descripcion");
            Parent = row.ToInt32("Parent");
            Orden = row.ToInt32("Orden");
        }
    }
}

