using Portal.Consultoras.Entities;
using System.Collections.Generic;
using System.ServiceModel;

namespace Portal.Consultoras.ServiceContracts
{
    [ServiceContract]
    public interface IPedidoRechazadoService
    {
        [OperationContract]
        int setPedidoRechazado(string PaisISO, List<BEPedidoRechazado> lista);
    }
}
