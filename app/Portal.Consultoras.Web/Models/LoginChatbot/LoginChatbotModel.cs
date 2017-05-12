using System.Collections.Generic;

namespace Portal.Consultoras.Web.Models.LoginChatbot
{
    public class LoginChatbotModel
    {
        public string TokenBotmaker { get; set; }
        public bool WebViewFallBack { get; set; }
        public string PaisesEsika { get; set; }
        public string UrlBotmakerChat { get; set; }
        public IList<PaisModel> ListaPaises { get; set; }
    }
}