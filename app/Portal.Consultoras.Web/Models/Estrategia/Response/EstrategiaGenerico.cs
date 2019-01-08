namespace Portal.Consultoras.Web.Models.Estrategia.Response
{
    using System.Collections.Generic;

    public class EstrategiaGenerico
    {
        public IList<Result> Result { get; set; }
        public string Message { get; set; }
        public bool Success { get; set; }
    }
}