using Portal.Consultoras.Common;
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
        public BuscadorYFiltrosProvider()
        {
            _sessionManager = SessionManager.SessionManager.Instance;
        }
        public async Task<BuscadorYFiltrosModel> GetBuscador(BuscadorModel buscadorModel)
        {
            var revistaDigital = _sessionManager.GetRevistaDigital();
            var userData = _sessionManager.GetUserData();
            var pathBuscador = string.Format(Constantes.RutaBuscadorService.UrlBuscador,
                userData.CodigoISO,
                userData.CampaniaID,
                ObtenerOrigen()
            );

            var parametros = GetJsonPostBuscador(userData, buscadorModel, revistaDigital);
            return await PostAsync<BuscadorYFiltrosModel>(pathBuscador, parametros);
        }

        private dynamic GetJsonPostBuscador(UsuarioModel usuarioModel, BuscadorModel buscadorModel, RevistaDigitalModel revistaDigital)
        {
            var suscripcion = (revistaDigital.EsSuscrita && revistaDigital.EsActiva);
            var presonalizaciones = "";
            var configBuscador = _sessionManager.GetBuscadorYFiltrosConfig();
            if (configBuscador != null)
                presonalizaciones = configBuscador.PersonalizacionDummy ?? "";

            return new
            {
                codigoConsultora = usuarioModel.CodigoConsultora,
                codigoZona = usuarioModel.CodigoZona,
                textoBusqueda = buscadorModel.TextoBusqueda,
                personalizaciones = presonalizaciones,
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
                    categoria = buscadorModel.Filtro.categoria,
                    marca = buscadorModel.Filtro.marca,
                    precio = buscadorModel.Filtro.precio 
                }
            };
        }

        
    }
}