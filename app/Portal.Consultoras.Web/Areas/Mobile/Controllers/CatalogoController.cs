﻿using Portal.Consultoras.Common;
using Portal.Consultoras.Web.Models;
using Portal.Consultoras.Web.ServiceCliente;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Net;
using System.ServiceModel;
using System.Web.Mvc;
using System.Web.Script.Serialization;

namespace Portal.Consultoras.Web.Areas.Mobile.Controllers
{
    public class CatalogoController : BaseMobileController
    {
        private const string TextoMensajeSaludoCorreo = "Revisa los catálogos de esta campaña y comunícate conmigo si estás interesada en algunos de los productos.";

        public ActionResult Index()
        {
            var clienteModel = new MisCatalogosRevistasModel();
            clienteModel.PaisNombre = getPaisNombreByISO(userData.CodigoISO);
            clienteModel.CampaniaActual = userData.CampaniaID.ToString();
            clienteModel.CampaniaAnterior = AddCampaniaAndNumero(userData.CampaniaID, -1).ToString();
            clienteModel.CampaniaSiguiente = AddCampaniaAndNumero(userData.CampaniaID, 1).ToString();
            clienteModel.CodigoRevistaActual = GetRevistaCodigoIssuu(clienteModel.CampaniaActual);
            clienteModel.CodigoRevistaAnterior = GetRevistaCodigoIssuu(clienteModel.CampaniaAnterior);
            clienteModel.CodigoRevistaSiguiente = GetRevistaCodigoIssuu(clienteModel.CampaniaSiguiente);

            var tieneGND = userData.TieneGND;
            clienteModel.TieneGND = tieneGND;
            clienteModel.MostrarTab = 
                (revistaDigital.TieneRDC || revistaDigital.TieneRDR) && revistaDigital.EsSuscritaInactiva() && !tieneGND ||
                ((revistaDigital.TieneRDC || revistaDigital.TieneRDR) && revistaDigital.EsNoSuscritaInactiva() && !tieneGND) ||
                ((revistaDigital.TieneRDC || revistaDigital.TieneRDR) && revistaDigital.EsNoSuscritaActiva() && !tieneGND) ||
                (!revistaDigital.TieneRDC && !revistaDigital.TieneRDR && !tieneGND) ||
                ((revistaDigital.TieneRDC || revistaDigital.TieneRDR) && revistaDigital.EsSuscritaActiva() && !tieneGND) ||
                (revistaDigital.TieneRDR && !tieneGND);

            clienteModel.MostrarRevistaDigital = (revistaDigital.TieneRDC || revistaDigital.TieneRDR) && revistaDigital.EsSuscritaInactiva() && !tieneGND ||
                ((revistaDigital.TieneRDC || revistaDigital.TieneRDR) && revistaDigital.EsNoSuscritaInactiva() && !tieneGND) ||
                (!revistaDigital.TieneRDC && !revistaDigital.TieneRDR && !tieneGND) ||
                (revistaDigital.TieneRDR && !tieneGND);
            
            clienteModel.PartialSectionBpt = GetPartialSectionBptModel();

            ViewBag.CodigoISO = userData.CodigoISO;
            ViewBag.EsConsultoraNueva = EsConsultoraNueva();
            ViewBag.TextoMensajeSaludoCorreo = TextoMensajeSaludoCorreo;
            ViewBag.NombreConsultora = userData.Sobrenombre;

            string PaisesCatalogoWhatsUp = GetConfiguracionManager(Constantes.ConfiguracionManager.PaisesCatalogoWhatsUp);
            ViewBag.ActivacionAppCatalogoWhastUp = PaisesCatalogoWhatsUp.Contains(userData.CodigoISO) ? 1 : 0;

            var paisesEsika = GetConfiguracionManager(Constantes.ConfiguracionManager.PaisesEsika).ToLower();
            ViewBag.EsPaisEsika = paisesEsika.Contains(userData.CodigoISO.ToLower());

            return View(clienteModel);
        }

        public ActionResult EnterateMas()
        {
            return View("EnterateMas");
        }

        public JsonResult AutocompleteCorreo()
        {
            var term = (Request["term"] ?? "").ToString();
            List<BECliente> lista = new List<BECliente>();
            lista = (List<BECliente>)Session[Constantes.ConstSession.ClientesByConsultora] ?? new List<BECliente>();
            if (!lista.Any())
            {
                using (ClienteServiceClient sv = new ClienteServiceClient())
                {
                    lista = sv.SelectByConsultora(userData.PaisID, userData.ConsultoraID).ToList();
                }
                lista.Update(c => { c.Nombre = c.Nombre.Trim(); c.eMail = c.eMail.Trim(); });
                Session[Constantes.ConstSession.ClientesByConsultora] = lista;
            }
            lista = lista.Where(c => c.eMail.Contains(term)).ToList();

            var data = lista.Select(c =>
                new
                {
                    value = c.eMail,
                    label = c.eMail,
                    email = c.eMail,
                    nombre = c.Nombre,
                    clienteID = c.ClienteID,
                });

            return Json(data, JsonRequestBehavior.AllowGet);
        }

        [HttpPost]
        public JsonResult ObtenerPortadaRevista(string codigoRevista)
        {
            var url = string.Empty;
            var urlNotFound = Url.Content("~/Content/Images/revista_no_disponible.jpg");

            try
            {
                string stringIssuuRevista = GetStringIssuRevista(codigoRevista);
                dynamic item = new JavaScriptSerializer().Deserialize<object>(stringIssuuRevista);
                url = item["thumbnail_url"];
            }
            catch (FaultException faulException)
            {
                LogManager.LogManager.LogErrorWebServicesPortal(faulException, userData.CodigoConsultora, userData.CodigoISO + " - " + "ObtenerPortadaRevista");
                url = urlNotFound;
            }
            catch (Exception ex)
            {
                LogManager.LogManager.LogErrorWebServicesBus(ex, userData.CodigoConsultora, userData.CodigoISO + " - " + "ObtenerPortadaRevista");
                url = urlNotFound;
            }

            return Json(url);
        }

        private string GetStringIssuRevista(string codigoRevista)
        {
            var stringIssuuRevista = string.Empty;
            using (var client = new WebClient())
            {
                var urlIssuuRevista = string.Format("https://issuu.com/oembed?url=https://issuu.com/somosbelcorp/docs/{0}", codigoRevista);
                stringIssuuRevista = client.DownloadString(urlIssuuRevista);
            }

            return stringIssuuRevista;
        }

        public ActionResult MiRevista(string campaniaRevista)
        {
            ViewBag.Campania = campaniaRevista;
            return View();
        }
        
        private PartialSectionBpt GetPartialSectionBptModel()
        {
            var partial = new PartialSectionBpt();
            try
            {
                partial.RevistaDigital = revistaDigital;

                if (revistaDigital.TieneRDC)
                {
                    if (revistaDigital.EsActiva)
                    {
                        if (revistaDigital.EsSuscrita)
                        {
                            partial.ConfiguracionPaisDatos = revistaDigital.ConfiguracionPaisDatos.FirstOrDefault(x => x.Codigo == Constantes.ConfiguracionPaisDatos.RD.MCatalogoInscritaActiva) ?? new ConfiguracionPaisDatosModel();
                        }
                        else
                        {
                            partial.ConfiguracionPaisDatos = revistaDigital.ConfiguracionPaisDatos.FirstOrDefault(x => x.Codigo == Constantes.ConfiguracionPaisDatos.RD.MCatalogoNoInscritaActiva) ?? new ConfiguracionPaisDatosModel();
                        }
                    }
                    else
                    {
                        if (revistaDigital.EsSuscrita)
                        {
                            partial.ConfiguracionPaisDatos = revistaDigital.ConfiguracionPaisDatos.FirstOrDefault(x => x.Codigo == Constantes.ConfiguracionPaisDatos.RD.MCatalogoInscritaNoActiva) ?? new ConfiguracionPaisDatosModel();
                        }
                        else
                        {
                            partial.ConfiguracionPaisDatos = revistaDigital.ConfiguracionPaisDatos.FirstOrDefault(x => x.Codigo == Constantes.ConfiguracionPaisDatos.RD.MCatalogoNoInscritaNoActiva) ?? new ConfiguracionPaisDatosModel();
                        }
                    }
                }
                else if (revistaDigital.TieneRDR)
                {
                    partial.ConfiguracionPaisDatos = revistaDigital.ConfiguracionPaisDatos.FirstOrDefault(x => x.Codigo == Constantes.ConfiguracionPaisDatos.RDR.MCatalogoRdr) ?? new ConfiguracionPaisDatosModel();
                }
            }
            catch (Exception ex)
            {
                LogManager.LogManager.LogErrorWebServicesBus(ex, (userData ?? new UsuarioModel()).CodigoConsultora, (userData ?? new UsuarioModel()).CodigoISO);
            }

            return partial;
        }
    }
}