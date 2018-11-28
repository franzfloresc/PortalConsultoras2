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

        public async Task<RecomendacionesModel> ObtenerRecomendaciones(string cuv, string codigoProducto)
        {
            var revistaDigital = _sessionManager.GetRevistaDigital();
            var userData = _sessionManager.GetUserData();
            var pathBuscador = string.Format(Constantes.RutaBuscadorService.UrlBuscador,
                userData.CodigoISO,
                userData.CampaniaID,
                ObtenerOrigen()
            );

            var jsonConsultar = GenerarJsonParaConsulta(userData, revistaDigital, cuv, codigoProducto);
            return await PostAsync<RecomendacionesModel>(pathBuscador, jsonConsultar);
        }

        public bool ValidarRecomendacionActivo()
        {
            return (from item 
                    in _recomendacionesConfiguracion.ConfiguracionPaisDatos
                    where item.Codigo == Constantes.CodigoConfiguracionRecomendaciones.ActivarRecomendaciones
                    select item.Valor1)
                .FirstOrDefault()
                .ToBool();
        }

        private dynamic GenerarJsonParaConsulta(UsuarioModel usuarioModel, RevistaDigitalModel revistaDigital, string cuv, string codigoProducto)
        {
            var suscripcion = (revistaDigital.EsSuscrita && revistaDigital.EsActiva);
            return new
            {
                codigoConsultora = usuarioModel.CodigoConsultora,
                codigoZona = usuarioModel.CodigoZona,
                cuv,
                codigoProducto,
                personalizaciones = _sessionManager.GetBuscadorYFiltrosConfig()?.PersonalizacionDummy ?? "",
                cantidadProductos = ObtenerCantidadProductosMax(),
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