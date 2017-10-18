using System.Collections.Generic;
using Portal.Consultoras.Entities;
using Portal.Consultoras.Entities.Cliente;

namespace Portal.Consultoras.BizLogic.Cliente
{
    public interface IRecordatorioBusinessLogic
    {
        int Insertar(int paisId, BEClienteRecordatorio recordatorio);
        List<BEClienteRecordatorio> Listar(int paisId, long consultoraId, short clienteId = 0);
        bool Actualizar(int paisId, BEClienteRecordatorio recordatorio);
        bool Eliminar(int paisId, short clienteId, long consultoraId, int recordatorioId);
        void Procesar(int paisID, BEClienteDB clienteDB);
    }
}