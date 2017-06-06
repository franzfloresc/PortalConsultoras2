using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Portal.Consultoras.Web.Areas.Mobile.Models
{
    [Serializable]
    public class MobileAppConfiguracionModel
    {
        /// <summary>
        /// Establece si se mostrara o no el boton atras en las vistas
        /// </summary>
        public bool EsconderBotonAtras { get; set; }
    }
}
