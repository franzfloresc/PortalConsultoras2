using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.ServiceModel;
using Portal.Consultoras.Entities;

namespace Portal.Consultoras.ServiceContracts
{
    [ServiceContract]
    public interface IClienteService
    {
        [OperationContract]
        int Insert(BECliente cliente);

        [OperationContract]
        int InsertById(BECliente cliente);

        [OperationContract]
        void Update(BECliente cliente);

        [OperationContract]
        bool Delete(int paisID, long consultoraID, int clienteID);

        [OperationContract]
        IList<BECliente> SelectByConsultora(int paisID, long consultoraID);

        [OperationContract]
        BECliente SelectById(int paisID, long consultoraID, int clienteID);

        [OperationContract]
        IList<BECliente> SelectByNombre(int paisID, long consultoraID, string Nombre);

        [OperationContract]
        int CheckClienteByConsultora(int paisID, long ConsultoraID, string Nombre);

        [OperationContract]
        void UndoCliente(int paisID, long consultoraID, int clienteID);

        [OperationContract]
        IList<BEPedidoWeb> GetPedidosWebByConsultora(int paisID, long consultoraID);

        [OperationContract]
        IList<BEPedidoWebDetalle> GetClientesByCampania(int paisID, int campaniaID, long consultoraID);

        [OperationContract]
        IList<BEPedidoWebDetalle> GetPedidoWebDetalleByCliente(int paisID, int campaniaID, long consultoraID, int clienteID);

        [OperationContract]
        IList<BECatalogo> GetCatalogosByCampania(int paisID, int campaniaID);

        // RQ 2295 Mejoras en Catalogos Belcorp
        [OperationContract]
        IList<BECatalogoConfiguracion> GetCatalogoConfiguracion(int paisID);

        [OperationContract]
        IList<BEPedidoWeb> GetPedidosWebAnterioresByConsultora(int paisID, long consultoraID);

        [OperationContract]
        IList<BEPedidoWebDetalle> GetPedidoProductosByCampania(int paisID, int campaniaID, long consultoraID);

        [OperationContract]
        void InsCatalogoCampania(int paisID, string CodigoConsultora, int CampaniaID);

    }
}
