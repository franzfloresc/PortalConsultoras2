using Portal.Consultoras.Common;
using System;
using System.Data;
using System.Runtime.Serialization;

namespace Portal.Consultoras.Entities
{
    [DataContract]
    public class BEPermiso
    {
        [DataMember]
        public int PermisoID { get; set; }

        [DataMember]
        public int PaisID { set; get; }

        [DataMember]
        public string Descripcion { get; set; }

        [DataMember]
        public int IdPadre { get; set; }

        [DataMember]
        public string DescripcionPadre { get; set; }

        [DataMember]
        public int OrdenItem { get; set; }

        [DataMember]
        public string UrlItem { get; set; }

        [DataMember]
        public bool PaginaNueva { get; set; }

        [DataMember]
        public int RolId { get; set; }

        [DataMember]
        public bool Mostrar { get; set; }

        [DataMember]
        public string Posicion { get; set; }

        [DataMember]
        public string DescripcionPaginaNueva { get; set; }

        [DataMember]
        public string UrlImagen { get; set; }

        [DataMember]
        public bool EsSoloImagen { get; set; }

        [DataMember]
        public bool EsMenuEspecial { get; set; }

        [DataMember]
        public bool EsServicios { get; set; }

        [DataMember]
        public string Codigo { get; set; }

        public BEPermiso() { }
        public BEPermiso(IDataRecord row)
        {
            PermisoID = row.ToInt32("PermisoID");
            PaisID = row.ToInt32("PaisID");
            Descripcion = row.ToString("Descripcion");
            IdPadre = row.ToInt32("IdPadre");
            OrdenItem = row.ToInt32("OrdenItem");
            UrlItem = row.ToString("UrlItem");
            PaginaNueva = row.ToBoolean("PaginaNueva");
            RolId = row.ToInt32("RolId");
            Mostrar = row.ToBoolean("Mostrar");
            Posicion = row.ToString("Posicion");
            DescripcionPadre = row.ToString("DescripcionPadre");
            DescripcionPaginaNueva = row.ToString("DescripcionPaginaNueva");
            UrlImagen = row.ToString("UrlImagen");
            EsSoloImagen = row.ToBoolean("EsSoloImagen");
            EsMenuEspecial = row.ToBoolean("EsMenuEspecial");
            EsServicios = row.ToBoolean("EsServicios");
            Codigo = row.ToString("Codigo");
        }
    }
}
