﻿using System.Web.Mvc;
using Portal.Consultoras.Web.Models.Layout;

namespace Portal.Consultoras.Web.Controllers
{
    public class ProgramaNuevasController : BaseViewController
    {
        // GET: ProgramaNuevas
        public ActionResult Index()
        {
            ViewBag.variableEstrategia = GetEstrategiaHabilitado();
            var model = GetLandingModel(1);

            return View(model);
        }
    }
}