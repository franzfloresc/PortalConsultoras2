using Portal.Consultoras.Common;
using Portal.Consultoras.Web.Models;
using Portal.Consultoras.Web.ServicePedido;
using System.Collections.Generic;
using System;
using System.Web.Mvc;
using System.Linq;

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

        private MensajeProductoBloqueadoModel MensajeProductoBloqueado()
        {
            var model = new MensajeProductoBloqueadoModel();

            if (!revistaDigital.TieneRDC) return model;

            model.IsMobile = IsMobile();
            
            if (!revistaDigital.EsActiva)
            {
                if (revistaDigital.EsSuscrita)
                {
                    model.MensajeIconoSuperior = true;
                    model.MensajeTitulo = model.IsMobile
                        ? "PODRÁS AGREGARLA EN LA CAMPAÑA " + revistaDigital.CampaniaActiva
                        : "PODRÁS AGREGAR OFERTAS COMO ESTA EN LA CAMPAÑA " + revistaDigital.CampaniaActiva;
                    model.BtnInscribirse = false;
                }
                else
                {
                    model.MensajeIconoSuperior = false;
                    model.MensajeTitulo = model.IsMobile
                        ? "INSCRÍBETE HOY EN ÉSIKA PARA MÍ Y NO TE PIERDAS EN C-" + revistaDigital.CampaniaActiva + "<br />OFERTAS COMO ESTA"
                        : "INSCRÍBETE HOY EN ÉSIKA PARA MÍ Y NO TE PIERDAS EN CAMPAÑA " + revistaDigital.CampaniaActiva + " OFERTAS COMO ESTA";
                    model.BtnInscribirse = true;
                }
            }

            return model;
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