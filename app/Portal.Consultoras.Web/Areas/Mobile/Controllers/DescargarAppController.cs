using Portal.Consultoras.Common;
using Portal.Consultoras.Web.ServiceSAC;
using System.Collections.Generic;
using System.Configuration;
using System.Linq;
using System.Threading.Tasks;
using System.Web.Mvc;

namespace Portal.Consultoras.Web.Areas.Mobile.Controllers
{
    public class DescargarAppController : BaseMobileController
    {
        public async Task<ActionResult> Index()
        {
            var lstComunicados = await ObtenerComunicadoPorConsultoraAsync();
            var oComunicado = lstComunicados.FirstOrDefault(x => x.Descripcion == Constantes.Comunicado.BannerDescargarAppNuevas);

            if (oComunicado != null) ViewBag.Url = oComunicado.DescripcionAccion;
            else return RedirectToAction("Index", "Bienvenida", new { area = "Mobile" });

            ViewBag.ComunicadoId = oComunicado.ComunicadoId;
            ViewBag.EsPaisEsika = ConfigurationManager.AppSettings.Get("PaisesEsika").Contains(userData.CodigoISO) ? "1" : "0";

            Session[Constantes.ConstSession.ConsultoraNuevaBannerAppMostrar] = true;

            return View();
        }

        private async Task<List<BEComunicado>> ObtenerComunicadoPorConsultoraAsync()
        {
            using (var sac = new SACServiceClient())
            {
                var lstComunicados = await sac.ObtenerComunicadoPorConsultoraAsync(UserData().PaisID, UserData().CodigoConsultora,
                        Constantes.ComunicadoTipoDispositivo.Desktop, UserData().CodigorRegion, UserData().CodigoZona, UserData().ConsultoraNueva);

                return lstComunicados.ToList();
            }
        }
    }
}