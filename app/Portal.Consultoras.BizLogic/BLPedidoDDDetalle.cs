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
            IList<BEPedidoDDDetalle> listaBEPedidoDDDetalle = new List<BEPedidoDDDetalle>();
            DAPedidoDDDetalle daPedidoDDDetalle = new DAPedidoDDDetalle(paisID);

            using (IDataReader reader = daPedidoDDDetalle.GetPedidoDDDetalleByPedidoID(campaniaID, pedidoID))
                while (reader.Read())
                {
                    BEPedidoDDDetalle bePedidoDDDetalle = new BEPedidoDDDetalle(reader);
                    listaBEPedidoDDDetalle.Add(bePedidoDDDetalle);
                }

            return listaBEPedidoDDDetalle;
        }

        public void InsPedidoDetalleDD(int paisID, BEPedidoDDDetalle bePedidoDDDetalle)
        {
            DAPedidoDDDetalle daPedidoDDDetalle = new DAPedidoDDDetalle(paisID);

            daPedidoDDDetalle.InsPedidoDetalleDD(bePedidoDDDetalle);
        }

        public void UpdPedidoDetalleDD(int paisID, BEPedidoDDDetalle bePedidoDDDetalle)
        {
            DAPedidoDDDetalle daPedidoDDDetalle = new DAPedidoDDDetalle(paisID);

            daPedidoDDDetalle.UpdPedidoDetalleDD(bePedidoDDDetalle);
        }

        public void DelPedidoDetalleDD(int paisID, BEPedidoDDDetalle bePedidoDDDetalle)
        {
            DAPedidoDDDetalle daPedidoDDDetalle = new DAPedidoDDDetalle(paisID);

            daPedidoDDDetalle.DelPedidoDetalleDD(bePedidoDDDetalle);
        }
    }
}
