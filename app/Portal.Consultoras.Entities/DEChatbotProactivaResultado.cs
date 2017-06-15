using System.Collections.Generic;

namespace Portal.Consultoras.Entities
{
    public class DEChatbotProactivaResultado
    {
        public int Id { get; set; }
        public string PaisISO { get; set; }
        public string Url { get; set; }
        public bool Exitoso { get; set; }
        public string Respuesta { get; set; }
        public string ErrorLog { get; set; }
        public List<DEChatbotProactivaMensaje> ListMensaje { get; set; }
    }
}
