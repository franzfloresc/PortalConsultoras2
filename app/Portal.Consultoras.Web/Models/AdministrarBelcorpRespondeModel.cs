using System;
using System.Collections.Generic;

namespace Portal.Consultoras.Web.Models
{
    public class AdministrarBelcorpRespondeModel
    {
        public int PaisID { get; set; }
        public IEnumerable<PaisModel> lstPais { get; set; }
        public string Telefono1 { get; set; }
        public string Telefono2 { get; set; }
        public string Escribenos { get; set; }
        public string EscribenosURL { get; set; }
        public string Chat { get; set; }
        public string ChatURL { get; set; }
        public string Correo { get; set; }
        public string CorreoBcc { get; set; }
        public Boolean ParametroPais { get; set; }
        public Boolean ParametroCodigoConsultora { get; set; }
    }
}