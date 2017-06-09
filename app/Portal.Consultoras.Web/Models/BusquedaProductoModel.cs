﻿using System;
using System.Collections.Generic;

namespace Portal.Consultoras.Web.Models
{
    [Serializable]
    public class BusquedaProductoModel
    {
        public List<Filtro> ListaFiltro { get; set; }
        public Ordenamiento Ordenamiento { get; set; }
        public int Limite { get; set; }
    }

    public class Filtro
    {
        public string Tipo { get; set; }
        public List<string> Valores { get; set; } 
    }

    public class Ordenamiento
    {
        public string Tipo { get; set; }
        public string Valor { get; set; }
    }
}