using Portal.Consultoras.Web.Providers;
using System;
using System.Web.Mvc;

namespace Portal.Consultoras.Web.Controllers
{
    public class GuiaNegocioController : BaseViewController
    {
        private readonly GuiaNegocioProvider _guiaNegocioProvider;

        public GuiaNegocioController()
        {
            _guiaNegocioProvider = new GuiaNegocioProvider();
        }

        public ActionResult Index()
        {
            try
            {
                if (_guiaNegocioProvider.GNDValidarAcceso(userData.esConsultoraLider, guiaNegocio, revistaDigital))
                {
                    return GNDViewLanding();
                }
            }
            catch (Exception ex)
            {
                logManager.LogErrorWebServicesBusWrap(ex, userData.CodigoConsultora, userData.CodigoISO, "GuiaNegocioController.Index");
            }

            return RedirectToAction("Index", "Bienvenida");
        }


        [HttpPost]
        public JsonResult GNDObtenerProductos(BusquedaProductoModel model)
        {
            try
            {
                if (!GNDValidarAcceso(userData.esConsultoraLider, guiaNegocio, revistaDigital))
                {
                    return Json(new
                    {
                        success = false,
                        message = "",
                        data = ""
                    });
                }

                var listaFinal1 = ConsultarEstrategiasModel("", 0, Constantes.TipoEstrategiaCodigo.GuiaDeNegocioDigitalizada);
                
                if (revistaDigital.TieneRDCR)
                {
                    if (GetConfiguracionManagerContains(Constantes.ConfiguracionManager.RevistaPiloto_Zonas_RDR_2 + userData.CodigoISO, userData.CodigoZona))
                    {
                        listaFinal1 = listaFinal1.Where(e => e.FlagRevista == Constantes.FlagRevista.Valor1 || e.FlagRevista == Constantes.FlagRevista.Valor3).ToList();
                    }
                    else
                    {
                        listaFinal1 = listaFinal1.Where(e => e.FlagRevista == Constantes.FlagRevista.Valor1).ToList();
                    }
                }

                var listModel = ConsultarEstrategiasFormatearModelo(listaFinal1, 2);

                int cantidadTotal = listModel.Count;

                return Json(new
                {
                    success = true,
                    lista = listModel,
                    campaniaId = model.CampaniaID,
                    cantidadTotal = cantidadTotal,
                    cantidad = cantidadTotal,
                    guardaEnLocalStorage = true
                });
            }
            catch (Exception ex)
            {
                LogManager.LogManager.LogErrorWebServicesBus(ex, userData.CodigoConsultora, userData.CodigoISO);
                return Json(new
                {
                    success = false,
                    message = "Error al cargar los productos",
                    data = ""
                });
            }
        }
    }
}