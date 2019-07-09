using Portal.Consultoras.Web.Models.Config.Response;
using Portal.Consultoras.Web.Models.Search.ResponsePromociones.Estructura;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace Portal.Consultoras.Web.Models.Search.ResponsePromociones
{
    public class OutputPromociones : ResponseStatus
    {
        public IList<PromocionModel> result { get; set; }
    }
}