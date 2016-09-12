using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace Portal.Consultoras.Web.Models
{
    public class RegionModel
    {
        public int RegionID { get; set; }
        public int PaisID { get; set; }
        public string Codigo { get; set; }
        public string Nombre { get; set; }

    }
}