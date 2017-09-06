using Portal.Consultoras.Common;
using Portal.Consultoras.Web.Models;
using Portal.Consultoras.Web.ServicePedido;
using System;
using System.Collections.Generic;
using System.Linq;
using System.ServiceModel;
using System.Web;
using System.Web.Mvc;

namespace Portal.Consultoras.Web.Areas.Mobile.Controllers
{
    public class OfertasController : BaseMobileController
    {
        public ActionResult Index()
        {
            try
            {
                if (Session[Constantes.SessionNames.MenuContenedorActivo] == null)
                    MenuContenedorGuardar(Constantes.ConfiguracionPais.Inicio, userData.CampaniaID);

                var listaSeccion = ObtenerConfiguracion();
                var modelo = new EstrategiaPersonalizadaModel { ListaSeccion = listaSeccion };

                return View(modelo);
            }
            catch (Exception ex)
            {
                LogManager.LogManager.LogErrorWebServicesBus(ex, userData.CodigoConsultora, userData.CodigoISO);
            }

            return RedirectToAction("Index", "Bienvenida");
        }
        
    }
}