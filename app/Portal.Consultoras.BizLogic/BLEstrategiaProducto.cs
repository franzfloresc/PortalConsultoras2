using Portal.Consultoras.Data;
using Portal.Consultoras.Entities;
using System.Collections.Generic;
using System.Data;

namespace Portal.Consultoras.BizLogic
{
    public class BLEstrategiaProducto
    {
        public int InsertEstrategiaProducto(BEEstrategiaProducto entidad)
        {
                var da = new DAEstrategiaProducto(entidad.PaisID);
                int result = da.InsertEstrategiaProducto(entidad);
                return result;
        }

        public List<BEEstrategiaProducto> GetEstrategiaProducto(BEEstrategia entidad)
        {
            var lista = new List<BEEstrategiaProducto>();
            var da = new DAEstrategiaProducto(entidad.PaisID);

            using (IDataReader reader = da.GetEstrategiaProducto(entidad))
                while (reader.Read())
                {
                    var entidadR = new BEEstrategiaProducto(reader);
                    lista.Add(entidadR);
                }

            return lista;
        }
    }
}
