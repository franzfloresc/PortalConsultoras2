using System;
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

        #region ConsultoraCliente
        public List<BEConsultoraClienteResponse> SincronizacionSubida(int paisID, long consultoraID, List<BEConsultoraCliente> clientes)
        {
            return new BLConsultoraCliente(paisID).SincronizacionSubida(consultoraID, clientes);
        }

        public List<BEConsultoraCliente> SincronizacionBajada(int paisID, long consultoraID)
        {
            return new BLConsultoraCliente(paisID).SincronizacionBajada(consultoraID);
        }

        public BEConsultoraClienteResponse ValidaTelefono(int paisID, BEContactoCliente contactoCliente)
        {
            return new BLConsultoraCliente(paisID).ValidaTelefono(contactoCliente);
        }
        #endregion
    }
}
