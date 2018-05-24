using Portal.Consultoras.Entities;
using System.Collections.Generic;

namespace Portal.Consultoras.BizLogic
{
    public interface ITablaLogicaDatosBusinessLogic
    {
        List<BETablaLogicaDatos> GetTablaLogicaDatos(int paisID, short tablaLogicaID);
        List<BETablaLogicaDatos> GetTablaLogicaDatosCache(int paisID, short tablaLogicaID);
    }
}