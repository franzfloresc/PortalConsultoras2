using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace Portal.Consultoras.Web.Models
{
    [Serializable()]
    public class PermisoModel
    {
        /*Inicio Cambios_Landing_Comunidad */
        public PermisoModel()
        {
            this.SubMenus = new List<PermisoModel>();
        }
        /*Fin Cambios_Landing_Comunidad */

        public int PermisoID { get; set; }

        public string Descripcion { get; set; }

        public int IdPadre { get; set; }

        public int OrdenItem { get; set; }

        public string UrlItem { get; set; }

        public bool PaginaNueva { get; set; }

        public int RolId { get; set; }

        public bool Mostrar { get; set; }

        public string Posicion { get; set; }

        /*Inicio Cambios_Landing_Comunidad */
        public string UrlImagen { get; set; }

        public bool EsSoloImagen { get; set; }

        public bool EsMenuEspecial { get; set; }

        public bool EsServicios { get; set; }

        public bool EsDireccionExterior { get; set; }

        public List<PermisoModel> SubMenus { get; set; }
        /*Fin Cambios_Landing_Comunidad */

        //RSA
        public string DescripcionFormateada { get; set; }
    }
}