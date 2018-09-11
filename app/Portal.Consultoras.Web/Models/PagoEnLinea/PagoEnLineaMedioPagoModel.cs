using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace Portal.Consultoras.Web.Models.PagoEnLinea
{
    [Serializable]
    public class PagoEnLineaMedioPagoModel
    {
        public int PagoEnLineaMedioPagoId { get; set; }
        public string Descripcion { get; set; }
        public string Codigo { get; set; }
        public string RutaIcono { get; set; }
        public int Orden { get; set; }
        public string TextoToolTip { get; set; }
        public bool Estado { get; set; }
    }
}