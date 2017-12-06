using Portal.Consultoras.Common;
using Portal.Consultoras.Web.Models;
using Portal.Consultoras.Web.ServiceSAC;
using System;
using System.Collections.Generic;
using System.Linq;
using System.ServiceModel;
using System.Web.Mvc;

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

                if (lst != null && lst.Count > 0)
                {
                    var carpetaPaisIncentivos = Globals.UrlIncentivos + "/" + userData.CodigoISO;
                    var carpetaPaisFileConsultoras = Globals.UrlFileConsultoras + "/" + userData.CodigoISO;
                    lst.Update(x => x.ArchivoPortada = ConfigCdn.GetUrlFileCdn(carpetaPaisIncentivos, x.ArchivoPortada));
                    lst.Update(x => x.ArchivoPDF = ConfigCdn.GetUrlFileCdn(carpetaPaisFileConsultoras, x.ArchivoPDF));
                }

                var incentivosModel = new IncentivosModel()
                {
                    PaisID = paisID,
                    CampaniaID = campaniaID,
                    ISO = iso,
                    listaIncentivos = lst
                };
                return View(incentivosModel);
            }
            catch (FaultException ex)
            {
                LogManager.LogManager.LogErrorWebServicesPortal(ex, userData.CodigoConsultora, userData.CodigoISO);
            }
            catch (Exception ex)
            {
                LogManager.LogManager.LogErrorWebServicesBus(ex, userData.CodigoConsultora, userData.CodigoISO);
            }
            return View(new IncentivosModel());
        }
    }
}
