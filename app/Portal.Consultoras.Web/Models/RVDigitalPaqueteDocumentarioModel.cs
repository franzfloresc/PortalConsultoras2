using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace Portal.Consultoras.Web.Models
{
    public class RVDigitalPaqueteDocumentarioModel
    {
        public int PaisID { get; set; }
        public IEnumerable<PaisModel> listaPaises { get; set; }
    }
}