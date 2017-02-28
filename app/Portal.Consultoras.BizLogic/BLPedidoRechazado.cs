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
        public int InsertarPedidoRechazadoXML(string paisISO, List<BEPedidoRechazadoSicc> listBEPedidoRechazado)
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

        public void UpdatePedidoRechazadoVisualizado(int paisID, long logGPRValidacionId)
        {
            DAPedidoRechazado dAPedidoRechazado = new DAPedidoRechazado(paisID);
            dAPedidoRechazado.UpdatePedidoRechazadoVisualizado(logGPRValidacionId);
        }

        public List<BELogGPRValidacion> GetBELogGPRValidacionByGetLogGPRValidacionId(int paisID, long logGPRValidacionId, long ConsultoraID)
        {
            DALogGPRValidacion dALogGPRValidacion = new DALogGPRValidacion(paisID);
            return dALogGPRValidacion.GetByLogGPRValidacionId(logGPRValidacionId, ConsultoraID);
        }

        public List<BELogGPRValidacionDetalle> GetListBELogGPRValidacionDetalleBELogGPRValidacionByLogGPRValidacionId(int paisID, long logGPRValidacionId)
        {
            DALogGPRValidacionDetalle dALogGPRValidacionDetalle = new DALogGPRValidacionDetalle(paisID);
            return dALogGPRValidacionDetalle.GetListByLogGPRValidacionId(logGPRValidacionId);
        }

        #region Private Functions

        private string CrearClienteXML(List<BEPedidoRechazadoSicc> listPedidoRechazadoSicc)
        {
            StringBuilder sb = new StringBuilder();

            foreach (BEPedidoRechazadoSicc pedidoRechazadoSicc in listPedidoRechazadoSicc)
            {
                string campania = pedidoRechazadoSicc.Campania;
                string codigoConsultora = pedidoRechazadoSicc.CodigoConsultora;
                string motivoRechazo = pedidoRechazadoSicc.MotivoRechazo;
                string valor = pedidoRechazadoSicc.Valor;
                string xml = "<PedidoRechazado Campania='{0}' CodigoConsultora='{1}' MotivoRechazo='{2}' Valor='{3}'/>";
                sb.Append(String.Format(xml, campania, codigoConsultora, motivoRechazo, valor));
            }
            return String.Format("<ROOT>{0}</ROOT>", sb.ToString());
        }

        #endregion
    }
}
