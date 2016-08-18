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
                if (!UsuarioModel.HasAcces(ViewBag.Permiso, "Incentivos/Index"))
                    return RedirectToAction("Index", "Bienvenida");

                List<BEIncentivo> lst;
                int paisID = UserData().PaisID;
                int campaniaID = UserData().CampaniaID;
                string iso = UserData().CodigoISO;

                using (SACServiceClient sv = new SACServiceClient())
                {
                    lst = sv.SelectIncentivos(paisID, campaniaID).ToList();
                }

                // 1664
                if (lst != null)
                {
                    var carpetaPais = Globals.UrlIncentivos + "/" + UserData().CodigoISO;
                    if (lst.Count > 0) { lst.Update(x => x.ArchivoPortada = ConfigS3.GetUrlFileS3(carpetaPais, x.ArchivoPortada, Globals.RutaImagenesIncentivos + "/" + UserData().CodigoISO)); }
                    carpetaPais = Globals.UrlFileConsultoras + "/" + UserData().CodigoISO;
                    if (lst.Count > 0) { lst.Update(x => x.ArchivoPDF = ConfigS3.GetUrlFileS3(carpetaPais, x.ArchivoPDF, Globals.RutaImagenesIncentivos + "/" + UserData().CodigoISO)); }
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
                LogManager.LogManager.LogErrorWebServicesPortal(ex, UserData().CodigoConsultora, UserData().CodigoISO);
            }
            catch (Exception ex)
            {
                LogManager.LogManager.LogErrorWebServicesBus(ex, UserData().CodigoConsultora, UserData().CodigoISO);
            }
            return View(new LugaresPagoModel());
        }

    }
}
