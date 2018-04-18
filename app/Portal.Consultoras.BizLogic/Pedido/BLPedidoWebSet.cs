using Portal.Consultoras.Data.Pedido;
using Portal.Consultoras.Entities.Pedido;
using System;

namespace Portal.Consultoras.BizLogic.Pedido
{
    public class BLPedidoWebSet : IPedidoWebSetBusinessLogic
    {
        public BEPedidoWebSet Obtener(int paisId, int id)
        {
            var da = new DAPedidoWebSet(paisId);
            var set = da.Obtener(id);

            if (set != null)
                set.Detalles = da.ObtenerDetalles(id);

            return set;
        }

        public bool Eliminar(int paisId, int id)
        {
            var da = new DAPedidoWebSet(paisId);
            var result = da.Eliminar(id);

            return result > 0;
        }

        public DateTime? ObtenerFechaInicioSets(int paisId)
        {
            DateTime? response = null;
            var da = new DAPedidoWebSet(paisId);
            response = da.ObtenerFechaInicioSets();

            return response;
        }
    }
}
