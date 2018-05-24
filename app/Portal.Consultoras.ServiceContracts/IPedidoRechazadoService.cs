using Portal.Consultoras.Entities;
using System.Collections.Generic;
using System.ServiceModel;

namespace Portal.Consultoras.ServiceContracts
{
    [ServiceContract]
    public interface IPedidoRechazadoService
    {
        [OperationContract]
        int SetPedidoRechazado(string PaisISO, List<BEPedidoRechazadoSicc> lista);

        [OperationContract]
        List<BELogGPRValidacion> GetBELogGPRValidacionByGetLogGPRValidacionId(int paisID, long logGPRValidacionId, long ConsultoraID);

        [OperationContract]
        List<BELogGPRValidacionDetalle> GetListBELogGPRValidacionDetalleBELogGPRValidacionByLogGPRValidacionId(int paisID, long logGPRValidacionId);

        [OperationContract]
        BEGPRBanner GetMotivoRechazo(BEGPRUsuario usuario);
    }
}