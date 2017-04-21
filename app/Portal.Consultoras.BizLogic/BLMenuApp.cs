using Portal.Consultoras.Data;
using Portal.Consultoras.Entities;
using System.Collections.Generic;
using System.Data;
using System.Linq;

namespace Portal.Consultoras.BizLogic
{
    public class BLMenuApp
    {
        public List<BEMenuApp> GetMenusApp(int paisId)
        {
            List<BEMenuApp> listaMenusApp = new List<BEMenuApp>();

            using (IDataReader reader = (new DAMenuApp(paisId)).GetMenusApp())
            {
                while (reader.Read())
                {
                    BEMenuApp menuApp = new BEMenuApp(reader);
                    listaMenusApp.Add(menuApp);
                }
            }

            listaMenusApp = ContruirMenus(listaMenusApp);

            return listaMenusApp;
        }

        private List<BEMenuApp> ContruirMenus(List<BEMenuApp> listaMenusApp)
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