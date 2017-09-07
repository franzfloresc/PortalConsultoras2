﻿using Portal.Consultoras.Common;
using Portal.Consultoras.Entities;
using Portal.Consultoras.Entities.Cliente;
using System;
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
        int GetExisteClienteConsultora(int paisID, BECliente entidad);

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
        IList<BECatalogoRevista> GetCatalogoRevista(string paisISO, string codigoZona, string campanias);

        [OperationContract]
        IList<BEPedidoWeb> GetPedidosWebAnterioresByConsultora(int paisID, long consultoraID);

        [OperationContract]
        IList<BEPedidoWebDetalle> GetPedidoProductosByCampania(int paisID, int campaniaID, long consultoraID);

        [OperationContract]
        void InsCatalogoCampania(int paisID, string CodigoConsultora, int CampaniaID);

        #region ClienteDB
        [OperationContract]
        List<BEClienteDB> SaveDB(int paisID, List<BEClienteDB> clientes);

        [OperationContract]
        IList<BEClienteDB> SelectByConsultoraDB(int paisID, long consultoraID, int campaniaID);
        #endregion

        [OperationContract]
        int MovimientoInsertar(int paisId, BEMovimiento movimiento);

        [OperationContract]
        IEnumerable<BEMovimiento> ListarMovimientosPorCliente(int paisId, short clienteId, long consultoraId);

        [OperationContract]
        Tuple<bool, string> MovimientoActualizar(int paisId, BEMovimiento movimiento);

        [OperationContract]
        int RecordatorioInsertar(int paisId, BEClienteRecordatorio recordatorio);

        [OperationContract]
        IEnumerable<BEClienteRecordatorio> RecordatoriosObtenerPorCliente(int paisId, long consultoraId);

        [OperationContract]
        bool RecordatorioActualizar(int paisId, BEClienteRecordatorio recordatorio);

        [OperationContract]
        bool RecordatorioEliminar(int paisId, short clienteId, long consultoraId, int recordatorioId);

        [OperationContract]
        IEnumerable<BEClienteDeudaRecordatorio> ObtenerDeudores(int paisId, long consultoraId);

        [OperationContract]
        long NotaInsertar(int paisId, BENota nota);

        [OperationContract]
        IEnumerable<BENota> NotasObtenerPorCliente(int paisId, long consultoraId);

        [OperationContract]
        bool NotaActualizar(int paisId, BENota nota);

        [OperationContract]
        bool NotaEliminar(int paisId, short clienteId, long consultoraId, long clienteNotaId);

    }
}
