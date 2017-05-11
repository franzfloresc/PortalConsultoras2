using System.Collections.Generic;

namespace Portal.Consultoras.Web.Models.LoginChatbot
{
    public class LoginChatbotModel
    {
        public string TokenBotmaker { get; set; }
        public bool WebViewFallBack { get; set; }
        public IList<PaisModel> ListaPaises { get; set; }
    }
}