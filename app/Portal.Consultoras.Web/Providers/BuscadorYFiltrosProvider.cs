using Portal.Consultoras.Common;
using Portal.Consultoras.Web.Models;
using Portal.Consultoras.Web.Models.Buscador;
using Portal.Consultoras.Web.ServicePedido;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using Portal.Consultoras.Web.SessionManager;
using System;

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

        public async Task<BuscadorYFiltrosModel> GetBuscador(BuscadorModel buscadorModel)
        {
            var lista = new BuscadorYFiltrosModel();
            try
            {
                var revistaDigital = _sessionManager.GetRevistaDigital();
                var userData = _sessionManager.GetUserData();
                var baseAddress = WebConfig.RutaServiceBuscadorAPI;
                var pathBuscador = string.Format(Constantes.RutaBuscadorService.UrlBuscador,
                            userData.CodigoISO,
                            userData.CampaniaID
                    );

                var parametros = getJsonPostBuscador(userData, buscadorModel, revistaDigital);
                lista = await PostAsync<BuscadorYFiltrosModel>(pathBuscador, parametros);
            }
            catch (Exception ex)
            {
                throw;
            }

            return lista;
        }

        private dynamic getJsonPostBuscador(UsuarioModel usuarioModel, BuscadorModel buscadorModel, RevistaDigitalModel revistaDigital)
        {
            var suscripcion = (revistaDigital.EsSuscrita && revistaDigital.EsActiva);
            return new
            {
                codigoConsultora = usuarioModel.CodigoConsultora,
                codigoZona = usuarioModel.CodigoZona,
                textoBusqueda = buscadorModel.TextoBusqueda,
                personalizaciones = usuarioModel.PersonalizacionesDummy,
                configuracion = new
                {
                    sociaEmpresaria = usuarioModel.Lider,
                    suscripcionActiva = suscripcion,
                    mdo = revistaDigital.ActivoMdo,
                    rd = revistaDigital.TieneRDC,
                    rdi = revistaDigital.TieneRDI,
                    rdr = revistaDigital.TieneRDCR,
                    diaFacturacion = usuarioModel.DiaFacturacion
                },
                paginacion = new
                {
                    numeroPagina = buscadorModel.Paginacion.NumeroPagina,
                    cantidad = buscadorModel.Paginacion.Cantidad
                },
                orden = new
                {
                    campo = buscadorModel.Orden.Campo,
                    tipo = buscadorModel.Orden.Tipo
                }
            };
        }

        public async Task<BuscadorYFiltrosModel> ValidacionProductoAgregado(BuscadorYFiltrosModel resultado, List<BEPedidoWebDetalle> pedidos, UsuarioModel userData, RevistaDigitalModel revistaDigital, bool IsMobile)
        {
            var suscripcionActiva = revistaDigital.EsSuscrita && revistaDigital.EsActiva;
            var resultBuscador = new BuscadorYFiltrosModel();

            if (!resultado.productos.Any()) return resultBuscador;
            resultBuscador.total = resultado.total; 
            foreach (var item in resultado.productos)
            {
                var pedidoAgregado = pedidos.Where(x => x.CUV == item.CUV).ToList();
                var labelAgregado = "";

                if (pedidoAgregado.Any())
                {
                    labelAgregado = "Agregado";
                }

                resultBuscador.productos.Add(new Productos
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
    }
}