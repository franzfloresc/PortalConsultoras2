using Portal.Consultoras.Entities;
using Portal.Consultoras.Entities.CargaMasiva;
using Portal.Consultoras.Entities.Cupon;
using Portal.Consultoras.Entities.Estrategia;
using Portal.Consultoras.Entities.Pedido;
using Portal.Consultoras.Entities.Pedido.App;
using Portal.Consultoras.Entities.ReservaProl;
using Portal.Consultoras.Entities.RevistaDigital;
using Portal.Consultoras.Entities.ShowRoom;
using Estrategia = Portal.Consultoras.Entities.Estrategia;
using Portal.Consultoras.Entities.PagoEnLinea;

using System;
using System.Collections.Generic;
using System.Data;
using System.ServiceModel;
using System.Threading.Tasks;

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
        BEPedidoWebResult InsertPedido(BEPedidoWebDetalleInvariant pedidoDetalle);

        [OperationContract]
        void DelPedidoWebDetalle(BEPedidoWebDetalle pedidowebdetalle);

        [OperationContract]
        IList<BEPedidoWebDetalle> SelectByCampania(BEPedidoWebDetalleParametros bePedidoWebDetalleParametros);

        [OperationContract]
        IList<BEPedidoDDWeb> SelectPedidosDDWeb(BEPedidoDDWeb BEPedidoDDWeb);

        [OperationContract]
        IList<BEPedidoDDWebDetalle> SelectPedidosDDWebDetalleByCampaniaPedido(int paisID, int CampaniaID, int PedidoID);

        [OperationContract]
        IList<BEPedidoWebDetalle> SelectByOfertaWeb(int paisID, int CampaniaID, long ConsultoraID, bool OfertaWeb);

        [OperationContract]
        int ValidarCargadePedidos(int paisID, int TipoCronograma, int MarcaPedido, DateTime FechaFactura);

        [OperationContract]
        string[] DescargaPedidosWeb(int paisID, DateTime fechaFacturacion, int tipoCronograma, bool marcarPedido, string usuario, string descripcionProceso);

        [OperationContract]
        string[] DescargaPedidosDD(int paisID, DateTime fechaFacturacion, int tipoCronograma, bool marcarPedido, string usuario);

        [OperationContract]
        int ValidarCuvDescargado(int paisID, int anioCampania, string codigoVenta, string codigoConsultora);

        [OperationContract]
        BEConfiguracionCampania GetEstadoPedido(int PaisID, int CampaniaID, long ConsultoraID, int ZonaID, int RegionID);

        [OperationContract]
        List<BEEscalaDescuento> GetEscalaDescuento(int PaisID);

        [OperationContract]
        List<BEEscalaDescuento> GetParametriaOfertaFinal(int paisID, string algoritmo);

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
        void AceptarBackOrderPedidoWebDetalle(BEPedidoWebDetalle pedidowebdetalle);

        [OperationContract]
        void UpdBackOrderListPedidoWebDetalle(int paisID, int campaniaID, int pedidoID, List<BEPedidoWebDetalle> listPedidoWebDetalle);

        [OperationContract]
        void QuitarBackOrderPedidoWebDetalle(BEPedidoWebDetalle pedidowebdetalle);

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
        int InsMatrizComercialImagen(BEMatrizComercialImagen entity);

        [OperationContract]
        int UpdMatrizComercialImagen(BEMatrizComercialImagen entity);

        [OperationContract]
        int UpdMatrizComercialNemotecnico(BEMatrizComercialImagen entity);

        [OperationContract]
        int UpdMatrizComercialDescripcionComercial(BEMatrizComercialImagen entity);

        [OperationContract]
        IList<BEMatrizComercial> GetMatrizComercialByCodigoSAP(int paisID, string codigoSAP);

        [OperationContract]
        IList<BEMatrizComercial> GetImagenesByCodigoSAP(int paisID, string codigoSAP);

        [OperationContract]
        IList<BEMatrizComercialImagen> GetImagenByNemotecnico(int paisID, int idMatrizImagen, string cuv2, string codigoSAP, int estrategiaID, int campaniaID, int tipoEstrategiaID, string nemotecnico, int tipoBusqueda, int numeroPagina, int registros);

        [OperationContract]
        IList<BEMatrizComercialImagen> GetMatrizComercialImagenByIdMatrizImagen(int paisID, int idMatrizComercial, int pagina, int registros);

        [OperationContract]
        IList<BEMatrizComercialImagen> GetImagenesByCodigoSAPPaginado(int paisID, string codigoSAP, int pagina, int registros);

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
        Task<bool> DelPedidoWebDetalleMasivo(BEUsuario usuario, int pedidoId);

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
        int DelCrossSellingAsociacion_Perfil(BECrossSellingAsociacion entidad);

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
        IList<BEOfertaNueva> GetProductosOfertaConsultoraNueva(int paisID, int CampaniaID, int consultoraid);

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
        List<BETracking> GetPedidosByConsultora(int paisID, string codigoConsultora, int top);

        [OperationContract]
        BETracking GetPedidoByConsultoraAndCampania(int paisID, string codigoConsultora, int campania);

        [OperationContract]
        BETracking GetPedidoByConsultoraAndCampaniaAndNroPedido(int paisID, string codigoConsultora, int campania, string nroPedido);

        [OperationContract]
        List<BETracking> GetTrackingByPedido(int paisID, string codigo, string campana, string nropedido);

        [OperationContract]
        List<BETracking> GetTrackingPedidoByConsultora(int paisID, string codigoConsultora, int top);

        [OperationContract]
        List<BETracking> GetPedidosByConsultoraDocumento(int paisID, string codigoConsultora, int top, int tipoDoc = 0);

        [OperationContract]
        List<BETracking> GetTrackingByPedidoConsultoraDocumento(int paisID, string codigo, string campana, string nropedido, int tipoDoc = 0);

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
        BEPedidoWeb GetResumenPedidoWebByCampaniaConsultora(int paisID, int campaniaID, long consultoraID);

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
        [OperationContract]
        void InsertarLogPedidoWeb(int PaisID, int CampaniaID, string CodigoConsultora, int PedidoId, string Accion, string CodigoUsuario);

        [OperationContract]
        void InsLogOfertaFinal(int PaisID, BEOfertaFinalConsultoraLog entidad);

        [OperationContract]
        void InsLogOfertaFinalBulk(int PaisID, List<BEOfertaFinalConsultoraLog> lista);

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
        [OperationContract]
        List<BENovedadTracking> GetNovedadesTracking(int paisID, string NumeroPedido);

        [OperationContract]
        int InsConfirmacionEntrega(int paisID, BEConfirmacionEntrega oBEConfirmacionEntrega);

        [OperationContract]
        int UpdConfirmacionEntrega(int paisID, BEConfirmacionEntrega oBEConfirmacionEntrega);

        [OperationContract]
        int InsConfirmacionRecojo(int paisID, BEConfirmacionRecojo oBEConfirmacionRecojo);

        [OperationContract]
        List<BEPostVenta> GetMisPostVentaByConsultora(int paisID, string codigoConsultora);

        [OperationContract]
        List<BEPostVenta> GetSeguimientoPostVenta(int paisID, string numeroRecojo, int estadoId);

        [OperationContract]
        List<BEPostVenta> GetNovedadPostVenta(int paisID, string numeroRecojo);

        [OperationContract]
        int InsertarEtiqueta(BEEtiqueta entidad);

        [OperationContract]
        List<BEEtiqueta> GetEtiquetas(BEEtiqueta entidad);

        [OperationContract]
        List<BEConfiguracionPackNuevas> GetConfiguracionPackNuevas(int paisID, string codigoPrograma);

        [OperationContract]
        int InsertarOferta(BEOferta entidad);

        [OperationContract]
        List<BEOferta> GetOfertas(BEOferta entidad);

        [OperationContract]
        int InsertarTipoEstrategia(BETipoEstrategia entidad);

        [OperationContract]
        int EliminarTipoEstrategia(BETipoEstrategia entidad);

        [OperationContract]
        List<BETipoEstrategia> GetTipoEstrategias(BETipoEstrategia entidad);

        [OperationContract]
        List<BEEstrategia> GetEstrategias(BEEstrategia entidad);

        [OperationContract]
        BEEstrategiaDetalle GetEstrategiaDetalle(int paisID, int estrategiaID);

        [OperationContract]
        List<BETallaColor> GetTallaColor(BETallaColor entidad);

        [OperationContract]
        int InsertarTallaColorCUV(BETallaColor entidad);

        [OperationContract]
        List<BEEstrategia> GetOfertaByCUV(BEEstrategia entidad);

        [OperationContract]
        int InsertarEstrategia(BEEstrategia entidad);

        [OperationContract]
        List<int> InsertarEstrategiaMasiva(BEEstrategiaMasiva entidad);

        [OperationContract]
        List<int> InsertarProductoShowroomMasiva(BEEstrategiaMasiva entidad);
        [OperationContract]
        List<string> ObtenerListadoCuvCupon(int paisId, int campaniaId);

        [OperationContract]
        List<BEEstrategia> FiltrarEstrategia(BEEstrategia entidad);

        [OperationContract]
        List<BEMatrizComercialImagen> GetImagenesByEstrategiaMatrizComercialImagen(BEEstrategia entidad, int pagina, int registros);

        [OperationContract]
        int DeshabilitarEstrategia(BEEstrategia entidad);
        [OperationContract]
        int EliminarEstrategia(BEEstrategia entidad);
        [OperationContract]
        int EliminarTallaColor(BETallaColor entidad);

        [OperationContract]
        int ValidarCUVsRecomendados(BEEstrategia entidad);

        [OperationContract]
        List<BEEstrategia> FiltrarEstrategiaPedido(BEEstrategia entidad);

        [OperationContract]
        string ValidarStockEstrategia(BEEstrategia entidad);

        [OperationContract]
        int DeleteOferta(BEOferta entidad);

        [OperationContract]
        IList<BEConfiguracionValidacionZE> GetRegionZonaZE(int PaisID, int RegionID, int ZonaID);

        [OperationContract]
        BENovedadFacturacion GetPedidoRechazadoByConsultora(int PaisID, string CampaniaId, string CodigoConsultora, DateTime Fecha);

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

        [OperationContract]
        List<BESuenioNavidad> ListarSuenioNavidad(BESuenioNavidad entidad);

        [OperationContract]
        void RegistrarSuenioNavidad(BESuenioNavidad entidad);

        [OperationContract]
        int ValidarSuenioNavidad(BESuenioNavidad entidad);

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

        [OperationContract]
        int ValidarDesactivaRevistaGana(int paisID, int campaniaID, string codigoZona);

        [OperationContract]
        BECUVCredito ValidarCUVCreditoPorCUVRegular(int paisID, string codigoConsultora, string cuv, int campaniaID);

        [OperationContract]
        bool InsLogEnvioCorreoPedidoValidado(int paisID, BELogCabeceraEnvioCorreo beLogCabeceraEnvioCorreo, List<BELogDetalleEnvioCorreo> listLogDetalleEnvioCorreo);

        [OperationContract]
        int RemoverOfertaLiquidacion(BEOfertaProducto entity);

        [OperationContract]
        BEResultadoSolicitud InsertarSolicitudCliente(string prefijoISO, BEEntradaSolicitudCliente entidadSolicitud);

        [OperationContract]
        BEResultadoSolicitud InsertarSolicitudClienteAppCatalogo(string prefijoISO, BESolicitudClienteAppCatalogo entidadSolicitud);

        [OperationContract]
        BEResultadoMisPedidosAppCatalogo GetPedidosAppCatalogo(string prefijoISO, long consultoraID, string dispositivoID, int tipoUsuario, int campania);

        [OperationContract]
        BEResultadoPedidoDetalleAppCatalogo GetPedidoDetalleAppCatalogo(string prefijoISO, long pedidoID);

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
        int CargarProductoCpc(int paisId, int eventoId, string usuarioCreacion, List<BEShowRoomCompraPorCompra> listaShowRoomCompraPorCompra);

        [OperationContract]
        BEShowRoomEventoConsultora GetShowRoomConsultora(int paisID, int campaniaID, string codigoConsultora, bool tienePersonalizacion);

        [OperationContract]
        void UpdateShowRoomConsultoraMostrarPopup(int paisID, int campaniaID, string codigoConsultora, bool mostrarPopup);

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
        int EliminarEstrategiaProductoAll(int paisID, int estrategiaID, string usuario);

        [OperationContract]
        IList<BEShowRoomPerfil> GetShowRoomPerfiles(int paisId, int eventoId);

        [OperationContract]
        void GuardarPerfilOfertaShowRoom(int paisId, int perfilId, int eventoId, int campaniaId, string cadenaCuv);

        [OperationContract]
        BEShowRoomOferta GetShowRoomOfertaById(int paisID, int ofertaShowRoomID);

        [OperationContract]
        IList<BEShowRoomNivel> GetShowRoomNivel(int paisId);

        [OperationContract]
        IList<BEShowRoomPersonalizacion> GetShowRoomPersonalizacion(int paisId);

        [OperationContract]
        IList<BEShowRoomPersonalizacionNivel> GetShowRoomPersonalizacionNivel(int paisId, int eventoId, int nivelId, int categoriaId);

        [OperationContract]
        int InsertShowRoomPersonalizacionNivel(int paisId, BEShowRoomPersonalizacionNivel beShowRoomPersonalizacionNivel);

        [OperationContract]
        int UpdateShowRoomPersonalizacionNivel(int paisId, BEShowRoomPersonalizacionNivel beShowRoomPersonalizacionNivel);

        [OperationContract]
        List<BEShowRoomCategoria> GetShowRoomCategorias(int paisId, int eventoId);

        [OperationContract]
        BEShowRoomCategoria GetShowRoomCategoriaById(int paisId, int categoriaId);

        [OperationContract]
        void UpdateShowRoomDescripcionCategoria(int paisId, BEShowRoomCategoria categoria);

        [OperationContract]
        void DeleteInsertShowRoomCategoriaByEvento(int paisId, int eventoId, List<BEShowRoomCategoria> listaCategoria);

        [OperationContract]
        IList<BEShowRoomTipoOferta> GetShowRoomTipoOferta(int paisID);

        [OperationContract]
        int ExisteShowRoomTipoOferta(int paisId, BEShowRoomTipoOferta entity);

        [OperationContract]
        int InsertShowRoomTipoOferta(int paisId, BEShowRoomTipoOferta entity);

        [OperationContract]
        int UpdateShowRoomTipoOferta(int paisId, BEShowRoomTipoOferta entity);

        [OperationContract]
        void HabilitarShowRoomTipoOferta(int paisId, BEShowRoomTipoOferta entity);

        #endregion

        #region Producto SUgerido

        [OperationContract]
        IList<BEProductoSugerido> GetPaginateProductoSugerido(int PaisID, int CampaniaID, string CUVAgotado, string CUVSugerido);

        [OperationContract]
        BEMatrizComercial GetMatrizComercialByCampaniaAndCUV(int paisID, int campaniaID, string cuv);

        [OperationContract]
        string InsProductoSugerido(int PaisID, BEProductoSugerido entidad);

        [OperationContract]
        string UpdProductoSugerido(int PaisID, BEProductoSugerido entidad);

        [OperationContract]
        string DelProductoSugerido(int PaisID, BEProductoSugerido entidad);
        #endregion

        #region kit Nuevas

        [OperationContract]
        BEConfiguracionProgramaNuevas GetConfiguracionProgramaNuevas(BEUsuario usuario);

        [OperationContract]
        string GetCuvKitNuevas(BEUsuario usuario, BEConfiguracionProgramaNuevas confProgNuevas);

        #endregion

        [OperationContract]
        void UpdateMontosPedidoWeb(BEPedidoWeb bePedidoWeb);

        [OperationContract]
        BEPedidoWeb GetPedidosWebByConsultoraCampania(int paisID, int consultoraID, int campaniaID);

        [OperationContract]
        List<BEPedidoWeb> GetPedidosFacturados(int paisId, string codigoConsultora);

        [OperationContract]
        List<BEPedidoWeb> GetPedidosIngresadoFacturado(int paisID, int consultoraID, int campaniaID, string codigoConsultora, int top);

        [OperationContract]
        List<BEPedidoWeb> GetPedidosIngresadoFacturadoWebMobile(int paisID, int consultoraID, int campaniaID, int clienteID, int top, string codigoConsultora);

        [OperationContract]
        List<BEPedidoWeb> GetPedidosIngresadoFacturadoApp(int paisID, int consultoraID, int campaniaID, string codigoConsultora, int usuarioPrueba, string consultoraAsociada, int top);

        [OperationContract]
        BEConsultorasProgramaNuevas GetConsultorasProgramaNuevas(int paisID, BEConsultorasProgramaNuevas entidad);

        [OperationContract]
        List<BEMensajeMetaConsultora> GetMensajeMetaConsultora(int paisID, BEMensajeMetaConsultora entidad);

        [OperationContract]
        string GetImagenOfertaPersonalizadaOF(int paisID, int campaniaID, string cuv);

        [OperationContract]
        BEProcesoPedidoRechazado ObtenerProcesoPedidoRechazadoGPR(int paisID, int campaniaID, long consultoraID);

        [OperationContract]
        List<BEPedidoWeb> GetPedidosFacturadoSegunDias(int paisID, int campaniaID, long consultoraID, int maxDias);
        [OperationContract]
        void ActualizarIndicadorGPRPedidosRechazados(int PaisID, long ProcesoID);

        [OperationContract]
        void ActualizarIndicadorGPRPedidosFacturados(int PaisID, long ProcesoID);

        [OperationContract]
        BEPedidoDescarga ObtenerUltimaDescargaPedido(int PaisID);

        [OperationContract]
        void DeshacerUltimaDescargaPedido(int PaisID);
        [OperationContract]
        BEPedidoDescarga ObtenerUltimaDescargaExitosa(int PaisID);

        [OperationContract]
        int ActivarDesactivarEstrategias(int PaisID, string Usuario, string EstrategiasActivas, string EstrategiasDesactivas);

        [OperationContract]
        int InsertarEstrategiaProducto(BEEstrategiaProducto entidad);

        [OperationContract]
        int ActualizarEstrategiaProducto(BEEstrategiaProducto entidad);

        [OperationContract]
        bool EliminarEstrategiaProducto(BEEstrategiaProducto entidad);

        [OperationContract]
        List<BEEstrategiaProducto> GetEstrategiaProducto(BEEstrategia entidad);

        [OperationContract]
        int UpdEventoConsultoraPopup(int paisID, BEShowRoomEventoConsultora entity, string tipo);

        [OperationContract]
        int ShowRoomProgramarAviso(int paisID, BEShowRoomEventoConsultora entity);

        [OperationContract]
        BEValidacionModificacionPedido ValidacionModificarPedido(int paisID, long consultoraID, int campania, bool usuarioPrueba, int aceptacionConsultoraDA);

        [OperationContract]
        BEValidacionModificacionPedido ValidacionModificarPedidoSelectiva(int paisID, long consultoraID, int campania, bool usuarioPrueba, int aceptacionConsultoraDA, bool validarGPR, bool validarReservado, bool validarHorario);

        [OperationContract]
        int UpdShowRoomEventoConsultoraEmailRecibido(int paisID, BEShowRoomEventoConsultora entity);

        [OperationContract]
        bool GetEventoConsultoraRecibido(int paisID, string CodigoConsultora, int CampaniaID);

        [OperationContract]
        string GetTokenIndicadorPedidoAutentico(int paisID, string paisISO, string codigoRegion, string codigoZona);

        [OperationContract]
        int InsIndicadorPedidoAutentico(int paisID, BEIndicadorPedidoAutentico entidad);

        [OperationContract]
        BEConsultoraRegaloProgramaNuevas GetConsultoraRegaloProgramaNuevas(int paisID, int campaniaId, string codigoConsultora, int consecutivoNueva);

        [OperationContract]
        Task<BEResultadoReservaProl> CargarSesionAndEjecutarReservaProl(string paisISO, int campania, long consultoraID, bool usuarioPrueba, int aceptacionConsultoraDA, bool esMovil, bool enviarCorreo);

        [OperationContract]
        Task<BEResultadoReservaProl> EjecutarReservaProl(BEInputReservaProl input);

        [OperationContract]
        bool EnviarCorreoReservaProl(BEInputReservaProl input);

        [OperationContract]
        int RDSuscripcion(BERevistaDigitalSuscripcion entidad);

        [OperationContract]
        int RDDesuscripcion(BERevistaDigitalSuscripcion entidad);

        [OperationContract]
        BERevistaDigitalSuscripcion RDGetSuscripcion(BERevistaDigitalSuscripcion entidad);

        [OperationContract]
        BERevistaDigitalSuscripcion RDGetSuscripcionActiva(BERevistaDigitalSuscripcion entidad);

        [OperationContract]
        int InsertarDesglose(BEInputReservaProl input);

        [OperationContract]
        string CargarSesionAndDeshacerPedidoValidado(string paisISO, int campania, long consultoraID, bool usuarioPrueba, int aceptacionConsultoraDA, string tipo);

        [OperationContract]
        string DeshacerPedidoValidado(BEUsuario usuario, string tipo);

        [OperationContract]
        Task<bool> DeshacerReservaPedido(BEUsuario usuario, int pedidoId);

        [OperationContract]
        BEConsultoraResumen ObtenerResumen(int paisId, int codigoCampania, long consultoraId);

        #region Cupon

        [OperationContract]
        BECuponConsultora GetCuponConsultoraByCodigoConsultoraCampaniaId(int paisId, BECuponConsultora cuponConsultora);

        [OperationContract]
        void UpdateCuponConsultoraEstadoCupon(int paisId, BECuponConsultora cuponConsultora);

        [OperationContract]
        void UpdateCuponConsultoraEnvioCorreo(int paisId, BECuponConsultora cuponConsultora);

        [OperationContract]
        void CrearCupon(int paisId, BECupon cupon);

        [OperationContract]
        void ActualizarCupon(int paisId, BECupon cupon);

        [OperationContract]
        List<BEReporteValidacionSRCampania> GetReporteShowRoomCampania(int paisID, int campaniaID);

        [OperationContract]
        List<BECupon> ListarCuponesPorCampania(int paisId, int campaniaId);

        #endregion

        #region Cupon Consultora

        [OperationContract]
        List<BEReporteValidacionSRPersonalizacion> GetReporteShowRoomPersonalizacion(int paisID, int campaniaID);

        [OperationContract]
        void CrearCuponConsultora(int paisId, BECuponConsultora cuponConsultora);

        [OperationContract]
        void ActualizarCuponConsultora(int paisId, BECuponConsultora cuponConsultora);

        [OperationContract]
        List<BECuponConsultora> ListarCuponConsultorasPorCupon(int paisId, int cuponId);

        [OperationContract]
        void InsertarCuponConsultorasXML(int paisId, int cuponId, int campaniaId, List<BECuponConsultora> listaCuponConsultoras);

        [OperationContract]
        List<BEReporteValidacion> GetReporteValidacion(int paisID, int campaniaID, int tipoEstrategia);
        #endregion

        #region Incentivos
        [OperationContract]
        List<BEIncentivoConcurso> ObtenerConcursosXConsultora(BEUsuario usuario);

        [OperationContract]
        void ActualizarInsertarPuntosConcurso(int PaisID, string CodigoConsultora, string CodigoCampania, string CodigoConcursos, string PuntosConcursos, string PuntosExigidosConcurso);

        [OperationContract]
        List<BEConsultoraConcurso> ObtenerPuntosXConsultoraConcurso(int PaisID, string CodigoCampania, string CodigoConcursoPuntos);

        [OperationContract]
        List<BEConsultoraConcurso> ListConcursosVigentes(int paisId, string codigoCampania, string codigoConsultora);

        [OperationContract]
        List<BEConsultoraConcurso> ListConcursosByCampania(int paisId, string codigoCampaniaActual, string codigoCampania, string tipoConcurso, string codigoConsultora);
        [OperationContract]
        List<BEIncentivoConcurso> ObtenerIncentivosConsultora(int paisID, string codigoConsultora, int codigoCampania, long ConsultoraID, bool estrategia);
        [OperationContract]
        List<BEIncentivoConcurso> ObtenerIncentivosHistorico(int paisID, string codigoConsultora, int codigoCampania);
        #endregion

        #region Producto Comentario
        [OperationContract]
        int InsertarProductoComentarioDetalle(int paisID, BEProductoComentarioDetalle entidad);

        [OperationContract]
        BEProductoComentario GetProductoComentarioByCodigoSap(int paisID, string codigoSap);

        [OperationContract]
        BEProductoComentarioDetalle GetUltimoProductoComentarioByCodigoSap(int paisID, string codigoSap);

        [OperationContract]
        List<BEProductoComentarioDetalle> GetListaProductoComentarioDetalleResumen(int paisID, BEProductoComentarioFilter filter);

        [OperationContract]
        List<BEProductoComentarioDetalle> GetListaProductoComentarioDetalleAprobar(int paisID, BEProductoComentarioFilter filter);

        [OperationContract]
        int AprobarProductoComentarioDetalle(int paisID, BEProductoComentarioDetalle entidad);
        #endregion

        #region FichaProducto
        [OperationContract]
        List<BEFichaProducto> GetFichaProducto(BEFichaProducto entidad);

        #endregion

        #region MisPedidos
        [OperationContract]
        List<BEMisPedidosCampania> GetMisPedidosByCampania(int paisID, long ConsultoraID, int CampaniaID, int ClienteID, int Top);
        [OperationContract]
        List<BEMisPedidosIngresados> GetMisPedidosIngresados(int paisID, long ConsultoraID, int CampaniaID, int ClienteID, string NombreConsultora);
        [OperationContract]
        List<BEMisPedidosFacturados> GetMisPedidosFacturados(int paisID, long ConsultoraID, int CampaniaID, int ClienteID, string NombreConsultora);
        #endregion
        
        #region ProductosPrecargados
        [OperationContract]
        int GetFlagProductosPrecargados(int paisID, string CodigoConsultora, int CampaniaID);

        [OperationContract]
        void UpdateMostradoProductosPrecargados(int paisID, int CampaniaID, long ConsultoraID, string IPUsuario);
        #endregion

        #region ConfiguracionProgramaNuevasApp
        [OperationContract]
        List<Estrategia.BEConfiguracionProgramaNuevasApp> GetConfiguracionProgramaNuevasApp(Estrategia.BEConfiguracionProgramaNuevasApp entidad);
        [OperationContract]
        bool InsConfiguracionProgramaNuevasApp(Estrategia.BEConfiguracionProgramaNuevasApp entidad);
        #endregion

        #region Certificado Digital
        [OperationContract]
        bool TieneCampaniaConsecutivas(int paisId, int campaniaId, int cantidadCampaniaConsecutiva, long consultoraId);

        [OperationContract]
        BEMiCertificado ObtenerCertificadoDigital(int paisId, int campaniaId, long consultoraId, Int16 tipoCert);

        #endregion

        #region PedidoApp
        [OperationContract]
        BEProductoApp GetCUVApp(BEProductoAppBuscar productoBuscar);
        [OperationContract]
        BEPedidoDetalleAppResult InsertPedidoDetalleApp(BEPedidoDetalleApp pedidoDetalle);
        [OperationContract]
        BEPedidoWeb GetPedidoApp(BEUsuario usuario);
        [OperationContract]
        bool InsertKitInicio(BEUsuario usuario);
        [OperationContract]
        BEPedidoDetalleAppResult UpdatePedidoDetalleApp(BEPedidoDetalleApp pedidoDetalle);
        [OperationContract]
        BEConfiguracionPedido GetConfiguracionPedidoApp(int paisID, string codigoUsuario);
        [OperationContract]
        Task<BEPedidoDetalleAppResult> DeletePedidoDetalleApp(BEPedidoDetalleApp pedidoDetalle);
        [OperationContract]
        Task<BEPedidoReservaAppResult> ReservaPedidoDetalleApp(BEUsuario usuario);
        [OperationContract]
        BEPedidoDetalleAppResult DeshacerReservaPedidoApp(BEUsuario usuario);
        [OperationContract]
        List<BEEstrategia> GetEstrategiaCarrusel(BEUsuario usuario);
        [OperationContract]
        BEUsuario GetConfiguracionOfertaFinal(BEUsuario usuario);
        [OperationContract]
        List<BEProducto> GetProductoSugerido(BEProductoAppBuscar productoBuscar);
        #endregion

        #region Pago en Linea
        [OperationContract]
        int InsertPagoEnLineaResultadoLog(int paisId, BEPagoEnLineaResultadoLog entidad);

        [OperationContract]
        string ObtenerTokenTarjetaGuardadaByConsultora(int paisId, string codigoConsultora);

        [OperationContract]
        void UpdateMontoDeudaConsultora(int paisId, string codigoConsultora, decimal montoDeuda);

        [OperationContract]
        BEPagoEnLineaResultadoLog ObtenerPagoEnLineaById(int paisId, int pagoEnLineaResultadoLogId);

        [OperationContract]
        BEPagoEnLineaResultadoLog ObtenerUltimoPagoEnLineaByConsultoraId(int paisId, long consultoraId);

        [OperationContract]
        List<BEPagoEnLineaResultadoLogReporte> ObtenerPagoEnLineaByFiltro(int paisId, BEPagoEnLineaFiltro filtro);

        [OperationContract]
        List<BEPagoEnLineaTipoPago> ObtenerPagoEnLineaTipoPago(int paisId);

        [OperationContract]
        List<BEPagoEnLineaMedioPago> ObtenerPagoEnLineaMedioPago(int paisId);

        [OperationContract]
        List<BEPagoEnLineaMedioPagoDetalle> ObtenerPagoEnLineaMedioPagoDetalle(int paisId);

        [OperationContract]
        List<BEPagoEnLineaTipoPasarela> ObtenerPagoEnLineaTipoPasarelaByCodigoPlataforma(int paisId, string codigoPlataforma);

        [OperationContract]
        List<BEPagoEnLineaPasarelaCampos> ObtenerPagoEnLineaPasarelaCampos(int paisId);

        [OperationContract]
        int ObtenerPagoEnLineaNumeroOrden(int paisId);
        #endregion

        [OperationContract]
        bool InsertPedidoWebSet(int paisID, int Campaniaid, int PedidoID, int CantidadSet, string CuvSet, long ConsultoraId, string CodigoUsuario, string CuvsStringList, int EstrategiaId);


        [OperationContract]
        bool UpdCantidadPedidoWebSet(int paisId, int setId, int cantidad);

        [OperationContract]
        List<BEPedidoWebSetDetalle> GetPedidoWebSetDetalle(int paisID, int campania, long consultoraId);

        [OperationContract]
        BEPedidoWebSet ObtenerPedidoWebSet(int paisId, int setId);

        [OperationContract]
        bool EliminarPedidoWebSet(int paisId, int setId);

        [OperationContract]
        DateTime? ObtenerFechaInicioSets(int paisId);

        [OperationContract]
        void DescargaPedidosCliente(int paisID, int nroLote, string codigoUsuario);
        
        [OperationContract]
        bool LimpiarCacheRedis(int paisID, string codigoTipoEstrategia, string campaniaID);
        
        [OperationContract]
        List<BEPedidoWebDetalle> ObtenerCuvSetDetalle(int paisID,int campaniaID, long consultoraID, int pedidoID, string ListaSet);

        [OperationContract]
        List<BEReporteValidacionSROferta> GetReporteShowRoomOferta(int paisID, int campaniaID);

        [OperationContract]
        List<BEReporteValidacionSRComponentes> GetReporteShowRoomComponentes(int paisID, int campaniaID);
        
        [OperationContract]
        BEEstrategia GetEstrategiaPremiosTippingPoint(int paisID, string codigoPrograma, int anioCampana, string codigoNivel);
        
        [OperationContract]
        BEActivarPremioNuevas GetActivarPremioNuevas(int paisID, string codigoPrograma, int anioCampana, string codigoNivel);

        [OperationContract]
        List<BEEstrategiaProducto> GetEstrategiaProductoList(int PaisID, string idList);

    }
}