using Portal.Consultoras.Common;
using Portal.Consultoras.Web.Models;
using Portal.Consultoras.Web.Models.Buscador;
using Portal.Consultoras.Web.ServicePedido;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using Portal.Consultoras.Web.SessionManager;

namespace Portal.Consultoras.Web.Providers
{
    public class BuscadorYFiltrosProvider : BuscadorBaseProvider
    {
        protected ISessionManager _sessionManager;

        public BuscadorYFiltrosProvider()
        {
            _sessionManager = SessionManager.SessionManager.Instance;
        }

        public async Task<string> GetPersonalizacion(UsuarioModel usuario)
        {
            var pathPersonalziacion = string.Format(Constantes.RutaBuscadorService.UrlPersonalizacion, 
                usuario.CodigoISO,
                usuario.CampaniaID,
                usuario.CodigoConsultora);
            
            return await ObtenerPersonalizaciones(pathPersonalziacion); ;
        }

        public async Task<List<BuscadorYFiltrosModel>> GetBuscador(BuscadorModel buscadorModel)
        {
            var revistaDigital = _sessionManager.GetRevistaDigital();
            var userData = _sessionManager.GetUserData();
            
            var suscripcionActiva = (revistaDigital.EsSuscrita && revistaDigital.EsActiva);
            var pathBuscador = string.Format(Constantes.RutaBuscadorService.UrlBuscador,
                        userData.CodigoISO,
                        userData.CampaniaID,
                        userData.CodigoConsultora,
                        userData.CodigoZona,
                        buscadorModel.TextoBusqueda,
                        buscadorModel.Paginacion.Cantidad,
                        userData.Lider,
                        suscripcionActiva,
                        revistaDigital.ActivoMdo,
                        revistaDigital.TieneRDC,
                        revistaDigital.TieneRDI,
                        revistaDigital.TieneRDCR,
                        userData.DiaFacturacion
                );

            if (userData.IndicadorConsultoraDummy == 1)
            {
                pathBuscador = pathBuscador + '/' + userData.PersonalizacionesDummy;
            }
           
            return await ObtenerBuscadorDesdeApi(pathBuscador);
        }

        public async Task<List<BuscadorYFiltrosModel>> ValidacionProductoAgregado(List<BuscadorYFiltrosModel> resultado, List<BEPedidoWebDetalle> pedidos, UsuarioModel userData, RevistaDigitalModel revistaDigital, bool IsMobile)
        {
            var suscripcionActiva =revistaDigital.EsSuscrita && revistaDigital.EsActiva;
            var resultBuscador = new List<BuscadorYFiltrosModel>();


            if (!resultado.Any()) return resultBuscador;
            foreach (var item in resultado)
            {
                var pedidoAgregado = pedidos.Where(x => x.CUV == item.CUV).ToList();
                var labelAgregado = "";

                if (pedidoAgregado.Any())
                {
                    labelAgregado = "Agregado";
                }

                resultBuscador.Add(new BuscadorYFiltrosModel
                {
                    CUV = item.CUV.Trim(),
                    SAP = item.SAP.Trim(),
                    Imagen = item.Imagen,
                    Descripcion = item.Descripcion,
                    DescripcionCompleta = item.Descripcion,
                    Valorizado = item.Valorizado,
                    Precio = item.Precio,
                    CodigoEstrategia = item.CodigoEstrategia,
                    CodigoTipoEstrategia = item.CodigoTipoEstrategia,
                    TipoEstrategiaId = item.TipoEstrategiaId,
                    LimiteVenta = item.LimiteVenta,
                    PrecioString = Util.DecimalToStringFormat(item.Precio.ToDecimal(), userData.CodigoISO, userData.Simbolo),
                    ValorizadoString = Util.DecimalToStringFormat(item.Valorizado.ToDecimal(), userData.CodigoISO, userData.Simbolo),
                    DescripcionEstrategia = Util.obtenerNuevaDescripcionProducto(userData.NuevasDescripcionesBuscador, suscripcionActiva, item.TipoPersonalizacion, item.CodigoTipoEstrategia, item.MarcaId, 0, true),
                    MarcaId = item.MarcaId,
                    CampaniaID = userData.CampaniaID,
                    Agregado = labelAgregado,
                    Stock = !item.Stock,
                    OrigenPedidoWeb = Util.obtenerCodigoOrigenWeb(item.TipoPersonalizacion, item.CodigoTipoEstrategia, item.MarcaId, IsMobile),
                    TipoPersonalizacion = item.TipoPersonalizacion,
                    URLBsucador = item.URLBsucador,
                    EstrategiaID = item.EstrategiaID
                });
            }

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