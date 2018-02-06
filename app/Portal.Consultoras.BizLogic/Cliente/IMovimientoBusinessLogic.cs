using Portal.Consultoras.Entities;
using Portal.Consultoras.Entities.Cliente;
using Portal.Consultoras.Entities.Framework;
using System.Collections.Generic;

namespace Portal.Consultoras.BizLogic.Cliente
{
    public interface IMovimientoBusinessLogic
    {
        ResponseType<int> Insertar(int paisId, BEMovimiento movimiento);
        IEnumerable<BEMovimiento> Listar(int paisId, short clienteId, long consultoraId);
        ResponseType<BEMovimiento> Actualizar(int paisId, BEMovimiento movimiento);
        ResponseType<int> Eliminar(int paisId, long consultoraId, short clienteId, int movimientoId);
        ResponseType<List<BEMovimiento>> Procesar(int paisId, BEClienteDB clienteDb);
        ResponseType<List<BEMovimientoDetalle>> ActualizarDetalle(int paisId, List<BEMovimientoDetalle> movimientos);
    }
}