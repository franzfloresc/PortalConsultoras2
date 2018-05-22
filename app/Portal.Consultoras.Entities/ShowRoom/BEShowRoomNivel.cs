using Portal.Consultoras.Common;
using System;
using System.Data;
using System.Runtime.Serialization;

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
            if (row.HasColumn("NivelId"))
                NivelId = Convert.ToInt32(row["NivelId"]);
            if (row.HasColumn("Codigo"))
                Codigo = Convert.ToString(row["Codigo"]);
            if (row.HasColumn("Descripcion"))
                Descripcion = Convert.ToString(row["Descripcion"]);
        }
    }
}
