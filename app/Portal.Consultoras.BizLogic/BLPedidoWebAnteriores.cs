using Portal.Consultoras.Data;
using Portal.Consultoras.Entities;
using System.Collections.Generic;
using System.Data;

namespace Portal.Consultoras.BizLogic
{
    public class BLPedidoWebAnteriores
    {
        public IList<BEPedidoWeb> GetPedidosWebAnterioresByConsultora(int paisID, long consultoraID)
        {
            var pedidoWeb = new List<BEPedidoWeb>();
            var daPedidoWeb = new DAPedidoWebAnteriores(paisID);

            using (IDataReader reader = daPedidoWeb.GetPedidosWebAnterioresByConsultora(consultoraID))
                while (reader.Read())
                {
                    var entidad = new BEPedidoWeb(reader) {PaisID = paisID};
                    pedidoWeb.Add(entidad);
                }

            return pedidoWeb;
        }

        public IList<BEPedidoWebDetalle> GetPedidoProductosByCampania(int paisID, int campaniaID, long consultoraID)
        {
            var pedidoWeb = new List<BEPedidoWebDetalle>();
            var daPedidoWeb = new DAPedidoWebAnteriores(paisID);

            using (IDataReader reader = daPedidoWeb.GetPedidoProductosByCampania(campaniaID, consultoraID))
                while (reader.Read())
                {
                    var entidad = new BEPedidoWebDetalle(reader) {PaisID = paisID};
                    pedidoWeb.Add(entidad);
                }

            return pedidoWeb;
        }
    }
}
