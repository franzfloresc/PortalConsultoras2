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
            TipoOfertaID = row.ToInt32("TipoOfertaID");
            Codigo = row.ToString("Codigo");
            Descripcion = row.ToString("Descripcion");
            Activo = row.ToBoolean("Activo");
            FechaCreacion = row.ToDateTime("FechaCreacion");
            UsuarioCreacion = row.ToString("UsuarioCreacion");
            FechaModificacion = row.ToDateTime("FechaModificacion");
            UsuarioModificacion = row.ToString("UsuarioModificacion");
        }
    }
}
