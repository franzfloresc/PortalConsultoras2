using System;
using System.Collections.Generic;

namespace Portal.Consultoras.Web.Models
{
    [Serializable()]
    public class PermisoModel
    {
        public PermisoModel()
        {
            this.SubMenus = new List<PermisoModel>();
        }

        public string ClaseMenu { get; set; }
        public string ClaseMenuItem { get; set; }
        public string ClaseSubMenu { get; set; }
        public string Codigo { get; set; }
        public string Descripcion { get; set; }
        public string DescripcionFormateada { get; set; }
        public bool EsDireccionExterior { get; set; }
        public bool EsMenuEspecial { get; set; }
        public bool EsServicios { get; set; }
        public bool EsSoloImagen { get; set; }
        public int IdPadre { get; set; }
        public bool Mostrar { get; set; }
        public string OnClickFunt { get; set; }
        public int OrdenItem { get; set; }
        public string PageTarget { get; set; }
        public bool PaginaNueva { get; set; }
        public int PermisoID { get; set; }
        public string Posicion { get; set; }
        public int RolId { get; set; }
        public List<PermisoModel> SubMenus { get; set; }
        public string UrlImagen { get; set; }
        public string UrlItem { get; set; }
    }
}