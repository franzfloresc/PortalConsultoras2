using Newtonsoft.Json;
using Portal.Consultoras.Common;
using Portal.Consultoras.Data;
using Portal.Consultoras.Entities;
using System;
using System.Collections.Generic;
using System.Configuration;
using System.Linq;
using System.Net;
using System.Net.Http;
using System.Net.Http.Headers;
using System.Text;
using System.Threading.Tasks;
using System.Transactions;
using Microsoft.Practices.ObjectBuilder2;

namespace Portal.Consultoras.BizLogic
{
    public class BLProactivaChatbot
    {
        private readonly string _chatBotToken;
        private readonly string _chatBotUrl;
        private readonly bool _saveLogAlways;

        public BLProactivaChatbot()
        {
            _saveLogAlways = ((ConfigurationManager.AppSettings["BotmakerApiSaveLogAlways"] ?? "0") == "1");
            _chatBotToken = ConfigurationManager.AppSettings["BotmakerToken"];
            _chatBotUrl = ConfigurationManager.AppSettings["BotmakerApi"];
            if (string.IsNullOrEmpty(_chatBotUrl))
            {
                throw new ArgumentException("Key vacia: BotmakerApi");
            }
        }

        public bool SendMessage(string paisISO, string urlRelative, List<BEChatbotProactivaMensaje> listProactivaMensaje)
        {
            var urlAbsolute = string.Format("{0}/{1}", _chatBotUrl, urlRelative);

            var sendOfertaTasks = listProactivaMensaje
                .Select(async o => await ProcesarEnviarAsync(urlAbsolute, paisISO, o))
                .ToArray();

            //var tasksResult = Task.WhenAll(sendOfertaTasks);
            Task.WaitAll(sendOfertaTasks);
            return sendOfertaTasks.All(st => st.Result);
            //return tasksResult.IsCompleted && !tasksResult.Result.Any(t => !t);
        }

        private async Task<bool> ProcesarEnviarAsync(string urlAbsolute, string paisIso, BEChatbotProactivaMensaje mensaje)
        {
            var resultado = new DEChatbotProactivaResultado { PaisISO = paisIso, Url = urlAbsolute };

            try
            {
                var content = CreateSingleJsonContent(paisIso, mensaje);
                using (var client = new HttpClient())
                {
                    client.Timeout = TimeSpan.FromMinutes(5);
                    client.DefaultRequestHeaders.Accept.Add(new MediaTypeWithQualityHeaderValue("application/json"));
                    client.DefaultRequestHeaders.Add("access-token", _chatBotToken);

                    var response = await client.PutAsync(urlAbsolute, content);
                    if (!response.IsSuccessStatusCode)
                    {
                        resultado.Respuesta = response.StatusCode.ToString();
                        resultado.ErrorLog = await response.Content.ReadAsStringAsync();
                    }


                    resultado.Exitoso = response.IsSuccessStatusCode;
                }
            }
            catch (Exception ex)
            {
                resultado.ErrorLog = ErrorUtilities.GetExceptionMessage(ex);
            }

            if (_saveLogAlways || !resultado.Exitoso)
                SaveDatabaseLog(resultado, new List<BEChatbotProactivaMensaje> { mensaje });

            return resultado.Exitoso;
        }

        private static StringContent CreateSingleJsonContent(string paisISO, BEChatbotProactivaMensaje mensaje)
        {
            var bodyJson = new[] {
            new {
                    variables = mensaje.Variables.Select(v =>
                        new
                        {
                            name = v.Item1,
                            value = v.Item2
                        }).ToArray(),
                    customerQuery = new[] {
                        new { name = "belcorpConsultoraState-userContext.loginResult.PaisISO", value = paisISO},
                        new { name = "belcorpConsultoraState-userContext.loginResult.CodigoUsuario", value = mensaje.CodigoUsuario }
                    },
                    messageRuleName = mensaje.NombreMensaje,
                    platform = "MESSENGER"
                }
            };

            return new StringContent(JsonConvert.SerializeObject(bodyJson), Encoding.UTF8, "application/json");
        }

        private static void SaveDatabaseLog(DEChatbotProactivaResultado resultado, List<BEChatbotProactivaMensaje> listProactivaMensaje)
        {
            try
            {
                resultado.ListMensaje = listProactivaMensaje.Select(pm => new DEChatbotProactivaMensaje
                {
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
            catch (Exception ex)
            {
                var codigosUsuarios = string.Join(",", listProactivaMensaje.Select(pm => pm.CodigoUsuario));
                LogManager.SaveLog(ex, codigosUsuarios, resultado.PaisISO);
            }
        }
    }
}
