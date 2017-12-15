﻿using System.Collections.Generic;
using System.Threading.Tasks;
using Portal.Consultoras.Common;
using Portal.Consultoras.Entities;

namespace Portal.Consultoras.BizLogic
{
    public interface ICatalogoBusinessLogic
    {
        IList<BECatalogo> GetCatalogosByCampania(int paisID, int campaniaID);
        IList<BECatalogoConfiguracion> GetCatalogoConfiguracion(int paisID);
        List<BECatalogoRevista> GetListCatalogoRevistaPublicado(string paisISO, string codigoZona, int campania, Enumeradores.TamanioImagenIssu tamanioImagenIssu);
        Task<List<BECatalogoRevista>> GetCatalogoRevista(string paisISO, string codigoZona, IEnumerable<int> campanias);
    }
}