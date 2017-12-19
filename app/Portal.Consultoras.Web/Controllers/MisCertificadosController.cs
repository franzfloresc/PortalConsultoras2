﻿using Portal.Consultoras.Common;
using Portal.Consultoras.Web.Models;
using Portal.Consultoras.Web.Models.MisCertificados;
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
using AutoMapper;
using System.Globalization;
using System.Configuration;

namespace Portal.Consultoras.Web.Controllers
{
    public class MisCertificadosController : BaseController
    {
        public ActionResult Index()
        {
            var listaCertificados = new List<MiCertificadoModel>();

            try
            {
                if (!UsuarioModel.HasAcces(ViewBag.Permiso, "MisCertificados/Index"))
                    return RedirectToAction("Index", "Bienvenida");

                listaCertificados = sessionManager.GetMisCertificados() ?? new List<MiCertificadoModel>();

                if (!listaCertificados.Any())
                {
                    listaCertificados = ObtenerCertificados();
                    sessionManager.SetMisCertificados(listaCertificados);
                }
            }
            catch (Exception ex)
            {
                LogManager.LogManager.LogErrorWebServicesBus(ex, userData.CodigoConsultora, userData.CodigoISO);
            }

            return View(listaCertificados);
        }

        private List<MiCertificadoModel> ObtenerCertificados()
        {
            var listaCertificados = new List<MiCertificadoModel>();

            var certificadoNoAdeudo = ObtenerCertificadoNoAdeudo();
            listaCertificados.Add(certificadoNoAdeudo);

            var certificadoComercial = ObtenerCertificadoComercial();
            listaCertificados.Add(certificadoComercial);

            return listaCertificados;
        }

        #region Certificado Paz y Salvo / No Adeudo
        private MiCertificadoModel ObtenerCertificadoNoAdeudo()
        {
            var certificado = new MiCertificadoModel();

            var certificadoId = 0;
            var nombre = "";
            var mensajeError = "";

            //userData.MontoDeuda = 0;    // test

            switch (userData.PaisID)
            {
                case Constantes.PaisID.Colombia:
                    nombre = "Paz y Salvo";

                    if (userData.MontoDeuda > 0)
                    {
                        mensajeError = "Tu cuenta tiene saldo pendiente, no es posible expedir un Paz y Salvo";
                        break;
                    }

                    certificadoId = 1;
                    break;
                case Constantes.PaisID.Ecuador:
                    nombre = "No Adeudo";

                    if (userData.MontoDeuda > 0)
                    {
                        mensajeError = "Tu cuenta tiene saldo pendiente, no es posible expedir un No Adeudo";
                        break;
                    }

                    certificadoId = 1;
                    break;
                default:
                    certificado.Nombre = "";
                    break;
            }

            certificado.CertificadoId = certificadoId;
            certificado.Nombre = nombre;
            certificado.MensajeError = mensajeError;
            certificado.NombreVista = "~/Views/MisCertificados/NoAdeudoPdf.cshtml";

            return certificado;
        }

        #endregion

        #region Certificado Comercial

        private MiCertificadoModel ObtenerCertificadoComercial()
        {
            var certificado = new MiCertificadoModel();

            var certificadoId = 0;
            var nombre = "";
            var mensajeError = "";
            //const int cantidadCampaniaConsecutiva = 5;
            var cantidadCampaniaConsecutiva = ConfigurationManager.AppSettings["cantCampaniaConsecutivaCertComercial"] ?? "5";

            switch (userData.PaisID)
            {
                case Constantes.PaisID.Colombia:
                case Constantes.PaisID.Ecuador:
                    nombre = "Certificado Comercial";

                    bool tieneCampaniaConsecutivas = false;
                    using (PedidoServiceClient ps = new PedidoServiceClient())
                    {
                        tieneCampaniaConsecutivas = ps.TieneCampaniaConsecutivas(userData.PaisID, userData.CampaniaID, int.Parse(cantidadCampaniaConsecutiva), userData.ConsultoraID);
                    }

                    //tieneCampaniaConsecutivas = true;   // test
                    if (!tieneCampaniaConsecutivas)
                    {
                        mensajeError = "No has sido constante en las últimas " + cantidadCampaniaConsecutiva +
                            " campañas, no es posible expedir un certificado comercial.";
                        break;
                    }

                    certificadoId = 2;

                    break;
                default:
                    certificado.Nombre = "";
                    break;
            }

            certificado.CertificadoId = certificadoId;
            certificado.Nombre = nombre;
            certificado.MensajeError = mensajeError;
            certificado.NombreVista = "~/Views/MisCertificados/ComercialPdf.cshtml";

            return certificado;
        }

        #endregion

        [ValidateInput(false)]
        public FileResult Export(int id)
        {
            try
            {
                var model = ObtenerCertificadoById(id);

                if (model.CertificadoId != 0)
                {
                    var tmp = model;
                    var tipo = Convert.ToInt16(id);

                    var listaData = sessionManager.GetMisCertificadosData() ?? new List<BEMiCertificado>();
                    BEMiCertificado beMiCertificado = null;
                    var existsData = false;

                    if (listaData.Any())
                    {
                        foreach(var item in listaData)
                        {
                            if (item.TipoCert == tipo)
                            {
                                existsData = true;
                            }
                        }
                    }

                    if (!listaData.Any() || !existsData)
                    {
                        using (PedidoServiceClient svc = new PedidoServiceClient())
                        {
                            beMiCertificado = svc.ObtenerCertificadoDigital(userData.PaisID, userData.CampaniaID, userData.ConsultoraID, tipo);
                        }

                        if (beMiCertificado != null && beMiCertificado.Result == 1)
                        {
                            listaData.Add(beMiCertificado);
                            sessionManager.SetMisCertificadosData(listaData);
                            model = Mapper.Map<MiCertificadoModel>(beMiCertificado);
                        }
                    }
                    else
                    {
                        beMiCertificado = listaData.FirstOrDefault(x => x.TipoCert == tipo);
                        model = Mapper.Map<MiCertificadoModel>(beMiCertificado);
                    }

                    model.CertificadoId = tmp.CertificadoId;
                    model.Nombre = tmp.Nombre;
                    model.MensajeError = tmp.MensajeError;
                    model.NombreVista = tmp.NombreVista;

                    if (beMiCertificado != null)
                    {
                        var dt = DateTime.Now;
                        var nombreMes1 = dt.ToString("MMMM", new CultureInfo("es-ES"));
                        //var format = @"dd \de MMMM \de yyyy";
                        var letrasAnio = Conversores.NumeroALetras(dt.Year).ToLower();
                        var ff1 = dt.ToString("dd") + " de " + nombreMes1.ToUpper(1) + " de " + dt.ToString("yyyy");
                        var ff2 = dt.ToString("dd") + " del mes de " + nombreMes1.ToUpper(1) + " de " + letrasAnio + " (" + dt.Year.ToString() + ").";
                        var fi = beMiCertificado.FechaIngresoConsultora;
                        //var ff3 = beMiCertificado.FechaIngresoConsultora.ToString(format1, new CultureInfo("es-ES"));
                        var nombreMes2 = fi.ToString("MMMM", new CultureInfo("es-ES"));
                        var ff3 = fi.ToString("dd") + " de " + nombreMes2.ToUpper(1) + " de " + fi.ToString("yyyy");

                        model.FechaCreacion = ff1;
                        model.FechaCreacionTexto = ff2;
                        model.FechaIngresoConsultora = ff3;
                        model.Moneda = userData.Simbolo;
                        //model.UrlFirma = "";

                        model.CodigoIso = userData.CodigoISO;
                        model.CantidadConsecutivaNueva = ConfigurationManager.AppSettings["cantCampaniaConsecutivaCertComercial"] ?? "5";
                        var view = model.NombreVista;
                        

                        string html = RenderViewToString(ControllerContext,
                            view, model, true);

                        var nameFile = userData.CodigoISO + "_" + "Certificado_" + model.CertificadoId + ".pdf";

                        using (MemoryStream stream = new System.IO.MemoryStream())
                        {
                            StringReader sr = new StringReader(html);
                            Document pdfDoc = new Document(PageSize.A4, 50f, 50f, 70f, 0f);
                            PdfWriter writer = PdfWriter.GetInstance(pdfDoc, stream);
                            pdfDoc.Open();
                            XMLWorkerHelper.GetInstance().ParseXHtml(writer, pdfDoc, sr);
                            pdfDoc.Close();
                            return File(stream.ToArray(), "application/pdf", nameFile);
                        }
                    }
                }
            }
            catch (Exception ex)
            {
                LogManager.LogManager.LogErrorWebServicesBus(ex, userData.CodigoConsultora, userData.CodigoISO);
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

        private MiCertificadoModel ObtenerCertificadoById(int id)
        {
            var listaCertificados = sessionManager.GetMisCertificados() ?? new List<MiCertificadoModel>();

            var certificado = listaCertificados.FirstOrDefault(p => p.CertificadoId == id) ?? new MiCertificadoModel();

            return certificado;
        }
    }
}