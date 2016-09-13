﻿using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace Portal.Consultoras.Web.Models
{
    public class ConfiguracionCrossSellingModel
    {
        public int PaisID { get; set; }
        public string Pais { get; set; }
        public int CampaniaID { get; set; }
        public int HabilitarDiasValidacion { get; set; }
        public IEnumerable<PaisModel> lstPais { get; set; }
        public IEnumerable<CampaniaModel> lstCampania { get; set; }
    }
}