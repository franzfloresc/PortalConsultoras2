using CORP.BEL.Unete.UI.UB.Validaciones;

namespace Portal.Consultoras.Web.GestionPasos
{
    public interface IEjecucion<in TModel, in TResponse>
    {
        ValidationResponse Ejecutar(TModel model, TResponse entidad);
    }
}