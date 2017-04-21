using Portal.Consultoras.Entities;
using System.Collections.Generic;
using System.ServiceModel;

namespace Portal.Consultoras.ServiceContracts
{
    [ServiceContract]
    public interface IMenuService
    {
        [OperationContract]
        List<BEMenuApp> ListarMenus(int paisiD);
    }
}