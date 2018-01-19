using Portal.Consultoras.Entities;
using System;
using System.Collections.Generic;

namespace Portal.Consultoras.BizLogic
{
    public interface ITrackingBusinessLogic
    {
        List<BEPostVenta> GetMisPostVentaByConsultora(int paisID, string codigoConsultora);
        List<BENovedadTracking> GetNovedadesTracking(int paisID, string NumeroPedido);
        List<BEPostVenta> GetNovedadPostVenta(int paisID, string numeroRecojo);
        BENovedadFacturacion GetPedidoAnuladoByConsultora(int PaisID, string CampaniaId, string CodigoConsultora, DateTime Fecha, string NumeroPedido);
        BETracking GetPedidoByConsultoraAndCampania(int paisID, string codigoConsultora, int campania);
        BETracking GetPedidoByConsultoraAndCampaniaAndNroPedido(int paisID, string codigoConsultora, int campania, string nroPedido);
        BENovedadFacturacion GetPedidoRechazadoByConsultora(int PaisID, string CampaniaId, string CodigoConsultora, DateTime Fecha);
        List<BETracking> GetPedidosByConsultora(int paisID, string codigoConsultora, int top);
        List<BEPostVenta> GetSeguimientoPostVenta(int paisID, string numeroRecojo, int estadoRecojoID);
        List<BETracking> GetTrackingByPedido(int paisID, string codigo, string campana, string nropedido);
        List<BETracking> GetTrackingPedidoByConsultora(int paisID, string codigoConsultora, int top);
        int InsConfirmacionEntrega(int paisID, BEConfirmacionEntrega oBEConfirmacionEntrega);
        int InsConfirmacionRecojo(int paisID, BEConfirmacionRecojo oBEConfirmacionRecoja);
        int UpdConfirmacionEntrega(int paisID, BEConfirmacionEntrega oBEConfirmacionEntrega);
    }
}