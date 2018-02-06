﻿using Portal.Consultoras.Web.Models;
using Portal.Consultoras.Web.ServiceSAC;
using System;
using System.Collections.Generic;
using System.Linq;
using System.ServiceModel;
using System.Web.Mvc;

namespace Portal.Consultoras.Web.Areas.Mobile.Controllers
{
    public class ProductosAgotadosController : BaseMobileController
    {
        private const int numeroFilas = 10;

        public ActionResult Index()
        {
            var userData = UserData();
            var model = new PedidoDetalleModel();
            try
            {
                var lstProductoFaltante = this.GetProductosFaltantes();
                Session["ListaProductoFaltantes"] = lstProductoFaltante;
                model.ListaProductoFaltante = lstProductoFaltante.Take(numeroFilas).ToList();
            }
            catch (FaultException ex)
            {
                LogManager.LogManager.LogErrorWebServicesPortal(ex, userData.CodigoConsultora, userData.CodigoISO);
            }
            catch (Exception ex)
            {
                LogManager.LogManager.LogErrorWebServicesBus(ex, userData.CodigoConsultora, userData.CodigoISO);
            }

            return View(model);
        }

        [HttpPost]
        public JsonResult MostrarMas(int Cantidad)
        {
            try
            {
                var lstProductoFaltante = Session["ListaProductoFaltantes"] as List<BEProductoFaltante>;

                if (lstProductoFaltante != null)
                    return Json(new
                    {
                        success = true,
                        lista = lstProductoFaltante.Skip(Cantidad).Take(numeroFilas).ToList(),
                        total = lstProductoFaltante.Count
                    });

                return Json(new
                {
                    success = false,
                    lista = "",
                    total = 0
                });
            }
            catch (Exception ex)
            {
                LogManager.LogManager.LogErrorWebServicesBus(ex, userData.CodigoConsultora, userData.CodigoISO);
                return Json(new
                {
                    success = false,
                    lista = "",
                    total = 0
                });
            }
        }
    }
}