using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace Portal.Consultoras.Web.Models
{
    public class RolModel
    {
        public string Descripcion { get; set; }
        public int PaisID { get; set; }
        public bool Sistema { get; set; }
        public int? PermisoID { get; set; }
        public int RolID { get; set; }
    }
}
