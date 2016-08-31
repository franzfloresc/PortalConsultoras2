using System;
using System.Collections.Generic;
using System.Linq;
using System.ServiceModel;
using System.Web;
using System.Web.Mvc;
using Portal.Consultoras.Web.Models;
using Portal.Consultoras.Web.ServiceSAC;
using Portal.Consultoras.Common; // 1664

namespace Portal.Consultoras.Web.Controllers
{
    public class IncentivosController : BaseController
    {
        public ActionResult Index()
        {
            try
            {
                List<BEIncentivo> lst;
                int paisID = userData.PaisID;
                int campaniaID = userData.CampaniaID;
                string iso = userData.CodigoISO;

                using (SACServiceClient sv = new SACServiceClient())
                {
                    lst = sv.SelectIncentivos(paisID, campaniaID).ToList();
                }

                // 1664
                if (lst != null)
                {
                    var carpetaPais = Globals.UrlIncentivos + "/" + userData.CodigoISO;
                    if (lst.Count > 0) { lst.Update(x => x.ArchivoPortada = ConfigS3.GetUrlFileS3(carpetaPais, x.ArchivoPortada, Globals.RutaImagenesIncentivos + "/" + userData.CodigoISO)); }
                    carpetaPais = Globals.UrlFileConsultoras + "/" + userData.CodigoISO;
                    if (lst.Count > 0) { lst.Update(x => x.ArchivoPDF = ConfigS3.GetUrlFileS3(carpetaPais, x.ArchivoPDF, Globals.RutaImagenesIncentivos + "/" + userData.CodigoISO)); }
                }

                var incentivosModel = new IncentivosModel()
                {
                    PaisID = paisID,
                    CampaniaID = campaniaID,
                    ISO = iso,
                    listaIncentivos = lst
                };
                return View("_Index", incentivosModel);
            }
            catch (FaultException ex)
            {
                LogManager.LogManager.LogErrorWebServicesPortal(ex, userData.CodigoConsultora, userData.CodigoISO);
            }
            catch (Exception ex)
            {
                LogManager.LogManager.LogErrorWebServicesBus(ex, userData.CodigoConsultora, userData.CodigoISO);
            }
            return View(new LugaresPagoModel());
        }

    }
}
