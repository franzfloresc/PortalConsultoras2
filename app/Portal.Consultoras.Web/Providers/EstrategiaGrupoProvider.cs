using Newtonsoft.Json;
using Portal.Consultoras.Common;
using Portal.Consultoras.Web.Models.Oferta.ResponseOfertaGenerico;
using Portal.Consultoras.Web.SessionManager;
using Portal.Consultoras.Web.ServicePROLConsultas;
using System;
using System.Collections.Generic;
using System.Configuration;
using System.Linq;
using System.Net.Http;
using System.Net.Http.Headers;
using System.Text;
using System.Threading.Tasks;
using Portal.Consultoras.Web.Models.AdministrarEstrategia;
using Portal.Consultoras.Web.Models;

namespace Portal.Consultoras.Web.Providers
{
    public class EstrategiaGrupoProvider
    {
        private static readonly HttpClient httpClient = new HttpClient();

        static EstrategiaGrupoProvider()
        {
            if (!string.IsNullOrEmpty(WebConfig.UrlMicroservicioPersonalizacionConfig))
            {
                httpClient.BaseAddress = new Uri(WebConfig.UrlMicroservicioPersonalizacionConfig);
                httpClient.DefaultRequestHeaders.Accept.Clear();
                httpClient.DefaultRequestHeaders.Accept.Add(new MediaTypeWithQualityHeaderValue("application/json"));
            }
        }

        public async Task<bool> InsertarGrupoEstrategiaApi(string path, List<EstrategiaGrupoModel> datos, UsuarioModel userData)
        {
            OutputEstrategiaGrupo respuesta = new OutputEstrategiaGrupo { Success = false };

            EstrategiaGrupoRequest prm = new EstrategiaGrupoRequest();
            /*prm.pais = userData.PaisID.ToString();
            prm.estrategiaId = datos[0].EstrategiaId.ToString();*/
            prm.lstEstrategiaGrupo = datos;
            string prmfinal = Newtonsoft.Json.JsonConvert.SerializeObject(prm.lstEstrategiaGrupo).ToString();
            HttpResponseMessage httpResponse = await httpClient.PostAsync(
                path + "/" + userData.CodigoISO + "/" + datos[0]._idEstrategia.ToString(),
                new StringContent(prmfinal,
                Encoding.UTF8,
                "application/json"));

            if (!httpResponse.IsSuccessStatusCode)
            {
                return respuesta.Success;
            }

            string jsonString = await httpResponse.Content.ReadAsStringAsync();

            try
            {
                respuesta = JsonConvert.DeserializeObject<OutputEstrategiaGrupo>(jsonString);
            }
            catch (Exception ex)
            {
                Common.LogManager.SaveLog(ex, string.Empty, userData.CodigoISO);
            }

            if (!respuesta.Success || !respuesta.Message.Equals(Constantes.EstadoRespuestaServicio.Success))
            {
                Common.LogManager.SaveLog(new Exception(respuesta.Message), string.Empty, userData.CodigoISO);
            }

            return respuesta.Success;
        }

        public List<EstrategiaGrupoModel> ObtenerEstrategiaGrupo(string estrategiaId, string codigoISO)
        {
            var estrategiaGrupoLista = new List<EstrategiaGrupoModel>();
            try
            {

                var taskApi = Task.Run(() => ObtenerEstrategiaGrupoApi(estrategiaId, codigoISO));
                Task.WhenAll(taskApi);
                var grupoListatask = taskApi.Result;
                if (grupoListatask != null && grupoListatask.Result != null)
                {
                    estrategiaGrupoLista = grupoListatask.Result.ToList();
                }
            }
            catch (Exception ex)
            {
                Common.LogManager.SaveLog(ex, string.Empty, codigoISO);
                estrategiaGrupoLista = new List<EstrategiaGrupoModel>();
            }
            return estrategiaGrupoLista;
        }

        private async Task<OutputEstrategiaGrupo> ObtenerEstrategiaGrupoApi(string estrategiaId, string codigoISO)
        {
            var path = string.Format(Constantes.PersonalizacionOfertasService.UrlGetEstrategiaGrupoByEstrategiaId, codigoISO, estrategiaId);
            OutputEstrategiaGrupo respuesta = new OutputEstrategiaGrupo();
            HttpResponseMessage httpResponse = await httpClient.GetAsync(path);

            if (!httpResponse.IsSuccessStatusCode)
            {
                return respuesta;
            }

            string jsonString = await httpResponse.Content.ReadAsStringAsync();


            if (Util.Trim(jsonString) == string.Empty)
            {
                return respuesta;
            }

            var listaSinPrecio2 = new List<string>();
            try
            {
                respuesta = JsonConvert.DeserializeObject<OutputEstrategiaGrupo>(jsonString);
            }
            catch (Exception ex)
            {
                Common.LogManager.SaveLog(ex, string.Empty, codigoISO);
                return respuesta;
            }

            if (!respuesta.Success || !respuesta.Message.Equals(Constantes.EstadoRespuestaServicio.Success))
            {
                Common.LogManager.SaveLog(new Exception(respuesta.Message), string.Empty, codigoISO);
                return respuesta;
            }

            return respuesta;
        }

    }
}