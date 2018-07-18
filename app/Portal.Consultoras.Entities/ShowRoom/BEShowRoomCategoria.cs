using Portal.Consultoras.Common;
using System;
using System.Data;
using System.Runtime.Serialization;

namespace Portal.Consultoras.Entities.ShowRoom
{
    [DataContract]
    public class BEShowRoomCategoria
    {
        [DataMember]
        public int CategoriaId { get; set; }
        [DataMember]
        public int EventoID { get; set; }
        [DataMember]
        public string Codigo { get; set; }
        [DataMember]
        public string Descripcion { get; set; }

        public BEShowRoomCategoria(IDataRecord row)
        {
            CategoriaId = row.ToInt32("CategoriaId");
            EventoID = row.ToInt32("EventoID");
            Codigo = row.ToString("Codigo");
            Descripcion = row.ToString("Descripcion");
        }
    }
}
