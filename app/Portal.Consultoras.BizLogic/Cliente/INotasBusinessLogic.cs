using System.Collections.Generic;
using Portal.Consultoras.Entities;
using Portal.Consultoras.Entities.Cliente;
using Portal.Consultoras.Entities.Framework;

namespace Portal.Consultoras.BizLogic.Cliente
{
    public interface INotasBusinessLogic
    {
        ResponseType<long> NotaInsertar(int paisId, BENota nota);
        ResponseType<List<BENota>> NotaListar(int paisId, long consultoraId);
        ResponseType<bool> NotaActualizar(int paisId, BENota nota);
        ResponseType<bool> NotaEliminar(int paisId, short clienteId, long consultoraId, long clienteNotaId);
        ResponseType<List<BENota>> NotaProcesar(int paisId, BEClienteDB clienteDb);
        ResponseType<bool> PuedeAgregarMasNotas(int paisId, long consultoraId, short clienteId);
    }
}