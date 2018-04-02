using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace Portal.Consultoras.Web.Models
{
    [Serializable]
    public class RevistaDigitalShortModel
    {
        public bool TieneRDI { get; set; }
        public bool TieneRDR { get; set; }
        public bool TieneRDC { get; set; }
        public bool TieneRDS { get; set; }
        public bool EsActiva { get; set; }
        public bool EsSuscrita { get; set; }
    }
}