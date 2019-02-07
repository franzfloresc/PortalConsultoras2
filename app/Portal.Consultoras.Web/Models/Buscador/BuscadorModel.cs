using System;
using System.Collections.Generic;

namespace Portal.Consultoras.Web.Models.Buscador
{
    [Serializable]
    public class BuscadorModel
    {
        public BuscadorModel()
        {
            Orden = new Orden();
            Paginacion = new Paginacion();
            Filtro = new List<Filtros>();
        }

        public string TextoBusqueda { get; set; }
        public Orden Orden { get; set; }
        public Paginacion Paginacion { get; set; }
        public List<Filtros> Filtro { get; set; }
        public bool IsMobile { get; set; }
        public bool IsHome { get; set; }        
    }

    public class Filtros
    {
        public string NombreGrupo { get; set; }
        public List<OpcionesFiltro> Opciones { get; set; }
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

    public class OpcionesFiltro
    {
        public string IdFiltro { get; set; }
        public string NombreFiltro { get; set; }
        public double Min { get; set; }
        public double Max { get; set; }
    }
}
