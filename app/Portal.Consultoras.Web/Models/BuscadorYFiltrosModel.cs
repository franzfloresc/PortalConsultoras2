﻿using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace Portal.Consultoras.Web.Models
{
    [Serializable]
    public class BuscadorYFiltrosModel
    {
        public int total { get; set; }
        public IList<Productos> productos { get; set; }
        public Filtros filtros { get; set; }
    }

    public class Filtros
    {
        public IList<FiltrosValores> categorias { get; set; }
        public IList<FiltrosValores> marcas { get; set; }
        public IList<FiltrosValores> precios { get; set; }
    }

    public class Productos
    {
        public string CUV { get; set; }
        public string SAP { get; set; }
        public string Imagen { get; set; }
        public string Descripcion { get; set; }
        public string DescripcionCompleta { get; set; }
        public double Valorizado { get; set; }
        public double Precio { get; set; }
        public int MarcaId { get; set; }
        public string TipoPersonalizacion { get; set; }
        public int CodigoEstrategia { get; set; }
        public string CodigoTipoEstrategia { get; set; }
        public int LimiteVenta { get; set; }
        public bool Stock { get; set; }
        public string PrecioString { get; set; }
        public string ValorizadoString { get; set; }
        public string Agregado { get; set; }
        public int CantidadesAgregadas { get; set; }
        public int CampaniaID { get; set; }
        public int TipoEstrategiaId { get; set; }
        public string DescripcionEstrategia { get; set; }
        public string OrigenPedidoWeb { get; set; }
        public string URLBsucador { get; set; }
        public int EstrategiaID { get; set; }
        public string SimboloMoneda { get; set; }
        public bool MaterialGanancia { get; set; }
    }

    public class FiltrosValores
    {
        public string idFiltro { get; set; }
        public string nombreFiltro { get; set; }
        public int cantidad { get; set; }
        public bool marcado { get; set; }
    }


}