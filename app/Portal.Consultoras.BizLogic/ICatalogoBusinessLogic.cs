using Portal.Consultoras.Common;
using Portal.Consultoras.Entities;
using System.Collections.Generic;
using System.Threading.Tasks;

namespace Portal.Consultoras.BizLogic
{
    public interface ICatalogoBusinessLogic
    {
        IList<BECatalogo> GetCatalogosByCampania(int paisID, int campaniaID);
        IList<BECatalogoConfiguracion> GetCatalogoConfiguracion(int paisID);
        List<BECatalogoRevista> GetListCatalogoRevistaPublicado(string paisISO, string codigoZona, int campania, Enumeradores.TamanioImagenIssu tamanioImagenIssu);
        List<BECatalogoRevista> GetCatalogoRevista(string paisISO, string codigoZona, List<int> campanias);

        List<BECatalogoRevista_ODS> SelectCatalogoRevistas_ODS(int paisID);
        List<BECatalogoRevista_ODS> PS_CatalogoRevistas_ODS(int paisID);
    }
}