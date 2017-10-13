using System.Collections.Generic;

using Portal.Consultoras.Entities;

namespace Portal.Consultoras.BizLogic
{
    public interface IClienteDBBusinessLogic
    {
        List<BEClienteDB> GetCliente(short TipoContactoID, string Valor, int PaisID);
        List<BEClienteDB> GetClienteByClienteID(string Clientes, int PaisID);
        long InsertCliente(BEClienteDB cliente);
        bool UpdateCliente(BEClienteDB cliente);
    }
}