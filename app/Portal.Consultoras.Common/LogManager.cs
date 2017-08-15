using Newtonsoft.Json;
using System;
using System.Collections.Generic;
using System.Configuration;
using System.IO;
using System.Net.Http;
using System.Net.Http.Headers;
using System.Text;
using System.Web;

namespace Portal.Consultoras.Common
{
    public static class LogManager
    {
        public static void SaveLog(Exception exception, string codigoUsuario, string paisISO, string titulo = "", string adicional = "", string pathFile = "")
        {
            try
            {
                if (exception == null) return;

                RegistrarArchivoTexto(exception, codigoUsuario, paisISO, titulo, adicional, pathFile);
                RegistrarDynamoDB(exception, paisISO, codigoUsuario);
            }
            catch { }
        }

        private static void RegistrarArchivoTexto(Exception exception, string pais, string usuario, string titulo = "", string adicional = "", string pathFile = "")
        {
            if (string.IsNullOrEmpty(pathFile))
            {
                pathFile = AppDomain.CurrentDomain.BaseDirectory + "Log";
            }

            if (!Directory.Exists(pathFile))
                Directory.CreateDirectory(pathFile);

            string path = string.Format("{0}Log_{1}.portal", pathFile, DateTime.Now.ToString("yyyy-MM-dd"));

            using (StreamWriter stream = new StreamWriter(path, true))
            {
                stream.WriteLine(":::::::::::::: " + titulo + " ::::::::::::::");
                stream.WriteLine(DateTime.Now + " ==> País: " + pais + " - Usuario: " + usuario);
                stream.WriteLine("Error message: " + exception.Message);
                stream.WriteLine("StackTrace: " + exception.StackTrace);
                if (string.IsNullOrEmpty(adicional)) stream.WriteLine("Adicional: " + adicional);
                stream.WriteLine(string.Empty);

                Exception innerException = exception.InnerException;
                while (innerException != null)
                {
                    stream.WriteLine("InnerException: " + innerException.Message);
                    innerException = innerException.InnerException;
                }
            }
        }

        private static void RegistrarDynamoDB(Exception exception, string pais, string usuario)
        {
            var dataString = string.Empty;
            try
            {
                if (Util.isNumeric(pais))
                {
                    pais = Util.GetPaisISO(int.Parse(pais));
                }

                var urlRequest = string.Empty;
                var browserRequest = string.Empty;

                if (HttpContext.Current.Request != null)
                {
                    urlRequest = HttpContext.Current.Request.Url.AbsolutePath;
                    browserRequest = HttpContext.Current.Request.UserAgent;
                }

                var data = new
                {
                    Aplicacion = Constantes.LogDynamoDB.AplicacionPortalConsultoras,
                    Pais = pais,
                    Usuario = usuario,
                    Mensaje = exception.Message,
                    StackTrace = exception.StackTrace,
                    Extra = new Dictionary<string, string>() {
                        { "Url", urlRequest },
                        { "Browser", browserRequest },
                        { "TipoTrace", "LogManager" }
                    }
                };

                var urlApi = ConfigurationManager.AppSettings.Get("UrlLogDynamo");

                if (string.IsNullOrEmpty(urlApi)) return;

                using (HttpClient httpClient = new HttpClient())
                {
                    httpClient.BaseAddress = new Uri(urlApi);
                    httpClient.DefaultRequestHeaders.Accept.Clear();
                    httpClient.DefaultRequestHeaders.Accept.Add(new MediaTypeWithQualityHeaderValue("application/json"));

                    dataString = JsonConvert.SerializeObject(data);

                    HttpContent contentPost = new StringContent(dataString, Encoding.UTF8, "application/json");

                    HttpResponseMessage response = httpClient.PostAsync("Api/LogError", contentPost).GetAwaiter().GetResult();

                    var result = response.IsSuccessStatusCode;
                }
            }
            catch (Exception ex)
            {
                RegistrarArchivoTexto(ex, pais, usuario, "Seguimiento de Errores DynamoDB", dataString);
            }
        }
    }
}