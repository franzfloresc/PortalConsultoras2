using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace Portal.Consultoras.Web.Models.PagoEnLinea
{
    [Serializable]
    public class PagoEnLineaTipoPagoModel
    {
        public int PagoEnLineaTipoPagoId { get; set; }
        public string Descripcion { get; set; }
        public string Codigo { get; set; }
        public bool Estado { get; set; }
    }
}