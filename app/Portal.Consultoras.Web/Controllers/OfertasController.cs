﻿using Portal.Consultoras.Common;
using Portal.Consultoras.Web.Models;
using Portal.Consultoras.Web.Models.Layout;
using Portal.Consultoras.Web.ServicePedido;
using System;
using System.Collections.Generic;
using System.Linq;
using System.ServiceModel;
using System.Web;
using System.Web.Mvc;

namespace Portal.Consultoras.Web.Controllers
{
    public class OfertasController : BaseController
    {
        public ActionResult Index()
        {
            try
            {
                var listaSeccion = ObtenerConfiguracion();
                var modelo = new EstrategiaPersonalizadaModel { ListaSeccion = listaSeccion };

                return View(modelo);
            }
            catch (Exception ex)
            {
                LogManager.LogManager.LogErrorWebServicesBus(ex, userData.CodigoConsultora, userData.CodigoISO);
            }

            return RedirectToAction("Index", "Bienvenida");
        }

        [HttpPost]
        public JsonResult ObtenerSeccion(string codigo, int campaniaId)
        {
            try
            {
                var seccion = ObtenerSeccionHomePalanca(codigo, campaniaId);

                return Json(new
                {
                    seccion = seccion
                }, JsonRequestBehavior.AllowGet);
            }
            catch (Exception ex)
            {
                LogManager.LogManager.LogErrorWebServicesBus(ex, userData.CodigoConsultora, userData.CodigoISO);

                return Json(new ConfiguracionSeccionHomeModel());
            }
        }

        [HttpPost]
        public JsonResult GuardarMenuContenedor(string codigo, int campania)
        {
            Session[Constantes.SessionNames.MenuContenedorActivo] = new MenuContenedorModel {
                CampaniaID = campania,
                Codigo = codigo
            };

            return Json(new
            {
                success = true
            }, JsonRequestBehavior.AllowGet);
        }
    }
}