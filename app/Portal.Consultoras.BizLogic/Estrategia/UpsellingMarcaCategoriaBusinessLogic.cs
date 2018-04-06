using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using Portal.Consultoras.Data.Estrategia;
using Portal.Consultoras.Entities.Estrategia;

namespace Portal.Consultoras.BizLogic.Estrategia
{
    public class UpsellingMarcaCategoriaBusinessLogic : IUpSellingMarcaCategoriaBusinessLogic
    {

        private readonly UpSellingMarcaCategoriaDataAccess _upSellingMarcaCategoriaDataAccess;

        public UpsellingMarcaCategoriaBusinessLogic(int paisId)
        {
            _upSellingMarcaCategoriaDataAccess = new UpSellingMarcaCategoriaDataAccess(paisId);
        }


        public IEnumerable<UpsellingMarcaCategoria> UpsellingMarcaCategoriaObtener(int upSellingId, string MarcaID, string CategoriaID)
        {
            IEnumerable<UpsellingMarcaCategoria> result;

            result = _upSellingMarcaCategoriaDataAccess.UpsellingMarcaCategoriaObtener(upSellingId, MarcaID, CategoriaID);

            return result;

        }

        public UpsellingMarcaCategoria UpsellingMarcaCategoriaInsertar(int upSellingId, string MarcaID, string CategoriaID)
        {

            UpsellingMarcaCategoria result = null;

            var registroExistente = UpsellingMarcaCategoriaObtener(upSellingId, MarcaID, CategoriaID);
            if (!registroExistente.Any())
            {
                result = _upSellingMarcaCategoriaDataAccess.UpsellingMarcaCategoriaInsertar(upSellingId, MarcaID, CategoriaID);
            }
            return result;
        }


        public bool UpsellingMarcaCategoriaEliminar(int upSellingId, string MarcaID, string CategoriaID)
        {
            bool result = false;
            result = _upSellingMarcaCategoriaDataAccess.UpsellingMarcaCategoriaEliminar(upSellingId, MarcaID, CategoriaID);
            return result;
        }

        public bool UpsellingMarcaCategoriaFlagsEditar(int upSellingId, bool CategoriaApoyada, bool CategoriaMonto)
        {
            bool result = false;
            result = _upSellingMarcaCategoriaDataAccess.UpsellingMarcaCategoriaFlagsEditar(upSellingId, CategoriaApoyada, CategoriaMonto);
            return result;
        }
         
    }
}
