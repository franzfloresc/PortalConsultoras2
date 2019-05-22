using Portal.Consultoras.Common;
using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations.Schema;
using System.Data;
using System.Linq;
using System.Runtime.Serialization;
using System.Text;
using System.Threading.Tasks;

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
