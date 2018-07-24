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
            NivelId = row.ToInt32("NivelId");
            Codigo = row.ToString("Codigo");
            Descripcion = row.ToString("Descripcion");
        }
    }
}
