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
            if (row.HasColumn("PersonalizacionNivelId") && row["PersonalizacionNivelId"] != DBNull.Value)
                PersonalizacionNivelId = Convert.ToInt32(row["PersonalizacionNivelId"]);
            if (row.HasColumn("EventoID") && row["EventoID"] != DBNull.Value)
                EventoID = Convert.ToInt32(row["EventoID"]);
            if (row.HasColumn("PersonalizacionId") && row["PersonalizacionId"] != DBNull.Value)
                PersonalizacionId = Convert.ToInt32(row["PersonalizacionId"]);
            if (row.HasColumn("NivelId") && row["NivelId"] != DBNull.Value)
                NivelId = Convert.ToInt32(row["NivelId"]);
            if (row.HasColumn("CategoriaId") && row["CategoriaId"] != DBNull.Value)
                CategoriaId = Convert.ToInt32(row["CategoriaId"]);
            if (row.HasColumn("Valor") && row["Valor"] != DBNull.Value)
                Valor = Convert.ToString(row["Valor"]);
        }
    }
}
