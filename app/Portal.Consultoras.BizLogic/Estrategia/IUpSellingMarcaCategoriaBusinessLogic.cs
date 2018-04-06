using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using Portal.Consultoras.Entities.Estrategia;

namespace Portal.Consultoras.BizLogic.Estrategia
{
    public interface IUpSellingMarcaCategoriaBusinessLogic
    {
        IEnumerable<UpsellingMarcaCategoria> UpsellingMarcaCategoriaObtener(int upSellingId, string MarcaID, string CategoriaID);

        UpsellingMarcaCategoria UpsellingMarcaCategoriaInsertar(int upSellingId, string MarcaID, string CategoriaID);

        bool UpsellingMarcaCategoriaEliminar(int upSellingId, string MarcaID, string CategoriaID);

        bool UpsellingMarcaCategoriaFlagsEditar(int upSellingId, bool CategoriaApoyada, bool CategoriaMonto);
    }
}
