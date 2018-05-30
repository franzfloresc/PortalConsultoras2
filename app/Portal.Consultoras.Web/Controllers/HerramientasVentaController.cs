﻿using Portal.Consultoras.Common;
using Portal.Consultoras.Web.Models;
using System;
using System.Linq;
using System.Web.Mvc;

namespace Portal.Consultoras.Web.Controllers
{
    public class HerramientasVentaController : BaseHerramientasVentaController
    {
        public ActionResult Index()
        {
            try
            {
                return RedirectToAction("Index", "Ofertas");
            }
            catch (Exception ex)
            {
                logManager.LogErrorWebServicesBusWrap(ex, userData.CodigoConsultora, userData.CodigoISO, "HerramientasVentaController.Index");
            }

            return RedirectToAction("Index", "Bienvenida");
        }

        public ActionResult Comprar()
        {
            try
            {
                return ViewLanding(1);
            }
            catch (Exception ex)
            {
                logManager.LogErrorWebServicesBusWrap(ex, userData.CodigoConsultora, userData.CodigoISO, "HerramientasVentaController.Comprar");
            }

            return RedirectToAction("Index", "Bienvenida");
        }

        public ActionResult Revisar()
        {
            try
            {
                return ViewLanding(2);
            }
            catch (Exception ex)
            {
                logManager.LogErrorWebServicesBusWrap(ex, userData.CodigoConsultora, userData.CodigoISO, "HerramientasVentaController.Revisar");
            }

            return RedirectToAction("Index", "Bienvenida");
        }
    }
}