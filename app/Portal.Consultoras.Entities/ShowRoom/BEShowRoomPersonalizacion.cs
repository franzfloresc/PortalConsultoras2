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
            if (row.HasColumn("PersonalizacionId") && row["PersonalizacionId"] != DBNull.Value)
                PersonalizacionId = Convert.ToInt32(row["PersonalizacionId"]);
            if (row.HasColumn("TipoAplicacion") && row["TipoAplicacion"] != DBNull.Value)
                TipoAplicacion = Convert.ToString(row["TipoAplicacion"]);
            if (row.HasColumn("Atributo") && row["Atributo"] != DBNull.Value)
                Atributo = Convert.ToString(row["Atributo"]);
            if (row.HasColumn("TextoAyuda") && row["TextoAyuda"] != DBNull.Value)
                TextoAyuda = Convert.ToString(row["TextoAyuda"]);
            if (row.HasColumn("TipoAtributo") && row["TipoAtributo"] != DBNull.Value)
                TipoAtributo = Convert.ToString(row["TipoAtributo"]);
            if (row.HasColumn("TipoPersonalizacion") && row["TipoPersonalizacion"] != DBNull.Value)
                TipoPersonalizacion = Convert.ToString(row["TipoPersonalizacion"]);
            if (row.HasColumn("Orden") && row["Orden"] != DBNull.Value)
                Orden = Convert.ToInt32(row["Orden"]);
            if (row.HasColumn("Estado") && row["Estado"] != DBNull.Value)
                Estado = Convert.ToBoolean(row["Estado"]);
        }
    }
}
