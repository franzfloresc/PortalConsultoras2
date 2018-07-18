using Portal.Consultoras.Common;
using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Runtime.Serialization;
using System.Text;
using System.Threading.Tasks;

namespace Portal.Consultoras.Entities
{
    [DataContract]
    public class BECategoria
    {
        [DataMember]
        public string CodigoCategoria { get; set; }
        [DataMember]
        public string DescripcionCategoria { get; set; }
        [DataMember]
        public string Eliminado { get; set; }

        public BECategoria()
        {
            CodigoCategoria = string.Empty;
            DescripcionCategoria = string.Empty;
            Eliminado = string.Empty;
        }

        public BECategoria(IDataRecord row)
        {
            CodigoCategoria = row.ToString("CodigoCategoria");
            DescripcionCategoria = row.ToString("DescripcionCategoria");
            Eliminado = row.ToString("Eliminado");
        }
    }
}
