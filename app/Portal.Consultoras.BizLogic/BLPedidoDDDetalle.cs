namespace Portal.Consultoras.BizLogic
{
    using Data;
    using Entities;
    using System.Collections.Generic;
    using System.Data;

    public class BLPedidoDDDetalle
    {
        public IList<BEPedidoDDDetalle> GetPedidoDDDetalleByPedidoID(int paisID, int campaniaID, int pedidoID)
        {
            IList<BEPedidoDDDetalle> listaBePedidoDdDetalle = new List<BEPedidoDDDetalle>();
            DAPedidoDDDetalle daPedidoDdDetalle = new DAPedidoDDDetalle(paisID);

            using (IDataReader reader = daPedidoDdDetalle.GetPedidoDDDetalleByPedidoID(campaniaID, pedidoID))
                while (reader.Read())
                {
                    BEPedidoDDDetalle bePedidoDdDetalle = new BEPedidoDDDetalle(reader);
                    listaBePedidoDdDetalle.Add(bePedidoDdDetalle);
                }

            return listaBePedidoDdDetalle;
        }

        public void InsPedidoDetalleDD(int paisID, BEPedidoDDDetalle bePedidoDDDetalle)
        {
            DAPedidoDDDetalle daPedidoDdDetalle = new DAPedidoDDDetalle(paisID);

            daPedidoDdDetalle.InsPedidoDetalleDD(bePedidoDDDetalle);
        }

        public void UpdPedidoDetalleDD(int paisID, BEPedidoDDDetalle bePedidoDDDetalle)
        {
            DAPedidoDDDetalle daPedidoDdDetalle = new DAPedidoDDDetalle(paisID);

            daPedidoDdDetalle.UpdPedidoDetalleDD(bePedidoDDDetalle);
        }

        public void DelPedidoDetalleDD(int paisID, BEPedidoDDDetalle bePedidoDDDetalle)
        {
            DAPedidoDDDetalle daPedidoDdDetalle = new DAPedidoDDDetalle(paisID);

            daPedidoDdDetalle.DelPedidoDetalleDD(bePedidoDDDetalle);
        }
    }
}
