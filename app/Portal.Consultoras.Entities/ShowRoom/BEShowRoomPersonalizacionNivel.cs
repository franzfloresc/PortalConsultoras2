using Portal.Consultoras.Common;
using System;
using System.Data;
using System.Runtime.Serialization;

namespace Portal.Consultoras.Entities.ShowRoom
{
    [DataContract]
    public class BEShowRoomPersonalizacionNivel
    {
        [DataMember]
        public int PersonalizacionNivelId { get; set; }
        [DataMember]
        public int EventoID { get; set; }
        [DataMember]
        public int PersonalizacionId { get; set; }
        [DataMember]
        public int NivelId { get; set; }
        [DataMember]
        public int CategoriaId { get; set; }
        [DataMember]
        public string Valor { get; set; }

        public BEShowRoomPersonalizacionNivel(IDataRecord row)
        {
            if (row.HasColumn("PersonalizacionNivelId"))
                PersonalizacionNivelId = Convert.ToInt32(row["PersonalizacionNivelId"]);
            if (row.HasColumn("EventoID"))
                EventoID = Convert.ToInt32(row["EventoID"]);
            if (row.HasColumn("PersonalizacionId"))
                PersonalizacionId = Convert.ToInt32(row["PersonalizacionId"]);
            if (row.HasColumn("NivelId"))
                NivelId = Convert.ToInt32(row["NivelId"]);
            if (row.HasColumn("CategoriaId"))
                CategoriaId = Convert.ToInt32(row["CategoriaId"]);
            if (row.HasColumn("Valor"))
                Valor = Convert.ToString(row["Valor"]);
        }
    }
}
