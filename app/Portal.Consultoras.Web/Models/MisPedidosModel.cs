using Portal.Consultoras.Web.ServiceUsuario;
using System;
using System.Collections.Generic;

namespace Portal.Consultoras.Web.Models
{
    [Serializable()]
    public class MisPedidosModel
    {
        public List<BEMisPedidos> ListaPedidos { get; set; }

        public string Registros { get; set; }
        public string RegistrosDe { get; set; }
        public string RegistrosTotal { get; set; }
        public string Pagina { get; set; }
        public string PaginaDe { get; set; }
        public string FechaPedidoReciente { get; set; }

        public List<BEMisPedidosDetalle> ListaDetalle { get; set; }

        public List<MisPedidosDetalleModel> ListaDetalleModel { get; set; }

        public List<MisPedidosMotivoRechazoModel> MotivosRechazo { get; set; }
    }
}