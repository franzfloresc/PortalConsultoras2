using Newtonsoft.Json;
using System;
using System.Collections.Generic;
using System.Configuration;
using System.Text;

namespace Portal.Consultoras.Common
{
    public static class MailUtilities
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
            string templatePath = AppDomain.CurrentDomain.BaseDirectory + "bin\\Templates\\mailing_proceso_descarga_excepcion.html";
            string htmlTemplate = FileManager.GetContenido(templatePath);

            htmlTemplate = htmlTemplate.Replace("#Pais#", paisISO);
            htmlTemplate = htmlTemplate.Replace("#FechaHoraProceso#", fechaProceso);
            htmlTemplate = htmlTemplate.Replace("#TipoProceso#", tipoProceso);
            htmlTemplate = htmlTemplate.Replace("#Error#", error);
            htmlTemplate = htmlTemplate.Replace("#ErrorExcepcion#", errorExcepcion.Replace(Environment.NewLine, "<br/>"));

            string emailFrom = ConfigurationManager.AppSettings["EmailFromProcesoDescargaExcepcion"] ?? "";
            string emailTo = ConfigurationManager.AppSettings["EmailToProcesoDescargaExcepcion"] ?? "";

            Util.EnviarMail(emailFrom, emailTo, "", titulo, htmlTemplate, true);
        }

        public static void EnviarMailProcesoRecuperaContrasenia(string emailFrom, string emailTo, string titulo, string displayname, string logo, string nombre, string url, string fondo)
        {
            string templatePath = AppDomain.CurrentDomain.BaseDirectory + "bin\\Templates\\mailing_proceso_recuperar_contrasenia.html";
            string htmlTemplate = FileManager.GetContenido(templatePath);

            htmlTemplate = htmlTemplate.Replace("#Logo#", logo);
            htmlTemplate = htmlTemplate.Replace("#Nombre#", nombre);
            htmlTemplate = htmlTemplate.Replace("#Url#", url);
            htmlTemplate = htmlTemplate.Replace("#Fondo#", fondo);

            Util.EnviarMail(emailFrom, emailTo, string.Empty, titulo, htmlTemplate, true, displayname);
        }

        public static void EnviarMailPinAutenticacion(string emailFrom, string emailTo, string titulo, string displayname, string logo, string nombre, string Pin)
        {
            string templatePath = AppDomain.CurrentDomain.BaseDirectory + "bin\\Templates\\mailing_proceso_Pin_Autenticacion.html";
            string htmlTemplate = FileManager.GetContenido(templatePath);

            htmlTemplate = htmlTemplate.Replace("#Logo#", logo);
            htmlTemplate = htmlTemplate.Replace("#Nombre#", nombre);
            htmlTemplate = htmlTemplate.Replace("#Pin#", Pin);

            try { Util.EnviarMail(emailFrom, emailTo, string.Empty, titulo, htmlTemplate, true, displayname); }
            catch { }
        }

        public static void EnviarMailProcesoActualizaMisDatos(string emailFrom, string emailTo, string titulo, string displayname, string logo, string nombre, string url, string fondo, string parametros)
        {
            string templatePath = AppDomain.CurrentDomain.BaseDirectory + "bin\\Templates\\mailing_proceso_actualizar_misdatos.html";
            string htmlTemplate = FileManager.GetContenido(templatePath);

            htmlTemplate = htmlTemplate.Replace("#Logo#", logo);
            htmlTemplate = htmlTemplate.Replace("#Nombre#", nombre);
            htmlTemplate = htmlTemplate.Replace("#Url#", url);
            htmlTemplate = htmlTemplate.Replace("#Fondo#", fondo);
            htmlTemplate = htmlTemplate.Replace("#Parametros#", parametros);
            
            Util.EnviarMailMasivoColas(emailFrom, emailTo, titulo, htmlTemplate, true, displayname);
        }

        public static string CuerpoMensajePersonalizado(string url, string nombreConsultora, string param_querystring, bool esPaisEsika)
        {
            string s_html = string.Empty;

            s_html = "<html>";
            s_html += "<body style=\"margin:0px; padding:0px; background:#FFF;\">";
            s_html += "<table width=\"100%\" border=\"0\" cellspacing=\"0\" cellpadding=\"0\" align=\"center\" style=\"background:#FFF;\">";
            s_html += "<thead>";
            s_html += "<tr>";
            if (esPaisEsika)
            {
                s_html += "<th colspan=\"3\" style=\"width:100%; height:50px; border-bottom:1px solid #000; padding:12px 0px; text-align:center;\"><img src=\"" + Globals.RutaCdn + "/ImagenesPortal/Iconos/logo.png\" alt=\"Logo Esika\" /></th>";
            }
            else
            {
                s_html += "<th colspan=\"3\" style=\"width:100%; height:50px; border-bottom:1px solid #000; padding:12px 0px; text-align:center;\"><img src=\"" + Globals.RutaCdn + "/ImagenesPortal/Iconos/logod.png\" alt=\"Logo Esika\" /></th>";
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
            s_html += "<td style=\"font-family:'Calibri'; font-size:17px; text-align:center; font-weight:500; color:#000; padding:0 0 20px 0;\">¡Hola " + nombreConsultora + "!</td>";
            s_html += "</tr>";
            s_html += "<tr>";
            s_html += "<td style=\"text-align:center; font-family:'Calibri'; font-size:20px; color:#000; padding-bottom:15px;\">Confírmanos tu dirección de correo para tener tu información actualizada y que puedas acceder a todos nuestros beneficios</td>";
            s_html += "</tr>";
            s_html += "<tr>";
            s_html += "</tr>";
            s_html += "<tr>";
            s_html += "<td>";
            s_html += "<table align=\"center\" border=\"0\" cellspacing=\"0\" cellpadding=\"0\" style=\"width:50%;\">";
            s_html += "<tbody>";
            s_html += "<tr>";
            if (esPaisEsika)
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
            s_html += "<a href='http://belcorp.biz/'><img src=\"" + Globals.RutaCdn + "/ImagenesPortal/Iconos/logo-belcorp.png\" alt=\"Logo Belcorp\" /></a>";
            s_html += "</td>";
            s_html += "<td style=\"width:8%; text-align:left;\">";
            s_html += "<a href='http://www.esika.com/'><img src=\"" + Globals.RutaCdn + "/ImagenesPortal/Iconos/logo-esika.png\" alt=\"Logo Esika\" /></a>";
            s_html += "</td>";
            s_html += "<td style=\"width:8%; text-align:left;\">";
            s_html += "<a href='http://www.lbel.com/'><img src=\"" + Globals.RutaCdn + "/ImagenesPortal/Iconos/logo-lbel.png\" alt=\"Logo L'bel\" /></a>";
            s_html += "</td>";
            s_html += "<td style=\"width:15%; text-align:left;border-right:1px solid #FFF;\">";
            s_html += "<a href='http://www.cyzone.com/'><img src=\"" + Globals.RutaCdn + "/Correo/logo-cyzone.png\" alt=\"Logo Cyzone\" /></a>";
            s_html += "</td>";
            s_html += "<td style=\"width:15%; font-family:'Calibri'; font-weight:400; font-size:13px; color:#FFF; vertical-align:middle;\">";
            s_html += "<table align=\"center\" style=\"text-align:center; width:100%;\">";
            s_html += "<tbody>";
            s_html += "<tr>";
            s_html += "<td style=\"text-align: right; font-family:'Calibri'; font-weight:400; font-size:13px; vertical-align: middle; width: 69%; color:white;\">SÍGUENOS EN</td>";
            s_html += "<td style=\"text-align: right; position: relative; top: 2px; left: 10px; width: 20%; vertical-align: top;\"><a href='https://www.facebook.com/SomosBelcorpOficial?fref=ts'><img src=\"" + Globals.RutaCdn + "/ImagenesPortal/Iconos/logo-facebook.png\" alt=\"Logo Facebook\" /></a></td>";
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
            s_html += "<a href='http://mandrillapp.com/track/click/30935960/comunidad.somosbelcorp.com?p=eyJzIjoiXzNUbWZ0Uzg5OU1VZW1BWDlrYmNuU3RXN1BjIiwidiI6MSwicCI6IntcInVcIjozMDkzNTk2MCxcInZcIjoxLFwidXJsXCI6XCJodHRwOlxcXC9cXFwvY29tdW5pZGFkLnNvbW9zYmVsY29ycC5jb21cIixcImlkXCI6XCJmYTI1NjEwYTRmZWM0NzVkYWJiNGYzM2U2OWJlMGQwNVwiLFwidXJsX2lkc1wiOltcIjk0OTg3MDY0MDU4MzkxNDg2ZWFiYTk2MjJiYTdiNTUxZWRlNmM2NzdcIl19In0' style='text-decoration:none'><span style=\"font-family:'Calibri'; font-size:12px; color:#000;\">¿Tienes dudas?</span></a>";
            s_html += "</td>";
            s_html += "<td style=\"text-align:center; width:48%;\">";
            s_html += "<a href='http://belcorpresponde.somosbelcorp.com/' style='text-decoration:none'><span style=\"font-family:'Calibri'; font-size:12px; color:#000;\">Contáctanos</span></a>";
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

        public static string CuerpoCorreoActivacionCupon(string userName, string campaniaActual, string simbolo, decimal monto, string tipoOferta, string url, string montoLimite, bool tipopais)
        {
            string codigoCampania = campaniaActual.Substring(4, 2);
            var textoGanaste = "¡" + userName + " ACTIVASTE TU CUPÓN DE " + Convert.ToInt32(monto) + "% DE DSCTO!";
            url = url + "Bienvenida";

            StringBuilder sBuilder = new StringBuilder();
            sBuilder.Append("<html>");
            sBuilder.Append("<head>");
            sBuilder.Append("</head>");
            sBuilder.Append("<body>");
            sBuilder.Append("<div style=\"width: 100%; table-layout: fixed; -webkit-text-size-adjust: 100%; -ms-text-size-adjust: 100%;\">");
            sBuilder.Append("<div style=\"max-width: 600px; Margin: 0 auto;\">");
            sBuilder.Append("<table width=\"100%\" align=\"center\" border =\"0\" cellspacing =\"0\" cellpadding =\"0\" style=\"background: #fff; max-width: 600px;\" class=\"main\">");
            sBuilder.Append("<tr>");
            sBuilder.Append("<td colspan=\"2\" style=\"width: 100%; height: 50px; padding: 12px 0px; text-align: center; background: #fff;\">");
            if (tipopais)
                sBuilder.Append("<img src=\"" + Globals.RutaCdn + "/ImagenesPortal/Iconos/logo.png\" alt =\"Logo Esika\"/>");
            else
                sBuilder.Append("<img src=\"" + Globals.RutaCdn + "/ImagenesPortal/Iconos/logod.png\" alt =\"Logo Esika\"/>");
            sBuilder.Append("</td>");
            sBuilder.Append("</tr>");
            sBuilder.Append("<tr>");
            sBuilder.Append("<td colspan=\"2\" style=\"text-align: center; font-family: 'Arial'; font-size: 22px; color: #000; padding-bottom: 5px; padding-left: 10px; padding-right: 10px;padding-top: 5px;\">");
            sBuilder.Append("<strong>" + textoGanaste + "</strong>");
            sBuilder.Append("</td>");
            sBuilder.Append("</tr>");
            sBuilder.Append("<tr>");
            sBuilder.Append("<td colspan=\"2\" style=\"text-align: center; font-family: 'Arial'; font-size: 15px; color: #000; padding-bottom: 15px; padding-left: 10px; padding-right: 10px;\">");
            sBuilder.Append("</td>");
            sBuilder.Append("</tr>");
            sBuilder.Append("<tr>");
            sBuilder.Append("<td colspan=\"2\" style=\"text-align: center; padding-top: 25px; background:#f2f2f2; padding-left: 5%; padding-right: 5%; padding-bottom: 25px;\">");
            if (tipopais)
                sBuilder.Append("<table width=\"100%\" align=\"center\" border =\"0\" cellspacing =\"0\" style=\"background:#e31b35; padding-top: 20px; padding-bottom: 20px; border-bottom:2px dashed #fff;\">");
            else
                sBuilder.Append("<table width=\"100%\" align=\"center\" border =\"0\" cellspacing =\"0\" style=\"background:#642f80; padding-top: 20px; padding-bottom: 20px; border-bottom:2px dashed #fff;\">");
            sBuilder.Append("<tr>");
            sBuilder.Append("<td>");
            sBuilder.Append("<div style=\"display: inline-block; width: 148px; vertical-align: middle; padding: 10px;\">");
            sBuilder.Append("<table>");
            sBuilder.Append("<tr>");
            sBuilder.Append("<td><img src=\"" + Globals.RutaCdn + "/ImagenesPortal/Iconos/calendario.png\"></td>");
            sBuilder.Append("</tr>");
            sBuilder.Append("<tr>");
            sBuilder.Append("<td style=\"color:#fff; font-size: 12px; font-family: 'Arial'; padding-top: 10px;\">Sólo válido en la campaña C" + codigoCampania + "</td>");
            sBuilder.Append("</tr>");
            sBuilder.Append("</table>");
            sBuilder.Append("</div>");
            sBuilder.Append("<div style=\"display: inline-block; width: 148px; vertical-align: middle; padding: 10px;\">");
            sBuilder.Append("<table>");
            sBuilder.Append("<tr>");
            sBuilder.Append("<td><img src=\"" + Globals.RutaCdn + "/ImagenesPortal/Iconos/group-6.png\"></td>");
            sBuilder.Append("</tr>");
            sBuilder.Append("<tr>");
            sBuilder.Append("<td style=\"color:#fff; font-size: 12px; font-family: 'Arial'; padding-top: 10px;\">Agrega alguna oferta exclusiva web (no incluye ofertas de liquidación web)</td>");
            sBuilder.Append("</tr>");
            sBuilder.Append("</table>");
            sBuilder.Append("</div>");
            sBuilder.Append("<div style=\"display: inline-block; width: 148px; vertical-align: middle; padding: 10px;\">");

            sBuilder.Append("<table>");
            sBuilder.Append("<tr>");
            if (tipopais)
                sBuilder.Append("<td><img src=\"" + Globals.RutaCdn + "/ImagenesPortal/Iconos/group-13.png\" ></td>");
            else
                sBuilder.Append("<td><img src=\"" + Globals.RutaCdn + "/ImagenesPortal/Iconos/icono_lbel.png\" ></td>");
            sBuilder.Append("</tr>");
            sBuilder.Append("<tr>");
            sBuilder.Append("<td style=\"color:#fff; font-size: 12px; font-family: 'Arial';  padding-top: 10px;\">Tu dscto lo verás reflejado en tu facturación<br>(dscto hasta " + simbolo + " " + montoLimite + ")</td>");
            sBuilder.Append("</tr>");
            sBuilder.Append("</table>");
            sBuilder.Append("</div>");
            sBuilder.Append("</td>");
            sBuilder.Append("</tr>");
            sBuilder.Append("</table>");
            sBuilder.Append("<div style=\"padding-top: 20px; background: #fff; padding-bottom: 20px;\" > ");
            if (tipopais)
                sBuilder.Append("<a href='" + url + "' style=\"display: inline-block; background:#e81c36; color: #fff;font-family: 'Arial'; height: 45px; width: 240px; line-height: 45px; font-size: 13px;letter-spacing: 1px; text-decoration: none;\">INGRESA A SOMOSBELCORP</a>");
            else
                sBuilder.Append("<a href='" + url + "' style=\"display: inline-block; background:#642f80; color: #fff;font-family: 'Arial'; height: 45px; width: 240px; line-height: 45px; font-size: 13px;letter-spacing: 1px; text-decoration: none;\">INGRESA A SOMOSBELCORP</a>");
            sBuilder.Append("</div>");
            sBuilder.Append("</td>");
            sBuilder.Append("</tr>");
            sBuilder.Append("<tr>");
            sBuilder.Append("<td colspan=\"2\" style=\"background: #000; height: 62px;\">");
            sBuilder.Append("<table align=\"center\" style=\"text-align:center; padding: 0 13px; width: 100%;\">");
            sBuilder.Append("<tbody>");
            sBuilder.Append("<tr>");
            sBuilder.Append("<td style=\"width: 11%; text-align: left; vertical-align: top;\">");
            sBuilder.Append("<a href=\"http://belcorp.biz/\"><img src=\"" + Globals.RutaCdn + "/ImagenesPortal/Iconos/logo-belcorp.png\" alt =\"Logo Belcorp\"/></a>");
            sBuilder.Append("</td>");
            sBuilder.Append("<td style=\"width: 8%; text-align: left;\">");
            sBuilder.Append("<a href=\"http://www.esika.com/\"><img src=\"" + Globals.RutaCdn + "/ImagenesPortal/Iconos/logo-esika.png\" alt =\"Logo Esika\"/></a>");
            sBuilder.Append("</td>");
            sBuilder.Append("<td style=\"width: 8%; text-align: left;\">");
            sBuilder.Append("<a href=\"http://www.lbel.com/\"><img src=\"" + Globals.RutaCdn + "/ImagenesPortal/Iconos/logo-lbel.png\" alt =\"Logo L'bel\"/></a>");
            sBuilder.Append("</td>");
            sBuilder.Append("<td style=\"width: 15%; text-align: left; border-right: 1px solid #FFF;\">");
            sBuilder.Append("<a href=\"http://www.cyzone.com/\" ><img src=\"" + Globals.RutaCdn + "/Correo/logo-cyzone.png\" alt =\"Logo Cyzone\"/></a>");
            sBuilder.Append("</td>");
            sBuilder.Append("<td style=\"width: 15%; font-family:'Calibri'; font-weight: 400; font-size:13px; color:#FFF; vertical-align:middle;\">");
            sBuilder.Append("<a href=\"https://www.facebook.com/SomosBelcorpOficial?fref=ts\" style=\"text-decoration: none\">");
            sBuilder.Append("<table align=\"center\" style=\"text-align: center; width: 100%;\">");
            sBuilder.Append("<tbody>");
            sBuilder.Append("<tr>");
            sBuilder.Append("<td style=\"text-align: right; font-family: 'Calibri'; font-weight: 400; font-size: 13px; vertical-align: middle; width: 69%; color: white; text-decoration: none;\">");
            sBuilder.Append("SÍGUENOS");
            sBuilder.Append("</td>");
            sBuilder.Append("<td style=\"text-align: right; position: relative; top: 2px; left: 10px; width: 20%; vertical-align: top;\">");
            sBuilder.Append("<img src=\"" + Globals.RutaCdn + "/ImagenesPortal/Iconos/logo-facebook.png\" alt =\"Logo Facebook\"/>");
            sBuilder.Append("</td>");
            sBuilder.Append("</tr>");
            sBuilder.Append("</tbody>");
            sBuilder.Append("</table>");
            sBuilder.Append("</td>");
            sBuilder.Append("</tr>");
            sBuilder.Append("</tbody>");
            sBuilder.Append("</table>");
            sBuilder.Append("</td>");
            sBuilder.Append("</tr>");
            sBuilder.Append("<tr>");
            sBuilder.Append("<td colspan=\"2\" style=\"text-align: center; background: #fff; width: 100%;\">");
            sBuilder.Append("<table width=\"220\" align=\"center\" border=\"0\" cellspacing=\"0\" cellpadding=\"0\" style=\"text-align:center; padding-top:4px; padding-bottom:5px;\">");
            sBuilder.Append("<tbody>");
            sBuilder.Append("<tr>");
            sBuilder.Append("<td align=\"center\" style=\"width:49%; text-align:center; border-right:1px solid #000;\">");
            sBuilder.Append("<span style=\"font-family:'Calibri'; font-size:11.5px; color:#000;\"><a style=\"text-decoration: none;  color: #000;\" href=\"http://comunidad.somosbelcorp.com/\">¿Tienes dudas?</a></span>");
            sBuilder.Append("</td>");
            sBuilder.Append("<td align=\"center\" style=\"text-align:center;\">");
            sBuilder.Append("<span style=\"font-family:'Calibri'; font-size:11.5px; color:#000;\"><a href=\"http://www.belcorpresponde.com/\" style=\"text-decoration: none; color: #000;\">Contáctanos</a></span>");
            sBuilder.Append("</td>");
            sBuilder.Append("</tr>");
            sBuilder.Append("</tbody>");
            sBuilder.Append("</table>");
            sBuilder.Append("</td>");
            sBuilder.Append("</tr>");
            sBuilder.Append("</table>");
            sBuilder.Append("</div>");
            sBuilder.Append("</div>");
            sBuilder.Append("</body>");
            sBuilder.Append("</html>");

            return sBuilder.ToString();
        }

        public static void EnviarMailBienvenidaAsesoraOnline(string emailFrom, string emailTo, string titulo, string displayname, string nombreConsultora)
        {
            string templatePath = AppDomain.CurrentDomain.BaseDirectory + "bin\\Templates\\mailing_bienvenida_coach_virtual.html";
            string htmlTemplate = FileManager.GetContenido(templatePath);

            htmlTemplate = htmlTemplate.Replace("#NombreConsultora#", nombreConsultora);

            Util.EnviarMail(emailFrom, emailTo, string.Empty, titulo, htmlTemplate, true, displayname);

        }
    }

    public class ToWithType
    {
        public string email { get; set; }
        public string name { get; set; }
        public string type { get; set; }
    }
}