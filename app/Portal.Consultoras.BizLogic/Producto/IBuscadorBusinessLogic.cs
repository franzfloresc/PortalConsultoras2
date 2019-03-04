using System.Collections.Generic;

using Portal.Consultoras.Entities.BuscadorYFiltros;
using Portal.Consultoras.Entities.Producto;

namespace Portal.Consultoras.BizLogic.Producto
{
    public interface IBuscadorBusinessLogic
    {
        List<BEBuscadorResponse> ObtenerBuscadorComplemento(int paisID, string codigoUsuario, bool suscripcionActiva, List<BEBuscadorResponse> lst, bool isApp);
        Dictionary<string, string> GetOrdenamientoFiltrosBuscador(int paisID);
        List<BEFiltroBuscador> GetFiltroBuscador(int paisID, int tablaLogicaDatosID);
    }
}