using Portal.Consultoras.Data.CDR;
using System.Transactions;

namespace Portal.Consultoras.BizLogic.CDR
{
    public class BLLogCDRWebCulminado
    {
        public void CreateLogCDRWebCulminadoFromCDRWeb(int paisId, int cDRWebId)
        {
            TransactionOptions transactionOptions = new TransactionOptions();
            transactionOptions.IsolationLevel = IsolationLevel.ReadCommitted;
            var dALogCDRWebCulminado = new DALogCDRWebCulminado(paisId);

            using (TransactionScope transaction = new TransactionScope(TransactionScopeOption.Required, transactionOptions))
            {
                dALogCDRWebCulminado.CreateLogCDRWebCulminadoFromCDRWeb(cDRWebId);
                transaction.Complete();
            }
        }
    }
}
