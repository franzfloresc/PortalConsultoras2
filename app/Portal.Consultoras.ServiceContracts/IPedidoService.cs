using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.ServiceModel;
using Portal.Consultoras.Entities;
using System.Data;

namespace Portal.Consultoras.ServiceContracts
{
    [ServiceContract]
    public interface IPedidoService
    {
        #region Reporte Lider

        [OperationContract]
        BEPedidoReporteLiderIndicador GetPedidosReporteLiderIndicador(int paisID, long ConsultoraLiderID, string CodigoPais, string CodigoCampaniaActual);

        [OperationContract]
        IList<BEPedidoReporteLiderListado> GetPedidosReporteLiderPedidosValidados(int paisID, long ConsultoraLiderID, string CodigoPais, string CodigoCampaniaActual);

        [OperationContract]
        IList<BEPedidoReporteLiderListado> GetPedidosReporteLiderPedidosNoValidados(int paisID, long ConsultoraLiderID, string CodigoPais, string CodigoCampaniaActual);

        [OperationContract]
        IList<BEPedidoReporteLiderListado> GetPedidosReporteLiderPedidosRechazados(int paisID, long ConsultoraLiderID, string CodigoPais, string CodigoCampaniaActual);

        [OperationContract]
        IList<BEPedidoReporteLiderListado> GetPedidosReporteLiderPedidosFacturados(int paisID, long ConsultoraLiderID, string CodigoPais, string CodigoCampaniaActual);

        #endregion

        [OperationContract]
        BEPedidoWebDetalle Insert(BEPedidoWebDetalle pedidowebdetalle);

        [OperationContract]
        void DelPedidoWebDetalle(BEPedidoWebDetalle pedidowebdetalle);

        [OperationContract]
        IList<BEPedidoWebDetalle> SelectByCampania(int paisID, int CampaniaID, long ConsultoraID, string Consultora);

        [OperationContract]
        IList<BEPedidoDDWeb> SelectPedidosDDWeb(BEPedidoDDWeb BEPedidoDDWeb);

        [OperationContract]
        IList<BEPedidoDDWebDetalle> SelectPedidosDDWebDetalleByCampaniaPedido(int paisID, int CampaniaID, int PedidoID);

        [OperationContract]
        IList<BEPedidoWebDetalle> SelectByOfertaWeb(int paisID, int CampaniaID, long ConsultoraID, bool OfertaWeb);

        [OperationContract]
        int ValidarCargadePedidos(int paisID, int TipoCronograma, int MarcaPedido, DateTime FechaFactura);

        [OperationContract]
        string[] DescargaPedidosWeb(int paisID, DateTime fechaFacturacion, int tipoCronograma, bool marcarPedido, string usuario);

        // R20151003 - Inicio
        [OperationContract]
        string[] DescargaPedidosDD(int paisID, DateTime fechaFacturacion, int tipoCronograma, bool marcarPedido, string usuario);

        [OperationContract]
        int ValidarCuvDescargado(int paisID, int anioCampania, string codigoVenta, string codigoConsultora);
        // R20151003 - Fin

        //[OperationContract(AsyncPattern = true)]
        //IAsyncResult BeginDescargaPedidosWeb(AsyncCallback callback, int paisID, DateTime fechaFacturacion, int tipoCronograma, bool marcarPedido);

        //int EndDescargaPedidosWeb(IAsyncResult result);

        [OperationContract]
        BEConfiguracionCampania GetEstadoPedido(int PaisID, int CampaniaID, long ConsultoraID, int ZonaID, int RegionID);

        [OperationContract]
        List<BEEscalaDescuento> GetEscalaDescuento(int PaisID);

        [OperationContract]
        List<BEEscalaDescuento> GetParametriaOfertaFinal(int paisID);

        [OperationContract]
        IList<BECuvProgramaNueva> GetCuvProgramaNueva(int paisID);

        #region Consulta y Bloquedo de Pedido
        [OperationContract]
        IList<BEPedidoWeb> SelectPedidosWebByFilter(BEPedidoWeb BEPedidoWeb, string Fecha, int? RegionID, int? TerritorioID);

        [OperationContract]
        IList<BEPedidoWebDetalle> SelectDetalleBloqueoPedidoByPedidoId(int paisID, int PedidoID);

        [OperationContract]
        void UpdBloqueoPedido(BEPedidoWeb BEPedidoWeb);

        [OperationContract]
        void UpdDesbloqueoPedido(BEPedidoWeb BEPedidoWeb);


        #endregion

        [OperationContract]
        void InsPedidoWebDetallePROL(int PaisID, int CampaniaID, int PedidoID, short EstadoPedido, List<BEPedidoWebDetalle> olstPedidoWebDetalle, int ModificaPedido, string CodigoUsuario, decimal MontoTotalProl, decimal DescuentoProl);

        [OperationContract]
        void InsPedidoWebDetallePROLv2(int PaisID, int CampaniaID, int PedidoID, short EstadoPedido, List<BEPedidoWebDetalle> olstPedidoWebDetalle, bool ValidacionAbierta, string CodigoUsuario, decimal MontoTotalProl, decimal DescuentoProl);

        [OperationContract]
        void UpdPedidoWebByEstado(int PaisID, int CampaniaID, int PedidoID, short EstadoPedido, bool ModificaPedidoReservado, bool Eliminar, string CodigoUsuario, bool ValidacionAbierta);

        [OperationContract]
        void UpdPedidoWebDetalle(BEPedidoWebDetalle pedidowebdetalle);

        [OperationContract]
        short UpdPedidoWebDetalleMasivo(List<BEPedidoWebDetalle> pedidowebdetalle);

        [OperationContract]
        IList<BEPedidoWebDetalle> SelectByPedidoValidado(int paisID, int CampaniaID, long ConsultoraID, string Consultora);

        [OperationContract]
        IList<BEPedidoDDWeb> GetPedidosWebDDNoFacturados(BEPedidoDDWeb BEPedidoDDWeb);

        [OperationContract]
        IList<BEPedidoDDWebDetalle> GetPedidosWebDDNoFacturadosDetalle(int paisID, string paisISO, int CampaniaID, string Consultora, string Origen);

        [OperationContract]
        IList<BEPedidoDDWeb> GetPedidosWebDDDetalleConsultora(BEPedidoDDWeb BEPedidoDDWeb);

        [OperationContract]
        int ValidarCuvMarquesina(string CampaniaID, int cuv, int IdPais);

        [OperationContract]
        IList<BEPedidoWebService> GetPedidoCuvMarquesina(int paisID, int CampaniaID, long ConsultoraID, string cuv);
        #region Fase II

        #region Ofertas Web

        [OperationContract]
        IList<BEConfiguracionOferta> GetTipoOfertasAdministracion(int paisID, int TipoOfertaSisID);

        [OperationContract]
        IList<BEOfertaProducto> GetProductosByTipoOferta(int paisID, int TipoOfertaSisID, int CampaniaID, string CodigoOferta);

        [OperationContract]
        IList<BEOfertaProducto> GetProductosOfertaByCUVCampania(int paisID, int TipoOfertaSisID, int CampaniaID, string CUV);

        [OperationContract]
        int InsOfertaProducto(BEOfertaProducto entity);

        [OperationContract]
        int UpdOfertaProducto(BEOfertaProducto entity);

        [OperationContract]
        int DelOfertaProducto(BEOfertaProducto entity);

        [OperationContract]
        int InsAdministracionStockMinimo(BEAdministracionOfertaProducto entity);

        [OperationContract]
        int UpdAdministracionStockMinimo(BEAdministracionOfertaProducto entity);

        [OperationContract]
        int UpdOfertaProductoStockMasivo(int paisID, List<BEOfertaProducto> stockProductos);

        //[OperationContract]
        //int UpdOfertaProductoStock(BEOfertaProducto entity);

        [OperationContract]
        IList<BEAdministracionOfertaProducto> GetDatosAdmStockMinimoCorreos(int paisID);

        [OperationContract]
        int InsStockCargaLog(BEStockCargaLog entity);

        [OperationContract]
        int GetOrdenPriorizacion(int paisID, int ConfiguracionOfertaID, int CampaniaID);

        [OperationContract]
        int ValidarPriorizacion(int paisID, int ConfiguracionOfertaID, int CampaniaID, int Orden);

        [OperationContract]
        int InsMatrizComercial(BEMatrizComercial entity);

        [OperationContract]
        int UpdMatrizComercial(BEMatrizComercial entity);

        [OperationContract]
        IList<BEMatrizComercial> GetMatrizComercialByCodigoSAP(int paisID, string codigoSAP);

        [OperationContract]
        IList<BEMatrizComercial> GetImagenesByCodigoSAP(int paisID, string codigoSAP);

        [OperationContract]
        int UpdMatrizComercialDescripcionMasivo(int paisID, List<BEMatrizComercial> lstmatriz, string UsuarioRegistro);

        [OperationContract]
        IList<BEOfertaProducto> GetOfertaProductosPortal(int PaisID, int TipoOfertaSisID, int DuplaConsultora, int CodigoCampania);

        [OperationContract]
        IList<BEOfertaProducto> GetOfertaProductosPortal2(int PaisID, int TipoOfertaSisID, int DuplaConsultora, int CodigoCampania, int Offset, int CantidadRegistros);

        [OperationContract]
        void InsPedidoWebDetalleOferta(BEPedidoWebDetalle pedidowebdetalle);

        [OperationContract]
        void UpdPedidoWebDetalleOferta(BEPedidoWebDetalle pedidowebdetalle);

        [OperationContract]
        int GetStockOfertaProductoLiquidacion(int paisID, int CampaniaID, string CUV);
        [OperationContract]
        int GetUnidadesPermitidasByCuv(int paisID, int CampaniaID, string CUV);

        //[OperationContract]
        //int InsPedidoWebOferta(BEPedidoWeb entity);

        //[OperationContract]
        //int UpdPedidoWebTotalesOferta(BEPedidoWeb entity);

        //[OperationContract]
        //int InsPedidoWebDetalleOferta(BEPedidoWebDetalle entity);

        //[OperationContract]
        //int UpdPedidoWebOferta(BEPedidoWebDetalle entity);

        #region Configuracion Oferta

        [OperationContract]
        int InsConfiguracionOferta(BEConfiguracionOferta entidad);

        [OperationContract]
        int UpdConfiguracionOferta(BEConfiguracionOferta entidad);

        [OperationContract]
        int DelConfiguracionOferta(int PaisID, int ConfiguracionOfertaID);

        [OperationContract]
        IList<BEConfiguracionOferta> GetConfiguracionOfertaAdministracion(int PaisID, int TipoOfertaSisID);

        [OperationContract]
        int ValidarCodigoOfertaAdministracion(int PaisID, string CodigoOferta);

        [OperationContract]
        int ActualizarItemsMostrarLiquidacion(int PaisID, int Cantidad);

        [OperationContract]
        int ObtenerMaximoItemsaMostrarLiquidacion(int PaisID);

        [OperationContract]
        int ValidarUnidadesPermitidasEnPedido(int PaisID, int CampaniaID, string CUV, long ConsultoraID);

        #endregion

        #endregion

        #region CrossSelling

        [OperationContract]
        int InsConfiguracionCrossSelling(BEConfiguracionCrossSelling entity);

        [OperationContract]
        IList<BEConfiguracionCrossSelling> GetConfiguracionCampaniasPorPais(int paisID, int CampaniaID);

        [OperationContract]
        int InsCrossSellingProducto(BECrossSellingProducto entidad);

        [OperationContract]
        int UpdCrossSellingProducto(BECrossSellingProducto entidad);

        [OperationContract]
        int DelCrossSellingProducto(BECrossSellingProducto entidad);

        [OperationContract]
        IList<BECrossSellingProducto> GetCrossSellingProductosAdministracion(int paisID, int CampaniaID);

        [OperationContract]
        IList<BECrossSellingAsociacion> GetCrossSellingAsociacionListado(int PaisID, int CampaniaID, string CUV);

        [OperationContract]
        IList<BECrossSellingAsociacion> GetCUVAsociadoByFilter(int PaisID, int CampaniaID, string CUV, string CodigoSegmento);


        [OperationContract]
        bool DelPedidoWebDetalleMasivo(int PaisID, int CampaniaID, int PedidoID, string CodigoUsuario);

        [OperationContract]
        bool DelPedidoWebDetallePackNueva(int PaisID, long ConsultoraID, int PedidoID);

        [OperationContract]
        IList<BECrossSellingAsociacion> GetDescripcionProductoByCUV(int PaisID, int CampaniaID, string CUV);

        [OperationContract]
        int InsCrossSellingAsociacion(BECrossSellingAsociacion entidad);

        [OperationContract]
        int UpdCrossSellingAsociacion(BECrossSellingAsociacion entidad);

        [OperationContract]
        int DelCrossSellingAsociacion(BECrossSellingAsociacion entidad);

        [OperationContract]
        int DelCrossSellingAsociacion_Perfil(BECrossSellingAsociacion entidad);//1673

        [OperationContract]
        IList<BECrossSellingProducto> GetProductosRecomendadosByCUVCampaniaPortal(int PaisID, long ConsultoraID, int CampaniaID, string CUV);

        [OperationContract]
        int ValidarConfiguracionCrossSelling(int PaisID, int CampaniaID);

        [OperationContract]
        int GetPedidoWebID(int paisID, int campaniaID, long consultoraID);

        [OperationContract]
        IList<BECrossSellingProducto> GetProductosRecomendadosHabilitados(int PaisID, int CampaniaID, int tipo);

        #endregion

        #endregion

        #region Packs Ofertas Nuevas
        [OperationContract]
        IList<BEOfertaNueva> GetOfertasNuevasByCampania(int paisID, int CampaniaID);
        [OperationContract]
        IList<BEOfertaNueva> GetPackOfertasNuevasByCampania(int paisID, int CampaniaID);
        [OperationContract]
        IList<BEOfertaNueva> GetProductosOfertaConsultoraNueva(int paisID, int CampaniaID, int consultoraid);//1487

        [OperationContract]
        BEOfertaNueva GetDescripcionPackByCUV(int paisID, string CUV, int CampaniaCodigo);
        [OperationContract]
        int ValidarOfertasNuevas(BEOfertaNueva oBe);
        [OperationContract]
        int ValidarUnidadesPermitidas(BEOfertaNueva oBe);
        [OperationContract]
        int ObtenerEstadoPacksOfertasNuevas(int PaisID, string CodigoConsultora);
        [OperationContract]
        int ObtenerEstadoPacksOfertasNueva(int PaisID, int idconsultora, int campania);
        [OperationContract]
        int UpdEstadoPacksOfertasNuevas(int PaisID, string CodigoConsultora, int CambioEstado);
        [OperationContract]
        int InsertOfertasNuevas(BEOfertaNueva oBe);
        [OperationContract]
        int UpdOfertasNuevas(BEOfertaNueva oBe);
        [OperationContract]
        int DelOfertasNuevas(BEOfertaNueva oBe, int ConfiguracionOfertaId);
        [OperationContract]
        int UpdEstadoPacksOfertasNueva(int PaisID, int idconsultora, string CodigoConsultora, int campania);

        #endregion

        #region OfertasFlexipago

        [OperationContract]
        IList<BEOfertaFlexipago> GetProductosByOfertaFlexipago(int paisID, int TipoOfertaSisID, int CampaniaID, string CodigoOferta, string CodigoSAP, string CUV, string CategoriaID);

        [OperationContract]
        void GuardarLinksOfertaFlexipago(BEOfertaFlexipago entidad);

        [OperationContract]
        BEOfertaFlexipago GetLinksOfertaFlexipago(int paisID);

        [OperationContract]
        int UpdOfertaFlexipagoStockMasivo(int paisID, List<BEOfertaFlexipago> stockProductos);

        [OperationContract]
        int UpdCategoriaConsultoraMasivo(int paisID, List<BEOfertaFlexipago> stockProductos);

        [OperationContract]
        string GetCategoriaByConsultora(int paisID, int CampaniaID, string CodigoConsultora);

        //[OperationContract]
        //int ValidarPriorizacionFlexipago(int paisID, int ConfiguracionOfertaID, int CampaniaID, int Orden);

        //[OperationContract]
        //int GetOrdenPriorizacionFlexipago(int paisID, int ConfiguracionOfertaID, int CampaniaID);

        [OperationContract]
        int InsOfertaFlexipago(BEOfertaFlexipago entity);

        [OperationContract]
        int UpdOfertaFlexipago(BEOfertaFlexipago entity);

        [OperationContract]
        int DelOfertaFlexipago(BEOfertaFlexipago entity);

        [OperationContract]
        int GetUnidadesPermitidasByCuvFlexipago(int paisID, int CampaniaID, string CUV);

        [OperationContract]
        int ValidarUnidadesPermitidasEnPedidoFlexipago(int PaisID, int CampaniaID, string CUV, long ConsultoraID);

        [OperationContract]
        int GetStockOfertaProductoFlexipago(int paisID, int CampaniaID, string CUV, int TipoOfertaSisID);

        [OperationContract]
        int ObtenerMaximoItemsaMostrarFlexipago(int PaisID);

        [OperationContract]
        int ActualizarItemsMostrarFlexipago(int PaisID, int Cantidad);

        [OperationContract]
        IList<BEOfertaFlexipago> GetOfertaProductosPortalFlexipago(int PaisID, int TipoOfertaSisID, string CodigoConsultora, int CodigoCampania);

        [OperationContract]
        IList<BEOfertaFlexipago> GetCuotasAnterioresFlexipago(int PaisID, string CodigoConsultora, int CampaniaID);

        [OperationContract]
        BEOfertaFlexipago GetLineaCreditoFlexipago(int PaisID, string CodigoConsultora, int CampaniaID);

        [OperationContract]
        bool GetPermisoFlexipago(int PaisID, string CodigoConsultora, int CampaniaID);

        #endregion

        #region PEDIDO FIC

        [OperationContract]
        IList<BEPedidoFICDetalle> SelectFICByCampania(int paisID, int CampaniaID, long ConsultoraID, string Consultora);

        [OperationContract]
        BEPedidoFICDetalle InsertFIC(BEPedidoFICDetalle pedidoficdetalle);

        [OperationContract]
        void UpdPedidoFICDetalle(BEPedidoFICDetalle pedidoficdetalle);

        [OperationContract]
        void DelPedidoFICDetalle(BEPedidoFICDetalle pedidoficdetalle);

        [OperationContract]
        bool DelPedidoFICDetalleMasivo(int PaisID, int CampaniaID, int PedidoID);

        [OperationContract]
        void InsTempServiceProl(int PaisID, DataTable ServicePROL);

        [OperationContract]
        IList<BEServicePROLFIC> GetReportePedidoFIC(int paisID, string CodigoCampania, string CodigoRegion, string CodigoZona, string CodigoConsultora);

        [OperationContract]
        string[] DescargaPedidosFIC(int paisID, DateTime fechaFacturacion, int tipoCronograma, string usuario);
        #endregion

        [OperationContract]
        int GetFechaNoHabilFacturacion(int paisID, string CodigoZona, DateTime Fecha);

        #region Tracking

        [OperationContract]
        List<BETracking> GetPedidosByConsultora(int paisID, string codigoConsultora);

        [OperationContract]
        BETracking GetPedidoByConsultoraAndCampania(int paisID, string codigoConsultora, int campania);

        [OperationContract]
        List<BETracking> GetTrackingByPedido(int paisID, string codigo, string campana, string nropedido);

        #endregion

        #region "CUV Automatico"
        [OperationContract]
        int GetProductoCUVsAutomaticosToInsert(BEPedidoWeb pedidoweb);
        #endregion

        #region "Oferta FIC"
        [OperationContract]
        int GetOfertaFICToInsert(BEPedidoWeb pedidoweb);
        #endregion

        #region "Segmento Planeamiento"
        [OperationContract]
        IList<BESegmentoPlaneamiento> GetSegmentoPlaneamiento(int PaisID, int campaniaId);
        #endregion

        [OperationContract]
        IList<BEPedidoDDWebDetalle> GetPedidoDDDetalle(int paisID, string paisISO, int pedidoID, int CampaniaID, string Consultora, string Origen, bool IndicadorActivo);

        [OperationContract]
        BEPedidoWeb GetPedidoWebByCampaniaConsultora(int paisID, int campaniaID, long consultoraID);

        [OperationContract]
        void AnularPedido(int paisID, int campaniaID, int pedidoID);

        #region Pedidos DD

        [OperationContract]
        BEPedidoDD GetPedidoDDByCampaniaConsultora(int paisID, int campaniaID, long consultoraID);

        [OperationContract]
        void InsPedidoDD(BEPedidoDD bePedidoDD);

        [OperationContract]
        void UpdPedidoDD(BEPedidoDD bePedidoDD);

        [OperationContract]
        void HabiliatPedidoIndividual(int paisID, int campaniaID, long consultoraID, string usuarioDigitador, bool indicadoEnviado);

        [OperationContract]
        bool InsLogPedidoDDInvalido(int paisID, BELogPedidoDDInvalido beLogPedidoDDInvalido);

        [OperationContract]
        IList<BELogPedidoDDInvalido> SelectLogPedidosInvalidos(int paisID, DateTime fechaRegistro);

        [OperationContract]
        void UpdLogPedidoInvalido(int paisID, DateTime fechaRegistro);
        /*GR2089*/
        [OperationContract]
        void InsertarLogPedidoWeb(int PaisID, int CampaniaID, string CodigoConsultora, int PedidoId, string Accion, string CodigoUsuario);
        [OperationContract]
        IList<BEPedidoDD> GetPedidosIngresados(int paisID, string codigoUsuario, DateTime fechaIngreso, string codigoConsultora, int campaniaID, string codigoZona, bool indicadorActivo);

        [OperationContract]
        void UpdPedidoDDDetalle(int paisID, BEPedidoDDDetalle bePedidoDDDetalle);

        [OperationContract]
        void DelPedidoDDDetalle(int paisID, BEPedidoDDDetalle bePedidoDDDetalle);

        [OperationContract]
        BEConfiguracionCampania GetCampaniaActualByZona(int paisID, string codigoZona);

        [OperationContract]
        BEConfiguracionCampania GetConfiguracionCampaniaZona(int paisID, int zonaID, int regionID, long consultoraID);

        #endregion

        [OperationContract]
        void InsPedidoWebAccionesPROL(List<BEPedidoWebDetalle> olstBEPedidoWebDetalle, int Tipo, int Accion);

        #region Asistencia Compartamos

        [OperationContract]
        bool VerificarAsistenciaCompartamos(int paisID, int campaniaID, long consultoraID);

        [OperationContract]
        void RegistrarAsistenciaCompartamos(int paisID, BEAsistenciaCompartamos beAsistenciaCompartamos);

        #endregion
        [OperationContract]
        int UpdVisualizacionPopupProRecom(int consultoraid, int campaniaid, int paisid);

        [OperationContract]
        string HabilitaPedidoMultiple(int paisID, IList<string> infoConsultoras);

        [OperationContract]
        IList<string> HabilitaPedidoMultipleInformacionConsultoras(int paisID, IDictionary<string, string> listaConsultoras);


        [OperationContract]
        BEInformacion GetReporteIntegradoWebDD(int PaisID, string PaisISO, int CampaniaIDInicio, int CampaniaIDFin);
        //ITG 1793
        [OperationContract]
        List<BENovedadTracking> GetNovedadesTracking(int paisID, string NumeroPedido);

        // Req. 1717 - Inicio
        [OperationContract]
        int InsConfirmacionEntrega(int paisID, BEConfirmacionEntrega oBEConfirmacionEntrega);

        [OperationContract]
        int UpdConfirmacionEntrega(int paisID, BEConfirmacionEntrega oBEConfirmacionEntrega);

        //Req. 20150711 
        [OperationContract]
        int InsConfirmacionRecojo(int paisID, BEConfirmacionRecojo oBEConfirmacionRecojo);

        [OperationContract]
        List<BEPostVenta> GetMisPostVentaByConsultora(int paisID, string codigoConsultora);

        [OperationContract]
        List<BEPostVenta> GetSeguimientoPostVenta(int paisID, string numeroRecojo, int estadoId);

        [OperationContract]
        List<BEPostVenta> GetNovedadPostVenta(int paisID, string numeroRecojo);

        // Req. 1747 - Etiqueta
        [OperationContract]
        int InsertarEtiqueta(BEEtiqueta entidad);

        [OperationContract]
        List<BEEtiqueta> GetEtiquetas(BEEtiqueta entidad);

        // R20160301 - Configuracion de packnuevas.
        [OperationContract]
        List<BEConfiguracionPackNuevas> GetConfiguracionPackNuevas(int paisID, string codigoPrograma);

        // Req. 1747 - Oferta
        [OperationContract]
        int InsertarOferta(BEOferta entidad);

        [OperationContract]
        List<BEOferta> GetOfertas(BEOferta entidad);

        // Req. 1747 - TipoEstrategia
        [OperationContract]
        int InsertarTipoEstrategia(BETipoEstrategia entidad);

        [OperationContract]
        int EliminarTipoEstrategia(BETipoEstrategia entidad);

        [OperationContract]
        List<BETipoEstrategia> GetTipoEstrategias(BETipoEstrategia entidad);

        // Req. 1747 - Estrategia
        [OperationContract]
        List<BEEstrategia> GetEstrategias(BEEstrategia entidad);

        [OperationContract]
        List<BETallaColor> GetTallaColor(BETallaColor entidad);

        [OperationContract]
        int InsertarTallaColorCUV(BETallaColor entidad);

        [OperationContract]
        List<BEEstrategia> GetOfertaByCUV(BEEstrategia entidad);

        [OperationContract]
        int InsertarEstrategia(BEEstrategia entidad);

        [OperationContract]
        List<BEEstrategia> FiltrarEstrategia(BEEstrategia entidad);

        [OperationContract]
        int DeshabilitarEstrategia(BEEstrategia entidad);

        [OperationContract]
        int EliminarTallaColor(BETallaColor entidad);

        [OperationContract]
        int ValidarCUVsRecomendados(BEEstrategia entidad);

        [OperationContract]
        List<BEEstrategia> GetEstrategiasPedido(BEEstrategia entidad);

        [OperationContract]
        List<BEEstrategia> FiltrarEstrategiaPedido(BEEstrategia entidad);

        [OperationContract]
        string ValidarStockEstrategia(BEEstrategia entidad);

        [OperationContract]
        int DeleteOferta(BEOferta entidad);

        [OperationContract]
        IList<BEConfiguracionValidacionZE> GetRegionZonaZE(int PaisID, int RegionID, int ZonaID);
        // 1747 - Fin

        //R2004
        [OperationContract]
        BENovedadFacturacion GetPedidoRechazadoByConsultora(int PaisID, string CampaniaId, string CodigoConsultora, DateTime Fecha);

        //R2004
        [OperationContract]
        BENovedadFacturacion GetPedidoAnuladoByConsultora(int PaisID, string CampaniaId, string CodigoConsultora, DateTime Fecha, string NumeroPedido);

        #region PROL AUTO - R2073

        [OperationContract]
        int GetEstadoProcesoPROLAuto(int paisID, DateTime FechaHoraFacturacion);

        [OperationContract]
        List<BEValidacionAutomatica> GetEstadoProcesoPROLAutoDetalle(int paisID);

        [OperationContract]
        BEValidacionMovil InsValidacionMovilPROLLog(BEValidacionMovil oBEValidacionMovil);

        [OperationContract]
        void UpdValidacionMovilPROLLog(BEValidacionMovil oBEValidacionMovil);

        [OperationContract]
        void UpdValAutoPROLPedidoWeb(int PaisId, int CampaniaId, int PedidoId, int EstadoPedido, bool ItemsEliminados, decimal montoTotalProl, decimal descuentoProl);

        [OperationContract]
        void InsPedidoWebAccionesPROLAuto(int PaisId, BEAccionesPROL oBEAccionesPROL);

        [OperationContract]
        void DelPedidoWebDetalleValAuto(int PaisId, int CampaniaID, int PedidoID, int PedidoDetalleID, long ConsultoraID, int MarcaID, string CUV, int Cantidad, decimal PrecioUnidad, DateTime FechaCreacion);

        [OperationContract]
        string GetValidacionMovilPROLLog(BEValidacionMovil oBEValidacionMovil);

        [OperationContract]
        void UpdPedidoWebDetalleObsPROL(int PaisId, int CampaniaId, int PedidoId, int PedidoDetalleId, string ObservacionPROL, bool Tipo);

        [OperationContract]
        List<BEPedidoWebDetalle> GetPedidoWebDetalleValidacionPROL(int PaisId, int CampaniaId, int PedidoId);

        [OperationContract]
        void InsPedidoWebCorreoPROL(int PaisId, long ValAutomaticaPROLLogId, int CampaniaID, int PedidoID);

        #endregion

        /* Req. 1987 - Inicio */
        [OperationContract]
        List<BESuenioNavidad> ListarSuenioNavidad(BESuenioNavidad entidad);

        [OperationContract]
        void RegistrarSuenioNavidad(BESuenioNavidad entidad);

        [OperationContract]
        int ValidarSuenioNavidad(BESuenioNavidad entidad);
        /* Req. 1987 - Fin */

        /* 2108 - Inicio */
        [OperationContract]
        int ValidarUnidadesPermitidasEnPedidoZA(int PaisID, int CampaniaID, string CUV, long ConsultoraID, int TipoOfertaSisID);
        [OperationContract]
        int GetUnidadesPermitidasByCuvZA(int paisID, int CampaniaID, string CUV, int TipoOfertaSisID);
        [OperationContract]
        int ObtenerMaximoItemsaMostrarZA(int PaisID);
        [OperationContract]
        int ActualizarItemsMostrarZA(int PaisID, int Cantidad);
        [OperationContract]
        IList<BEAdministracionOfertaProducto> GetDatosAdmStockMinimoCorreosZA(int paisID, int TipoOfertaSisID);
        [OperationContract]
        int InsAdministracionStockMinimoZA(BEAdministracionOfertaProducto entity);
        [OperationContract]
        int UpdAdministracionStockMinimoZA(BEAdministracionOfertaProducto entity);
        /* 2108 - Fin */

        /* 2024 - Inicio */
        [OperationContract]
        List<BEOfertaProducto> GetTallaColorLiquidacion(BEOfertaProducto entidad);
        [OperationContract]
        int InsertarTallaColorLiquidacion(BEOfertaProducto entidad);
        [OperationContract]
        int EliminarTallaColorLiquidacion(BEOfertaProducto entidad);
        [OperationContract]
        List<BEOfertaProducto> ConsultarLiquidacionByCUV(BEOfertaProducto entidad);
        [OperationContract]
        int CantidadPedidoByConsultora(BEOfertaProducto entidad);
        /* 2024 - Fin */

        //R2154
        [OperationContract]
        int ValidarDesactivaRevistaGana(int paisID, int campaniaID, string codigoZona);

        //2140
        [OperationContract]
        BECUVCredito ValidarCUVCreditoPorCUVRegular(int paisID, string codigoConsultora, string cuv, int campaniaID);

        //2264
        [OperationContract]
        bool InsLogEnvioCorreoPedidoValidado(int paisID, BELogCabeceraEnvioCorreo beLogCabeceraEnvioCorreo, List<BELogDetalleEnvioCorreo> listLogDetalleEnvioCorreo);

        /*RQ 2370 - EC*/
        [OperationContract]
        int RemoverOfertaLiquidacion(BEOfertaProducto entity);

        // R2319 - AHA - Inicio
        [OperationContract]
        BEResultadoSolicitud InsertarSolicitudCliente(string prefijoISO, BEEntradaSolicitudCliente entidadSolicitud);
        // R2319 - AHA - Fin

        [OperationContract]
        BEResultadoSolicitud InsertarSolicitudClienteAppCatalogo(string prefijoISO, BESolicitudClienteAppCatalogo entidadSolicitud);

        #region ShowRoom

        [OperationContract]
        BEShowRoomEvento GetShowRoomEventoByCampaniaID(int paisID, int campaniaID);

        [OperationContract]
        int InsertShowRoomEvento(int paisID, BEShowRoomEvento beShowRoomEvento);

        [OperationContract]
        void UpdateShowRoomEvento(int paisID, BEShowRoomEvento beShowRoomEvento);

        [OperationContract]
        int CargarMasivaConsultora(int paisID, List<BEShowRoomEventoConsultora> listaConsultora);

        [OperationContract]
        int UpdOfertaShowRoomStockMasivo(int paisID, List<BEShowRoomOferta> stockProductos);

        [OperationContract]
        int CargarMasivaDescripcionSets(int paisID, int campaniaID, string usuarioCreacion, List<BEShowRoomOfertaDetalle> listaShowRoomOfertaDetalle);

        [OperationContract]
        BEShowRoomEventoConsultora GetShowRoomConsultora(int paisID, int campaniaID, string codigoConsultora);

        [OperationContract]
        void UpdateShowRoomConsultoraMostrarPopup(int paisID, int campaniaID, string codigoConsultora, bool mostrarPopup);

        [OperationContract]
        IList<BEShowRoomOferta> GetProductosShowRoom(int paisID, int tipoOfertaSisID, int campaniaID, string codigoOferta);

        [OperationContract]
        int GetOrdenPriorizacionShowRoom(int paisID, int ConfiguracionOfertaID, int CampaniaID);

        [OperationContract]
        int ValidarPriorizacionShowRoom(int paisID, int ConfiguracionOfertaID, int CampaniaID, int Orden);

        [OperationContract]
        int InsOfertaShowRoom(int paisID, BEShowRoomOferta entity);

        [OperationContract]
        int UpdOfertaShowRoom(int paisID, BEShowRoomOferta entity);

        [OperationContract]
        int DelOfertaShowRoom(int paisID, BEShowRoomOferta entity);

        [OperationContract]
        int RemoverOfertaShowRoom(int paisID, BEShowRoomOferta entity);

        [OperationContract]
        IList<BEShowRoomOferta> GetShowRoomOfertas(int paisID, int campaniaID);

        [OperationContract]
        int GetUnidadesPermitidasByCuvShowRoom(int paisID, int CampaniaID, string CUV);

        [OperationContract]
        int ValidarUnidadesPermitidasEnPedidoShowRoom(int PaisID, int CampaniaID, string CUV, long ConsultoraID);

        [OperationContract]
        int CantidadPedidoByConsultoraShowRoom(BEOfertaProducto entidad);

        [OperationContract]
        int GetStockOfertaShowRoom(int paisID, int CampaniaID, string CUV);

        [OperationContract]
        int DeshabilitarShowRoomEvento(int paisID, BEShowRoomEvento beShowRoomEvento);

        [OperationContract]
        int EliminarShowRoomEvento(int paisID, BEShowRoomEvento beShowRoomEvento);

        [OperationContract]
        int GuardarImagenShowRoom(int paisID, int eventoId, string nombreImagenFinal, int tipo, string usuarioModificacion);

        [OperationContract]
        IList<BEShowRoomOfertaDetalle> GetProductosShowRoomDetalle(int paisID, int campaniaId, string cuv);

        [OperationContract]
        int InsOfertaShowRoomDetalle(int paisID, BEShowRoomOfertaDetalle entity);

        [OperationContract]
        int UpdOfertaShowRoomDetalle(int paisID, BEShowRoomOfertaDetalle entity);

        [OperationContract]
        int EliminarOfertaShowRoomDetalle(int paisID, BEShowRoomOfertaDetalle beShowRoomOfertaDetalle);

        [OperationContract]
        int EliminarOfertaShowRoomDetalleAll(int paisID, int campaniaID, string cuv);

        [OperationContract]
        IList<BEShowRoomPerfil> GetShowRoomPerfiles(int paisId, int eventoId);

        [OperationContract]
        IList<BEShowRoomPerfilOferta> GetShowRoomPerfilOfertaCuvs(int paisId, BEShowRoomPerfilOferta beShowRoomPerfilOferta);

        [OperationContract]
        void GuardarPerfilOfertaShowRoom(int paisId, int perfilId, int eventoId, int campaniaId, string cadenaCuv);

        [OperationContract]
        IList<BEShowRoomOferta> GetShowRoomOfertasConsultora(int paisID, int campaniaID, string codigoConsultora);

        #endregion

        #region Producto SUgerido

        [OperationContract]
        IList<BEProductoSugerido> GetPaginateProductoSugerido(int PaisID, int CampaniaID, string CUVAgotado, string CUVSugerido);

        [OperationContract]
        IList<BEMatrizComercial> GetImagenesByCUV(int PaisID, int campaniaID, string cuv);

        [OperationContract]
        string InsProductoSugerido(int PaisID, BEProductoSugerido entidad);

        [OperationContract]
        string UpdProductoSugerido(int PaisID, BEProductoSugerido entidad);

        [OperationContract]
        string DelProductoSugerido(int PaisID, BEProductoSugerido entidad);
        #endregion

        #region kit Nuevas

        [OperationContract]
        BEConfiguracionProgramaNuevas GetConfiguracionProgramaNuevas(int paisID, BEConfiguracionProgramaNuevas entidad);

        #endregion

        [OperationContract]
        void UpdateMontosPedidoWeb(BEPedidoWeb bePedidoWeb);

        [OperationContract]
        BEPedidoWeb GetPedidosWebByConsultoraCampania(int paisID, int consultoraID, int campaniaID);

        [OperationContract]
        List<BEPedidoWeb> GetPedidosFacturados(int paisId, string codigoConsultora);

        [OperationContract]
        List<BEPedidoWeb> GetPedidosIngresadoFacturado(int paisID, int consultoraID, int campaniaID);
        
        [OperationContract]
        BEConsultorasProgramaNuevas GetConsultorasProgramaNuevas(int paisID, BEConsultorasProgramaNuevas entidad);

        [OperationContract]
        List<BEMensajeMetaConsultora> GetMensajeMetaConsultora(int paisID, BEMensajeMetaConsultora entidad);

        [OperationContract]
        string GetImagenOfertaPersonalizadaOF(int paisID, int campaniaID, string cuv);
    }
}
