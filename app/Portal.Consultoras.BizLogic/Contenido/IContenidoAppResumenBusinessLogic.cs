﻿using Portal.Consultoras.Entities;
using System.Collections.Generic;

namespace Portal.Consultoras.BizLogic.Contenido
{
    public interface IContenidoAppResumenBusinessLogic
    {
        List<BEContenidoApp> GetContenidoApp(BEUsuario itmFilter);
        void CheckContenidoApp(BEUsuario itmFilter, int idContenidoDetalle);
    }
}
