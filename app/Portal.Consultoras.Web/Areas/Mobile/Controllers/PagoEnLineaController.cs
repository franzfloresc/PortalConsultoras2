using Portal.Consultoras.Common;
using Portal.Consultoras.Web.Models;
using System;
using System.Linq;
using System.Web.Mvc;
using Portal.Consultoras.Web.Models.PagoEnLinea;
using System.ServiceModel;
using System.Text;
using Portal.Consultoras.Common.PagoEnLinea;
using System.Net;
using System.IO;
using System.Web;
using Portal.Consultoras.Web.ServicePedido;

namespace Portal.Consultoras.Web.Areas.Mobile.Controllers
{
    public class PagoEnLineaController : BaseMobileController
    {

        public ActionResult Index()
        {
            sessionManager.SetDatosPagoVisa(null);

            var model = ObtenerValoresPagoEnLinea();

            return View(model);
        }

        public ActionResult SeleccionTipoPago()
        {
            return View();
        }

        public ActionResult ConfirmacionPago()
        {
            return View();
        }

        //public ActionResult PagoExitoso()
        //{
        //    return View();
        //}

        public ActionResult PagoRechazado()
        {
            return View();
        }


        //public JsonResult GuardarDatosPago(PagoEnLineaModel model)
        //{
        //    model.CodigoIso = userData.CodigoISO;
        //    model.Simbolo = userData.Simbolo;

        //    sessionManager.SetDatosPagoVisa(model);

        //    return Json(new
        //    {
        //        success = true,
        //        message = "OK"
        //    });
        //}

        public ActionResult PagoVisa()
        {
            var model = sessionManager.GetDatosPagoVisa();

            if (model == null)
                return RedirectToAction("Index", "PagoEnLinea", new { area = "Mobile" });

            model.PagoVisaModel = ObtenerValoresPagoVisa(model);

            sessionManager.SetDatosPagoVisa(model);

            return View(model);
        }

        public ActionResult PagoVisaResultado()
        {
            var model = sessionManager.GetDatosPagoVisa();

            if (model == null)
                return RedirectToAction("Index", "PagoEnLinea", new { area = "Mobile" });

            try
            {
                string transactionToken = Request.Form["transactionToken"];
                bool pagoOk = ProcesarPagoVisa(ref model, transactionToken);

                if (pagoOk)
                {
                    return View("PagoExitoso", model);
                }
                else
                {
                    return View("PagoRechazado", model);
                }
            }
            catch (Exception ex)
            {
                LogManager.LogManager.LogErrorWebServicesBus(ex, (userData ?? new UsuarioModel()).CodigoConsultora, (userData ?? new UsuarioModel()).CodigoISO);
            }

            return View("PagoRechazado", model);
        }
    }
}