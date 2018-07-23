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
            PersonalizacionNivelId = row.ToInt32("PersonalizacionNivelId");
            EventoID = row.ToInt32("EventoID");
            PersonalizacionId = row.ToInt32("PersonalizacionId");
            NivelId = row.ToInt32("NivelId");
            CategoriaId = row.ToInt32("CategoriaId");
            Valor = row.ToString("Valor");
        }
    }
}
