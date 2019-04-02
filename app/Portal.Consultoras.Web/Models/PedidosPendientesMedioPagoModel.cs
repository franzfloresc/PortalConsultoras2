using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace Portal.Consultoras.Web.Models
{
    public class PedidosPendientesMedioPagoModel
    {

        public decimal Total { get; set; }
        public decimal TotalGana { get; set; }
        public decimal TotalCatalogo { get; set; }
        public List<EstrategiaPedidoModel> ListaGana { get; set; }
        public List<EstrategiaPedidoModel> ListaCatalogo { get; set; }
        public decimal GananciaGana { get; set; }

    }
}