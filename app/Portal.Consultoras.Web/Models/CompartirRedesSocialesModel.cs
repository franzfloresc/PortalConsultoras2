using System;

namespace Portal.Consultoras.Web.Models
{
    [Serializable]
    public class CompartirRedesSocialesModel
    {
        // Face Book
        public string FBMensaje { get; set; }
        public string FBRuta { get; set; }

        // Whats App
        public string WAMensaje { get; set; }
        public string WARuta { get; set; }
    }
}