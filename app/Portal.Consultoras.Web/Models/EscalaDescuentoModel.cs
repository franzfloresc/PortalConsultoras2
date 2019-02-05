using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace Portal.Consultoras.Web.Models
{
    public class EscalaDescuentoModel
    {
        public string MontoMinimo { get; set; }
        public string MontoMaximo { get; set; }
        public string PorcentajeDescuento { get; set; }
    }
}