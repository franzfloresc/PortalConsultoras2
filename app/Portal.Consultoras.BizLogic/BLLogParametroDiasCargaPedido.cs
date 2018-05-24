using Portal.Consultoras.Data;
using Portal.Consultoras.Entities;
using System.Collections.Generic;
using System.Data;
using System.Transactions;

namespace Portal.Consultoras.BizLogic
{
    public class BLLogParametroDiasCargaPedido
    {
        public IList<BELogParametroDiasCargaPedido> GetLogParametroDiasCargaPedido(int paisID)
        {
            var lista = new List<BELogParametroDiasCargaPedido>();
            var daLogParametroDiasCargaPedido = new DALogParametroDiasCargaPedido(paisID);

            using (IDataReader reader = daLogParametroDiasCargaPedido.GetLogParametroDiasCargaPedido(paisID))
                while (reader.Read())
                {
                    var entidad = new BELogParametroDiasCargaPedido(reader);
                    lista.Add(entidad);
                }

            return lista;
        }

        public void InsLogParametroDiasCargaPedido(int paisID, string CodigoUsuario, List<BELogParametroDiasCargaPedido> listaEntidades)
        {
            TransactionOptions transactionOptions =
                new TransactionOptions { IsolationLevel = System.Transactions.IsolationLevel.ReadUncommitted };
            var daLogParametroDiasCargaPedido = new DALogParametroDiasCargaPedido(paisID);

            using (TransactionScope transaction = new TransactionScope(TransactionScopeOption.Required, transactionOptions))
            {
                foreach (var entidad in listaEntidades)
                {
                    daLogParametroDiasCargaPedido.InsLogParametroDiasCargaPedido(CodigoUsuario, entidad);
                }
                transaction.Complete();
            }
        }
    }
}
