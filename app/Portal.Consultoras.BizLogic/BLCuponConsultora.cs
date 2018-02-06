using Portal.Consultoras.Data;
using Portal.Consultoras.Entities.Cupon;
using System;
using System.Collections.Generic;
using System.Data;
using System.Text;
using System.Transactions;

namespace Portal.Consultoras.BizLogic
{
    public class BLCuponConsultora
    {
        public BECuponConsultora GetCuponConsultoraByCodigoConsultoraCampaniaId(int paisID, BECuponConsultora cuponConsultora)
        {
            BECuponConsultora entidad = null;
            var daCuponConsultora = new DACuponConsultora(paisID);

            using (IDataReader reader = daCuponConsultora.GetCuponConsultoraByCodigoConsultoraCampaniaId(cuponConsultora))
                if (reader.Read())
                {
                    entidad = new BECuponConsultora(reader);
                }
            return entidad;
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
            List<BECuponConsultora> listaCuponConsultoras = new List<BECuponConsultora>();
            var daCuponConsultora = new DACuponConsultora(paisId);

            using (IDataReader reader = daCuponConsultora.ListarCuponConsultorasPorCupon(paisId, cuponId))
            {
                while (reader.Read())
                {
                    listaCuponConsultoras.Add(new BECuponConsultora(reader));
                }
            }

            return listaCuponConsultoras;
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
