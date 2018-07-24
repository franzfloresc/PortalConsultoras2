using Portal.Consultoras.Data;
using Portal.Consultoras.Entities;
using System;
using System.Collections.Generic;
using System.Data;

namespace Portal.Consultoras.BizLogic
{
    public class BLEstrategiaProducto : IEstrategiaProductoBusinessLogic
    {
        public int InsertEstrategiaProducto(BEEstrategiaProducto entidad)
        {
            var da = new DAEstrategiaProducto(entidad.PaisID);
            int result = da.InsertEstrategiaProducto(entidad);
            return result;
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
            var da = new DAEstrategiaProducto(entidad.PaisID);

            using (IDataReader reader = da.GetEstrategiaProducto(entidad))
                while (reader.Read())
                {
                    var entidadR = new BEEstrategiaProducto(reader);
                    lista.Add(entidadR);
                }

            return lista;
        }

        public List<BEEstrategiaProducto> GetEstrategiaProductoList(int PaisID,string idList)
        {
            var lista = new List<BEEstrategiaProducto>();
            var da = new DAEstrategiaProducto(PaisID);

            using (IDataReader reader = da.GetEstrategiaProductoList(idList))
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
