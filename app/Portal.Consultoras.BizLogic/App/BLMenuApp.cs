using Portal.Consultoras.Data;
using Portal.Consultoras.Entities;
using Portal.Consultoras.Common;

using System.Collections.Generic;
using System.Data;
using System.Linq;

namespace Portal.Consultoras.BizLogic
{
    public class BLMenuApp : IMenuAppBusinessLogic
    {
        public IList<BEMenuApp> GetMenuApp(BEMenuApp menuApp)
        {
            using (IDataReader reader = new DAMenuApp(menuApp.paisId).GetMenusApp(menuApp))
            {
                var listaMenusApp = reader.MapToCollection<BEMenuApp>();
                return ContruirMenus(listaMenusApp).OrderBy(x=>x.Posicion).ThenBy(x=>x.Orden).ToList();
            }
        }

        private IList<BEMenuApp> ContruirMenus(IList<BEMenuApp> listaMenusApp)
        {
            List<BEMenuApp> menus = listaMenusApp.Where(m => m.CodigoMenuPadre.Trim().Equals(string.Empty)).OrderBy(m => m.Orden).ToList();
            List<BEMenuApp> subMenus = listaMenusApp.Where(m => !m.CodigoMenuPadre.Trim().Equals(string.Empty)).ToList();

            foreach (var menu in menus)
            {
                menu.SubMenus = subMenus.Where(sm => sm.CodigoMenuPadre.Equals(menu.Codigo)).OrderBy(sm => sm.Orden).ToList();
            }

            return menus;
        }
    }
}