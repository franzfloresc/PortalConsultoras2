using Portal.Consultoras.Entities;
using Portal.Consultoras.Entities.CaminoBrillante;
using Portal.Consultoras.Entities.OrdenYFiltros;
using Portal.Consultoras.Entities.Pedido;
using System.Collections.Generic;

namespace Portal.Consultoras.BizLogic.CaminoBrillante
{
    public interface ICaminoBrillanteBusinessLogic
    {
        List<BENivelCaminoBrillante> GetNiveles(int paisId);
        BEConsultoraCaminoBrillante GetConsultoraNivel(BEUsuario entidad);
        BEDemostradoresPaginado GetDemostradores(BEUsuario entidad, int cantRegistros, int regMostrados, string codOrdenar, string codFiltro);
        List<BEKitCaminoBrillante> GetKits(BEUsuario entidad);
        void UpdFlagsKitsOrDemostradores(BEPedidoWebDetalle bePedidoWebDetalle, int paisId, int campaniaId, int nivelId);
        bool UpdEstragiaCaminiBrillante(BEEstrategia estrategia, int paisId, int campaniaId, int nivelId, string cuv);
        string ValAgregarCaminiBrillante(BEEstrategia estrategia, BEUsuario usuario, BEPedidoDetalle pedidoDetalle, List<BEPedidoWebDetalle> lstDetalle);
        BEValidacionCaminoBrillante ValidarBusquedaCaminoBrillante(BEUsuario entidad, string cuv);
        BEOrdenFiltroConfiguracion GetFiltrosCaminoBrillante(int paisId, bool isApp);
        BECarruselCaminoBrillante GetCarruselCaminoBrillante(BEUsuario entidad);
        List<BEConfiguracionCaminoBrillante> GetCaminoBrillanteConfiguracion(int paisID, string esApp);
        BEOfertaCaminoBrillante GetOfertaCaminoBrillante(BEUsuario entidad, string CUV);
        //bool IsOrigenPedidoCaminoBrillante(int origenPedidoWeb);
    }
}