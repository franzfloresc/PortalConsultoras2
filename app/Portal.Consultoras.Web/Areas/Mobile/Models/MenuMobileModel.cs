using System;
using System.Collections.Generic;

namespace Portal.Consultoras.Web.Areas.Mobile.Models
{
    [Serializable()]
    public class MenuMobileModel
    {
        public MenuMobileModel()
        {
            SubMenu = new List<MenuMobileModel>();
        }

        public string ClaseMenu { get; set; }
        public string ClaseMenuItem { get; set; }
        public string ClaseSubMenu { get; set; }
        public string Codigo { get; set; }
        public string Descripcion { get; set; }
        public string EstiloMenu { get; set; }
        public int MenuMobileID { get; set; }
        public string MenuPadreDescripcion { get; set; }
        public int MenuPadreID { get; set; }
        public string OnClickFunt { get; set; }
        public int OrdenItem { get; set; }

        public string PageTarget { get; set; }
        public bool PaginaNueva { get; set; }
        public string Posicion { get; set; }
        public IList<MenuMobileModel> SubMenu { get; set; }
        public string UrlImagen { get; set; }
        public string UrlItem { get; set; }
        public string Version { get; set; }
    }
}
