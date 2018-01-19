using Portal.Consultoras.Entities;
using Portal.Consultoras.Entities.Cliente;
using Portal.Consultoras.Entities.Framework;
using System.Collections.Generic;

namespace Portal.Consultoras.BizLogic.Cliente
{
    public interface IRecordatorioBusinessLogic
    {
        ResponseType<int> Insertar(int paisId, BEClienteRecordatorio recordatorio);
        List<BEClienteRecordatorio> Listar(int paisId, long consultoraId, short clienteId = 0);
        ResponseType<bool> Actualizar(int paisId, BEClienteRecordatorio recordatorio);
        ResponseType<bool> Eliminar(int paisId, short clienteId, long consultoraId, int recordatorioId);

        ResponseType<List<BEClienteRecordatorio>> Procesar(int paisID, BEClienteDB clienteDB);
    }
}