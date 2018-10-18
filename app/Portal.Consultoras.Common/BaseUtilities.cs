using Newtonsoft.Json;
using Newtonsoft.Json.Linq;
using System;
using System.Collections.Generic;
using System.Configuration;
using System.IO;
using System.Linq;
using System.Linq.Expressions;
using System.Net;
using System.Text;

namespace Portal.Consultoras.Common
{
    public static class BaseUtilities
    {
        private const string PrefijoCodigoPais = "CodigoPais";
        private const string PrefijoNombrePais = "NombrePais";

        private static string ObtenerConnectionStringPorPais(string valorAReemplazar, string connectionString, string prefijo, string valorDefault = "")
        {
            var key = ConfigurationManager.AppSettings.AllKeys.FirstOrDefault(k => k.Contains(string.Format("{0}_{1}", prefijo, valorAReemplazar)));
            var value = key != null ? ConfigurationManager.AppSettings[key] : valorDefault;

            return ConfigurationManager.ConnectionStrings[connectionString].ConnectionString.Replace("XX", value);
        }

        public static string ObtenerConnectionString(string codigoPais, string connectionStringName)
        {
            switch (connectionStringName)
            {
                case ConnectionStringNames.BelcorpPais:
                    return ObtenerConnectionStringPorPais(codigoPais, connectionStringName, PrefijoNombrePais, "CL");
                case ConnectionStringNames.ODS:
                    return ObtenerConnectionStringPorPais(codigoPais, connectionStringName, PrefijoCodigoPais, "Chile");
                default:
                    return string.Empty;
            }
        }

        /// <summary>
        /// Función para consumir servicios POST. Devuelve el objeto deserializado
        /// </summary>
        /// <param name="data"> La data a enviar en formato de bytes. Usar la función "Encoding.ASCII.GetBytes(JsonConvert.SerializeObject( [object] ))" para transformar el objeto en bytes </param>
        /// <param name="urlBase"> Url base del servicio. Debe ser del archivo ".svc"</param>
        /// <param name="metodo">El método del servicio que se va a usar</param>
        /// <param name="contentType">El tipo de contenido del request. Por default es "application/json"</param>
        /// <returns>Retorna un objeto del tipo "dynamic"</returns>
        public static TResult ConsumirServicio<TResult>(byte[] data, string urlBase, string metodo, string contentType = "application/json") where TResult : class
        {
            try
            {
                var result = "";
                var request = WebRequest.Create(string.Format("{0}{1}", urlBase, metodo)) as HttpWebRequest;
                if (request != null)
                {
                    request.Method = "POST";
                    request.Timeout = 5 * 60 * 1000;
                    request.ContentType = contentType;
                    request.ContentLength = data.Length;

                    using (var stream = request.GetRequestStream())
                    {
                        stream.Write(data, 0, data.Length);
                    }

                    var response = (request.GetResponse()) as HttpWebResponse;
                    if (response != null)
                    {
                        var streamRe = response.GetResponseStream();
                        if (streamRe != null)
                            result = new StreamReader(streamRe).ReadToEnd();
                    }
                }

                var resultado = JsonConvert.DeserializeObject<TResult>(result);
                return resultado;
            }
            catch (Exception ex)
            {
                ErrorUtilities.AddLog(ex);
                return null;
            }
        }

        public static TResult ConsumirServicio<TResult>(string metodo, object data, string urlServicio = null) where TResult : class
        {
            var urlBase = ConfigurationManager.AppSettings[AppSettingsKeys.WSGEO_Url];
            var bytes = Encoding.UTF8.GetBytes(JsonConvert.SerializeObject(data));

            return ConsumirServicio<TResult>(bytes, urlServicio ?? urlBase, metodo);
        }

        public static JObject ConsumirServicio(string metodo, object data)
        {
            var urlBase = ConfigurationManager.AppSettings[AppSettingsKeys.WSGEO_Url];
            var bytes = Encoding.UTF8.GetBytes(JsonConvert.SerializeObject(data));

            return ConsumirServicio<dynamic>(bytes, urlBase, metodo) as JObject;
        }

        public static string ObtenerExceptionMessage(Exception ex)
        {
            var message = string.Empty;

            do
            {
                message = ex.Message;
                ex = ex.InnerException;

            } while (ex != null);

            return message;
        }

        public static string ObtenerUrlServicioCrediticio(string codigoPais)
        {
            var key = ConfigurationManager.AppSettings.AllKeys.FirstOrDefault(k => k.Contains(string.Format("WSUrlBuro_{0}", codigoPais)));
            return key != null ? ConfigurationManager.AppSettings[key] : string.Empty;
        }

        public static string AplicarFormatoNumeroDocumentoPorPais(string codigoISO, string numeroDocumento)
        {
            return Dictionaries.FormatoNumeroDocumentoBD.ContainsKey(codigoISO) && Dictionaries.FormatoNumeroDocumentoBD[codigoISO] != null && !string.IsNullOrWhiteSpace(numeroDocumento) ?
                Dictionaries.FormatoNumeroDocumentoBD[codigoISO](numeroDocumento) : numeroDocumento;
        }

        public static IEnumerable<T> OrdenarLista<T>(IEnumerable<T> lista, string propiedadOrdenar, string direccionOrdenamiento)
           where T : class
        {
            if (string.IsNullOrEmpty(propiedadOrdenar))
                return lista;

            var tipoOrdenamiento = direccionOrdenamiento == "DESC" ? 2 : 1;

            var listaPropiedadesOrdenar = propiedadOrdenar.Split(',');
            var primeraPropiedad = listaPropiedadesOrdenar[0];

            var lambdaOrder = ObtenerLambda<T>(primeraPropiedad);

            var enumerable = lista as IList<T> ?? lista.ToList();

            IOrderedEnumerable<T> listaOrdenada = tipoOrdenamiento == 1
                ? Enumerable.OrderBy(enumerable, (dynamic)lambdaOrder.Compile())
                : Enumerable.OrderByDescending(enumerable, (dynamic)lambdaOrder.Compile());

            if (listaPropiedadesOrdenar.Length > 1)
            {
                for (int i = 1; i < listaPropiedadesOrdenar.Length; i++)
                {
                    var propiedadActual = listaPropiedadesOrdenar[i];
                    var nuevoLambda = ObtenerLambda<T>(propiedadActual);

                    listaOrdenada = tipoOrdenamiento == 1
                        ? Enumerable.ThenBy(listaOrdenada, (dynamic)nuevoLambda.Compile())
                        : Enumerable.ThenByDescending(listaOrdenada, (dynamic)nuevoLambda.Compile());
                }
            }

            return listaOrdenada;
        }

        private static LambdaExpression ObtenerLambda<T>(string propiedad)
        {
            ParameterExpression p = Expression.Parameter(typeof(T), "p");
            var propertyReference = typeof(T).GetProperty(propiedad);

            var lambdaOrder = Expression.Lambda(
                Expression.Property(p, propertyReference), p);

            return lambdaOrder;
        }
    }
}