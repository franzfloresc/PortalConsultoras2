using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace Portal.Consultoras.Web.Models
{
    [Serializable]
    public class PagoEnlineaInfoModel
    {
        public decimal MontoSaldoActual { get; set; }
        public string Nombre { get; set; }
        public DateTime FechaConferencia { get; set; }
    }
}