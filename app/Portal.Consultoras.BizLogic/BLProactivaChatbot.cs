using Newtonsoft.Json;
using Portal.Consultoras.Common;
using Portal.Consultoras.Data;
using Portal.Consultoras.Entities;
using System;
using System.Collections.Generic;
using System.Configuration;
using System.Linq;
using System.Net;
using System.Transactions;

namespace Portal.Consultoras.BizLogic
{
    public class BLProactivaChatbot
    {
        public bool SendMessage(string paisISO, string urlRelative, List<BEChatbotProactivaMensaje> listProactivaMensaje)
        {
            bool saveLogAlways = ((ConfigurationManager.AppSettings["BotmakerApiSaveLogAlways"] ?? "0") == "1");
            var resultado = new DEChatbotProactivaResultado { PaisISO = paisISO, Url = urlRelative };

            try
            {
                var urlAbsolute = string.Format("https://go.botmaker.com/api/v1.0/{0}", urlRelative);
                var dataString = CreateJsonBody(paisISO, listProactivaMensaje);
                
                using (var webClient = new WebClient())
                {
                    webClient.Headers.Add("Content-Type", "application/json");
                    webClient.Headers.Add("Accept", "text/html");
                    webClient.Headers.Add("access-token", "eyJhbGciOiJIUzUxMiJ9.eyJidXNpbmVzc0lkIjoiYmVsY29ycGMiLCJuYW1lIjoiSGVybmFuIExpZW5kbyIsImFwaSI6dHJ1ZSwiaWQiOiJISU9JMTVMUmJoaHh4S3hiNzBUTllnQUo5bGoxIiwiZXhwIjoxNjQ5ODU3NjIzLCJqdGkiOiJISU9JMTVMUmJoaHh4S3hiNzBUTllnQUo5bGoxIn0.4R_ULN8Npng_Iof3spagET1C3H-neXoR_NMuDGIuNswNjGRTOSmhc-hQ-UlEAfeFHJcoc6vIO9BLJOmsdrYWYQ");
                    resultado.Respuesta = webClient.UploadString(urlAbsolute, "PUT", dataString);
                }
                resultado.Exitoso = (resultado.Respuesta != "0");
            }
            catch(Exception ex){ resultado.ErrorLog = ErrorUtilities.GetExceptionMessage(ex); }

            if (saveLogAlways || !resultado.Exitoso) SaveDatabaseLog(resultado, listProactivaMensaje);
            return resultado.Exitoso;
        }

        private string CreateJsonBody(string paisISO, List<BEChatbotProactivaMensaje> listMensajeProactiva)
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

        private void SaveDatabaseLog(DEChatbotProactivaResultado resultado, List<BEChatbotProactivaMensaje> listProactivaMensaje)
        {
            try
            {
                resultado.ListMensaje = listProactivaMensaje.Select(pm => new DEChatbotProactivaMensaje {
                    CodigoUsuario = pm.CodigoUsuario,
                    NombreMensaje = pm.NombreMensaje,
                    Variables = string.Join(",", pm.Variables.Select(v => string.Format("\"{0}\":\"{1}\"", v.Item1, v.Item2)).ToArray())
                }).ToList();

                TransactionOptions transactionOptions = new TransactionOptions { IsolationLevel = IsolationLevel.ReadUncommitted };
                using (TransactionScope transaction = new TransactionScope(TransactionScopeOption.Required, transactionOptions))
                {
                    int paisID = Util.GetPaisID(resultado.PaisISO);
                    new DABotmakerApiLog(paisID).Insert(resultado);
                    transaction.Complete();
                }
            }
            catch (Exception ex) {
                var codigosUsuarios = string.Join(",", listProactivaMensaje.Select(pm => pm.CodigoUsuario));
                LogManager.SaveLog(ex, codigosUsuarios, resultado.PaisISO);
            }
        }
    }
}
