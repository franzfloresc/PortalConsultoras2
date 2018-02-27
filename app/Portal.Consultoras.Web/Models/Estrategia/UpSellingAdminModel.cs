using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using Portal.Consultoras.Web.Infraestructure;

namespace Portal.Consultoras.Web.Models.Estrategia
{
    public class UpSellingAdminModel
    {
        public string PaisIso { get; set; }

        public string PaisNombre { get; set; }

        public IEnumerable<CampaniaModel> Campanas { get; set; }

        public bool EsPaisEsika { get; set; }
        public string UrlS3 { get; internal set; }
    }
}
