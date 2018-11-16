using Portal.Consultoras.Entities;
using System.Collections.Generic;

namespace Portal.Consultoras.BizLogic
{
    public interface ITablaLogicaDatosBusinessLogic
    {
        List<BETablaLogicaDatos> GetList(int paisID, short tablaLogicaID);
        List<BETablaLogicaDatos> GetListCache(int paisID, short tablaLogicaID);
    }
}