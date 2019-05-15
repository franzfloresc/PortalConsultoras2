using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
//HD-3606 EINCA
namespace Portal.Consultoras.Web.Models.Pedido
{
    public class PedidoSeguimientoDetalleModel
    {  
        public int Campana { get; set; }
        public string NumeroPedido { get; set; }
        public int Etapa { get; set; }
        public string Situacion { get; set; }
        public DateTime? Fecha { get; set; }
        public string FechaFormatted { get; set; }
        public bool Alcanzado { get; set; }
        public string Observacion { get; set; }
    }
}