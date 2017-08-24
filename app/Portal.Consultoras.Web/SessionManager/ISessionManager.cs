using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using Portal.Consultoras.Web.ServicePedido;
using Portal.Consultoras.Web.Models;

namespace Portal.Consultoras.Web.SessionManager
{
    public interface ISessionManager
    {
        BEPedidoWeb GetPedidoWeb();

        void SetPedidoWeb(BEPedidoWeb pedidoWeb);


        List<BEPedidoWebDetalle> GetDetallesPedido();

        void SetDetallesPedido(List<BEPedidoWebDetalle> detallesPedidoWeb);

        List<ObservacionModel> GetObservacionesProl();

        void SetObservacionesProl(List<ObservacionModel> observaciones);
    }
}
