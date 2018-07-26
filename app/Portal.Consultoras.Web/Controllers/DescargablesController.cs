using Portal.Consultoras.Common;
using Portal.Consultoras.Web.Models;
using System;
using System.Web.Mvc;

namespace Portal.Consultoras.Web.Controllers
{
    public class DescargablesController : BaseController
    {
        public ActionResult Descargables()
        {
            var model = new DescargablesModel();
            try
            {
                string paisIso = Util.GetPaisISO(userData.PaisID);
                var carpetaPais = Globals.UrlFileConsultoras + "/" + paisIso;
                string urlS3 = ConfigCdn.GetUrlCdn(carpetaPais);

                model.NombreTarjeta_navidenia = Constantes.ArchivosDescargables.TARJETA_NAVIDENA;
                model.NombrePapel_regalo_dorado = Constantes.ArchivosDescargables.PAPEL_REGALO_DORADO;
                model.NombrePapel_regalo_rojo = Constantes.ArchivosDescargables.PAPEL_REGALO_ROJO;

                model.Urltarjeta_navidenia = urlS3 + Constantes.ArchivosDescargables.TARJETA_NAVIDENA;
                model.Urlpapel_regalo_dorado = urlS3 + Constantes.ArchivosDescargables.PAPEL_REGALO_DORADO;
                model.Urlpapel_regalo_rojo = urlS3 + Constantes.ArchivosDescargables.PAPEL_REGALO_ROJO;
            }
            catch (Exception ex)
            {
                LogManager.LogManager.LogErrorWebServicesBus(ex, userData.CodigoConsultora, userData.CodigoISO);
            }

            return PartialView(model);
        }
    }
}