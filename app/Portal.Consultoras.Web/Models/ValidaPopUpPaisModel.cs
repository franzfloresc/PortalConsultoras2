using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace Portal.Consultoras.Web.Models
{
    public class ValidaPopUpPaisModel
    {
        public bool ShowPopupMisDatos { get; set; }
        public int ValidaDatosActualizados { get; set; }
        public int ValidaTiempoVentana { get; set; }
        public int ValidaSegmento { get; set; }
    }
}