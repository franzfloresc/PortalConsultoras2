using Portal.Consultoras.Data;
using Portal.Consultoras.Entities;
using System.Collections.Generic;
using System.Data;
using System.Transactions;

namespace Portal.Consultoras.BizLogic
{
    public class BLFeErratas
    {
        public IList<BEFeErratas> SelectFeErratas(int paisID, int campaniaID)
        {
            var lista = new List<BEFeErratas>();
            var daFeErratas = new DAFeErratas(paisID);

            using (IDataReader reader = daFeErratas.SelectFeErratas(paisID, campaniaID))
                while (reader.Read())
                {
                    var entidad = new BEFeErratas(reader);
                    lista.Add(entidad);
                }

            return lista;
        }

        public void InsertFeErratas(BEFeErratas entidad)
        {
            var daFeErratas = new DAFeErratas(entidad.PaisID);
            daFeErratas.Insert(entidad);
        }

        public void UpdateFeErratas(BEFeErratas entidad)
        {
            var daFeErratas = new DAFeErratas(entidad.PaisID);
            daFeErratas.Update(entidad);
        }

        public void DeleteFeErratas(int paisID, int feErratasID)
        {
            var daFeErratas = new DAFeErratas(paisID);
            daFeErratas.Delete(feErratasID);
        }

        public void SaveMultiple(int paisID, List<BEFeErratas> erratasUpdate, List<BEFeErratas> erratasDel)
        {
            using (var tran = new TransactionScope())
            {
                var daFeErratas = new DAFeErratas(paisID);
                foreach (var item in erratasDel)
                {
                    daFeErratas.Delete(item.FeErratasID);
                }
                foreach (var item in erratasUpdate)
                {
                    if (item.FeErratasID < 0)
                    {
                        daFeErratas.Insert(item);
                    }
                    else
                    {
                        daFeErratas.Update(item);
                    }
                }
                tran.Complete();
            }
        }

        public IList<BEFeErratas> SelectFeErratasEntradas(int paisID, int campaniaID, string titulo)
        {
            var lista = new List<BEFeErratas>();
            var daFeErratas = new DAFeErratas(paisID);

            using (IDataReader reader = daFeErratas.SelectFeErratasEntradas(paisID, campaniaID, titulo))
                while (reader.Read())
                {
                    var entidad = new BEFeErratas(reader);
                    lista.Add(entidad);
                }

            return lista;
        }
    }
}
