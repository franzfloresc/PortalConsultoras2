using Newtonsoft.Json;
using Portal.Consultoras.Common;
using Portal.Consultoras.Data;
using Portal.Consultoras.Entities;
using System;
using System.Collections.Generic;
using System.Configuration;
using System.Linq;
using System.Net.Http;
using System.Net.Http.Headers;
using System.Text;
using System.Threading.Tasks;
using System.Transactions;

namespace Portal.Consultoras.BizLogic
{
    public class BLProactivaChatbot
    {
        private readonly string _chatBotToken;
        private readonly string _chatBotUrl;
        private readonly bool _saveLogAlways;
        private readonly int _messageLenght;
        private readonly int _chatBotTimeOut;

        public BLProactivaChatbot()
        {
            _saveLogAlways = ((ConfigurationManager.AppSettings["BotmakerApiSaveLogAlways"] ?? "0") == "1");
            _chatBotToken = ConfigurationManager.AppSettings["BotmakerToken"];
            _chatBotUrl = ConfigurationManager.AppSettings["BotmakerApi"];

            if (string.IsNullOrEmpty(_chatBotUrl))
            {
                throw new ArgumentException("Key vacia: BotmakerApi");
            }
            _messageLenght = int.Parse(ConfigurationManager.AppSettings["BotmakerMenssagePerRequest"]);
            _chatBotTimeOut = int.Parse(ConfigurationManager.AppSettings["BotmakerTimeOut"]);
        }

        public bool SendMessage(string paisISO, string urlRelative, List<BEChatbotProactivaMensaje> listProactivaMensaje)
        {
            var urlAbsolute = string.Format("{0}/{1}", _chatBotUrl, urlRelative);

            var pages = listProactivaMensaje.Count / _messageLenght;
            if (pages == 0)
                pages = 1;

            var tasks = new List<Task<bool>>();

            for (int i = 1; i <= pages; i++)
            {
                var group = listProactivaMensaje
                    .Skip((i - 1) * _messageLenght)
                    .Take(_messageLenght);

                tasks.Add(ProcesarEnviarAsync(urlAbsolute, paisISO, group));
            }

            var resultTask = Task.WhenAll(tasks);
            Task.WaitAll(resultTask);

            return resultTask.IsCompleted && tasks.All(a => a.Result);
        }

        [Obsolete]
        private async Task<bool> ProcesarEnviarAsync(string urlAbsolute, string paisIso, BEChatbotProactivaMensaje mensaje)
        {
            var content = CreateJsonContent(paisIso, mensaje);
            var resultado = await EnviarAsync(urlAbsolute, paisIso, content);

            if (_saveLogAlways || !resultado.Exitoso)
                SaveDatabaseLog(resultado, new List<BEChatbotProactivaMensaje> { mensaje });

            return resultado.Exitoso;
        }

        private async Task<bool> ProcesarEnviarAsync(string urlAbsolute, string paisIso, IEnumerable<BEChatbotProactivaMensaje> mensaje)
        {
            var content = CreateJsonContent(paisIso, mensaje);
            var resultado = await EnviarAsync(urlAbsolute, paisIso, content);

            if (_saveLogAlways || !resultado.Exitoso)
                SaveDatabaseLog(resultado, mensaje);

            return resultado.Exitoso;
        }

        private async Task<DEChatbotProactivaResultado> EnviarAsync(string urlAbsolute, string paisIso, StringContent content)
        {
            var resultado = new DEChatbotProactivaResultado { PaisISO = paisIso, Url = urlAbsolute };
            try
            {
                using (var client = new HttpClient())
                {
                    client.Timeout = TimeSpan.FromSeconds(_chatBotTimeOut);
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

            return resultado;
        }

        [Obsolete]
        private static StringContent CreateJsonContent(string paisISO, BEChatbotProactivaMensaje mensaje)
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

        private static StringContent CreateJsonContent(string paisISO, IEnumerable<BEChatbotProactivaMensaje> listMensajeProactiva)
        {
            var bodyJson = listMensajeProactiva.Select(mp => new
            {
                variables = mp.Variables.Select(v => new { name = v.Item1, value = v.Item2 }).ToArray(),
                customerQuery = new[] {
                    new { name = "belcorpConsultoraState-userContext.loginResult.PaisISO", value = paisISO},
                    new { name = "belcorpConsultoraState-userContext.loginResult.CodigoUsuario", value = mp.CodigoUsuario }
                },
                messageRuleName = mp.NombreMensaje,
                platform = "MESSENGER"
            }).ToArray();

            return new StringContent(JsonConvert.SerializeObject(bodyJson), Encoding.UTF8, "application/json");
        }

        private static void SaveDatabaseLog(DEChatbotProactivaResultado resultado, IEnumerable<BEChatbotProactivaMensaje> listProactivaMensaje)
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
