using Newtonsoft.Json;
using System;
using System.Collections.Generic;
using System.Configuration;
using System.Diagnostics;
using System.IO;
using System.Net.Http;
using System.Net.Http.Headers;
using System.Text;
using System.Web;
using System.Web.Routing;

namespace Portal.Consultoras.Common
{
    public static class LogManager
    {
        public static void SaveLog(Exception exception, string codigoUsuario, string paisISO, string adicional = "")
        {
            SaveLog(new LogError
            {
                Exception = exception,
                CodigoUsuario = codigoUsuario,
                IsoPais = paisISO,
                Origen = "Servidor",
                Titulo = "Seguimiento de Errores Servicio Portal",
                InformacionAdicional = adicional
            });
        }

        public static void SaveLog(Exception exception, string codigoUsuario, int paisId, string adicional = "")
        {
            SaveLog(new LogError
            {
                Exception = exception,
                CodigoUsuario = codigoUsuario,
                IsoPais = paisId.ToString(),
                Origen = "Servidor",
                Titulo = "Seguimiento de Errores Servicio Portal",
                InformacionAdicional = adicional
            });
        }

        public static void SaveLog(Exception exception, long consultoraId, int paisId, string adicional = "")
        {
            SaveLog(new LogError
            {
                Exception = exception,
                CodigoUsuario = consultoraId.ToString(),
                IsoPais = paisId.ToString(),
                Origen = "Servidor",
                Titulo = "Seguimiento de Errores Servicio Portal",
                InformacionAdicional = adicional
            });
        }

        public static void SaveLog(Exception exception, long consultoraId, string paisIso, string adicional = "")
        {
            SaveLog(new LogError
            {
                Exception = exception,
                CodigoUsuario = consultoraId.ToString(),
                IsoPais = paisIso,
                Origen = "Servidor",
                Titulo = "Seguimiento de Errores Servicio Portal",
                InformacionAdicional = adicional
            });
        }

        public static void SaveLog(LogError logError, string pathFile = "")
        {
            try
            {
                if (logError == null || logError.Exception == null) return;

                if (Util.IsNumeric(logError.IsoPais))
                {
                    logError.IsoPais = Util.GetPaisISO(int.Parse(logError.IsoPais));
                }

                RegistrarArchivoTexto(logError, pathFile);
                RegistrarDynamoDB(logError);
                RegistrarElastic(logError);
            }
            catch (Exception)
            {
                //EventLog.WriteEntry("SomosBelcorp - LogManager", string.Format("Mensaje: {0} \nTrace: {1}", ex.Message, ex.StackTrace), EventLogEntryType.Error);
            }
        }

        private static void RegistrarArchivoTexto(LogError logError, string pathFile = "")
        {
            try
            {
                if (string.IsNullOrEmpty(pathFile))
                {
                    pathFile = AppDomain.CurrentDomain.BaseDirectory + "Log\\";
                }

                if (!Directory.Exists(pathFile))
                    Directory.CreateDirectory(pathFile);

                string path = string.Format("{0}Log_{1}.portal", pathFile, DateTime.Now.ToString("yyyy-MM-dd"));

                using (StreamWriter stream = new StreamWriter(path, true))
                {
                    stream.WriteLine(":::::::::::::: " + logError.Titulo + " ::::::::::::::");
                    stream.WriteLine(DateTime.Now + " ==> País: " + logError.IsoPais + " - Usuario: " + logError.CodigoUsuario);
                    stream.WriteLine("Error message: " + logError.Exception.Message);
                    stream.WriteLine("StackTrace: " + logError.Exception.StackTrace);
                    if (!string.IsNullOrEmpty(logError.InformacionAdicional))
                        stream.WriteLine("Adicional: " + logError.InformacionAdicional);
                    stream.WriteLine(string.Empty);

                    Exception innerException = logError.Exception.InnerException;
                    while (innerException != null)
                    {
                        stream.WriteLine("InnerException: " + innerException.Message);
                        innerException = innerException.InnerException;
                    }
                }
            }
            catch (Exception ex)
            {
                EventLog.WriteEntry("SomosBelcorp - LogManager", string.Format("Mensaje: {0} \nTrace: {1}", ex.Message, ex.StackTrace), EventLogEntryType.Error);
            }
        }

        private static void RegistrarDynamoDB(LogError logError)
        {
            var dataString = string.Empty;
            try
            {
                var urlRequest = string.Empty;
                var browserRequest = string.Empty;
                var ctrl = string.Empty;
                var acti = string.Empty;

                if (HttpContext.Current != null && HttpContext.Current.Request != null)
                {
                    urlRequest = HttpContext.Current.Request.Url.ToString();
                    browserRequest = HttpContext.Current.Request.UserAgent;

                    var routeValues = HttpContext.Current.Request.RequestContext.RouteData.Values;
                    ctrl = routeValues.ContainsKey("controller") ? routeValues["controller"].ToString() : "CtrlNoRoute";
                    acti = routeValues.ContainsKey("action") ? routeValues["action"].ToString() : "ActiNoRoute";
                }

                var exceptionMessage = string.Empty;
                var exceptionStackTrace = string.Empty;

                if (logError.Exception != null)
                {
                    exceptionMessage = logError.Exception.Message;
                    exceptionStackTrace = logError.Exception.StackTrace;

                    var innerException = logError.Exception.InnerException;
                    while (innerException != null)
                    {
                        exceptionStackTrace = logError.Exception.ToString();
                        exceptionMessage = string.Format("{0}, InnerException: {1}", exceptionMessage, innerException.Message);

                        innerException = innerException.InnerException;
                    }
                }
                
                var data = new
                {
                    Aplicacion = Constantes.LogDynamoDB.AplicacionPortalConsultoras,
                    Pais = logError.IsoPais,
                    Usuario = logError.CodigoUsuario,
                    Mensaje = exceptionMessage,
                    StackTrace = exceptionStackTrace,

                    CurrentUrl = urlRequest,
                    ControllerName = ctrl.ToLower(),
                    ActionName = acti.ToLower(),

                    Extra = new Dictionary<string, string>() {
                        { "Origen", logError.Origen },
                        //{ "Url", urlRequest },
                        { "Browser", browserRequest },
                        { "TipoTrace", "LogManager" },
                        { "Server", Environment.MachineName }
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

                    var noQuitar = response.IsSuccessStatusCode;
                }
            }
            catch (Exception ex)
            {
                logError.Exception = ex;
                logError.InformacionAdicional = dataString;
                logError.Titulo = "Seguimiento de Errores DynamoDB";

                RegistrarArchivoTexto(logError);
            }
        }

        private static void RegistrarElastic(LogError logError)
        {
            var urlApi = ConfigurationManager.AppSettings.Get("UrlLogElastic");

            if (string.IsNullOrEmpty(urlApi)) return;

            var dataString = string.Empty;
            try
            {
                var urlRequest = string.Empty;
                var browserRequest = string.Empty;
                RouteValueDictionary routeValues = null;

                if (HttpContext.Current != null && HttpContext.Current.Request != null)
                {
                    urlRequest = HttpContext.Current.Request.Url.ToString();
                    browserRequest = HttpContext.Current.Request.UserAgent;
                    routeValues = HttpContext.Current.Request.RequestContext.RouteData.Values;
                }

                var exceptionMessage = string.Empty;
                if (logError.Exception != null)
                {
                    exceptionMessage = logError.Exception.Message;
                }

                string className;
                string methodName;
                string application;

                if (logError.Origen.Equals("Servidor"))
                {
                    application = "WebService";
                    
                    StackTrace st = new StackTrace(logError.Exception, true);
                    StackFrame frame = st.GetFrame(st.FrameCount - 1); 
                    className = frame.GetMethod().DeclaringType.Name;
                    methodName = frame.GetMethod().Name;
                }
                else
                {
                    if (routeValues != null)
                    {
                        className = routeValues.ContainsKey("controller") ? routeValues["controller"].ToString() : "CtrlNoRoute";
                        methodName = routeValues.ContainsKey("action") ? routeValues["action"].ToString() : "ActiNoRoute";
                    }
                    else
                    {
                        className = "";
                        methodName = "";
                    }
                    application = "Web";
                }                

                var data = new
                {
                    Date = DateTime.Now,
                    HostName = Environment.MachineName,
                    ThreadId = System.Threading.Thread.CurrentThread.ManagedThreadId,
                    Level = "ERROR",
                    Class = className,
                    Method = methodName,
                    Message = exceptionMessage,
                    Application = application,
                    Pais = logError.IsoPais,
                    User = logError.CodigoUsuario,
                    Exception = JsonConvert.SerializeObject(logError.Exception),
                    Url = urlRequest,
                    Navigator = browserRequest,
                    Trace = "LogManager"
                };                

                using (HttpClient httpClient = new HttpClient())
                {
                    httpClient.DefaultRequestHeaders.Accept.Clear();
                    httpClient.DefaultRequestHeaders.Accept.Add(new MediaTypeWithQualityHeaderValue("application/json"));

                    dataString = JsonConvert.SerializeObject(data);

                    HttpContent contentPost = new StringContent(dataString, Encoding.UTF8, "application/json");

                    HttpResponseMessage response = httpClient.PostAsync(GetUrl(urlApi), contentPost).GetAwaiter().GetResult();

                    var noQuitar = response.IsSuccessStatusCode;
                }
            }
            catch (Exception ex)
            {
                logError.Exception = ex;
                logError.InformacionAdicional = dataString;
                logError.Titulo = "Seguimiento de Errores Elastic";

                RegistrarArchivoTexto(logError);
            }
        }

        private static string GetUrl(string endpoint)
        {
            var pattern = ConfigurationManager.AppSettings.Get("PatternElastic");

            string indexName = pattern + DateTime.Now.ToString("yyyy.MM.dd");
            return endpoint + indexName + "/LogEvent";
        }
    }
}