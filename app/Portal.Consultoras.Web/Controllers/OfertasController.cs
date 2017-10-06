using Portal.Consultoras.Common;
using Portal.Consultoras.Web.Models;
using System;
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

            if (!userData.RevistaDigital.TieneRDC) return model;

            model.IsMobile = IsMobile();
            if (userData.RevistaDigital.SuscripcionAnterior1Model.EstadoRegistro == Constantes.EstadoRDSuscripcion.Activo)
            {
                if (userData.RevistaDigital.SuscripcionModel.EstadoRegistro == Constantes.EstadoRDSuscripcion.Activo)
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
                if (userData.RevistaDigital.SuscripcionModel.EstadoRegistro == Constantes.EstadoRDSuscripcion.Activo)
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
                if (campaniaId == userData.CampaniaID && codigo.Equals("LAN")) Session["TieneLan"] = false;
                else if (campaniaId == userData.CampaniaID && codigo.Equals("OPT")) Session["TieneOpt"] = false;
                else if (campaniaId != userData.CampaniaID && codigo.Equals("LAN")) Session["TieneLanX1"] = false;
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