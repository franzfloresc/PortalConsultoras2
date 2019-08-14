using Portal.Consultoras.Web.Models.Config.Response;
using Portal.Consultoras.Web.Models.Search.ResponsePromociones.Estructura;
using System.Collections.Generic;

namespace Portal.Consultoras.Web.Models.Search.ResponsePromociones
{
    public class OutputPromociones : ResponseStatus
    {
        public IList<PromocionModel> Result { get; set; }
    }
}