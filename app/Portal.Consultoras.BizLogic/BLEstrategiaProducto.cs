using Portal.Consultoras.Data;
using Portal.Consultoras.Entities;
using System;
using System.Collections.Generic;
using System.Data;

namespace Portal.Consultoras.BizLogic
{
    public class BLEstrategiaProducto
    {
        public int InsertEstrategiaProducto(BEEstrategiaProducto entidad)
        {
            try
            {
                var DA = new DAEstrategiaProducto(entidad.PaisID);
                int result = DA.InsertEstrategiaProducto(entidad);
                return result;
            }
            catch (Exception) { throw; }
        }

        public int UpdateEstrategiaProducto(BEEstrategiaProducto entidad)
        {
            try
            {
                var DA = new DAEstrategiaProducto(entidad.PaisID);
                int result = DA.UpdateEstrategiaProducto(entidad);
                return result;
            }
            catch (Exception) { throw; }
        }

        public List<BEEstrategiaProducto> GetEstrategiaProducto(BEEstrategia entidad)
        {
            var lista = new List<BEEstrategiaProducto>();
            var DA = new DAEstrategiaProducto(entidad.PaisID);

            using (IDataReader reader = DA.GetEstrategiaProducto(entidad))
                while (reader.Read())
                {
                    var entidadR = new BEEstrategiaProducto(reader);
                    lista.Add(entidadR);
                }

            return lista;
        }

        public bool DeleteEstrategiaProducto(BEEstrategiaProducto entidad)
        {
            var DA = new DAEstrategiaProducto(entidad.PaisID);

            var result = DA.DeleteEstrategiaProducto(entidad);
            return result;
        }
    }
}
