﻿using Portal.Consultoras.Web.Models;
using System;
using System.Collections.Generic;
using System.Linq;
using System.ServiceModel;
using System.Web;
using System.Web.Mvc;

namespace Portal.Consultoras.Web.Controllers
{
    public class CaminoBrillanteAdministrarController: BaseAdmController
    {
        public ActionResult AdministrarBeneficios(TipoEstrategiaModel model)
        {
            try
            {
                //if (!UsuarioModel.HasAcces(ViewBag.Permiso, "AdministrarTipoEstrategia/Index"))
                //    return RedirectToAction("Index", "Bienvenida");

                model.listaPaises = DropDowListPaises();
            }
            catch (FaultException ex)
            {
                LogManager.LogManager.LogErrorWebServicesPortal(ex, userData.CodigoConsultora, userData.CodigoISO);
            }
            return View(model);
            //return View();
        }
    }
}