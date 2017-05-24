using Newtonsoft.Json;
using Portal.Consultoras.Common;
using Portal.Consultoras.Entities;
using System;
using System.Collections.Generic;
using System.Configuration;
using System.Linq;
using System.Net;

namespace Portal.Consultoras.BizLogic
{
    public class BLProactivaChatbot
    {
        public bool SendMessage(string paisISO, string urlRelative, List<BEChatbotMensajeProactiva> listMensajeProactiva)
        {
            bool saveLogAlways = ((ConfigurationManager.AppSettings["BotmakerApiSaveLogAlways"] ?? "0") == "1");
            string respuesta = "";
            string error = "";
            bool success = false;

            try
            {
                var urlAbsolute = string.Format("https://go.botmaker.com/api/v1.0/{0}", urlRelative);
                var dataString = CreateJsonBody(paisISO, listMensajeProactiva);
                
                using (var webClient = new WebClient())
                {
                    webClient.Headers.Add("Content-Type", "application/json");
                    webClient.Headers.Add("Accept", "text/html");
                    webClient.Headers.Add("access-token", "eyJhbGciOiJIUzUxMiJ9.eyJidXNpbmVzc0lkIjoiYmVsY29ycGMiLCJuYW1lIjoiSGVybmFuIExpZW5kbyIsImFwaSI6dHJ1ZSwiaWQiOiJISU9JMTVMUmJoaHh4S3hiNzBUTllnQUo5bGoxIiwiZXhwIjoxNjQ5ODU3NjIzLCJqdGkiOiJISU9JMTVMUmJoaHh4S3hiNzBUTllnQUo5bGoxIn0.4R_ULN8Npng_Iof3spagET1C3H-neXoR_NMuDGIuNswNjGRTOSmhc-hQ-UlEAfeFHJcoc6vIO9BLJOmsdrYWYQ");
                    respuesta = webClient.UploadString(urlAbsolute, "PUT", dataString);
                }
                return respuesta != "0";
            }
            catch(Exception ex){ error = ErrorUtilities.GetExceptionMessage(ex); }

            //if (!success) SaveDatabaseLog(paisISO, urlRelative, listMensajeProactiva, null);
            return success;
        }

        private string CreateJsonBody(string paisISO, List<BEChatbotMensajeProactiva> listMensajeProactiva)
        {
            var bodyJson = listMensajeProactiva.Select(mp => new {
                variables = mp.Variables.Select(v => new { name = v.Item1, value = v.Item2 }).ToArray(),
                customerQuery = new[] {
                    new { name = "belcorpConsultoraState-userContext.loginResult.PaisISO", value = paisISO},
                    new { name = "belcorpConsultoraState-userContext.loginResult.CodigoUsuario", value = mp.CodigoUsuario }
                },
                messageRuleName = mp.NombreMensaje,
                platform = "MESSENGER"
            }).ToArray();
            return JsonConvert.SerializeObject(bodyJson);
        }

        //private bool SaveDatabaseLog(string paisISO, string urlRelative, List<BEChatbotMensajeProactiva> listMensajeProactiva, Exception ex)
        //{
        //    try
        //    {
        //        var urlAbsolute = string.Format("https://go.botmaker.com/api/v1.0/{0}", urlRelative);

        //        var bodyJson = listMensajeProactiva.Select(mp => new {
        //            variables = mp.Variables.Select(v => new { name = v.Item1, value = v.Item2 }).ToArray(),
        //            customerQuery = new[] {
        //                new { name = "belcorpConsultoraState-userContext.loginResult.PaisISO", value = mp.PaisISO},
        //                new { name = "belcorpConsultoraState-userContext.loginResult.CodigoUsuario", value = mp.CodigoUsuario }
        //            },
        //            messageRuleName = mp.NombreMensaje,
        //            platform = "MESSENGER"
        //        }).ToArray();
        //        var dataString = JsonConvert.SerializeObject(bodyJson);

        //        string response;
        //        using (var webClient = new WebClient())
        //        {
        //            webClient.Headers.Add("Content-Type", "application/json");
        //            webClient.Headers.Add("Accept", "text/html");
        //            webClient.Headers.Add("access-token", "eyJhbGciOiJIUzUxMiJ9.eyJidXNpbmVzc0lkIjoiYmVsY29ycGMiLCJuYW1lIjoiSGVybmFuIExpZW5kbyIsImFwaSI6dHJ1ZSwiaWQiOiJISU9JMTVMUmJoaHh4S3hiNzBUTllnQUo5bGoxIiwiZXhwIjoxNjQ5ODU3NjIzLCJqdGkiOiJISU9JMTVMUmJoaHh4S3hiNzBUTllnQUo5bGoxIn0.4R_ULN8Npng_Iof3spagET1C3H-neXoR_NMuDGIuNswNjGRTOSmhc-hQ-UlEAfeFHJcoc6vIO9BLJOmsdrYWYQ");
        //            response = webClient.UploadString(urlAbsolute, "PUT", dataString);
        //        }
        //        return response != "0";
        //    }
        //    catch (Exception ex) { return false; }
        //}
    }
}
