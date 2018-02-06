using Portal.Consultoras.Web.ServiceSeguridad;
using System.Collections.Generic;

namespace Portal.Consultoras.Web.Models
{
    public class AdministrarLinkModel
    {
        public int PermisoID { get; set; }
        public int PaisID { set; get; }
        public int OrdenItem { set; get; }
        public string Descripcion { set; get; }
        public string UrlItem { set; get; }
        public IEnumerable<PosicionModel> listaPosiciones { set; get; }
        public bool PaginaNueva { set; get; }
        public int PermisoIDPadre { get; set; }
        public string Posicion { get; set; }
        public IEnumerable<BEPermiso> listaLinks { set; get; }
        public IEnumerable<PaisModel> listaPaises { set; get; }

        public AdministrarLinkModel()
        {
            this.listaPosiciones = new List<PosicionModel>
            {
                new PosicionModel { PosicionID = 1, Nombre= "Header"},
                new PosicionModel { PosicionID = 2, Nombre= "Footer"}
            };
        }
    }

    public class PosicionModel
    {
        public int PosicionID { get; set; }
        public string Nombre { get; set; }
    }
}