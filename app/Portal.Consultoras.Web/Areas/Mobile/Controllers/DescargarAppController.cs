using System.Web.Mvc;
using System.Configuration;
using System.Linq;
using System.Threading.Tasks;

using Portal.Consultoras.Web.ServiceSAC;
using Portal.Consultoras.Common;

namespace Portal.Consultoras.Web.Areas.Mobile.Controllers
{
    public class DescargarAppController : BaseMobileController
    {
        public async Task<ActionResult> Index()
        {
            using (var sac = new SACServiceClient())
            {
                var lstComunicados = await sac.ObtenerComunicadoPorConsultoraAsync(userData.PaisID, userData.CodigoConsultora, 
                    Constantes.ComunicadoTipoDispositivo.Mobile, userData.CodigorRegion, userData.CodigoZona, userData.ConsultoraNueva);
                var oComunicado = lstComunicados.FirstOrDefault(x => x.Descripcion == Constantes.Comunicado.BannerDescargarAppNuevas);
                if (oComunicado != null) ViewBag.Url = oComunicado.DescripcionAccion;
                else return RedirectToAction("Index", "Bienvenida", new { area = "Mobile" });
            }

            ViewBag.EsPaisEsika = ConfigurationManager.AppSettings.Get("PaisesEsika").Contains(userData.CodigoISO) ? "1" : "0";

            Session[Constantes.ConstSession.ConsultoraNuevaBannerAppMostrar] = true;

            return View();
        }
    }
}