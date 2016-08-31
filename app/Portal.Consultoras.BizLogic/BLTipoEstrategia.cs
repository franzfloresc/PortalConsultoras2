using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Data;
using Portal.Consultoras.Entities;
using Portal.Consultoras.Data;

namespace Portal.Consultoras.BizLogic
{
    public class BLTipoEstrategia
    {
        public int InsertTipoEstrategia(BETipoEstrategia entidad)
        {
            try
            {
                var DATipoEstrategia = new DATipoEstrategia(entidad.PaisID);
                int result = DATipoEstrategia.Insert(entidad);
                return result;
            }
            catch (Exception) { throw; }
        }

        public int DeleteTipoEstrategia(BETipoEstrategia entidad)
        {
            try
            {
                var DATipoEstrategia = new DATipoEstrategia(entidad.PaisID);
                int result = DATipoEstrategia.Delete(entidad);
                return result;
            }
            catch (Exception) { throw; }
        }

        public List<BETipoEstrategia> GetTipoEstrategias(BETipoEstrategia entidad)
        {
            List<BETipoEstrategia> listaTipoEstrategias = new List<BETipoEstrategia>();

            var DATipoEstrategia = new DATipoEstrategia(entidad.PaisID);
            using (IDataReader reader = DATipoEstrategia.GetTipoEstrategia(entidad))
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
