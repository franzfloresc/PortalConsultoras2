using System;

namespace Portal.Consultoras.Web.Models
{
    [Serializable]
    public class GuiaNegocioModel
    {
        public bool TieneGND { get; set; }
        public bool BloqueoProductoDigital { get; set; }
    }
}