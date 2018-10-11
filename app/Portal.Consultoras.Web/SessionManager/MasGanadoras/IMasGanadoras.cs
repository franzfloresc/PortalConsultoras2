using Portal.Consultoras.Web.Models;

namespace Portal.Consultoras.Web.SessionManager.MasGanadoras
{
    public interface IMasGanadoras
    {
        MasGanadorasModel GetModel();
        void SetModel(MasGanadorasModel model);
    }
}
