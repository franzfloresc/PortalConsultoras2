using Portal.Consultoras.Common;
using Portal.Consultoras.Web.Models;
using Portal.Consultoras.Web.Models.ElasticSearch;
using System;
using System.Threading.Tasks;

namespace Portal.Consultoras.Web.Providers
{
    public class CarruselUpSellingProvider : BuscadorBaseProvider
    {
        protected TablaLogicaProvider _tablaLogicaProvider;
        protected ConsultaProlProvider _consultaProlProvider;

        public CarruselUpSellingProvider()
        {
            _sessionManager = SessionManager.SessionManager.Instance;
            _tablaLogicaProvider = new TablaLogicaProvider();
            _consultaProlProvider = new ConsultaProlProvider();
        }

        public virtual async Task<OutputProductosUpSelling> ObtenerProductosCarruselUpSelling(string cuv, string[] codigosProductos, double precioProducto)
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
                var jsonData = GenerarJsonParaConsulta(userData, revistadigital, codigosProductos, cantidadProductosUpSelling, precioProducto, cuv);

                return await PostAsync<OutputProductosUpSelling>(pathBuscador, jsonData);
            }
            catch (Exception)
            {
                return new OutputProductosUpSelling();
            }
        }

        private int ObtenerCantidadProductosUpSelling()
        {
            var userData = _sessionManager.GetUserData();
            var cantidadProductos = _tablaLogicaProvider.GetTablaLogicaDatoValorInt(userData.PaisID,
                ConsTablaLogica.ConfiguracionesFicha.TablaLogicaId,
                ConsTablaLogica.ConfiguracionesFicha.CantidadProductosUpSelling, true);
            return cantidadProductos;
        }

        private dynamic GenerarJsonParaConsulta(UsuarioModel usuarioModel,
            RevistaDigitalModel revistaDigital,
            string[] codigosProductos,
            int cantidadProductos,
            double precioProducto,
            string cuv)
        {
            var suscripcion = revistaDigital.EsActiva;
            var personalizaciones = "";
            var buscadorConfig = _sessionManager.GetBuscadorYFiltrosConfig();
            var esFacturacion = _consultaProlProvider.GetValidarDiasAntesStock(usuarioModel);

            if (buscadorConfig != null)
                personalizaciones = buscadorConfig.PersonalizacionDummy ?? "";

            return new
            {
                codigoConsultora = usuarioModel.CodigoConsultora,
                codigoZona = usuarioModel.CodigoZona,
                codigoProducto = codigosProductos,
                cuv,
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
                    diaFacturacion = usuarioModel.DiaFacturacion,
                    esFacturacion
                }
            };
        }
    }
}