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
    public class BEShowRoomPerfilOferta
    {
        [DataMember]
        public int PerfilOfertaShowRoomID { get; set; }

        [DataMember]
        public int EventoID { get; set; }

        [DataMember]
        public int PerfilID { get; set; }

        [DataMember]
        public int CampaniaID { get; set; }

        [DataMember]
        public string CUV { get; set; }

        [DataMember]
        public int Orden { get; set; }

        public BEShowRoomPerfilOferta(IDataRecord datarec)
        {
            if (DataRecord.HasColumn(datarec, "PerfilOfertaShowRoomID") && datarec["PerfilOfertaShowRoomID"] != DBNull.Value)
                PerfilOfertaShowRoomID = DbConvert.ToInt32(datarec["PerfilOfertaShowRoomID"]);
            if (DataRecord.HasColumn(datarec, "EventoID") && datarec["EventoID"] != DBNull.Value)
                EventoID = DbConvert.ToInt32(datarec["EventoID"]);
            if (DataRecord.HasColumn(datarec, "PerfilID") && datarec["PerfilID"] != DBNull.Value)
                PerfilID = DbConvert.ToInt32(datarec["PerfilID"]);
            if (DataRecord.HasColumn(datarec, "CampaniaID") && datarec["CampaniaID"] != DBNull.Value)
                CampaniaID = DbConvert.ToInt32(datarec["CampaniaID"]);
            if (DataRecord.HasColumn(datarec, "CUV") && datarec["CUV"] != DBNull.Value)
                CUV = DbConvert.ToString(datarec["CUV"]);
            if (DataRecord.HasColumn(datarec, "Orden") && datarec["Orden"] != DBNull.Value)
                Orden = DbConvert.ToInt32(datarec["Orden"]);
        }
    }
}
