using Portal.Consultoras.Common;
using Portal.Consultoras.Web.Models;
using Portal.Consultoras.Web.Models.ElasticSearch;
using System;
using System.Collections.Generic;
using System.Threading.Tasks;
using AutoMapper;
using Portal.Consultoras.Web.Models.Search.ResponseOferta.Estructura;

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

        public virtual async Task<List<EstrategiaPersonalizadaProductoModel>> ObtenerProductosCarruselUpSelling(string cuv, string[] codigosProductos, double precioProducto)
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

            OutputProductosUpSelling response = await PostAsync<OutputProductosUpSelling>(pathBuscador, jsonData);
            return !response.success ? 
                new List<EstrategiaPersonalizadaProductoModel>() : 
                Mapper.Map<List<Estrategia>, List<EstrategiaPersonalizadaProductoModel>>(response.result ?? new List<Estrategia>());
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