namespace Portal.Consultoras.Web.Models.Search.ResponseEvento
{
    using Portal.Consultoras.Web.Models.Search.Response;
    using Portal.Consultoras.Web.Models.Search.ResponseEvento.Estructura;
    using System.Collections.Generic;

    public class OutputEvento : ResponseStatus
    {
        public IList<Evento> Result { get; set; }
    }
}