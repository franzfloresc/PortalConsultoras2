using Portal.Consultoras.Common;
using Portal.Consultoras.Web.Controllers;
using Portal.Consultoras.Web.Models;
using System;
using System.Collections.Generic;
using System.Configuration;
using System.Linq;
using System.Web.Mvc;
using Portal.Consultoras.Web.ServicePedido;

namespace Portal.Consultoras.Web.Areas.Mobile.Controllers
{
    public class RevistaDigitalController : BaseRevistaDigitalController
    {
        public ActionResult Index()
        {
            try
            {
                ViewBag.EsMobile = 2;
                return IndexModel();
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
                ViewBag.EsMobile = 2;
                var modelo = (EstrategiaPersonalizadaProductoModel)Session[Constantes.SessionNames.ProductoTemporal];
                if (modelo == null || modelo.CUV2 != cuv)
                {
                    return RedirectToAction("Index", "RevistaDigital", new { area = "Mobile" });
                    //List<BEEstrategia> listaEstrategiaPedidoModel = (List<BEEstrategia>)Session[Constantes.SessionNames.ListaEstrategia];
                    //modelo = ConsultarEstrategiasModelFormato(listaEstrategiaPedidoModel.Where(x => x.CUV2 == cuv).ToList()).FirstOrDefault();

                }
                ViewBag.CampaniaMasDos = AddCampaniaAndNumero(userData.CampaniaID, 2) % 100;
                return DetalleModel(modelo);
            }
            catch (Exception ex)
            {
                LogManager.LogManager.LogErrorWebServicesBus(ex, userData.CodigoConsultora, userData.CodigoISO);
            }

            return RedirectToAction("Index", "RevistaDigital", new { area = "Mobile" });
        }

        public ActionResult _Landing(int id)
        {
            try
            {
                ViewBag.EsMobile = 2;
                return ViewLanding(id);
            }
            catch (Exception ex)
            {
                LogManager.LogManager.LogErrorWebServicesBus(ex, userData.CodigoConsultora, userData.CodigoISO);
                return PartialView("template-Landing", new RevistaDigitalModel());
            }
        }

        public ActionResult MensajeBloqueado()
        {
            try
            {
                ViewBag.EsMobile = 2;
                return PartialView("template-mensaje-bloqueado", MensajeProductoBloqueado());
            }
            catch (Exception ex)
            {
                LogManager.LogManager.LogErrorWebServicesBus(ex, userData.CodigoConsultora, userData.CodigoISO);
            }
            return PartialView("template-mensaje-bloqueado", new MensajeProductoBloqueadoModel());
        }

    }
}