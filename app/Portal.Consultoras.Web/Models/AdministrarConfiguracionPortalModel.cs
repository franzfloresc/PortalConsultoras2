﻿using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace Portal.Consultoras.Web.Models
{
    public class AdministrarConfiguracionPortalModel
    {
        public int PaisID { get; set; }
        public Boolean EstadoSimplificacionCUV { get; set; }
        public Boolean EsquemaDAConsultora { get; set; }
        public Boolean TipoProcesoCarga { get; set; }
        public IEnumerable<PaisModel> lstPais { get; set; }
        
    }
}
