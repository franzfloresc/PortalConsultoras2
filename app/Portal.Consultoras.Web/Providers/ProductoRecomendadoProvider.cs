using System;
using System.Linq;
using System.Threading.Tasks;
using Portal.Consultoras.Common;
using Portal.Consultoras.Web.Models;
using Portal.Consultoras.Web.Models.Recomendaciones;
using Portal.Consultoras.Web.SessionManager;

namespace Portal.Consultoras.Web.Providers
{
    public class ProductoRecomendadoProvider : BuscadorBaseProvider
    {
        protected RecomendacionesConfiguracionModel _recomendacionesConfiguracion;

        public ProductoRecomendadoProvider()
        {
            _sessionManager = SessionManager.SessionManager.Instance;
            _recomendacionesConfiguracion = _sessionManager.GetRecomendacionesConfig();
        }

        public async Task<RecomendacionesModel> ObtenerRecomendaciones(string cuv, string codigoProducto, bool esMobile)
        {
            var revistaDigital = _sessionManager.GetRevistaDigital();
            var userData = _sessionManager.GetUserData();
            var pathBuscador = string.Format(Constantes.RutaBuscadorService.UrlRecomendaciones,
                userData.CodigoISO,
                userData.CampaniaID,
                ObtenerOrigen()
            );

            var jsonConsultar = GenerarJsonParaConsulta(userData, revistaDigital, cuv, codigoProducto, esMobile);
            return await PostAsync<RecomendacionesModel>(pathBuscador, jsonConsultar);
        }

        public bool ValidarRecomendacionActivo()
        {
            var value = (from item 
                    in _recomendacionesConfiguracion.ConfiguracionPaisDatos
                    where item.Codigo == Constantes.CodigoConfiguracionRecomendaciones.ActivarRecomendaciones
                    select item.Valor1)
                .FirstOrDefault();
            return !value.IsNullOrEmptyTrim() && value == "1";
        }

        private int ObtenerCantidadMinima()
        {
            var value = (from item
                        in _recomendacionesConfiguracion.ConfiguracionPaisDatos
                    where item.Codigo == Constantes.CodigoConfiguracionRecomendaciones.MinimoResultados
                    select item.Valor1)
                .FirstOrDefault();
            int x;
            return int.TryParse(value, out x) ? x : 1;
        }
        public bool ValidarCantidadMinima(RecomendacionesModel recomendacionesModel)
        {
            return recomendacionesModel.Productos.Any() && recomendacionesModel.Productos.Count >= ObtenerCantidadMinima();
        }
        
        private dynamic GenerarJsonParaConsulta(UsuarioModel usuarioModel, RevistaDigitalModel revistaDigital, string cuv, string codigoProducto, bool esMobile)
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
                cuv,
                codigoProducto,
                personalizaciones,
                cantidadProductos = ObtenerCantidadProductosMax(),
                configuracion = new
                {
                    sociaEmpresaria = usuarioModel.Lider.ToString(),
                    suscripcionActiva = suscripcion.ToString(),
                    mdo = revistaDigital.ActivoMdo.ToString(),
                    rd = revistaDigital.TieneRDC.ToString(),
                    rdi = revistaDigital.TieneRDI.ToString(),
                    rdr = revistaDigital.TieneRDCR.ToString(),
                    diaFacturacion = usuarioModel.DiaFacturacion,
                    mostrarProductoConsultado = esMobile.ToString()
                }
            };
        }

        private int ObtenerCantidadProductosMax()
        {
            var cantidadProductos = (from item
                        in _recomendacionesConfiguracion.ConfiguracionPaisDatos
                    where item.Codigo == Constantes.CodigoConfiguracionRecomendaciones.MaximoResultados
                    select item.Valor1)
                .FirstOrDefault();
            
            int x;
            return int.TryParse(cantidadProductos, out x) ? x : 6;
        }
    }
}