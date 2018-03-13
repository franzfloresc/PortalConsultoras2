using Portal.Consultoras.Data;
using Portal.Consultoras.Entities.Cupon;
using Portal.Consultoras.Common;

using System;
using System.Collections.Generic;
using System.Data;
using System.Text;
using System.Transactions;

namespace Portal.Consultoras.BizLogic
{
    public class BLCuponConsultora : ICuponConsultoraBusinessLogic
    {
        public BECuponConsultora GetCuponConsultoraByCodigoConsultoraCampaniaId(int paisID, BECuponConsultora cuponConsultora)
        {
            using (IDataReader reader = new DACuponConsultora(paisID).GetCuponConsultoraByCodigoConsultoraCampaniaId(cuponConsultora))
            {
                return reader.MapToObject<BECuponConsultora>(true);
            }
        }

        public void UpdateCuponConsultoraEstadoCupon(int paisId, BECuponConsultora cuponConsultora)
        {
            var daCuponConsultora = new DACuponConsultora(paisId);
            daCuponConsultora.UpdateCuponConsultoraEstadoCupon(cuponConsultora);
        }

        public void UpdateCuponConsultoraEnvioCorreo(int paisId, BECuponConsultora cuponConsultora)
        {
            var daCuponConsultora = new DACuponConsultora(paisId);
            daCuponConsultora.UpdateCuponConsultoraEnvioCorreo(cuponConsultora);
        }

        public void CrearCuponConsultora(int paisId, BECuponConsultora cuponConsultora)
        {
            var daCuponConsultora = new DACuponConsultora(paisId);
            daCuponConsultora.CrearCuponConsultora(cuponConsultora);
        }

        public void ActualizarCuponConsultora(int paisId, BECuponConsultora cuponConsultora)
        {
            var daCuponConsultora = new DACuponConsultora(paisId);
            daCuponConsultora.ActualizarCuponConsultora(cuponConsultora);
        }

        public List<BECuponConsultora> ListarCuponConsultorasPorCupon(int paisId, int cuponId)
        {
            using (IDataReader reader = new DACuponConsultora(paisId).ListarCuponConsultorasPorCupon(paisId, cuponId))
            {
                return reader.MapToCollection<BECuponConsultora>();
            }
        }

        public void InsertarCuponConsultorasXML(int paisId, int cuponId, int campaniaId, List<BECuponConsultora> listaCuponConsultoras)
        {
            string xml = CrearClienteXML(listaCuponConsultoras);

            TransactionOptions transactionOptions = new TransactionOptions { IsolationLevel = System.Transactions.IsolationLevel.RepeatableRead };
            using (TransactionScope transactionScope = new TransactionScope(TransactionScopeOption.Required, transactionOptions))
            {
                var daCuponConsultora = new DACuponConsultora(paisId);

                daCuponConsultora.InsertarCuponConsultorasXML(cuponId, campaniaId, xml);
                transactionScope.Complete();
            }
        }

        private string CrearClienteXML(List<BECuponConsultora> listaCuponConsultoras)
        {
            StringBuilder sb = new StringBuilder();
            if (listaCuponConsultoras == null || listaCuponConsultoras.Count == 0) return "";

            foreach (BECuponConsultora cuponConsultora in listaCuponConsultoras)
            {
                string xml = "<CuponConsultora CodigoConsultora='{0}' ValorAsociado='{1}'/>";
                sb.Append(String.Format(xml, cuponConsultora.CodigoConsultora, cuponConsultora.ValorAsociado));
            }
            return String.Format("<ROOT>{0}</ROOT>", sb.ToString());
        }
    }
}
