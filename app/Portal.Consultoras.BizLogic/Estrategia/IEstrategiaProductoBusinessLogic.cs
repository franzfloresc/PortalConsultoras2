using System.Collections.Generic;
using Portal.Consultoras.Entities;

namespace Portal.Consultoras.BizLogic
{
    public interface IEstrategiaProductoBusinessLogic
    {
        bool DeleteEstrategiaProducto(BEEstrategiaProducto entidad);
        List<BEEstrategiaProducto> GetEstrategiaProducto(BEEstrategia entidad);
        int InsertEstrategiaProducto(BEEstrategiaProducto entidad);
        int UpdateEstrategiaProducto(BEEstrategiaProducto entidad);
    }
}