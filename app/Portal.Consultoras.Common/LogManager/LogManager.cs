﻿using Newtonsoft.Json;
using System;
using System.Collections.Generic;
using System.Configuration;
using System.Diagnostics;
using System.IO;
using System.Net.Http;
using System.Net.Http.Headers;
using System.Text;
using System.Web;

namespace Portal.Consultoras.Common
{
    public static class LogManager
    {
        public static void SaveLog(Exception exception, string codigoUsuario, string paisISO)
        {
            SaveLog(new LogError
            {
                Exception = exception,
                CodigoUsuario = codigoUsuario,
                IsoPais = paisISO,
                Origen = "Servidor",
                Titulo = "Seguimiento de Errores Servicio Portal"
            });
        }

        public static void SaveLog(LogError logError, string pathFile = "")
        {
            try
            {
                if (logError == null || logError.Exception == null) return;

                if (Util.isNumeric(logError.IsoPais))
                {
                    logError.IsoPais = Util.GetPaisISO(int.Parse(logError.IsoPais));
                }

                RegistrarArchivoTexto(logError, pathFile);
                RegistrarDynamoDB(logError);
            }
            catch (Exception ex)
            {
                EventLog.WriteEntry("SomosBelcorp - LogManager", string.Format("Mensaje: {0} \nTrace: {1}", ex.Message, ex.StackTrace), EventLogEntryType.Error);
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

                if (HttpContext.Current.Request != null)
                {
                    urlRequest = HttpContext.Current.Request.Url.ToString();
                    browserRequest = HttpContext.Current.Request.UserAgent;
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
                    Extra = new Dictionary<string, string>() {
                        { "Origen", logError.Origen },
                        { "Url", urlRequest },
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

                    var result = response.IsSuccessStatusCode;
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
    }
}
