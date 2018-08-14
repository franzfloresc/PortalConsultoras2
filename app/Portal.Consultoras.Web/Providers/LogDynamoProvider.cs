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
using Portal.Consultoras.Common;

namespace Portal.Consultoras.Web.Providers
{
    public class LogDynamoProvider
    {

        protected ISessionManager sessionManager;
        protected readonly ConfiguracionManagerProvider _configuracionManager;
        protected readonly EventoFestivoProvider _eventoFestivo;

        public LogDynamoProvider()
        {
            sessionManager = SessionManager.SessionManager.Instance;
            _configuracionManager = new ConfiguracionManagerProvider();
        }

        public void EjecutarLogDynamoDB(UsuarioModel userParametro, bool esMobile, string campomodificacion, string valoractual, string valoranterior, string origen, string aplicacion, string accion, string codigoconsultorabuscado, string seccion = "")
        {
            string dataString = string.Empty;
            string urlApi = string.Empty;
            string apiController = string.Empty;
            bool noQuitar = false;
            if (userParametro.CodigoISO != "PE") seccion = "";

            try
            {
                var paisesAdmitidos = new List<BETablaLogicaDatos>();
                using (var tablaLogica = new SACServiceClient())
                {
                    paisesAdmitidos = tablaLogica.GetTablaLogicaDatos(userParametro.PaisID, 138).ToList();
                }

                if (paisesAdmitidos.Count > 0 && Convert.ToInt32(paisesAdmitidos[0].Codigo) == Convert.ToInt32(userParametro.PaisID))
                {
                    var data = new
                    {
                        Usuario = userParametro.CodigoUsuario,
                        CodigoConsultora = userParametro.CodigoConsultora,
                        CampoModificacion = campomodificacion,
                        ValorActual = valoractual,
                        ValorAnterior = valoranterior,
                        Origen = origen,
                        Aplicacion = aplicacion,
                        Pais = userParametro.NombrePais,
                        Rol = userParametro.RolDescripcion,
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
                LogManager.LogManager.LogErrorWebServicesBus(ex, userParametro.CodigoConsultora, userParametro.CodigoISO, dataString);
            }
        }

        public void RegistrarLogDynamoDB(UsuarioModel userParametro, string aplicacion, string rol, string pantallaOpcion, string opcionAccion, string ipCliente, bool esMobile)
        {
            var dataString = string.Empty;
            try
            {
                var data = new
                {
                    Fecha = "",
                    Aplicacion = aplicacion,
                    Pais = userParametro.CodigoISO,
                    Region = userParametro.CodigorRegion,
                    Zona = userParametro.CodigoZona,
                    Seccion = userParametro.SeccionAnalytics,
                    Rol = rol,
                    Campania = userParametro.CampaniaID.ToString(),
                    Usuario = userParametro.CodigoUsuario,
                    PantallaOpcion = pantallaOpcion,
                    OpcionAccion = opcionAccion,
                    DispositivoCategoria = esMobile ? "MOBILE" : "WEB",
                    DispositivoID = ipCliente,
                    Version = "2.0"
                };


                var urlApi = _configuracionManager.GetConfiguracionManager(Constantes.ConfiguracionManager.UrlLogDynamo);

                if (string.IsNullOrEmpty(urlApi)) return;

                var httpClient = new HttpClient { BaseAddress = new Uri(urlApi) };
                httpClient.DefaultRequestHeaders.Accept.Clear();
                httpClient.DefaultRequestHeaders.Accept.Add(new MediaTypeWithQualityHeaderValue("application/json"));

                dataString = JsonConvert.SerializeObject(data);

                HttpContent contentPost = new StringContent(dataString, Encoding.UTF8, "application/json");

                var response = httpClient.PostAsync("Api/LogUsabilidad", contentPost).GetAwaiter().GetResult();

                var noQuitar = response.IsSuccessStatusCode;

                httpClient.Dispose();
            }
            catch (Exception ex)
            {
                LogManager.LogManager.LogErrorWebServicesBus(ex, userParametro.CodigoConsultora, userParametro.CodigoISO, dataString);
            }
        }

        public UsuarioModel ActualizarDatosLogDynamoDB(UsuarioModel userParametro, bool esMobile, MisDatosModel p_modelo, string p_origen, string p_aplicacion, string p_Accion, string p_CodigoConsultoraBuscado = "", string p_Seccion = "")
        {
            string dataString = string.Empty;

            try
            {
                //Data actual viene del Model       => model
                //Data anterior viene del userData  => userData 

                if (userParametro != null && p_modelo != null && p_Accion.Trim().ToUpper() == "MODIFICACION")
                {
                    string _seccion = "Mis Datos";

                    if (string.IsNullOrEmpty(userParametro.Sobrenombre)) userParametro.Sobrenombre = "";
                    if (string.IsNullOrEmpty(userParametro.EMail)) userParametro.EMail = "";
                    if (string.IsNullOrEmpty(userParametro.Telefono)) userParametro.Telefono = "";
                    if (string.IsNullOrEmpty(userParametro.Celular)) userParametro.Celular = "";
                    if (string.IsNullOrEmpty(userParametro.TelefonoTrabajo)) userParametro.TelefonoTrabajo = "";

                    if (string.IsNullOrEmpty(p_modelo.Sobrenombre)) p_modelo.Sobrenombre = "";
                    if (string.IsNullOrEmpty(p_modelo.EMail)) p_modelo.EMail = "";
                    if (string.IsNullOrEmpty(p_modelo.Telefono)) p_modelo.Telefono = "";
                    if (string.IsNullOrEmpty(p_modelo.Celular)) p_modelo.Celular = "";
                    if (string.IsNullOrEmpty(p_modelo.TelefonoTrabajo)) p_modelo.TelefonoTrabajo = "";

                    string v_campomodificacion = string.Empty;
                    string v_valoranterior = string.Empty;
                    string v_valoractual = string.Empty;

                    if (userParametro.Sobrenombre.Trim().ToUpper() != p_modelo.Sobrenombre.Trim().ToUpper())
                    {
                        v_campomodificacion = "SOBRENOMBRE";
                        v_valoractual = p_modelo.Sobrenombre.Trim();
                        v_valoranterior = userParametro.Sobrenombre.Trim();
                        userParametro.Sobrenombre = v_valoractual;
                        EjecutarLogDynamoDB(userParametro, esMobile, v_campomodificacion, v_valoractual, v_valoranterior, p_origen, p_aplicacion, p_Accion, p_CodigoConsultoraBuscado, _seccion);
                    }

                    if (userParametro.EMail.Trim().ToUpper() != p_modelo.EMail.Trim().ToUpper())
                    {
                        v_campomodificacion = "EMAIL";
                        v_valoractual = p_modelo.EMail.Trim();
                        v_valoranterior = userParametro.EMail.Trim();
                        userParametro.EMail = v_valoractual;
                        EjecutarLogDynamoDB(userParametro, esMobile, v_campomodificacion, v_valoractual, v_valoranterior, p_origen, p_aplicacion, p_Accion, p_CodigoConsultoraBuscado, _seccion);
                    }

                    if (userParametro.Telefono.Trim().ToUpper() != p_modelo.Telefono.Trim().ToUpper())
                    {
                        v_campomodificacion = "TELEFONO";
                        v_valoractual = p_modelo.Telefono.Trim();
                        v_valoranterior = userParametro.Telefono.Trim();
                        userParametro.Telefono = v_valoractual;
                        EjecutarLogDynamoDB(userParametro, esMobile, v_campomodificacion, v_valoractual, v_valoranterior, p_origen, p_aplicacion, p_Accion, p_CodigoConsultoraBuscado, _seccion);
                    }

                    if (userParametro.Celular.Trim().ToUpper() != p_modelo.Celular.Trim().ToUpper())
                    {
                        v_campomodificacion = "CELULAR";
                        v_valoractual = p_modelo.Celular.Trim();
                        v_valoranterior = userParametro.Celular.Trim();
                        userParametro.Celular = v_valoractual;
                        EjecutarLogDynamoDB(userParametro, esMobile, v_campomodificacion, v_valoractual, v_valoranterior, p_origen, p_aplicacion, p_Accion, p_CodigoConsultoraBuscado, _seccion);
                    }

                    if (userParametro.TelefonoTrabajo.Trim().ToUpper() != p_modelo.TelefonoTrabajo.Trim().ToUpper())
                    {
                        v_campomodificacion = "TELEFONO TRABAJO";
                        v_valoractual = p_modelo.TelefonoTrabajo.Trim();
                        v_valoranterior = userParametro.TelefonoTrabajo.Trim();
                        userParametro.TelefonoTrabajo = v_valoractual;
                        EjecutarLogDynamoDB(userParametro, esMobile, v_campomodificacion, v_valoractual, v_valoranterior, p_origen, p_aplicacion, p_Accion, p_CodigoConsultoraBuscado, _seccion);
                    }

                    sessionManager.SetUserData(userParametro);
                }
                else if (p_Accion.Trim().ToUpper() == "CONSULTA")
                {
                    EjecutarLogDynamoDB(userParametro, esMobile, "", "", "", p_origen, p_aplicacion, p_Accion, p_CodigoConsultoraBuscado, p_Seccion);
                }
            }
            catch (Exception ex)
            {
                LogManager.LogManager.LogErrorWebServicesBus(ex, (userParametro ?? new UsuarioModel()).CodigoConsultora, (userParametro ?? new UsuarioModel()).CodigoISO, dataString);
            }

            return userParametro;

        }

        public void RegistrarLogGestionSacUnete(UsuarioModel userParametro, string solicitudId, string pantalla, string accion)
        {
            var dataString = string.Empty;
            try
            {
                var urlApi = _configuracionManager.GetConfiguracionManager(Constantes.ConfiguracionManager.UrlLogDynamo);
                if (string.IsNullOrEmpty(urlApi)) return;

                var data = new
                {
                    FechaRegistro = "",
                    Pais = userParametro.CodigoISO,
                    Rol = userParametro.RolDescripcion,
                    Usuario = userParametro.CodigoUsuario,
                    Pantalla = pantalla,
                    Accion = accion,
                    SolicitudId = solicitudId
                };

                var httpClient = new HttpClient { BaseAddress = new Uri(urlApi) };
                httpClient.DefaultRequestHeaders.Accept.Clear();
                httpClient.DefaultRequestHeaders.Accept.Add(new MediaTypeWithQualityHeaderValue("application/json"));
                dataString = JsonConvert.SerializeObject(data);
                HttpContent contentPost = new StringContent(dataString, Encoding.UTF8, "application/json");
                var response = httpClient.PostAsync("Api/LogGestionSacUnete", contentPost).GetAwaiter().GetResult();
                var noQuitar = response.IsSuccessStatusCode;

                httpClient.Dispose();
            }
            catch (Exception ex)
            {
                LogManager.LogManager.LogErrorWebServicesBus(ex, userParametro.CodigoConsultora, userParametro.CodigoISO, dataString);
            }

        }

        public void RegistrarLogDynamoCambioClave(UsuarioModel userParametro, bool esMobile, string accion, string consultora, string v_valoractual, string v_valoranterior, string Ruta, string Seccion)
        {
            var p_origen = Ruta;
            var p_seccion = Seccion;
            var p_aplicacion = Constantes.LogDynamoDB.AplicacionPortalConsultoras;

            if (accion.Trim().ToUpper() == "MODIFICACION")
            {
                EjecutarLogDynamoDB(userParametro, esMobile, "Contraseña", v_valoractual, v_valoranterior, p_origen, p_aplicacion, accion, "", p_seccion);
            }
            else
            {
                EjecutarLogDynamoDB(userParametro, esMobile, "", "", "", p_origen, p_aplicacion, accion, consultora, p_seccion);
            }
        }

        public void RegistraLogDynamoCDR(UsuarioModel userParametro, bool esMobile, MisReclamosModel model)
        {
            try
            {
                var p_origen = "MI NEGOCIO/CAMBIOS Y DEVOLUCIONES";
                var p_seccion = "Validacion de datos";
                var v_campomodificacion = "";
                var v_valoractual = "";
                var v_valoranterior = "";
                var p_aplicacion = Constantes.LogDynamoDB.AplicacionPortalConsultoras;
                var p_Accion = "Modificacion";

                if (string.IsNullOrEmpty(userParametro.EMail)) userParametro.EMail = "";
                if (string.IsNullOrEmpty(userParametro.Celular)) userParametro.Celular = "";

                if (string.IsNullOrEmpty(model.Email)) model.Email = "";
                if (string.IsNullOrEmpty(model.Telefono)) model.Telefono = "";

                if (userParametro.EMail.ToString().Trim().ToUpper() != model.Email.ToString().Trim().ToUpper())
                {
                    v_campomodificacion = "EMAIL";
                    v_valoractual = model.Email.ToString().Trim();
                    v_valoranterior = userParametro.EMail.ToString().Trim();
                    EjecutarLogDynamoDB(userParametro, esMobile, v_campomodificacion, v_valoractual, v_valoranterior, p_origen, p_aplicacion, p_Accion, "", p_seccion);
                }

                if (userParametro.Celular.ToString().Trim().ToUpper() != model.Telefono.ToString().Trim().ToUpper())
                {
                    v_campomodificacion = "CELULAR";
                    v_valoractual = model.Telefono.ToString().Trim();
                    v_valoranterior = userParametro.Celular.ToString().Trim();
                    EjecutarLogDynamoDB(userParametro, esMobile, v_campomodificacion, v_valoractual, v_valoranterior, p_origen, p_aplicacion, p_Accion, "", p_seccion);
                }
            }
            catch (Exception ex)
            {
                LogManager.LogManager.LogErrorWebServicesBus(ex, userParametro.CodigoConsultora, userParametro.CodigoISO);
            }
        }
    }
}
