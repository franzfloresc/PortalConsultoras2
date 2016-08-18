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
    public class BLLogModificacionCronograma
    {
        public IList<BELogModificacionCronograma> GetLogModificacionCronograma(int paisID)
        {
            var lista = new List<BELogModificacionCronograma>();
            var DALogModificacionCronograma = new DALogModificacionCronograma(paisID);

            using (IDataReader reader = DALogModificacionCronograma.GetLogModificacionCronograma(paisID))
                while (reader.Read())
                {
                    var entidad = new BELogModificacionCronograma(reader);
                    lista.Add(entidad);
                }

            return lista;
        }

        public void InsLogModificacionCronogramaMasivo(int paisID, string CodigoUsuario, List<BELogModificacionCronograma> listaEntidades)
        {
            TransactionOptions transactionOptions = new TransactionOptions();
            transactionOptions.IsolationLevel = System.Transactions.IsolationLevel.ReadUncommitted;
            var DALogModificacionCronograma = new DALogModificacionCronograma(paisID);

            using (TransactionScope transaction = new TransactionScope(TransactionScopeOption.Required, transactionOptions))
            {
                foreach (var entidad in listaEntidades)
                {
                    DALogModificacionCronograma.InsLogModificacionCronograma(CodigoUsuario,entidad);
                }
                transaction.Complete();
            }
        }

    }
}
