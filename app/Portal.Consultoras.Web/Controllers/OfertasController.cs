﻿using Portal.Consultoras.Common;
using Portal.Consultoras.Web.Models;
using Portal.Consultoras.Web.ServicePedido;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web.Mvc;

namespace Portal.Consultoras.Web.Controllers
{
    public class OfertasController : BaseController
    {
        public ActionResult Index()
        {
            try
            {
                var modelo = new EstrategiaPersonalizadaModel
                {
                    ListaSeccion = ObtenerConfiguracionSeccion(),
                    MensajeProductoBloqueado = MensajeProductoBloqueado()
                };
                
                ViewBag.IconoLLuvia = ObtenerValorPersonalizacionShowRoom(Constantes.ShowRoomPersonalizacion.Desktop.IconoLluvia, Constantes.ShowRoomPersonalizacion.TipoAplicacion.Desktop);

                var listaShowRoom = (List<BEShowRoomOferta>)Session[Constantes.ConstSession.ListaProductoShowRoom] ?? new List<BEShowRoomOferta>();
                ViewBag.xlistaProductoSR = listaShowRoom.Count(x => !x.EsSubCampania);
                
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
                var modelo = new EstrategiaPersonalizadaModel
                {
                    ListaSeccion = ObtenerConfiguracionSeccion(),
                    MensajeProductoBloqueado = MensajeProductoBloqueado()
                };

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
                    sessionManager.SetTieneLan(false);
                else if (campaniaId != userData.CampaniaID && codigo.Equals(Constantes.ConfiguracionPais.Lanzamiento))
                    sessionManager.SetTieneLanX1(false);
                else if (campaniaId == userData.CampaniaID && codigo.Equals(Constantes.ConfiguracionPais.OfertasParaTi))
                    sessionManager.SetTieneOpt(false);
                else if (campaniaId == userData.CampaniaID && codigo.Equals(Constantes.ConfiguracionPais.RevistaDigital))
                    sessionManager.SetTieneOpm(false);
                else if (campaniaId != userData.CampaniaID && codigo.Equals(Constantes.ConfiguracionPais.RevistaDigital))
                    sessionManager.SetTieneOpmX1(false);
                else if (campaniaId == userData.CampaniaID && codigo.Equals(Constantes.ConfiguracionPais.RevistaDigitalReducida))
                    sessionManager.SetTieneRdr(false);
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