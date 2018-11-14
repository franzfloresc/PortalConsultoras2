﻿using Portal.Consultoras.Common;
using Portal.Consultoras.Web.Models;
using Portal.Consultoras.Web.Models.Buscador;
using Portal.Consultoras.Web.ServicePedido;
using Portal.Consultoras.Web.SessionManager;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;

namespace Portal.Consultoras.Web.Providers
{
    public class BuscadorYFiltrosProvider : BuscadorBaseProvider
    {
        protected ISessionManager _sessionManager;

        private string Origen
        {
            get { return Util.EsDispositivoMovil() ? "sb-mobile" : "sb-desktop"; }
        }

        public BuscadorYFiltrosProvider()
        {
            _sessionManager = SessionManager.SessionManager.Instance;
        }

        public async Task<string> GetPersonalizacion(UsuarioModel usuario)
        {
            var pathPersonalziacion = string.Format(Constantes.RutaBuscadorService.UrlPersonalizacion,
                usuario.CodigoISO,
                usuario.CampaniaID,
                usuario.CodigoConsultora,
                Origen);

            return await ObtenerPersonalizaciones(pathPersonalziacion);
        }

        public async Task<BuscadorYFiltrosModel> GetBuscador(BuscadorModel buscadorModel)
        {
            var revistaDigital = _sessionManager.GetRevistaDigital();
            var userData = _sessionManager.GetUserData();
            var pathBuscador = string.Format(Constantes.RutaBuscadorService.UrlBuscador,
                userData.CodigoISO,
                userData.CampaniaID,
                Origen
            );

            var parametros = GetJsonPostBuscador(userData, buscadorModel, revistaDigital);
            return await PostAsync<BuscadorYFiltrosModel>(pathBuscador, parametros);
        }

        private dynamic GetJsonPostBuscador(UsuarioModel usuarioModel, BuscadorModel buscadorModel, RevistaDigitalModel revistaDigital)
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
                    sociaEmpresaria = usuarioModel.Lider.ToString(),
                    suscripcionActiva = suscripcion.ToString(),
                    mdo = revistaDigital.ActivoMdo.ToString(),
                    rd = revistaDigital.TieneRDC.ToString(),
                    rdi = revistaDigital.TieneRDI.ToString(),
                    rdr = revistaDigital.TieneRDCR.ToString(),
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
                },
                filtro = new
                {
                    categoria = buscadorModel.Filtro.categoria == null ? "" : buscadorModel.Filtro.categoria,
                    marca = buscadorModel.Filtro.marca == null ? "" : buscadorModel.Filtro.marca
                }
            };
        }

        public async Task<BuscadorYFiltrosModel> ValidacionProductoAgregado(BuscadorYFiltrosModel resultado, List<BEPedidoWebDetalle> pedidos, UsuarioModel userData, RevistaDigitalModel revistaDigital, bool IsMobile)
        {
            var labelAgregado = "";
            var suscripcionActiva = revistaDigital.EsSuscrita && revistaDigital.EsActiva;
            if (resultado.total == 0) return new BuscadorYFiltrosModel();

            foreach (var item in resultado.productos)
            {
                var pedidoAgregado = pedidos.Where(x => x.CUV == item.CUV).ToList();
                labelAgregado = "";

                if (pedidoAgregado.Any())
                {
                    labelAgregado = "Agregado";
                }

                item.CampaniaID = userData.CampaniaID;
                item.PrecioString = Util.DecimalToStringFormat(item.Precio.ToDecimal(), userData.CodigoISO, userData.Simbolo);
                item.ValorizadoString = Util.DecimalToStringFormat(item.Valorizado.ToDecimal(), userData.CodigoISO, userData.Simbolo);
                item.DescripcionEstrategia = Util.obtenerNuevaDescripcionProducto(userData.NuevasDescripcionesBuscador, suscripcionActiva, item.TipoPersonalizacion, item.CodigoTipoEstrategia, item.MarcaId, 0, true);
                item.OrigenPedidoWeb = Util.obtenerCodigoOrigenWeb(item.TipoPersonalizacion, item.CodigoTipoEstrategia, item.MarcaId, IsMobile);
                item.Agregado = labelAgregado;
                item.Stock = !item.Stock;
                item.DescripcionCompleta = item.Descripcion;
            }

            return resultado;
        }
    }
}