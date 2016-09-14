using Portal.Consultoras.Entities;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Runtime.Serialization;
using System.ServiceModel;
using System.Text;

namespace Portal.Consultoras.ServiceContracts
{
    [ServiceContract]
    public interface IWS_GPR
    {
        [OperationContract]
        int setPedidoRechazado(string PaisISO, List<BEPedidoRechazado> lista);
    }
}
