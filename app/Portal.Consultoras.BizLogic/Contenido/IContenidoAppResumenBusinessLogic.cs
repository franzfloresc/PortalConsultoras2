using Portal.Consultoras.Entities;
using System.Collections.Generic;

namespace Portal.Consultoras.BizLogic.Contenido
{
    public interface IContenidoAppResumenBusinessLogic
    {
        List<BEContenidoAppResumen> GetContenidoApp(BEUsuario itmFilter);
    }
}
