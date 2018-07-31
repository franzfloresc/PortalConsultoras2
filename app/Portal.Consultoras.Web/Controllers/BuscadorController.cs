using Portal.Consultoras.Common;
using Portal.Consultoras.Web.Models;
using Portal.Consultoras.Web.ServiceUsuario;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;

namespace Portal.Consultoras.Web.Controllers
{
    public class BuscadorController : BaseController
    {
        // GET: Buscador
        public ActionResult Index()
        {
            return View();
        }

        [HttpPost]
        public JsonResult BusquedaProductos(string busqueda)
        {
            try
            {
                // Método para motor con los siguientes parametros: CodigoPais, CodigoCampaña, CodigoConsultora, TextoBusqueda, CantidadProductos

                var resultBuscador = new List<BEBuscadorYFiltros>();

                using (var usuario = new UsuarioServiceClient())
                {
                    resultBuscador = usuario.listaProductos(userData.PaisID, userData.CampaniaID, 20, busqueda, userData.RegionID, userData.ZonaID, Convert.ToInt32(userData.CodigorRegion), Convert.ToInt32(userData.CodigoZona)).ToList();
                }

                if (resultBuscador.Any())
                {
                    var carpetapais = Globals.UrlMatriz + "/" + userData.CodigoISO;

                    foreach (var item in resultBuscador)
                    {
                        if (string.IsNullOrWhiteSpace(item.Imagen))
                        {
                            item.Imagen = "../../Content/Images/imagen_prod_no_disponible.png";
                        }
                        else
                        {
                            item.Imagen = ConfigCdn.GetUrlFileCdn(carpetapais, item.Imagen);
                        }
                        item.Valorizado = Util.DecimalToStringFormat(item.Valorizado.ToDecimal(), userData.CodigoISO, userData.Simbolo);
                        item.Precio = Util.DecimalToStringFormat(item.Precio.ToDecimal(), userData.CodigoISO, userData.Simbolo);
                    }
                }

                return Json(new { Success = true, Productos = resultBuscador, Message = "" });
            }
            catch (Exception ex)
            {
                LogManager.LogManager.LogErrorWebServicesBus(ex, userData.CodigoConsultora, userData.CodigoISO);
                return Json(new { Error = true, Message = "Hubo un error al obtener los productos." });
            }
        }

        private List<BuscadorYFiltrosModel> Data()
        {
            return new List<BuscadorYFiltrosModel>();
        }
    }
}