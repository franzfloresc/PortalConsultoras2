using Portal.Consultoras.Data;
using Portal.Consultoras.Entities;
using Portal.Consultoras.Common;

using System.Collections.Generic;
using System.Linq;

namespace Portal.Consultoras.BizLogic
{
    public class BLTipoEstrategia : ITipoEstrategiaBusinessLogic
    {
        public int InsertTipoEstrategia(BETipoEstrategia entidad)
        {
            var daTipoEstrategia = new DATipoEstrategia(entidad.PaisID);
            int result = daTipoEstrategia.Insert(entidad);
            return result;
        }

        public int DeleteTipoEstrategia(BETipoEstrategia entidad)
        {
            var daTipoEstrategia = new DATipoEstrategia(entidad.PaisID);
            int result = daTipoEstrategia.Delete(entidad);
            return result;
        }

        public List<BETipoEstrategia> GetTipoEstrategias(BETipoEstrategia entidad)
        {
            using (var reader = new DATipoEstrategia(entidad.PaisID).GetTipoEstrategia(entidad))
            {
                return reader.MapToCollection<BETipoEstrategia>();
            }
        }

        public BETipoEstrategia GetTipoEstrategiaById(int paisId, int tipoEntidadId)
        {
            if (tipoEntidadId > 0)
            {
                var tipoEstrategia = new BETipoEstrategia
                {
                    TipoEstrategiaID = tipoEntidadId,
                    PaisID = paisId
                };
                var lista = GetTipoEstrategias(tipoEstrategia);
                return lista.FirstOrDefault() ?? new BETipoEstrategia();
            }
            return new BETipoEstrategia();
        }
    }
}
