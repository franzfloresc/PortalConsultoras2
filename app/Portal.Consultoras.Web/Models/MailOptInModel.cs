using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using Portal.Consultoras.Web.ServiceSAC;


namespace Portal.Consultoras.Web.Models
{
    public class MailOptInModel
    {
        public string UrlConfirmacion { get; set; }

        public string Telefono1 { get; set; }

        public string Telefono2 { get; set; }

        public string Nombre { get; set; }
    }
}