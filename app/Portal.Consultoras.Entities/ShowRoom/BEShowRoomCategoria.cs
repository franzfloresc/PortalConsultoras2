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
            if (row.HasColumn("CategoriaId"))
                CategoriaId = Convert.ToInt32(row["CategoriaId"]);
            if (row.HasColumn("EventoID"))
                EventoID = Convert.ToInt32(row["EventoID"]);
            if (row.HasColumn("Codigo"))
                Codigo = Convert.ToString(row["Codigo"]);
            if (row.HasColumn("Descripcion"))
                Descripcion = Convert.ToString(row["Descripcion"]);
        }
    }
}
