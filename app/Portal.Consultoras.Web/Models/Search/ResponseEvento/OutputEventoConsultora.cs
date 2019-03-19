namespace Portal.Consultoras.Web.Models.Search.ResponseEvento
{
    using Portal.Consultoras.Web.Models.Search.Response;
    using Portal.Consultoras.Web.Models.Search.ResponseEvento.Estructura;
    using System.Collections.Generic;

    public class OutputEventoConsultora : ResponseStatus
    {
        public IList<EventoConsultora> Result { get; set; }
    }
}