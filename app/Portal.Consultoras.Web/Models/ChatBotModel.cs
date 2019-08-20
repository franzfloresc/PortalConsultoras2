using System.Collections.Generic;

namespace Portal.Consultoras.Web.Models
{
    public class ChatBotModel
    {
        public int PaisID { get; set; }
        public string FechaInicio { set; get; }
        public string FechaFin { set; get; }
        public IEnumerable<PaisModel> listaPaises { get; set; }

    }
}