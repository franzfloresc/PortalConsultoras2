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

                //BPT 236
                ViewBag.xlistaProductoSR = ((List<BEShowRoomOferta>)Session[Constantes.ConstSession.ListaProductoShowRoom]).
                                            Where(x => x.EsSubCampania == false).ToList().Count();
                

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

        public MensajeProductoBloqueadoModel MensajeProductoBloqueado()
        {
            var model = new MensajeProductoBloqueadoModel();

            if (!revistaDigital.TieneRDC) return model;

            model.IsMobile = IsMobile();
            if (revistaDigital.SuscripcionAnterior1Model.EstadoRegistro == Constantes.EstadoRDSuscripcion.Activo)
            {
                if (revistaDigital.SuscripcionModel.EstadoRegistro == Constantes.EstadoRDSuscripcion.Activo)
                {
                    model.MensajeIconoSuperior = true;
                    model.MensajeTitulo = model.IsMobile
                        ? "PODRÁS AGREGARLA EN LA PRÓXIMA CAMPAÑA"
                        : "PODRÁS AGREGAR ESTA OFERTA A PARTIR DE LA PRÓXIMA CAMPAÑA";
                    model.BtnInscribirse = false;
                }
                else
                {
                    model.MensajeIconoSuperior = false;
                    model.MensajeTitulo = model.IsMobile
                        ? "INSCRÍBETE HOY EN ÉSIKA PARA MÍ Y NO TE PIERDAS EN C-" + AddCampaniaAndNumero(userData.CampaniaID, 2).Substring(4, 2) + "<br />OFERTAS COMO ESTA"
                        : "INSCRÍBETE HOY EN ÉSIKA PARA MÍ Y NO TE PIERDAS EN CAMPAÑA " + AddCampaniaAndNumero(userData.CampaniaID, 2).Substring(4, 2) + " OFERTAS COMO ESTA";
                    model.BtnInscribirse = true;
                }
            }
            else
            {
                if (revistaDigital.SuscripcionModel.EstadoRegistro == Constantes.EstadoRDSuscripcion.Activo)
                {
                    model.MensajeIconoSuperior = true;
                    model.MensajeTitulo = model.IsMobile
                        ? "PODRÁS AGREGARLA EN LA CAMPAÑA " + AddCampaniaAndNumero(userData.CampaniaID, 2).Substring(4, 2)
                        : "PODRÁS AGREGAR OFERTAS COMO ESTA EN LA CAMPAÑA " + AddCampaniaAndNumero(userData.CampaniaID, 2).Substring(4, 2);
                    model.BtnInscribirse = false;
                }
                else
                {
                    model.MensajeIconoSuperior = false;
                    model.MensajeTitulo = model.IsMobile
                        ? "INSCRÍBETE HOY EN ÉSIKA PARA MÍ Y NO TE PIERDAS EN C-" + AddCampaniaAndNumero(userData.CampaniaID, 2).Substring(4, 2) + "<br />OFERTAS COMO ESTA"
                        : "INSCRÍBETE HOY EN ÉSIKA PARA MÍ Y NO TE PIERDAS EN CAMPAÑA " + AddCampaniaAndNumero(userData.CampaniaID, 2).Substring(4, 2) + " OFERTAS COMO ESTA";
                    model.BtnInscribirse = true;
                }
            }

            return model;
        }

        [HttpPost]
        public JsonResult ObtenerSeccion(string codigo, int campaniaId)
        {
            try
            {
                var seccion = ObtenerSeccionHomePalanca(codigo, campaniaId);

                return Json(new
                {
                    seccion = seccion
                }, JsonRequestBehavior.AllowGet);
            }
            catch (Exception ex)
            {
                LogManager.LogManager.LogErrorWebServicesBus(ex, userData.CodigoConsultora, userData.CodigoISO);

                return Json(new ConfiguracionSeccionHomeModel());
            }
        }

        [HttpPost]
        public JsonResult ActualiarSession(string codigo, int campaniaId)
        {
            try
            {
                if (campaniaId == userData.CampaniaID && codigo.Equals(Constantes.ConfiguracionPais.Lanzamiento))
                    Session[Constantes.ConstSession.TieneLan] = false;
                else if (campaniaId == userData.CampaniaID && codigo.Equals(Constantes.ConfiguracionPais.OfertasParaTi))
                    Session[Constantes.ConstSession.TieneOpt] = false;
                else if (campaniaId != userData.CampaniaID && codigo.Equals(Constantes.ConfiguracionPais.Lanzamiento))
                    Session[Constantes.ConstSession.TieneLanX1] = false;
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