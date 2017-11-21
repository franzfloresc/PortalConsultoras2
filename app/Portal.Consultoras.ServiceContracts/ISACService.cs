﻿using System;
using System.Collections.Generic;
using System.ServiceModel;
using Portal.Consultoras.Entities;
using System.Data;
using Portal.Consultoras.Entities.Mobile;

namespace Portal.Consultoras.ServiceContracts
{
    [ServiceContract]
    public interface ISACService
    {
        #region Cronograma
        [OperationContract]
        IList<BECronograma> GetCronogramaByCampania(int paisID, int CampaniaID, int ZonaID, Int16 TipoCronogramaID);

        [OperationContract]
        int MigrarCronogramaAnticipado(int paisID, int CampaniaID, int ZonaID);

        [OperationContract]
        bool GetCronogramaAutomaticoActivacion(int paisID);

        [OperationContract]
        int GetCampaniaFacturacionPais(int paisID);

        #endregion

        #region Cronograma Anticipado

        [OperationContract]
        IList<BECronograma> GetCronogramaByCampaniaAnticipado(int paisID, int CampaniaID, int ZonaID, Int16 TipoCronogramaID);

        [OperationContract]
        int InsertCronogramaAnticipado(BECronograma cronograma);

        [OperationContract]
        void UpdateCronogramaAnticipado(BECronograma cronograma);

        [OperationContract]
        void DeleteCronogramaAnticipado(BECronograma cronograma);

        [OperationContract]
        BECronograma GetCronogramaByCampaniayZona(int paisID, int CampaniaID, int ZonaID);

        [OperationContract]
        int InsConfiguracionConsultoraDA(int paisID, BEConfiguracionConsultoraDA configuracionConsultoraDA);

        [OperationContract]
        int GetConfiguracionConsultoraDA(int paisID, BEConfiguracionConsultoraDA configuracionConsultoraDA);

        [OperationContract]
        int GetCronogramaDA(int paisID, DateTime fechaFacturacion);

        #endregion

        #region Producto Faltante
        [OperationContract]
        void InsProductoFaltante(int paisID, string paisISO, string CodigoUsuario, IList<BEProductoFaltante> productosFaltantes, bool FaltanteUltimoMinuto);

        [OperationContract]
        bool DelProductoFaltante(int paisID, string paisISO, string CodigoUsuario, BEProductoFaltante productoFaltante);

        [OperationContract]
        int DelProductoFaltante2(int paisID, string paisISO, string CodigoUsuario, IList<BEProductoFaltante> prod, int flag, int pais, int campania, int zona, string cuv, string e_producto, DateTime fecha);

        [OperationContract]
        IList<BEProductoFaltante> GetProductoFaltanteByEntity(int paisID, BEProductoFaltante productofaltante, string ColumnaOrden, string Ordenamiento, int PaginaActual, int FlagPaginacion, int RegistrosPorPagina);

        [OperationContract]
        IList<BEProductoFaltante> GetProductoFaltanteByCampaniaAndZonaID(int paisID, int CampaniaID, int ZonaID, string cuv, string descripcion);

        [OperationContract]
        string InsProductoFaltanteMasivo(int paisID, string paisISO, string CodigoUsuario, int campaniaID, IList<BEProductoFaltante> productosFaltantes, bool FaltanteUltimoMinuto);

        [OperationContract]
        void InsLogIngresoFAD(int PaisID, int CampaniaId, long ConsultoraId, string CUV, int Cantidad, decimal PrecioUnidad, int ZonaId);

        #endregion

        #region ConfiguracionValidacionZona

        [OperationContract]
        IList<BEConfiguracionValidacionZona> GetCampaniasActivas(int paisID, int campaniaID);

        [OperationContract]
        void InsConfiguracionValidacionZona(BEConfiguracionValidacion ent, List<BEConfiguracionValidacionZona> lista);

        [OperationContract]
        void UpdConfiguracionValidacionZona(BEConfiguracionValidacion ent, List<BEConfiguracionValidacionZona> lista);
        [OperationContract]
        void DelConfiguracionValidacionZona(int paisID, int CampaniaID);

        #endregion

        #region ConfiguracionValidacion

        [OperationContract]
        IList<BEConfiguracionValidacion> GetConfiguracionValidacion(int paisID, int CampaniaID);
        [OperationContract]
        void InsertConfiguracionValidacion(BEConfiguracionValidacion entidad);
        [OperationContract]
        void UpdateConfiguracionValidacion(BEConfiguracionValidacion entidad);

        #endregion

        #region ProductoDescripcion

        [OperationContract]
        List<BEProductoDescripcion> GetProductoDescripcionByCUVandCampania(int paisID, int campaniaID, string CUV);

        [OperationContract]
        void UpdProductoDescripcion(BEProductoDescripcion producto, string codigoUsuario);

        #endregion

        #region Oferta Web

        [OperationContract]
        IList<BEOfertaWeb> GetOfertaWebByCampania(int PaisID, int CampaniaID, int PedidoID, long ConsultoraID);

        #endregion

        #region ConsultoraFicticia

        [OperationContract]
        int InsConsultoraFicticia(BEConsultoraFicticia BEConsultoraFicticia);

        [OperationContract]
        IList<BEConsultoraFicticia> SelectConsultoraFicticia(int paisID, string CodigoUsuario, string NombreCompleto);

        [OperationContract]
        void DelConsultoraFicticia(int paisID, string CodigoConsultora);

        [OperationContract]
        void UpdConsultoraFicticia(string CodigoUsuario, string CodigoConsultora, int paisID, Int64 ConsultoraID, string Clave);

        [OperationContract]
        string GetCodigoConsultoraAsociada(int paisID, string CodigoUsuario);

        [OperationContract]
        string GetNombreConsultoraAsociada(int paisID, string CodigoUsuario);
        #endregion

        #region DatosBelcorp

        [OperationContract]
        IList<BEDatosBelcorp> GetDatosBelcorp(int paisID);

        #endregion

        #region ActualizacionFacturacion
        [OperationContract]
        IList<BELogActualizacionFacturacion> LogActualizacionFacturacion(int paisID);

        [OperationContract]
        IList<BELogActualizacionFacturacion> UpdLogActualizacionFacturacion(int paisID, string CampaniaCodigo, string Codigos, int Tipo, DateTime FechaFacturacion, DateTime FechaReFacturacion, string CodigoUsuario);

        [OperationContract]
        void UpdateCronogramaDD(int paisID, string CampaniaCodigo, string Codigos, int Tipo, DateTime FechaFacturacion, DateTime FechaFinFacturacion, DateTime FechaReFacturacion, string CodigoUsuario);

        [OperationContract]
        void InsCronogramaDemandaAnticipadaDD(int paisID, string CampaniaCodigo, string ZonaCodigo, DateTime FechaFacturacion, DateTime FechaReFacturacion);

        [OperationContract]
        void UpdCronogramaDemandaAnticipadaDD(int paisID, string CampaniaCodigo, string ZonaCodigo, DateTime FechaFacturacion, DateTime FechaReFacturacion);

        [OperationContract]
        void DelCronogramaDemandaAnticipadaDD(int paisID, string ZonaCodigo);
        #endregion

        #region Servicios
        [OperationContract]
        IList<BEServicio> GetServicios(string Descripcion);
        [OperationContract]
        IList<BEServicioCampania> GetServicioByCampaniaPais(int PaisId, int CampaniaId);
        [OperationContract]
        IList<BEServicioCampania> GetServicioByCampaniaPaisAdministrador(int PaisId, int CampaniaId);
        [OperationContract]
        IList<BEEstadoServicio> GetEstadoServiciobyPais(int ServicioId, int CampaniaId);
        [OperationContract]
        IList<BEServicioParametro> GetParametrosbyServicio(int ServicioId);

        [OperationContract]
        int InsServicio(BEServicio servicio);
        [OperationContract]
        int UpdServicio(BEServicio servicio);
        [OperationContract]
        int DelServicio(int ServicioId);
        [OperationContract]
        int DelServicioParametro(int ServicioId, int ParametroId);
        [OperationContract]
        int InsServicioParametro(int ServicioId, int ParametroId);
        [OperationContract]
        int InsServicioCampania(int CampaniaId, int ServicioId, string CodigoISO);
        [OperationContract]
        int InsServicioCampaniaRango(int CampaniaId, int CampaniaFinalId, int ServicioId, string CodigoISO);
        [OperationContract]
        int DelServicioCampania(int CampaniaId, int ServicioId, string CodigoISO);
        [OperationContract]
        int DelServicioCampaniaRango(int CampaniaId, int CampaniaFinalId, int ServicioId, string CodigoISO);
        #endregion

        #region Parametros
        [OperationContract]
        IList<BEParametro> SelectParametros();

        #endregion

        #region Factor de Ganancia

        [OperationContract]
        IList<BEFactorGanancia> SelectFactorGanancia(int paisID);

        [OperationContract]
        IList<BEFactorGanancia> GetFactorGananciaById(int paisID);

        [OperationContract]
        int InsertFactorGanancia(BEFactorGanancia entidad);

        [OperationContract]
        int UpdateFactorGanancia(BEFactorGanancia entidad);

        [OperationContract]
        void DeleteFactorGanancia(int paisID, int factorGananciaID);

        [OperationContract]
        IList<BEFactorGanancia> GetFactorGananciaByPaisRango(decimal monto, int paisId);

        [OperationContract]
        IList<BEPedidoWebDetalleDescuento> GetIndicadorDescuentoByPedidoWebDetalle(int paisID, int campaniaId, int pedidoId);

        [OperationContract]
        void UpdatePedidoWebEstimadoGanancia(int paisID, int campaniaId, int pedidoId, decimal estimadoGanancia);

        [OperationContract]
        BEFactorGanancia GetFactorGananciaSiguienteEscala(decimal monto, int paisID);

        [OperationContract]
        BEFactorGanancia GetFactorGananciaEscalaDescuento(decimal monto, int paisID);

        #endregion

        #region Modificacion Cronograma
        [OperationContract]
        IList<BEConfiguracionValidacionZona> GetRegionZonaDiasDuracionCronograma(int PaisID, int RegionID, int ZonaID);
        [OperationContract]
        void UpdConfiguracionValidacionZonaCronograma(int paisID, List<BEConfiguracionValidacionZona> listaEntidades);
        [OperationContract]
        IList<BELogModificacionCronograma> GetLogModificacionCronograma(int PaisID);
        [OperationContract]
        void InsLogModificacionCronogramaMasivo(int paisID, string CodigoUsuario, List<BELogModificacionCronograma> listaEntidades);

        [OperationContract]
        void InsLogConfiguracionCronogramaMasivo(int paisID, string CodigoUsuario, List<BELogConfiguracionCronograma> listaEntidades);

        [OperationContract]
        BEConfiguracionValidacionZona GetConfiguracionValidacionZona(int paisID, int campaniaID, int zonaID);
        #endregion

        #region Lugares de Pago

        [OperationContract]
        IList<BELugarPago> SelectLugarPago(int paisID);

        [OperationContract]
        BELugarPago GetLugarPagoById(int paisID, int lugarPagoID);

        [OperationContract]
        int InsertLugarPago(BELugarPago entidad);

        [OperationContract]
        int UpdateLugarPago(BELugarPago entidad);

        [OperationContract]
        void DeleteLugarPago(int paisID, int lugarPagoID);

        #endregion

        #region Incentivos

        [OperationContract]
        IList<BEIncentivo> SelectIncentivos(int paisID, int campaniaID);

        [OperationContract]
        void InsertIncentivo(BEIncentivo entidad);

        [OperationContract]
        void UpdateIncentivo(BEIncentivo entidad);

        [OperationContract]
        void DeleteIncentivo(int paisID, int incentivoID);

        #endregion

        #region Belcorp Noticias

        [OperationContract]
        IList<BEBelcorpNoticia> SelectBelcorpNoticias(int paisID, int campaniaID);

        [OperationContract]
        BEBelcorpNoticia GetBelcorpNoticiaById(int paisID, int belcorpNoticiaID);

        [OperationContract]
        void InsertBelcorpNoticia(BEBelcorpNoticia entidad);

        [OperationContract]
        void UpdateBelcorpNoticia(BEBelcorpNoticia entidad);

        [OperationContract]
        void DeleteBelcorpNoticia(int paisID, int belcorpNoticiaID);

        #endregion

        #region Tabla Logica Datos
        [OperationContract]
        List<BETablaLogicaDatos> GetTablaLogicaDatos(int paisID, Int16 TablaLogicaID);
        #endregion

        #region "Fe de Erratas"

        [OperationContract]
        IList<BEFeErratas> SelectFeErratas(int paisID, int campaniaID);

        [OperationContract]
        void InsertFeErratas(BEFeErratas entidad);

        [OperationContract]
        void UpdateFeErratas(BEFeErratas entidad);

        [OperationContract]
        void DeleteFeErratas(int paisID, int feErratasID);

        [OperationContract]
        IList<BEFeErratas> SelectFeErratasEntradas(int paisID, int campaniaID, string titulo);

        [OperationContract]
        void SaveChangesFeErratas(int paisID, List<BEFeErratas> erratasUpdate, List<BEFeErratas> erratasDel);

        #endregion

        #region "CUV Automatico"
        [OperationContract]
        void InsCuvAutomatico(int paisID, IList<BECUVAutomatico> cuvautomatico);

        [OperationContract]
        IList<BECUVAutomatico> GetProductoCuvAutomatico(int paisID, BECUVAutomatico cuvautomatico, string ColumnaOrden,
                                                        string Ordenamiento, int PaginaActual, int FlagPaginacion,
                                                        int RegistrosPorPagina);

        [OperationContract]
        bool DelCUVAutomatico(int paisID, BECUVAutomatico cuvautomatico);

        #endregion

        #region "Oferta FIC"
        [OperationContract]
        void InsOfertaFIC(int paisID, IList<BEOfertaFIC> ofertaFIC);

        [OperationContract]
        IList<BEOfertaFIC> GetProductoOfertaFIC(int paisID, BEOfertaFIC cuvautomatico, string ColumnaOrden,
                                                        string Ordenamiento, int PaginaActual, int FlagPaginacion,
                                                        int RegistrosPorPagina);

        [OperationContract]
        bool DelOfertaFIC(int paisID, BEOfertaFIC cuvautomatico);

        #endregion

        #region "Banner en Pase de Pedido"
        [OperationContract]
        IList<BEBannerPedido> SelectBannerPedido(int paisID, int campaniaID);

        [OperationContract]
        void InsertBannerPedido(BEBannerPedido entidad);

        [OperationContract]
        void UpdateBannerPedido(BEBannerPedido entidad);


        [OperationContract]
        void DeleteBannerPedido(int paisID, int BannerPedidoID);
        #endregion

        #region SolicitudCredito

        [OperationContract]
        IList<BESolicitudCredito> GetSolicitudCreditos(BESolicitudCredito objSolCredito);

        [OperationContract]
        BESolicitudCredito ValidarSolicitudPendiente(int paisID, string numeroDocumento);

        [OperationContract]
        int InsertarSolicitudCredito(int paisID, BESolicitudCredito beSolicitudCredito);

        [OperationContract]
        IList<BECiudad> GetCiudades(int paisID, string codigoRegion);

        [OperationContract]
        IList<BESolicitudCredito> BuscarSolicitudCredito(int paisID, string codigoZona, string codigoTerritorio, DateTime? fechaInicioSolicitud, DateTime? fechaFinSolicitud, string numeroDocumento, int estadoSolicitud, string TipoSolicitud, string CodigoConsultora);

        [OperationContract]
        BESolicitudCredito BuscarSolicitudCreditoPorID(int paisID, int solicitudCreditoID);

        [OperationContract]
        BESolicitudCredito ObtenerInfoActDatos(int paisID, string codigoConsultora);

        [OperationContract]
        string[] DescargaSolicitudes(int paisID, string codigoUsuario);

        [OperationContract]
        DataTable ReporteSolidCreditDia(int paisID, string codigoRegion, DateTime? fechaInicioSolicitud, DateTime? fechaFinSolicitud);

        #endregion

        #region Comunicado

        [OperationContract]
        BEComunicado GetComunicadoByConsultora(int paisID, string CodigoConsultora);

        [OperationContract]
        List<BEComunicado> ObtenerComunicadoPorConsultora(int PaisID, string CodigoConsultora, short TipoDispositivo);

        [OperationContract]
        List<BEPopupPais> ObtenerOrdenPopUpMostrar(int PaisID);
        [OperationContract]
        void UpdComunicadoByConsultora(int paisID, string CodigoConsultora);

        [OperationContract]
        void InsertarComunicadoVisualizado(int PaisID, string CodigoConsultora, int ComunicadoID);
        
        [OperationContract]
        void InsertarDonacionConsultora(int PaisId, string CodigoISO, string CodigoConsultora, string Campania, string IPUsuario);
        #endregion

        #region Estado Cuenta

        [OperationContract]
        List<BEEstadoCuenta> GetEstadoCuentaConsultora(int PaisId, long consultoraId);

        #endregion

        #region Pedidos Facturados

        [OperationContract]
        List<BEPedidoFacturado> GetPedidosFacturadosCabecera(int PaisId, string CodigoConsultora);

        [OperationContract]
        List<BEPedidoFacturado> GetPedidosFacturadosDetalle(int PaisId, string Campania, string Region, string Zona, string CodigoConsultora, int pedidoId);

        #endregion

        #region Configuracion Validacion Nuevo PROL

        [OperationContract]
        IList<BEConfiguracionValidacionNuevoPROL> GetConfiguracionValidacionNuevoPROL(int PaisID, int TipoPROL);
        [OperationContract]
        int InsConfiguracionValidacionNuevoPROL(int PaisID, string Usuario, IList<BEConfiguracionValidacionNuevoPROL> ZonasNuevoPROL);

        #endregion

        #region Configuracion Tipo Proceso Carga Pedidos
        [OperationContract]
        IList<BEConfiguracionTipoProcesoCargaPedidos> GetConfiguracionTipoProcesoCargaPedidos(int PaisID, int TipoPROL);
        [OperationContract]
        int InsConfiguracionTipoProcesoCargaPedidos(int PaisID, string Usuario, IList<BEConfiguracionTipoProcesoCargaPedidos> ZonasNuevoPROL);
        #endregion

        #region ConfiguracionParametroCarga

        [OperationContract]
        IList<BEConfiguracionParametroCarga> GetCampaniasActivasConfiguracionParametroCarga(int paisID, int campaniaID);

        [OperationContract]
        void InsConfiguracionParametroCarga(BEConfiguracionValidacion ent, List<BEConfiguracionParametroCarga> lista);

        [OperationContract]
        void UpdConfiguracionParametroCarga(BEConfiguracionValidacion ent, List<BEConfiguracionParametroCarga> lista);

        [OperationContract]
        void DelConfiguracionParametroCarga(int paisID, int CampaniaID);

        #endregion

        #region ParametroDiasCargaPedido

        [OperationContract]
        IList<BEConfiguracionParametroCarga> GetRegionZonaDiasParametroCarga(int PaisID, int RegionID, int ZonaID);

        [OperationContract]
        void UpdConfiguracionParametroCargaPedido(int paisID, List<BEConfiguracionParametroCarga> listaEntidades);

        [OperationContract]
        IList<BELogParametroDiasCargaPedido> GetLogParametroDiasCargaPedido(int PaisID);

        [OperationContract]
        void InsLogParametroDiasCargaPedido(int paisID, string CodigoUsuario, List<BELogParametroDiasCargaPedido> listaEntidades);

        #endregion

        [OperationContract]
        IList<BEConfiguracionPortal> GetConfiguracionPortal(int paisID);

        #region Participantes Demanada Anticipada - R20160302

        [OperationContract]
        IList<BEParticipantesDemandaAnticipada> GetParticipantesConfiguracionConsultoraDA(int PaisID, string CodigoCampania, string CodigoConsultora);

        [OperationContract]
        int InsParticipantesDemandaAnticipada(int paisID, BEParticipantesDemandaAnticipada participantesDemandaAnticipada);

        [OperationContract]
        BEParticipantesDemandaAnticipada GetConsultoraByCodigo(int paisID, string CodigoConsultora);

        #endregion

        [OperationContract]
        void DeleteCacheServicio(string CodigoISO, int CampaniaId);

        [OperationContract]
        BEServicioSegmentoZona GetServicioCampaniaSegmentoZona(int ServicioId, int CampaniaId, int PaisId);

        [OperationContract]
        List<BEServicioSegmentoZona> GetServicioCampaniaSegmentoZonaAsignados(int ServicioId, int PaisId, int Tipo);

        [OperationContract]
        void UpdServicioCampaniaSegmentoZona(int ServicioId, int CampaniaId, int PaisId, int Segmento, string ConfiguracionZona, string SegmentoInternoId);

        [OperationContract]
        int DelProductoFaltanteMasivo(int paisID, int campaniaID, string zona, string cuv, string fecha, string descripcion);

        [OperationContract]
        List<BETablaLogicaDatos> ListarColoniasByTerritorio(int paisID, string codigo);

        [OperationContract]
        string ValidarNumeroRFC(int paisID, string numeroRFC);

        #region Cliente Busca Consultora

        [OperationContract]
        BEAfiliaClienteConsultora GetAfiliaClienteConsultoraByConsultora(int paisID, string ConsultoraID);

        [OperationContract]
        int InsAfiliaClienteConsultora(int paisID, long ConsultoraID);

        [OperationContract]
        int UpdAfiliaClienteConsultora(int paisID, long ConsultoraID, bool EsAfiliacion);

        [OperationContract]
        int UpdDesafiliaClienteConsultora(int paisID, long ConsultoraID, bool EsAfiliacion, int MotivoDesafiliacionID);

        #endregion

        [OperationContract]
        BESolicitudCliente GetSolicitudCliente(int paisID, long SolicitudClienteId);

        [OperationContract]
        List<BESolicitudClienteDetalle> GetSolicitudClienteDetalle(int paisID, long SolicitudClienteId);

        [OperationContract]
        void UpdSolicitudCliente(int paisID, BESolicitudCliente entidadSolicitud);

        [OperationContract]
        void UpdSolicitudClienteDetalle(int paisID, BESolicitudClienteDetalle entidadSolicitudDetalle);

        [OperationContract]
        void RechazarSolicitudCliente(int paisID, long solicitudId, bool definitivo, int opcionRechazo, string razonMotivoRechazo);

        [OperationContract]
        BESolicitudNuevaConsultora ReasignarSolicitudCliente(int paisID, long solicitudId, string codigoUbigeo, string campania, int marcaId, int OpcionRechazo, string RazonMotivoRechazo);

        [OperationContract]
        void CancelarSolicitudCliente(int paisID, long solicitudId, int opcionCancelacion, string razonMotivoCancelacion);
        
        [OperationContract]
        void CancelarSolicitudClienteYRemoverPedido(int paisID, int campaniaID, long consultoraID, string codigoUsuario, long solicitudId, int opcionCancelacion, string razonMotivoCancelacion);

        [OperationContract]
        List<BEMotivoSolicitud> GetMotivosRechazo(int paisID);

        [OperationContract]
        int EnviarSolicitudClienteaGZ(int paisID, BESolicitudCliente entidadSolicitudCliente);

        [OperationContract]
        List<BESolicitudCliente> BuscarSolicitudAnuladasRechazadas(int paisID, BESolicitudCliente entidadSolicitudCliente);

        [OperationContract]
        BESolicitudCliente DetalleSolicitudAnuladasRechazadas(int paisID, BESolicitudCliente entidadSolicitudCliente);

        [OperationContract]
        BEConfiguracionPortal ObtenerConfiguracionPortal(BEConfiguracionPortal beoConfiguracionPortal);

        [OperationContract]
        int ActualizarConfiguracionPortal(BEConfiguracionPortal beoConfiguracionPortal);

        #region Descarga Curso Lider
        [OperationContract]
        void GetInformacionCursoLiderDescarga(int PaisId, string PaisISO, string FechaProceso, string Usuario);
        #endregion
        [OperationContract]
        List<BEEstadoSolicitudCliente> GetEstadoSolicitudCliente(int paisID);

        [OperationContract]
        List<BEReporteAfiliados> GetReporteAfiliados(int paisID, DateTime FechaInicio, DateTime FechaFin);

        [OperationContract]
        List<BEReportePedidos> GetReportePedidos(DateTime FechaInicio, DateTime FechaFin, int estado, string marca, string campania, int paisID);

        [OperationContract]
        void GetConsultoraDigitalesDescarga(int PaisId, string PaisISO, string FechaProceso, string Usuario);

        [OperationContract]
        BEPaisCampana GetCampaniaActivaPais(int paisID, DateTime fechaConsulta);

        [OperationContract]
        DateTime GetFechaHoraPais(int paisID);

        [OperationContract]
        List<BEProveedorDespachoCobranza> GetProveedorDespachoCobranza(int paisID);

        [OperationContract]
        int DelProveedorDespachoCobranza(int paisID, int ProveedorDespachoCobanzaID);

        [OperationContract]
        void UpdProveedorDespachoCobranzaCabecera(int paisID, BEProveedorDespachoCobranza entidad);

        [OperationContract]
        void InsProveedorDespachoCobranzaCabecera(int paisID, BEProveedorDespachoCobranza entidad);

        [OperationContract]
        void MntoCampoProveedorDespachoCobranza(BEProveedorDespachoCobranza entidad, int accion, int campoid, string valor, string valorAntiguo);

        [OperationContract]
        List<BEProveedorDespachoCobranza> GetProveedorDespachoCobranzaMnto(int paisID, BEProveedorDespachoCobranza entity);

        [OperationContract]
        List<BEProveedorDespachoCobranza> GetProveedorDespachoCobranzaBYiD(int paisID, BEProveedorDespachoCobranza entity);
        
        [OperationContract]
        bool EnviarProactivaChatbot(string paisISO, string urlRelativa, List<BEChatbotProactivaMensaje> listMensajeProactiva);

        [OperationContract]
        List<BEPedidoFacturado> GetPedidosFacturadosDetalleMobile(int PaisId, int CampaniaID, long ConsultoraID, short ClienteID, string CodigoConsultora);

        [OperationContract]
        int UpdateClientePedidoFacturado(int paisID, int codigoPedido, int ClienteID);

        [OperationContract]
        string GetCampaniaActualAndSiguientePais(int paisID, string codigoISO);
        
        [OperationContract]
        IList<BEApp> ListarApps(int paisID);

        #region ConfiguracionPais
        [OperationContract]
        List<BEConfiguracionPais> ListConfiguracionPais(int paisId, bool tienePerfil);

        [OperationContract]
        BEConfiguracionPais GetConfiguracionPais(int paisId, int configuracionPaisId);

        [OperationContract]
        void UpdateConfiguracionPais(BEConfiguracionPais configuracionPais);
        #endregion

        #region ConfiguracionOfertasHome
        [OperationContract]
        List<BEConfiguracionOfertasHome> ListConfiguracionOfertasHome(int paisId, int campaniaId);

        [OperationContract]
        BEConfiguracionOfertasHome GetConfiguracionOfertasHome(int paisId, int configuracionOfertasHomeId);

        [OperationContract]
        void UpdateConfiguracionOfertasHome(BEConfiguracionOfertasHome configuracionOfertasHome);

        [OperationContract]
        IList<BEConfiguracionOfertasHome> ListarSeccionConfiguracionOfertasHome(int paisId, int campaniaId);
        #endregion

        #region DescripcionEstrategia
        [OperationContract]
        List<BEDescripcionEstrategia> ActualizarDescripcionEstrategia(int paisId, int campaniaId, int tipoEstrategiaId,
            List<BEDescripcionEstrategia> listaDescripcionEstrategias);
        #endregion
    }
}