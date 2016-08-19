using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace Portal.Consultoras.Web.Models
{
    public class DescargarPedidoModel
    {
        public int PaisID { get; set; }
        public DateTime FechaFacturacion { get; set; }
        public int TipoCronogramaID { get; set; }
        public bool FlagPedidos { get; set; }
        public IEnumerable<PaisModel> listaPaises { get; set; }
    }
}