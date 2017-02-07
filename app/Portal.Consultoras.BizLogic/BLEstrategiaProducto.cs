using Portal.Consultoras.Data;
using Portal.Consultoras.Entities;
using System;

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
    }
}
