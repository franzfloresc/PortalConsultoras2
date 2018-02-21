using System.Collections.Generic;
using Portal.Consultoras.Entities;

namespace Portal.Consultoras.BizLogic
{
    public interface IMenuAppBusinessLogic
    {
        IList<BEMenuApp> GetMenuApp(BEMenuApp menuApp);
    }
}