using Portal.Consultoras.Common;

namespace Portal.Consultoras.Web.Models.Pedido
{
    public class PedidoRechazadoBannerModel
    {
        public Enumeradores.RechazoBannerUrl Url { get; set; }

        public string Titulo { get; set; }

        public string Mensaje { get; set; }

        public bool RechazadoXDeuda { get; set; }

        public bool MostrarBannerRechazo { get; set; }
    }
}