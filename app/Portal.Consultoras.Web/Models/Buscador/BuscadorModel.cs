using System;
using System.Collections.Generic;

namespace Portal.Consultoras.Web.Models.Buscador
{
    [Serializable]
    public class BuscadorModel
    {
        public string TextoBusqueda { get; set; }
        public Orden Orden { get; set; }
        public Paginacion Paginacion { get; set; }
        public Filtros Filtro { get; set; }
    }

    public class Filtros
    {
        public string categoria { get; set; }
        public string marca { get; set; }
    }

    public class ValoresFiltros
    {
        public string id { get; set; }
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
