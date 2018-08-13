using Portal.Consultoras.Common;
using Portal.Consultoras.Web.Controllers;
using Portal.Consultoras.Web.Models;
using Portal.Consultoras.Web.Models.Buscador;
using Portal.Consultoras.Web.Providers;
using Portal.Consultoras.Web.ServiceUsuario;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using System.Web;
using System.Web.Mvc;

namespace Portal.Consultoras.Web.Areas.Mobile.Controllers
{
    public class BuscadorController : BaseMobileController
    {
        BuscadorYFiltrosProvider BuscadorYFiltrosProvider = new BuscadorYFiltrosProvider();
        // GET: Mobile/Buscador
        public ActionResult Index()
        {            
            return View();
        }

      
        public async Task<JsonResult> BusquedaProductos(string busqueda, int totalResultados)
        {
            var ListaProductosModel = new List<BuscadorYFiltrosModel>();
            try
            {
                var resultBuscador = new List<BuscadorYFiltrosModel>();
                var buscadorModel = new BuscadorModel();
                buscadorModel.TextoBusqueda = busqueda;
                buscadorModel.CantidadProductos = totalResultados;

                resultBuscador = await BuscadorYFiltrosProvider.GetBuscador(userData, buscadorModel);

                if (resultBuscador.Any())
                {
                    var pedidos = sessionManager.GetDetallesPedido();

                    foreach (var item in resultBuscador)
                    {
                        var pedidoAgregado = pedidos.Where(x => x.CUV == item.CUV).ToList();
                        var labelAgregado = "";
                        var cantidadAgregada = 0;

                        if (pedidoAgregado.Any())
                        {
                            labelAgregado = "Agregado";
                            cantidadAgregada = pedidoAgregado[0].Cantidad;
                        }

                        ListaProductosModel.Add(new BuscadorYFiltrosModel()
                        {
                            CUV = item.CUV.Trim(),
                            SAP = item.SAP.Trim(),
                            Imagen = item.Imagen,
                            Descripcion = item.Descripcion,
                            Valorizado = item.Valorizado,
                            Precio = item.Precio,
                            CodigoEstrategia = item.CodigoEstrategia,
                            CodigoTipoEstrategia = item.CodigoTipoEstrategia,
                            TipoEstrategiaId = 1,//item.TipoEstrategiaId,
                            LimiteVenta = item.LimiteVenta,
                            PrecioString = Util.DecimalToStringFormat(item.Precio.ToDecimal(), userData.CodigoISO, userData.Simbolo),
                            ValorizadoString = Util.DecimalToStringFormat(item.Valorizado.ToDecimal(), userData.CodigoISO, userData.Simbolo),
                            DescripcionEstrategia = "En duro",//item.descripcionEstrategia,
                            MarcaId = item.MarcaId,
                            CampaniaID = userData.CampaniaID,
                            Agregado = labelAgregado,
                            CantidadesAgregadas = cantidadAgregada
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