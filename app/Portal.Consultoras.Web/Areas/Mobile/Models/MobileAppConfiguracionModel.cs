using System;

namespace Portal.Consultoras.Web.Areas.Mobile.Models
{
    [Serializable]
    public class MobileAppConfiguracionModel
    {
        public bool MostrarBotonAtras { get; set; }

        public int ClienteID { get; set; }

        public bool MostrarHipervinculo { get; set; }

        public bool EsAppMobile { get; set; }

        public int TimeOutSession { get; set; }

        public MobileAppConfiguracionModel()
        {
            MostrarBotonAtras = true;
            MostrarHipervinculo = true;
        }
        public int Campania { get; set; }
    }
}
