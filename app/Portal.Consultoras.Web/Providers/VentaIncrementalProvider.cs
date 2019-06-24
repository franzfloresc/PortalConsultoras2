using System;
using System.Collections.Generic;
using System.Linq;
using System.Net.Http;
using System.Net.Http.Headers;
using System.Text;
using System.Threading.Tasks;
using System.Web;
using AutoMapper;
using Newtonsoft.Json;
using Portal.Consultoras.Common;
using Portal.Consultoras.Web.Models;
using Portal.Consultoras.Web.Models.ElasticSearch;
using Portal.Consultoras.Web.Models.Search.ResponseOferta;
using Portal.Consultoras.Web.Models.Search.ResponseOferta.Estructura;
using Portal.Consultoras.Web.SessionManager;

namespace Portal.Consultoras.Web.Providers
{
    public class VentaIncrementalProvider : OfertaBaseProvider
    {
        protected static TablaLogicaProvider _tablaLogicaProvider;
        private readonly ISessionManager _sessionManager = SessionManager.SessionManager.Instance;

        public VentaIncrementalProvider()
        {
            _tablaLogicaProvider = new TablaLogicaProvider();
        }

        public bool ValidarActivacion(int paisId, string tipo)
        {
            var codeFuncionalidad = "";
            if (tipo.Equals(Constantes.TipoVentaIncremental.CrossSelling))
                codeFuncionalidad = ConsTablaLogica.ConfiguracionesFicha.FuncionalidadCrossSelling;
            else if (tipo.Equals(Constantes.TipoVentaIncremental.Sugerido))
                codeFuncionalidad = ConsTablaLogica.ConfiguracionesFicha.FuncionalidadSugerido;

            var valor = _tablaLogicaProvider.GetTablaLogicaDatoValorInt(paisId,
                ConsTablaLogica.ConfiguracionesFicha.TablaLogicaId,
                codeFuncionalidad, true);

            return valor != 0;
        }

        public virtual async Task<List<EstrategiaPersonalizadaProductoModel>> ObtenerProductosIncremental(string cuv, string tipo)
        {
            var userData = _sessionManager.GetUserData();
            var path = string.Format(Constantes.PersonalizacionOfertasService.UrlVentaIncremental,
                userData.CodigoISO,
                userData.CampaniaID,
                ObtenerOrigen()
            );
            var jsonData = GenerarJsonParaConsulta(userData.CodigoConsultora, cuv, tipo);
            OutputOfertaIncremental response = await PostAsyncMicroservicioSearch<OutputOfertaIncremental>(path, jsonData);

            if (!response.success) return new List<EstrategiaPersonalizadaProductoModel>();
            if (tipo.Equals(Constantes.TipoVentaIncremental.CrossSelling))
                return Mapper.Map<List<Estrategia>, List<EstrategiaPersonalizadaProductoModel>>(response.result.crosssell ?? new List<Estrategia>());
            if (tipo.Equals(Constantes.TipoVentaIncremental.Sugerido))
                return Mapper.Map<List<Estrategia>, List<EstrategiaPersonalizadaProductoModel>>(response.result.suggested ?? new List<Estrategia>());
            return new List<EstrategiaPersonalizadaProductoModel>();
        }

        private dynamic GenerarJsonParaConsulta(string codigoConsultora, string cuv, string tipo)
        {
            return new
            {
                codigoConsultora,
                cuv,
                segmento = new[]{tipo}
            };
        }

        public string ObtenerOrigen()
        {
            return Util.EsDispositivoMovil() ? "sb-mobile" : "sb-desktop";
        }
    }
}