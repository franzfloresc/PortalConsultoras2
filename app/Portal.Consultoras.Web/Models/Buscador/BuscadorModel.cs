using System;
using System.Collections.Generic;

namespace Portal.Consultoras.Web.Models.Buscador
{
    [Serializable]
    public class BuscadorModel
    {
        public BuscadorModel()
        {
            Filtro = new Filtros();
            Orden = new Orden();
            Paginacion = new Paginacion();
        }

        public string TextoBusqueda { get; set; }
        public Orden Orden { get; set; }
        public Paginacion Paginacion { get; set; }
        public Filtros Filtro { get; set; }
        public bool IsMobile { get; set; }
    }

    public class Filtros
    {
        public List<ValoresFiltros> categoria { get; set; }
        public List<ValoresFiltros> marca { get; set; }
        public List<ValoresFiltros> precio { get; set; }
    }

    public class ValoresFiltros
    {
        public string idFiltro { get; set; }
        public string nombreFiltro { get; set; }
        public double min { get; set; }
        public double max { get; set; }
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
