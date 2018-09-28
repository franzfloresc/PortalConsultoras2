using Portal.Consultoras.Common;
using Portal.Consultoras.Web.ServicePedido;
using System.Collections.Generic;
using System.Linq;
using System.Web.Mvc;

namespace Portal.Consultoras.Web.Controllers
{
    public class EscalaDescuentosController : BaseController
    {
        public ActionResult Index()
        {
            string fileName = string.Empty;
            var carpetaPais = string.Format("{0}/{1}", Globals.UrlEscalaDescuentos , userData.CodigoISO);
          
            using (var svc = new PedidoServiceClient())
            {
                List<BEEscalaDescuento> Lista = svc.ListarEscalaDescuentoZona(userData.PaisID, userData.CampaniaID, userData.CodigorRegion, userData.CodigoZona).ToList<BEEscalaDescuento>();
                if(Lista.Count ==0)
                    fileName = string.Format("Landing_escala_dscto_{0}.jpg", userData.CodigoISO);
                else
                    fileName = string.Format("Landing_escala_dscto_{0}_{1}.jpg", userData.CodigoISO, Lista[0].NameDocumento);
            }
            ViewBag.Ruta = ConfigCdn.GetUrlFileCdn(carpetaPais, fileName);
            return View();
        }


    }
}
