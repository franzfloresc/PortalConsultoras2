﻿namespace Portal.Consultoras.Web.Models.Oferta.ResponseOfertaGenerico
{
    using Portal.Consultoras.Web.Models.Search.Response;
    using Portal.Consultoras.Web.Models.Search.ResponseOferta.Estructura;

    public class OutputOferta : ResponseStatus
    {
        public Estrategia Result { get; set; }
    }
}