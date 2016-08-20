using System.Collections.Generic;

namespace Portal.Consultoras.Web.GestionPasos
{
    public interface IEjecucionAsync< TModel, TResponse> : IEjecucion<TModel, TResponse>
    {
        IEnumerable<IEjecucion<TModel, TResponse>> OperacionesSiguientes { get; set; }
    }
}