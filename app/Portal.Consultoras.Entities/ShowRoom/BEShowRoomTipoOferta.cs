using Portal.Consultoras.Common;
using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Runtime.Serialization;
using System.Text;
using System.Threading.Tasks;

namespace Portal.Consultoras.Entities.ShowRoom
{
    [DataContract]
    public class BEShowRoomTipoOferta
    {
        [DataMember]
        public int TipoOfertaID { get; set; }

        [DataMember]
        public string Codigo { get; set; }

        [DataMember]
        public string Descripcion { get; set; }

        [DataMember]
        public bool Activo { get; set; }

        [DataMember]
        public DateTime FechaCreacion { get; set; }

        [DataMember]
        public string UsuarioCreacion { get; set; }

        [DataMember]
        public DateTime FechaModificacion { get; set; }

        [DataMember]
        public string UsuarioModificacion { get; set; }

        public BEShowRoomTipoOferta(IDataRecord row)
        {
            if (row.HasColumn("TipoOfertaID") && row["TipoOfertaID"] != DBNull.Value)
                TipoOfertaID = Convert.ToInt32(row["TipoOfertaID"]);
            if (row.HasColumn("Codigo") && row["Codigo"] != DBNull.Value)
                Codigo = Convert.ToString(row["Codigo"]);
            if (row.HasColumn("Descripcion") && row["Descripcion"] != DBNull.Value)
                Descripcion = Convert.ToString(row["Descripcion"]);
            if (row.HasColumn("Activo") && row["Activo"] != DBNull.Value)
                Activo = Convert.ToBoolean(row["Activo"]);
            if (row.HasColumn("FechaCreacion") && row["FechaCreacion"] != DBNull.Value)
                FechaCreacion = Convert.ToDateTime(row["FechaCreacion"]);
            if (row.HasColumn("UsuarioCreacion") && row["UsuarioCreacion"] != DBNull.Value)
                UsuarioCreacion = Convert.ToString(row["UsuarioCreacion"]);
            if (row.HasColumn("FechaModificacion") && row["FechaModificacion"] != DBNull.Value)
                FechaModificacion = Convert.ToDateTime(row["FechaModificacion"]);
            if (row.HasColumn("UsuarioModificacion") && row["UsuarioModificacion"] != DBNull.Value)
                UsuarioModificacion = Convert.ToString(row["UsuarioModificacion"]);
        }
    }
}
