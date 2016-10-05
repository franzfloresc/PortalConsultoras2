using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

using Portal.Consultoras.Web.ServiceUsuario;

namespace Portal.Consultoras.Web.Models
{
    public class MisPedidosDetalleModel
    {
        public List<BEMisPedidosDetalle> ListaDetalle { get; set; }

        public string Registros { get; set; }
        public string RegistrosDe { get; set; }
        public string RegistrosTotal { get; set; }
        public string Pagina { get; set; }
        public string PaginaDe { get; set; }

        public int PedidoId { get; set; }
        public int PedidoDetalleId { get; set; }
        public string OpcionAcepta { get; set; }
    }
}