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
    public class BLLogParametroDiasCargaPedido
    {
        public IList<BELogParametroDiasCargaPedido> GetLogParametroDiasCargaPedido(int paisID)
        {
            var lista = new List<BELogParametroDiasCargaPedido>();
            var DALogParametroDiasCargaPedido = new DALogParametroDiasCargaPedido(paisID);

            using (IDataReader reader = DALogParametroDiasCargaPedido.GetLogParametroDiasCargaPedido(paisID))
                while (reader.Read())
                {
                    var entidad = new BELogParametroDiasCargaPedido(reader);
                    lista.Add(entidad);
                }

            return lista;
        }

        public void InsLogParametroDiasCargaPedido(int paisID, string CodigoUsuario, List<BELogParametroDiasCargaPedido> listaEntidades)
        {
            TransactionOptions transactionOptions = new TransactionOptions();
            transactionOptions.IsolationLevel = System.Transactions.IsolationLevel.ReadUncommitted;
            var DALogParametroDiasCargaPedido = new DALogParametroDiasCargaPedido(paisID);

            using (TransactionScope transaction = new TransactionScope(TransactionScopeOption.Required, transactionOptions))
            {
                foreach (var entidad in listaEntidades)
                {
                    DALogParametroDiasCargaPedido.InsLogParametroDiasCargaPedido(CodigoUsuario, entidad);
                }
                transaction.Complete();
            }
        }
    }
}
