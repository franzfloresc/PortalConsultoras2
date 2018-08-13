using Portal.Consultoras.Common;
using Portal.Consultoras.Web.Models;
using Portal.Consultoras.Web.Models.Buscador;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using System.Web;

namespace Portal.Consultoras.Web.Providers
{
    public class BuscadorYFiltrosProvider : BuscadorBaseProvider
    {
        public async Task<List<BuscadorYFiltrosModel>> GetBuscador(UsuarioModel userData, BuscadorModel buscadorModel)
        {
            List<BuscadorYFiltrosModel> resultados = null;
            try
            {
                string pathBuscador = string.Format(Constantes.RutaBuscadorService.UrlBuscador,
                            userData.CodigoISO,
                            userData.CampaniaID,
                            userData.CodigoConsultora,
                            userData.CodigoZona,
                            buscadorModel.TextoBusqueda,
                            buscadorModel.CantidadProductos,
                            userData.Lider,
                            buscadorModel.SuscripcionActiva,
                            buscadorModel.MDO,
                            buscadorModel.RD,
                            buscadorModel.RDI,
                            buscadorModel.RDR,
                            userData.DiaFacturacion
                    );

                //var taskApi = Task.Run(() => ObtenerBuscadorDesdeApi(pathBuscador));

                //Task.WhenAll(taskApi);

                //resultados = taskApi.Result;

                resultados = await ObtenerBuscadorDesdeApi(pathBuscador);
            }
            catch (Exception ex)
            {
                throw ex;
            }
            return resultados;
        }
    }
}