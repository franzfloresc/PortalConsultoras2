using System.Collections.Generic;
using System.Threading.Tasks;
using AutoMapper;
using Portal.Consultoras.Web.Models;
using Portal.Consultoras.Web.ServiceZonificacion;
using Portal.Consultoras.Web.SessionManager;
using System.Net.Http;
using Portal.Consultoras.Web.ServiceSAC;
using System.Linq;
using System;
using System.Configuration;
using System.Net.Http.Headers;
using Newtonsoft.Json;
using System.Text;

namespace Portal.Consultoras.Web.Providers
{
    public class LogDynamoProvider
    {
        public void EjecutarLogDynamoDB(UsuarioModel user, bool esMobile, string campomodificacion, string valoractual, string valoranterior, string origen, string aplicacion, string accion, string codigoconsultorabuscado, string seccion = "")
        {
            string dataString = string.Empty;
            string urlApi = string.Empty;
            string apiController = string.Empty;
            bool noQuitar = false;
            if (user.CodigoISO != "PE") seccion = "";

            try
            {
                var paisesAdmitidos = new List<BETablaLogicaDatos>();
                using (var tablaLogica = new SACServiceClient())
                {
                    paisesAdmitidos = tablaLogica.GetTablaLogicaDatos(user.PaisID, 138).ToList();
                }

                if (paisesAdmitidos.Count > 0 && Convert.ToInt32(paisesAdmitidos[0].Codigo) == Convert.ToInt32(user.PaisID))
                {
                    var data = new
                    {
                        Usuario = user.CodigoUsuario,
                        CodigoConsultora = user.CodigoConsultora,
                        CampoModificacion = campomodificacion,
                        ValorActual = valoractual,
                        ValorAnterior = valoranterior,
                        Origen = origen,
                        Aplicacion = aplicacion,
                        Pais = user.NombrePais,
                        Rol = user.RolDescripcion,
                        Dispositivo = esMobile ? "MOBILE" : "WEB",
                        Accion = accion,
                        UsuarioConsultado = codigoconsultorabuscado,
                        Seccion = seccion
                    };

                    urlApi = ConfigurationManager.AppSettings.Get("UrlLogDynamo");
                    apiController = ConfigurationManager.AppSettings.Get("UrlLogDynamoApiController");

                    if (string.IsNullOrEmpty(urlApi)) return;

                    HttpClient httpClient = new HttpClient();
                    httpClient.BaseAddress = new Uri(urlApi);
                    httpClient.DefaultRequestHeaders.Accept.Clear();
                    httpClient.DefaultRequestHeaders.Accept.Add(new MediaTypeWithQualityHeaderValue("application/json"));

                    dataString = JsonConvert.SerializeObject(data);
                    HttpContent contentPost = new StringContent(dataString, Encoding.UTF8, "application/json");
                    HttpResponseMessage response = httpClient.PostAsync(apiController, contentPost).GetAwaiter().GetResult();
                    noQuitar = response.IsSuccessStatusCode;
                    httpClient.Dispose();
                }
            }
            catch (Exception ex)
            {
                LogManager.LogManager.LogErrorWebServicesBus(ex, user.CodigoConsultora, user.CodigoISO, dataString);
            }
        }
    }
}
