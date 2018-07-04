﻿using System.Collections.Generic;
using System.Data;
using Portal.Consultoras.Entities;

namespace Portal.Consultoras.BizLogic
{
    public interface IConsultoraLiderBusinessLogic
    {
        IList<string> GetLiderCampaniaActual(int paisID, long ConsultoraID, string CodigoPais);
        IList<string> GetProyectaNivel(int paisID, long ConsultoraID);
        DataSet ObtenerParametrosSuperateLider(int paisID, long ConsultoraID, int CampaniaVenta);
        BEParametrosLider ObtenerParametrosConsultoraLider(int PaisID, long ConsultoraID, int CampaniaVenta);

    }
}