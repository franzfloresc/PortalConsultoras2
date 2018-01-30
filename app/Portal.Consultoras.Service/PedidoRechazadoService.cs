using Portal.Consultoras.BizLogic;
using Portal.Consultoras.Entities;
using Portal.Consultoras.ServiceContracts;
using Portal.Consultoras.BizLogic.Pedido;

using System.Collections.Generic;

namespace Portal.Consultoras.Service
{
    public class PedidoRechazadoService : IPedidoRechazadoService
    {
        private readonly IPedidoRechazadoBusinessLogic _pedidoRechazadoBusinessLogic;

        public PedidoRechazadoService() : this(new BLPedidoRechazado())
        {

        }

        public PedidoRechazadoService(IPedidoRechazadoBusinessLogic pedidoRechazadoBusinessLogic)
        {
            _pedidoRechazadoBusinessLogic = pedidoRechazadoBusinessLogic;
        }

        public int SetPedidoRechazado(string PaisISO, List<BEPedidoRechazadoSicc> lista)
        {
            var BLPedidoRechazado = new BLPedidoRechazado();
            return BLPedidoRechazado.InsertarPedidoRechazadoXML(PaisISO,lista);
        }

        public List<BELogGPRValidacion> GetBELogGPRValidacionByGetLogGPRValidacionId(int paisID, long logGPRValidacionId, long ConsultoraID)
        {
            var BLPedidoRechazado = new BLPedidoRechazado();
            return BLPedidoRechazado.GetBELogGPRValidacionByGetLogGPRValidacionId(paisID, logGPRValidacionId, ConsultoraID);
        }

        public List<BELogGPRValidacionDetalle> GetListBELogGPRValidacionDetalleBELogGPRValidacionByLogGPRValidacionId(int paisID, long logGPRValidacionId)
        {
            var BLPedidoRechazado = new BLPedidoRechazado();
            return BLPedidoRechazado.GetListBELogGPRValidacionDetalleBELogGPRValidacionByLogGPRValidacionId(paisID, logGPRValidacionId);
        }

        public BEGPRBanner GetMotivoRechazo(BEGPRUsuario usuario)
        {
            return _pedidoRechazadoBusinessLogic.GetMotivoRechazo(usuario);
        }
    }
}
