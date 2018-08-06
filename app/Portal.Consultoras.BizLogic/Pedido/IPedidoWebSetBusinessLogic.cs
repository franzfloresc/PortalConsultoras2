using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using Portal.Consultoras.Entities;
using Portal.Consultoras.Entities.Pedido;

namespace Portal.Consultoras.BizLogic.Pedido
{
    public interface IPedidoWebSetBusinessLogic
    {
        /// <summary>
        /// Obtiene el pedido web set y sus detalles por id
        /// </summary>
        /// <param name="paisId">Pais id</param>
        /// <param name="id">Set Id</param>
        /// <returns>PedidoSet object</returns>
        BEPedidoWebSet Obtener(int paisId,  int id);

        /// <summary>
        /// Elimina el Set por id, incluido sus detalles
        /// </summary>
        /// <param name="paisId">Pais Id</param>
        /// <param name="id">Set Id</param>
        /// <returns>True si elimino, false caso contrario</returns>
        bool Eliminar(int paisId, int id, BEPedidoWebDetalleParametros bePedidoWebDetalleParametros);

        DateTime? ObtenerFechaInicioSets(int paisId);
    }
}
