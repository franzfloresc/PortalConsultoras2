using System;
using System.Collections.Generic;

namespace Portal.Consultoras.Web.Models
{
    [Serializable]
    public class EstrategiaOutModel
    {
        public string Mensaje { get; set; }
        public string Titulo { get; set; }
        public string TituloDescripcion { get; set; }
        public string CodigoEstrategia { get; set; }
        public string Consultora { get; set; }
        public int OrigenPedidoWeb { get; set; }
        public EstrategiaPedidoModel Item { get; set; }
        public List<EstrategiaPedidoModel> Lista { get; set; }
        public List<EstrategiaPersonalizadaProductoModel> ListaModelo { get; set; }
        public List<EstrategiaPersonalizadaProductoModel> ListaLan { get; set; }
    }
}