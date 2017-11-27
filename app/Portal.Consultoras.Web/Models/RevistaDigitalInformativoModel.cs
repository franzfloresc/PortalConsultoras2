using Portal.Consultoras.Common;
using System;
using System.Collections.Generic;

namespace Portal.Consultoras.Web.Models
{
    [Serializable]
    public class RevistaDigitalInformativoModel
    {
        public bool EsSuscrita { get; set; }
        public int EstadoSuscripcion { get; set; }
        public string Video { get; set; }
        
    }
}