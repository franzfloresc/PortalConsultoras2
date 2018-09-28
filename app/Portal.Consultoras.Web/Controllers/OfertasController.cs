﻿using Portal.Consultoras.Common;
using Portal.Consultoras.Web.Models;
using Portal.Consultoras.Web.Providers;
using System;
using System.Web.Mvc;

namespace Portal.Consultoras.Web.Controllers
{
    public class OfertasController : BaseController
    {
        protected ConfiguracionOfertasHomeProvider _confiOfertasHomeProvider;

        public OfertasController()
        {
            _confiOfertasHomeProvider = new ConfiguracionOfertasHomeProvider();
        }

        public ActionResult Index()
        {
            string sap = "";
            var url = (Request.Url.Query).Split('?');

            if (EsDispositivoMovil())
            {
                //return RedirectToAction("Index", "Ofertas", new { area = "Mobile" });
                if (url.Length > 1)
                {
                    sap = "&" + url[1];
                    return RedirectToAction("Index", "Ofertas", new { area = "Mobile", sap });
                }
                else
                {
                    return RedirectToAction("Index", "Ofertas", new { area = "Mobile" });
                }


            }

            try
            {
                var modelo = new EstrategiaPersonalizadaModel
                {
                    ListaSeccion = _confiOfertasHomeProvider.ObtenerConfiguracionSeccion(revistaDigital, IsMobile()),
                    MensajeProductoBloqueado = _ofertasViewProvider.MensajeProductoBloqueado(IsMobile())
                };

                ViewBag.IconoLLuvia = _showRoomProvider.ObtenerValorPersonalizacionShowRoom(Constantes.ShowRoomPersonalizacion.Desktop.IconoLluvia, Constantes.ShowRoomPersonalizacion.TipoAplicacion.Desktop);
                
                ViewBag.variableEstrategia = GetVariableEstrategia();

                return View(modelo);
            }
            catch (Exception ex)
            {
                LogManager.LogManager.LogErrorWebServicesBus(ex, userData.CodigoConsultora, userData.CodigoISO);
            }

            return RedirectToAction("Index", "Bienvenida");
        }

        public ActionResult Revisar()
        {
            try
            {
                bool esMobile = IsMobile();
                var modelo = new EstrategiaPersonalizadaModel
                {
                    ListaSeccion = _confiOfertasHomeProvider.ObtenerConfiguracionSeccion(revistaDigital, esMobile),
                    MensajeProductoBloqueado = _ofertasViewProvider.MensajeProductoBloqueado(esMobile),
                    MensajeProductoBloqueado2 = _ofertasViewProvider.HVMensajeProductoBloqueado(herramientasVenta, esMobile)

                };

                ViewBag.variableEstrategia = GetVariableEstrategia();

                return View("Index", modelo);
            }
            catch (Exception ex)
            {
                LogManager.LogManager.LogErrorWebServicesBus(ex, userData.CodigoConsultora, userData.CodigoISO);
            }

            return RedirectToAction("Index", "Bienvenida");
        }

        [HttpPost]
        public JsonResult ActualizarSession(string codigo, int campaniaId)
        {
            try
            {
                if (campaniaId == userData.CampaniaID && codigo.Equals(Constantes.ConfiguracionPais.Lanzamiento))
                    SessionManager.SetTieneLan(false);
                else if (campaniaId != userData.CampaniaID && codigo.Equals(Constantes.ConfiguracionPais.Lanzamiento))
                    SessionManager.SetTieneLanX1(false);
                else if (campaniaId == userData.CampaniaID && codigo.Equals(Constantes.ConfiguracionPais.OfertasParaTi))
                    SessionManager.SetTieneOpt(false);
                else if (campaniaId == userData.CampaniaID && codigo.Equals(Constantes.ConfiguracionPais.RevistaDigital))
                    SessionManager.SetTieneOpm(false);
                else if (campaniaId != userData.CampaniaID && codigo.Equals(Constantes.ConfiguracionPais.RevistaDigital))
                    SessionManager.SetTieneOpmX1(false);
                else if (campaniaId == userData.CampaniaID && codigo.Equals(Constantes.ConfiguracionPais.HerramientasVenta))
                    SessionManager.SetTieneHv(false);
                else if (campaniaId != userData.CampaniaID && codigo.Equals(Constantes.ConfiguracionPais.HerramientasVenta))
                    SessionManager.SetTieneHvX1(false);

                return Json(new
                {
                    estado = "Ok"
                }, JsonRequestBehavior.AllowGet);
            }
            catch (Exception ex)
            {
                LogManager.LogManager.LogErrorWebServicesBus(ex, userData.CodigoConsultora, userData.CodigoISO);

                return Json(new
                {
                    estado = ex.Message
                }, JsonRequestBehavior.AllowGet);
            }
        }
    }
}