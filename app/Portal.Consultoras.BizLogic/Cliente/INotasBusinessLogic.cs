using System.Collections.Generic;
using Portal.Consultoras.Entities;
using Portal.Consultoras.Entities.Cliente;
using Portal.Consultoras.Entities.Framework;

namespace Portal.Consultoras.BizLogic.Cliente
{
    public interface INotasBusinessLogic
    {
        ResponseType<long> Insertar(int paisId, BENota nota);
        ResponseType<List<BENota>> Listar(int paisId, long consultoraId);
        ResponseType<bool> Actualizar(int paisId, BENota nota);
        ResponseType<bool> Eliminar(int paisId, short clienteId, long consultoraId, long clienteNotaId);
        ResponseType<List<BENota>> Procesar(int paisId, BEClienteDB clienteDb);
        ResponseType<bool> PuedeAgregarMasNotas(int paisId, long consultoraId, short clienteId);
    }
}