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
        private readonly int _messagePerRequest;
        private readonly int _chatBotTimeOut;

        public BLProactivaChatbot()
        {
            if (string.IsNullOrEmpty(ConfigurationManager.AppSettings["BotmakerApiSaveLogAlways"]))
                throw new ArgumentException("Key vacia: BotmakerApiSaveLogAlways");

            if (string.IsNullOrEmpty(ConfigurationManager.AppSettings["BotmakerToken"]))
                throw new ArgumentException("Key vacia: BotmakerToken");

            if (string.IsNullOrEmpty(ConfigurationManager.AppSettings["BotmakerApi"]))
                throw new ArgumentException("Key vacia: BotmakerApi");

            if (string.IsNullOrEmpty(ConfigurationManager.AppSettings["BotmakerMenssagePerRequest"]))
                throw new ArgumentException("Key vacia: BotmakerMenssagePerRequest");

            if (string.IsNullOrEmpty(ConfigurationManager.AppSettings["BotmakerTimeOut"]))
                throw new ArgumentException("Key vacia: BotmakerTimeOut");

            _saveLogAlways = ((ConfigurationManager.AppSettings["BotmakerApiSaveLogAlways"] ?? "0") == "1");
            _chatBotToken = ConfigurationManager.AppSettings["BotmakerToken"];
            _chatBotUrl = ConfigurationManager.AppSettings["BotmakerApi"];
            _messagePerRequest = int.Parse(ConfigurationManager.AppSettings["BotmakerMenssagePerRequest"]);
            _chatBotTimeOut = int.Parse(ConfigurationManager.AppSettings["BotmakerTimeOut"]);
        }

        public bool SendMessage(string paisISO, string urlRelative, List<BEChatbotProactivaMensaje> listProactivaMensaje)
        {
            var urlAbsolute = string.Format("{0}/{1}", _chatBotUrl, urlRelative);

            var pages = Math.Ceiling((double)listProactivaMensaje.Count / _messagePerRequest);

            var tasks = new List<Task<bool>>();

            for (int i = 1; i <= pages; i++)
            {
                var group = listProactivaMensaje
                    .Skip((i - 1) * _messagePerRequest)
                    .Take(_messagePerRequest);

                tasks.Add(ProcesarEnviarAsync(urlAbsolute, paisISO, group));
            }

            var resultTask = Task.WhenAll(tasks);
            Task.WaitAll(resultTask);

            return resultTask.IsCompleted && tasks.All(a => a.Result);
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
                    client.DefaultRequestHeaders.Accept.Clear();
                    client.DefaultRequestHeaders.Accept.Add(new MediaTypeWithQualityHeaderValue("text/plain"));
                    client.DefaultRequestHeaders.Add("access-token", _chatBotToken);

                    var response = await client.PutAsync(urlAbsolute, content);
                    if (!response.IsSuccessStatusCode)
                    {
                        resultado.ErrorLog = response.StatusCode.ToString();
                    }

                    resultado.Respuesta = await response.Content.ReadAsStringAsync();
                    resultado.Exitoso = response.IsSuccessStatusCode;
                }
            }
            catch (Exception ex)
            {
                resultado.ErrorLog = ErrorUtilities.GetExceptionMessage(ex);
            }

            return resultado;
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
                int paisId = Util.GetPaisID(resultado.PaisISO);
                resultado.ListMensaje = listProactivaMensaje.Select(pm => new DEChatbotProactivaMensaje
                {
                    CodigoUsuario = pm.CodigoUsuario,
                    NombreMensaje = pm.NombreMensaje,
                    Variables = string.Join(",", pm.Variables.Select(v => string.Format("\"{0}\":\"{1}\"", v.Item1, v.Item2)).ToArray())
                }).ToList();

                TransactionOptions transactionOptions = new TransactionOptions { IsolationLevel = IsolationLevel.ReadUncommitted };
                using (TransactionScope transaction = new TransactionScope(TransactionScopeOption.Required, transactionOptions))
                {
                    new DABotmakerApiLog(paisId).Insert(resultado);
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
