using Portal.Consultoras.Common;
using System;
using System.Data;
using System.Runtime.Serialization;

namespace Portal.Consultoras.Entities.ShowRoom
{
    [DataContract]
    public class BEShowRoomPersonalizacion
    {
        [DataMember]
        public int PersonalizacionId { get; set; }
        [DataMember]
        public string TipoAplicacion { get; set; }
        [DataMember]
        public string Atributo { get; set; }
        [DataMember]
        public string TextoAyuda { get; set; }
        [DataMember]
        public string TipoAtributo { get; set; }
        [DataMember]
        public string TipoPersonalizacion { get; set; }
        [DataMember]
        public int Orden { get; set; }
        [DataMember]
        public bool Estado { get; set; }

        public BEShowRoomPersonalizacion(IDataRecord row)
        {
            if (row.HasColumn("PersonalizacionId"))
                PersonalizacionId = Convert.ToInt32(row["PersonalizacionId"]);
            if (row.HasColumn("TipoAplicacion"))
                TipoAplicacion = Convert.ToString(row["TipoAplicacion"]);
            if (row.HasColumn("Atributo"))
                Atributo = Convert.ToString(row["Atributo"]);
            if (row.HasColumn("TextoAyuda"))
                TextoAyuda = Convert.ToString(row["TextoAyuda"]);
            if (row.HasColumn("TipoAtributo"))
                TipoAtributo = Convert.ToString(row["TipoAtributo"]);
            if (row.HasColumn("TipoPersonalizacion"))
                TipoPersonalizacion = Convert.ToString(row["TipoPersonalizacion"]);
            if (row.HasColumn("Orden"))
                Orden = Convert.ToInt32(row["Orden"]);
            if (row.HasColumn("Estado"))
                Estado = Convert.ToBoolean(row["Estado"]);
        }
    }
}
