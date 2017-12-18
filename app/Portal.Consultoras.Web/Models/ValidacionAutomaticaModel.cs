using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using Portal.Consultoras.Web.ServicePedido;

namespace Portal.Consultoras.Web.Models
{
    public class ValidacionAutomaticaModel
    {
        public List<BEValidacionAutomatica> ListaValidacionAutomatica { get; set; }
        public int Proceso { get; set; }
    }
}