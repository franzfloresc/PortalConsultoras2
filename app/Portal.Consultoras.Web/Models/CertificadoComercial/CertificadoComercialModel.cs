using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace Portal.Consultoras.Web.Models.CertificadoComercial
{
    [Serializable]
    public class CertificadoComercialModel
    {
        public int CertificadoComercialId { get; set; }
        public string Nombre { get; set; }
        public string MensajeError { get; set; }
        public string NombreVista { get; set; }       
    }
}