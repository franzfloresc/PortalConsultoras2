﻿using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using Portal.Consultoras.Entities;
using Portal.Consultoras.BizLogic;
using Portal.Consultoras.ServiceContracts;
using Portal.Consultoras.Common;

namespace Portal.Consultoras.Service
{
    public class ClienteService : IClienteService
    {
        private BLCliente BLCliente;
        private BLPedidoWeb BLPedidoWeb;
        private BLPedidoWebDetalle BLPedidoWebDetalle;
        private BLCatalogo BLCatalogo;
        private BLPedidoWebAnteriores BLPedidoWebAnteriores;

        public ClienteService()
        {
            BLCliente = new BLCliente();
            BLPedidoWeb = new BLPedidoWeb();
            BLPedidoWebDetalle = new BLPedidoWebDetalle();
            BLCatalogo = new BLCatalogo();
            BLPedidoWebAnteriores = new BLPedidoWebAnteriores();
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

        public BECliente SelectById(int paisID, long consultoraID, int clienteID)
        {
            return BLCliente.SelectById(paisID, consultoraID, clienteID);
        }

        public int CheckClienteByConsultora(int paisID, long ConsultoraID, string Nombre)
        {
            return BLCliente.CheckClienteByConsultora(paisID, ConsultoraID, Nombre);
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

        public List<BEClienteResponse> SaveDB(int paisID, List<BEClienteDB> clientes)
        {
            return BLCliente.SaveDB(paisID, clientes);
        }

        public IList<BEClienteDB> SelectByConsultoraDB(int paisID, long consultoraID)
        {
            return BLCliente.SelectByConsultoraDB(paisID, consultoraID);
        }

        public BEClienteResponse ValidateTelefonoByConsultoraDB(int paisID, long consultoraID, BEClienteContactoDB contactoCliente)
        {
            return BLCliente.ValidateTelefonoByConsultoraDB(paisID, consultoraID, contactoCliente);
        }

        public bool MovimientoInsertar(int paisId, BEMovimiento movimiento)
        {
            return BLCliente.MovimientoInsertar(paisId, movimiento);
        }

        public IEnumerable<BEMovimiento> ListarMovimientosPorCliente(int paisId, int clienteId, long consultoraId)
        {
            return BLCliente.MovimientoListar(paisId, clienteId, consultoraId);
        }

        public bool RecordatorioInsertar(int paisId, BEClienteRecordatorio recordatorio)
        {
            return BLCliente.RecordatorioInsertar(paisId, recordatorio);
        }

        public IEnumerable<BEClienteRecordatorio> RecordatoriosObtenerPorCliente(int paisId, int clienteId, long consultoraId)
        {
            return BLCliente.RecordatorioListar(paisId, clienteId, consultoraId);
        }

        public bool RecordatorioActualizar(int paisId, BEClienteRecordatorio recordatorio)
        {
            return BLCliente.RecordatorioActualizar(paisId, recordatorio);
        }

        public bool RecordatorioEliminar(int paisId, long codigoCliente, long consultoraId, int recordatorioId)
        {
            return BLCliente.RecordatorioEliminar(paisId, codigoCliente, consultoraId, recordatorioId);
        }
    }
}
