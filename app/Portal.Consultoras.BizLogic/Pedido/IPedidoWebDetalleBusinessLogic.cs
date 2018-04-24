﻿using System.Collections.Generic;
using Portal.Consultoras.Entities;

namespace Portal.Consultoras.BizLogic
{
    public interface IPedidoWebDetalleBusinessLogic
    {
        void AceptarBackOrderPedidoWebDetalle(BEPedidoWebDetalle pedidowebdetalle);
        void DelPedidoWebDetalle(BEPedidoWebDetalle pedidowebdetalle);
        bool DelPedidoWebDetalleMasivo(int PaisID, int CampaniaID, int PedidoID, string CodigoUsuario);
        bool DelPedidoWebDetallePackNueva(int PaisID, long ConsultoraID, int PedidoID);
        IList<BEPedidoWebDetalle> GetClientesByCampania(int paisID, int campaniaID, long consultoraID);
        IList<BEPedidoWebDetalle> GetClientesByCampaniaByClienteID(int paisID, int campaniaID, long consultoraID, string ClienteID);
        IList<BEPedidoDDWebDetalle> GetPedidosDDWebDetalleByCampaniaPedido(int paisID, int CampaniaID, int PedidoID);
        IList<BEPedidoWebDetalle> GetPedidoWebDetalleByCampania(BEPedidoWebDetalleParametros bePedidoWebDetalleParametros);
        IList<BEPedidoWebDetalle> GetPedidoWebDetalleByCliente(int paisID, int campaniaID, long consultoraID, int clienteID);
        IList<BEPedidoWebDetalle> GetPedidoWebDetalleByOfertaWeb(int paisID, int CampaniaID, long ConsultoraID, bool OfertaWeb);
        IList<BEPedidoWebDetalle> GetPedidoWebDetalleByPedidoID(int paisID, int campaniaID, int pedidoID);
        IList<BEPedidoWebDetalle> GetPedidoWebDetalleByPedidoValidado(int paisID, int CampaniaID, long ConsultoraID, string Consultora);
        BEPedidoWebResult InsertPedido(BEPedidoWebDetalleInvariant model);
        void InsPedidoWebAccionesPROL(List<BEPedidoWebDetalle> olstBEPedidoWebDetalle, int Tipo, int Accion);
        BEPedidoWebDetalle InsPedidoWebDetalle(BEPedidoWebDetalle pedidowebdetalle);
        void InsPedidoWebDetallePROL(int PaisID, int CampaniaID, int PedidoID, short EstadoPedido, List<BEPedidoWebDetalle> olstPedidoWebDetalle, int ModificaPedido, string CodigoUsuario, decimal MontoTotalProl, decimal DescuentoProl);
        void InsPedidoWebDetallePROLv2(int PaisID, int CampaniaID, int PedidoID, short EstadoPedido, List<BEPedidoWebDetalle> olstPedidoWebDetalle, string CodigoUsuario, decimal MontoTotalProl, decimal DescuentoProl);
        void QuitarBackOrderPedidoWebDetalle(BEPedidoWebDetalle pedidowebdetalle);
        IList<BEPedidoWebDetalle> SelectDetalleBloqueoPedidoByPedidoId(int paisID, int PedidoID);
        void UpdBackOrderListPedidoWebDetalle(int paisID, int campaniaID, int pedidoID, List<BEPedidoWebDetalle> listPedidoWebDetalle);
        void UpdPedidoWebByEstado(int PaisID, int CampaniaID, int PedidoID, short EstadoPedido, bool ModificaPedidoReservado, bool Eliminar, string CodigoUsuario, bool ValidacionAbierta);
        void UpdPedidoWebDetalle(BEPedidoWebDetalle pedidowebdetalle);
        short UpdPedidoWebDetalleMasivo(List<BEPedidoWebDetalle> pedidowebdetalle);
    }
}