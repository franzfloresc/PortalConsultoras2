using Portal.Consultoras.Common;
using Portal.Consultoras.Web.Models;
using Portal.Consultoras.Web.Models.CertificadoComercial;
using Portal.Consultoras.Web.ServicePedido;
using System;
using System.Collections.Generic;
using System.Linq;
using System.ServiceModel;
using System.Web;
using System.Web.Mvc;

using System.IO;
using iTextSharp.text;
using iTextSharp.text.pdf;
using iTextSharp.tool.xml;
using iTextSharp.text.html.simpleparser;

namespace Portal.Consultoras.Web.Controllers
{
    public class CertificadoComercialController : BaseController
    {
        public ActionResult Index()
        {
            var listaCertificados = new List<CertificadoComercialModel>();

            try
            {
                if (!UsuarioModel.HasAcces(ViewBag.Permiso, "CertificadoComercial/Index"))
                    return RedirectToAction("Index", "Bienvenida");

                listaCertificados = ObtenerCertificados();                

                sessionManager.SetCertificadoComercial(listaCertificados);
            }
            catch (FaultException ex)
            {
                LogManager.LogManager.LogErrorWebServicesPortal(ex, userData.CodigoConsultora, userData.CodigoISO);
            }            

            return View(listaCertificados);
        }

        private List<CertificadoComercialModel> ObtenerCertificados()
        {
            var listaCertificados = new List<CertificadoComercialModel>();

            var certificadoNoAdeudo = ObtenerCertificadoNoAdeudo();
            listaCertificados.Add(certificadoNoAdeudo);

            var certificadoComercial = ObtenerCertificadoComercial();
            listaCertificados.Add(certificadoComercial);

            return listaCertificados;
        }

        #region Certificado Paz y Salvo / No Adeudo
        private CertificadoComercialModel ObtenerCertificadoNoAdeudo()
        {          
            var certificado = new CertificadoComercialModel();

            var certificadoComercialId = 99;
            var nombre = "";
            var mensajeError = "";

            switch (userData.PaisID)
            {
                case Constantes.PaisID.Colombia:
                    nombre = "Paz y Salvo";

                    if (userData.MontoDeuda > 0)
                    {
                        mensajeError = "Tu cuenta tiene saldo pendiente, no es posible expedir un Paz y Salvo";
                        break;
                    }

                    certificadoComercialId = 1;
                    break;
                case Constantes.PaisID.Ecuador:
                    nombre = "No Adeudo";

                    if (userData.MontoDeuda > 0)
                    {
                        mensajeError = "Tu cuenta tiene saldo pendiente, no es posible expedir un No Adeudo";
                        break;
                    }

                    certificadoComercialId = 1;                    
                    break;
                default:
                    certificado.Nombre = "";
                    break;
            }

            certificado.CertificadoComercialId = certificadoComercialId;
            certificado.Nombre = nombre;
            certificado.MensajeError = mensajeError;
            certificado.NombreVista = "~/Views/CertificadoComercial/NoAdeudoPDF.cshtml";

            return certificado;            
        }

        #endregion

        #region Certificado Comercial

        private CertificadoComercialModel ObtenerCertificadoComercial()
        {
            var certificado = new CertificadoComercialModel();

            var certificadoComercialId = 0;
            var nombre = "";
            var mensajeError = "";
            const int cantidadCampaniaConsecutiva = 3;

            switch (userData.PaisID)
            {
                case Constantes.PaisID.Colombia:
                case Constantes.PaisID.Ecuador:
                    nombre = "Certificación Comercial";

                    bool tieneCampaniaConsecutivas = false;
                    using (PedidoServiceClient ps = new PedidoServiceClient())
                    {
                        tieneCampaniaConsecutivas = ps.TieneCampaniaConsecutivas(userData.PaisID, userData.CampaniaID, cantidadCampaniaConsecutiva, userData.ConsultoraID);
                    }

                    if (!tieneCampaniaConsecutivas)
                    {
                        mensajeError = "No has sido constante en las últimas " + cantidadCampaniaConsecutiva +
                            " campañas, no es posible expedir un certificado comercial.";
                        break;
                    }

                    certificadoComercialId = 2;

                    break;
                default:
                    certificado.Nombre = "";
                    break;
            }

            certificado.CertificadoComercialId = certificadoComercialId;
            certificado.Nombre = nombre;
            certificado.MensajeError = mensajeError;
            certificado.NombreVista = "~/Views/CertificadoComercial/ComercialPDF.cshtml";

            return certificado;
        }

        #endregion

        [ValidateInput(false)]
        public FileResult Export(int id)
        {
            var model = ObtenerCertificadoById(id);

            if(model.CertificadoComercialId != 0)
            {
                var view = model.NombreVista;
            
                string html = RenderViewToString(ControllerContext,
                    view, model, true);

                using (MemoryStream stream = new System.IO.MemoryStream())
                {
                    StringReader sr = new StringReader(html);
                    Document pdfDoc = new Document(PageSize.A4, 10, 10, 100, 0);
                    PdfWriter writer = PdfWriter.GetInstance(pdfDoc, stream);
                    pdfDoc.Open();
                    XMLWorkerHelper.GetInstance().ParseXHtml(writer, pdfDoc, sr);
                    pdfDoc.Close();
                    return File(stream.ToArray(), "application/pdf", "Report" + model.CertificadoComercialId + ".pdf");
                }
            }

            return null;                       
        }

        private string RenderViewToString(ControllerContext context,
                                    string viewPath,
                                    object model = null,
                                    bool partial = false)
        {
            // first find the ViewEngine for this view
            ViewEngineResult viewEngineResult = null;
            if (partial)
                viewEngineResult = ViewEngines.Engines.FindPartialView(context, viewPath);
            else
                viewEngineResult = ViewEngines.Engines.FindView(context, viewPath, null);

            if (viewEngineResult == null)
                throw new FileNotFoundException("View cannot be found.");

            // get the view and attach the model to view data
            var view = viewEngineResult.View;
            context.Controller.ViewData.Model = model;

            string result = null;

            using (var sw = new StringWriter())
            {
                var ctx = new ViewContext(context, view,
                                            context.Controller.ViewData,
                                            context.Controller.TempData,
                                            sw);
                view.Render(ctx, sw);
                result = sw.ToString();
            }

            return result;
        }

        private CertificadoComercialModel ObtenerCertificadoById(int id)
        {            
            var listaCertificados = sessionManager.GetCertificadoComercial() ?? new List<CertificadoComercialModel>();

            var certificado = listaCertificados.FirstOrDefault(p => p.CertificadoComercialId == id) ?? new CertificadoComercialModel();

            return certificado;
        }
    }
}