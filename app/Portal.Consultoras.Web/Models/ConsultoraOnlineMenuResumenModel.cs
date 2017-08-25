using System;

namespace Portal.Consultoras.Web.Models
{
    [Serializable]
    public class ConsultoraOnlineMenuResumenModel
    {
        public int TipoMenuConsultoraOnline { get; set; }
        public int CantPedidosPendientes { get; set; }
        public string TeQuedanConsultoraOnline { get; set; }
        public int MenuHijoIDConsultoraOnline { get; set; }
        public int MenuPadreIDConsultoraOnline { get; set; }

        public ConsultoraOnlineMenuResumenModel()
        {
            TeQuedanConsultoraOnline = "";
        }
    }
}