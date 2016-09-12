using Portal.Consultoras.Data;
using Portal.Consultoras.Entities;
using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

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

        public IList<BEMatrizComercial> GetImagenesByCUV(int paisID, int campaniaID, string cuv)
        {
            var lst = new List<BEMatrizComercial>();
            var dataAccess = new DAProductoSugerido(paisID);

            using (IDataReader reader = dataAccess.GetImagenesByCUV(campaniaID, cuv))
                while (reader.Read())
                {
                    var entity = new BEMatrizComercial(reader);
                    lst.Add(entity);
                }
            return lst;
        }

        public string InsProductoSugerido(int paisID, BEProductoSugerido entidad)
        {
            var dataAccess = new DAProductoSugerido(paisID);
            return dataAccess.InsProductoSugerido(entidad); ;
        }

        public string UpdProductoSugerido(int paisID, BEProductoSugerido entidad)
        {
            var dataAccess = new DAProductoSugerido(paisID);
            return dataAccess.UpdProductoSugerido(entidad); ;
        }

        public string DelProductoSugerido(int paisID, BEProductoSugerido entidad)
        {
            var dataAccess = new DAProductoSugerido(paisID);
            return dataAccess.DelProductoSugerido(entidad); ;
        }
    }
}
