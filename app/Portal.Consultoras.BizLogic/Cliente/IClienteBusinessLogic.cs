using System.Collections.Generic;
using Portal.Consultoras.Entities;
using Portal.Consultoras.Entities.Cliente;

namespace Portal.Consultoras.BizLogic
{
    public interface IClienteBusinessLogic
    {
        int CheckClienteByConsultora(int paisID, long ConsultoraID, string Nombre);
        bool Delete(int paisID, long consultoraID, int clienteID);
        int GetExisteClienteConsultora(int paisID, BECliente entidad);
        void InsCatalogoCampania(int paisID, string CodigoConsultora, int CampaniaID);
        int Insert(BECliente cliente);
        int InsertById(BECliente cliente);
        IEnumerable<BEClienteDeudaRecordatorio> ObtenerDeudores(int paisId, long consultoraId);
        List<BEClienteDB> SaveDB(int paisID, List<BEClienteDB> clientes);
        IList<BECliente> SelectByConsultora(int paisID, long consultoraID, int ClienteID = 0);
        BECliente SelectByConsultoraByCodigo(int paisID, long consultoraID, int ClienteID, long codigoCliente);
        List<BEClienteDB> SelectByConsultoraDB(int paisID, long consultoraID, int campaniaID, int clienteID);
        BECliente SelectById(int paisID, long consultoraID, int clienteID);
        IList<BECliente> SelectByNombre(int paisID, long consultoraID, string Nombre);
        void UndoCliente(int paisID, long consultoraID, int clienteID);
        void Update(BECliente cliente);
    }
}