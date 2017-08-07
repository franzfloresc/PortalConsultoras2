using System;
using System.Collections.Generic;

namespace Portal.Consultoras.Web.Models
{
    [Serializable]
    public class ConfiguracionPaisModel
    {
        public int ConfiguracionPaisID { get; set; }
        public string Codigo { get; set; }
        public bool Excluyente { get; set; }
        public string Descripcion { get; set; }
        public bool Estado { get; set; }
        public bool Validado { get; set; }
    }
}