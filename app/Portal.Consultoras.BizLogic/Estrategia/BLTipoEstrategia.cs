using Portal.Consultoras.Data;
using Portal.Consultoras.Entities;

using System.Collections.Generic;

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
            var listaTipoEstrategias = new List<BETipoEstrategia>();

            var daTipoEstrategia = new DATipoEstrategia(entidad.PaisID);
            using (var reader = daTipoEstrategia.GetTipoEstrategia(entidad))
            {
                while (reader.Read())
                {
                    listaTipoEstrategias.Add(new BETipoEstrategia(reader));
                }
            }
            return listaTipoEstrategias;
        }
    }
}
