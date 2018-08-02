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
            var ListaProductosModel = new List<BuscadorYFiltrosModel>();

            try
            {
                List<BEBuscadorYFiltros> resultBuscador;

                using (var usuario = new UsuarioServiceClient())
                {
                    resultBuscador = usuario.listaProductos(userData.PaisID, userData.CampaniaID, 20, busqueda, userData.RegionID, userData.ZonaID, Convert.ToInt32(userData.CodigorRegion), Convert.ToInt32(userData.CodigoZona)).ToList();
                }

                if (resultBuscador.Any())
                {
                    // Se validara Stock o lo hara el API?
                    var carpetapais = Globals.UrlMatriz + "/" + userData.CodigoISO;

                    foreach (var item in resultBuscador)
                    {
                        ListaProductosModel.Add(new BuscadorYFiltrosModel()
                        {
                            CUV = item.CUV.Trim(),
                            SAP = item.SAP.Trim(),
                            Imagen = string.IsNullOrWhiteSpace(item.Imagen) ? "../../Content/Images/imagen_prod_no_disponible.png" : ConfigCdn.GetUrlFileCdn(carpetapais, item.Imagen),
                            Descripcion = item.Descripcion,
                            Valorizado = item.Valorizado,
                            Precio = item.Precio,
                            Catalogo = item.Catalogo,
                            CodigoEstrategia = item.CodigoEstrategia,
                            CodigoPalanca = item.CodigoPalanca,
                            LimiteVenta = item.LimiteVenta,
                            PrecioString = Util.DecimalToStringFormat(item.Precio.ToDecimal(), userData.CodigoISO, userData.Simbolo),
                            ValorizadoString = Util.DecimalToStringFormat(item.Valorizado.ToDecimal(), userData.CodigoISO, userData.Simbolo)
                        });
                    }
                }
            }
            catch (Exception ex)
            {
                LogManager.LogManager.LogErrorWebServicesBus(ex, userData.CodigoConsultora, userData.CodigoISO);
                ListaProductosModel = new List<BuscadorYFiltrosModel>();
            }
            return Json(ListaProductosModel, JsonRequestBehavior.AllowGet);
        }

        private List<BuscadorYFiltrosModel> Data()
        {
            return new List<BuscadorYFiltrosModel>();
        }
    }
}