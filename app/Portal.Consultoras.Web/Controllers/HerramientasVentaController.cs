﻿using System;
using System.Web.Mvc;

namespace Portal.Consultoras.Web.Controllers
{
    public class HerramientasVentaController : BaseViewController
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
                if (EsDispositivoMovil())
                {
                    var url = (Request.Url.Query).Split('?');
                    if (url.Length > 1)
                    {
                        string sap = "&" + url[1];
                        return RedirectToAction("Comprar", "HerramientasVenta", new { area = "Mobile", sap });
                    }
                    else
                    {
                        return RedirectToAction("Comprar", "HerramientasVenta", new { area = "Mobile" });
                    }
                }

                return HVViewLanding(1);
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
                return HVViewLanding(2);
            }
            catch (Exception ex)
            {
                logManager.LogErrorWebServicesBusWrap(ex, userData.CodigoConsultora, userData.CodigoISO, "HerramientasVentaController.Revisar");
            }

            return RedirectToAction("Index", "Bienvenida");
        }
    }
}