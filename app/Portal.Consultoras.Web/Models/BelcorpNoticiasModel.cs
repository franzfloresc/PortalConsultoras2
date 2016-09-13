using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using Portal.Consultoras.Web.ServiceSAC;

namespace Portal.Consultoras.Web.Models
{
    public class BelcorpNoticiasModel
    {
        public int PaisID { set; get; }
        public int CampaniaID { set; get; }
        public string ISO { get; set; }
        public IEnumerable<BEBelcorpNoticia> listaBelcorpNoticias { set; get; }
    }
}