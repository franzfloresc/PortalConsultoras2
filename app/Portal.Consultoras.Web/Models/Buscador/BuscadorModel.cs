using System;

namespace Portal.Consultoras.Web.Models.Buscador
{
    [Serializable]
    public class BuscadorModel
    {
        public string TextoBusqueda { get; set; }
        public Orden Orden { get; set; }
        public Paginacion Paginacion { get; set; }
    }
    
    public class Paginacion
    {
        public int NumeroPagina { get; set; }
        public int Cantidad { get; set; }
    }
    
    public class Orden
    {
        public string Campo { get; set; }
        public string Tipo { get; set; }
    }
}
