using Portal.Consultoras.Web.Models;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Threading.Tasks;
using Portal.Consultoras.Common;
using Portal.Consultoras.Web.Models.ElasticSearch;

namespace Portal.Consultoras.Web.Providers
{
    public class CarruselUpSellingProvider:BuscadorBaseProvider
    {
        protected TablaLogicaProvider _tablaLogicaProvider;

        public CarruselUpSellingProvider()
        {
            _sessionManager = SessionManager.SessionManager.Instance;
            _tablaLogicaProvider = new TablaLogicaProvider();
        }

        public async Task<OutputProductosUpSelling> ObtenerProductosCarruselUpSelling(string[] codigosProductos, double precioProducto)
        {
            try
            {
                var revistadigital = _sessionManager.GetRevistaDigital();
                var userData = _sessionManager.GetUserData();
                var pathBuscador = string.Format(Constantes.RutaBuscadorService.UrlUpSelling,
                    userData.CodigoISO,
                    userData.CampaniaID,
                    ObtenerOrigen()
                );
                var cantidadProductosUpSelling = ObtenerCantidadProductosUpSelling();
                var jsonData = GenerarJsonParaConsulta(userData, revistadigital, codigosProductos, cantidadProductosUpSelling, precioProducto);

                return await PostAsync<OutputProductosUpSelling>(pathBuscador, jsonData);
            }
            catch (Exception ex)
            {
                return new OutputProductosUpSelling();
            }
        }

        private int ObtenerCantidadProductosUpSelling()
        {
            var userData = _sessionManager.GetUserData();
            var cantidadProductos = _tablaLogicaProvider.GetTablaLogicaDatoValor(userData.PaisID, ConsTablaLogica.ConfiguracionesFicha.TablaLogicaId, ConsTablaLogica.ConfiguracionesFicha.CantidadProductosCarruselUpSelling, true);
            return cantidadProductos.IsNullOrEmptyTrim() ? 0 : Convert.ToInt32(cantidadProductos);
        }

        private dynamic GenerarJsonParaConsulta(UsuarioModel usuarioModel, RevistaDigitalModel revistaDigital, string[] codigosProductos, int cantidadProductos, double precioProducto)
        {
            var suscripcion = (revistaDigital.EsSuscrita && revistaDigital.EsActiva);
            var personalizaciones = "";
            var buscadorConfig = _sessionManager.GetBuscadorYFiltrosConfig();
            if (buscadorConfig != null)
                personalizaciones = buscadorConfig.PersonalizacionDummy ?? "";

            return new
            {
                codigoConsultora = usuarioModel.CodigoConsultora,
                codigoZona = usuarioModel.CodigoZona,
                codigoProducto = codigosProductos,
                personalizaciones,
                cantidadProductos,
                precioProducto,
                configuracion = new
                {
                    sociaEmpresaria = usuarioModel.Lider.ToString(),
                    suscripcionActiva = suscripcion.ToString(),
                    mdo = revistaDigital.ActivoMdo.ToString(),
                    rd = revistaDigital.TieneRDC.ToString(),
                    rdi = revistaDigital.TieneRDI.ToString(),
                    rdr = revistaDigital.TieneRDCR.ToString(),
                    diaFacturacion = usuarioModel.DiaFacturacion
                }
            };
        }
    }
}