using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Data;
using Portal.Consultoras.Entities;
using Portal.Consultoras.Data;
using System.Transactions;

namespace Portal.Consultoras.BizLogic
{
    public class BLFeErratas
    {
        public IList<BEFeErratas> SelectFeErratas(int paisID, int campaniaID)
        {
            var lista = new List<BEFeErratas>();
            var DAFeErratas = new DAFeErratas(paisID);

            using (IDataReader reader = DAFeErratas.SelectFeErratas(paisID, campaniaID))
                while (reader.Read())
                {
                    var entidad = new BEFeErratas(reader);
                    lista.Add(entidad);
                }

            return lista;
        }
        
        public void InsertFeErratas(BEFeErratas entidad)
        {
            var DAFeErratas = new DAFeErratas(entidad.PaisID);
            DAFeErratas.Insert(entidad);
        }

        public void UpdateFeErratas(BEFeErratas entidad)
        {
            var DAFeErratas = new DAFeErratas(entidad.PaisID);
            DAFeErratas.Update(entidad);
        }

        public void DeleteFeErratas(int paisID, int feErratasID)
        {
            var DAFeErratas = new DAFeErratas(paisID);
            DAFeErratas.Delete(feErratasID);
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
            var DAFeErratas = new DAFeErratas(paisID);

            using (IDataReader reader = DAFeErratas.SelectFeErratasEntradas(paisID, campaniaID, titulo))
                while (reader.Read())
                {
                    var entidad = new BEFeErratas(reader);
                    lista.Add(entidad);
                }

            return lista;
        }
    }
}
