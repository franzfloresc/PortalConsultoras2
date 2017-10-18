using Portal.Consultoras.BizLogic;
using Portal.Consultoras.Common;
using Portal.Consultoras.Entities;
using Portal.Consultoras.Entities.Cliente;
using Portal.Consultoras.ServiceContracts;
using System;
using System.Collections.Generic;
using Portal.Consultoras.BizLogic.Cliente;
using Portal.Consultoras.Entities.Framework;

namespace Portal.Consultoras.Service
{
    public class ClienteService : IClienteService
    {
        private BLCliente BLCliente;
        private BLPedidoWeb BLPedidoWeb;
        private BLPedidoWebDetalle BLPedidoWebDetalle;
        private BLCatalogo BLCatalogo;
        private BLPedidoWebAnteriores BLPedidoWebAnteriores;
        private readonly INotasBusinessLogic _notasBusinessLogic;
        private readonly IMovimientoBusinessLogic _movimientoBusinessLogic;
        private readonly IRecordatorioBusinessLogic _recordatorioBusinessLogic;

        public ClienteService() : this(new BLNotas(),
            new BLMovimiento(),
            new BLRecordatorio())
        {
            BLCliente = new BLCliente();
            BLPedidoWeb = new BLPedidoWeb();
            BLPedidoWebDetalle = new BLPedidoWebDetalle();
            BLCatalogo = new BLCatalogo();
            BLPedidoWebAnteriores = new BLPedidoWebAnteriores();
        }

        public ClienteService(INotasBusinessLogic notasBusinessLogic,
            IMovimientoBusinessLogic movimientoBusinessLogic,
            IRecordatorioBusinessLogic recordatorioBusinessLogic)
        {
            _notasBusinessLogic = notasBusinessLogic;
            _movimientoBusinessLogic = movimientoBusinessLogic;
            _recordatorioBusinessLogic = recordatorioBusinessLogic;
        }

        public int Insert(BECliente cliente)
        {
            return BLCliente.Insert(cliente);
        }

        public void Update(BECliente cliente)
        {
            BLCliente.Update(cliente);
        }

        public bool Delete(int paisID, long consultoraID, int clienteID)
        {
            return BLCliente.Delete(paisID, consultoraID, clienteID);
        }

        public IList<BECliente> SelectByConsultora(int paisID, long consultoraID)
        {
            return BLCliente.SelectByConsultora(paisID, consultoraID);
        }

        public BECliente SelectByConsultoraByCodigo(int paisID, long consultoraID, int ClienteID, long codigoCliente)
        {
            return BLCliente.SelectByConsultoraByCodigo(paisID, consultoraID, ClienteID, codigoCliente);
        }

        public BECliente SelectById(int paisID, long consultoraID, int clienteID)
        {
            return BLCliente.SelectById(paisID, consultoraID, clienteID);
        }

        public int CheckClienteByConsultora(int paisID, long ConsultoraID, string Nombre)
        {
            return BLCliente.CheckClienteByConsultora(paisID, ConsultoraID, Nombre);
        }

        public int GetExisteClienteConsultora(int paisID, BECliente entidad)
        {
            return BLCliente.GetExisteClienteConsultora(paisID, entidad);
        }

        public void UndoCliente(int paisID, long consultoraID, int clienteID)
        {
            BLCliente.UndoCliente(paisID, consultoraID, clienteID);
        }

        public IList<BEPedidoWeb> GetPedidosWebByConsultora(int paisID, long consultoraID)
        {
            return BLPedidoWeb.GetPedidosWebByConsultora(paisID, consultoraID);
        }

        public IList<BEPedidoWebDetalle> GetClientesByCampania(int paisID, int campaniaID, long consultoraID)
        {
            return BLPedidoWebDetalle.GetClientesByCampania(paisID, campaniaID, consultoraID);
        }

        //EPD-1164
        public IList<BEPedidoWebDetalle> GetClientesByCampaniaByClienteID(int paisID, int campaniaID, long consultoraID, string ClienteID)
        {
            return BLPedidoWebDetalle.GetClientesByCampaniaByClienteID(paisID, campaniaID, consultoraID, ClienteID);
        }

        public IList<BEPedidoWebDetalle> GetPedidoWebDetalleByCliente(int paisID, int campaniaID, long consultoraID, int clienteID)
        {
            return BLPedidoWebDetalle.GetPedidoWebDetalleByCliente(paisID, campaniaID, consultoraID, clienteID);
        }

        public IList<BECatalogo> GetCatalogosByCampania(int paisID, int campaniaID)
        {
            return BLCatalogo.GetCatalogosByCampania(paisID, campaniaID);
        }

        // RQ 2295 Mejoras en Catalogos Belcorp
        public IList<BECatalogoConfiguracion> GetCatalogoConfiguracion(int paisID)
        {
            return BLCatalogo.GetCatalogoConfiguracion(paisID);
        }

        public IList<BECatalogoRevista> GetListCatalogoRevistaPublicado(string paisISO, string codigoZona, int campania, Enumeradores.TamanioImagenIssu tamanioImagenIssu)
        {
            return BLCatalogo.GetListCatalogoRevistaPublicado(paisISO, codigoZona, campania, tamanioImagenIssu);
        }

        public IList<BECatalogoRevista> GetListCatalogoRevistaPublicadoWithTitulo(string paisISO, string codigoZona, int campania)
        {
            return BLCatalogo.GetListCatalogoRevistaPublicadoWithTitulo(paisISO, codigoZona, campania);
        }

        public IList<BECatalogoRevista> GetCatalogoRevista(string paisISO, string codigoZona, string campanias)
        {
            return BLCatalogo.GetCatalogoRevista(paisISO, codigoZona, campanias);
        }

        public IList<BEPedidoWeb> GetPedidosWebAnterioresByConsultora(int paisID, long consultoraID)
        {
            return BLPedidoWebAnteriores.GetPedidosWebAnterioresByConsultora(paisID, consultoraID);
        }

        public IList<BEPedidoWebDetalle> GetPedidoProductosByCampania(int paisID, int campaniaID, long consultoraID)
        {
            return BLPedidoWebAnteriores.GetPedidoProductosByCampania(paisID, campaniaID, consultoraID);
        }


        public IList<BECliente> SelectByNombre(int paisID, long consultoraID, string Nombre)
        {
            return BLCliente.SelectByNombre(paisID, consultoraID, Nombre);
        }


        public int InsertById(BECliente cliente)
        {
            return BLCliente.InsertById(cliente);
        }

        public void InsCatalogoCampania(int paisID, string CodigoConsultora, int CampaniaID)
        {
            BLCliente.InsCatalogoCampania(paisID, CodigoConsultora, CampaniaID);
        }

        #region ClienteDB
        public List<BEClienteDB> SaveDB(int paisID, List<BEClienteDB> clientes)
        {
            return BLCliente.SaveDB(paisID, clientes);
        }

        public IList<BEClienteDB> SelectByConsultoraDB(int paisID, long consultoraID, int campaniaID, int clienteID)
        {
            return BLCliente.SelectByConsultoraDB(paisID, consultoraID, campaniaID, clienteID);
        }
        #endregion

        public int MovimientoInsertar(int paisId, BEMovimiento movimiento)
        {
            var result = _movimientoBusinessLogic.Insertar(paisId, movimiento);

            return result.Data;
        }

        public IEnumerable<BEMovimiento> ListarMovimientosPorCliente(int paisId, short clienteId, long consultoraId)
        {
            return _movimientoBusinessLogic.Listar(paisId, clienteId, consultoraId);
        }

        public Tuple<bool, string> MovimientoActualizar(int paisId, BEMovimiento movimiento)
        {
            var result = _movimientoBusinessLogic.Actualizar(paisId, movimiento);
            return new Tuple<bool, string>(result.Success, result.Message);
        }

        public Tuple<bool, string> MovimientoEliminar(int paisId, long consultoraId, short clienteId, int movimientoId)
        {
            var result = _movimientoBusinessLogic.Eliminar(paisId, consultoraId, clienteId, movimientoId);
            return new Tuple<bool, string>(result.Success, result.Message);
        }

        public int RecordatorioInsertar(int paisId, BEClienteRecordatorio recordatorio)
        {
            return _recordatorioBusinessLogic.Insertar(paisId, recordatorio);
        }

        public IEnumerable<BEClienteRecordatorio> RecordatoriosObtenerPorCliente(int paisId, long consultoraId)
        {
            return _recordatorioBusinessLogic.Listar(paisId, consultoraId);
        }

        public bool RecordatorioActualizar(int paisId, BEClienteRecordatorio recordatorio)
        {
            return _recordatorioBusinessLogic.Actualizar(paisId, recordatorio);
        }

        public bool RecordatorioEliminar(int paisId, short clienteId, long consultoraId, int recordatorioId)
        {
            return _recordatorioBusinessLogic.Eliminar(paisId, clienteId, consultoraId, recordatorioId);
        }

        public IEnumerable<BEClienteDeudaRecordatorio> ObtenerDeudores(int paisId, long consultoraId)
        {
            return BLCliente.ObtenerDeudores(paisId, consultoraId);
        }

        public ResponseType<long> NotaInsertar(int paisId, BENota nota)
        {
            return _notasBusinessLogic.Insertar(paisId, nota);
        }

        public ResponseType<List<BENota>> NotaListar(int paisId, long consultoraId)
        {
            return _notasBusinessLogic.Listar(paisId, consultoraId);
        }

        public ResponseType<bool> NotaActualizar(int paisId, BENota nota)
        {
            return _notasBusinessLogic.Actualizar(paisId, nota);
        }

        public ResponseType<bool> NotaEliminar(int paisId, short clienteId, long consultoraId, long clienteNotaId)
        {
            return _notasBusinessLogic.Eliminar(paisId, clienteId, consultoraId, clienteNotaId);
        }
    }
}
