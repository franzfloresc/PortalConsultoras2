using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace Portal.Consultoras.Web.Models.PagoEnLinea
{
    [Serializable]
    public class PagoEnLineaTipoPasarelaModel
    {
        public int PagoEnLineaTipoPasarelaId { get; set; }
        public string CodigoPlataforma { get; set; }
        public string Codigo { get; set; }
        public string Descripcion { get; set; }
        public string Valor { get; set; }
    }
}