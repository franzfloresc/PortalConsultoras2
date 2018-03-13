using Portal.Consultoras.Entities;
using System.Collections.Generic;

namespace Portal.Consultoras.BizLogic.Pedido
{
    public interface IPedidoRechazadoBusinessLogic
    {
        int InsertarPedidoRechazadoXML(string paisISO, List<BEPedidoRechazadoSicc> listBEPedidoRechazado);
        void UpdatePedidoRechazadoVisualizado(int paisID, long logGPRValidacionId);
        List<BELogGPRValidacion> GetBELogGPRValidacionByGetLogGPRValidacionId(int paisID, long logGPRValidacionId, long ConsultoraID);
        List<BELogGPRValidacionDetalle> GetListBELogGPRValidacionDetalleBELogGPRValidacionByLogGPRValidacionId(int paisID, long logGPRValidacionId);
        BEGPRBanner GetMotivoRechazo(BEGPRUsuario usuario);
    }
}