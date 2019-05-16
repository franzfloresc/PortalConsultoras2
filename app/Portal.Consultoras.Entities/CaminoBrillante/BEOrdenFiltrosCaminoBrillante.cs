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
        [Column("DatosOrden")]
        public string Codigo { get; set; }        
        [DataMember]
        [Column("DatosFiltro")]
        public string Descripcion { get; set; }
        [DataMember]
        [Column("DatosFiltro")]
        public string Tipo { get; set; }
    }
}
