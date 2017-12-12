using System;

namespace Portal.Consultoras.Web.Models
{
    [Serializable]
    public class CompartirRedesSocialesModel
    {
        public string FBMensaje { get; set; }
        public string FBRuta { get; set; }

        public string WAMensaje { get; set; }
        public string WARuta { get; set; }
    }
}
