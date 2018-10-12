using System.Collections.Generic;
using Portal.Consultoras.Entities.Producto;

namespace Portal.Consultoras.BizLogic.Producto
{
    public interface IBuscadorBusinessLogic
    {
        List<BEBuscadorResponse> ObtenerBuscadorComplemento(int paisID, string codigoUsuario, bool suscripcionActiva, List<BEBuscadorResponse> lst, bool isApp);
    }
}