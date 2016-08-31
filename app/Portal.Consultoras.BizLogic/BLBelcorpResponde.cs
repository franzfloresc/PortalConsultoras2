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
    public class BLBelcorpResponde
    {
        public IList<BEBelcorpResponde> GetBelcorpResponde(int paisID)
        {
            IList<BEBelcorpResponde> lista = (IList<BEBelcorpResponde>)CacheManager<BEBelcorpResponde>.GetData(paisID, ECacheItem.BelcorpResponde);
            if (lista == null)
            {
                lista = new List<BEBelcorpResponde>();
                var DABelcorpResponde = new DABelcorpResponde();

                using (IDataReader reader = DABelcorpResponde.GetBelcorpResponde(paisID))
                    while (reader.Read())
                    {
                        var entidad = new BEBelcorpResponde(reader);
                        lista.Add(entidad);
                    }
                CacheManager<BEBelcorpResponde>.AddData(paisID, ECacheItem.BelcorpResponde, lista);
            }
            return lista;
        }

        public IList<BEBelcorpResponde> GetBelcorpRespondeAdministrador(int paisID)
        {
            var lista = new List<BEBelcorpResponde>();
            var DABelcorpResponde = new DABelcorpResponde();

            using (IDataReader reader = DABelcorpResponde.GetBelcorpResponde(paisID))
                while (reader.Read())
                {
                    var entidad = new BEBelcorpResponde(reader);
                    lista.Add(entidad);
                }

            return lista;
        }

        public void InsBelcorpResponde(BEBelcorpResponde BEBelcorpResponde)
        {
            var DABelcorpResponde = new DABelcorpResponde();
            DABelcorpResponde.InsBelcorpResponde(BEBelcorpResponde);

            CacheManager<BEBelcorpResponde>.RemoveData(BEBelcorpResponde.PaisID, ECacheItem.BelcorpResponde);
        }

        public void DeleteBelcorpRespondeCache(int paisID)
        {
            CacheManager<BEBelcorpResponde>.RemoveData(paisID, ECacheItem.BelcorpResponde);
        }
    }
}
