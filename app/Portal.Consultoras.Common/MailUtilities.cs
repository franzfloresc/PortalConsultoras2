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

        //1774
        public static string CuerpoMensajePersonalizado(string url,string nombreconsultora, string param_querystring, bool tipopais)
        {
            string s_html = string.Empty;

            s_html = "<html>";
            s_html += "<body style=\"margin:0px; padding:0px; background:#FFF;\">";
            s_html += "<table width=\"100%\" border=\"0\" cellspacing=\"0\" cellpadding=\"0\" align=\"center\" style=\"background:#FFF;\">";
            s_html += "<thead>";
            s_html += "<tr>";
            if (tipopais)
            {
                s_html += "<th colspan=\"3\" style=\"width:100%; height:50px; border-bottom:1px solid #000; padding:12px 0px; text-align:center;\"><img src=\"http://www.genesis-peru.com/mailing-belcorp/logo.png\" alt=\"Logo Esika\" /></th>";
            }
            else
            {
                s_html += "<th colspan=\"3\" style=\"width:100%; height:50px; border-bottom:1px solid #000; padding:12px 0px; text-align:center;\"><img src=\"https://s3.amazonaws.com/uploads.hipchat.com/583104/4578891/jG6i4d6VUyIaUwi/logod.png\" alt=\"Logo Esika\" /></th>";
            }
            s_html += "</tr>";
            s_html += "</thead>";
            s_html += "<tbody>";
            s_html += "<tr>";
            s_html += "<td colspan=\"3\" style=\"height:30px;\"></td>";
            s_html += "</tr>";
            s_html += "<tr>";
            s_html += "<td colspan=\"3\">";
            s_html += "<table align=\"center\"  border=\"0\" cellspacing=\"0\" cellpadding=\"0\" style=\"width:100%; text-align:center; padding-bottom:20px;\">";
            s_html += "<tbody>";
            s_html += "<tr>";
            s_html += "<td style=\"font-family:'Calibri'; font-size:17px; text-align:center; font-weight:500; color:#000; padding:0 0 20px 0;\">¡Hola " + nombreconsultora + "!</td>";
            s_html += "</tr>";
            s_html += "<tr>";
            s_html += "<td style=\"text-align:center; font-family:'Calibri'; font-size:22px; font-weight:700; color:#000; padding-bottom:15px;\"> CONF&Iacute;RMANOS TU DIRECCIÓN DE CORREO </td>";
            s_html += "</tr>";
            s_html += "<tr>";
            //s_html += "<td style=\"text-align:center; font-family:'Calibri'; color:#000; font-weight:500; font-size:14px; padding-bottom:30px;  padding-left:14px; padding-right:14px;\">Confirma tu correo para acceder a todos nuestros beneficios: para tener la info actualizada</td>";
            s_html += "</tr>";
            s_html += "<tr>";
            s_html += "<td>";
            s_html += "<table align=\"center\" border=\"0\" cellspacing=\"0\" cellpadding=\"0\" style=\"width:50%;\">";
            s_html += "<tbody>";
            s_html += "<tr>";
            if (tipopais)
            {
                s_html += "<td style=\"font-family:'Calibri'; width:100%; text-align:center; background:#e81c36; padding-top:10px; padding-bottom:10px; color:white; font-weight:700;\"><a href='" + url + "WebPages/MailConfirmation.aspx?data=" + param_querystring + "'  style=\"text-decoration:none; font-family:'Calibri'; color:white; font-weight:700; font-size:15px;\">CONFIRMAR CORREO</a></td>";
            }
            else
            {
                s_html += "<td style=\"font-family:'Calibri'; width:100%; text-align:center; background:#642f80; padding-top:10px; padding-bottom:10px; color:white; font-weight:700;\"><a href='" + url + "WebPages/MailConfirmation.aspx?data=" + param_querystring + "'  style=\"text-decoration:none; font-family:'Calibri'; color:white; font-weight:700; font-size:15px;\">CONFIRMAR CORREO</a></td>";
            }
            s_html += "</tr>";
            s_html += "</tbody>";
            s_html += "</table>";
            s_html += "</td>";
            s_html += "</tr>";
            s_html += "<tr>";
            s_html += "<td colspan=\"3\" style=\"text-align:center; font-family:'Calibri'; color:#000; font-size:12px; font-weight:400;padding-top:45px; padding-bottom:27px;\"></td>";
            s_html += "</tr>";
            s_html += "<tr>";
            s_html += "<td colspan=\"3\" style=\"background:#000; height:62px;\">";
            s_html += "<table align=\"center\" style=\"text-align:center; padding:0 13px; width:100%; max-width:550px; \">";
            s_html += "<!--[if gte mso 9]>";
            s_html += "<table id=\"tableForOutlook\"><tr><td>";
            s_html += "<![endif]-->";
            s_html += "<tbody>";
            s_html += "<tr>";
            s_html += "<td style=\"width:11%; text-align:left; vertical-align:top;\">";
            s_html += "<img src=\"http://www.genesis-peru.com/mailing-belcorp/logo-belcorp.png\" alt=\"Logo Belcorp\" />";
            s_html += "</td>";
            s_html += "<td style=\"width:8%; text-align:left;\">";
            s_html += "<img src=\"https://s3.amazonaws.com/uploads.hipchat.com/583104/4019711/G9GQryrWRTreo75/logo-esika.png\" alt=\"Logo Esika\" />";
            s_html += "</td>";
            s_html += "<td style=\"width:8%; text-align:left;\">";
            s_html += "<img src=\"https://s3.amazonaws.com/uploads.hipchat.com/583104/4019711/T3o8rSPUKtKpe4g/logo-lbel.png\" alt=\"Logo L'bel\" />";
            s_html += "</td>";
            s_html += "<td style=\"width:15%; text-align:left;border-right:1px solid #FFF;\">";
            s_html += "<img src=\"https://s3.amazonaws.com/uploads.hipchat.com/583104/4019711/qZf6NJ5d9D75LCO/logo-cyzone.png\" alt=\"Logo Cyzone\" />";
            s_html += "</td>";
            s_html += "<td style=\"width:15%; font-family:'Calibri'; font-weight:400; font-size:13px; color:#FFF; vertical-align:middle;\">";
            s_html += "<table align=\"center\" style=\"text-align:center; width:100%;\">";
            s_html += "<tbody>";
            s_html += "<tr>";
            s_html += "<td style=\"text-align: right; font-family:'Calibri'; font-weight:400; font-size:13px; vertical-align: middle; width: 69%; color:white;\">SÍGUENOS</td>";
            s_html += "<td style=\"text-align: right; position: relative; top: 2px; left: 10px; width: 20%; vertical-align: top;\"><img src=\"http://www.genesis-peru.com/mailing-belcorp/logo-facebook.png\" alt=\"Logo Facebook\" /></td>";
            s_html += "</tr>";
            s_html += "</tbody>";
            s_html += "</table>";
            s_html += "</td>";
            s_html += "</tr>";
            s_html += "</tbody>";
            s_html += "<!--[if gte mso 9]>";
            s_html += "</td></tr></table>";
            s_html += "<![endif]-->";
            s_html += "</table>";
            s_html += "</td>";
            s_html += "</tr>";
            s_html += "<tr>";
            s_html += "<td colspan=\"3\">";
            s_html += "<table align=\"center\" style=\"text-align:center; width:200px;\">";
            s_html += "<tbody>";
            s_html += "<tr>";
            s_html += "<td colspan=\"2\" style=\"height:6px;\"></td>";
            s_html += "</tr>";
            s_html += "<tr>";
            s_html += "<td style=\"text-align:center; width:48%; border-right:1px solid #000; padding-right: 13px;\">";
            s_html += "<span style=\"font-family:'Calibri'; font-size:12px; color:#000;\">¿Tienes dudas?</span>";
            s_html += "</td>";
            s_html += "<td style=\"text-align:center; width:48%;\">";
            s_html += "<span style=\"font-family:'Calibri'; font-size:12px; color:#000;\">Contáctanos</span>";
            s_html += "</td>";
            s_html += "</tr>";
            s_html += "</tbody>";
            s_html += "</table>";
            s_html += "</td>";
            s_html += "</tr>";
            s_html += "</tbody>";
            s_html += "</table>";
            s_html += "</body>";
            s_html += "</html>";

            return s_html;


        }

    }

    public class ToWithType
    {
        public string email { get; set; }
        public string name { get; set; }
        public string type { get; set; }
    }
}