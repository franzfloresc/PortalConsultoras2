using ClosedXML.Excel;
using Portal.Consultoras.Common;
using Portal.Consultoras.Web.Models;
using Portal.Consultoras.Web.ServiceSAC;
using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Reflection;
using System.ServiceModel;
using System.Threading.Tasks;
using System.Web;
using System.Web.Mvc;

namespace Portal.Consultoras.Web.Controllers
{
    public class ReporteEncuestaSatisfaccionController : BaseAdmController
    {
        // GET: EncuestaSatisfaccion
        public ActionResult Index()
        {
            int paisId = userData.PaisID;
            try
            {
                if (!UsuarioModel.HasAcces(ViewBag.Permiso, "ReporteEncuestaSatisfaccionController/Index"))
                    return RedirectToAction("Index", "Bienvenida");


            }
            catch (FaultException ex)
            {
                LogManager.LogManager.LogErrorWebServicesPortal(ex, userData.CodigoConsultora, userData.CodigoISO);
            }


            var model = new ReporteEncuestaSatisfaccionModel()
            {
                listaCampanias = _zonificacionProvider.GetCampanias(paisId),
                listaPaises = DropDowListPaises(),
                listaRegiones = _zonificacionProvider.GetRegiones(paisId),
                listaZonas = _zonificacionProvider.GetZonas(paisId),
                PaisID = paisId


            };
            return View(model);
        }




    }
}