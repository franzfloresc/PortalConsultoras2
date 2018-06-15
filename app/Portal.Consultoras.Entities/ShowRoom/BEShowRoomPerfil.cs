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

        public BEShowRoomPerfil(IDataRecord datarec)
        {
            if (DataRecord.HasColumn(datarec, "PerfilID"))
                PerfilID = Convert.ToInt32(datarec["PerfilID"]);
            if (DataRecord.HasColumn(datarec, "PerfilDescripcion"))
                PerfilDescripcion = Convert.ToString(datarec["PerfilDescripcion"]);
            if (DataRecord.HasColumn(datarec, "EventoID"))
                EventoID = Convert.ToInt32(datarec["EventoID"]);
        }
    }
}
