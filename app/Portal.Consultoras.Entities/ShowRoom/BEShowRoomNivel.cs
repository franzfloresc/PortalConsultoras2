using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Runtime.Serialization;
using System.Text;
using System.Threading.Tasks;
using Portal.Consultoras.Common;

namespace Portal.Consultoras.Entities.ShowRoom
{
    [DataContract]
    public class BEShowRoomNivel
    {
        [DataMember]
        public int NivelId { get; set; }

        [DataMember]
        public string Codigo { get; set; }

        [DataMember]
        public string Descripcion { get; set; }

        public BEShowRoomNivel(IDataRecord row)
        {
            if (row.HasColumn("NivelId") && row["NivelId"] != DBNull.Value)
                NivelId = Convert.ToInt32(row["NivelId"]);
            if (row.HasColumn("Codigo") && row["Codigo"] != DBNull.Value)
                Codigo = Convert.ToString(row["Codigo"]);
            if (row.HasColumn("Descripcion") && row["Descripcion"] != DBNull.Value)
                Descripcion = Convert.ToString(row["Descripcion"]);
        }
    }
}
