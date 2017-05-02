using System.Collections.Generic;

namespace Portal.Consultoras.Web.Models.LoginChatbot
{
    public class LoginNormalChatbotModel : LoginChatbotModel
    {
        public IList<PaisModel> ListaPaises { get; set; }
    }
}