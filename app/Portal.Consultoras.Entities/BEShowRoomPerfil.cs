using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Runtime.Serialization;
using System.Text;
using System.Threading.Tasks;
using OpenSource.Library.DataAccess;
using Portal.Consultoras.Common;

namespace Portal.Consultoras.Entities
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
            if (DataRecord.HasColumn(datarec, "PerfilID") && datarec["PerfilID"] != DBNull.Value)
                PerfilID = DbConvert.ToInt32(datarec["PerfilID"]);
            if (DataRecord.HasColumn(datarec, "PerfilDescripcion") && datarec["PerfilDescripcion"] != DBNull.Value)
                PerfilDescripcion = DbConvert.ToString(datarec["PerfilDescripcion"]);
            if (DataRecord.HasColumn(datarec, "EventoID") && datarec["EventoID"] != DBNull.Value)
                EventoID = DbConvert.ToInt32(datarec["EventoID"]);
        }
    }
}
