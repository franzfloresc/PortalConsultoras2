namespace Portal.Consultoras.BizLogic
{
    using Data;
    using Entities;
    using System;
    using System.Collections.Generic;
    using System.Data;

    public class BLLogPedidoDDInvalido
    {
        public bool InsLogPedidoDDInvalido(int paisID, BELogPedidoDDInvalido beLogPedidoDDInvalido)
        {
            try
            {
                DALogPedidoDDInvalido daLogPedidoDdInvalido = new DALogPedidoDDInvalido(paisID);

                daLogPedidoDdInvalido.InsLogPedidoDDInvalido(beLogPedidoDDInvalido);

                return true;
            }
            catch (Exception)
            {
                return false;
            }
        }

        public IList<BELogPedidoDDInvalido> SelectLogPedidosInvalidos(int paisID, DateTime fechaRegistro)
        {
            DALogPedidoDDInvalido daLogPedidoDdInvalido = new DALogPedidoDDInvalido(paisID);
            IList<BELogPedidoDDInvalido> listBeLogPedidoDdInvalido = new List<BELogPedidoDDInvalido>();

            using (IDataReader reader = daLogPedidoDdInvalido.SelectLogPedidosInvalidos(fechaRegistro))
                while (reader.Read())
                {
                    var logPedidoInvalido = new BELogPedidoDDInvalido(reader);
                    listBeLogPedidoDdInvalido.Add(logPedidoInvalido);
                }

            return listBeLogPedidoDdInvalido;
        }

        public void UpdLogPedidoInvalido(int paisID, DateTime fechaRegistro)
        {
            DALogPedidoDDInvalido daLogPedidoDdInvalido = new DALogPedidoDDInvalido(paisID);
            daLogPedidoDdInvalido.UpdLogPedidoInvalido(fechaRegistro);
        }
    }
}
