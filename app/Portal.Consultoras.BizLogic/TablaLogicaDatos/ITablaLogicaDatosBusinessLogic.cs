using System.Collections.Generic;

using Portal.Consultoras.Entities;

namespace Portal.Consultoras.BizLogic
{
    public interface ITablaLogicaDatosBusinessLogic
    {
        List<BETablaLogicaDatos> GetTablaLogicaDatos(int paisID, short TablaLogicaID);
    }
}