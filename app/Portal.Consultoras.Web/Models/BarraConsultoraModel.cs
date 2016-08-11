using Portal.Consultoras.Web.ServicePedido;
using System.Collections.Generic;

namespace Portal.Consultoras.Web.Models
{
    public class BarraConsultoraModel
    {
        public decimal MontoMinimo { get; set; }
        public string MontoMinimoStr { get; set; }

        public decimal MontoMaximo { get; set; }
        public string MontoMaximoStr { get; set; }

        public decimal MontoEscala { get; set; }
        public string MontoEscalaStr { get; set; }

        public decimal MontoDescuento { get; set; }
        public string MontoDescuentoStr { get; set; }

        public decimal TippingPoint { get; set; }
        public string TippingPointStr { get; set; }
        
        public decimal TotalPedido { get; set; }
        public string TotalPedidoStr { get; set; }

        public IList<BarraConsultoraEscalaDescuentoModel> ListaEscalaDescuento { get; set; }
        public IList<BEMensajeMetaConsultora> ListaMensajeMeta { get; set; }
    }
}