namespace Portal.Consultoras.Web.Models.Oferta.ResponseOfertaGenerico
{
    using Portal.Consultoras.Web.Models.Search.Response;
    using Portal.Consultoras.Web.Models.Search.ResponseOferta.Estructura;
    using System.Collections.Generic;

    public class OutputOfertaLista : ResponseStatus
    {
        public IList<Estrategia> Result { get; set; }
    }
}