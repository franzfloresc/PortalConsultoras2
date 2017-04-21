using Portal.Consultoras.BizLogic;
using Portal.Consultoras.Entities;
using Portal.Consultoras.ServiceContracts;
using System.Collections.Generic;

namespace Portal.Consultoras.Service
{
    public class MenuService : IMenuService
    {
        private BLMenuApp BLMenuApp;

        public MenuService()
        {
            BLMenuApp = new BLMenuApp();
        }
        public List<BEMenuApp> ListarMenus(int paisiD)
        {
            return BLMenuApp.GetMenusApp(paisiD);
        }
    }
}