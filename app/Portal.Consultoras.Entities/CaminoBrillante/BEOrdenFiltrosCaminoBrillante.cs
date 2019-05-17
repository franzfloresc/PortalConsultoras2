using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations.Schema;
using System.Linq;
using System.Runtime.Serialization;
using System.Text;
using System.Threading.Tasks;

namespace Portal.Consultoras.Entities.CaminoBrillante
{
    [DataContract]
    public class BEOrdenFiltrosCaminoBrillante
    {
        [DataMember]
        [Column("Codigo")]
        public string Codigo { get; set; }        
        [DataMember]
        [Column("Descripcion")]
        public string Descripcion { get; set; }
        [DataMember]
        [Column("Tipo")]
        public string Tipo { get; set; }
    }
}
