using Portal.Consultoras.Common;
using System;
using System.Collections.Generic;
using System.Data.SqlTypes;
using System.Linq;
using System.ServiceModel;
using System.Web;
using System.Web.Mvc;
using Portal.Consultoras.Web.Models;

namespace Portal.Consultoras.Web.Controllers
{
    public class DescargablesController: BaseController
    {
        public ActionResult Descargables()
        {
            var model = new DescargablesModel();
            try
            {
                string paisISO = Util.GetPaisISO(userData.PaisID);
                var carpetaPais = Globals.UrlFileConsultoras + "/" + paisISO;
                string urlS3 = ConfigS3.GetUrlS3(carpetaPais);

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