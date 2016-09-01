using System.Collections.Generic;
using System.Configuration;
using System.Text;
using Newtonsoft.Json;

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
    }

    public class ToWithType
    {
        public string email { get; set; }
        public string name { get; set; }
        public string type { get; set; }
    }
}