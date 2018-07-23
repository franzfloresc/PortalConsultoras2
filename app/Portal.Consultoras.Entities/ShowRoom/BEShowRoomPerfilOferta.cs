using OpenSource.Library.DataAccess;
using Portal.Consultoras.Common;
using System;
using System.Data;
using System.Runtime.Serialization;

namespace Portal.Consultoras.Entities.ShowRoom
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

        [DataMember]
        public bool EsSubCampania { get; set; }

        public BEShowRoomPerfilOferta(IDataRecord row)
        {
            PerfilOfertaShowRoomID = row.ToInt32("PerfilOfertaShowRoomID");
            EventoID = row.ToInt32("EventoID");
            PerfilID = row.ToInt32("PerfilID");
            CampaniaID = row.ToInt32("CampaniaID");
            CUV = row.ToString("CUV");
            Orden = row.ToInt32("Orden");
            EsSubCampania = row.ToBoolean("EsSubCampania");
        }
    }
}
