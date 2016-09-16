using Portal.Consultoras.Common;
using Portal.Consultoras.Data;
using Portal.Consultoras.Entities;
using System;
using System.Collections.Generic;
using System.Text;
using System.Transactions;

namespace Portal.Consultoras.BizLogic
{
    public class BLPedidoRechazado
    {
        public int InsertarPedidoRechazadoXML(string paisISO, List<BEPedidoRechazado> listBEPedidoRechazado)
        {
            if (listBEPedidoRechazado == null || listBEPedidoRechazado.Count == 0) return 0;

            DAPedidoRechazado dAPedidoRechazado = null;
            try
            {
                int paisID = Util.GetPaisID(paisISO);
                if (paisID > 0) dAPedidoRechazado = new DAPedidoRechazado(paisID);
            }
            catch(Exception ex) { LogManager.SaveLog(ex, "", paisISO); }
            if (dAPedidoRechazado == null) return 0;
            
            try
            {
                string xml = CrearClienteXML(listBEPedidoRechazado);

                TransactionOptions transactionOptions = new TransactionOptions { IsolationLevel = IsolationLevel.RepeatableRead };
                using (TransactionScope transactionScope = new TransactionScope(TransactionScopeOption.Required, transactionOptions))
                {
                    dAPedidoRechazado.InsertarPedidoRechazadoXML("OK", string.Empty, xml);
                    transactionScope.Complete();
                }
                return 1;
            }
            catch (Exception ex) {
                try { dAPedidoRechazado.InsertarPedidoRechazadoXML("Error",  ex.Message + "(" + ex.StackTrace + ")", ""); }
                catch (Exception ex2)
                {
                    LogManager.SaveLog(ex, "", paisISO);
                    LogManager.SaveLog(ex2, "", paisISO);
                }                
            }
            return 0;
        }

        private string CrearClienteXML(List<BEPedidoRechazado> obj)
        {
            StringBuilder sb = new StringBuilder();

            foreach (BEPedidoRechazado lista in obj)
            {
                string campania = lista.Campania;
                string codigoConsultora = lista.CodigoConsultora;
                string motivoRechazo = lista.MotivoRechazo;
                string valor = lista.Valor;
                string xml = "<PedidoRechazado Campania='{0}' CodigoConsultora='{1}' MotivoRechazo='{2}' Valor='{3}'/>";
                sb.Append(String.Format(xml, campania, codigoConsultora, motivoRechazo, valor));
            }
            return String.Format("<ROOT>{0}</ROOT>", sb.ToString());
        }
    }
}
