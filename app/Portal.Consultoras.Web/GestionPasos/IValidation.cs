using CORP.BEL.Unete.UI.UB.Validaciones;

namespace CORP.BEL.Unete.UI.UB.GestionPasos
{
    public interface IValidation<in TModel>
    {
        ValidationResponse Validar(TModel model);
    }
}