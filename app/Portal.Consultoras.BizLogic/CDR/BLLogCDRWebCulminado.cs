using Portal.Consultoras.Data.CDR;
using Portal.Consultoras.Entities.CDR;
using System.Transactions;

namespace Portal.Consultoras.BizLogic.CDR
{
    public class BLLogCDRWebCulminado
    {
        public void CreateLogCDRWebCulminadoFromCDRWeb(int paisId, int cDRWebId)
        {
            TransactionOptions transactionOptions = new TransactionOptions
            {
                IsolationLevel = IsolationLevel.ReadCommitted
            };
            var daLogCdrWebCulminado = new DALogCDRWebCulminado(paisId);

            using (TransactionScope transaction = new TransactionScope(TransactionScopeOption.Required, transactionOptions))
            {
                daLogCdrWebCulminado.CreateLogCDRWebCulminadoFromCDRWeb(cDRWebId);
                transaction.Complete();
            }
        }

        public int UpdateVisualizado(int paisId, long logCDRWebCulminadoId)
        {
            return new DALogCDRWebCulminado(paisId).UpdateVisualizado(logCDRWebCulminadoId);
        }

        public BECDRWeb GetByLogCDRWebCulminadoId(int paisId, long logCDRWebCulminadoId)
        {
            return new DALogCDRWebCulminado(paisId).GetByLogCDRWebCulminadoId(logCDRWebCulminadoId);
        }
    }
}