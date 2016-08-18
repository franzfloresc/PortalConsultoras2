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
                DALogPedidoDDInvalido daLogPedidoDDInvalido = new DALogPedidoDDInvalido(paisID);

                daLogPedidoDDInvalido.InsLogPedidoDDInvalido(beLogPedidoDDInvalido);

                return true;
            }
            catch (Exception)
            {
                return false;
            }
        }

        public IList<BELogPedidoDDInvalido> SelectLogPedidosInvalidos(int paisID, DateTime fechaRegistro)
        {
            DALogPedidoDDInvalido daLogPedidoDDInvalido = new DALogPedidoDDInvalido(paisID);
            IList<BELogPedidoDDInvalido> listBELogPedidoDDInvalido = new List<BELogPedidoDDInvalido>();

            using (IDataReader reader = daLogPedidoDDInvalido.SelectLogPedidosInvalidos(fechaRegistro))
                while (reader.Read())
                {
                    var logPedidoInvalido = new BELogPedidoDDInvalido(reader);
                    listBELogPedidoDDInvalido.Add(logPedidoInvalido);
                }

            return listBELogPedidoDDInvalido;
        }

        public void UpdLogPedidoInvalido(int paisID, DateTime fechaRegistro)
        {
            DALogPedidoDDInvalido daLogPedidoDDInvalido = new DALogPedidoDDInvalido(paisID);
            daLogPedidoDDInvalido.UpdLogPedidoInvalido(fechaRegistro);
        }
    }
}
