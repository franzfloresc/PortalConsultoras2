using Portal.Consultoras.Common;
using Portal.Consultoras.Entities;
using System.Collections.Generic;
using System.ServiceModel;

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
        BECliente SelectByConsultoraByCodigo(int paisID, long consultoraID, int ClienteID, long codigoCliente);

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

        //EPD-1164
        [OperationContract]
        IList<BEPedidoWebDetalle> GetClientesByCampaniaByClienteID(int paisID, int campaniaID, long consultoraID, string ClienteID);

        [OperationContract]
        IList<BEPedidoWebDetalle> GetPedidoWebDetalleByCliente(int paisID, int campaniaID, long consultoraID, int clienteID);

        [OperationContract]
        IList<BECatalogo> GetCatalogosByCampania(int paisID, int campaniaID);

        // RQ 2295 Mejoras en Catalogos Belcorp
        [OperationContract]
        IList<BECatalogoConfiguracion> GetCatalogoConfiguracion(int paisID);

        [OperationContract]
        IList<BECatalogoRevista> GetListCatalogoRevistaPublicado(string paisISO, string codigoZona, int campania, Enumeradores.TamanioImagenIssu tamanioImagenIssu);

        [OperationContract]
        IList<BECatalogoRevista> GetListCatalogoRevistaPublicadoWithTitulo(string paisISO, string codigoZona, int campania);

        [OperationContract]
        IList<BEPedidoWeb> GetPedidosWebAnterioresByConsultora(int paisID, long consultoraID);

        [OperationContract]
        IList<BEPedidoWebDetalle> GetPedidoProductosByCampania(int paisID, int campaniaID, long consultoraID);

        [OperationContract]
        void InsCatalogoCampania(int paisID, string CodigoConsultora, int CampaniaID);

        [OperationContract]
        List<BEClienteResponse> SaveDB(int paisID, List<BEClienteDB> clientes);

        [OperationContract]
        IList<BEClienteDB> SelectByConsultoraDB(int paisID, long consultoraID);

        [OperationContract]
        BEClienteResponse ValidateTelefonoByConsultoraDB(int paisID, long consultoraID, BEClienteContactoDB contactoCliente);

        [OperationContract]
        bool MovimientoInsertar(int paisId, BEMovimiento movimiento);

        [OperationContract]
        IEnumerable<BEMovimiento> ListarMovimientosPorCliente(int paisId, int clienteId, long consultoraId);

        [OperationContract]
        bool RecordatorioInsertar(int paisId, BEClienteRecordatorio recordatorio);

        [OperationContract]
        IEnumerable<BEClienteRecordatorio> RecordatoriosObtenerPorCliente(int paisId, int clienteId, long consultoraId);

        [OperationContract]
        bool RecordatorioActualizar(int paisId, BEClienteRecordatorio recordatorio);

        [OperationContract]
        bool RecordatorioEliminar(int paisId, long codigoCliente, long consultoraId, int recordatorioId);
    }
}
