using Portal.Consultoras.Data;
using Portal.Consultoras.Entities;
using System.Collections.Generic;
using System.Data;

namespace Portal.Consultoras.BizLogic
{
    public class BLProductoSugerido
    {
        public IList<BEProductoSugerido> GetPaginateProductoSugerido(int paisID, int campaniaID, string cuvAgotado, string cuvSugerido)
        {
            var lst = new List<BEProductoSugerido>();
            var dataAccess = new DAProductoSugerido(paisID);

            using (IDataReader reader = dataAccess.GetPaginateProductoSugerido(campaniaID, cuvAgotado, cuvSugerido))
                while (reader.Read())
                {
                    var entity = new BEProductoSugerido(reader);
                    lst.Add(entity);
                }
            return lst;
        }

        public BEMatrizComercial GetMatrizComercialByCampaniaAndCUV(int paisID, int campaniaID, string cuv)
        {
            BEMatrizComercial entity = null;
            var dataAccess = new DAOfertaProducto(paisID);

            using (IDataReader reader = dataAccess.GetMatrizComercialByCampaniaAndCUV(campaniaID, cuv))
                while (reader.Read())
                {
                    entity = new BEMatrizComercial(reader);
                }
            return entity;
        }

        public string InsProductoSugerido(int paisID, BEProductoSugerido entidad)
        {
            var dataAccess = new DAProductoSugerido(paisID);
            return dataAccess.InsProductoSugerido(entidad);
        }

        public string UpdProductoSugerido(int paisID, BEProductoSugerido entidad)
        {
            var dataAccess = new DAProductoSugerido(paisID);
            return dataAccess.UpdProductoSugerido(entidad);
        }

        public string DelProductoSugerido(int paisID, BEProductoSugerido entidad)
        {
            var dataAccess = new DAProductoSugerido(paisID);
            return dataAccess.DelProductoSugerido(entidad);
        }

        public void InsDemandaTotalReemplazoSugerido(int paisID, BEProductoSugerido entidad)
        {
            var dataAccess = new DAProductoSugerido(paisID);
            dataAccess.InsDemandaTotalReemplazoSugerido(entidad);
        }
    }
}
