using Portal.Consultoras.Common;
using System;
using System.Data;
using System.Runtime.Serialization;

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
            if (row.HasColumn("TipoOfertaID"))
                TipoOfertaID = Convert.ToInt32(row["TipoOfertaID"]);
            if (row.HasColumn("Codigo"))
                Codigo = Convert.ToString(row["Codigo"]);
            if (row.HasColumn("Descripcion"))
                Descripcion = Convert.ToString(row["Descripcion"]);
            if (row.HasColumn("Activo"))
                Activo = Convert.ToBoolean(row["Activo"]);
            if (row.HasColumn("FechaCreacion"))
                FechaCreacion = Convert.ToDateTime(row["FechaCreacion"]);
            if (row.HasColumn("UsuarioCreacion"))
                UsuarioCreacion = Convert.ToString(row["UsuarioCreacion"]);
            if (row.HasColumn("FechaModificacion"))
                FechaModificacion = Convert.ToDateTime(row["FechaModificacion"]);
            if (row.HasColumn("UsuarioModificacion"))
                UsuarioModificacion = Convert.ToString(row["UsuarioModificacion"]);
        }
    }
}
