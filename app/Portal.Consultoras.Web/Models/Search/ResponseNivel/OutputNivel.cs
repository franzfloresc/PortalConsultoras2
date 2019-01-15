namespace Portal.Consultoras.Web.Models.Search.ResponseNivel
{
    using Portal.Consultoras.Web.Models.Search.Response;
    using Portal.Consultoras.Web.Models.Search.ResponseNivel.Estructura;
    using System.Collections.Generic;

    public class OutputNivel : ResponseStatus
    {
        public IList<Nivel> Result { get; set; }
    }
}