using System;

namespace Portal.Consultoras.Web.Areas.Mobile.Models
{
    [Serializable]
    public class MobileAppConfiguracionModel
    {
        /// <summary>
        /// Establece si se mostrara o no el boton atras en las vistas
        /// </summary>
        public bool MostrarBotonAtras { get; set; }
        public int ClienteID { get; set; }

        /// <summary>
        /// Determina si se muestra o no un hipervinculo
        /// </summary>
        public bool MostrarHipervinculo { get; set; }

        /// <summary>
        /// Determina si es app mobile o no
        /// </summary>
        public bool EsAppMobile { get; set; }

        /// <summary>
        /// Obtiene o establece el tiempo que se guardara las variables de session
        /// </summary>
        public int TimeOutSession { get; set; }
        
        public MobileAppConfiguracionModel()
        {
            MostrarBotonAtras = true;
            MostrarHipervinculo = true;
        }
    }
}
