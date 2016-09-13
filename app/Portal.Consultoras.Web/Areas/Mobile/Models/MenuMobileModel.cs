using System.Collections.Generic;

namespace Portal.Consultoras.Web.Areas.Mobile.Models
{
    public class MenuMobileModel
    {
        public MenuMobileModel()
        {
            SubMenu = new List<MenuMobileModel>();
        }

        public int MenuMobileID { get; set; }

        public string Descripcion { get; set; }

        public int MenuPadreID { get; set; }

        public string MenuPadreDescripcion { get; set; }

        public int OrdenItem { get; set; }

        public string UrlItem { get; set; }

        public string UrlImagen { get; set; }

        public bool PaginaNueva { get; set; }

        public string Posicion { get; set; }

        public string Version { get; set; }

        public IList<MenuMobileModel> SubMenu { get; set; }
    }
}
