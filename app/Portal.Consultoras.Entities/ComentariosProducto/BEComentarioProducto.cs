using System;
using System.Collections.Generic;
using System.Linq;
using System.Runtime.Serialization;
using System.Text;
using System.Threading.Tasks;

namespace Portal.Consultoras.Entities.ComentarioProducto
{
    [DataContract]
    public class BEComentarioProducto
    {
        public int ComentarioProductoId { get; set; }
        public DateTime Fecha { get; set; }
    }
}
