using Portal.Consultoras.Common;
using System.Collections.Generic;

namespace Portal.Consultoras.Web.Models
{
    public class LoginChatbotModel
    {
        public int PaisID { get; set; }
        public string TokenBotmaker { get; set; }
        public bool WebViewFallBack { get; set; }
        public Enumeradores.TipoLogin Tipo { get; set; }
        public IList<PaisModel> ListaPaises { get; set; }
        public string AppFacebookId { get; set; }
    }
}