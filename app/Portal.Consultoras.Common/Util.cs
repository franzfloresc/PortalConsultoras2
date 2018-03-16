﻿using Belcorp.Security.Federation.Connections;
using ClosedXML.Excel;
using MaxMind.Db;
using MaxMind.Util;
using Microsoft.IdentityModel.Protocols.WSIdentity;
using Microsoft.IdentityModel.Protocols.WSTrust;
using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.OleDb;
using System.Drawing;
using System.Drawing.Imaging;
using System.Globalization;
using System.IO;
using System.Linq;
using System.Net;
using System.Net.Mail;
using System.Net.Mime;
using System.Reflection;
using System.Security.Cryptography;
using System.ServiceModel;
using System.ServiceModel.Security;
using System.Text;
using System.Threading;
using System.Web;
using System.Web.Mvc;
using System.Web.Routing;
using System.Web.Script.Serialization;

namespace Portal.Consultoras.Common
{
    public class Util
    {
        static public int ParseInt(object value)
        {
            int number;
            bool result = int.TryParse(ParseString(value), out number);
            return result ? number : 0;
        }
        
        static public Int32 ParseInt32(object value)
        {
            Int32 number;
            bool result = Int32.TryParse(ParseString(value), out number);
            return result ? number : 0;
        }
        
        static public Int64 ParseInt64(object value)
        {
            Int64 number;
            bool result = Int64.TryParse(ParseString(value), out number);
            return result ? number : 0;

        }
        
        static public Double ParseDouble(object value)
        {
            Double number;
            bool result = Double.TryParse(ParseString(value), out number);
            return result ? number : 0;
        }

        static public Double ParseDouble(object value, Int32 NumDecimales)
        {
            Double number;
            bool result = Double.TryParse(ParseString(value), out number);
            return result ? RoundDouble(number, NumDecimales) : 0;
        }
        
        static public Double RoundDouble(Double value, Int32 NumDecimales)
        {
            return Math.Round(value, NumDecimales);
        }

        static public String ParseString(object value)
        {
            var cadena = Convert.ToString(value);
            return !string.IsNullOrEmpty(cadena) ? cadena : String.Empty;
        }
        
        static public String ParseStringNullable(int? value)
        {
            if (value == null)
                return String.Empty;
            
            String cadena = Convert.ToString(value.Value);
            return !string.IsNullOrEmpty(cadena) ? cadena : String.Empty;
        }
        
        static public DateTime? ParseDate(object value)
        {
            DateTime date;
            bool result = DateTime.TryParse(ParseString(value), out date);
            return result ? (DateTime?) date : null;
        }
        
        static public DateTime? ParseDate(object value, string format)
        {
            if (ParseDate(value) == null) return null;
            return DateTime.ParseExact(ParseString(value), format, null);
        }
        
        static public DateTime? ParseDate(object value, string format, CultureInfo culture)
        {
            if (ParseDate(value) != null) return null;
            return DateTime.ParseExact(ParseString(value), format, culture);
        }
        
        public static DateTime TruncateDate(DateTime value)
        {
            var iDay = value.Day;
            var iMonth = value.Month;
            var iYear = value.Year;

            DateTime dtValue = new DateTime(iYear, iMonth, iDay);

            return dtValue;
        }

        /// <summary>
        /// Valida si un objecto es de tipo numérico
        /// </summary>
        /// <param name="value">objecto a verificar</param>
        /// <returns>true o false sea el caso</returns>
        static public bool IsNumeric(object value)
        {
            double numero;
            var resultado = Double.TryParse(Convert.ToString(value), System.Globalization.NumberStyles.Any, System.Globalization.NumberFormatInfo.InvariantInfo, out numero);
            return resultado;

        }

        public static long DateDiff(Enumeradores.DateInterval Interval, System.DateTime StartDate, System.DateTime EndDate)
        {
            long lngDateDiffValue = 0;
            System.TimeSpan TS = new System.TimeSpan(EndDate.Ticks - StartDate.Ticks);
            switch (Interval)
            {
                case Enumeradores.DateInterval.Day:
                    lngDateDiffValue = (long)TS.Days;
                    break;
                case Enumeradores.DateInterval.Hour:
                    lngDateDiffValue = (long)TS.TotalHours;
                    break;
                case Enumeradores.DateInterval.Minute:
                    lngDateDiffValue = (long)TS.TotalMinutes;
                    break;
                case Enumeradores.DateInterval.Month:
                    lngDateDiffValue = (long)(TS.Days / 30);
                    break;
                case Enumeradores.DateInterval.Quarter:
                    lngDateDiffValue = (long)((TS.Days / 30) / 3);
                    break;
                case Enumeradores.DateInterval.Second:
                    lngDateDiffValue = (long)TS.TotalSeconds;
                    break;
                case Enumeradores.DateInterval.Week:
                    lngDateDiffValue = (long)(TS.Days / 7);
                    break;
                case Enumeradores.DateInterval.Year:
                    lngDateDiffValue = (long)(TS.Days / 365);
                    break;
            }
            return lngDateDiffValue;
        }
        
        static public long ToUnixTimespan(DateTime date)
        {
            TimeSpan tspan = date.ToUniversalTime().Subtract(
                new DateTime(1970, 1, 1, 0, 0, 0));

            return (long)Math.Truncate(tspan.TotalSeconds);
        }

        /// <summary>
        /// Metodo para convertir a un Unix TimeSpan to a regular System.DataTime
        /// </summary>
        /// <param name="timespan"></param>
        /// <returns>valor que va ser convertido</returns>
        static public DateTime? UnixTimespanToDate(double? timestamp)
        {
            try
            {
                if (timestamp == null)
                    return null;

                DateTime converted = new DateTime(1970, 1, 1, 0, 0, 0, 0);
                DateTime newDateTime = converted.AddSeconds(timestamp.Value);
                return newDateTime;
            }
            catch (Exception)
            {
                return null;
            }

        }

        /// <summary>
        /// Metodo que permite generar una cadena aleatoria de 8 digitos
        /// </summary>
        /// <returns></returns>
        public static string CadenaAleatoria()
        {
            try
            {
                var txtBuil = new StringBuilder();
                Random objAleatorio = new Random();
                for (int i = 0; i < 8; i++)
                {
                    txtBuil.Append(objAleatorio.Next(0, 10).ToString());
                }
                return txtBuil.ToString();
            }
            catch (Exception)
            {
                return "";
            }
        }

        /// <summary>
        /// Metodo que permite generar una identificador unico global
        /// </summary>
        public static string GenerarGUID()
        {
            return System.Guid.NewGuid().ToString().Replace("-", "").Substring(0, 10);
        }

        /// <summary>
        /// Metodo que permite el envio de correos
        /// </summary>
        /// <param name="strDe">Remitentente</param>
        /// <param name="strPara">Receptor</param>
        /// <param name="strTitulo">Subject o Asunto</param>
        /// <param name="strMensaje">Conteneido del Mensaje</param>
        /// <param name="isHTML">Flag que indica si es HTML o no</param>
        /// <param name="Tags">Tag del elemento</param>
        /// <returns></returns>
        public static bool EnviarMailMobile(string strDe, string strPara, string strTitulo, string strMensaje, bool isHTML, string displayNameDe)
        {
            if (string.IsNullOrEmpty(strPara))
                return true;

            if (strPara.ToLower().Contains("ñ") || strPara.ToLower().Contains("á") || strPara.ToLower().Contains("é") ||
                strPara.ToLower().Contains("í") || strPara.ToLower().Contains("ó") || strPara.ToLower().Contains("ú"))
                return true;

            RegexUtilities emailutil = new RegexUtilities();
            if (!emailutil.IsValidEmail(strPara))
                return true;

            string strServidor = ParseString(ConfigurationManager.AppSettings["SMPTServer"]);
            string strUsuario = ParseString(ConfigurationManager.AppSettings["SMPTUser"]);
            string strPassword = ParseString(ConfigurationManager.AppSettings["SMPTPassword"]);

            MailMessage objMail = new MailMessage();
            SmtpClient objClient = new SmtpClient(strServidor);

            AlternateView avHtml = AlternateView.CreateAlternateViewFromString(strMensaje, null, MediaTypeNames.Text.Html);

            LinkedResource logo = new LinkedResource(HttpContext.Current.Request.MapPath("~/Content/Images/Logo.gif"), MediaTypeNames.Image.Gif);
            logo.ContentId = "Logo";
            avHtml.LinkedResources.Add(logo);

            if (ParseString(ConfigurationManager.AppSettings["flagCorreo"]) == "0")
            {
                strPara = strUsuario;
            }
            objMail.AlternateViews.Add(avHtml);
            objMail.To.Add(strPara);

            objMail.From = string.IsNullOrEmpty(displayNameDe) 
                ? new MailAddress(strDe)
                : new MailAddress(strDe, displayNameDe);

            objMail.Subject = strTitulo;
            objMail.Body = "<HTML><head><META http-equiv=Content-Type content=\"text/html; \"></head><body> " + strMensaje + "</body></HTML>";
            objMail.IsBodyHtml = isHTML;

            NetworkCredential credentials = new NetworkCredential(strUsuario, strPassword);
            objClient.EnableSsl = true;
            objClient.Credentials = credentials;

            try
            {
                objClient.Send(objMail);
            }
            catch (Exception ex)
            {
                throw new ApplicationException("Error al enviar correo electronico:" + ex.Message);
            }
            finally
            {
                objMail.Dispose();
            }
            return true;
        }
        public static bool EnviarMailMobile(string strDe, string strPara, string strTitulo, string strMensaje, bool isHTML)
        {
            return Util.EnviarMailMobile(strDe, strPara, strTitulo, strMensaje, isHTML, null);
        }

        public static bool EnviarMail(string strDe, string strPara, string strTitulo, string strMensaje, bool isHTML, string displayNameDe)
        {
            if (string.IsNullOrEmpty(strPara))
                return true;

            if (strPara.ToLower().Contains("ñ") || strPara.ToLower().Contains("á") || strPara.ToLower().Contains("é") ||
                strPara.ToLower().Contains("í") || strPara.ToLower().Contains("ó") || strPara.ToLower().Contains("ú"))
                return true;

            RegexUtilities emailutil = new RegexUtilities();
            if (!emailutil.IsValidEmail(strPara))
                return true;

            string strServidor = ParseString(ConfigurationManager.AppSettings["SMPTServer"]);
            string strUsuario = ParseString(ConfigurationManager.AppSettings["SMPTUser"]);
            string strPassword = ParseString(ConfigurationManager.AppSettings["SMPTPassword"]);

            MailMessage objMail = new MailMessage();
            SmtpClient objClient = new SmtpClient(strServidor);

            AlternateView avHtml = AlternateView.CreateAlternateViewFromString(strMensaje, null, MediaTypeNames.Text.Html);

            if (ParseString(ConfigurationManager.AppSettings["flagCorreo"]) == "0")
            {
                strPara = strUsuario;
            }
            objMail.AlternateViews.Add(avHtml);
            objMail.To.Add(strPara);
            objMail.From = string.IsNullOrEmpty(displayNameDe)
                ? new MailAddress(strDe) 
                : new MailAddress(strDe, displayNameDe);
            objMail.Subject = strTitulo;
            objMail.Body = "<HTML><head><META http-equiv=Content-Type content=\"text/html; \"></head><body> " + strMensaje + "</body></HTML>";
            objMail.IsBodyHtml = isHTML;

            NetworkCredential credentials = new NetworkCredential(strUsuario, strPassword);
            objClient.EnableSsl = true;
            objClient.Credentials = credentials;

            try
            {
                objClient.Send(objMail);
            }
            catch (Exception ex)
            {
                throw new ApplicationException("Error al enviar correo electronico:" + ex.Message);
            }
            finally
            {
                objMail.Dispose();
            }
            return true;
        }
        public static bool EnviarMail(string strDe, string strPara, string strTitulo, string strMensaje, bool isHTML)
        {
            return Util.EnviarMail(strDe, strPara, strTitulo, strMensaje, isHTML, null);
        }
        public static bool EnviarMail(string strDe, string strPara, string strParaOculto, string strTitulo, string strMensaje, bool isHTML, string displayNameDe = null, bool IndicadorSimplificacionCUV = false)
        {
            if (string.IsNullOrEmpty(strPara))
                return false;

            if (strPara.ToLower().Contains("ñ") || strPara.ToLower().Contains("á") || strPara.ToLower().Contains("é") ||
                strPara.ToLower().Contains("í") || strPara.ToLower().Contains("ó") || strPara.ToLower().Contains("ú"))
                return false;

            RegexUtilities emailutil = new RegexUtilities();
            if (!emailutil.IsValidEmail(strPara))
                return false;

            string strServidor = ParseString(ConfigurationManager.AppSettings["SMPTServer"]);
            string strUsuario = ParseString(ConfigurationManager.AppSettings["SMPTUser"]);
            string strPassword = ParseString(ConfigurationManager.AppSettings["SMPTPassword"]);

            MailMessage objMail = new MailMessage();
            SmtpClient objClient = new SmtpClient(strServidor);

            AlternateView avHtml = AlternateView.CreateAlternateViewFromString(strMensaje, null, MediaTypeNames.Text.Html);

            objMail.To.Add(strPara);
            objMail.From = string.IsNullOrEmpty(displayNameDe) 
                ? new MailAddress(strDe) 
                : new MailAddress(strDe, displayNameDe);

            objMail.Subject = strTitulo;
            if (FileExists(HttpContext.Current.Request.MapPath("/Content/Images/indicador.png")) && FileExists(HttpContext.Current.Request.MapPath("/Content/Images/belcorp_logo.png")))
            {
                LinkedResource iconoSimplificacion = new LinkedResource(HttpContext.Current.Request.MapPath("../Content/Images/indicador.png"), MediaTypeNames.Image.Gif);
                LinkedResource logo = new LinkedResource(HttpContext.Current.Request.MapPath("../Content/Images/belcorp_logo.png"), MediaTypeNames.Image.Gif);
                logo.ContentId = "Logo";
                avHtml.LinkedResources.Add(logo);

                objMail.AlternateViews.Add(avHtml);


                if (IndicadorSimplificacionCUV)
                {
                    iconoSimplificacion.ContentId = "IconoIndicador";
                    avHtml.LinkedResources.Add(iconoSimplificacion);
                    objMail.Body = "<HTML><head><META http-equiv=Content-Type content=\"text/html; \"></head><body> " + String.Format(strMensaje, iconoSimplificacion.ContentId) + "</body></HTML>";
                }
                else
                {
                    objMail.Body = "<HTML><head><META http-equiv=Content-Type content=\"text/html; \"></head><body> " + strMensaje + "</body></HTML>";
                }
            }
            else
            {
                objMail.AlternateViews.Add(avHtml);
                objMail.Body = "<HTML><head><META http-equiv=Content-Type content=\"text/html; \"></head><body> " + strMensaje + "</body></HTML>";
            }
            objMail.IsBodyHtml = isHTML;
            NetworkCredential credentials = new NetworkCredential(strUsuario, strPassword);
            objClient.EnableSsl = true;
            objClient.Credentials = credentials;

            try
            {
                objClient.Send(objMail);
            }
            catch (Exception ex)
            {
                throw new ApplicationException("Error al enviar correo electronico:" + ex.Message);
            }
            finally
            {
                objMail.Dispose();
            }
            return true;
        }
        public static bool EnviarMail(string strDe, string strPara, string strParaOculto, string strTitulo, string strMensaje, bool isHTML)
        {
            return Util.EnviarMail(strDe, strPara, strParaOculto, strTitulo, strMensaje, isHTML, null, false);
        }

        public static bool EnviarMail3(string strDe, string strPara, string strTitulo, string strMensaje, bool isHTML, string strBcc, string strFile, string displayNameDe)
        {
            if (string.IsNullOrEmpty(strPara))
                return true;

            if (strPara.ToLower().Contains("ñ") || strPara.ToLower().Contains("á") || strPara.ToLower().Contains("é") ||
                strPara.ToLower().Contains("í") || strPara.ToLower().Contains("ó") || strPara.ToLower().Contains("ú"))
                return true;

            RegexUtilities emailutil = new RegexUtilities();
            if (!emailutil.IsValidEmail(strPara))
                return true;

            string strServidor = ParseString(ConfigurationManager.AppSettings["SMPTServer"]);
            string strUsuario = ParseString(ConfigurationManager.AppSettings["SMPTUser"]);
            string strPassword = ParseString(ConfigurationManager.AppSettings["SMPTPassword"]);

            MailMessage objMail = new MailMessage();
            SmtpClient objClient = new SmtpClient(strServidor);

            AlternateView avHtml = AlternateView.CreateAlternateViewFromString(strMensaje, null, MediaTypeNames.Text.Html);

            LinkedResource logo = new LinkedResource(HttpContext.Current.Request.MapPath("../Content/Images/logotipo_belcorp_05.png"), MediaTypeNames.Image.Gif);
            logo.ContentId = "Logo";
            avHtml.LinkedResources.Add(logo);

            if (ParseString(ConfigurationManager.AppSettings["flagCorreo"]) == "0")
                strPara = strUsuario;

            objMail.AlternateViews.Add(avHtml);
            objMail.To.Add(strPara);

            objMail.From = string.IsNullOrEmpty(displayNameDe) 
                ? new MailAddress(strDe)
                : new MailAddress(strDe, displayNameDe);

            objMail.Subject = strTitulo;
            objMail.Body = "<HTML><head><META http-equiv=Content-Type content=\"text/html; \"></head><body> " + strMensaje + "</body></HTML>";
            objMail.IsBodyHtml = isHTML;

            Attachment data = new Attachment(strFile, MediaTypeNames.Application.Pdf);
            objMail.Attachments.Add(data);

            NetworkCredential credentials = new NetworkCredential(strUsuario, strPassword);
            objClient.EnableSsl = true;
            objClient.Credentials = credentials;

            try
            {
                objClient.Send(objMail);
            }
            catch (Exception ex)
            {
                throw new ApplicationException("Error al enviar correo electronico:" + ex.Message);
            }
            finally
            {
                objMail.Dispose();
            }
            return true;
        }
        public static bool EnviarMail3(string strDe, string strPara, string strTitulo, string strMensaje, bool isHTML, string strBcc, string displayNameDe)
        {
            if (string.IsNullOrEmpty(strPara))
                return true;

            if (strPara.ToLower().Contains("ñ") || strPara.ToLower().Contains("á") || strPara.ToLower().Contains("é") ||
                strPara.ToLower().Contains("í") || strPara.ToLower().Contains("ó") || strPara.ToLower().Contains("ú"))
                return true;

            RegexUtilities emailutil = new RegexUtilities();
            if (!emailutil.IsValidEmail(strPara))
                return true;

            string strServidor = ParseString(ConfigurationManager.AppSettings["SMPTServer"]);
            string strUsuario = ParseString(ConfigurationManager.AppSettings["SMPTUser"]);
            string strPassword = ParseString(ConfigurationManager.AppSettings["SMPTPassword"]);

            MailMessage objMail = new MailMessage();
            SmtpClient objClient = new SmtpClient(strServidor);

            AlternateView avHtml = AlternateView.CreateAlternateViewFromString(String.Format(strMensaje, "Logo"), null, MediaTypeNames.Text.Html);

            LinkedResource logo = new LinkedResource(HttpContext.Current.Request.MapPath("../Content/Images/logotipo_belcorp_05.png"), MediaTypeNames.Image.Gif);
            logo.ContentId = "Logo";
            avHtml.LinkedResources.Add(logo);

            if (ParseString(ConfigurationManager.AppSettings["flagCorreo"]) == "0")
            {
                strPara = strUsuario;
            }
            objMail.AlternateViews.Add(avHtml);
            objMail.To.Add(strPara);
            objMail.From = string.IsNullOrEmpty(displayNameDe)
                ? new MailAddress(strDe)
                : new MailAddress(strDe, displayNameDe);

            objMail.Subject = strTitulo;
            objMail.Body = "<HTML><head><META http-equiv=Content-Type content=\"text/html; \"></head><body> " + String.Format(strMensaje, logo.ContentId) + "</body></HTML>";
            objMail.IsBodyHtml = isHTML;

            NetworkCredential credentials = new NetworkCredential(strUsuario, strPassword);
            objClient.EnableSsl = true;
            objClient.Credentials = credentials;

            try
            {
                objClient.Send(objMail);
            }
            catch (Exception ex)
            {
                throw new ApplicationException("Error al enviar correo electronico:" + ex.Message);
            }
            finally
            {
                objMail.Dispose();
            }
            return true;
        }
        public static bool EnviarMail3(string strDe, string strPara, string strTitulo, string strMensaje, bool isHTML, string strBcc)
        {
            return Util.EnviarMail3(strDe, strPara, strTitulo, strMensaje, isHTML, strBcc, null);
        }

        public static bool EnviarMail2(string strDe, string strPara, string strTitulo, string strMensaje, bool isHTML, string Tags, string strRemitente)
        {
            string strUrl = ParseString(ConfigurationManager.AppSettings["SMPTURL"]);
            string strUsuario = ParseString(ConfigurationManager.AppSettings["SMPTUser"]);
            string strPassword = ParseString(ConfigurationManager.AppSettings["SMPTPassword"]);

            if (ParseString(ConfigurationManager.AppSettings["flagCorreo"]) == "0")
            {
                strPara = strUsuario;
            }

            MandrillMail oMail = new MandrillMail();

            List<To> to_ = new List<To>
            {
                new To
                {
                    email = strPara
                }
            };

            byte[] bytes_;
            using (var img = Image.FromFile(HttpContext.Current.Request.MapPath("../Content/Images/Logo.gif")))
            {
                using (MemoryStream ms = new MemoryStream())
                {
                    img.Save(ms, ImageFormat.Gif);
                    bytes_ = ms.ToArray();
                }
            }

            List<Images> Images_ = new List<Images>
            {
                new Images
                {
                    type = "image/gif",
                    name = "Logo",
                    content = Convert.ToBase64String(bytes_)
                }
            };

            oMail.key = strPassword;
            oMail.message = new Message
            {
                html = "<HTML><head><META http-equiv=Content-Type content=\"text/html; \"></head><body> " + AcentosCaracteres(strMensaje) + "</body></HTML>",
                text = null,
                subject = strTitulo,
                from_email = strDe,
                from_name = (string.IsNullOrEmpty(strRemitente) ? null : strRemitente),
                to = to_,
                important = false,
                bcc_address = null,
                tags = (string.IsNullOrEmpty(Tags) ? new string[] { } : new string[] { Tags }),
                images = Images_,
                async = false
            };

            string jsonData = new JavaScriptSerializer().Serialize(oMail);

            HttpWebRequest request = (HttpWebRequest)WebRequest.Create(strUrl);
            request.Method = "POST";
            request.ContentType = "application/json";
            bytes_ = Encoding.UTF8.GetBytes(jsonData);
            request.ContentLength = bytes_.Length;
            using (Stream webStream = request.GetRequestStream())
            {
                webStream.Write(bytes_, 0, bytes_.Length);
            }

            try
            {
                WebResponse webResponse = request.GetResponse();
                using (Stream webStream = webResponse.GetResponseStream())
                {
                    if (webStream != null)
                    {
                        using (StreamReader responseReader = new StreamReader(webStream))
                        {
                            responseReader.ReadToEnd();
                        }
                    }
                }
            }
            catch (Exception ex)
            {
                throw new ApplicationException("Error al enviar correo electronico:" + ex.Message);
            }
            return true;
        }
        public static bool EnviarMail2(string strDe, string strPara, string strTitulo, string strMensaje, bool isHTML, string Tag)
        {
            return Util.EnviarMail2(strDe, strPara, strTitulo, strMensaje, isHTML, Tag, null);
        }

        public static bool EnviarMailPedido(string strDe, string strPara, string strParaOculto, string strTitulo, string strMensaje, bool isHTML, string displayNameDe)
        {
            if (string.IsNullOrEmpty(strPara))
                return false;

            if (strPara.ToLower().Contains("ñ") || strPara.ToLower().Contains("á") || strPara.ToLower().Contains("é") ||
                strPara.ToLower().Contains("í") || strPara.ToLower().Contains("ó") || strPara.ToLower().Contains("ú"))
                return false;

            RegexUtilities emailutil = new RegexUtilities();
            if (!emailutil.IsValidEmail(strPara))
                return false;

            string strServidor = ParseString(ConfigurationManager.AppSettings["SMPTServer"]);
            string strUsuario = ParseString(ConfigurationManager.AppSettings["SMPTUser"]);
            string strPassword = ParseString(ConfigurationManager.AppSettings["SMPTPassword"]);

            MailMessage objMail = new MailMessage();
            SmtpClient objClient = new SmtpClient(strServidor);

            AlternateView avHtml = AlternateView.CreateAlternateViewFromString(String.Format(strMensaje, "Logo"), null, MediaTypeNames.Text.Html);

            LinkedResource logo = new LinkedResource(HttpContext.Current.Request.MapPath("../Content/Images/belcorp_logo.png"), MediaTypeNames.Image.Gif);
            logo.ContentId = "Logo";
            avHtml.LinkedResources.Add(logo);

            objMail.AlternateViews.Add(avHtml);
            objMail.To.Add(strPara);
            objMail.From = string.IsNullOrEmpty(displayNameDe) 
                ? new MailAddress(strDe) 
                : new MailAddress(strDe, displayNameDe);
            objMail.Subject = strTitulo;
            objMail.Body = "<HTML><head><META http-equiv=Content-Type content=\"text/html; \"></head><body> " + strMensaje + "</body></HTML>";
            objMail.IsBodyHtml = isHTML;

            NetworkCredential credentials = new NetworkCredential(strUsuario, strPassword);
            objClient.EnableSsl = true;
            objClient.Credentials = credentials;

            try
            {
                objClient.Send(objMail);
            }
            catch (Exception ex)
            {
                throw new ApplicationException("Error al enviar correo electronico:" + ex.Message);
            }
            finally
            {
                objMail.Dispose();
            }
            return true;
        }
        public static bool EnviarMailPedido(string strDe, string strPara, string strParaOculto, string strTitulo, string strMensaje, bool isHTML)
        {
            return Util.EnviarMailPedido(strDe, strPara, strParaOculto, strTitulo, strMensaje, isHTML, null);
        }


        public static bool EnviarMail3Mobile(string strDe, string strPara, string strTitulo, string strMensaje, bool isHTML, string strBcc, string displayNameDe)
        {
            if (string.IsNullOrEmpty(strPara))
                return true;

            if (strPara.ToLower().Contains("ñ") || strPara.ToLower().Contains("á") || strPara.ToLower().Contains("é") ||
                strPara.ToLower().Contains("í") || strPara.ToLower().Contains("ó") || strPara.ToLower().Contains("ú"))
                return true;

            RegexUtilities emailutil = new RegexUtilities();
            if (!emailutil.IsValidEmail(strPara))
                return true;

            string strServidor = ParseString(ConfigurationManager.AppSettings["SMPTServer"]);
            string strUsuario = ParseString(ConfigurationManager.AppSettings["SMPTUser"]);
            string strPassword = ParseString(ConfigurationManager.AppSettings["SMPTPassword"]);

            MailMessage objMail = new MailMessage();
            SmtpClient objClient = new SmtpClient(strServidor);

            AlternateView avHtml = AlternateView.CreateAlternateViewFromString(String.Format(strMensaje, "Logo"), null, MediaTypeNames.Text.Html);

            LinkedResource logo = new LinkedResource(HttpContext.Current.Request.MapPath("~/Content/Images/logotipo_belcorp_05.png"), MediaTypeNames.Image.Gif);
            logo.ContentId = "Logo";
            avHtml.LinkedResources.Add(logo);

            if (ParseString(ConfigurationManager.AppSettings["flagCorreo"]) == "0")
            {
                strPara = strUsuario;
            }
            objMail.AlternateViews.Add(avHtml);
            objMail.To.Add(strPara);
            objMail.From = string.IsNullOrEmpty(displayNameDe)
                ? new MailAddress(strDe)
                : new MailAddress(strDe, displayNameDe);

            objMail.Subject = strTitulo;
            objMail.Body = "<HTML><head><META http-equiv=Content-Type content=\"text/html; \"></head><body> " + String.Format(strMensaje, logo.ContentId) + "</body></HTML>";
            objMail.IsBodyHtml = isHTML;

            NetworkCredential credentials = new NetworkCredential(strUsuario, strPassword);
            objClient.EnableSsl = true;
            objClient.Credentials = credentials;

            try
            {
                objClient.Send(objMail);
            }
            catch (Exception ex)
            {
                throw new ApplicationException("Error al enviar correo electronico:" + ex.Message);
            }
            finally
            {
                objMail.Dispose();
            }
            return true;
        }
        public static bool EnviarMail3Mobile(string strDe, string strPara, string strTitulo, string strMensaje, bool isHTML, string strBcc)
        {
            return Util.EnviarMail3Mobile(strDe, strPara, strTitulo, strMensaje, isHTML, strBcc, null);
        }

        /// <summary>
        /// Metodo que permite el envio de correos
        /// </summary>
        /// <param name="strDe">Remitentente</param>
        /// <param name="strPara">Receptor</param>
        /// <param name="strTitulo">Subject o Asunto</param>
        /// <param name="strMensaje">Conteneido del Mensaje</param>
        /// <param name="isHTML">Flag que indica si es HTML o no</param>
        /// <returns></returns>
        public static bool EnviarMailMasivo(string strDe, string[] strPara, string strTitulo, string strMensaje, bool isHTML)
        {
            try
            {
                string strServidor = ParseString(ConfigurationManager.AppSettings["SMPTServer"]);
                string strUsuario = ParseString(ConfigurationManager.AppSettings["SMPTUser"]);
                string strPassword = ParseString(ConfigurationManager.AppSettings["SMPTPassword"]);

                ThreadPool.QueueUserWorkItem(callback =>
                {
                    using (MailMessage objMail = new MailMessage())
                    {
                        AlternateView avHtml = AlternateView.CreateAlternateViewFromString(strMensaje, null, MediaTypeNames.Text.Html);

                        objMail.AlternateViews.Add(avHtml);
                        foreach (var item in strPara)
                        {
                            objMail.Bcc.Add(item);
                        }
                        objMail.From = new MailAddress(strDe);
                        objMail.Subject = strTitulo;
                        objMail.Body = "<HTML><head><META http-equiv=Content-Type content=\"text/html; \"></head><body> " + strMensaje + "</body></HTML>";
                        objMail.IsBodyHtml = isHTML;
                        objMail.BodyEncoding = UTF8Encoding.UTF8;

                        using (SmtpClient objClient = new SmtpClient(strServidor))
                        {
                            NetworkCredential credentials = new NetworkCredential(strUsuario, strPassword);
                            objClient.EnableSsl = true; 
                            objClient.Credentials = credentials;
                            objClient.Send(objMail);
                        }
                    }
                });
            }
            catch (Exception)
            {
                throw new ApplicationException("Error al enviar correo electronico");
            }
            return true;
        }

        public static bool EnviarMailMasivoColas(string strDe, string strPara, string strTitulo, string strMensaje, bool isHTML, string displayNameDe)
        {
            if (string.IsNullOrEmpty(strPara))
                return true;

            if (strPara.ToLower().Contains("ñ") || strPara.ToLower().Contains("á") || strPara.ToLower().Contains("é") ||
                strPara.ToLower().Contains("í") || strPara.ToLower().Contains("ó") || strPara.ToLower().Contains("ú"))
                return true;

            RegexUtilities emailutil = new RegexUtilities();
            if (!emailutil.IsValidEmail(strPara))
                return true;

            try
            {
                string strServidor = ParseString(ConfigurationManager.AppSettings["SMPTServer"]);
                string strUsuario = ParseString(ConfigurationManager.AppSettings["SMPTUser"]);
                string strPassword = ParseString(ConfigurationManager.AppSettings["SMPTPassword"]);

                ThreadPool.QueueUserWorkItem(callback =>
                {
                    using (MailMessage objMail = new MailMessage())
                    {
                        objMail.To.Add(strPara);
                        objMail.From = string.IsNullOrEmpty(displayNameDe) 
                            ? new MailAddress(strDe) 
                            : new MailAddress(strDe, displayNameDe);
                        objMail.Subject = strTitulo;
                        objMail.Body = "<html><head><META http-equiv=Content-Type content=\"text/html; \"></head><body style=\"font-family:Arial, Helvetica, sans-serif; font-size: 12px; color:#333333; margin:0; padding:0; background-color:#F0F0F0;\"> " + strMensaje + "</body></html>";
                        objMail.IsBodyHtml = isHTML;
                        objMail.BodyEncoding = UTF8Encoding.UTF8;

                        using (SmtpClient objClient = new SmtpClient(strServidor))
                        {
                            NetworkCredential credentials = new NetworkCredential(strUsuario, strPassword);
                            objClient.EnableSsl = true;
                            objClient.Credentials = credentials;
                            objClient.Send(objMail);
                        }
                    }
                });
            }
            catch (Exception)
            {
                throw new ApplicationException("Error al enviar correo electronico");
            }
            return true;
        }
        public static bool EnviarMailMasivoColas(string strDe, string strPara, string strTitulo, string strMensaje, bool isHTML)
        {
            return Util.EnviarMailMasivoColas(strDe, strPara, strTitulo, strMensaje, isHTML, null);
        }

        public static bool EnviarMailMasivoColas2(string strDe, string strPara, string strTitulo, string strMensaje, bool isHTML, string tags, string displayNameDe)
        {
            string strUrl = ParseString(ConfigurationManager.AppSettings["SMPTURL"]);
            string strPassword = ParseString(ConfigurationManager.AppSettings["SMPTPassword"]);
            try
            {
                ThreadPool.QueueUserWorkItem(callback =>
                {
                    MandrillMail oMail = new MandrillMail();

                    List<To> to_ = new List<To>
                    {
                        new To
                        {
                            email = strPara
                        }
                    };

                    oMail.key = strPassword;
                    oMail.message = new Message
                    {
                        html = "<html><head><META http-equiv=Content-Type content=\"text/html; \"></head><body style=\"font-family:Arial, Helvetica, sans-serif; font-size: 12px; color:#333333; margin:0; padding:0; background-color:#F0F0F0;\"> " + AcentosCaracteres(strMensaje) + "</body></html>",
                        text = null,
                        subject = strTitulo,
                        from_email = strDe,
                        from_name = displayNameDe,
                        to = to_,
                        important = false,
                        bcc_address = null,
                        tags = (string.IsNullOrEmpty(tags) ? new string[] { } : new string[] { tags }),
                        async = true
                    };

                    string jsonData = new JavaScriptSerializer().Serialize(oMail);

                    HttpWebRequest request = (HttpWebRequest)WebRequest.Create(strUrl);
                    request.Method = "POST";
                    request.ContentType = "application/json";
                    byte[] bytes_ = Encoding.UTF8.GetBytes(jsonData);
                    request.ContentLength = bytes_.Length;
                    using (Stream webStream = request.GetRequestStream())
                    {
                        webStream.Write(bytes_, 0, bytes_.Length);
                    }

                    try
                    {
                        WebResponse webResponse = request.GetResponse();
                        using (Stream webStream = webResponse.GetResponseStream())
                        {
                            if (webStream != null)
                            {
                                using (StreamReader responseReader = new StreamReader(webStream))
                                {
                                    responseReader.ReadToEnd();
                                }
                            }
                        }
                    }
                    catch (Exception ex)
                    {
                        throw new ApplicationException("Error al enviar correo electronico:" + ex.Message);
                    }
                });
            }
            catch (Exception)
            {
                throw new ApplicationException("Error al enviar correo electronico");
            }
            return true;
        }
        public static bool EnviarMailMasivoColas2(string strDe, string strPara, string strTitulo, string strMensaje, bool isHTML, string tags)
        {
            return Util.EnviarMailMasivoColas2(strDe, strPara, strTitulo, strMensaje, isHTML, tags, null);
        }

        /// <summary>
        /// Metodo que permite llenar la entidad de páginación para grillas sin filtros
        /// </summary>
        /// <param name="item">Entidad</param>
        /// <param name="lst">Lista Generica</param>
        /// <returns></returns>
        public static BEPager PaginadorGenerico<T>(BEGrid item, List<T> lst)
        {
            item.PageSize = item.PageSize <= 0 ? 1 : item.PageSize;

            BEPager pag = new BEPager();
            pag.RecordCount = lst.Count;
            pag.PageCount = ((pag.RecordCount - 1) / item.PageSize) + 1;
            pag.CurrentPage = item.CurrentPage > pag.PageCount ? pag.PageCount : item.CurrentPage;
            return pag;
        }

        /// <summary>
        /// Metodo que permite llenar la entidad de páginación segun la cantidad de registros total
        /// </summary>
        /// <param name="item">Entidad</param>
        /// <param name="RecordCount">Cantidad de registros total</param>
        /// <returns></returns>
        public static BEPager PaginadorGenerico(BEGrid item, int RecordCount)
        {
            BEPager pag = new BEPager();

            item.PageSize = item.PageSize <= 0 ? 1 : item.PageSize;

            int pageCount = RecordCount / item.PageSize;
            pageCount = pageCount < 1 ? 1 : pageCount;
            pageCount += RecordCount > (pageCount * item.PageSize) ? 1 : 0;

            pag.RecordCount = RecordCount;
            pag.PageCount = pageCount;

            int currentPage = item.CurrentPage;
            pag.CurrentPage = currentPage > pageCount ? pageCount : currentPage;

            return pag;
        }

        public static bool IsDate(string strValor)
        {
            try { DateTime.Parse(strValor); }
            catch (FormatException) { return false; }
            return true;
        }

        /// <summary>
        /// Metodo que valida que un archivo exista. True si existe, caso contrario False.
        /// </summary>
        /// <param name="filename">Ubicacion del archivo</param>
        /// <returns></returns>
        public static bool FileExists(string filename)
        {
            return System.IO.File.Exists(filename);
        }

        /// <summary>
        /// Metodo que valida el tipo de extension de un archivo. True si la extension corresponde al tipo de archivo, caso contrario False.
        /// </summary>
        /// <param name="filename">Ubicacion del archivo</param>
        /// <param name="TypeDocExt">Tipo de documento</param>
        /// <returns></returns>
        public static bool IsFileExtension(string filename, Enumeradores.TypeDocExtension TypeDocExt)
        {
            List<string> types = new List<string>();
            try
            {
                string ext = System.IO.Path.GetExtension(@filename).ToLower();

                switch (TypeDocExt)
                {
                    case Enumeradores.TypeDocExtension.Excel:
                        types.Add(".xls");
                        types.Add(".xlsx");
                        break;
                    case Enumeradores.TypeDocExtension.Word:
                        types.Add(".doc");
                        types.Add(".docx");
                        break;
                }

                foreach (string type in types)
                {
                    if (ext.Equals(type)) return true;
                }
                return false;
            }
            catch (Exception)
            {
                return false;
            }
        }

        /// <summary>
        /// Metodo que valida que un archivo no se encuentre abierto o se este usando por otro proceso.True si el archivo esta siendo usado, caso contrario False.
        /// </summary>
        /// <param name="path">Ubicacion del archivo</param>
        /// <returns></returns>
        public static bool IsFileOpen(string path)
        {
            FileStream fs = null;
            try
            {
                fs = new FileStream(path, FileMode.Open, FileAccess.Read, FileShare.None);
                return false;
            }
            catch (IOException)
            {
                return true;
            }
            finally
            {
                if (fs != null)
                    fs.Close();
            }
        }

        /// <summary>
        /// Metodo que lee un archivo excel y lo convierte en una lista.
        /// </summary>
        /// <typeparam name="V">Tipo de entidad</typeparam>
        /// <param name="filepath">ruta completa donde se encuentra el archivo a leer</param>
        /// <param name="Source">Entidad del cual se tomarán las propiedades como cabecera y contenido del excel</param>
        /// <param name="ReadAllSheets">Determina si se leeran todas las hojas que contiene el archivo. True todos, caso contrario False para leer solo la primera hoja.</param>
        /// <param name="IsCorrect">Devuelve True si no ocurrió problemas al leer el archivo, caso contrario False</param>
        /// <returns></returns>
        public static List<V> ReadXmlFile<V>(string filepath, V Source, bool ReadAllSheets, ref bool IsCorrect) where V : new()
        {
            string connectionString = string.Empty;
            List<V> list = null;

            try
            {
                string extension = System.IO.Path.GetExtension(@filepath).ToLower();
                if (extension.Equals(".xls"))
                {
                    // para lectura de archivos 97-2003
                    connectionString = string.Format("Provider=Microsoft.Jet.OLEDB.4.0;Data Source={0};" +
                    "Extended Properties=\"Excel 8.0;IMEX=1;HDR=YES;\"", filepath);
                }
                else if (extension.Equals(".xlsx"))
                {
                    // para lectura de archivos 2007 o posterior
                    connectionString = string.Format("Provider=Microsoft.ACE.OLEDB.12.0;Data Source={0};" +
                        "Extended Properties=\"Excel 12.0;IMEX=1;HDR=YES;\"", filepath);
                }
                List<string> sheets = new List<string>();

                using (OleDbConnection con = new OleDbConnection(connectionString))
                {
                    con.Open();
                    // Obtiene todas las hojas que tenga el documento Excel
                    DataTable schemas = con.GetOleDbSchemaTable(OleDbSchemaGuid.Tables, null);

                    if (schemas != null)
                    {
                        if (ReadAllSheets)
                        {
                            // obtiene todos los sheet names
                            sheets = schemas.AsEnumerable().Cast<DataRow>().Where(row => row["TABLE_NAME"].ToString().EndsWith("$"))
                                .Select(name => name["TABLE_NAME"].ToString()).ToList();
                        }
                        else
                        {
                            // obtiene el primer sheet name
                            sheets.Add((string)schemas.Rows[0]["TABLE_NAME"]);
                        }
                    }

                    foreach (string sheetName in sheets)
                    {
                        string commandText = "Select * From [" + sheetName + "]";

                        using (OleDbCommand select = new OleDbCommand(commandText, con))
                        {
                            using (OleDbDataReader reader = select.ExecuteReader())
                            {
                                if (reader != null)
                                {
                                    reader.GetSchemaTable();

                                    if (reader.HasRows)
                                    {
                                        list = new List<V>();
                                        while (reader.Read())
                                        {
                                            var entity = new V();
                                            foreach (System.Reflection.PropertyInfo property in Source.GetType()
                                                .GetProperties())
                                            {
                                                if (reader.HasColumn(property.Name))
                                                {
                                                    System.Reflection.PropertyInfo prop =
                                                        entity.GetType().GetProperty(property.Name);
                                                    if (prop != null)
                                                    {
                                                        Type tipo = prop.PropertyType;
                                                        object changed = Convert.ChangeType(reader[property.Name], tipo);
                                                        prop.SetValue(entity, changed, null);
                                                    }
                                                }
                                            }

                                            list.Add(entity);
                                        }
                                    }
                                }
                            }
                        }
                    }
                    IsCorrect = true;
                }
            }
            catch (Exception)
            {
                IsCorrect = false;
            }
            return list;
        }

        /// <summary>
        /// Metodo que exporta una lista a documento Excel.
        /// </summary>
        /// <typeparam name="V">Tipo de entidad</typeparam>
        /// <param name="filename">nombre del archivo sin la extension</param>
        /// <param name="Source">Lista de Entidades cuyos registros van a ser exportados a excel</param>
        /// <param name="columnDefinition">Diccionario que contiene: Nombre de las columnas a mostrar[Key], Propiedad asociada a la entidad[value]</param>
        /// <returns></returns>
        public static bool ExportToExcel<V>(string filename, List<V> Source, Dictionary<string, string> columnDefinition)
        {
            try
            {
                string extension = ".xlsx";
                string originalFileName = Path.GetFileNameWithoutExtension(filename) + extension;

                var wb = new XLWorkbook();
                var ws = wb.Worksheets.Add("Hoja1");
                List<string> columns = new List<string>();
                int index = 1;

                foreach (KeyValuePair<string, string> keyvalue in columnDefinition)
                {
                    ws.Cell(1, index).Value = keyvalue.Key;
                    index++;
                    columns.Add(keyvalue.Value);
                }
                int row = 2;
                foreach (var dataItem in (System.Collections.IEnumerable)Source)
                {
                    var col = 1;
                    foreach (string column in columns)
                    {
                        foreach (PropertyInfo property in dataItem.GetType().GetProperties())
                        {
                            if (column == property.Name)
                            {
                                if (property.PropertyType == typeof(Nullable<bool>) || property.PropertyType == typeof(bool))
                                {
                                    string value = System.Web.UI.DataBinder.GetPropertyValue(dataItem, property.Name, null);
                                    ws.Cell(row, col).Value = (string.IsNullOrEmpty(value) ? "" : (value == "True" ? "Si" : "No"));
                                }
                                else
                                {
                                    if (property.PropertyType == typeof(Nullable<DateTime>) || property.PropertyType == typeof(DateTime))
                                        ws.Cell(row, col).Style.DateFormat.Format = "dd/MM/yyyy";
                                    else
                                        ws.Cell(row, col).Style.NumberFormat.Format = "@";
                                    ws.Cell(row, col).Value = System.Web.UI.DataBinder.GetPropertyValue(dataItem, property.Name, null);

                                }
                                break;
                            }
                        }
                        col++;
                    }
                    row++;
                }
                ws.Range(1, 1, 1, index - 1).AddToNamed("Titles");

                var titlesStyle = wb.Style;
                titlesStyle.Font.Bold = true;
                titlesStyle.Alignment.Horizontal = XLAlignmentHorizontalValues.Center;
                titlesStyle.Fill.BackgroundColor = XLColor.FromHtml("#669966");

                wb.NamedRanges.NamedRange("Titles").Ranges.Style = titlesStyle;

                var stream = new MemoryStream();
                wb.SaveAs(stream);

                HttpContext.Current.Response.ClearHeaders();
                HttpContext.Current.Response.Clear();
                HttpContext.Current.Response.Buffer = false;
                HttpContext.Current.Response.AddHeader("Content-disposition", "attachment; filename=" + originalFileName);
                HttpContext.Current.Response.Charset = "UTF-8";
                HttpContext.Current.Response.Cache.SetCacheability(HttpCacheability.Private);
                HttpContext.Current.Response.ContentType = "application/octet-stream";
                HttpContext.Current.Response.BinaryWrite(stream.ToArray());
                HttpContext.Current.Response.Flush();
                HttpContext.Current.Response.End();

                return true;
            }
            catch (Exception)
            {
                return false;
            }
        }


        //Para Showroom
        public static bool ExportToExcelFormat<V>(string filename, List<V> Source, Dictionary<string, string> columnDefinition, string dateFormat)
        {
            try
            {
                string extension = ".xlsx";
                string originalFileName = Path.GetFileNameWithoutExtension(filename) + extension;

                var wb = new XLWorkbook();
                var ws = wb.Worksheets.Add("Hoja1");
                List<string> columns = new List<string>();
                int index = 1;

                foreach (KeyValuePair<string, string> keyvalue in columnDefinition)
                {
                    ws.Cell(1, index).Value = keyvalue.Key;
                    index++;
                    columns.Add(keyvalue.Value);
                }
                int row = 2;
                foreach (var dataItem in (System.Collections.IEnumerable)Source)
                {
                    var col = 1;
                    foreach (string column in columns)
                    {
                        foreach (PropertyInfo property in dataItem.GetType().GetProperties())
                        {
                            if (column == property.Name)
                            {
                                if (property.PropertyType == typeof(Nullable<bool>) || property.PropertyType == typeof(bool))
                                {
                                    string value = System.Web.UI.DataBinder.GetPropertyValue(dataItem, property.Name, null);
                                    ws.Cell(row, col).Value = (string.IsNullOrEmpty(value) ? "" : (value == "True" ? "Si" : "No"));
                                }
                                else
                                {
                                    if (property.PropertyType == typeof(Nullable<DateTime>) || property.PropertyType == typeof(DateTime))
                                        ws.Cell(row, col).Style.DateFormat.Format = !string.IsNullOrWhiteSpace(dateFormat)? dateFormat: "dd/MM/yyyy";
                                    else
                                        ws.Cell(row, col).Style.NumberFormat.Format = "@";
                                    ws.Cell(row, col).Value = System.Web.UI.DataBinder.GetPropertyValue(dataItem, property.Name, null);

                                }
                                break;
                            }
                        }
                        col++;
                    }
                    row++;
                }
                ws.Range(1, 1, 1, index - 1).AddToNamed("Titles");

                var titlesStyle = wb.Style;
                titlesStyle.Font.Bold = true;
                titlesStyle.Alignment.Horizontal = XLAlignmentHorizontalValues.Center;
                titlesStyle.Fill.BackgroundColor = XLColor.FromHtml("#669966");

                wb.NamedRanges.NamedRange("Titles").Ranges.Style = titlesStyle;

                var stream = new MemoryStream();
                wb.SaveAs(stream);

                HttpContext.Current.Response.ClearHeaders();
                HttpContext.Current.Response.Clear();
                HttpContext.Current.Response.Buffer = false;
                HttpContext.Current.Response.AddHeader("Content-disposition", "attachment; filename=" + originalFileName);
                HttpContext.Current.Response.Charset = "UTF-8";
                HttpContext.Current.Response.Cache.SetCacheability(HttpCacheability.Private);
                HttpContext.Current.Response.ContentType = "application/octet-stream";
                HttpContext.Current.Response.BinaryWrite(stream.ToArray());
                HttpContext.Current.Response.Flush();
                HttpContext.Current.Response.End();

                return true;
            }
            catch (Exception)
            {
                return false;
            }
        }

        /// <summary>
        /// Metodo que exporta una lista a documento Excel.
        /// </summary>
        /// <typeparam name="V">Tipo de entidad</typeparam>
        /// <param name="filename">nombre del archivo sin la extension</param>
        /// <param name="Source">Lista de Entidades cuyos registros van a ser exportados a excel</param>
        /// <param name="columnDefinition">Diccionario que contiene: Nombre de las columnas a mostrar[Key], Propiedad asociada a la entidad[value]</param>
        /// <returns></returns>
        public static bool ExportToExcelManySheets<V>(string filename, List<List<V>> Sources, List<Dictionary<string, string>> columnDefinitions, List<string> nombresHojas, int sizeColumn)
        {
            try
            {
                string extension = ".xlsx";
                string originalFileName = Path.GetFileNameWithoutExtension(filename) + extension;

                var wb = new XLWorkbook();
                for (int i = 0; i < Sources.Count; i++)
                {
                    var ws = wb.Worksheets.Add(nombresHojas[i]);
                    List<string> columns = new List<string>();
                    int index = 1;

                    foreach (KeyValuePair<string, string> keyvalue in columnDefinitions[i])
                    {
                        ws.Cell(1, index).Value = keyvalue.Key;
                        index++;
                        columns.Add(keyvalue.Value);
                    }
                    int row = 2;
                    foreach (var dataItem in (System.Collections.IEnumerable)Sources[i])
                    {
                        var col = 1;
                        foreach (string column in columns)
                        {
                            foreach (PropertyInfo property in dataItem.GetType().GetProperties())
                            {
                                if (column == property.Name)
                                {
                                    if (property.PropertyType == typeof(Nullable<bool>) || property.PropertyType == typeof(bool))
                                    {
                                        string value = System.Web.UI.DataBinder.GetPropertyValue(dataItem, property.Name, null);
                                        ws.Cell(row, col).Value = (string.IsNullOrEmpty(value) ? "" : (value == "True" ? "Si" : "No"));
                                    }
                                    else
                                    {
                                        if (property.PropertyType == typeof(Nullable<DateTime>) || property.PropertyType == typeof(DateTime))
                                            ws.Cell(row, col).Style.DateFormat.Format = "dd/MM/yyyy";
                                        else
                                            ws.Cell(row, col).Style.NumberFormat.Format = "@";
                                        ws.Cell(row, col).Value = System.Web.UI.DataBinder.GetPropertyValue(dataItem, property.Name, null);

                                    }
                                    ws.Column(col).Width = sizeColumn;
                                    break;
                                }
                            }
                            col++;

                        }
                        row++;
                    }
                    ws.Range(1, 1, 1, index - 1).AddToNamed("Titles");
                }

                var titlesStyle = wb.Style;
                titlesStyle.Font.Bold = true;
                titlesStyle.Alignment.Horizontal = XLAlignmentHorizontalValues.Center;
                titlesStyle.Fill.BackgroundColor = XLColor.FromHtml("#993399");
                titlesStyle.Font.FontColor = XLColor.White;

                wb.NamedRanges.NamedRange("Titles").Ranges.Style = titlesStyle;

                var stream = new MemoryStream();
                wb.SaveAs(stream);

                HttpContext.Current.Response.ClearHeaders();
                HttpContext.Current.Response.Clear();
                HttpContext.Current.Response.Buffer = false;
                HttpContext.Current.Response.AddHeader("Content-disposition", "attachment; filename=" + originalFileName);
                HttpContext.Current.Response.Charset = "UTF-8";
                HttpContext.Current.Response.Cache.SetCacheability(HttpCacheability.Private);
                HttpContext.Current.Response.ContentType = "application/octet-stream";
                HttpContext.Current.Response.BinaryWrite(stream.ToArray());
                HttpContext.Current.Response.Flush();
                HttpContext.Current.Response.End();

                return true;
            }
            catch (Exception)
            {
                return false;
            }
        }


        /// <summary>
        /// Metodo que exporta una lista a documento Excel.
        /// </summary>
        /// <typeparam name="V">Tipo de entidad</typeparam>
        /// <param name="filename">nombre del archivo sin la extension</param>
        /// <param name="Source">Lista de Entidades cuyos registros van a ser exportados a excel</param>
        /// <param name="columnDefinition">Diccionario que contiene: Nombre de las columnas a mostrar[Key], Propiedad asociada a la entidad[value]</param>
        /// <returns></returns>
        public static bool ExportToExcel_FIC<V>(string filename, List<V> Source, Dictionary<string, string> columnDefinition)
        {
            try
            {
                string extension = ".xlsx";
                string originalFileName = Path.GetFileNameWithoutExtension(filename) + extension;

                var wb = new XLWorkbook();
                var ws = wb.Worksheets.Add("Hoja1");
                List<string> columns = new List<string>();
                int index = 1;

                foreach (KeyValuePair<string, string> keyvalue in columnDefinition)
                {
                    ws.Cell(1, index).Value = keyvalue.Key;
                    index++;
                    columns.Add(keyvalue.Value);
                }
                int row = 2;
                foreach (var dataItem in (System.Collections.IEnumerable)Source)
                {
                    var col = 1;
                    foreach (string column in columns)
                    {
                        foreach (PropertyInfo property in dataItem.GetType().GetProperties())
                        {
                            if (column == property.Name)
                            {
                                if (property.PropertyType == typeof(Nullable<bool>) || property.PropertyType == typeof(bool))
                                {
                                    string value = System.Web.UI.DataBinder.GetPropertyValue(dataItem, property.Name, null);
                                    ws.Cell(row, col).Value = (string.IsNullOrEmpty(value) ? "" : (value == "True" ? "Si" : "No"));
                                }
                                else
                                {
                                    if (property.PropertyType == typeof(Nullable<DateTime>) || property.PropertyType == typeof(DateTime))
                                        ws.Cell(row, col).Style.DateFormat.Format = "dd/MM/yyyy hh:mm";
                                    else
                                        ws.Cell(row, col).Style.NumberFormat.Format = "@";
                                    ws.Cell(row, col).Value = System.Web.UI.DataBinder.GetPropertyValue(dataItem, property.Name, null);

                                }
                                break;
                            }
                        }
                        col++;
                    }
                    row++;
                }
                ws.Range(1, 1, 1, index - 1).AddToNamed("Titles");

                var titlesStyle = wb.Style;
                titlesStyle.Font.Bold = true;
                titlesStyle.Alignment.Horizontal = XLAlignmentHorizontalValues.Center;
                titlesStyle.Fill.BackgroundColor = XLColor.FromHtml("#669966");

                wb.NamedRanges.NamedRange("Titles").Ranges.Style = titlesStyle;

                var stream = new MemoryStream();
                wb.SaveAs(stream);

                HttpContext.Current.Response.ClearHeaders();
                HttpContext.Current.Response.Clear();
                HttpContext.Current.Response.Buffer = false;
                HttpContext.Current.Response.AddHeader("Content-disposition", "attachment; filename=" + originalFileName);
                HttpContext.Current.Response.Charset = "UTF-8";
                HttpContext.Current.Response.Cache.SetCacheability(HttpCacheability.Private);
                HttpContext.Current.Response.ContentType = "application/octet-stream";
                HttpContext.Current.Response.BinaryWrite(stream.ToArray());
                HttpContext.Current.Response.Flush();
                HttpContext.Current.Response.End();

                return true;
            }
            catch (Exception)
            {
                return false;
            }
        }



        /// <summary>
        /// Metodo que exporta una lista a documento Excel.
        /// </summary>
        /// <typeparam name="V">Tipo de entidad</typeparam>
        /// <param name="filename">nombre del archivo sin la extension</param>
        /// <param name="Source">Lista de Entidades cuyos registros van a ser exportados a excel</param>
        /// <param name="columnDefinition">Diccionario que contiene: Nombre de las columnas a mostrar[Key], Propiedad asociada a la entidad[value]</param>
        /// <param name="cookieName">Nombre de la cookie que será creado en el response de la descarga</param>
        /// <param name="valueName">Valor de la cookie creado en el response de la descarga</param>
        /// <returns></returns>
        public static bool ExportToExcel<V>(string filename, List<V> Source, Dictionary<string, string> columnDefinition, string cookieName, string valueName)
        {
            try
            {
                string extension = ".xlsx";
                string originalFileName = Path.GetFileNameWithoutExtension(filename) + extension;

                var wb = new XLWorkbook();
                var ws = wb.Worksheets.Add("Hoja1");
                List<string> columns = new List<string>();
                int index = 1;

                foreach (KeyValuePair<string, string> keyvalue in columnDefinition)
                {
                    ws.Cell(1, index).Value = keyvalue.Key;
                    index++;
                    columns.Add(keyvalue.Value);
                }
                int row = 2;
                foreach (var dataItem in (System.Collections.IEnumerable)Source)
                {
                    var col = 1;
                    foreach (string column in columns)
                    {
                        foreach (PropertyInfo property in dataItem.GetType().GetProperties())
                        {
                            if (column == property.Name)
                            {
                                if (property.PropertyType == typeof(Nullable<bool>) || property.PropertyType == typeof(bool))
                                {
                                    string value = System.Web.UI.DataBinder.GetPropertyValue(dataItem, property.Name, null);
                                    ws.Cell(row, col).Value = (string.IsNullOrEmpty(value) ? "" : (value == "True" ? "Si" : "No"));
                                }
                                else
                                {
                                    if (property.PropertyType == typeof(Nullable<DateTime>) || property.PropertyType == typeof(DateTime))
                                        ws.Cell(row, col).Style.DateFormat.Format = "dd/MM/yyyy";
                                    else
                                        ws.Cell(row, col).Style.NumberFormat.Format = "@";
                                    ws.Cell(row, col).Value = System.Web.UI.DataBinder.GetPropertyValue(dataItem, property.Name, null);

                                }
                                break;
                            }
                        }
                        col++;
                    }
                    row++;
                }
                ws.Range(1, 1, 1, index - 1).AddToNamed("Titles");

                var titlesStyle = wb.Style;
                titlesStyle.Font.Bold = true;
                titlesStyle.Alignment.Horizontal = XLAlignmentHorizontalValues.Center;
                titlesStyle.Fill.BackgroundColor = XLColor.FromHtml("#669966");

                wb.NamedRanges.NamedRange("Titles").Ranges.Style = titlesStyle;

                var stream = new MemoryStream();
                wb.SaveAs(stream);

                HttpContext.Current.Response.ClearHeaders();
                HttpContext.Current.Response.Clear();
                if (!string.IsNullOrEmpty(cookieName) && !string.IsNullOrEmpty(valueName))
                    HttpContext.Current.Response.AppendCookie(new HttpCookie(cookieName, valueName));
                HttpContext.Current.Response.Buffer = false;
                HttpContext.Current.Response.AddHeader("Content-disposition", "attachment; filename=" + originalFileName);
                HttpContext.Current.Response.Charset = "UTF-8";
                HttpContext.Current.Response.Cache.SetCacheability(HttpCacheability.Private);
                HttpContext.Current.Response.ContentType = "application/octet-stream";
                HttpContext.Current.Response.BinaryWrite(stream.ToArray());
                HttpContext.Current.Response.Flush();
                HttpContext.Current.Response.End();

                return true;
            }
            catch (Exception)
            {
                return false;
            }
        }

        /// <summary>
        /// AOB:*Reportes dinamicos SOLCredit region
        /// </summary>
        /// <param name="filename"></param>
        /// <param name="Source"></param>
        /// <param name="columnDefinition"></param>
        /// <param name="cookieName"></param>
        /// <param name="valueName"></param>
        /// <returns></returns>
        public static bool ExportToExcelSinP(string filename, List<Dictionary<string, string>> Source, Dictionary<string, string> columnDefinition, string cookieName, string valueName)
        {
            try
            {
                string extension = ".xlsx";
                string originalFileName = Path.GetFileNameWithoutExtension(filename) + extension;

                var wb = new XLWorkbook();
                var ws = wb.Worksheets.Add("Hoja1");
                List<string> columns = new List<string>();
                
                if (Source.Count == 0)
                {
                    ws.Cell(1, 1).Value = "No hay registros para mostrar en la fecha que indicas";
                }
                else
                {
                    int index = 1;

                    foreach (KeyValuePair<string, string> keyvalue in columnDefinition)
                    {
                        if (index == 1)
                        {
                            ws.Cell(1, index).Value = keyvalue.Key;
                        }
                        else
                        {

                            ws.Cell(1, index).Value = keyvalue.Value;
                            ws.Cell(1, index).Style.DateFormat.Format = "dd/MM/yyyy";

                        }
                        index++;
                        columns.Add(keyvalue.Value);
                    }
                    int row = 2;

                    foreach (var dicdetalle in Source)
                    {
                        var col = 1;
                        foreach (var detalle in dicdetalle)
                        {
                            ws.Cell(row, col).Value = detalle.Value;
                            col++;
                        }
                        row++;

                    }

                    ws.Range(1, 1, 1, index - 1).AddToNamed("Titles");
                    ws.Row(1).Style.Font.Bold = true;

                }
                ws.Columns().AdjustToContents();

                var stream = new MemoryStream();
                wb.SaveAs(stream);

                HttpContext.Current.Response.ClearHeaders();
                HttpContext.Current.Response.Clear();
                if (!string.IsNullOrEmpty(cookieName) && !string.IsNullOrEmpty(valueName))
                    HttpContext.Current.Response.AppendCookie(new HttpCookie(cookieName, valueName));
                HttpContext.Current.Response.Buffer = false;
                HttpContext.Current.Response.AddHeader("Content-disposition", "attachment; filename=" + originalFileName);
                HttpContext.Current.Response.Charset = "UTF-8";
                HttpContext.Current.Response.Cache.SetCacheability(HttpCacheability.Private);
                HttpContext.Current.Response.ContentType = "application/octet-stream";
                HttpContext.Current.Response.BinaryWrite(stream.ToArray());
                HttpContext.Current.Response.Flush();
                HttpContext.Current.Response.End();

                return true;
            }
            catch (Exception)
            {
                return false;
            }
        }

        public static bool ExportToExcelMultiple<V>(string filename, List<V> SourceDetails, Dictionary<int, string> columnHeaderDefinition,
            Dictionary<string, string> columnDetailDefinition, string[] arrTotal)
        {
            try
            {
                string extension = ".xlsx";
                string originalFileName = Path.GetFileNameWithoutExtension(filename) + extension;

                var wb = new XLWorkbook();
                var ws = wb.Worksheets.Add("Hoja1");
                List<string> columns = new List<string>();

                int row = 1;
                int col = 0;

                foreach (KeyValuePair<int, string> keyvalue in columnHeaderDefinition)
                {
                    ws.Cell(row, 1).Value = keyvalue.Value;
                    ws.Range(string.Format("A{0}:E{1}", row, row)).Row(1).Merge();
                    ws.Cell(row, 1).Style.Font.Bold = true;
                    var col2 = 1;
                    foreach (KeyValuePair<string, string> keyvalue2 in columnDetailDefinition)
                    {
                        ws.Cell(row + 1, col2).Value = keyvalue2.Key;
                        col2++;
                        columns.Add(keyvalue2.Value);
                    }

                    ws.Range(row + 1, 1, row + 1, col2 - 1).AddToNamed("HeadDetails");
                    var titlesStyleh = wb.Style;
                    titlesStyleh.Font.Bold = true;
                    titlesStyleh.Alignment.Horizontal = XLAlignmentHorizontalValues.Center;
                    titlesStyleh.Fill.BackgroundColor = XLColor.FromHtml("#863A9A");
                    titlesStyleh.Font.FontColor = XLColor.FromHtml("#ffffff");
                    wb.NamedRanges.NamedRange("HeadDetails").Ranges.Style = titlesStyleh;

                    var i = 0;

                    row += 2;
                    while (i < keyvalue.Key)
                    {
                        col = 1;
                        foreach (string column in columns)
                        {
                            var source = SourceDetails[i];
                            foreach (PropertyInfo property in source.GetType().GetProperties())
                            {
                                var arr = column.Contains("#") 
                                    ? column.Split('#')
                                    : new string[] { "", column };

                                if (arr[1] == property.Name)
                                {
                                    if (property.PropertyType == typeof(Nullable<bool>) || property.PropertyType == typeof(bool))
                                    {
                                        string value = System.Web.UI.DataBinder.GetPropertyValue(SourceDetails[i], property.Name, null);
                                        ws.Cell(row, col).Value = (string.IsNullOrEmpty(value) ? "" : (value == "True" ? "Si" : "No"));
                                    }
                                    else
                                    {
                                        if (property.PropertyType == typeof(Nullable<DateTime>) || property.PropertyType == typeof(DateTime))
                                            ws.Cell(row, col).Style.DateFormat.Format = "dd/MM/yyyy";
                                        else if (property.PropertyType == typeof(Nullable<decimal>) || property.PropertyType == typeof(decimal))
                                        {
                                            ws.Cell(row, col).Value = arr[0] + System.Web.UI.DataBinder.GetPropertyValue(SourceDetails[i], property.Name, "{0:0.00}");
                                            ws.Cell(row, col).Style.Fill.BackgroundColor = XLColor.FromHtml("#DED2F1");
                                            break;
                                        }
                                        else
                                            ws.Cell(row, col).Style.NumberFormat.Format = "@";
                                        ws.Cell(row, col).Value = arr[0] + System.Web.UI.DataBinder.GetPropertyValue(SourceDetails[i], property.Name, null);
                                    }

                                    ws.Cell(row, col).Style.Fill.BackgroundColor = XLColor.FromHtml("#DED2F1");
                                    break;
                                }
                            }
                            col++;
                        }
                        row++;
                        i++;
                    }
                    columns = new List<string>();
                    if (arrTotal.Length > 0)
                    {
                        ws.Range(row, 1, row, col - 1).AddToNamed("Totals");
                        var titlesStyle = wb.Style;
                        titlesStyle.Font.Bold = true;
                        titlesStyle.Alignment.Horizontal = XLAlignmentHorizontalValues.Left;
                        titlesStyle.Fill.BackgroundColor = XLColor.NoColor;
                        titlesStyleh.Font.FontColor = XLColor.FromHtml("#000000");
                        wb.NamedRanges.NamedRange("Totals").Ranges.Style = titlesStyle;

                        ws.Cell(row, col - 2).Value = arrTotal[0];
                        ws.Cell(row, col - 1).Value = arrTotal[1].Split('#')[0] +
                            System.Web.UI.DataBinder.GetPropertyValue(SourceDetails[i], (SourceDetails[i]).GetType().GetProperty(arrTotal[1].Split('#')[1]).Name, "{0:0.00}");
                    }
                    row++;
                    var index = keyvalue.Key + 1;
                    SourceDetails.RemoveRange(0, index);
                }

                ws.Columns().AdjustToContents();

                var stream = new MemoryStream();
                wb.SaveAs(stream);

                HttpContext.Current.Response.ClearHeaders();
                HttpContext.Current.Response.Clear();
                HttpContext.Current.Response.Buffer = false;
                HttpContext.Current.Response.AddHeader("Content-disposition", "attachment; filename=" + originalFileName);
                HttpContext.Current.Response.Charset = "UTF-8";
                HttpContext.Current.Response.Cache.SetCacheability(HttpCacheability.Private);
                HttpContext.Current.Response.ContentType = "application/octet-stream";
                HttpContext.Current.Response.BinaryWrite(stream.ToArray());
                HttpContext.Current.Response.Flush();
                HttpContext.Current.Response.End();

                return true;
            }
            catch (Exception)
            {
                return false;
            }
        }

        public static string EncriptarQueryString(params string[] Parametros)
        {
            TSHAK.Components.SecureQueryString queryString = default(TSHAK.Components.SecureQueryString);
            queryString = new TSHAK.Components.SecureQueryString(new Byte[] { 0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 1, 2, 3, 4, 5, 8 });
            for (int i = 0; i < Parametros.Length; i++)
            {
                queryString[i.ToString()] = Parametros[i].Trim();
            }

            return HttpUtility.UrlEncode(queryString.ToString());
        }

        public static string DesencriptarQueryString(string ParametroQueryString)
        {
            StringBuilder oStringBuilder = new StringBuilder();

            TSHAK.Components.SecureQueryString queryString = default(TSHAK.Components.SecureQueryString);
            queryString = new TSHAK.Components.SecureQueryString(new Byte[] { 0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 1, 2, 3, 4, 5, 8 }, ParametroQueryString.Replace(" ", "+"));
            for (int i = 0; i < queryString.Count; i++)
            {
                oStringBuilder.Append(queryString[i]);
                if (i < queryString.Count - 1)
                    oStringBuilder.Append(";");
            }

            return oStringBuilder.ToString();
        }
        public static string Desencriptar_QueryString(string ParametroQueryString)
        {
            StringBuilder stringBuilder = new StringBuilder();
            TSHAK.Components.SecureQueryString secureQueryString = new TSHAK.Components.SecureQueryString(new byte[] { 0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 1, 2, 3, 4, 5, 8 }, ParametroQueryString);
            for (int i = 0; i < secureQueryString.Count - 1; i++)
            {
                stringBuilder.Append(secureQueryString[i]);
            }
            return stringBuilder.ToString();
        }

        public static string Encrypt(string clearText)
        {
            string encryptionKey = "MAKV2SPBNI99212";
            byte[] clearBytes = Encoding.Unicode.GetBytes(clearText);
            using (Aes encryptor = Aes.Create())
            {
                Rfc2898DeriveBytes pdb = new Rfc2898DeriveBytes(encryptionKey, new byte[] { 0x49, 0x76, 0x61, 0x6e, 0x20, 0x4d, 0x65, 0x64, 0x76, 0x65, 0x64, 0x65, 0x76 });
                if (encryptor != null)
                {
                    encryptor.Key = pdb.GetBytes(32);
                    encryptor.IV = pdb.GetBytes(16);
                    using (MemoryStream ms = new MemoryStream())
                    {
                        using (CryptoStream cs = new CryptoStream(ms, encryptor.CreateEncryptor(),
                            CryptoStreamMode.Write))
                        {
                            cs.Write(clearBytes, 0, clearBytes.Length);
                            cs.Close();
                        }

                        clearText = Convert.ToBase64String(ms.ToArray());
                    }
                }
            }
            return clearText;
        }

        public static string Decrypt(string cipherText)
        {
            string encryptionKey = "MAKV2SPBNI99212";
            cipherText = cipherText.Replace(" ", "+");
            byte[] cipherBytes = Convert.FromBase64String(cipherText);
            using (Aes encryptor = Aes.Create())
            {
                Rfc2898DeriveBytes pdb = new Rfc2898DeriveBytes(encryptionKey, new byte[] { 0x49, 0x76, 0x61, 0x6e, 0x20, 0x4d, 0x65, 0x64, 0x76, 0x65, 0x64, 0x65, 0x76 });
                if (encryptor != null)
                {
                    encryptor.Key = pdb.GetBytes(32);
                    encryptor.IV = pdb.GetBytes(16);
                    using (MemoryStream ms = new MemoryStream())
                    {
                        using (CryptoStream cs = new CryptoStream(ms, encryptor.CreateDecryptor(),
                            CryptoStreamMode.Write))
                        {
                            cs.Write(cipherBytes, 0, cipherBytes.Length);
                            cs.Close();
                        }

                        cipherText = Encoding.Unicode.GetString(ms.ToArray());
                    }
                }
            }
            return cipherText;
        }

        public static string EncriptarCookie(string Parametros)
        {
            TSHAK.Components.SecureQueryString queryString = new TSHAK.Components.SecureQueryString(new Byte[] { 0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 1, 2, 3, 4, 5, 8 });
            queryString["0"] = Parametros;
            return queryString.ToString();

        }
        public static string DesencriptarCookie(string ParametroQueryString)
        {
            StringBuilder oStringBuilder = new StringBuilder();
            TSHAK.Components.SecureQueryString queryString = new TSHAK.Components.SecureQueryString(new Byte[] { 0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 1, 2, 3, 4, 5, 8 }, ParametroQueryString);
            oStringBuilder.Append(queryString[0]);
            return oStringBuilder.ToString();


        }

        public static string EncriptarSuperateBelcorp(string xmlKeysPath, string texto)
        {
            byte[] textoOriginal = Encoding.UTF8.GetBytes(texto);
            RSACryptoServiceProvider.UseMachineKeyStore = true;
            RSACryptoServiceProvider rsa2 = new RSACryptoServiceProvider();
            rsa2 = CargarLlave(xmlKeysPath, rsa2);
            byte[] output = rsa2.Encrypt(textoOriginal, false);

            string llaveEncriptada = Convert.ToBase64String(output);
            return llaveEncriptada;
        }

        public static string EncriptarDuplaCyzone(string xmlKeysPath, string texto)
        {
            byte[] textoOriginal = Encoding.UTF8.GetBytes(texto);
            RSACryptoServiceProvider rsa2 = new RSACryptoServiceProvider();
            rsa2 = CargarLlave(xmlKeysPath, rsa2);
            byte[] output = rsa2.Encrypt(textoOriginal, false);

            string llaveEncriptada = Convert.ToBase64String(output);
            return llaveEncriptada;
        }

        public static string DesencriptarDuplaCyzone(string xmlKeysPath, string input)
        {
            byte[] inputbytes = Convert.FromBase64String(input);
            RSACryptoServiceProvider rsa = new RSACryptoServiceProvider();
            rsa = CargarLlave(xmlKeysPath, rsa);
            byte[] outputbytes = rsa.Decrypt(inputbytes, false);
            string output = System.Text.Encoding.UTF8.GetString(outputbytes);
            return output;
        }

        public static RSACryptoServiceProvider CargarLlave(string xmlKeysPath, RSACryptoServiceProvider rsa)
        {
            FileStream fs = new FileStream(xmlKeysPath, FileMode.Open, FileAccess.Read, FileShare.Read);
            StreamReader sr = new StreamReader(fs);
            string llave = sr.ReadToEnd();
            sr.Close();
            rsa.FromXmlString(llave);
            return rsa;
        }

        public static string Enletras(string num)
        {
            string dec = "";
            double nro;

            try
            {
                nro = Convert.ToDouble(num);
            }
            catch
            {
                return "";
            }

            var entero = Convert.ToInt64(Math.Truncate(nro));
            var decimales = Convert.ToInt32(Math.Round((nro - entero) * 100, 2));
            if (decimales > 0)
            {
                dec = " CON " + decimales.ToString() + "/100";
            }

            var res = ToText(entero) + dec;
            return res;
        }

        private static string ToText(long value)
        {
            string num2Text;
            if (value == 0) num2Text = "CERO";
            else if (value == 1) num2Text = "UNO";
            else if (value == 2) num2Text = "DOS";
            else if (value == 3) num2Text = "TRES";
            else if (value == 4) num2Text = "CUATRO";
            else if (value == 5) num2Text = "CINCO";
            else if (value == 6) num2Text = "SEIS";
            else if (value == 7) num2Text = "SIETE";
            else if (value == 8) num2Text = "OCHO";
            else if (value == 9) num2Text = "NUEVE";
            else if (value == 10) num2Text = "DIEZ";
            else if (value == 11) num2Text = "ONCE";
            else if (value == 12) num2Text = "DOCE";
            else if (value == 13) num2Text = "TRECE";
            else if (value == 14) num2Text = "CATORCE";
            else if (value == 15) num2Text = "QUINCE";
            else if (value < 20) num2Text = "DIECI" + ToText(value - 10);
            else if (value == 20) num2Text = "VEINTE";
            else if (value < 30) num2Text = "VEINTI" + ToText(value - 20);
            else if (value == 30) num2Text = "TREINTA";
            else if (value == 40) num2Text = "CUARENTA";
            else if (value == 50) num2Text = "CINCUENTA";
            else if (value == 60) num2Text = "SESENTA";
            else if (value == 70) num2Text = "SETENTA";
            else if (value == 80) num2Text = "OCHENTA";
            else if (value == 90) num2Text = "NOVENTA";
            else if (value < 100) num2Text = ToText(value / 10 * 10) + " Y " + ToText(value % 10);
            else if (value == 100) num2Text = "CIEN";
            else if (value < 200) num2Text = "CIENTO " + ToText(value - 100);
            else if ((value == 200) || (value == 300) || (value == 400) || (value == 600) || (value == 800)) num2Text = ToText(value / 100) + "CIENTOS";
            else if (value == 500) num2Text = "QUINIENTOS";
            else if (value == 700) num2Text = "SETECIENTOS";
            else if (value == 900) num2Text = "NOVECIENTOS";
            else if (value < 1000) num2Text = ToText(value / 100 * 100) + " " + ToText(value % 100);

            else if (value == 1000) num2Text = "MIL";
            else if (value < 2000) num2Text = "MIL " + ToText(value % 1000);
            else if (value < 1000000)
            {
                num2Text = ToText(value / 1000) + " MIL";
                if (value % 1000 > 0) num2Text = num2Text + " " + ToText(value % 1000);
            }

            else if (value == 1000000) num2Text = "UN MILLON";
            else if (value < 2000000) num2Text = "UN MILLON " + ToText(value % 1000000);
            else if (value < 1000000000000)
            {
                num2Text = ToText(value / 1000000) + " MILLONES";
                if (value % 1000000 > 0) num2Text = num2Text + " " + ToText(value % 1000000);
            }

            else if (value == 1000000000000) num2Text = "UN BILLON";
            else if (value < 2000000000000) num2Text = "UN BILLON " + ToText(value % 1000000000000);
            else
            {
                num2Text = ToText(value / 1000000000000) + " BILLONES";
                if (value % 1000000000000 > 0) num2Text = num2Text + " " + ToText(value % 1000000000000);
            }

            return num2Text;
        }

        public static bool ExportToPdf(Controller controller, string fileName, string stActionIndex)
        {
            try
            {
                string extension = ".pdf";
                string originalFileName = Path.GetFileNameWithoutExtension(fileName) + extension;

                String thisPageUrl = Util.GetUrlOriginal(controller.HttpContext.Request).AbsoluteUri;

                var rd = controller.RouteData;
                var action = rd.GetRequiredString("action");
                var controllerStr = rd.GetRequiredString("controller");

                String baseUrl = thisPageUrl.Substring(0, thisPageUrl.Length - string.Format("{0}/{1}", controllerStr, action).Length);
                baseUrl = string.Format(baseUrl + "{0}/{1}", controllerStr, stActionIndex);

                HiQPdf.HtmlToPdf htmlToPdfConverter = new HiQPdf.HtmlToPdf();
                htmlToPdfConverter.SerialNumber = "zoann56qqIKnrLyvvLf74P7u/u7/7vf39/fu/f/g//zg9/f39w==";

                byte[] pdfBuffer = htmlToPdfConverter.ConvertUrlToMemory(baseUrl);

                HttpContext.Current.Response.Clear();
                HttpContext.Current.Response.Buffer = false;
                HttpContext.Current.Response.AddHeader("Content-disposition", "attachment; filename=" + originalFileName);
                HttpContext.Current.Response.Cache.SetCacheability(HttpCacheability.Private);
                HttpContext.Current.Response.Charset = "iso-8859-1";
                HttpContext.Current.Response.ContentType = "application/octet-stream";
                HttpContext.Current.Response.BinaryWrite(pdfBuffer);
                HttpContext.Current.Response.Flush();
                HttpContext.Current.Response.End();
            }
            catch (Exception)
            {
                return false;
            }
            return true;
        }

        public static bool ExportToPdf(Controller controller, string fileName, string stActionIndex, string enviar)
        {
            try
            {
                string extension = ".pdf";
                string originalFileName = Path.GetFileNameWithoutExtension(fileName) + extension;

                HttpRequestBase request = controller.HttpContext.Request;

                if (request.Url != null)
                {
                    string baseUrl = request.Url.Scheme + "://" + request.Url.Authority + (request.ApplicationPath != null && request.ApplicationPath.Equals("/") ? "/" : (request.ApplicationPath + "/"));

                    var rd = controller.RouteData;
                    var controllerStr = rd.GetRequiredString("controller");

                    baseUrl = string.Format(baseUrl + "/{0}/{1}?parametros={2}", controllerStr, stActionIndex, enviar);

                    HiQPdf.HtmlToPdf htmlToPdfConverter = new HiQPdf.HtmlToPdf();
                    htmlToPdfConverter.SerialNumber = "zoann56qqIKnrLyvvLf74P7u/u7/7vf39/fu/f/g//zg9/f39w==";

                    byte[] pdfBuffer = htmlToPdfConverter.ConvertUrlToMemory(baseUrl);

                    HttpContext.Current.Response.Clear();
                    HttpContext.Current.Response.Buffer = false;
                    HttpContext.Current.Response.AddHeader("Content-disposition", "attachment; filename=" + originalFileName);
                    HttpContext.Current.Response.Cache.SetCacheability(HttpCacheability.Private);
                    HttpContext.Current.Response.Charset = "iso-8859-1";
                    HttpContext.Current.Response.ContentType = "application/octet-stream";
                    HttpContext.Current.Response.BinaryWrite(pdfBuffer);
                }

                HttpContext.Current.Response.Flush();
                HttpContext.Current.Response.End();
            }
            catch (Exception)
            {
                return false;
            }
            return true;
        }

        public static bool ExportToPdfWebPages(Controller controller, string fileName, string stActionIndex, string enviar)
        {
            try
            {
                string extension = ".pdf";
                string originalFileName = Path.GetFileNameWithoutExtension(fileName) + extension;

                HttpRequestBase request = controller.HttpContext.Request;

                if (request.Url != null)
                {
                    string baseUrl = request.Url.Scheme + "://" + request.Url.Authority + (request.ApplicationPath != null && request.ApplicationPath.Equals("/") ? "/" : (request.ApplicationPath + "/"));

                    baseUrl = string.Format(baseUrl + "WebPages/{0}.aspx?parametros={1}", stActionIndex, enviar);

                    HiQPdf.HtmlToPdf htmlToPdfConverter = new HiQPdf.HtmlToPdf();
                    htmlToPdfConverter.SerialNumber = "zoann56qqIKnrLyvvLf74P7u/u7/7vf39/fu/f/g//zg9/f39w==";

                    byte[] pdfBuffer = htmlToPdfConverter.ConvertUrlToMemory(baseUrl);

                    HttpContext.Current.Response.Clear();
                    HttpContext.Current.Response.Buffer = false;
                    HttpContext.Current.Response.AddHeader("Content-disposition", "attachment; filename=" + originalFileName);
                    HttpContext.Current.Response.Cache.SetCacheability(HttpCacheability.NoCache);
                    HttpContext.Current.Response.Charset = "iso-8859-1";
                    HttpContext.Current.Response.ContentType = "application/octet-stream";
                    HttpContext.Current.Response.BinaryWrite(pdfBuffer);
                }

                HttpContext.Current.Response.Flush();
                HttpContext.Current.Response.End();
            }
            catch (Exception)
            {
                return false;
            }
            return true;
        }

        private static Uri GetUrlOriginal(HttpRequestBase request)
        {
            string hostHeader = request.Headers["host"];

            return new Uri(string.Format("{0}://{1}{2}",
               request.Url.Scheme,
               hostHeader,
               request.RawUrl));
        }

        public static Uri GetUrlHost(HttpRequestBase request)
        {
            string baseUrl = request.Url.Scheme + "://" + request.Url.Authority + (request.ApplicationPath != null && request.ApplicationPath.Equals("/") ? "/" : (request.ApplicationPath + "/"));
            return new Uri(baseUrl);
        }

        public static Uri GetUrlHost(HttpRequest request)
        {
            string baseUrl = request.Url.Scheme + "://" + request.Url.Authority + (request.ApplicationPath != null && request.ApplicationPath.Equals("/") ? "/" : (request.ApplicationPath + "/"));
            return new Uri(baseUrl);
        }

        public static string CreateRandomPassword(int PasswordLength)
        {
            string _allowedChars = "abcdefghijkmnpqrstuvwxyzABCDEFGHJKLMNPQRSTUVWXYZ23456789!@$?";
            Byte[] randomBytes = new Byte[PasswordLength];
            char[] chars = new char[PasswordLength];
            int allowedCharCount = _allowedChars.Length;

            for (int i = 0; i < PasswordLength; i++)
            {
                Random randomObj = new Random();
                randomObj.NextBytes(randomBytes);
                chars[i] = _allowedChars[(int)randomBytes[i] % allowedCharCount];
            }

            return (new string(chars)).ToUpper();
        }

        public static string Desencriptar(string cadena)
        {
            cadena = cadena.Replace("ABCDE", "+");
            string clave = "12345678912345678912345678912345";
            // Convierto la cadena y la clave en arreglos de bytes
            // para poder usarlas en las funciones de encriptacion
            // En este caso la cadena la convierta usando base 64
            // que es la codificacion usada en el metodo encriptar
            byte[] cadenaBytes = Convert.FromBase64String(cadena);
            byte[] claveBytes = Encoding.UTF8.GetBytes(clave);

            // Creo un objeto de la clase Rijndael
            RijndaelManaged rij = new RijndaelManaged();

            // Configuro para que utilice el modo ECB
            rij.Mode = CipherMode.ECB;

            // Configuro para que use encriptacion de 256 bits.
            rij.BlockSize = 256;

            // Declaro que si necesitara mas bytes agregue ceros.
            rij.Padding = PaddingMode.Zeros;

            // Declaro un desencriptador que use mi clave secreta y un vector
            // de inicializacion aleatorio
            var desencriptador = rij.CreateDecryptor(claveBytes, rij.IV);

            // Declaro un stream de memoria para que guarde los datos
            // encriptados
            MemoryStream memStream = new MemoryStream(cadenaBytes);

            // Declaro un stream de cifrado para que pueda leer de aqui
            // la cadena a desencriptar. Esta clase utiliza el desencriptador
            // y el stream de memoria para realizar la desencriptacion
            var cifradoStream = new CryptoStream(memStream, desencriptador, CryptoStreamMode.Read);

            // Declaro un lector para que lea desde el stream de cifrado.
            // A medida que vaya leyendo se ira desencriptando.
            StreamReader lectorStream = new StreamReader(cifradoStream);

            // Leo todos los bytes y lo almaceno en una cadena
            string resultado = lectorStream.ReadToEnd();

            // Cierro los dos streams creados
            memStream.Close();
            cifradoStream.Close();

            // Devuelvo la cadena
            return resultado;
        }

        public static string AcentosCaracteres(string html_)
        {
            html_ = html_.Replace("á", "&aacute;");
            html_ = html_.Replace("é", "&eacute;");
            html_ = html_.Replace("í", "&iacute;");
            html_ = html_.Replace("ó", "&oacute;");
            html_ = html_.Replace("ú", "&uacute;");
            html_ = html_.Replace("Á", "&Aacute;");
            html_ = html_.Replace("É", "&Eacute;");
            html_ = html_.Replace("Í", "&Iacute;");
            html_ = html_.Replace("Ó", "&Oacute;");
            html_ = html_.Replace("Ú", "&Uacute;");
            html_ = html_.Replace("Ñ", "&Ntilde;");
            html_ = html_.Replace("ñ", "&ntilde;");
            html_ = html_.Replace("¿", "&iquest;");
            html_ = html_.Replace("¡", "&iexcl;");
            html_ = html_.Replace("Ü", "&Uuml;");
            html_ = html_.Replace("ü", "&uuml;");

            return html_;
        }

        public static string SinAcentosCaracteres(string html_)
        {
            html_ = html_.Replace("á", "a");
            html_ = html_.Replace("é", "e");
            html_ = html_.Replace("í", "i");
            html_ = html_.Replace("ó", "o");
            html_ = html_.Replace("ú", "u");
            html_ = html_.Replace("Á", "A");
            html_ = html_.Replace("É", "E");
            html_ = html_.Replace("Í", "I");
            html_ = html_.Replace("Ó", "O");
            html_ = html_.Replace("Ú", "U");
            html_ = html_.Replace("Ñ", "N");
            html_ = html_.Replace("ñ", "n");
            return html_;
        }

        public static string ObtenerNombrePaisPorISO(string paisISO)
        {
            string paisNom;
            switch (paisISO)
            {
                case "AR":
                    paisNom = "Argentina";
                    break;
                case "BO":
                    paisNom = "Bolivia";
                    break;
                case "CL":
                    paisNom = "Chile";
                    break;
                case "CO":
                    paisNom = "Colombia";
                    break;
                case "CR":
                    paisNom = "Costa Rica";
                    break;
                case "EC":
                    paisNom = "Ecuador";
                    break;
                case "SV":
                    paisNom = "El Salvador";
                    break;
                case "GT":
                    paisNom = "Guatemala";
                    break;
                case "MX":
                    paisNom = "México";
                    break;
                case "PA":
                    paisNom = "Panamá";
                    break;
                case "PE":
                    paisNom = "Perú";
                    break;
                case "PR":
                    paisNom = "Puerto Rico";
                    break;
                case "DO":
                    paisNom = "República Dominicana";
                    break;
                default:
                    paisNom = "Venezuela";
                    break;
            }
            return paisNom;
        }

        public static int GetPaisID(string ISO)
        {
            ISO = ISO.ToUpper();

            var listaPaises = new Dictionary<string, int>()
            {
                {"AR", 1},
                {"BO", 2},
                {"CL", 3},
                {"CO", 4},
                {"CR", 5},
                {"EC", 6},
                {"SV", 7},
                {"GT", 8},
                {"MX", 9},
                {"PA", 10},
                {"PE", 11},
                {"PR", 12},
                {"DO", 13},
                {"VE", 14},
            };

            if (!listaPaises.ContainsKey(ISO))
                return 0;

            return listaPaises[ISO];
        }

        public static string GetPaisISO(int paisID)
        {
            var listaPaises = new Dictionary<int, string>()
            {
                {1, "AR" },
                {2, "BO"},
                {3, "CL"},
                {4, "CO"},
                {5, "CR"},
                {6, "EC"},
                {7, "SV"},
                {8, "GT"},
                {9, "MX"},
                {10, "PA" },
                {11, "PE"},
                {12, "PR"},
                {13, "DO"},
                {14, "VE"}
            };

            if (!listaPaises.ContainsKey(paisID))
                return string.Empty;

            return listaPaises[paisID];
        }

        public static string GetPaisNombre(int paisID)
        {
            List<KeyValuePair<string, string>> listaPaises = new List<KeyValuePair<string, string>>()
            {
                new KeyValuePair<string, string>("1", "Argentina"),
                new KeyValuePair<string, string>("2", "Bolivia"),
                new KeyValuePair<string, string>("3", "Chile"),
                new KeyValuePair<string, string>("4", "Colombia"),
                new KeyValuePair<string, string>("5", "Costa Rica"),
                new KeyValuePair<string, string>("6", "Ecuador"),
                new KeyValuePair<string, string>("7", "El Salvador"),
                new KeyValuePair<string, string>("8", "Guatemala"),
                new KeyValuePair<string, string>("9", "México"),
                new KeyValuePair<string, string>("10", "Pnamá"),
                new KeyValuePair<string, string>("11", "Perú"),
                new KeyValuePair<string, string>("12", "Puerto Rico"),
                new KeyValuePair<string, string>("13", "Republica Dominicana"),
                new KeyValuePair<string, string>("14", "Venezuela"),
            };
            string iso;
            try
            {
                iso = (from c in listaPaises
                       where c.Key == paisID.ToString()
                       select c.Value).SingleOrDefault();
            }
            catch (Exception)
            {
                throw new Exception("Hubo un error en obtener el País");
            }
            return (iso == null ? string.Empty : iso);
        }

        public static int Edad(DateTime fechaNacimiento)
        {
            int edad = DateTime.Now.Year - fechaNacimiento.Year;

            DateTime nacimientoAhora = fechaNacimiento.AddYears(edad);
            if (DateTime.Now.CompareTo(nacimientoAhora) > 0)
            {
                edad--;
            }

            return edad;
        }

        public static bool CheckIsImage(string contentType, string allowSubtypes)
        {
            if (contentType == null) throw new ArgumentNullException("contentType", "Este parametro es obligatorio");
            var result = contentType.StartsWith("image/");
            if (result && allowSubtypes != null)
            {
                var subtype = contentType.Split('/')[1];
                result = allowSubtypes.Contains(subtype);
            }
            return result;
        }
        public static bool CheckIsImage(string contentType)
        {
            return Util.CheckIsImage(contentType, null);
        }

        public static string ToFileSize(int source)
        {
            return ToFileSize(Convert.ToInt64(source));
        }
        public static string ToFileSize(long source)
        {
            string[] unitStorage = { "KB", "MB", "GB", "TB", "PB", "EB" };
            const int byteConversion = 1024;
            var bytes = Convert.ToDouble(source);
            for (var i = unitStorage.Length; i > 0; i--)
            {
                if (bytes >= Math.Pow(byteConversion, i))
                {
                    return string.Concat(Math.Round(bytes / Math.Pow(byteConversion, i), 2), unitStorage[i - 1]);
                }
                if (bytes < 1024)
                {
                    return string.Concat(bytes, " Bytes");
                }
            }
            return String.Empty;
        }

        public static string GetMimeType(Image image)
        {
            return GetMimeType(image.RawFormat);
        }
        public static string GetMimeType(ImageFormat imageFormat)
        {
            ImageCodecInfo[] codecs = ImageCodecInfo.GetImageEncoders();
            return codecs.First(codec => codec.FormatID == imageFormat.Guid).MimeType;
        }

        public static bool ExportToExcelHeaderDetail<V>(string filename, List<V> SourceDetails, Dictionary<int, string> columnHeaderDefinition,
            Dictionary<string, string> columnDetailDefinition, string[] arrTotal)
        {
            try
            {
                string extension = ".xlsx";
                string originalFileName = Path.GetFileNameWithoutExtension(filename) + extension;

                var wb = new XLWorkbook();
                var ws = wb.Worksheets.Add("Hoja1");
                List<string> columns = new List<string>();

                int row = 1;
                int col = 0;

                foreach (KeyValuePair<int, string> keyvalue in columnHeaderDefinition)
                {
                    ws.Cell(row, 1).Value = keyvalue.Value;
                    ws.Range(string.Format("A{0}:E{1}", row, row)).Row(1).Merge();
                    ws.Cell(row, 1).Style.Font.Bold = true;
                    var col2 = 1;
                    foreach (KeyValuePair<string, string> keyvalue2 in columnDetailDefinition)
                    {
                        ws.Cell(row + 1, col2).Value = keyvalue2.Key;
                        col2++;
                        columns.Add(keyvalue2.Value);
                    }

                    ws.Range(row + 1, 1, row + 1, col2 - 1).AddToNamed("HeadDetails");
                    var titlesStyleh = wb.Style;
                    titlesStyleh.Font.Bold = true;
                    titlesStyleh.Alignment.Horizontal = XLAlignmentHorizontalValues.Center;
                    titlesStyleh.Fill.BackgroundColor = XLColor.FromHtml("#863A9A");
                    titlesStyleh.Font.FontColor = XLColor.FromHtml("#ffffff");
                    wb.NamedRanges.NamedRange("HeadDetails").Ranges.Style = titlesStyleh;

                    var i = 0;

                    row += 2;
                    while (i < keyvalue.Key)
                    {
                        col = 1;
                        foreach (string column in columns)
                        {
                            var source = SourceDetails[i];
                            foreach (PropertyInfo property in source.GetType().GetProperties())
                            {
                                var arr = column.Contains("#") 
                                    ? column.Split('#') 
                                    : new string[] { "", column };

                                if (arr[1] == property.Name)
                                {
                                    if (property.PropertyType == typeof(Nullable<bool>) || property.PropertyType == typeof(bool))
                                    {
                                        string value = System.Web.UI.DataBinder.GetPropertyValue(SourceDetails[i], property.Name, null);
                                        ws.Cell(row, col).Value = (string.IsNullOrEmpty(value) ? "" : (value == "True" ? "Si" : "No"));
                                    }
                                    else
                                    {
                                        if (property.PropertyType == typeof(Nullable<DateTime>) || property.PropertyType == typeof(DateTime))
                                            ws.Cell(row, col).Style.DateFormat.Format = "dd/MM/yyyy";
                                        else if (property.PropertyType == typeof(Nullable<decimal>) || property.PropertyType == typeof(decimal))
                                        {
                                            ws.Cell(row, col).Value = arr[0] + System.Web.UI.DataBinder.GetPropertyValue(SourceDetails[i], property.Name, "{0:0.00}");
                                            ws.Cell(row, col).Style.Fill.BackgroundColor = XLColor.FromHtml("#DED2F1");
                                            break;
                                        }
                                        else
                                            ws.Cell(row, col).Style.NumberFormat.Format = "@";
                                        ws.Cell(row, col).Value = arr[0] + System.Web.UI.DataBinder.GetPropertyValue(SourceDetails[i], property.Name, null);
                                    }

                                    ws.Cell(row, col).Style.Fill.BackgroundColor = XLColor.FromHtml("#DED2F1");
                                    break;
                                }
                            }
                            col++;
                        }
                        row++;
                        i++;
                    }
                    columns = new List<string>();
                    if (arrTotal.Length > 0)
                    {
                        ws.Range(row, 1, row, col - 1).AddToNamed("Totals");
                        var titlesStyle = wb.Style;
                        titlesStyle.Font.Bold = true;
                        titlesStyle.Alignment.Horizontal = XLAlignmentHorizontalValues.Left;
                        titlesStyle.Fill.BackgroundColor = XLColor.NoColor;
                        titlesStyleh.Font.FontColor = XLColor.FromHtml("#000000");
                        wb.NamedRanges.NamedRange("Totals").Ranges.Style = titlesStyle;

                        ws.Cell(row, col - 2).Value = arrTotal[0];
                        ws.Cell(row, col - 1).Value = arrTotal[1].Split('#')[0] +
                            System.Web.UI.DataBinder.GetPropertyValue(SourceDetails[i], (SourceDetails[i]).GetType().GetProperty(arrTotal[1].Split('#')[1]).Name, "{0:0.00}");
                    }
                    row++;
                    var index = keyvalue.Key + 1;
                    SourceDetails.RemoveRange(0, index);
                }

                ws.Columns().AdjustToContents();

                var stream = new MemoryStream();
                wb.SaveAs(stream);

                HttpContext.Current.Response.ClearHeaders();
                HttpContext.Current.Response.Clear();
                HttpContext.Current.Response.Buffer = false;
                HttpContext.Current.Response.AddHeader("Content-disposition", "attachment; filename=" + originalFileName);
                HttpContext.Current.Response.Charset = "UTF-8";
                HttpContext.Current.Response.Cache.SetCacheability(HttpCacheability.Private);
                HttpContext.Current.Response.ContentType = "application/octet-stream";
                HttpContext.Current.Response.BinaryWrite(stream.ToArray());
                HttpContext.Current.Response.Flush();
                HttpContext.Current.Response.End();

                return true;
            }
            catch (Exception)
            {
                return false;
            }
        }

        public static string RemoveDiacritics(string text)
        {
            var normalizedString = text.Normalize(NormalizationForm.FormD);
            var stringBuilder = new StringBuilder();

            foreach (var c in normalizedString)
            {
                var unicodeCategory = CharUnicodeInfo.GetUnicodeCategory(c);
                if (unicodeCategory != UnicodeCategory.NonSpacingMark)
                {
                    stringBuilder.Append(c);
                }
            }

            return stringBuilder.ToString().Normalize(NormalizationForm.FormC);
        }

        public static string Trim(string cadena)
        {
            cadena = cadena ?? "";
            cadena = cadena.Trim();
            return cadena;
        }

        public static string SubStr(string cadena, int inicio, int cant = -100)
        {
            cadena = cadena ?? "";
            cadena = cadena.Trim();
            if (cadena == "")
                return "";

            inicio = inicio < 0 ? 0 : inicio;
            cant = cant < 0 ? cadena.Length : cant;

            var len = cadena.Length;

            if (len <= inicio)
            {
                inicio = len - 1;
                cant = 0;
            }
            if (len < cant)
            {
                cant = len - inicio;
            }
            if (inicio + cant + 1 > len)
            {
                cant = len - inicio;
            }

            return cadena.Substring(inicio, cant);
        }

        /// <summary>
        /// Convierte el decimal a string con el formato segun el pais
        /// </summary>
        /// <param name="valor">Monto a formatear</param>
        /// <param name="pais">CodigoISO del Pais. Ejm PE</param>
        /// <returns></returns>
        public static string DecimalToStringFormat(decimal valor, string pais)
        {
            if (string.IsNullOrEmpty(pais)) return "";

            var importe = string.Format("{0:#,##0.00}", valor);
            string listaPaises = ParseString(ConfigurationManager.AppSettings["KeyPaisFormatDecimal"] ?? "");
            if (listaPaises.Contains(pais)) importe = importe.Split('.')[0].Replace(",", ".");

            return importe;
        }

        /// <summary>
        /// Convierte el decimal a string con el formato segun el pais
        /// </summary>
        /// <param name="valor">Monto a formatear</param>
        /// <param name="pais">CodigoISO del Pais. Ejm PE</param>
        /// <param name="simbolo">Simbolo monetario del Pais. Ejm S/.</param>
        /// <returns></returns>
        public static string DecimalToStringFormat(decimal valor, string pais, string simbolo)
        {
            if (string.IsNullOrEmpty(pais)) return "";

            var importe = string.Format("{0:#,##0.00}", valor);
            string listaPaises = ParseString(ConfigurationManager.AppSettings["KeyPaisFormatDecimal"] ?? "");
            if (listaPaises.Contains(pais)) importe = importe.Split('.')[0].Replace(",", ".");

            return string.Format("{0} {1}", simbolo, importe);
        }

        /// <summary>
        /// Convierte el decimal a string con el formato segun el pais
        /// </summary>
        /// <param name="valor">Monto a formatear</param>
        /// <param name="pais">CodigoISO del Pais. Ejm PE</param>
        /// <returns></returns>
        public static string DecimalToStringFormat(string valor, string pais)
        {
            valor = valor ?? "";
            valor = valor.Trim();
            if (valor == "") return "";

            decimal x;
            if (decimal.TryParse(valor, out x))
            {
                return DecimalToStringFormat(decimal.Parse(valor), pais);
            }
            return "";
        }

        public static string ValidaMontoMaximo(decimal monto, string pais)
        {
            var montoval = DecimalToStringFormat(monto, pais);
            return ValidaMontoMaximo(montoval);
        }

        public static string ValidaMontoMaximo(string monto)
        {
            var montoval = string.IsNullOrEmpty(monto) ? "" : monto.Trim();
            if (montoval != "" &&
                (montoval == "0" || montoval == "0.00" || montoval == "0,00"
                || montoval == "99999999" || montoval == "99999999.00" || montoval == "99999999,00"
                || montoval == "99,999,999.00" || montoval == "99.999.999"
                || montoval == "999,999,999.00" || montoval == "999.999.999"
                || montoval == "9,999,999,999.00" || montoval == "9.999.999.999"
                || montoval == "99,999,999,999.00" || montoval == "99.999.999.999"
                || montoval == "999,999,999,999.00" || montoval == "999.999.999.999")
            )
                return "";

            return montoval;
        }

        public static string SubStrCortarNombre(string cadena, int cant, string strFin = "")
        {
            var str = SubStr(cadena, 0, cant);
            str = str == cadena && cadena != "" ? str + strFin : (str + "...");
            str = str == "..." ? "" : str;
            return str;
        }

        public static string ReemplazarSaltoLinea(string cadena, string saltoLinea)
        {
            return cadena.Replace("\r\n", saltoLinea).Replace("\n", saltoLinea).Replace("\r", saltoLinea);
        }

        public static int ObtenerCampaniaPasada(int campaniaId, int numeroCampaniasAtras)
        {
            int resultado;
            try
            {
                string campaniaFinal;

                string cadenaCampania = campaniaId > 99999 ? campaniaId.ToString() : "000000";
                const int totalCampanias = 18;

                string anio = cadenaCampania.Substring(0, 4);
                string campania = cadenaCampania.Substring(4, 2);

                if (campania == "00")
                    campaniaFinal = "0";
                else
                {
                    int numeroCampania = int.Parse(campania);
                    int anioCampania = int.Parse(anio);

                    if (numeroCampaniasAtras == totalCampanias)
                    {
                        anioCampania = anioCampania - 1;
                        numeroCampania = numeroCampaniasAtras;
                    }
                    else
                    {
                        if (numeroCampaniasAtras > numeroCampania)
                        {
                            anioCampania = anioCampania - 1;
                            numeroCampania = totalCampanias - numeroCampaniasAtras + numeroCampania;
                        }
                        else
                        {
                            numeroCampania = numeroCampania - numeroCampaniasAtras;
                        }
                    }

                    if (numeroCampania < 10)
                    {
                        campaniaFinal = anioCampania + numeroCampania.ToString().PadLeft(2, '0');
                    }
                    else
                    {
                        campaniaFinal = anioCampania + numeroCampania.ToString();
                    }
                }

                resultado = int.Parse(campaniaFinal);
            }
            catch (Exception)
            {
                resultado = 0;
            }

            return resultado;
        }

        public static string GetISObyIPAddress(string ip)
        {
            if (string.IsNullOrWhiteSpace(ip)) return "";

            string geoLiteDbPath = HttpContext.Current.Request.PhysicalApplicationPath + @"\bin\MaxMind\GeoLite2-Country.mmdb";
            return GetISObyIPAddress(ip, geoLiteDbPath);
        }

        public static string GetISObyIPAddress(string ip, string geoLiteDbPath)
        {
            string iso = "00";
            using (var reader = new DatabaseReader(geoLiteDbPath, FileAccessMode.MemoryMapped))
            {
                CountryResponse countryResp = reader.Country(ip);
                if (countryResp != null)
                {
                    iso = countryResp.Country.IsoCode;
                }
            }
            return iso;
        }

        public static string ValidarUsuarioADFS(string usuario, string clave)
        {
            string codigoMensaje;
            string mensaje;
            string paisIso = "";

            try
            {
                // 1. definir la DTO con datos de configuración de conexión
                var dto = new WSTrustDTO
                {
                    Username = string.Format("Galileo\\{0}", usuario), // dominio + usuario
                    Password = clave, // contraseña del usuario
                    WSTrustEndpointAddress = ConfigurationManager.AppSettings["WSTrustEndpointUrl"]
                    // endpoint de pruebas (modificar en producción)
                };

                // 2. Configuración para el acceso del relying party
                var rst = new RequestSecurityToken
                {
                    RequestType = WSTrust13Constants.RequestTypes.Issue,
                    AppliesTo = new EndpointAddress(ConfigurationManager.AppSettings["RequestSecurityTokenUrl"]),
                    // <- no cambiar, configuración actual del relying party para consultoras
                    KeyType = WSTrust13Constants.KeyTypes.Bearer,
                    RequestDisplayToken = true
                };

                // 3. Obteniendo los claims
                var ws = new WSTrustConnection(dto);
                DisplayClaimCollection respuestaAdfs = ws.GetDisplayClaims(rst);

                // 4. Verificar datos del usuario
                if (respuestaAdfs.Count < 2)
                {
                    // Usuario no encontrado
                    codigoMensaje = "003";  //CodigosMensajesError.CodigoAutenticacionInvalida;
                    mensaje = "Autenticación invalida, Usuario no encontrado.";
                }
                else
                {
                    if (string.IsNullOrEmpty(respuestaAdfs[0].DisplayValue))
                    {
                        // País deshabilitado
                        codigoMensaje = "003";  //CodigosMensajesError.CodigoAutenticacionInvalida;
                        mensaje = "Autenticación invalida, País deshabilitado.";
                    }
                    else
                    {
                        codigoMensaje = "000";  //CodigosMensajesError.CodigoOk;
                        mensaje = "Ok";
                        paisIso = respuestaAdfs[0].DisplayValue;
                    }
                }
            }
            catch (MessageSecurityException securityException)
            {
                var innerException = securityException.InnerException as FaultException;
                if (innerException != null && innerException.Code != null && innerException.Code.IsSenderFault &&
                    innerException.Code.Name == "Sender")
                {
                    codigoMensaje = "003";  //CodigosMensajesError.CodigoAutenticacionInvalida;
                    mensaje = "Autenticación inválida: asegúrese que los datos ingresados sean los correctos.";
                }
                else
                {
                    codigoMensaje = "001";  //CodigosMensajesError.CodigoExcepcion;
                    mensaje = "Ocurrió un error durante la validación ADFS.";
                }
            }
            catch (Exception)
            {
                codigoMensaje = "001";  //CodigosMensajesError.CodigoExcepcion;
                mensaje = "Ocurrió un error durante la validación ADFS.";
            }

            var resultado = codigoMensaje + "|" + mensaje + "|" + paisIso;

            return resultado;
        }

        public static RouteValueDictionary QueryStringToRouteValueDictionary(string queryString)
        {
            var parsed = HttpUtility.ParseQueryString(queryString);
            var queryStringDic = parsed.AllKeys.ToDictionary(k => k, k => (object)parsed[k]);
            return new RouteValueDictionary(queryStringDic);
        }

        public static Uri GetUrlRecuperarContrasenia(string urlportal, int paisId, string correo, string paisiso, string codigousuario, string fechasolicitud, string nombre)
        {
            string urlPaisId = HttpUtility.UrlEncode(Crypto.EncryptLogin(paisId.ToString().Trim()));
            string urlCorreo = HttpUtility.UrlEncode(Crypto.EncryptLogin(correo.Trim()));
            string urlPaisiso = HttpUtility.UrlEncode(Crypto.EncryptLogin(paisiso.Trim()));
            string urlCodigousuario = HttpUtility.UrlEncode(Crypto.EncryptLogin(codigousuario.Trim()));
            string urlFechasolicitud = HttpUtility.UrlEncode(Crypto.EncryptLogin(fechasolicitud.Trim()));
            string urlNombre = HttpUtility.UrlEncode(Crypto.EncryptLogin(nombre.Trim()));
            string url_guiId = HttpUtility.UrlEncode(Portal.Consultoras.Common.Crypto.EncryptLogin(GenerarGUID()));

            var uri = new Uri(urlportal + "WebPages/RestablecerContrasena.aspx?xyzab=param1&abxyz=param2&yzabx=param3&bxyza=param4&zabxy=param5&wxabc=param6");
            var qs = HttpUtility.ParseQueryString(uri.Query);
            if (urlPaisId != null) qs.Set("xyzab", urlPaisId);
            if (urlCorreo != null) qs.Set("abxyz", urlCorreo);
            if (urlPaisiso != null) qs.Set("yzabx", urlPaisiso);
            if (urlCodigousuario != null) qs.Set("bxyza", urlCodigousuario);
            if (urlFechasolicitud != null) qs.Set("zabxy", urlFechasolicitud);
            if (urlNombre != null) qs.Set("xbaby", urlNombre);
            qs.Set("wxabc", url_guiId);

            var uriBuilder = new UriBuilder(uri)
            {
                Query = qs.ToString()
            };

            return uriBuilder.Uri;
        }

        public static String GetUrlCompartirFB(string codigoISO, int id = 0)
        {
            if (string.IsNullOrEmpty(ConfigurationManager.AppSettings["CONTEXTO_BASE"]))
            {
                LogManager.SaveLog(new Exception("Key no encontrada: CONTEXTO_BASE"), "", codigoISO);
                return string.Empty;
            }

            var partialUrl = "Pdto.aspx?id=" + codigoISO + "_" + (id > 0 ? id.ToString() : "[valor]");
            return ConfigurationManager.AppSettings["CONTEXTO_BASE"] + "/" + partialUrl;
        }

        public static string NombreMes(int Mes)
        {
            string result = string.Empty;
            switch (Mes)
            {
                case 1:
                    result = "Ene";
                    break;
                case 2:
                    result = "Feb";
                    break;
                case 3:
                    result = "Mar";
                    break;
                case 4:
                    result = "Abr";
                    break;
                case 5:
                    result = "May";
                    break;
                case 6:
                    result = "Jun";
                    break;
                case 7:
                    result = "Jul";
                    break;
                case 8:
                    result = "Ago";
                    break;
                case 9:
                    result = "Sep";
                    break;
                case 10:
                    result = "Oct";
                    break;
                case 11:
                    result = "Nov";
                    break;
                case 12:
                    result = "Dic";
                    break;
            }
            return result;
        }
        
        public static int AddCampaniaAndNumero(int campania, int numero, int nroCampanias)
        {
            if (campania <= 0 || nroCampanias <= 0) return 0;

            int anioCampania = campania / 100;
            int nroCampania = campania % 100;

            int sumNroCampania = (nroCampania + numero) - 1;
            int anioCampaniaResult = anioCampania + (sumNroCampania / nroCampanias);
            int nroCampaniaResult = (sumNroCampania % nroCampanias) + 1;

            if (nroCampaniaResult < 1)
            {
                anioCampaniaResult = anioCampaniaResult - 1;
                nroCampaniaResult = nroCampaniaResult + nroCampanias;
            }
            return (anioCampaniaResult * 100) + nroCampaniaResult;
        }

        public static bool IsUrl(string url)
        {
            Uri uriResult;
            return Uri.TryCreate(url, UriKind.Absolute, out uriResult);
        }

        public static bool ExisteUrlRemota(string url)
        {
            bool result;

            WebRequest webRequest = WebRequest.Create(url);
            webRequest.Timeout = 1200; // miliseconds
            webRequest.Method = "HEAD";

            HttpWebResponse response = null;

            try
            {
                response = (HttpWebResponse)webRequest.GetResponse();
                result = true;
            }
            catch (WebException webException)
            {                
                LogManager.SaveLog(new Exception("URL " + url + " no encontrada"), "", "");
                result = false;
            }
            finally
            {
                if (response != null)
                {
                    response.Close();
                }
            }

            return result;
        }

        public static string GenerarRutaImagenResize(string rutaImagen, string rutaNombreExtension)
        {            
            if (string.IsNullOrEmpty(rutaImagen))
                return "";            

            string soloImagen = Path.GetFileNameWithoutExtension(rutaImagen);

            var ruta = rutaImagen.Clone().ToString();

            ruta = ruta.Replace(soloImagen, soloImagen + rutaNombreExtension);

            return ruta;
        }
    }

    public static class DataRecord
    {
        public static bool HasColumn(this IDataRecord r, string columnName)
        {
            if (r == null) return false;

            columnName = columnName.Trim();

            if (string.IsNullOrEmpty(columnName)) return false;

            for (int i = 0; i < r.FieldCount; i++)
            {
                if (columnName.Equals(r.GetName(i), StringComparison.InvariantCultureIgnoreCase))
                    return r[columnName] != DBNull.Value;                           
            }

            return false;
        }
        public static bool HasColumn(this DataRow row, string columnName)
        {
            if (row == null) return false;

            columnName = (columnName ?? "").Trim();
            if (columnName == "") return false;

            if (row.Table.Columns.Contains(columnName)) return row[columnName] != DBNull.Value;

            return false;
        }

        public static IList<string> GetAllNames(this IDataRecord record)
        {
            var result = new List<string>();
            for (int i = 0; i < record.FieldCount; i++)
            {
                result.Add(record.GetName(i));
            }
            return result;
        }

        public static T GetColumn<T>(IDataRecord lector, string name)
        {
            try
            {
                name = name ?? "";
                name = name.Trim();
                if (HasColumn(lector, name))
                    return (T)lector.GetValue(lector.GetOrdinal(name));

                return default(T);
            }
            catch (Exception)
            {
                return default(T);
            }
        }

        /// <summary>
        /// Obtiene el valor de la fila convirtiendo a un tipo, verificar primero si existe con HasColumn
        /// </summary>
        /// <typeparam name="T">Data Row</typeparam>
        /// <param name="row">Fila</param>
        /// <param name="name">Nombre de la columna</param>
        /// <exception cref="ArgumentNullException">ArgumentNullException cuando name es enviado vacio o nulo</exception>
        /// <returns>Valor convertido</returns>
        public static T GetValue<T>(this IDataRecord row, string name)
        {
            try
            {
                if (string.IsNullOrEmpty(name))
                {
                    throw new ArgumentNullException("nombre enviado es nulo o vacio");
                }

                return (T)row.GetValue(row.GetOrdinal(name));
            }
            catch (Exception ex)
            {
                var value = row.GetValue(row.GetOrdinal(name));
                throw new InvalidCastException("campo: " + name + " no se puede convertir de " + value.GetType() + " a " + typeof(T), ex);
            }
        }
    }

    public static class LinqExtensions
    {
        public static void Update<TSource>(this IEnumerable<TSource> outer, Action<TSource> updator)
        {
            foreach (var item in outer)
            {
                updator(item);
            }
        }
    }
}
