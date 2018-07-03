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
            if (!userData.TienePagoEnLinea)
                return RedirectToAction("Index", "Bienvenida", new { area = "Mobile" });

            sessionManager.SetDatosPagoVisa(null);

            var model = ObtenerValoresPagoEnLinea();

            return View(model);
        }
        
        public ActionResult MetodoPago()
        {
            var model = sessionManager.GetDatosPagoVisa();

            if (model == null)
                return RedirectToAction("Index", "PagoEnLinea", new { area = "Mobile" });

            model.ListaMetodoPago = ObtenerListaMetodoPago();

            if (model.ListaMetodoPago.Count > 0)
            {
                var metodoPagoPasarelaVisa = model.ListaMetodoPago.FirstOrDefault(p => p.TipoPasarelaCodigoPlataforma == Constantes.PagoEnLineaMetodoPago.PasarelaVisa);

                if (metodoPagoPasarelaVisa != null)
                    model.PagoVisaModel = ObtenerValoresPagoVisa(model);
                else
                    model.PagoVisaModel = new PagoVisaModel();
            }


            return View(model);
        }

        public ActionResult PasarelaPago()
        {
            var model = sessionManager.GetDatosPagoVisa();

            //Logica para Obtener Valores de la PasarelaBelcorp

            return View(model);
        }

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
                    ViewBag.UrlCondiciones = GetMenuLinkByDescription(Constantes.ConfiguracionManager.MenuCondicionesDescripcion);

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