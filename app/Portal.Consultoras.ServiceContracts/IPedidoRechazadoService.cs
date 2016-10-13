using Portal.Consultoras.Entities;
using System.Collections.Generic;
using System.ServiceModel;

namespace Portal.Consultoras.ServiceContracts
{
    [ServiceContract]
    public interface IPedidoRechazadoService
    {
        [OperationContract]
        int SetPedidoRechazado(string PaisISO, List<BEPedidoRechazado> lista);

        [OperationContract]
        BELogGPRValidacion GetBELogGPRValidacionByGetLogGPRValidacionId(int paisID, long logGPRValidacionId);

        [OperationContract]
        List<BELogGPRValidacionDetalle> GetListBELogGPRValidacionDetalleBELogGPRValidacionByLogGPRValidacionId(int paisID, long logGPRValidacionId);
    }
}
