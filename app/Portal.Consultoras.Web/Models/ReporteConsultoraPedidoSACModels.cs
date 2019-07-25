using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace Portal.Consultoras.Web.Models
{
    public class ReporteConsultoraPedidoSACModels
    {
        public ReporteConsultoraPedidoSACModels()
        {
            listaPaises = new List<PaisModel>();
        }

        public int PaisID { get; set; }
        public bool PedidoFICActivo { get; set; }
        public DateTime FechaFacturacion { get; set; }
        public int TipoCronogramaID { get; set; }
        public bool FlagPedidos { get; set; }
        public IEnumerable<PaisModel> listaPaises { get; set; }
        public IEnumerable<CampaniaModel> listaCampania { set; get; }

    }
}