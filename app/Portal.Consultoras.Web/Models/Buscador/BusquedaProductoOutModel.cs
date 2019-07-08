using System.Collections.Generic;

namespace Portal.Consultoras.Web.Models.Buscador
{
    public class BusquedaProductoOutModel
    {
        public string TextoBusqueda { get; set; }
        public string CategoriaBusqueda { get; set; }
        public Dictionary<string,string> ListaOrdenamiento { get; set; }
        public int TotalProductosPagina { get; set; }
        public int TotalCaracteresDescripcion { get; set; }
        public bool MostrarOpcionesOrdenamiento { get; set; }

        
    }
}