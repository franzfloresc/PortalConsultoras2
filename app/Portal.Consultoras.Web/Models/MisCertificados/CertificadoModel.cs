using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace Portal.Consultoras.Web.Models.MisCertificados
{
    [Serializable]
    public class CertificadoModel
    {
        public int CertificadoComercialId { get; set; }
        public string Nombre { get; set; }
        public string MensajeError { get; set; }
        public string NombreVista { get; set; }       
    }
}