using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Data;
using Portal.Consultoras.Entities;
using Portal.Consultoras.Data;

namespace Portal.Consultoras.BizLogic
{
    public class BLPedidoWebAnteriores
    {
        public IList<BEPedidoWeb> GetPedidosWebAnterioresByConsultora(int paisID, long consultoraID)
        {
            var pedidoWeb = new List<BEPedidoWeb>();
            var DAPedidoWeb = new DAPedidoWebAnteriores(paisID);

            using (IDataReader reader = DAPedidoWeb.GetPedidosWebAnterioresByConsultora(consultoraID))
                while (reader.Read())
                {
                    var entidad = new BEPedidoWeb(reader);
                    entidad.PaisID = paisID;
                    pedidoWeb.Add(entidad);
                }

            return pedidoWeb;
        }

        public IList<BEPedidoWebDetalle> GetPedidoProductosByCampania(int paisID, int campaniaID, long consultoraID)
        {
            var pedidoWeb = new List<BEPedidoWebDetalle>();
            var DAPedidoWeb = new DAPedidoWebAnteriores(paisID);

            using (IDataReader reader = DAPedidoWeb.GetPedidoProductosByCampania(campaniaID, consultoraID))
                while (reader.Read())
                {
                    var entidad = new BEPedidoWebDetalle(reader);
                    entidad.PaisID = paisID;
                    pedidoWeb.Add(entidad);
                }

            return pedidoWeb;
        }
    }
}
