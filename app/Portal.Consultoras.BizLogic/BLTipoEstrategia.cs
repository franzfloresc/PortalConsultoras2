using Portal.Consultoras.Data;
using Portal.Consultoras.Entities;
using System.Collections.Generic;
using System.Data;

namespace Portal.Consultoras.BizLogic
{
    public class BLTipoEstrategia
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
            List<BETipoEstrategia> listaTipoEstrategias = new List<BETipoEstrategia>();

            var daTipoEstrategia = new DATipoEstrategia(entidad.PaisID);
            using (IDataReader reader = daTipoEstrategia.GetTipoEstrategia(entidad))
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
