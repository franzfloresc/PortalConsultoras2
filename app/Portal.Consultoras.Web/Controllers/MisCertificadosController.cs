﻿using AutoMapper;
using iTextSharp.text;
using iTextSharp.text.pdf;
using iTextSharp.tool.xml;
using Portal.Consultoras.Common;
using Portal.Consultoras.Web.Models;
using Portal.Consultoras.Web.Models.MisCertificados;
using Portal.Consultoras.Web.ServicePedido;
using Portal.Consultoras.Web.ServiceSAC;
using System;
using System.Collections.Generic;
using System.Configuration;
using System.Globalization;
using System.IO;
using System.Linq;
using System.Web.Mvc;

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

                ViewBag.PaisUser = userData.PaisID;
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
            if (certificadoNoAdeudo != null)
            {
                listaCertificados.Add(certificadoNoAdeudo);
            }

            var certificadoComercial = ObtenerCertificadoComercial();
            if (certificadoComercial != null)
            {
                listaCertificados.Add(certificadoComercial);
            }

            var certificadoTributario = ObtenerCertificadoTributario();
            if (certificadoTributario != null)
            {
                listaCertificados.Add(certificadoTributario);
            }

            return listaCertificados;
        }

        #region Certificado Paz y Salvo / No Adeudo
        private MiCertificadoModel ObtenerCertificadoNoAdeudo()
        {
            var certificado = new MiCertificadoModel();

            var certificadoId = 0;
            var nombre = "";
            var mensajeError = "";

            switch (userData.PaisID)
            {
                case Constantes.PaisID.Colombia:
                    nombre = "Paz y Salvo";

                    if (userData.MontoDeuda > 0)
                    {
                        mensajeError = "Tu cuenta tiene saldo pendiente, no es posible expedir un certficado de Paz y Salvo";
                        break;
                    }

                    certificadoId = 1;
                    break;
                case Constantes.PaisID.Ecuador:
                case Constantes.PaisID.Peru:
                    nombre = (userData.PaisID == Constantes.PaisID.Peru) ? "Constancia No Adeudo" : "No Adeudo";

                    if (userData.MontoDeuda > 0)
                    {
                        mensajeError = "Tu cuenta tiene saldo pendiente, no es posible expedir un certificado de No Adeudo";
                        break;
                    }

                    certificadoId = 1;
                    break;
                default:
                    nombre = "";
                    break;
            }

            if (nombre == "") return certificado;

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
            var cantidadCampaniaConsecutiva = "";// ConfigurationManager.AppSettings["cantCampaniaConsecutivaCertComercial"] ?? "5";

            short codigoTablaLogica = 140;
            var CampaniaConsecutiva = new List<BETablaLogicaDatos>();
            using (var tablaLogica = new SACServiceClient())
            {
                CampaniaConsecutiva = tablaLogica.GetTablaLogicaDatos(userData.PaisID, codigoTablaLogica).ToList();
                cantidadCampaniaConsecutiva = CampaniaConsecutiva[0].Valor;
            }

            switch (userData.PaisID)
            {
                case Constantes.PaisID.Colombia:
                case Constantes.PaisID.Ecuador:
                case Constantes.PaisID.Peru:

                    bool tieneCampaniaConsecutivas;
                    using (PedidoServiceClient ps = new PedidoServiceClient())
                    {
                        tieneCampaniaConsecutivas = ps.TieneCampaniaConsecutivas(userData.PaisID, userData.CampaniaID, int.Parse(cantidadCampaniaConsecutiva), userData.ConsultoraID);
                    }

                    nombre = "Certificado Comercial";

                    if (!tieneCampaniaConsecutivas)
                    {
                        mensajeError = "No has sido constante en las últimas " + cantidadCampaniaConsecutiva +
                            " campañas, no es posible expedir un certificado comercial.";
                        break;
                    }

                    certificadoId = 2;

                    break;
                default:
                    nombre = "";
                    break;
            }

            if (nombre == "") return certificado;

            certificado.CertificadoId = certificadoId;
            certificado.Nombre = nombre;
            certificado.MensajeError = mensajeError;
            certificado.NombreVista = "~/Views/MisCertificados/ComercialPdf.cshtml";
            return certificado;
        }

        #endregion

        #region Certificado Tributario
        private MiCertificadoModel ObtenerCertificadoTributario()
        {
            var certificado = new MiCertificadoModel();

            switch (userData.PaisID)
            {
                case Constantes.PaisID.Colombia:
                    certificado.Nombre = "Certificados Tributarios";

                    if (userData.TotalCompraCer == 0)
                    {
                        certificado.MensajeError = "No tienes venta registrada con nosotros en el año gravable anterior, no es posible expedir un certificado tributario.";
                        break;
                    }

                    certificado.CertificadoId = 3;
                    certificado.NombreVista = "~/Views/MisCertificados/TributarioPdf.cshtml";
                    break;
                default:
                    certificado = null;
                    break;
            }
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
                    BEMiCertificado beMiCertificado;
                    var existsData = false;

                    if (listaData.Any())
                    {
                        foreach (var item in listaData)
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
                        var letrasAnio = Conversores.NumeroALetras(dt.Year).ToLower();
                        var ff1 = dt.ToString("dd") + " de " + nombreMes1.ToUpper(1) + " de " + dt.ToString("yyyy");
                        var ff2 = dt.ToString("dd") + " del mes de " + nombreMes1.ToUpper(1) + " de " + letrasAnio + " (" + dt.Year.ToString() + ").";
                        var fi = beMiCertificado.FechaIngresoConsultora;
                        var nombreMes2 = fi.ToString("MMMM", new CultureInfo("es-ES"));
                        var ff3 = fi.ToString("dd") + " de " + nombreMes2.ToUpper(1) + " de " + fi.ToString("yyyy");

                        model.FechaCreacion = ff1;
                        model.FechaCreacionTexto = ff2;
                        model.FechaIngresoConsultora = ff3;
                        model.Moneda = userData.Simbolo;

                        model.Anio = (dt.Year - 1).ToString();

                        model.CompraVDirecta = Math.Round(userData.CompraVDirectaCer, 2).ToString();
                        model.IVACompraVDirecta = Math.Round(userData.IVACompraVDirectaCer, 2).ToString();
                        model.Retail = Math.Round(userData.RetailCer, 2).ToString();
                        model.IVARetail = Math.Round(userData.IVARetailCer, 2).ToString();
                        model.TotalCompra = Math.Round(userData.TotalCompraCer, 2).ToString();
                        model.IvaTotal = Math.Round(userData.IvaTotalCer, 2).ToString();

                        switch (userData.PaisID)
                        {
                            case Constantes.PaisID.Peru:
                                model.Pais = "Peru";
                                break;
                            default:
                                model.Pais = "";
                                break;
                        }

                        model.CodigoIso = userData.CodigoISO;

                        short codigoTablaLogica = 140;
                        var CampaniaConsecutiva = new List<BETablaLogicaDatos>();
                        using (var tablaLogica = new SACServiceClient())
                        {
                            CampaniaConsecutiva = tablaLogica.GetTablaLogicaDatos(userData.PaisID, codigoTablaLogica).ToList();
                            model.CantidadConsecutivaNueva = CampaniaConsecutiva[0].Valor;
                        }

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
            var viewEngineResult = partial
                ? ViewEngines.Engines.FindPartialView(context, viewPath)
                : ViewEngines.Engines.FindView(context, viewPath, null);

            if (viewEngineResult == null)
                throw new FileNotFoundException("View cannot be found.");

            // get the view and attach the model to view data
            var view = viewEngineResult.View;
            context.Controller.ViewData.Model = model;

            string result;

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