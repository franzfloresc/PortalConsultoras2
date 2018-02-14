﻿using Portal.Consultoras.Web.Controllers;
using Portal.Consultoras.Web.Infraestructure;
using Portal.Consultoras.Web.CustomFilters;

using System;
using System.Web.Mvc;

namespace Portal.Consultoras.Web.Areas.Mobile.Controllers
{
    [UniqueSession("UniqueRoute", UniqueRoute.IdentifierKey, "/g/")]
    [ClearSessionMobileApp(UniqueRoute.IdentifierKey, "MobileAppConfiguracion", "StartSession")]
    public class GuiaNegocioController : BaseGuiaNegocioController
    {
        public ActionResult Index()
        {
            try
            {
                if (GNDValidarAcceso())
                {
                    return ViewLanding();
                }
            }
            catch (Exception ex)
            {
                logManager.LogErrorWebServicesBusWrap(ex, userData.CodigoConsultora, userData.CodigoISO,string.Empty);
            }

            return RedirectToAction("Index", "Bienvenida", new { area = "Mobile" });
        }
    }
}