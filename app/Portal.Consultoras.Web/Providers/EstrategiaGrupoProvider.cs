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

        public OutputEstrategiaGrupo Guardar(List<EstrategiaGrupoModel> datos, string codigoIso)
        {
            if (!datos.Any())
            {
                return new OutputEstrategiaGrupo { Success = true, Message = "Sin datos que guardar" };
            }

            Task<OutputEstrategiaGrupo> taskapi = Task.Run(() => InsertarGrupoEstrategiaApi(Constantes.PersonalizacionOfertasService.UrlGuardarEstrategiaGrupo, datos, codigoIso));
            Task.WhenAll(taskapi);

            return taskapi.Result;
        }

        private async Task<OutputEstrategiaGrupo> InsertarGrupoEstrategiaApi(string path, List<EstrategiaGrupoModel> datos, string codigoIso)
        {
            OutputEstrategiaGrupo respuesta = new OutputEstrategiaGrupo { Success = false };

            EstrategiaGrupoRequest prm = new EstrategiaGrupoRequest();

            prm.lstEstrategiaGrupo = datos;
            string prmfinal = Newtonsoft.Json.JsonConvert.SerializeObject(prm.lstEstrategiaGrupo).ToString();
            HttpResponseMessage httpResponse = await httpClient.PostAsync(
                path + "/" + codigoIso + "/" + datos[0]._idEstrategia.ToString(),
                new StringContent(prmfinal,
                Encoding.UTF8,
                "application/json"));

            if (!httpResponse.IsSuccessStatusCode)
            {
                return respuesta;
            }

            string jsonString = await httpResponse.Content.ReadAsStringAsync();

            try
            {
                respuesta = JsonConvert.DeserializeObject<OutputEstrategiaGrupo>(jsonString);
            }
            catch (Exception ex)
            {
                Common.LogManager.SaveLog(ex, string.Empty, codigoIso, jsonString);
            }

            if (!respuesta.Success || !respuesta.Message.Equals(Constantes.EstadoRespuestaServicio.Success))
            {
                Common.LogManager.SaveLog(new Exception(respuesta.Message), string.Empty, codigoIso);
            }

            return respuesta;
        }

        public List<EstrategiaGrupoModel> ObtenerEstrategiaGrupo(string estrategiaId, string codigoIso)
        {
            var estrategiaGrupoLista = new List<EstrategiaGrupoModel>();
            try
            {

                var taskApi = Task.Run(() => ObtenerEstrategiaGrupoApi(estrategiaId, codigoIso));
                Task.WhenAll(taskApi);
                var grupoListatask = taskApi.Result;
                if (grupoListatask != null && grupoListatask.Result != null)
                {
                    estrategiaGrupoLista = grupoListatask.Result.ToList();
                }
            }
            catch (Exception ex)
            {
                Common.LogManager.SaveLog(ex, string.Empty, codigoIso);
                estrategiaGrupoLista = new List<EstrategiaGrupoModel>();
            }
            return estrategiaGrupoLista;
        }

        private async Task<OutputEstrategiaGrupo> ObtenerEstrategiaGrupoApi(string estrategiaId, string codigoIso)
        {
            var path = string.Format(Constantes.PersonalizacionOfertasService.UrlGetEstrategiaGrupoByEstrategiaId, codigoIso, estrategiaId);
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
            
            try
            {
                respuesta = JsonConvert.DeserializeObject<OutputEstrategiaGrupo>(jsonString);
            }
            catch (Exception ex)
            {
                Common.LogManager.SaveLog(ex, string.Empty, codigoIso, jsonString);
                return respuesta;
            }

            if (!respuesta.Success || !respuesta.Message.Equals(Constantes.EstadoRespuestaServicio.Success))
            {
                Common.LogManager.SaveLog(new Exception(respuesta.Message), string.Empty, codigoIso);
                return respuesta;
            }

            return respuesta;
        }

    }
}