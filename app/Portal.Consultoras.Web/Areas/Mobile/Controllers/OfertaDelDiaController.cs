using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;

namespace Portal.Consultoras.Web.Areas.Mobile.Controllers
{
    public class OfertaDelDiaController : BaseMobileController
    {
        public ActionResult Index()
        {
            try
            {
                if (!ViewBag.MostrarOfertaDelDia)
                {
                    return RedirectToAction("Index", "Bienvenida", new { area = "Mobile" });
                }
            }
            catch (Exception ex)
            {
                LogManager.LogManager.LogErrorWebServicesBus(ex, userData.CodigoConsultora, userData.CodigoISO);
            }

            return View();
        }
    }
}