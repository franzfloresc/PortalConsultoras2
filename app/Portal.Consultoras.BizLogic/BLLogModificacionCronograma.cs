using Portal.Consultoras.Data;
using Portal.Consultoras.Entities;
using System;
using System.Collections.Generic;
using System.Data;
using System.Text;
using System.Transactions;

namespace Portal.Consultoras.BizLogic
{
    public class BLLogModificacionCronograma
    {
        public IList<BELogModificacionCronograma> GetLogModificacionCronograma(int paisID)
        {
            var lista = new List<BELogModificacionCronograma>();
            var daLogModificacionCronograma = new DALogModificacionCronograma(paisID);

            using (IDataReader reader = daLogModificacionCronograma.GetLogModificacionCronograma(paisID))
                while (reader.Read())
                {
                    var entidad = new BELogModificacionCronograma(reader);
                    lista.Add(entidad);
                }

            return lista;
        }

        public void InsLogModificacionCronogramaMasivo(int paisID, string CodigoUsuario, List<BELogModificacionCronograma> listaEntidades)
        {
            TransactionOptions transactionOptions =
                new TransactionOptions { IsolationLevel = System.Transactions.IsolationLevel.ReadUncommitted };
            var daLogModificacionCronograma = new DALogModificacionCronograma(paisID);

            using (TransactionScope transaction = new TransactionScope(TransactionScopeOption.Required, transactionOptions))
            {
                foreach (var entidad in listaEntidades)
                {
                    daLogModificacionCronograma.InsLogModificacionCronograma(CodigoUsuario, entidad);
                }
                transaction.Complete();
            }
        }

        public void InsLogConfiguracionCronogramaMasivo(int paisID, string CodigoUsuario, List<BELogConfiguracionCronograma> listaEntidades)
        {
            TransactionOptions transactionOptions =
                new TransactionOptions { IsolationLevel = System.Transactions.IsolationLevel.ReadUncommitted };
            var daLogModificacionCronograma = new DALogModificacionCronograma(paisID);

            string xml = CrearLogCongiraucionCronogramaXxml(listaEntidades);

            using (TransactionScope transaction = new TransactionScope(TransactionScopeOption.Required, transactionOptions))
            {
                daLogModificacionCronograma.InsLogConfiguracionCronogarma(CodigoUsuario, xml);
                transaction.Complete();
            }
        }

        private string CrearLogCongiraucionCronogramaXxml(List<BELogConfiguracionCronograma> listaEntidades)
        {
            StringBuilder sb = new StringBuilder();

            foreach (BELogConfiguracionCronograma entidad in listaEntidades)
            {
                string xml = "<LogConfiguracionCronograma CodigoRegion='{0}' CodigoZona='{1}' DiasDuracionAnterior='{2}' DiasDuracionActual='{3}'/>";
                sb.Append(String.Format(xml, entidad.CodigoRegion, entidad.CodigoZona, entidad.DiasDuracionAnterior, entidad.DiasDuracionActual));
            }
            return String.Format("<ROOT>{0}</ROOT>", sb.ToString());
        }

    }
}
