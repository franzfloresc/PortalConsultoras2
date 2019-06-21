namespace Portal.Consultoras.Entities.Search.ResponseRecomendacion
{
    using Portal.Consultoras.Entities.Search.Response;
    using Portal.Consultoras.Entities.Search.ResponseRecomendacion.Estructura;
    using System.Collections.Generic;

    public class OutputOfertaLista : ResponseStatus
    {
        public IList<Estrategia> Result { get; set; }
    }
}