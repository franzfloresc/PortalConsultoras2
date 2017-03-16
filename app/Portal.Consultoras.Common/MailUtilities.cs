using System.Collections.Generic;
using System.Configuration;
using System.Text;
using Newtonsoft.Json;
using System;

namespace Portal.Consultoras.Common
{
    public class MailUtilities
    {
        /// <summary>
        /// Método para enviar correo a través del API de Mandrill, https://mandrillapp.com/api/docs/messages.html
        /// </summary>
        /// <param name="from">Correo de la persona que enviará el correo</param>
        /// <param name="toMail">Correo de la persona a la que se le va a enviar el mensaje</param>
        /// <param name="toName">Nombre de la persona a la que se le va a enviar el mensaje</param>
        /// <param name="message">Mensaje a enviar en formato HTML</param>
        /// <returns></returns>
        public static dynamic EnviarMailMandrillJson(List<ToWithType> recipients, string message, List<Images> images = null)
        {
            
            var url = ConfigurationManager.AppSettings[AppSettingsKeys.MandrillURL];
            var key = ConfigurationManager.AppSettings[AppSettingsKeys.MandrillKey];
            var from = ConfigurationManager.AppSettings[AppSettingsKeys.MandrillFrom];
            var subject = ConfigurationManager.AppSettings[AppSettingsKeys.MandrillSubject];

            var jsonObject = JsonConvert.SerializeObject(new
            {
                key = key,
                message = new
                {
                    from_email = from,
                    subject = subject,
                    html = MailUtilities.ConstruirMensajeHTML(message),
                    important = false,
                    to = recipients,
                    async = true,
                    images = images ?? new List<Images>()
                }
            });

            var bytes = Encoding.ASCII.GetBytes(jsonObject);

            return BaseUtilities.ConsumirServicio<dynamic>(bytes, url, "");
        }

        /// <summary>
        /// Construye el mensaje en formato text/html
        /// </summary>
        /// <param name="mensaje">Mensaje en texto plano</param>
        /// <returns></returns>
        public static string ConstruirMensajeHTML(string mensaje)
        {
            return string.Format("<HTML><head><META http-equiv=Content-Type content=\"text/html; \"><META charset=\"UTF-8\"></head><body>{0}</body></HTML>", mensaje);
        }

        public static void EnviarMailProcesoDescargaExcepcion(string titulo, string paisISO, DateTime fechaProceso, string tipoProceso, string error, string errorExcepcion)
        {
            EnviarMailProcesoDescargaExcepcion(titulo, paisISO, fechaProceso.ToString("dd/MM/yyyy hh:mm tt"), tipoProceso, error, errorExcepcion);
        }
        public static void EnviarMailProcesoDescargaExcepcion(string titulo, string paisISO, string fechaProceso, string tipoProceso, string error, string errorExcepcion)
        {
            string templatePath = AppDomain.CurrentDomain.BaseDirectory + "bin\\Template\\mailing_proceso_descarga_excepcion.html";
            string htmlTemplate = FileManager.GetContenido(templatePath);

            htmlTemplate = htmlTemplate.Replace("#Pais#", paisISO);
            htmlTemplate = htmlTemplate.Replace("#FechaHoraProceso#", fechaProceso);
            htmlTemplate = htmlTemplate.Replace("#TipoProceso#", tipoProceso);
            htmlTemplate = htmlTemplate.Replace("#Error#", error);
            htmlTemplate = htmlTemplate.Replace("#ErrorExcepcion#", errorExcepcion.Replace(Environment.NewLine, "<br/>"));

            string emailFrom = ConfigurationManager.AppSettings["EmailFromProcesoDescargaExcepcion"] ?? "";
            string emailTo = ConfigurationManager.AppSettings["EmailToProcesoDescargaExcepcion"] ?? "";

            try { Util.EnviarMail(emailFrom, emailTo, "", titulo, htmlTemplate, true); }
            catch(Exception ex) { }
        }
    }

    public class ToWithType
    {
        public string email { get; set; }
        public string name { get; set; }
        public string type { get; set; }
    }
}