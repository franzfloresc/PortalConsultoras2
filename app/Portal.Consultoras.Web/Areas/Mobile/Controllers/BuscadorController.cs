using Portal.Consultoras.Common;
using Portal.Consultoras.Web.Controllers;
using Portal.Consultoras.Web.Models;
using Portal.Consultoras.Web.ServiceUsuario;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;

namespace Portal.Consultoras.Web.Areas.Mobile.Controllers
{
    public class BuscadorController : BaseMobileController
    {
        // GET: Mobile/Buscador
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
                var configuracionPais = SessionManager.GetBuscadorYFiltros();
                var valores = configuracionPais.ConfiguracionPaisDatos.Where(x => x.Codigo == Constantes.TipoConfiguracionBuscador.TotalResultadosBuscador).ToList();
                var TotalResultadosBuscador = 20;

                if (valores.Any())
                {
                    TotalResultadosBuscador = valores[0].Valor1.ToInt();
                }

                using (var usuario = new UsuarioServiceClient())
                {
                    resultBuscador = usuario.listaProductos(userData.PaisID, userData.CampaniaID, TotalResultadosBuscador, busqueda, userData.RegionID, userData.ZonaID, Convert.ToInt32(userData.CodigorRegion), Convert.ToInt32(userData.CodigoZona)).ToList();
                }

                if (resultBuscador.Any())
                {
                    // Se validara Stock o lo hara el API?
                    var carpetapais = Globals.UrlMatriz + "/" + userData.CodigoISO;

                    var pedidos = SessionManager.GetDetallesPedido();

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
                            Imagen = string.IsNullOrWhiteSpace(item.Imagen) ? "../../Content/Images/imagen_prod_no_disponible.png" : ConfigCdn.GetUrlFileCdn(carpetapais, item.Imagen),
                            Descripcion = item.Descripcion,
                            Valorizado = item.Valorizado,
                            Precio = item.Precio,
                            Catalogo = item.Catalogo,
                            CodigoEstrategia = item.CodigoEstrategia,
                            CodigoPalanca = item.CodigoPalanca,
                            LimiteVenta = item.LimiteVenta,
                            PrecioString = Util.DecimalToStringFormat(item.Precio.ToDecimal(), userData.CodigoISO, userData.Simbolo),
                            ValorizadoString = Util.DecimalToStringFormat(item.Valorizado.ToDecimal(), userData.CodigoISO, userData.Simbolo),
                            DescripcionEstrategia = item.descripcionEstrategia,
                            MarcaId = item.MarcaID,
                            CampaniaID = userData.CampaniaID,
                            EstrategiaCodigo = item.EstrategiaCodigo,
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

        //private List<BuscadorYFiltrosModel> Data()
        //{
        //    return new List<BuscadorYFiltrosModel>();
        //}
    }
}