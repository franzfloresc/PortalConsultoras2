using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using Portal.Consultoras.Web.ServiceSAC;

namespace Portal.Consultoras.Web.Models
{
    [Serializable]
    public class OfertaFinalModel
    {
        public OfertaFinalModel()
        {
            Success = false;
            Estado = false;
            Algoritmo = string.Empty;
        }
        public bool Success { get; set; }
        public bool Estado { get; set; }
        public string Algoritmo { get; set; }        
    }
}