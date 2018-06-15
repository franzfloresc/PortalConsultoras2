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
            this.CodigoCategoria = string.Empty;
            this.DescripcionCategoria = string.Empty;
            this.Eliminado = string.Empty;
        }

        public BECategoria(IDataRecord row)
        {
            if (DataRecord.HasColumn(row, "CodigoCategoria"))
                CodigoCategoria = Convert.ToString(row["CodigoCategoria"]);
            if (DataRecord.HasColumn(row, "DescripcionCategoria"))
                DescripcionCategoria = Convert.ToString(row["DescripcionCategoria"]);
            if (DataRecord.HasColumn(row, "Eliminado"))
                Eliminado = Convert.ToString(row["Eliminado"]);
        }
    }
}
