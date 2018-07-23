using OpenSource.Library.DataAccess;
using Portal.Consultoras.Common;
using System;
using System.Data;
using System.Runtime.Serialization;

namespace Portal.Consultoras.Entities.ShowRoom
{
    [DataContract]
    public class BEShowRoomPerfil
    {
        [DataMember]
        public int PerfilID { get; set; }

        [DataMember]
        public string PerfilDescripcion { get; set; }

        [DataMember]
        public int EventoID { get; set; }

        public BEShowRoomPerfil(IDataRecord row)
        {
            PerfilID = row.ToInt32("PerfilID");
            PerfilDescripcion = row.ToString("PerfilDescripcion");
            EventoID = row.ToInt32("EventoID");
        }
    }
}
