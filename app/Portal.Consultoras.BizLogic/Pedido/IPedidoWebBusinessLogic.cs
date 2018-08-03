using Portal.Consultoras.Entities;
using Portal.Consultoras.Entities.Pedido;
using System;
using System.Collections.Generic;

namespace Portal.Consultoras.BizLogic
{
    public interface IPedidoWebBusinessLogic
    {
        void ActualizarIndicadorGPRPedidosFacturados(int PaisID, long ProcesoID);
        void ActualizarIndicadorGPRPedidosRechazados(int PaisID, long ProcesoID);
        void DelIndicadorPedidoAutentico(int paisID, BEIndicadorPedidoAutentico entidad);
        string[] DescargaPedidosDD(int paisID, DateTime fechaFacturacion, int tipoCronograma, bool marcarPedido, string usuario);
        string[] DescargaPedidosFIC(int paisID, DateTime fechaFacturacion, int tipoCronograma, string usuario);
        string[] DescargaPedidosWeb(int paisID, DateTime fechaFacturacion, int tipoCronograma, bool marcarPedido, string usuario, string descripcionProceso);
        void DeshacerUltimaDescargaPedido(int PaisID);
        BEConsultoraWS GetConsultoraWebService(int paisID, string CodigoConsultora);
        IList<BECuvProgramaNueva> GetCuvProgramaNueva(int paisID);
        BEConfiguracionCampania GetEstadoPedido(int PaisID, int CampaniaID, long ConsultoraID, int ZonaID, int RegionID);
        int GetFechaNoHabilFacturacion(int paisID, string CodigoZona, DateTime Fecha);
        BEHabPedidoCabWS GetHabilitarPedidosWebService(int paisID, string CodigoPais, int CampaniaID, string CodigoConsultora);
        List<BEPedidoWebService> GetPedidoConsolidado(int paisID, int CampaniaID, string CodigoConsultora, string ZonaCodigo, int PedidoPROL, string Origen, int IndicadorPedido, int IdEstadoActividad, int IndicadorSaldo, string SeccionCodigo, string NombreConsultora);
        List<BEPedidoWebService> GetPedidoCuvMarquesina(int paisID, int CampaniaID, long ConsultoraID, string CUV);
        IList<BEPedidoDDWebDetalle> GetPedidoDDDetalle(int paisID, string paisISO, int pedidoID, int CampaniaID, string Consultora, string Origen, bool IndicadorActivo);
        List<BEPedidoWebService> GetPedidoDetalleConsolidado(int paisID, int CampaniaID, string CodigoConsultora, string origen);
        IList<BEPedidoDDWeb> GetPedidosDDWeb(BEPedidoDDWeb BEPedidoDDWeb);
        List<BEPedidoWeb> GetPedidosFacturados(int paisId, string codigoConsultora);
        List<BEPedidoWeb> GetPedidosFacturadoSegunDias(int paisID, int campaniaID, long consultoraID, int maxDias);
        List<BEPedidoWeb> GetPedidosIngresadoFacturado(int paisID, int consultoraID, int campaniaID, string codigoConsultora, int top);
        List<BEPedidoWeb> GetPedidosIngresadoFacturadoWebMobile(int paisID, int consultoraID, int campaniaID, int clienteID, int top, string codigoConsultora);
        List<BEPedidoWebService> GetPedidosPortal(int paisID, int CampaniaID, string CodigoConsultora, string ZonaCodigo, int PedidoPROL);
        List<BEPedidoWebService> GetPedidosPortalCaribeMX(int paisID, int CampaniaID, string CodigoConsultora, string ZonaCodigo, int PedidoPROL);
        List<BEPedidoWebService> GetPedidosPortalCaribeMXFinal(int paisID, int CampaniaID, string CodigoConsultora, string ZonaCodigo, int PedidoPROL, int IndicadorPedido, string SeccionCodigo, int IdEstadoActividad, int IndicadorSaldo, string NombreConsultora);
        List<BEPedidoWebService> GetPedidosPortalConsolidado(int paisID, string CodigoConsultora, int CampaniaID, DateTime FechaInicial, DateTime FechaFinal);
        List<BEPedidoWebService> GetPedidosPortalConsolidadoDetalle(int paisID, string CodigoConsultora, int CampaniaID, string CodigosZonas);
        List<BEPedidoWebService> GetPedidosPortalDetalle(int paisID, int CampaniaID, string CodigoConsultora);
        List<BEPedidoWebService> GetPedidosPortalDetalleCaribeMXFinal(int paisID, int CampaniaID, string CodigoConsultora);
        List<BEPedidoExtendidoWS> GetPedidosPortalDetalleExtendido(int paisID, int CampaniaID, string CodigoConsultora);
        List<BEPedidoExtendidoWS> GetPedidosPortalExtendido(int paisID, int CampaniaID, string CodigoConsultora, string RegionCodigo, string ZonaCodigo, int PedidoPROL, int IndicadorPedido, string SeccionCodigo, int IdEstadoActividad, int IndicadorSaldo, string NombreConsultora);
        IList<BEPedidoWeb> GetPedidosWebByConsultora(int paisID, long consultoraID);
        BEPedidoWeb GetPedidosWebByConsultoraCampania(int paisID, int consultoraID, int campaniaID);
        IList<BEPedidoDDWeb> GetPedidosWebDDDetalleConsultora(BEPedidoDDWeb BEPedidoDDWeb);
        IList<BEPedidoDDWeb> GetPedidosWebDDNoFacturados(BEPedidoDDWeb BEPedidoDDWeb);
        IList<BEPedidoDDWebDetalle> GetPedidosWebDDNoFacturadosDetalle(int paisID, string paisISO, int CampaniaID, string Consultora, string Origen);
        BEPedidoWeb GetPedidoWebByCampaniaConsultora(int paisID, int campaniaID, long consultoraID);
        int GetPedidoWebID(int paisID, int campaniaID, long consultoraID);
        BEConsultoraResumen GetResumen(int paisId, int codigoConsultora, int codigoCampania);
        BEPedidoWeb GetResumenPedidoWebByCampaniaConsultora(int paisID, int campaniaID, long consultoraID);
        string GetTokenIndicadorPedidoAutentico(int paisID, string paisISO, string codigoRegion, string codigoZona);
        void InsertarLogPedidoWeb(int PaisID, int CampaniaID, string CodigoConsultora, int PedidoId, string Accion, string CodigoUsuario);
        int InsIndicadorPedidoAutentico(int paisID, BEIndicadorPedidoAutentico entidad);
        void InsLogOfertaFinal(int PaisID, BEOfertaFinalConsultoraLog entidad);
        void InsLogOfertaFinalBulk(int PaisID, List<BEOfertaFinalConsultoraLog> lista);
        List<int> ListaPaisValidoCUVCredito();
        BEPedidoDescarga ObtenerUltimaDescargaExitosa(int PaisID);
        BEPedidoDescarga ObtenerUltimaDescargaPedido(int PaisID);
        IList<BEPedidoWeb> SelectPedidosWebByFilter(BEPedidoWeb BEPedidoWeb, string Fecha, int? RegionID, int? TerritorioID);
        void UpdateMontosPedidoWeb(BEPedidoWeb bePedidoWeb);
        void UpdBloquedoPedidowebService(int paisID, int CampaniaID, string CodigoConsultora, bool Bloqueado, string DescripcionBloqueo);
        void UpdBloqueoPedido(BEPedidoWeb BEPedidoWeb);
        void UpdDesbloqueoPedido(BEPedidoWeb BEPedidoWeb);
        int UpdIndicadorPedidoAutentico(int paisID, BEIndicadorPedidoAutentico entidad);
        BEValidacionModificacionPedido ValidacionModificarPedido(int paisID, long consultoraID, int campania, bool usuarioPrueba, int aceptacionConsultoraDA, bool validarGPR = true, bool validarReservado = true, bool validarHorario = true, bool validarFacturado = true);
        int ValidarCargadePedidos(int paisID, int TipoCronograma, int MarcaPedido, DateTime FechaFactura);
        BECUVCredito ValidarCUVCreditoPorCUVRegular(int paisID, string codigoConsultora, string cuv, int campaniaID);
        int ValidarCuvMarquesina(int paisID, string CampaniaID, int Cuv);
        int ValidarDesactivaRevistaGana(int paisID, int campaniaID, string codigoZona);

        #region MisPedidos
        List<BEMisPedidosCampania> GetMisPedidosByCampania(int paisID, long ConsultoraID, int CampaniaID, int ClienteID, int Top);
        List<BEMisPedidosFacturados> GetMisPedidosFacturados(int paisID, long ConsultoraID, int CampaniaID, int ClienteID, string NombreConsultora);
        List<BEMisPedidosIngresados> GetMisPedidosIngresados(int paisID, long ConsultoraID, int CampaniaID, int ClienteID, string NombreConsultora);
        #endregion

        void DescargaPedidosCliente(int paisID, int nroLote, string codigoUsuario);
    }
}