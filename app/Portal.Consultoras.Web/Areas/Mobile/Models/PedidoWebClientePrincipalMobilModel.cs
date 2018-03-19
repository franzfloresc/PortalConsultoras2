using System;
using System.Collections.Generic;

namespace Portal.Consultoras.Web.Areas.Mobile.Models
{
    [Serializable()]
    public class PedidoWebClientePrincipalMobilModel
    {
        public PedidoWebClientePrincipalMobilModel()
        {
            ListaPedidoCliente = new List<PedidoWebMobilModel>();
        }

        public string Simbolo { get; set; }

        public int PaisID { get; set; }

        public int ClienteID { get; set; }

        public List<PedidoWebMobilModel> ListaPedidoCliente { get; set; }
    }
}