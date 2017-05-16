﻿using System.Collections.Generic;
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
            s_html += "<td style=\"text-align:center; font-family:'Calibri'; font-size:20px; color:#000; padding-bottom:15px;\">Confírmanos tu dirección de correo para tener tu información actualizada y que puedas acceder a todos nuestros beneficios</td>";
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
            s_html += "<a href='http://belcorp.biz/'><img src=\"http://www.genesis-peru.com/mailing-belcorp/logo-belcorp.png\" alt=\"Logo Belcorp\" /></a>";
            s_html += "</td>";
            s_html += "<td style=\"width:8%; text-align:left;\">";
            s_html += "<a href='http://www.esika.com/'><img src=\"https://s3.amazonaws.com/uploads.hipchat.com/583104/4019711/G9GQryrWRTreo75/logo-esika.png\" alt=\"Logo Esika\" /></a>";
            s_html += "</td>";
            s_html += "<td style=\"width:8%; text-align:left;\">";
            s_html += "<a href='http://www.lbel.com/'><img src=\"https://s3.amazonaws.com/uploads.hipchat.com/583104/4019711/T3o8rSPUKtKpe4g/logo-lbel.png\" alt=\"Logo L'bel\" /></a>";
            s_html += "</td>";
            s_html += "<td style=\"width:15%; text-align:left;border-right:1px solid #FFF;\">";
            s_html += "<a href='http://www.cyzone.com/'><img src=\"https://s3.amazonaws.com/uploads.hipchat.com/583104/4019711/qZf6NJ5d9D75LCO/logo-cyzone.png\" alt=\"Logo Cyzone\" /></a>";
            s_html += "</td>";
            s_html += "<td style=\"width:15%; font-family:'Calibri'; font-weight:400; font-size:13px; color:#FFF; vertical-align:middle;\">";
            s_html += "<table align=\"center\" style=\"text-align:center; width:100%;\">";
            s_html += "<tbody>";
            s_html += "<tr>";
            s_html += "<td style=\"text-align: right; font-family:'Calibri'; font-weight:400; font-size:13px; vertical-align: middle; width: 69%; color:white;\">SÍGUENOS EN</td>";
            s_html += "<td style=\"text-align: right; position: relative; top: 2px; left: 10px; width: 20%; vertical-align: top;\"><a href='https://www.facebook.com/SomosBelcorpOficial?fref=ts'><img src=\"http://www.genesis-peru.com/mailing-belcorp/logo-facebook.png\" alt=\"Logo Facebook\" /></a></td>";
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

        public static string CuerpoCorreoActivacionCupon()
        {
            StringBuilder sBuilder = new StringBuilder();
            sBuilder.Append("This is a test for");
            return sBuilder.ToString();
        }
    }

    public class ToWithType
    {
        public string email { get; set; }
        public string name { get; set; }
        public string type { get; set; }
    }
}