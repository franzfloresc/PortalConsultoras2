using Portal.Consultoras.Common;
using Portal.Consultoras.Web.Models;
using Portal.Consultoras.Web.Models.Buscador;
using Portal.Consultoras.Web.ServicePedido;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using Portal.Consultoras.Common;
using System.Web;

namespace Portal.Consultoras.Web.Providers
{
    public class BuscadorYFiltrosProvider : BuscadorBaseProvider
    {
        public async Task<List<BuscadorYFiltrosModel>> GetBuscador(BuscadorModel buscadorModel)
        {
            List<BuscadorYFiltrosModel> resultados = null;
            try
            {
                var suscripcionActiva = (buscadorModel.revistaDigital.EsSuscrita == true && buscadorModel.revistaDigital.EsActiva == true);

                string pathBuscador = string.Format(Constantes.RutaBuscadorService.UrlBuscador,
                            buscadorModel.userData.CodigoISO,
                            //buscadorModel.userData.CampaniaID,
                            "201811",
                            buscadorModel.userData.CodigoConsultora,
                            buscadorModel.userData.CodigoZona,
                            buscadorModel.TextoBusqueda,
                            buscadorModel.CantidadProductos,
                            buscadorModel.userData.Lider,
                            suscripcionActiva,
                            buscadorModel.revistaDigital.ActivoMdo,
                            buscadorModel.revistaDigital.TieneRDC,
                            buscadorModel.revistaDigital.TieneRDI,
                            buscadorModel.revistaDigital.TieneRDCR,
                            buscadorModel.userData.DiaFacturacion
                    );

                resultados = await ObtenerBuscadorDesdeApi(pathBuscador);
            }
            catch (Exception ex)
            {
                throw ex;
            }
            return resultados;
        }

        public async Task<List<BuscadorYFiltrosModel>> ValidacionProductoAgregado(List<BuscadorYFiltrosModel> resultado, List<BEPedidoWebDetalle> pedidos, UsuarioModel userData, RevistaDigitalModel revistaDigital, bool IsMobile)
        {
            var suscripcionActiva = (revistaDigital.EsSuscrita == true && revistaDigital.EsActiva == true);
            var resultBuscador = new List<BuscadorYFiltrosModel>();

            try
            {
                if (resultado.Any())
                {
                    foreach (var item in resultado)
                    {
                        var pedidoAgregado = pedidos.Where(x => x.CUV == item.CUV).ToList();
                        var labelAgregado = "";
                        var cantidadAgregada = 0;

                        if (pedidoAgregado.Any())
                        {
                            labelAgregado = "Agregado";
                            cantidadAgregada = pedidoAgregado[0].Cantidad;
                        }

                        resultBuscador.Add(new BuscadorYFiltrosModel()
                        {
                            CUV = item.CUV.Trim(),
                            SAP = item.SAP.Trim(),
                            Imagen = item.Imagen,
                            Descripcion = item.Descripcion,
                            Valorizado = item.Valorizado,
                            Precio = item.Precio,
                            CodigoEstrategia = item.CodigoEstrategia,
                            CodigoTipoEstrategia = item.CodigoTipoEstrategia,
                            TipoEstrategiaId = item.TipoEstrategiaId,//item.TipoEstrategiaId,
                            LimiteVenta = item.LimiteVenta,
                            PrecioString = Util.DecimalToStringFormat(item.Precio.ToDecimal(), userData.CodigoISO, userData.Simbolo),
                            ValorizadoString = Util.DecimalToStringFormat(item.Valorizado.ToDecimal(), userData.CodigoISO, userData.Simbolo),
                            DescripcionEstrategia = Util.obtenerNuevaDescripcionProducto(userData.NuevasDescripcionesBuscador, suscripcionActiva, item.TipoPersonalizacion, item.CodigoTipoEstrategia, item.MarcaId, 0),
                            MarcaId = item.MarcaId,
                            CampaniaID = userData.CampaniaID,
                            Agregado = labelAgregado,
                            CantidadesAgregadas = cantidadAgregada,
                            Stock = !item.Stock,
                            OrigenPedidoWeb = Util.obtenerCodigoOrigenWeb(item.TipoPersonalizacion, item.CodigoTipoEstrategia, item.MarcaId, IsMobile)
                        });
                    }
                }
            }
            catch (Exception ex)
            {
                throw ex;
            }

            await Task.Delay(1000);
            return resultBuscador;
        }

        //public List<BuscadorYFiltrosModel> ValidacionProductoAgregado(List<BuscadorYFiltrosModel> resultado, List<BEPedidoWebDetalle> pedidos, UsuarioModel userData, RevistaDigitalModel revistaDigital)
        //{
        //    var suscripcionActiva = (revistaDigital.EsSuscrita == true && revistaDigital.EsActiva == true);
        //    var resultBuscador = new List<BuscadorYFiltrosModel>();
        //    try
        //    {
        //        if (resultado.Any())
        //        {
        //            foreach (var item in resultado)
        //            {
        //                var pedidoAgregado = pedidos.Where(x => x.CUV == item.CUV).ToList();
        //                var labelAgregado = "";
        //                var cantidadAgregada = 0;

        //                if (pedidoAgregado.Any())
        //                {
        //                    labelAgregado = "Agregado";
        //                    cantidadAgregada = pedidoAgregado[0].Cantidad;
        //                }

        //                resultBuscador.Add(new BuscadorYFiltrosModel()
        //                {
        //                    CUV = item.CUV.Trim(),
        //                    SAP = item.SAP.Trim(),
        //                    Imagen = item.Imagen,
        //                    Descripcion = item.Descripcion,
        //                    Valorizado = item.Valorizado,
        //                    Precio = item.Precio,
        //                    CodigoEstrategia = item.CodigoEstrategia,
        //                    CodigoTipoEstrategia = item.CodigoTipoEstrategia,
        //                    TipoEstrategiaId = item.TipoEstrategiaId,//item.TipoEstrategiaId,
        //                    LimiteVenta = item.LimiteVenta,
        //                    PrecioString = Util.DecimalToStringFormat(item.Precio.ToDecimal(), userData.CodigoISO, userData.Simbolo),
        //                    ValorizadoString = Util.DecimalToStringFormat(item.Valorizado.ToDecimal(), userData.CodigoISO, userData.Simbolo),
        //                    DescripcionEstrategia = Util.obtenerNuevaDescripcionProducto(userData.NuevasDescripcionesBuscador, suscripcionActiva, item.TipoPersonalizacion, item.CodigoTipoEstrategia, item.MarcaId),
        //                    MarcaId = item.MarcaId,
        //                    CampaniaID = userData.CampaniaID,
        //                    Agregado = labelAgregado,
        //                    CantidadesAgregadas = cantidadAgregada,
        //                    Stock = !item.Stock
        //                });
        //            }
        //        }
        //    }
        //    catch (Exception ex)
        //    {
        //        throw ex;
        //    }
        //    return resultBuscador;
        //}
    }
}