﻿using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace Portal.Consultoras.Web.Models
{
    public class ConfiguracionValidacionZonaModel
    {
        public int CampaniaID { set; get; }
        public int ZonaID { set; get; }
        public string Codigo { set; get; }
        public Int16 ValidacionActiva { set; get; }
        public int PaisID { set; get; }
    }
}