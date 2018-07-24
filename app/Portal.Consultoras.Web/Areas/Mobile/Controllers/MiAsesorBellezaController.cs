using Portal.Consultoras.Common;
using Portal.Consultoras.Web.Areas.Mobile.Models;
using System.Web.Mvc;

namespace Portal.Consultoras.Web.Areas.Mobile.Controllers
{
    public class MiAsesorBellezaController : BaseMobileController
    {
        public ActionResult Index()
        {
            var userData = UserData();
            MiAsesorBellezaModel model = new MiAsesorBellezaModel();

            if (userData.CodigoISO == Constantes.CodigosISOPais.Panama)
            {
                model.OrdenMaximo = 2;
                model.OrdenLbel = 1;
                model.OrdenCyzone = 2;
            }
            else
            {
                model.OrdenMaximo = 3;
                model.OrdenCyzone = 3;

                if (_configuracionManagerProvider.GetPaisesEsikaFromConfig().Contains(userData.CodigoISO))
                {
                    model.OrdenEsika = 1;
                    model.OrdenLbel = 2;
                }
                else
                {
                    model.OrdenLbel = 1;
                    model.OrdenEsika = 2;
                }
            }

            return View(model);
        }

    }
}
