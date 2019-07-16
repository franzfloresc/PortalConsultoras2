using AutoMapper;
using Portal.Consultoras.Common;
using Portal.Consultoras.Web.Models;
using Portal.Consultoras.Web.Providers;
using Portal.Consultoras.Web.ServiceSAC;
using System;
using System.Collections.Generic;
using System.Data;
using System.IO;
using System.Linq;
using System.ServiceModel;
using System.Web.Mvc;

namespace Portal.Consultoras.Web.Controllers
{
    public class ChatbotController : BaseAdmController
    {
        protected TablaLogicaProvider _tablaLogica;
        public ChatbotController()
        {
            _tablaLogica = new TablaLogicaProvider();
        }

        public ActionResult Index()
        {
            
            return View(model);

        }


    }
}