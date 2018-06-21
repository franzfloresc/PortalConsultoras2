using AutoMapper;
using Portal.Consultoras.Common;
using Portal.Consultoras.Web.Controllers;
using Portal.Consultoras.Web.CustomFilters;
using Portal.Consultoras.Web.Infraestructure;
using Portal.Consultoras.Web.Models;
using System;
using System.Linq;
using System.ServiceModel;
using System.Web.Mvc;

namespace Portal.Consultoras.Web.Areas.Mobile.Controllers
{
    [UniqueSession("UniqueRoute", UniqueRoute.IdentifierKey, "/g/")]
    [ClearSessionMobileApp(UniqueRoute.IdentifierKey, "MobileAppConfiguracion", "StartSession")]
    public class RevistaDigitalController : BaseViewController
    {
        public ActionResult Index()
        {
            try
            {
                return RedirectToAction("Index", "Ofertas", new { area = "Mobile" });
            }
            catch (Exception ex)
            {
                LogManager.LogManager.LogErrorWebServicesBus(ex, userData.CodigoConsultora, userData.CodigoISO);
            }

            return RedirectToAction("Index", "Bienvenida", new { area = "Mobile" });
        }

        public ActionResult Detalle(string cuv, int campaniaId)
        {
            try
            {

                return RDDetalleModel(cuv, campaniaId);
            }
            catch (Exception ex)
            {
                LogManager.LogManager.LogErrorWebServicesBus(ex, userData.CodigoConsultora, userData.CodigoISO);
            }

            return RedirectToAction("Index", "Ofertas", new { area = "Mobile" });
        }

        public ActionResult Informacion(string tipo)
        {
            try
            {
                ViewBag.TipoLayout = tipo;
                return RDIndexModel();
            }
            catch (Exception ex)
            {
                LogManager.LogManager.LogErrorWebServicesBus(ex, userData.CodigoConsultora, userData.CodigoISO);
            }

            return RedirectToAction("Index", "Bienvenida");
        }

        public ActionResult Comprar()
        {
            try
            {
                return RDViewLanding(1);
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
                return RDViewLanding(2);
            }
            catch (Exception ex)
            {
                LogManager.LogManager.LogErrorWebServicesBus(ex, userData.CodigoConsultora, userData.CodigoISO);
            }

            return RedirectToAction("Index", "Bienvenida");
        }

        public ActionResult MensajeBloqueado()
        {
            try
            {
                return PartialView("template-mensaje-bloqueado", _ofertasViewProvider.MensajeProductoBloqueado(IsMobile()));
            }
            catch (Exception ex)
            {
                LogManager.LogManager.LogErrorWebServicesBus(ex, userData.CodigoConsultora, userData.CodigoISO);
            }
            return PartialView("template-mensaje-bloqueado", new MensajeProductoBloqueadoModel());
        }

        public ActionResult RDMensajeBloqueadoDetalle()
        {
            MensajeProductoBloqueadoModel modelo;
            try
            {
                modelo = _ofertasViewProvider.RDMensajeProductoBloqueado(IsMobile());
            }
            catch (Exception ex)
            {
                LogManager.LogManager.LogErrorWebServicesBus(ex, userData.CodigoConsultora, userData.CodigoISO);
                modelo = new MensajeProductoBloqueadoModel();
            }
            return PartialView("template-mensaje-bloqueado-Lan-Detalle", modelo);
        }

        //public virtual MensajeProductoBloqueadoModel RDMensajeProductoBloqueado()
        //{
        //    var model = new MensajeProductoBloqueadoModel();

        //    if (!revistaDigital.TieneRDC) return model;

        //    model.IsMobile = IsMobile();
        //    string codigo;

        //    if (revistaDigital.EsSuscrita)
        //    {
        //        model.MensajeIconoSuperior = true;
        //        codigo = model.IsMobile ? Constantes.ConfiguracionPaisDatos.RD.MPopupBloqueadoNoActivaSuscrita : Constantes.ConfiguracionPaisDatos.RD.DPopupBloqueadoNoActivaSuscrita;
        //        model.BtnInscribirse = false;
        //    }
        //    else
        //    {
        //        model.MensajeIconoSuperior = false;
        //        codigo = model.IsMobile ? Constantes.ConfiguracionPaisDatos.RD.MPopupBloqueadoNoActivaNoSuscrita : Constantes.ConfiguracionPaisDatos.RD.DPopupBloqueadoNoActivaNoSuscrita;
        //        model.BtnInscribirse = true;
        //    }

        //    var dato = revistaDigital.ConfiguracionPaisDatos.FirstOrDefault(d => d.Codigo == codigo);
        //    model.MensajeTitulo = dato == null ? "" : Util.Trim(dato.Valor1);

        //    return model;
        //}
        
    }
}