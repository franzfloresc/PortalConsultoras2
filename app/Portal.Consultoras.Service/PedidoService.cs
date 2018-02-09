﻿using Portal.Consultoras.BizLogic;
using Portal.Consultoras.BizLogic.RevistaDigital;
using Portal.Consultoras.Entities;
using Portal.Consultoras.Entities.Cupon;
using Portal.Consultoras.Entities.ReservaProl;
using Portal.Consultoras.Entities.RevistaDigital;
using Portal.Consultoras.Entities.ShowRoom;
using Portal.Consultoras.ServiceContracts;
using Portal.Consultoras.Entities.Pedido;
using Estrategia = Portal.Consultoras.Entities.Estrategia;

using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.ServiceModel;
using Portal.Consultoras.Entities.CargaMasiva;
using Portal.Consultoras.Common;
using Portal.Consultoras.Entities.PagoEnLinea;
using Portal.Consultoras.BizLogic.PagoEnlinea;

namespace Portal.Consultoras.Service
{
    public class PedidoService : IPedidoService
    {
        private BLPedidoWebDetalle BLPedidoWebDetalle;
        private BLPedidoWeb BLPedidoWeb;
        private BLPedidoReporteLider BLPedidoReporteLider;
        private BLOfertaNueva BLOfertaNueva;
        private BLPedidoFICDetalle BLPedidoFICDetalle;
        private BLTracking BLTracking;
        private BLCuv oBLCUV;
        private BLSegmentoPlaneamiento oBLSegmentoPlaneamiento;
        private BLPedidoDD BLPedidoDD;
        private BLLogPedidoDDInvalido BLLogPedidoDDInvalido;
        private BLPedidoDDDetalle BLPedidoDDDetalle;
        private BLValidacionAutomatica BLValidacionAutomatica;
        private BLShowRoomEvento BLShowRoomEvento;
        private BLProductoSugerido BLProductoSugerido;
        private BLConfiguracionProgramaNuevas BLConfiguracionProgramaNuevas;
        private BLEscalaDescuento BLEscalaDescuento;
        private BLConsultorasProgramaNuevas BLConsultorasProgramaNuevas;
        private BLMensajeMetaConsultora BLMensajeMetaConsultora;
        private BLProcesoPedidoRechazado BLProcesoPedidoRechazado;
        private BLCupon BLCupon;
        private BLEstrategia blEstrategia;        
        private BLRevistaDigitalSuscripcion BLRevistaDigitalSuscripcion;
        private BLCuponConsultora BLCuponConsultora;
        private BLFichaProducto blFichaProducto;
        private BLPagoEnLinea BLPagoEnLinea;

        private readonly IConsultoraConcursoBusinessLogic _consultoraConcursoBusinessLogic;
        private readonly IPedidoWebBusinessLogic _pedidoWebBusinessLogic;
        private readonly IConfiguracionProgramaNuevasBusinessLogic _configuracionProgramaNuevasBusinessLogic;
        private readonly ITrackingBusinessLogic _trackingBusinessLogic;

        public PedidoService() : this(new BLConsultoraConcurso(), new BLPedidoWeb(), new BLConfiguracionProgramaNuevas(), new BLTracking())
        {
            BLPedidoWebDetalle = new BLPedidoWebDetalle();
            BLPedidoWeb = new BLPedidoWeb();
            BLPedidoReporteLider = new BLPedidoReporteLider();
            BLOfertaNueva = new BLOfertaNueva();
            BLPedidoFICDetalle = new BLPedidoFICDetalle();
            BLTracking = new BLTracking();
            oBLCUV = new BLCuv();
            oBLSegmentoPlaneamiento = new BLSegmentoPlaneamiento();
            BLPedidoDD = new BLPedidoDD();
            BLLogPedidoDDInvalido = new BLLogPedidoDDInvalido();
            BLPedidoDDDetalle = new BLPedidoDDDetalle();
            BLValidacionAutomatica = new BLValidacionAutomatica();
            BLShowRoomEvento = new BLShowRoomEvento();
            BLProductoSugerido = new BLProductoSugerido();
            BLConfiguracionProgramaNuevas = new BLConfiguracionProgramaNuevas();
            BLEscalaDescuento = new BLEscalaDescuento();
            BLConsultorasProgramaNuevas = new BLConsultorasProgramaNuevas();
            BLMensajeMetaConsultora = new BLMensajeMetaConsultora();
            BLProcesoPedidoRechazado = new BLProcesoPedidoRechazado();
            BLCupon = new BLCupon();
            blEstrategia = new BLEstrategia();
            BLRevistaDigitalSuscripcion = new BLRevistaDigitalSuscripcion();
            BLCuponConsultora = new BLCuponConsultora();
            blFichaProducto = new BLFichaProducto();
            BLPagoEnLinea = new BLPagoEnLinea();
        }

        public PedidoService(IConsultoraConcursoBusinessLogic consultoraConcursoBusinessLogic, IPedidoWebBusinessLogic pedidoWebBusinessLogic,
            IConfiguracionProgramaNuevasBusinessLogic configuracionProgramaNuevasBusinessLogic, ITrackingBusinessLogic trackingBusinessLogic)
        {
            _consultoraConcursoBusinessLogic = consultoraConcursoBusinessLogic;
            _pedidoWebBusinessLogic = pedidoWebBusinessLogic;
            _configuracionProgramaNuevasBusinessLogic = configuracionProgramaNuevasBusinessLogic;
            _trackingBusinessLogic = trackingBusinessLogic;
        }

        #region Reporte Lider

        public BEPedidoReporteLiderIndicador GetPedidosReporteLiderIndicador(int paisID, long ConsultoraLiderID, string CodigoPais, string CodigoCampaniaActual)
        {
            return BLPedidoReporteLider.GetPedidosReporteLiderIndicador(paisID, ConsultoraLiderID, CodigoPais, CodigoCampaniaActual);
        }

        public IList<BEPedidoReporteLiderListado> GetPedidosReporteLiderPedidosValidados(int paisID, long ConsultoraLiderID, string CodigoPais, string CodigoCampaniaActual)
        {
            return BLPedidoReporteLider.GetPedidosReporteLiderPedidosValidados(paisID, ConsultoraLiderID, CodigoPais, CodigoCampaniaActual);
        }

        public IList<BEPedidoReporteLiderListado> GetPedidosReporteLiderPedidosNoValidados(int paisID, long ConsultoraLiderID, string CodigoPais, string CodigoCampaniaActual)
        {
            return BLPedidoReporteLider.GetPedidosReporteLiderPedidosNoValidados(paisID, ConsultoraLiderID, CodigoPais, CodigoCampaniaActual);
        }

        public IList<BEPedidoReporteLiderListado> GetPedidosReporteLiderPedidosRechazados(int paisID, long ConsultoraLiderID, string CodigoPais, string CodigoCampaniaActual)
        {
            return BLPedidoReporteLider.GetPedidosReporteLiderPedidosRechazados(paisID, ConsultoraLiderID, CodigoPais, CodigoCampaniaActual);
        }

        public IList<BEPedidoReporteLiderListado> GetPedidosReporteLiderPedidosFacturados(int paisID, long ConsultoraLiderID, string CodigoPais, string CodigoCampaniaActual)
        {
            return BLPedidoReporteLider.GetPedidosReporteLiderPedidosFacturados(paisID, ConsultoraLiderID, CodigoPais, CodigoCampaniaActual);
        }
        #endregion

        public BEPedidoWebDetalle Insert(BEPedidoWebDetalle pedidowebdetalle)
        {
            return BLPedidoWebDetalle.InsPedidoWebDetalle(pedidowebdetalle);
        }

        public BEPedidoWebResult InsertPedido(BEPedidoWebDetalleInvariant pedidoDetalle)
        {
            return BLPedidoWebDetalle.InsertPedido(pedidoDetalle);
        }

        public IList<BEPedidoWebDetalle> SelectByCampania(BEPedidoWebDetalleParametros bePedidoWebDetalleParametros)
        {            
            return BLPedidoWebDetalle.GetPedidoWebDetalleByCampania(bePedidoWebDetalleParametros);
        }

        public void DelPedidoWebDetalle(BEPedidoWebDetalle pedidowebdetalle)
        {
            BLPedidoWebDetalle.DelPedidoWebDetalle(pedidowebdetalle);
        }

        public IList<BEPedidoDDWeb> SelectPedidosDDWeb(BEPedidoDDWeb BEPedidoDDWeb)
        {
            return BLPedidoWeb.GetPedidosDDWeb(BEPedidoDDWeb);
        }

        public IList<BEPedidoDDWebDetalle> SelectPedidosDDWebDetalleByCampaniaPedido(int paisID, int CampaniaID, int PedidoID)
        {
            return BLPedidoWebDetalle.GetPedidosDDWebDetalleByCampaniaPedido(paisID, CampaniaID, PedidoID);
        }

        public IList<BEPedidoWebDetalle> SelectByOfertaWeb(int paisID, int CampaniaID, long ConsultoraID, bool OfertaWeb)
        {
            return BLPedidoWebDetalle.GetPedidoWebDetalleByOfertaWeb(paisID, CampaniaID, ConsultoraID, OfertaWeb);
        }

        public string[] DescargaPedidosWeb(int paisID, DateTime fechaFacturacion, int tipoCronograma, bool marcarPedido, string usuario, string descripcionProceso)
        {
            try
            {
                return BLPedidoWeb.DescargaPedidosWeb(paisID, fechaFacturacion, tipoCronograma, marcarPedido, usuario, descripcionProceso);
            }
            catch (BizLogicException ex)
            {
                throw new FaultException(ex.Message);
            }
            catch (Exception)
            {
                throw new FaultException("Error desconocido.");
            }
        }
        public string[] DescargaPedidosDD(int paisID, DateTime fechaFacturacion, int tipoCronograma, bool marcarPedido, string usuario)
        {
            try
            {
                return BLPedidoWeb.DescargaPedidosDD(paisID, fechaFacturacion, tipoCronograma, marcarPedido, usuario);
            }
            catch (BizLogicException ex)
            {
                throw new FaultException(ex.Message);
            }
            catch (Exception)
            {
                throw new FaultException("Error desconocido.");
            }
        }

        public BEConfiguracionCampania GetEstadoPedido(int PaisID, int CampaniaID, long ConsultoraID, int ZonaID, int RegionID)
        {
            return BLPedidoWeb.GetEstadoPedido(PaisID, CampaniaID, ConsultoraID, ZonaID, RegionID);
        }
        public IList<BEPedidoWebService> GetPedidoCuvMarquesina(int paisID, int CampaniaID, long ConsultoraID, string cuv)
        {
            return BLPedidoWeb.GetPedidoCuvMarquesina(paisID, CampaniaID, ConsultoraID, cuv);
        }
        public int ValidarCargadePedidos(int paisID, int TipoCronograma, int MarcaPedido, DateTime FechaFactura)
        {
            return BLPedidoWeb.ValidarCargadePedidos(paisID, TipoCronograma, MarcaPedido, FechaFactura);
        }

        public IList<BECuvProgramaNueva> GetCuvProgramaNueva(int paisID)
        {
            return BLPedidoWeb.GetCuvProgramaNueva(paisID);
        }
        #region Consulta y Bloquedo de Pedido
        public IList<BEPedidoWeb> SelectPedidosWebByFilter(BEPedidoWeb BEPedidoWeb, string Fecha, int? RegionID, int? TerritorioID)
        {
            return BLPedidoWeb.SelectPedidosWebByFilter(BEPedidoWeb, Fecha, RegionID, TerritorioID);
        }

        public IList<BEPedidoWebDetalle> SelectDetalleBloqueoPedidoByPedidoId(int paisID, int PedidoID)
        {
            return BLPedidoWebDetalle.SelectDetalleBloqueoPedidoByPedidoId(paisID, PedidoID);
        }

        public int ValidarCuvMarquesina(string CampaniaID, int cuv, int IdPais)
        {
            return BLPedidoWeb.ValidarCuvMarquesina(IdPais, CampaniaID, cuv);
        }
        public int ValidarCuvDescargado(int paisID, int anioCampania, string codigoVenta, string codigoConsultora)
        {
            return BLPedidoDD.ValidarCuvDescargado(paisID, anioCampania, codigoVenta, codigoConsultora);
        }
        public void UpdBloqueoPedido(BEPedidoWeb BEPedidoWeb)
        {
            BLPedidoWeb.UpdBloqueoPedido(BEPedidoWeb);
        }

        public void UpdDesbloqueoPedido(BEPedidoWeb BEPedidoWeb)
        {
            BLPedidoWeb.UpdDesbloqueoPedido(BEPedidoWeb);
        }
        #endregion


        public void InsPedidoWebDetallePROL(int PaisID, int CampaniaID, int PedidoID, short EstadoPedido, List<BEPedidoWebDetalle> olstPedidoWebDetalle, int ModificaPedido, string CodigoUsuario, decimal MontoTotalProl, decimal DescuentoProl)
        {
            BLPedidoWebDetalle.InsPedidoWebDetallePROL(PaisID, CampaniaID, PedidoID, EstadoPedido, olstPedidoWebDetalle, ModificaPedido, CodigoUsuario, MontoTotalProl, DescuentoProl);
        }


        public void UpdPedidoWebByEstado(int PaisID, int CampaniaID, int PedidoID, short EstadoPedido, bool ModificaPedidoReservado, bool Eliminar, string CodigoUsuario, bool ValidacionAbierta)
        {
            BLPedidoWebDetalle.UpdPedidoWebByEstado(PaisID, CampaniaID, PedidoID, EstadoPedido, ModificaPedidoReservado, Eliminar, CodigoUsuario, ValidacionAbierta);
        }

        public void UpdPedidoWebDetalle(BEPedidoWebDetalle pedidowebdetalle)
        {
            BLPedidoWebDetalle.UpdPedidoWebDetalle(pedidowebdetalle);
        }

        public short UpdPedidoWebDetalleMasivo(List<BEPedidoWebDetalle> pedidowebdetalle)
        {
            return BLPedidoWebDetalle.UpdPedidoWebDetalleMasivo(pedidowebdetalle);
        }

        public void AceptarBackOrderPedidoWebDetalle(BEPedidoWebDetalle pedidowebdetalle)
        {
            BLPedidoWebDetalle.AceptarBackOrderPedidoWebDetalle(pedidowebdetalle);
        }

        public void UpdBackOrderListPedidoWebDetalle(int paisID, int campaniaID, int pedidoID, List<BEPedidoWebDetalle> listPedidoWebDetalle)
        {
            BLPedidoWebDetalle.UpdBackOrderListPedidoWebDetalle(paisID, campaniaID, pedidoID, listPedidoWebDetalle);
        }

        public void QuitarBackOrderPedidoWebDetalle(BEPedidoWebDetalle pedidowebdetalle)
        {
            BLPedidoWebDetalle.QuitarBackOrderPedidoWebDetalle(pedidowebdetalle);
        }

        public IList<BEPedidoWebDetalle> SelectByPedidoValidado(int paisID, int CampaniaID, long ConsultoraID, string Consultora)
        {
            return BLPedidoWebDetalle.GetPedidoWebDetalleByPedidoValidado(paisID, CampaniaID, ConsultoraID, Consultora);
        }

        public IList<BEPedidoDDWeb> GetPedidosWebDDNoFacturados(BEPedidoDDWeb BEPedidoDDWeb)
        {
            try
            {
                return BLPedidoWeb.GetPedidosWebDDNoFacturados(BEPedidoDDWeb);
            }
            catch (BizLogicException ex)
            {
                throw new FaultException(ex.Message);
            }
            catch (Exception)
            {
                throw new FaultException("Error desconocido.");
            }
        }

        public IList<BEPedidoDDWebDetalle> GetPedidosWebDDNoFacturadosDetalle(int paisID, string paisISO, int CampaniaID, string Consultora, string Origen)
        {
            try
            {
                return BLPedidoWeb.GetPedidosWebDDNoFacturadosDetalle(paisID, paisISO, CampaniaID, Consultora, Origen);
            }
            catch (BizLogicException ex)
            {
                throw new FaultException(ex.Message);
            }
            catch (Exception)
            {
                throw new FaultException("Error desconocido.");
            }
        }

        public IList<BEPedidoDDWeb> GetPedidosWebDDDetalleConsultora(BEPedidoDDWeb BEPedidoDDWeb)
        {
            try
            {
                return BLPedidoWeb.GetPedidosWebDDDetalleConsultora(BEPedidoDDWeb);
            }
            catch (BizLogicException ex)
            {
                throw new FaultException(ex.Message);
            }
            catch (Exception)
            {
                throw new FaultException("Error desconocido.");
            }
        }

        #region Fase II

        #region Ofertas Web

        public IList<BEConfiguracionOferta> GetTipoOfertasAdministracion(int paisID, int TipoOfertaSisID)
        {
            return new BLOfertaProducto().GetTipoOfertasAdministracion(paisID, TipoOfertaSisID);
        }

        public IList<BEOfertaProducto> GetProductosByTipoOferta(int paisID, int TipoOfertaSisID, int CampaniaID, string CodigoOferta)
        {
            return new BLOfertaProducto().GetProductosByTipoOferta(paisID, TipoOfertaSisID, CampaniaID, CodigoOferta);
        }

        public IList<BEOfertaProducto> GetProductosOfertaByCUVCampania(int paisID, int TipoOfertaSisID, int CampaniaID, string CUV)
        {
            return new BLOfertaProducto().GetProductosByTipoOferta(paisID, TipoOfertaSisID, CampaniaID, CUV);
        }

        public int InsOfertaProducto(BEOfertaProducto entity)
        {
            return new BLOfertaProducto().InsOfertaProducto(entity);
        }

        public int UpdOfertaProducto(BEOfertaProducto entity)
        {
            return new BLOfertaProducto().UpdOfertaProducto(entity);
        }

        public int DelOfertaProducto(BEOfertaProducto entity)
        {
            return new BLOfertaProducto().DelOfertaProducto(entity);
        }

        public int InsAdministracionStockMinimo(BEAdministracionOfertaProducto entity)
        {
            return new BLOfertaProducto().InsAdministracionStockMinimo(entity);
        }

        public int UpdAdministracionStockMinimo(BEAdministracionOfertaProducto entity)
        {
            return new BLOfertaProducto().UpdAdministracionStockMinimo(entity);
        }

        public int UpdOfertaProductoStockMasivo(int paisID, List<BEOfertaProducto> stockProductos)
        {
            return new BLOfertaProducto().UpdOfertaProductoStockMasivo(paisID, stockProductos);
        }

        public int InsStockCargaLog(BEStockCargaLog entity)
        {
            return new BLOfertaProducto().InsStockCargaLog(entity);
        }

        public IList<BEAdministracionOfertaProducto> GetDatosAdmStockMinimoCorreos(int paisID)
        {
            return new BLOfertaProducto().GetDatosAdmStockMinimoCorreos(paisID);
        }

        public int GetOrdenPriorizacion(int paisID, int ConfiguracionOfertaID, int CampaniaID)
        {
            return new BLOfertaProducto().GetOrdenPriorizacion(paisID, ConfiguracionOfertaID, CampaniaID);
        }

        public int ValidarPriorizacion(int paisID, int ConfiguracionOfertaID, int CampaniaID, int Orden)
        {
            return new BLOfertaProducto().ValidarPriorizacion(paisID, ConfiguracionOfertaID, CampaniaID, Orden);
        }

        public int InsMatrizComercial(BEMatrizComercial entity)
        {
            return new BLOfertaProducto().InsMatrizComercial(entity);
        }

        public int UpdMatrizComercial(BEMatrizComercial entity)
        {
            return new BLOfertaProducto().UpdMatrizComercial(entity);
        }

        public IList<BEMatrizComercial> GetMatrizComercialByCodigoSAP(int paisID, string codigoSAP)
        {
            return new BLOfertaProducto().GetMatrizComercialByCodigoSAP(paisID, codigoSAP);
        }

        public IList<BEMatrizComercialImagen> GetMatrizComercialImagenByIdMatrizImagen(int paisID, int idMatrizComercial, int pagina, int registros)
        {
            return new BLOfertaProducto().GetMatrizComercialImagenByIdMatrizImagen(paisID, idMatrizComercial, pagina, registros);
        }

        public IList<BEMatrizComercialImagen> GetImagenesByCodigoSAPPaginado(int paisID, string codigoSAP, int pagina, int registros)
        {
            return new BLOfertaProducto().GetImagenesByCodigoSAP(paisID, codigoSAP, pagina, registros);
        }

        public IList<BEMatrizComercial> GetImagenesByCodigoSAP(int paisID, string codigoSAP)
        {
            return new BLOfertaProducto().GetImagenesByCodigoSAP(paisID, codigoSAP);
        }

        public IList<BEMatrizComercialImagen> GetImagenByNemotecnico(int paisID, int idMatrizImagen, string cuv2, string codigoSAP, int estrategiaID, int campaniaID, int tipoEstrategiaID, string nemotecnico, int tipoBusqueda, int numeroPagina, int registros)
        {
            return new BLOfertaProducto().GetImagenByNemotecnico(paisID, idMatrizImagen, cuv2, codigoSAP, estrategiaID, campaniaID, tipoEstrategiaID, nemotecnico, tipoBusqueda, numeroPagina, registros);
        }

        public int UpdMatrizComercialDescripcionMasivo(int paisID, List<BEMatrizComercial> lstmatriz, string UsuarioRegistro)
        {
            return new BLOfertaProducto().UpdMatrizComercialDescripcionMasivo(paisID, lstmatriz, UsuarioRegistro);
        }

        public IList<BEOfertaProducto> GetOfertaProductosPortal(int PaisID, int TipoOfertaSisID, int DuplaConsultora, int CodigoCampania)
        {
            return new BLOfertaProducto().GetOfertaProductosPortal(PaisID, TipoOfertaSisID, DuplaConsultora, CodigoCampania);
        }

        public IList<BEOfertaProducto> GetOfertaProductosPortal2(int PaisID, int TipoOfertaSisID, int DuplaConsultora, int CodigoCampania, int Offset, int CantidadRegistros)
        {
            return new BLOfertaProducto().GetOfertaProductosPortal2(PaisID, TipoOfertaSisID, DuplaConsultora, CodigoCampania, Offset, CantidadRegistros);
        }

        public void InsPedidoWebDetalleOferta(BEPedidoWebDetalle pedidowebdetalle)
        {
            new BLOfertaProducto().InsPedidoWebDetalleOferta(pedidowebdetalle);
        }

        public void UpdPedidoWebDetalleOferta(BEPedidoWebDetalle pedidowebdetalle)
        {
            new BLOfertaProducto().UpdPedidoWebDetalleOferta(pedidowebdetalle);
        }

        public int GetStockOfertaProductoLiquidacion(int paisID, int CampaniaID, string CUV)
        {
            return new BLOfertaProducto().GetStockOfertaProductoLiquidacion(paisID, CampaniaID, CUV);
        }

        public int GetUnidadesPermitidasByCuv(int paisID, int CampaniaID, string CUV)
        {
            return new BLOfertaProducto().GetUnidadesPermitidasByCuv(paisID, CampaniaID, CUV);
        }


        public int ValidarUnidadesPermitidasEnPedido(int PaisID, int CampaniaID, string CUV, long ConsultoraID)
        {
            return new BLOfertaProducto().ValidarUnidadesPermitidasEnPedido(PaisID, CampaniaID, CUV, ConsultoraID);
        }

        #region Configuracion Oferta

        public int InsConfiguracionOferta(BEConfiguracionOferta entidad)
        {
            return new BLOfertaProducto().InsConfiguracionOferta(entidad);
        }
        public int UpdConfiguracionOferta(BEConfiguracionOferta entidad)
        {
            return new BLOfertaProducto().UpdConfiguracionOferta(entidad);
        }
        public int DelConfiguracionOferta(int PaisID, int ConfiguracionOfertaID)
        {
            return new BLOfertaProducto().DelConfiguracionOferta(PaisID, ConfiguracionOfertaID);
        }
        public IList<BEConfiguracionOferta> GetConfiguracionOfertaAdministracion(int PaisID, int TipoOfertaSisID)
        {
            return new BLOfertaProducto().GetConfiguracionOfertaAdministracion(PaisID, TipoOfertaSisID);
        }

        public int ValidarCodigoOfertaAdministracion(int PaisID, string CodigoOferta)
        {
            return new BLOfertaProducto().ValidarCodigoOfertaAdministracion(PaisID, CodigoOferta);
        }

        public int ActualizarItemsMostrarLiquidacion(int PaisID, int Cantidad)
        {
            return new BLOfertaProducto().ActualizarItemsMostrarLiquidacion(PaisID, Cantidad);
        }
        public int ObtenerMaximoItemsaMostrarLiquidacion(int PaisID)
        {
            return new BLOfertaProducto().ObtenerMaximoItemsaMostrarLiquidacion(PaisID);
        }

        #endregion

        #endregion

        #region Cross Selling

        public int InsConfiguracionCrossSelling(BEConfiguracionCrossSelling entity)
        {
            return new BLCrossSelling().InsConfiguracionCrossSelling(entity);
        }

        public IList<BEConfiguracionCrossSelling> GetConfiguracionCampaniasPorPais(int paisID, int CampaniaID)
        {
            return new BLCrossSelling().GetConfiguracionCampaniasPorPais(paisID, CampaniaID);
        }

        public int InsCrossSellingProducto(BECrossSellingProducto entidad)
        {
            return new BLCrossSellingProducto().InsCrossSellingProducto(entidad);
        }
        public int UpdCrossSellingProducto(BECrossSellingProducto entidad)
        {
            return new BLCrossSellingProducto().UpdCrossSellingProducto(entidad);
        }

        public int DelCrossSellingProducto(BECrossSellingProducto entidad)
        {
            return new BLCrossSellingProducto().DelCrossSellingProducto(entidad);
        }

        public IList<BECrossSellingProducto> GetCrossSellingProductosAdministracion(int paisID, int CampaniaID)
        {
            return new BLCrossSellingProducto().GetCrossSellingProductosAdministracion(paisID, CampaniaID);
        }

        public IList<BECrossSellingAsociacion> GetCrossSellingAsociacionListado(int PaisID, int CampaniaID, string CUV)
        {
            return new BLCrossSellingProducto().GetCrossSellingAsociacionListado(PaisID, CampaniaID, CUV);
        }

        public IList<BECrossSellingAsociacion> GetCUVAsociadoByFilter(int PaisID, int CampaniaID, string CUV, string CodigoSegmento)
        {
            return new BLCrossSellingProducto().GetCUVAsociadoByFilter(PaisID, CampaniaID, CUV, CodigoSegmento);
        }

        public IList<BECrossSellingProducto> GetProductosRecomendadosHabilitados(int PaisID, int CampaniaID, int tipo)
        {
            return new BLCrossSellingProducto().GetProductosRecomendadosHabilitados(PaisID, CampaniaID, tipo);
        }

        public IList<BECrossSellingAsociacion> GetDescripcionProductoByCUV(int PaisID, int CampaniaID, string CUV)
        {
            return new BLCrossSellingProducto().GetDescripcionProductoByCUV(PaisID, CampaniaID, CUV);
        }

        public int InsCrossSellingAsociacion(BECrossSellingAsociacion entidad)
        {
            return new BLCrossSellingProducto().InsCrossSellingAsociacion(entidad);
        }

        public int UpdCrossSellingAsociacion(BECrossSellingAsociacion entidad)
        {
            return new BLCrossSellingProducto().UpdCrossSellingAsociacion(entidad);
        }

        public int DelCrossSellingAsociacion(BECrossSellingAsociacion entidad)
        {
            return new BLCrossSellingProducto().DelCrossSellingAsociacion(entidad);
        }

        public int DelCrossSellingAsociacion_Perfil(BECrossSellingAsociacion entidad)
        {
            return new BLCrossSellingProducto().DelCrossSellingAsociacion_Perfil(entidad);
        }
        public IList<BECrossSellingProducto> GetProductosRecomendadosByCUVCampaniaPortal(int PaisID, long ConsultoraID, int CampaniaID, string CUV)
        {
            return new BLCrossSellingProducto().GetProductosRecomendadosByCUVCampaniaPortal(PaisID, ConsultoraID, CampaniaID, CUV);
        }

        public int ValidarConfiguracionCrossSelling(int PaisID, int CampaniaID)
        {
            return new BLCrossSelling().ValidarConfiguracionCrossSelling(PaisID, CampaniaID);
        }
        #endregion

        #endregion

        public bool DelPedidoWebDetalleMasivo(int PaisID, int CampaniaID, int PedidoID, string CodigoUsuario)
        {
            return BLPedidoWebDetalle.DelPedidoWebDetalleMasivo(PaisID, CampaniaID, PedidoID, CodigoUsuario);
        }

        public bool DelPedidoWebDetallePackNueva(int PaisID, long ConsultoraID, int PedidoID)
        {
            return BLPedidoWebDetalle.DelPedidoWebDetallePackNueva(PaisID, ConsultoraID, PedidoID);
        }

        public int GetPedidoWebID(int paisID, int campaniaID, long consultoraID)
        {
            return BLPedidoWeb.GetPedidoWebID(paisID, campaniaID, consultoraID);
        }

        #region Packs Ofertas Nuevas
        public IList<BEOfertaNueva> GetOfertasNuevasByCampania(int paisID, int CampaniaID)
        {
            return BLOfertaNueva.GetOfertasNuevasByCampania(paisID, CampaniaID);
        }

        public IList<BEOfertaNueva> GetPackOfertasNuevasByCampania(int paisID, int CampaniaID)
        {
            return BLOfertaNueva.GetPackOfertasNuevasByCampania(paisID, CampaniaID);
        }
        public IList<BEOfertaNueva> GetProductosOfertaConsultoraNueva(int paisID, int CampaniaID, int consultoraid)
        {
            return BLOfertaNueva.GetProductosOfertaConsultoraNueva(paisID, CampaniaID, consultoraid);
        }

        public BEOfertaNueva GetDescripcionPackByCUV(int paisID, string CUV, int CampaniaCodigo)
        {
            return BLOfertaNueva.GetDescripcionPackByCUV(paisID, CUV, CampaniaCodigo);
        }

        public int ValidarOfertasNuevas(BEOfertaNueva oBe)
        {
            return BLOfertaNueva.ValidarOfertasNuevas(oBe);
        }

        public int ValidarUnidadesPermitidas(BEOfertaNueva oBe)
        {
            return BLOfertaNueva.ValidarUnidadesPermitidas(oBe);
        }

        public int ObtenerEstadoPacksOfertasNuevas(int PaisID, string CodigoConsultora)
        {
            return BLOfertaNueva.ObtenerEstadoPacksOfertasNuevas(PaisID, CodigoConsultora);
        }

        public int ObtenerEstadoPacksOfertasNueva(int PaisID, int idconsultora, int campania)
        {
            return BLOfertaNueva.ObtenerEstadoPacksOfertasNueva(PaisID, idconsultora, campania);
        }


        public int UpdEstadoPacksOfertasNuevas(int PaisID, string CodigoConsultora, int CambioEstado)
        {
            return BLOfertaNueva.UpdEstadoPacksOfertasNuevas(PaisID, CodigoConsultora, CambioEstado);
        }

        public int UpdEstadoPacksOfertasNueva(int PaisID, int idconsultora, string CodigoConsultora, int campania)
        {
            return BLOfertaNueva.UpdEstadoPacksOfertasNueva(PaisID, idconsultora, CodigoConsultora, campania);
        }
        public int InsertOfertasNuevas(BEOfertaNueva oBe)
        {
            return BLOfertaNueva.InsertOfertasNuevas(oBe);
        }

        public int UpdOfertasNuevas(BEOfertaNueva oBe)
        {
            return BLOfertaNueva.UpdOfertasNuevas(oBe);
        }

        public int DelOfertasNuevas(BEOfertaNueva oBe, int ConfiguracionOfertaId)
        {
            return BLOfertaNueva.DelOfertasNuevas(oBe, ConfiguracionOfertaId);
        }


        #endregion

        #region Ofertas Flexipago

        public IList<BEOfertaFlexipago> GetProductosByOfertaFlexipago(int paisID, int TipoOfertaSisID, int CampaniaID, string CodigoOferta, string CodigoSAP, string CUV, string CategoriaID)
        {
            return new BLOfertaFlexipago().GetProductosByOfertaFlexipago(paisID, TipoOfertaSisID, CampaniaID, CodigoOferta, CodigoSAP, CUV, CategoriaID);
        }

        public void GuardarLinksOfertaFlexipago(BEOfertaFlexipago entidad)
        {
            new BLOfertaFlexipago().GuardarLinksOfertaFlexipago(entidad);
        }

        public BEOfertaFlexipago GetLinksOfertaFlexipago(int paisID)
        {
            return new BLOfertaFlexipago().GetLinksOfertaFlexipago(paisID);
        }

        public int UpdOfertaFlexipagoStockMasivo(int paisID, List<BEOfertaFlexipago> stockProductos)
        {
            return new BLOfertaFlexipago().UpdOfertaFlexipagoStockMasivo(paisID, stockProductos);
        }

        public int UpdCategoriaConsultoraMasivo(int paisID, List<BEOfertaFlexipago> stockProductos)
        {
            return new BLOfertaFlexipago().UpdCategoriaConsultoraMasivo(paisID, stockProductos);
        }

        public string GetCategoriaByConsultora(int paisID, int CampaniaID, string CodigoConsultora)
        {
            return new BLOfertaFlexipago().GetCategoriaByConsultora(paisID, CampaniaID, CodigoConsultora);
        }

        public int InsOfertaFlexipago(BEOfertaFlexipago entity)
        {
            return new BLOfertaFlexipago().InsOfertaFlexipago(entity);
        }

        public int UpdOfertaFlexipago(BEOfertaFlexipago entity)
        {
            return new BLOfertaFlexipago().UpdOfertaFlexipago(entity);
        }

        public int DelOfertaFlexipago(BEOfertaFlexipago entity)
        {
            return new BLOfertaFlexipago().DelOfertaFlexipago(entity);
        }

        public int GetUnidadesPermitidasByCuvFlexipago(int paisID, int CampaniaID, string CUV)
        {
            return new BLOfertaFlexipago().GetUnidadesPermitidasByCuvFlexipago(paisID, CampaniaID, CUV);
        }

        public int ValidarUnidadesPermitidasEnPedidoFlexipago(int PaisID, int CampaniaID, string CUV, long ConsultoraID)
        {
            return new BLOfertaFlexipago().ValidarUnidadesPermitidasEnPedidoFlexipago(PaisID, CampaniaID, CUV, ConsultoraID);
        }

        public int GetStockOfertaProductoFlexipago(int paisID, int CampaniaID, string CUV, int TipoOfertaSisID)
        {
            return new BLOfertaFlexipago().GetStockOfertaProductoFlexipago(paisID, CampaniaID, CUV, TipoOfertaSisID);
        }

        public int ObtenerMaximoItemsaMostrarFlexipago(int PaisID)
        {
            return new BLOfertaFlexipago().ObtenerMaximoItemsaMostrarFlexipago(PaisID);
        }

        public int ActualizarItemsMostrarFlexipago(int PaisID, int Cantidad)
        {
            return new BLOfertaFlexipago().ActualizarItemsMostrarFlexipago(PaisID, Cantidad);
        }

        public IList<BEOfertaFlexipago> GetOfertaProductosPortalFlexipago(int PaisID, int TipoOfertaSisID, string CodigoConsultora, int CodigoCampania)
        {
            return new BLOfertaFlexipago().GetOfertaProductosPortalFlexipago(PaisID, TipoOfertaSisID, CodigoConsultora, CodigoCampania);
        }

        public IList<BEOfertaFlexipago> GetCuotasAnterioresFlexipago(int PaisID, string CodigoConsultora, int CampaniaID)
        {
            return new BLOfertaFlexipago().GetCuotasAnterioresFlexipago(PaisID, CodigoConsultora, CampaniaID);
        }

        public BEOfertaFlexipago GetLineaCreditoFlexipago(int PaisID, string CodigoConsultora, int CampaniaID)
        {
            return new BLOfertaFlexipago().GetLineaCreditoFlexipago(PaisID, CodigoConsultora, CampaniaID);
        }

        public bool GetPermisoFlexipago(int PaisID, string CodigoConsultora, int CampaniaID)
        {
            return new BLOfertaFlexipago().GetPermisoFlexipago(PaisID, CodigoConsultora, CampaniaID);
        }

        #endregion

        #region PEDIDO FIC

        public IList<BEPedidoFICDetalle> SelectFICByCampania(int paisID, int CampaniaID, long ConsultoraID, string Consultora)
        {
            return BLPedidoFICDetalle.GetPedidoFICDetalleByCampania(paisID, CampaniaID, ConsultoraID, Consultora);
        }

        public BEPedidoFICDetalle InsertFIC(BEPedidoFICDetalle pedidoficdetalle)
        {
            return BLPedidoFICDetalle.InsPedidoFICDetalle(pedidoficdetalle);
        }

        public void UpdPedidoFICDetalle(BEPedidoFICDetalle pedidoficdetalle)
        {
            BLPedidoFICDetalle.UpdPedidoFICDetalle(pedidoficdetalle);
        }

        public void DelPedidoFICDetalle(BEPedidoFICDetalle pedidoficdetalle)
        {
            BLPedidoFICDetalle.DelPedidoFICDetalle(pedidoficdetalle);
        }

        public bool DelPedidoFICDetalleMasivo(int PaisID, int CampaniaID, int PedidoID)
        {
            return BLPedidoFICDetalle.DelPedidoFICDetalleMasivo(PaisID, CampaniaID, PedidoID);
        }

        public void InsTempServiceProl(int PaisID, DataTable ServicePROL)
        {
            BLPedidoFICDetalle.InsTempServiceProl(PaisID, ServicePROL);
        }

        public IList<BEServicePROLFIC> GetReportePedidoFIC(int paisID, string CodigoCampania, string CodigoRegion, string CodigoZona, string CodigoConsultora)
        {
            return BLPedidoFICDetalle.GetReportePedidoFIC(paisID, CodigoCampania, CodigoRegion, CodigoZona, CodigoConsultora);
        }

        public string[] DescargaPedidosFIC(int paisID, DateTime fechaFacturacion, int tipoCronograma, string usuario)
        {
            return BLPedidoWeb.DescargaPedidosFIC(paisID, fechaFacturacion, tipoCronograma, usuario);
        }
        #endregion

        public int GetFechaNoHabilFacturacion(int paisID, string CodigoZona, DateTime Fecha)
        {
            return BLPedidoWeb.GetFechaNoHabilFacturacion(paisID, CodigoZona, Fecha);
        }

        #region Tracking

        public List<BETracking> GetPedidosByConsultora(int paisID, string codigoConsultora, int top)
        {
            return BLTracking.GetPedidosByConsultora(paisID, codigoConsultora, top);
        }

        public BETracking GetPedidoByConsultoraAndCampania(int paisID, string codigoConsultora, int campania)
        {
            return BLTracking.GetPedidoByConsultoraAndCampania(paisID, codigoConsultora, campania);
        }

        public BETracking GetPedidoByConsultoraAndCampaniaAndNroPedido(int paisID, string codigoConsultora, int campania, string nroPedido)
        {
            return BLTracking.GetPedidoByConsultoraAndCampaniaAndNroPedido(paisID, codigoConsultora, campania, nroPedido);
        }

        public List<BETracking> GetTrackingByPedido(int paisID, string codigo, string campana, string nropedido)
        {
            return BLTracking.GetTrackingByPedido(paisID, codigo, campana, nropedido);
        }

        public List<BETracking> GetTrackingPedidoByConsultora(int paisID, string codigoConsultora, int top)
        {
            return _trackingBusinessLogic.GetTrackingPedidoByConsultora(paisID, codigoConsultora, top);
        }
        #endregion

        #region CUV_Automatico
        public int GetProductoCUVsAutomaticosToInsert(BEPedidoWeb pedidoweb)
        {
            return oBLCUV.GetProductoCUVsAutomaticosToInsert(pedidoweb);
        }
        #endregion

        #region Oferta_FIC
        public int GetOfertaFICToInsert(BEPedidoWeb pedidoweb)
        {
            return oBLCUV.GetOfertaFICToInsert(pedidoweb);
        }
        #endregion

        #region "Segmento Planeamiento"
        public IList<BESegmentoPlaneamiento> GetSegmentoPlaneamiento(int PaisID, int campaniaId)
        {
            return oBLSegmentoPlaneamiento.GetSegmentoPlaneamiento(PaisID, campaniaId);
        }
        #endregion

        public BEPedidoWeb GetPedidoWebByCampaniaConsultora(int paisID, int campaniaID, long consultoraID)
        {
            return BLPedidoWeb.GetPedidoWebByCampaniaConsultora(paisID, campaniaID, consultoraID);
        }

        public BEPedidoWeb GetResumenPedidoWebByCampaniaConsultora(int paisID, int campaniaID, long consultoraID)
        {
            return BLPedidoWeb.GetResumenPedidoWebByCampaniaConsultora(paisID, campaniaID, consultoraID);
        }

        public List<BEEscalaDescuento> GetEscalaDescuento(int paisID)
        {
            return BLEscalaDescuento.GetEscalaDescuento(paisID);
        }

        public List<BEEscalaDescuento> GetParametriaOfertaFinal(int paisID,string algoritmo)
        {
            return BLEscalaDescuento.GetParametriaOfertaFinal(paisID, algoritmo);
        }

        #region Pedidos DD

        public BEPedidoDD GetPedidoDDByCampaniaConsultora(int paisID, int campaniaID, long consultoraID)
        {
            return BLPedidoDD.GetPedidoDDByCampaniaConsultora(paisID, campaniaID, consultoraID);
        }

        public void InsPedidoDD(BEPedidoDD bePedidoDD)
        {
            BLPedidoDD.InsPedidoDD(bePedidoDD);
        }

        public void UpdPedidoDD(BEPedidoDD bePedidoDD)
        {
            BLPedidoDD.UpdPedidoDD(bePedidoDD);
        }

        public void HabiliatPedidoIndividual(int paisID, int campaniaID, long consultoraID, string usuarioDigitador, bool indicadoEnviado)
        {
            BLPedidoDD.HabiliatPedidoIndividual(paisID, campaniaID, consultoraID, usuarioDigitador, indicadoEnviado);
        }

        public IList<BELogPedidoDDInvalido> SelectLogPedidosInvalidos(int paisID, DateTime fechaRegistro)
        {
            return BLLogPedidoDDInvalido.SelectLogPedidosInvalidos(paisID, fechaRegistro);
        }

        public bool InsLogPedidoDDInvalido(int paisID, BELogPedidoDDInvalido beLogPedidoDDInvalido)
        {
            return BLLogPedidoDDInvalido.InsLogPedidoDDInvalido(paisID, beLogPedidoDDInvalido);
        }

        public void UpdLogPedidoInvalido(int paisID, DateTime fechaRegistro)
        {
            BLLogPedidoDDInvalido.UpdLogPedidoInvalido(paisID, fechaRegistro);
        }

        public IList<BEPedidoDD> GetPedidosIngresados(int paisID, string codigoUsuario, DateTime fechaIngreso, string codigoConsultora, int campaniaID, string codigoZona, bool indicadorActivo)
        {
            return BLPedidoDD.GetPedidosIngresados(paisID, codigoUsuario, fechaIngreso, codigoConsultora, campaniaID, codigoZona, indicadorActivo);
        }

        public void UpdPedidoDDDetalle(int paisID, BEPedidoDDDetalle bePedidoDDDetalle)
        {
            BLPedidoDDDetalle.UpdPedidoDetalleDD(paisID, bePedidoDDDetalle);
        }

        public void DelPedidoDDDetalle(int paisID, BEPedidoDDDetalle bePedidoDDDetalle)
        {
            BLPedidoDDDetalle.DelPedidoDetalleDD(paisID, bePedidoDDDetalle);
        }

        public IList<BEPedidoDDWebDetalle> GetPedidoDDDetalle(int paisID, string paisISO, int pedidoID, int CampaniaID, string Consultora, string Origen, bool IndicadorActivo)
        {
            try
            {
                return BLPedidoWeb.GetPedidoDDDetalle(paisID, paisISO, pedidoID, CampaniaID, Consultora, Origen, IndicadorActivo);
            }
            catch (BizLogicException ex)
            {
                throw new FaultException(ex.Message);
            }
            catch (Exception)
            {
                throw new FaultException("Error desconocido.");
            }
        }

        public void AnularPedido(int paisID, int campaniaID, int pedidoID)
        {
            BLPedidoDD.AnularPedido(paisID, campaniaID, pedidoID);
        }

        #region Configuracion Campanña

        public BEConfiguracionCampania GetCampaniaActualByZona(int paisID, string codigoZona)
        {
            BLConfiguracionCampania blConfiguracion = new BLConfiguracionCampania();
            return blConfiguracion.GetCampaniaActualByZona(paisID, codigoZona);
        }

        public BEConfiguracionCampania GetConfiguracionCampaniaZona(int paisID, int zonaID, int regionID, long consultoraID)
        {
            BLConfiguracionCampania blConfiguracion = new BLConfiguracionCampania();
            return blConfiguracion.GetConfiguracionCampaniaZona(paisID, zonaID, regionID, consultoraID);
        }

        #endregion

        #endregion

        public void InsPedidoWebAccionesPROL(List<BEPedidoWebDetalle> olstBEPedidoWebDetalle, int Tipo, int Accion)
        {
            BLPedidoWebDetalle.InsPedidoWebAccionesPROL(olstBEPedidoWebDetalle, Tipo, Accion);
        }
        public int UpdVisualizacionPopupProRecom(int consultoraid, int campaniaid, int paisid)
        {
            return new BLCrossSellingProducto().UpdVisualizacionPopupProRecom(consultoraid, campaniaid, paisid);
        }

        #region Asistencia Compartamos

        public bool VerificarAsistenciaCompartamos(int paisID, int campaniaID, long consultoraID)
        {
            return BLPedidoDD.VerificarAsistenciaCompartamos(paisID, campaniaID, consultoraID);
        }

        public void RegistrarAsistenciaCompartamos(int paisID, BEAsistenciaCompartamos beAsistenciaCompartamos)
        {
            BLPedidoDD.RegistrarAsistenciaCompartamos(paisID, beAsistenciaCompartamos);
        }

        #endregion


        public string HabilitaPedidoMultiple(int paisID, IList<string> infoConsultoras)
        {
            return BLPedidoDD.HabilitaPedidoMultiple(paisID, infoConsultoras);
        }

        public IList<string> HabilitaPedidoMultipleInformacionConsultoras(int paisID, IDictionary<string, string> listaConsultoras)
        {
            return BLPedidoDD.HabilitaPedidoMultipleInformacionConsultoras(paisID, listaConsultoras);
        }


        public BEInformacion GetReporteIntegradoWebDD(int PaisID, string PaisISO, int CampaniaIDInicio, int CampaniaIDFin)
        {
            return new BLReporteIntegradoWebDD().GetReporteIntegradoWebDD(PaisID, PaisISO, CampaniaIDInicio, CampaniaIDFin);
        }

        public List<BENovedadTracking> GetNovedadesTracking(int paisID, string NumeroPedido)
        {
            return BLTracking.GetNovedadesTracking(paisID, NumeroPedido);
        }

        public int InsConfirmacionEntrega(int paisID, BEConfirmacionEntrega oBEConfirmacionEntrega)
        {
            return BLTracking.InsConfirmacionEntrega(paisID, oBEConfirmacionEntrega);
        }

        public int UpdConfirmacionEntrega(int paisID, BEConfirmacionEntrega oBEConfirmacionEntrega)
        {
            return BLTracking.UpdConfirmacionEntrega(paisID, oBEConfirmacionEntrega);
        }

        public int InsConfirmacionRecojo(int paisID, BEConfirmacionRecojo oBEConfirmacionRecojo)
        {
            return BLTracking.InsConfirmacionRecojo(paisID, oBEConfirmacionRecojo);
        }

        public List<BEPostVenta> GetMisPostVentaByConsultora(int paisID, string codigoConsultora)
        {
            return BLTracking.GetMisPostVentaByConsultora(paisID, codigoConsultora);
        }

        public List<BEPostVenta> GetSeguimientoPostVenta(int paisID, string numeroRecojo, int estadoId)
        {
            return BLTracking.GetSeguimientoPostVenta(paisID, numeroRecojo, estadoId);
        }

        public List<BEPostVenta> GetNovedadPostVenta(int paisID, string numeroRecojo)
        {
            return BLTracking.GetNovedadPostVenta(paisID, numeroRecojo);
        }

        public int InsertarEtiqueta(BEEtiqueta entidad)
        {
            return new BLEtiqueta().InsertEtiqueta(entidad);
        }

        public List<BEEtiqueta> GetEtiquetas(BEEtiqueta entidad)
        {
            return new BLEtiqueta().GetEtiquetas(entidad);
        }


        /// <summary>
        /// Retorna los codigos de programa y pedidos asociados configurarados para Pack Nuevas.
        /// </summary>
        /// <returns></returns>
        public List<BEConfiguracionPackNuevas> GetConfiguracionPackNuevas(int paisID, string codigoPrograma)
        {
            return new BLConfiguracionPortal().ObtenerConfiguracionPackNuevas(paisID, codigoPrograma);
        }

        public int InsertarOferta(BEOferta entidad)
        {
            return new BLOferta().InsertOferta(entidad);
        }

        public List<BEOferta> GetOfertas(BEOferta entidad)
        {
            return new BLOferta().GetOfertas(entidad);
        }

        public int InsertarTipoEstrategia(BETipoEstrategia entidad)
        {
            return new BLTipoEstrategia().InsertTipoEstrategia(entidad);
        }

        public int EliminarTipoEstrategia(BETipoEstrategia entidad)
        {
            return new BLTipoEstrategia().DeleteTipoEstrategia(entidad);
        }

        public List<BETipoEstrategia> GetTipoEstrategias(BETipoEstrategia entidad)
        {
            return new BLTipoEstrategia().GetTipoEstrategias(entidad);
        }

        public List<BEEstrategia> GetEstrategias(BEEstrategia entidad)
        {
            return new BLEstrategia().GetEstrategias(entidad);
        }
        public BEEstrategiaDetalle GetEstrategiaDetalle(int paisID, int estrategiaID)
        {
            return new BLEstrategia().GetEstrategiaDetalle(paisID, estrategiaID);
        }
        public List<BETallaColor> GetTallaColor(BETallaColor entidad)
        {
            return new BLEstrategia().GetTallaColor(entidad);
        }
        public int InsertarTallaColorCUV(BETallaColor entidad)
        {
            return new BLEstrategia().InsertTallaColorCUV(entidad);
        }
        public List<BEEstrategia> GetOfertaByCUV(BEEstrategia entidad)
        {
            return new BLEstrategia().GetOfertaByCUV(entidad);
        }
        public int InsertarEstrategia(BEEstrategia entidad)
        {
            return new BLEstrategia().InsertEstrategia(entidad);
        }
        public List<BEEstrategia> FiltrarEstrategia(BEEstrategia entidad)
        {
            return new BLEstrategia().FiltrarEstrategia(entidad);
        }
        public List<BEMatrizComercialImagen> GetImagenesByEstrategiaMatrizComercialImagen(BEEstrategia entidad, int pagina, int registros)
        {
            return new BLEstrategia().GetImagenesByEstrategiaMatrizComercialImagen(entidad, pagina, registros);
        }
        public int DeshabilitarEstrategia(BEEstrategia entidad)
        {
            return new BLEstrategia().DeshabilitarEstrategia(entidad);
        }
        public int EliminarTallaColor(BETallaColor entidad)
        {
            return new BLEstrategia().EliminarTallaColor(entidad);
        }
        public int ValidarCUVsRecomendados(BEEstrategia entidad)
        {
            return new BLEstrategia().ValidarCUVsRecomendados(entidad);
        }
        public List<BEEstrategia> GetEstrategiasPedido(BEEstrategia entidad)
        {
            return blEstrategia.GetEstrategiasPedido(entidad);
        }

        public List<BEEstrategia> GetMasVendidos(BEEstrategia entidad)
        {
            return blEstrategia.GetMasVendidos(entidad);
        }

        public List<BEEstrategia> FiltrarEstrategiaPedido(BEEstrategia entidad)
        {
            return new BLEstrategia().FiltrarEstrategiaPedido(entidad);
        }
        public string ValidarStockEstrategia(BEEstrategia entidad)
        {
            return new BLEstrategia().ValidarStockEstrategia(entidad);
        }
        public int DeleteOferta(BEOferta entidad)
        {
            return new BLOferta().DeleteOferta(entidad);
        }
        public IList<BEConfiguracionValidacionZE> GetRegionZonaZE(int PaisID, int RegionID, int ZonaID)
        {
            return new BLEstrategia().GetRegionZonaZE(PaisID, RegionID, ZonaID);
        }

        public void InsPedidoWebDetallePROLv2(int PaisID, int CampaniaID, int PedidoID, short EstadoPedido, List<BEPedidoWebDetalle> olstPedidoWebDetalle, bool ValidacionAbierta, string CodigoUsuario, decimal MontoTotalProl, decimal DescuentoProl)
        {
            BLPedidoWebDetalle.InsPedidoWebDetallePROLv2(PaisID, CampaniaID, PedidoID, EstadoPedido, olstPedidoWebDetalle, ValidacionAbierta, CodigoUsuario, MontoTotalProl, DescuentoProl);
        }

        public BENovedadFacturacion GetPedidoRechazadoByConsultora(int PaisID, string CampaniaId, string CodigoConsultora, DateTime Fecha)
        {
            return BLTracking.GetPedidoRechazadoByConsultora(PaisID, CampaniaId, CodigoConsultora, Fecha);
        }

        public BENovedadFacturacion GetPedidoAnuladoByConsultora(int PaisID, string CampaniaId, string CodigoConsultora, DateTime Fecha, string NumeroPedido)
        {
            return BLTracking.GetPedidoAnuladoByConsultora(PaisID, CampaniaId, CodigoConsultora, Fecha, NumeroPedido);
        }

        #region VAL PROL - R2073

        public int GetEstadoProcesoPROLAuto(int paisID, DateTime FechaHoraFacturacion)
        {
            return BLValidacionAutomatica.GetEstadoProcesoPROLAuto(paisID, FechaHoraFacturacion);
        }

        public List<BEValidacionAutomatica> GetEstadoProcesoPROLAutoDetalle(int paisID)
        {
            return BLValidacionAutomatica.GetEstadoProcesoPROLAutoDetalle(paisID);
        }

        public BEValidacionMovil InsValidacionMovilPROLLog(BEValidacionMovil oBEValidacionMovil)
        {
            return BLValidacionAutomatica.InsValidacionMovilPROLLog(oBEValidacionMovil);
        }

        public void UpdValidacionMovilPROLLog(BEValidacionMovil oBEValidacionMovil)
        {
            BLValidacionAutomatica.UpdValidacionMovilPROLLog(oBEValidacionMovil);
        }

        public void UpdValAutoPROLPedidoWeb(int PaisId, int CampaniaId, int PedidoId, int EstadoPedido, bool ItemsEliminados, decimal montoTotalProl, decimal descuentoProl)
        {
            BLValidacionAutomatica.UpdValAutoPROLPedidoWeb(PaisId, CampaniaId, PedidoId, EstadoPedido, ItemsEliminados, montoTotalProl, descuentoProl);
        }

        public void InsPedidoWebAccionesPROLAuto(int PaisId, BEAccionesPROL oBEAccionesPROL)
        {
            BLValidacionAutomatica.InsPedidoWebAccionesPROLAuto(PaisId, oBEAccionesPROL);
        }

        public void DelPedidoWebDetalleValAuto(int PaisId, int CampaniaID, int PedidoID, int PedidoDetalleID, long ConsultoraID, int MarcaID, string CUV, int Cantidad, decimal PrecioUnidad, DateTime FechaCreacion)
        {
            BLValidacionAutomatica.DelPedidoWebDetalleValAuto(PaisId, CampaniaID, PedidoID, PedidoDetalleID, ConsultoraID, MarcaID, CUV, Cantidad, PrecioUnidad, FechaCreacion);
        }

        public string GetValidacionMovilPROLLog(BEValidacionMovil oBEValidacionMovil)
        {
            return BLValidacionAutomatica.GetValidacionMovilPROLLog(oBEValidacionMovil);
        }

        public void UpdPedidoWebDetalleObsPROL(int PaisId, int CampaniaId, int PedidoId, int PedidoDetalleId, string ObservacionPROL, bool Tipo)
        {
            BLValidacionAutomatica.UpdPedidoWebDetalleObsPROL(PaisId, CampaniaId, PedidoId, PedidoDetalleId, ObservacionPROL, Tipo);
        }

        public List<BEPedidoWebDetalle> GetPedidoWebDetalleValidacionPROL(int PaisId, int CampaniaId, int PedidoId)
        {
            return BLValidacionAutomatica.GetPedidoWebDetalleValidacionPROL(PaisId, CampaniaId, PedidoId);
        }

        public void InsPedidoWebCorreoPROL(int PaisId, long ValAutomaticaPROLLogId, int CampaniaID, int PedidoID)
        {
            BLValidacionAutomatica.InsPedidoWebCorreoPROL(PaisId, ValAutomaticaPROLLogId, CampaniaID, PedidoID);
        }

        #endregion

        public List<BESuenioNavidad> ListarSuenioNavidad(BESuenioNavidad entidad)
        {
            return new BLSuenioNavidad().ListarSuenioNavidad(entidad).ToList();
        }

        public void RegistrarSuenioNavidad(BESuenioNavidad entidad)
        {
            new BLSuenioNavidad().RegistrarSuenioNavidad(entidad);
        }

        public int ValidarSuenioNavidad(BESuenioNavidad entidad)
        {
            return new BLSuenioNavidad().ValidarSuenioNavidad(entidad);
        }

        public int ValidarUnidadesPermitidasEnPedidoZA(int PaisID, int CampaniaID, string CUV, long ConsultoraID, int TipoOfertaSisID)
        {
            return new BLOfertaProducto().ValidarUnidadesPermitidasEnPedidoZA(PaisID, CampaniaID, CUV, ConsultoraID, TipoOfertaSisID);
        }
        public int GetUnidadesPermitidasByCuvZA(int paisID, int CampaniaID, string CUV, int TipoOfertaSisID)
        {
            return new BLOfertaProducto().GetUnidadesPermitidasByCuvZA(paisID, CampaniaID, CUV, TipoOfertaSisID);
        }
        public int ObtenerMaximoItemsaMostrarZA(int PaisID)
        {
            return new BLOfertaProducto().ObtenerMaximoItemsaMostrarZA(PaisID);
        }
        public int ActualizarItemsMostrarZA(int PaisID, int Cantidad)
        {
            return new BLOfertaProducto().ActualizarItemsMostrarZA(PaisID, Cantidad);
        }
        public IList<BEAdministracionOfertaProducto> GetDatosAdmStockMinimoCorreosZA(int paisID, int TipoOfertaSisID)
        {
            return new BLOfertaProducto().GetDatosAdmStockMinimoCorreosZA(paisID, TipoOfertaSisID);
        }
        public int InsAdministracionStockMinimoZA(BEAdministracionOfertaProducto entity)
        {
            return new BLOfertaProducto().InsAdministracionStockMinimoZA(entity);
        }
        public int UpdAdministracionStockMinimoZA(BEAdministracionOfertaProducto entity)
        {
            return new BLOfertaProducto().UpdAdministracionStockMinimoZA(entity);
        }

        public List<BEOfertaProducto> GetTallaColorLiquidacion(BEOfertaProducto entidad)
        {
            return new BLOfertaProducto().GetTallaColor(entidad);
        }
        public int InsertarTallaColorLiquidacion(BEOfertaProducto entidad)
        {
            return new BLOfertaProducto().InsertTallaColorCUV(entidad);
        }
        public int EliminarTallaColorLiquidacion(BEOfertaProducto entidad)
        {
            return new BLOfertaProducto().EliminarTallaColor(entidad);
        }
        public List<BEOfertaProducto> ConsultarLiquidacionByCUV(BEOfertaProducto entidad)
        {
            return new BLOfertaProducto().ConsultarLiquidacionByCUV(entidad);
        }
        public int CantidadPedidoByConsultora(BEOfertaProducto entidad)
        {
            return new BLOfertaProducto().CantidadPedidoByConsultora(entidad);
        }

        public int ValidarDesactivaRevistaGana(int paisID, int campaniaID, string codigoZona)
        {
            return new BLPedidoWeb().ValidarDesactivaRevistaGana(paisID, campaniaID, codigoZona);
        }

        public BECUVCredito ValidarCUVCreditoPorCUVRegular(int paisID, string codigoConsultora, string cuvRegular, int campaniaID)
        {
            return new BLPedidoWeb().ValidarCUVCreditoPorCUVRegular(paisID, codigoConsultora, cuvRegular, campaniaID);
        }

        public bool InsLogEnvioCorreoPedidoValidado(int paisID, BELogCabeceraEnvioCorreo beLogCabeceraEnvioCorreo, List<BELogDetalleEnvioCorreo> listLogDetalleEnvioCorreo)
        {
            return new BLLogEnvioCorreo().InsLogEnvioCorreoPedidoValidado(paisID, beLogCabeceraEnvioCorreo, listLogDetalleEnvioCorreo);
        }

        public int RemoverOfertaLiquidacion(BEOfertaProducto entity)
        {
            return new BLOfertaProducto().RemoverOfertaLiquidacion(entity);
        }

        public int GetPaisID(string ISO)
        {
            List<KeyValuePair<string, string>> listaPaises = new List<KeyValuePair<string, string>>()
            {
                new KeyValuePair<string, string>("1", "AR"),
                new KeyValuePair<string, string>("2", "BO"),
                new KeyValuePair<string, string>("3", "CL"),
                new KeyValuePair<string, string>("4", "CO"),
                new KeyValuePair<string, string>("5", "CR"),
                new KeyValuePair<string, string>("6", "EC"),
                new KeyValuePair<string, string>("7", "SV"),
                new KeyValuePair<string, string>("8", "GT"),
                new KeyValuePair<string, string>("9", "MX"),
                new KeyValuePair<string, string>("10", "PA"),
                new KeyValuePair<string, string>("11", "PE"),
                new KeyValuePair<string, string>("12", "PR"),
                new KeyValuePair<string, string>("13", "DO"),
                new KeyValuePair<string, string>("14", "VE"),
            };
            string paisID = "0";
            try
            {
                paisID = (from c in listaPaises
                          where c.Value == ISO.ToUpper()
                          select c.Key).SingleOrDefault();
            }
            catch (Exception)
            {
                throw new Exception("Hubo un error en obtener el País");
            }
            return int.Parse(paisID);
        }

        public BEResultadoSolicitud InsertarSolicitudCliente(string prefijoISO, BEEntradaSolicitudCliente entidadSolicitud)
        {
            int resultado = 0;
            string mensaje = "";
            try
            {
                if (prefijoISO == null || prefijoISO == string.Empty)
                {
                    mensaje = "Debe ingresar el código ISO de País.";
                    return new BEResultadoSolicitud(resultado, mensaje);
                }
                else if (prefijoISO.Length > 5)
                {
                    mensaje = "El código ISO de País no puede exceder los 5 caracteres.";
                    return new BEResultadoSolicitud(resultado, mensaje);
                }
                else if (entidadSolicitud == null)
                {
                    mensaje = "No se ha creado el objeto de solicitud.";
                    return new BEResultadoSolicitud(resultado, mensaje);
                }
                else
                {
                    int paisID = GetPaisID(prefijoISO);
                    BLSolicitudCliente blSolicitudCliente = new BLSolicitudCliente();

                    return blSolicitudCliente.InsertarSolicitudCliente(paisID, entidadSolicitud);
                }
            }
            catch (Exception ex)
            {
                mensaje = ex.Message.ToString();
                return new BEResultadoSolicitud(resultado, mensaje);
            }
        }

        public BEResultadoSolicitud InsertarSolicitudClienteAppCatalogo(string prefijoISO, BESolicitudClienteAppCatalogo entidadSolicitud)
        {
            int resultado = 0;
            try
            {
                if (prefijoISO == null || prefijoISO == string.Empty) return new BEResultadoSolicitud(resultado, "Debe ingresar el código ISO de País.");
                if (prefijoISO.Length > 2) return new BEResultadoSolicitud(resultado, "El código ISO de País no puede exceder los 5 caracteres.");
                if (entidadSolicitud == null) return new BEResultadoSolicitud(resultado, "No se ha creado el objeto de solicitud.");

                int paisID = GetPaisID(prefijoISO);
                BLSolicitudCliente blSolicitudCliente = new BLSolicitudCliente();
                return blSolicitudCliente.InsertarSolicitudClienteAppCatalogo(paisID, entidadSolicitud);
            }
            catch (Exception ex) { return new BEResultadoSolicitud(resultado, ex.Message); }
        }

        #region AppCatalogo

        public BEResultadoMisPedidosAppCatalogo GetPedidosAppCatalogo(string prefijoISO, long consultoraID, string dispositivoID, int tipoUsuario, int campania)
        {
            Boolean error = true;
            try
            {
                if (prefijoISO == null || prefijoISO == string.Empty) return new BEResultadoMisPedidosAppCatalogo(error, "Debe ingresar el código ISO de País.");
                if (prefijoISO.Length > 2) return new BEResultadoMisPedidosAppCatalogo(error, "El código ISO de País no puede exceder los 2 caracteres.");
                if (tipoUsuario == 1 && (dispositivoID == null || dispositivoID == string.Empty)) return new BEResultadoMisPedidosAppCatalogo(error, "Debe ingresar el código del dispositivo.");
                if (tipoUsuario == 2 && consultoraID == 0) return new BEResultadoMisPedidosAppCatalogo(error, "Debe ingresar el código de consultora.");

                int paisID = GetPaisID(prefijoISO);
                BLSolicitudCliente blSolicitudCliente = new BLSolicitudCliente();
                return blSolicitudCliente.GetPedidosAppCatalogo(paisID, consultoraID, dispositivoID, tipoUsuario, campania);
            }
            catch (Exception ex) { return new BEResultadoMisPedidosAppCatalogo(error, ex.Message);}
        }

        public BEResultadoPedidoDetalleAppCatalogo GetPedidoDetalleAppCatalogo(string prefijoISO, long pedidoID)
        {
            Boolean error = true;
            try
            {
                if (prefijoISO == null || prefijoISO == string.Empty) return new BEResultadoPedidoDetalleAppCatalogo(error, "Debe ingresar el código ISO de País.");
                if (prefijoISO.Length > 2) return new BEResultadoPedidoDetalleAppCatalogo(error, "El código ISO de País no puede exceder los 2 caracteres.");
                if ( pedidoID == 0) return new BEResultadoPedidoDetalleAppCatalogo(error, "Debe ingresar el código del Pedido.");

                int paisID = GetPaisID(prefijoISO);
                BLSolicitudCliente blSolicitudCliente = new BLSolicitudCliente();
                return blSolicitudCliente.GetPedidoDetalle(paisID, pedidoID);
            }
            catch (Exception ex) { return new BEResultadoPedidoDetalleAppCatalogo(error, ex.Message); }
        }

        #endregion

        #region ShowRoom

        public BEShowRoomEvento GetShowRoomEventoByCampaniaID(int paisID, int campaniaID)
        {
            return BLShowRoomEvento.GetShowRoomEventoByCampaniaID(paisID, campaniaID);
        }

        public int InsertShowRoomEvento(int paisID, BEShowRoomEvento beShowRoomEvento)
        {
            return BLShowRoomEvento.InsertShowRoomEvento(paisID, beShowRoomEvento);
        }

        public void UpdateShowRoomEvento(int paisID, BEShowRoomEvento beShowRoomEvento)
        {
            BLShowRoomEvento.UpdateShowRoomEvento(paisID, beShowRoomEvento);
        }

        public int CargarMasivaConsultora(int paisID, List<BEShowRoomEventoConsultora> listaConsultora)
        {
            return BLShowRoomEvento.CargarMasivaConsultora(paisID, listaConsultora);
        }

        public int UpdOfertaShowRoomStockMasivo(int paisID, List<BEShowRoomOferta> stockProductos)
        {
            return BLShowRoomEvento.UpdOfertaShowRoomStockMasivo(paisID, stockProductos);
        }
        
        public int CargarMasivaDescripcionSets(int paisID, int campaniaID, string usuarioCreacion, List<BEShowRoomOfertaDetalle> listaShowRoomOfertaDetalle, string nombreArchivoCargado, string nombreArchivoGuardado)
        {
            return BLShowRoomEvento.CargarMasivaDescripcionSets(paisID, campaniaID, usuarioCreacion, listaShowRoomOfertaDetalle, nombreArchivoCargado, nombreArchivoGuardado);
        }

        public int CargarProductoCpc(int paisId, int eventoId, string usuarioCreacion, List<BEShowRoomCompraPorCompra> listaShowRoomCompraPorCompra)
        {
            return BLShowRoomEvento.CargarProductoCpc(paisId, eventoId, usuarioCreacion, listaShowRoomCompraPorCompra);
        }

        public BEShowRoomEventoConsultora GetShowRoomConsultora(int paisID, int campaniaID, string codigoConsultora, bool tienePersonalizacion)
        {
            return BLShowRoomEvento.GetShowRoomConsultora(paisID, campaniaID, codigoConsultora, tienePersonalizacion);
        }

        public void UpdateShowRoomConsultoraMostrarPopup(int paisID, int campaniaID, string codigoConsultora, bool mostrarPopup)
        {
            BLShowRoomEvento.UpdateShowRoomConsultoraMostrarPopup(paisID, campaniaID, codigoConsultora, mostrarPopup);
        }

        public IList<BEShowRoomOferta> GetProductosShowRoom(int paisID, int campaniaID)
        {
            return BLShowRoomEvento.GetProductosShowRoom(paisID, campaniaID);
        }

        public int GetOrdenPriorizacionShowRoom(int paisID, int ConfiguracionOfertaID, int CampaniaID)
        {
            return BLShowRoomEvento.GetOrdenPriorizacionShowRoom(paisID, ConfiguracionOfertaID, CampaniaID);
        }

        public int ValidarPriorizacionShowRoom(int paisID, int ConfiguracionOfertaID, int CampaniaID, int Orden)
        {
            return BLShowRoomEvento.ValidarPriorizacionShowRoom(paisID, ConfiguracionOfertaID, CampaniaID, Orden);
        }

        public int ValidadStockOfertaShowRoom(int paisID, BEShowRoomOferta entity)
        {
            return BLShowRoomEvento.ValidadStockOfertaShowRoom(paisID, entity);
        }

        public int InsOfertaShowRoom(int paisID, BEShowRoomOferta entity)
        {
            return BLShowRoomEvento.InsOfertaShowRoom(paisID, entity);
        }

        public int UpdOfertaShowRoom(int paisID, BEShowRoomOferta entity)
        {
            return BLShowRoomEvento.UpdOfertaShowRoom(paisID, entity);
        }

        public int DelOfertaShowRoom(int paisID, BEShowRoomOferta entity)
        {
            return BLShowRoomEvento.DelOfertaShowRoom(paisID, entity);
        }

        public int InsOrUpdOfertaShowRoom(int paisID, BEShowRoomOferta entity)
        {
            return BLShowRoomEvento.InsOrUpdOfertaShowRoom(paisID, entity);
        }

        public int RemoverOfertaShowRoom(int paisID, BEShowRoomOferta entity)
        {
            return BLShowRoomEvento.RemoverOfertaShowRoom(paisID, entity);
        }

        public int GetUnidadesPermitidasByCuvShowRoom(int paisID, int CampaniaID, string CUV)
        {
            return BLShowRoomEvento.GetUnidadesPermitidasByCuvShowRoom(paisID, CampaniaID, CUV);
        }

        public int ValidarUnidadesPermitidasEnPedidoShowRoom(int PaisID, int CampaniaID, string CUV, long ConsultoraID)
        {
            return BLShowRoomEvento.ValidarUnidadesPermitidasEnPedidoShowRoom(PaisID, CampaniaID, CUV, ConsultoraID);
        }

        public int CantidadPedidoByConsultoraShowRoom(BEOfertaProducto entidad)
        {
            return BLShowRoomEvento.CantidadPedidoByConsultoraShowRoom(entidad);
        }

        public int GetStockOfertaShowRoom(int paisID, int CampaniaID, string CUV)
        {
            return BLShowRoomEvento.GetStockOfertaShowRoom(paisID, CampaniaID, CUV);
        }

        public int DeshabilitarShowRoomEvento(int paisID, BEShowRoomEvento beShowRoomEvento)
        {
            return BLShowRoomEvento.DeshabilitarShowRoomEvento(paisID, beShowRoomEvento);
        }

        public int EliminarShowRoomEvento(int paisID, BEShowRoomEvento beShowRoomEvento)
        {
            return BLShowRoomEvento.EliminarShowRoomEvento(paisID, beShowRoomEvento);
        }

        public int GuardarImagenShowRoom(int paisID, int eventoId, string nombreImagenFinal, int tipo, string usuarioModificacion)
        {
            return BLShowRoomEvento.GuardarImagenShowRoom(paisID, eventoId, nombreImagenFinal, tipo, usuarioModificacion);
        }

        public IList<BEShowRoomOfertaDetalle> GetProductosShowRoomDetalle(int paisID, int campaniaId, string cuv)
        {
            return BLShowRoomEvento.GetProductosShowRoomDetalle(paisID, campaniaId, cuv);
        }

        public int InsOfertaShowRoomDetalle(int paisID, BEShowRoomOfertaDetalle entity)
        {
            return BLShowRoomEvento.InsOfertaShowRoomDetalle(paisID, entity);
        }

        public int UpdOfertaShowRoomDetalle(int paisID, BEShowRoomOfertaDetalle entity)
        {
            return BLShowRoomEvento.UpdOfertaShowRoomDetalle(paisID, entity);
        }

        public int EliminarOfertaShowRoomDetalle(int paisID, BEShowRoomOfertaDetalle beShowRoomOfertaDetalle)
        {
            return BLShowRoomEvento.EliminarOfertaShowRoomDetalle(paisID, beShowRoomOfertaDetalle);
        }

        public int EliminarOfertaShowRoomDetalleAll(int paisID, int campaniaID, string cuv)
        {
            return BLShowRoomEvento.EliminarOfertaShowRoomDetalleAll(paisID, campaniaID, cuv);
        }

        public IList<BEShowRoomPerfil> GetShowRoomPerfiles(int paisId, int eventoId)
        {
            return BLShowRoomEvento.GetShowRoomPerfiles(paisId, eventoId);
        }

        public IList<BEShowRoomPerfilOferta> GetShowRoomPerfilOfertaCuvs(int paisId, BEShowRoomPerfilOferta beShowRoomPerfilOferta)
        {
            return BLShowRoomEvento.GetShowRoomPerfilOfertaCuvs(paisId, beShowRoomPerfilOferta);
        }

        public void GuardarPerfilOfertaShowRoom(int paisId, int perfilId, int eventoId, int campaniaId, string cadenaCuv)
        {
            BLShowRoomEvento.GuardarPerfilOfertaShowRoom(paisId, perfilId, eventoId, campaniaId, cadenaCuv);
        }

        public IList<BEShowRoomOferta> GetShowRoomOfertasConsultora(int paisID, int campaniaID, string codigoConsultora, bool tienePersonalizacion)
        {
            return BLShowRoomEvento.GetShowRoomOfertasConsultora(paisID, campaniaID, codigoConsultora, tienePersonalizacion);
        }

        public BEShowRoomOferta GetShowRoomOfertaById(int paisID, int ofertaShowRoomID)
        {
            return BLShowRoomEvento.GetShowRoomOfertaById(paisID, ofertaShowRoomID);
        }

        public IList<BEShowRoomNivel> GetShowRoomNivel(int paisId)
        {
            return BLShowRoomEvento.GetShowRoomNivel(paisId);
        }

        public IList<BEShowRoomPersonalizacion> GetShowRoomPersonalizacion(int paisId)
        {
            return BLShowRoomEvento.GetShowRoomPersonalizacion(paisId);
        }

        public IList<BEShowRoomPersonalizacionNivel> GetShowRoomPersonalizacionNivel(int paisId, int eventoId,
            int nivelId, int categoriaId)
        {
            return BLShowRoomEvento.GetShowRoomPersonalizacionNivel(paisId, eventoId, nivelId, categoriaId);
        }

        public int InsertShowRoomPersonalizacionNivel(int paisId, BEShowRoomPersonalizacionNivel beShowRoomPersonalizacionNivel)
        {
            return BLShowRoomEvento.InsertShowRoomPersonalizacionNivel(paisId, beShowRoomPersonalizacionNivel);
        }

        public int UpdateShowRoomPersonalizacionNivel(int paisId, BEShowRoomPersonalizacionNivel beShowRoomPersonalizacionNivel)
        {
            return BLShowRoomEvento.UpdateShowRoomPersonalizacionNivel(paisId, beShowRoomPersonalizacionNivel);
        }

        public List<BEShowRoomCategoria> GetShowRoomCategorias(int paisId, int eventoId)
        {
            return BLShowRoomEvento.GetShowRoomCategorias(paisId, eventoId);
        }

        public BEShowRoomCategoria GetShowRoomCategoriaById(int paisId, int categoriaId)
        {
            return BLShowRoomEvento.GetShowRoomCategoriaById(paisId, categoriaId);
        }

        public void UpdateShowRoomDescripcionCategoria(int paisId, BEShowRoomCategoria categoria)
        {
            BLShowRoomEvento.UpdateShowRoomDescripcionCategoria(paisId, categoria);
        }

        public void DeleteInsertShowRoomCategoriaByEvento(int paisId, int eventoId, List<BEShowRoomCategoria> listaCategoria)
        {
            BLShowRoomEvento.DeleteInsertShowRoomCategoriaByEvento(paisId, eventoId, listaCategoria);
        }

        public List<BEShowRoomOferta> GetProductosCompraPorCompra(int paisId, int EventoID, int CampaniaID)
        {
            return BLShowRoomEvento.GetProductosCompraPorCompra(paisId, EventoID, CampaniaID);
        }

        public IList<BEShowRoomTipoOferta> GetShowRoomTipoOferta(int paisID)
        {
            return BLShowRoomEvento.GetShowRoomTipoOferta(paisID);
        }

        public int ExisteShowRoomTipoOferta(int paisId, BEShowRoomTipoOferta entity)
        {
            return BLShowRoomEvento.ExisteShowRoomTipoOferta(paisId, entity);
        }

        public int InsertShowRoomTipoOferta(int paisId, BEShowRoomTipoOferta entity)
        {
            return BLShowRoomEvento.InsertShowRoomTipoOferta(paisId, entity);
        }

        public int UpdateShowRoomTipoOferta(int paisId, BEShowRoomTipoOferta entity)
        {
            return BLShowRoomEvento.UpdateShowRoomTipoOferta(paisId, entity);
        }

        public void HabilitarShowRoomTipoOferta(int paisId, BEShowRoomTipoOferta entity)
        {
            BLShowRoomEvento.HabilitarShowRoomTipoOferta(paisId, entity);
        }

        #endregion

        #region Producto SUgerido

        public IList<BEProductoSugerido> GetPaginateProductoSugerido(int PaisID, int CampaniaID, string CUVAgotado, string CUVSugerido)
        {
            return BLProductoSugerido.GetPaginateProductoSugerido(PaisID, CampaniaID, CUVAgotado, CUVSugerido);
        }

        public BEMatrizComercial GetMatrizComercialByCampaniaAndCUV(int paisID, int campaniaID, string cuv)
        {
            return BLProductoSugerido.GetMatrizComercialByCampaniaAndCUV(paisID, campaniaID, cuv);
        }

        public string InsProductoSugerido(int paisID, BEProductoSugerido entity)
        {
            return BLProductoSugerido.InsProductoSugerido(paisID, entity);
        }

        public string UpdProductoSugerido(int paisID, BEProductoSugerido entity)
        {
            return BLProductoSugerido.UpdProductoSugerido(paisID, entity);
        }

        public string DelProductoSugerido(int paisID, BEProductoSugerido entity)
        {
            return BLProductoSugerido.DelProductoSugerido(paisID, entity);
        }
        #endregion

        #region

        public BEConfiguracionProgramaNuevas GetConfiguracionProgramaNuevas(int paisID, BEConfiguracionProgramaNuevas entity)
        {
            return BLConfiguracionProgramaNuevas.GetConfiguracionProgramaNuevas(paisID, entity);
        }

        public BEConfiguracionProgramaNuevas GetConfiguracionProgramaDespuesPrimerPedido(int paisID, BEConfiguracionProgramaNuevas entity)
        {
            return BLConfiguracionProgramaNuevas.GetConfiguracionProgramaDespuesPrimerPedido(paisID, entity);
        }

        #endregion

        public void UpdateMontosPedidoWeb(BEPedidoWeb bePedidoWeb)
        {
            BLPedidoWeb.UpdateMontosPedidoWeb(bePedidoWeb);
        }

        public BEPedidoWeb GetPedidosWebByConsultoraCampania(int paisID, int consultoraID, int campaniaID)
        {
            return BLPedidoWeb.GetPedidosWebByConsultoraCampania(paisID, consultoraID, campaniaID);
        }

        public List<BEPedidoWeb> GetPedidosFacturados(int paisId, string codigoConsultora)
        {
            return BLPedidoWeb.GetPedidosFacturados(paisId, codigoConsultora);
        }

        public List<BEPedidoWeb> GetPedidosIngresadoFacturado(int paisID, int consultoraID, int campaniaID, string codigoConsultora, int top)
        {
            return BLPedidoWeb.GetPedidosIngresadoFacturado(paisID, consultoraID, campaniaID, codigoConsultora, top);
        }

        public List<BEPedidoWeb> GetPedidosIngresadoFacturadoWebMobile(int paisID, int consultoraID, int campaniaID, int clienteID, int top, string codigoConsultora)
        {
            return BLPedidoWeb.GetPedidosIngresadoFacturadoWebMobile(paisID, consultoraID, campaniaID, clienteID, top, codigoConsultora);
        }

        public void InsertarLogPedidoWeb(int PaisID, int CampaniaID, string CodigoConsultora, int PedidoId, string Accion, string CodigoUsuario)
        {
            BLPedidoWeb.InsertarLogPedidoWeb(PaisID, CampaniaID, CodigoConsultora, PedidoId, Accion, CodigoUsuario);
        }

        public BEConsultorasProgramaNuevas GetConsultorasProgramaNuevas(int paisID, BEConsultorasProgramaNuevas entity)
        {
            return BLConsultorasProgramaNuevas.GetConsultorasProgramaNuevas(paisID, entity);
        }

        public List<BEMensajeMetaConsultora> GetMensajeMetaConsultora(int paisID, BEMensajeMetaConsultora entity)
        {
            return BLMensajeMetaConsultora.GetMensajeMetaConsultora(paisID, entity);
        }

        public string GetImagenOfertaPersonalizadaOF(int paisID, int campaniaID, string cuv)
        {
            return new BLEstrategia().GetImagenOfertaPersonalizadaOF(paisID, campaniaID, cuv);
        }

        public BEProcesoPedidoRechazado ObtenerProcesoPedidoRechazadoGPR(int paisID, int campaniaID, long consultoraID)
        {
            return BLProcesoPedidoRechazado.ObtenerProcesoPedidoRechazadoGPR(paisID, campaniaID, consultoraID);
        }
        
        public void InsLogOfertaFinal(int PaisID, BEOfertaFinalConsultoraLog entidad)
        {
            BLPedidoWeb.InsLogOfertaFinal(PaisID, entidad);
        }

        public void InsLogOfertaFinalBulk(int PaisID, List<BEOfertaFinalConsultoraLog> lista)
        {
            BLPedidoWeb.InsLogOfertaFinalBulk(PaisID, lista);
        }

        public List<BEPedidoWeb> GetPedidosFacturadoSegunDias(int paisID, int campaniaID, long consultoraID, int maxDias)
        {
            return BLPedidoWeb.GetPedidosFacturadoSegunDias(paisID, campaniaID, consultoraID, maxDias);
        }

        public void ActualizarIndicadorGPRPedidosRechazados(int PaisID, long ProcesoID)
        {
            BLPedidoWeb.ActualizarIndicadorGPRPedidosRechazados(PaisID, ProcesoID);
        }
        public void ActualizarIndicadorGPRPedidosFacturados(int PaisID, long ProcesoID)
        {
            BLPedidoWeb.ActualizarIndicadorGPRPedidosFacturados(PaisID, ProcesoID);
        }

        public BEPedidoDescarga ObtenerUltimaDescargaPedido(int PaisID)
        {
            return BLPedidoWeb.ObtenerUltimaDescargaPedido(PaisID);
        }

        public BEPedidoDescarga ObtenerUltimaDescargaExitosa(int PaisID)
        {
            return BLPedidoWeb.ObtenerUltimaDescargaExitosa(PaisID);
        }

        public void DeshacerUltimaDescargaPedido(int PaisID)
        {
            BLPedidoWeb.DeshacerUltimaDescargaPedido(PaisID);
        }
        
        public int GetCantidadOfertasParaTi(int paisId, int campaniaId, int tipoConfigurado, int estrategiaId)
        {
            return new BLEstrategia().GetCantidadOfertasParaTi(paisId, campaniaId, tipoConfigurado, estrategiaId);
        }

        public List<BEEstrategia> GetOfertasParaTiByTipoConfigurado(int paisId, int campaniaId, int tipoConfigurado, string estrategiaCodigo)
        {
            return new BLEstrategia().GetOfertasParaTiByTipoConfigurado(paisId, campaniaId, tipoConfigurado, estrategiaCodigo);
        }

        public int InsertEstrategiaTemporal(int paisId, List<BEEstrategia> lista, int campaniaId, string codigoUsuario)
        {
            return new BLEstrategia().InsertEstrategiaTemporal(paisId, lista, campaniaId, codigoUsuario);
        }

        public int GetCantidadOfertasParaTiTemporal(int paisId, int campaniaId, int tipoConfigurado)
        {
            return new BLEstrategia().GetCantidadOfertasParaTiTemporal(paisId, campaniaId, tipoConfigurado);
        }

        public List<BEEstrategia> GetOfertasParaTiByTipoConfiguradoTemporal(int paisId, int campaniaId, int tipoConfigurado)
        {
            return new BLEstrategia().GetOfertasParaTiByTipoConfiguradoTemporal(paisId, campaniaId, tipoConfigurado);
        }

        public int DeleteEstrategiaTemporal(int paisId, int campaniaId)
        {
            return new BLEstrategia().DeleteEstrategiaTemporal(paisId, campaniaId);
        }

        public int InsertEstrategiaOfertaParaTi(int paisId, List<BEEstrategia> lista, int campaniaId, string codigoUsuario, int estrategiaId)
        {
            return new BLEstrategia().InsertEstrategiaOfertaParaTi(paisId, lista, campaniaId, codigoUsuario, estrategiaId);
        }

        public List<BEEstrategia> GetEstrategiaODD(int paisID, int codCampania, string codConsultora, DateTime fechaInicioFact)
        {
            return blEstrategia.GetEstrategiaODD(paisID, codCampania, codConsultora, fechaInicioFact);
        }

        public int ActivarDesactivarEstrategias(int PaisID, string Usuario, string EstrategiasActivas, string EstrategiasDesactivas)
        {
            return new BLEstrategia().ActivarDesactivarEstrategias(PaisID, Usuario, EstrategiasActivas, EstrategiasDesactivas);
        }

        public int UpdEventoConsultoraPopup(int paisID, BEShowRoomEventoConsultora entity, string tipo)
        {
            return new BLShowRoomEvento().UpdEventoConsultoraPopup(paisID, entity, tipo);
        }

        public int InsertarEstrategiaProducto(BEEstrategiaProducto entidad)
        {
            return new BLEstrategiaProducto().InsertEstrategiaProducto(entidad);
        }

        public List<BEEstrategiaProducto> GetEstrategiaProducto(BEEstrategia entidad)
        {
            return new BLEstrategiaProducto().GetEstrategiaProducto(entidad);
        }

        public int ShowRoomProgramarAviso(int paisID, BEShowRoomEventoConsultora entity)
        {
            return new BLShowRoomEvento().ShowRoomProgramarAviso(paisID, entity);
        }

        public BEValidacionModificacionPedido ValidacionModificarPedido(int paisID, long consultoraID, int campania, bool usuarioPrueba, int aceptacionConsultoraDA)
        {
            return BLPedidoWeb.ValidacionModificarPedido(paisID, consultoraID, campania, usuarioPrueba, aceptacionConsultoraDA);
        }

        public BEValidacionModificacionPedido ValidacionModificarPedidoSelectiva(int paisID, long consultoraID, int campania, bool usuarioPrueba, int aceptacionConsultoraDA, bool validarGPR, bool validarReservado, bool validarHorario)
        {
            return BLPedidoWeb.ValidacionModificarPedido(paisID, consultoraID, campania, usuarioPrueba, aceptacionConsultoraDA, validarGPR, validarReservado, validarHorario);
        }

        public int UpdShowRoomEventoConsultoraEmailRecibido(int paisID, BEShowRoomEventoConsultora entity)
        {
            return new BLShowRoomEvento().UpdShowRoomEventoConsultoraEmailRecibido(paisID, entity);
        }

        public bool GetEventoConsultoraRecibido(int paisID, string CodigoConsultora, int CampaniaID)
        {
            return new BLShowRoomEvento().GetEventoConsultoraRecibido(paisID, CodigoConsultora, CampaniaID);
        }

        public BEResultadoReservaProl CargarSesionAndEjecutarReservaProl(string paisISO, int campania, long consultoraID, bool usuarioPrueba, int aceptacionConsultoraDA, bool esMovil, bool enviarCorreo)
        {
            return new BLReservaProl().CargarSesionAndEjecutarReservaProl(paisISO, campania, consultoraID, usuarioPrueba, aceptacionConsultoraDA, esMovil, enviarCorreo);
        }

        public BEResultadoReservaProl EjecutarReservaProl(BEInputReservaProl input)
        {
            return new BLReservaProl().EjecutarReservaProl(input);
        }

        public int InsMatrizComercialImagen(BEMatrizComercialImagen entity)
        {
            return new BLOfertaProducto().InsMatrizComercialImagen(entity);
        }

        public int UpdMatrizComercialImagen(BEMatrizComercialImagen entity)
        {
            return new BLOfertaProducto().UpdMatrizComercialImagen(entity);
        }

        public bool EnviarCorreoReservaProl(BEInputReservaProl input)
        {
            return new BLReservaProl().EnviarCorreoReservaProl(input);
        }

        public int InsertarDesglose(BEInputReservaProl input)
        {
            return new BLReservaProl().InsertarDesglose(input);
        }

        public string CargarSesionAndDeshacerPedidoValidado(string paisISO, int campania, long consultoraID, bool usuarioPrueba, int aceptacionConsultoraDA, string tipo)
        {
            return new BLReservaProl().CargarSesionAndDeshacerPedidoValidado(paisISO, campania, consultoraID, usuarioPrueba, aceptacionConsultoraDA, tipo);
        }

        public string DeshacerPedidoValidado(BEUsuario usuario, string tipo)
        {
            return new BLReservaProl().DeshacerPedidoValidado(usuario, tipo);
        }
        
        public string GetTokenIndicadorPedidoAutentico(int paisID, string paisISO, string codigoRegion, string codigoZona)
        {
            return BLPedidoWeb.GetTokenIndicadorPedidoAutentico(paisID, paisISO, codigoRegion, codigoZona);
        }

        public int InsIndicadorPedidoAutentico(int paisID, BEIndicadorPedidoAutentico entidad)
        {
            return BLPedidoWeb.InsIndicadorPedidoAutentico(paisID, entidad);
        }

        public int UpdMatrizComercialNemotecnico(BEMatrizComercialImagen entity)
        {
            return new BLOfertaProducto().UpdMatrizComercialNemotecnico(entity);
        }

        public int UpdMatrizComercialDescripcionComercial(BEMatrizComercialImagen entity)
        {
            return new BLOfertaProducto().UpdMatrizComercialDescripcionComercial(entity);
        }

        public BEConsultoraRegaloProgramaNuevas GetConsultoraRegaloProgramaNuevas(int paisID, int campaniaId, string codigoConsultora, string codigoRegion, string codigoZona)
        {
            return new BLPedidoWeb().GetConsultoraRegaloProgramaNuevas(paisID, campaniaId, codigoConsultora, codigoRegion, codigoZona);
        }

        #region Cupon

        public BECuponConsultora GetCuponConsultoraByCodigoConsultoraCampaniaId(int paisId, BECuponConsultora cuponConsultora)
        {
            return BLCuponConsultora.GetCuponConsultoraByCodigoConsultoraCampaniaId(paisId, cuponConsultora);
        }

        public void UpdateCuponConsultoraEstadoCupon(int paisId, BECuponConsultora cuponConsultora)
        {
            BLCuponConsultora.UpdateCuponConsultoraEstadoCupon(paisId, cuponConsultora);
        }
        
        public void UpdateCuponConsultoraEnvioCorreo(int paisId, BECuponConsultora cuponConsultora)
        {
            BLCuponConsultora.UpdateCuponConsultoraEnvioCorreo(paisId, cuponConsultora);
        }

        public void CrearCupon(int paisId, BECupon cupon)
        {
            BLCupon.CrearCupon(paisId, cupon);
        }

        public void ActualizarCupon(int paisId, BECupon cupon)
        {
            BLCupon.ActualizarCupon(paisId, cupon);
        }

        public List<BECupon> ListarCuponesPorCampania(int paisId, int campaniaId)
        {
            var listaCupones = BLCupon.ListarCuponesPorCampania(paisId, campaniaId);
            return listaCupones;
        }

        #endregion

        #region Cupon Consultoras

        public void CrearCuponConsultora(int paisId, BECuponConsultora cuponConsultora)
        {
            BLCuponConsultora.CrearCuponConsultora(paisId, cuponConsultora);
        }

        public void ActualizarCuponConsultora(int paisId, BECuponConsultora cuponConsultora)
        {
            BLCuponConsultora.ActualizarCuponConsultora(paisId, cuponConsultora);
        }
        
        public List<BEReporteValidacionSRCampania> GetReporteShowRoomCampania(int paisID, int campaniaID)
        {
            return new BLReporteValidacion().GetReporteShowRoomCampania(paisID, campaniaID).ToList();
        }

        public List<BECuponConsultora> ListarCuponConsultorasPorCupon(int paisId, int cuponId)
        {
            var listaCuponConsultoras = BLCuponConsultora.ListarCuponConsultorasPorCupon(paisId, cuponId);
            return listaCuponConsultoras;
        }
        
        public List<BEReporteValidacionSRPersonalizacion> GetReporteShowRoomPersonalizacion(int paisID, int campaniaID)
        {
            return new BLReporteValidacion().GetReporteShowRoomPersonalizacion(paisID, campaniaID).ToList();
        }

        public void InsertarCuponConsultorasXML(int paisId, int cuponId, int campaniaId, List<BECuponConsultora> listaCuponConsultoras)
        {
            BLCuponConsultora.InsertarCuponConsultorasXML(paisId, cuponId, campaniaId, listaCuponConsultoras);
        }

        public List<BEReporteValidacionSROferta> GetReporteShowRoomOferta(int paisID, int campaniaID)
        {
            return new BLReporteValidacion().GetReporteShowRoomOferta(paisID, campaniaID).ToList();
        }

        public int RDSuscripcion(BERevistaDigitalSuscripcion entidad)
        {
            return BLRevistaDigitalSuscripcion.Suscripcion(entidad);
        }
        
        public List<BEReporteValidacionSRComponentes> GetReporteShowRoomComponentes(int paisID, int campaniaID)
        {
            return new BLReporteValidacion().GetReporteShowRoomComponentes(paisID, campaniaID).ToList();
        }

        public int RDDesuscripcion(BERevistaDigitalSuscripcion entidad)
        {
            return BLRevistaDigitalSuscripcion.Desuscripcion(entidad);
        }

        public BERevistaDigitalSuscripcion RDGetSuscripcion(BERevistaDigitalSuscripcion entidad)
        {
            return BLRevistaDigitalSuscripcion.Single(entidad);
        }

        public BERevistaDigitalSuscripcion RDGetSuscripcionActiva(BERevistaDigitalSuscripcion entidad)
        {
            return BLRevistaDigitalSuscripcion.SingleActiva(entidad);
        }

        public BEConsultoraResumen ObtenerResumen(int paisId, int codigoCampania, long consultoraId)
        {
            return BLPedidoWeb.GetResumen(paisId, (int)consultoraId, codigoCampania);
        }
        
        public List<BEReporteValidacion> GetReporteValidacion(int paisID, int campaniaID, int tipoEstrategia)
        {
            return new BLReporteValidacion().GetReporteValidacion(paisID, campaniaID, tipoEstrategia).ToList();
        }
        #endregion

        #region Incentivos
        public List<BEIncentivoConcurso> ObtenerConcursosXConsultora(int PaisID, string CodigoCampania, string CodigoConsultora, string CodigoRegion, string CodigoZona)
        {
            return _consultoraConcursoBusinessLogic.ObtenerConcursosXConsultora(PaisID, CodigoCampania, CodigoConsultora, CodigoRegion, CodigoZona).ToList();
        }

        public void ActualizarInsertarPuntosConcurso(int PaisID, string CodigoConsultora, string CodigoCampania, string CodigoConcursos, string PuntosConcursos, string PuntosExigidosConcurso)
        {
            _consultoraConcursoBusinessLogic.ActualizarInsertarPuntosConcurso(PaisID, CodigoConsultora, CodigoCampania, CodigoConcursos, PuntosConcursos, PuntosExigidosConcurso);
        }

        public List<BEConsultoraConcurso> ObtenerPuntosXConsultoraConcurso(int PaisID, string CodigoCampania, string CodigoConsultora)
        {
            return _consultoraConcursoBusinessLogic.ObtenerPuntosXConsultoraConcurso(PaisID, CodigoCampania, CodigoConsultora);
        }

        public List<BEConsultoraConcurso> ListConcursosVigentes(int paisId, string codigoCampania, string codigoConsultora)
        {
            return _consultoraConcursoBusinessLogic.ListConcursosVigentes(paisId, codigoCampania, codigoConsultora);
        }

        public List<BEConsultoraConcurso> ListConcursosByCampania(int paisId, string codigoCampaniaActual, string codigoCampania, string tipoConcurso, string codigoConsultora)
        {
            return _consultoraConcursoBusinessLogic.ListConcursosByCampania(paisId, codigoCampania, codigoCampania, tipoConcurso, codigoConsultora);
        }
        public List<BEIncentivoConcurso> ObtenerIncentivosConsultora(int paisID, string codigoConsultora, int codigoCampania, long ConsultoraID)
        {
            return _consultoraConcursoBusinessLogic.ObtenerIncentivosConsultora(paisID, codigoConsultora, codigoCampania, ConsultoraID);
        }

        public List<BEIncentivoConcurso> ObtenerIncentivosHistorico(int paisID, string codigoConsultora, int codigoCampania)
        {
            return _consultoraConcursoBusinessLogic.ObtenerIncentivosHistorico(paisID, codigoConsultora, codigoCampania);
        }
        #endregion

        #region Producto Comentario
        public int InsertarProductoComentarioDetalle(int paisID, BEProductoComentarioDetalle entidad)
        {
            return blEstrategia.InsertarProductoComentarioDetalle(paisID, entidad);
        }
        
        public BEProductoComentario GetProductoComentarioByCodigoSap(int paisID, string codigoSap)
        {
            return blEstrategia.GetProductoComentarioByCodSap(paisID, codigoSap);
        }

        public BEProductoComentarioDetalle GetUltimoProductoComentarioByCodigoSap(int paisID, string codigoSap)
        {
            return blEstrategia.GetUltimoProductoComentarioByCodigoSap(paisID, codigoSap);
        }

        public List<BEProductoComentarioDetalle> GetListaProductoComentarioDetalleResumen(int paisID, BEProductoComentarioFilter filter)
        {
            return blEstrategia.GetListaProductoComentarioDetalleResumen(paisID, filter);
        }

        public List<BEProductoComentarioDetalle> GetListaProductoComentarioDetalleAprobar(int paisID, BEProductoComentarioFilter filter)
        {
            return blEstrategia.GetListaProductoComentarioDetalleAprobar(paisID, filter);
        }

        public int AprobarProductoComentarioDetalle(int paisID, BEProductoComentarioDetalle entidad)
        {
            return blEstrategia.AprobarProductoComentarioDetalle(paisID, entidad);
        }

        #endregion

        #region FichaProducto
        public List<BEFichaProducto> GetFichaProducto(BEFichaProducto entidad)
        {
            return blFichaProducto.GetFichaProducto(entidad);
        }
        #endregion

        #region MisPedidos
        public List<BEMisPedidosCampania> GetMisPedidosByCampania(int paisID, long ConsultoraID, int CampaniaID, int ClienteID, int Top)
        {
            return _pedidoWebBusinessLogic.GetMisPedidosByCampania(paisID, ConsultoraID, CampaniaID, ClienteID, Top);
        }
        public List<BEMisPedidosIngresados> GetMisPedidosIngresados(int paisID, long ConsultoraID, int CampaniaID, int ClienteID, string NombreConsultora)
        {
            return _pedidoWebBusinessLogic.GetMisPedidosIngresados(paisID, ConsultoraID, CampaniaID, ClienteID, NombreConsultora);
        }
        public List<BEMisPedidosFacturados> GetMisPedidosFacturados(int paisID, long ConsultoraID, int CampaniaID, int ClienteID, string NombreConsultora)
        {
            return _pedidoWebBusinessLogic.GetMisPedidosFacturados(paisID, ConsultoraID, CampaniaID, ClienteID, NombreConsultora);
        }
        #endregion

        #region CargaMasivaImagenes

        public List<BECargaMasivaImagenes> GetListaImagenesEstrategiasByCampania(int paisId, int campaniaId)
        {
            return blEstrategia.GetListaImagenesEstrategiasByCampania(paisId, campaniaId);
        }

        public List<BECargaMasivaImagenes> GetListaImagenesOfertaLiquidacionByCampania(int paisId, int campaniaId)
        {
            return blEstrategia.GetListaImagenesOfertaLiquidacionByCampania(paisId, campaniaId);
        }

        public List<BECargaMasivaImagenes> GetListaImagenesProductoSugeridoByCampania(int paisId, int campaniaId)
        {
            return blEstrategia.GetListaImagenesProductoSugeridoByCampania(paisId, campaniaId);
        }

        #endregion

        #region ProductosPrecargados
        public int GetFlagProductosPrecargados(int paisID, string CodigoConsultora, int CampaniaID)
        {
            return BLPedidoWeb.GetFlagProductosPrecargados(paisID, CodigoConsultora, CampaniaID);
        }

        public void UpdateMostradoProductosPrecargados(int paisID, int CampaniaID, long ConsultoraID, string IPUsuario)
        {
            BLPedidoWeb.UpdateMostradoProductosPrecargados(paisID, CampaniaID, ConsultoraID, IPUsuario);
        }
        #endregion  
        
        #region ConfiguracionProgramaNuevasApp
        public List<Estrategia.BEConfiguracionProgramaNuevasApp> GetConfiguracionProgramaNuevasApp(int paisID, string CodigoPrograma)
        {
            return _configuracionProgramaNuevasBusinessLogic.GetConfiguracionProgramaNuevasApp(paisID, CodigoPrograma);
        }
        public string InsConfiguracionProgramaNuevasApp(int paisID, Estrategia.BEConfiguracionProgramaNuevasApp entidad)
        {
            return _configuracionProgramaNuevasBusinessLogic.InsConfiguracionProgramaNuevasApp(paisID, entidad);
        }
        #endregion

        #region Certificado Digital
        public bool TieneCampaniaConsecutivas(int paisId, int campaniaId, int cantidadCampaniaConsecutiva, long consultoraId)
        {
            return BLPedidoWeb.TieneCampaniaConsecutivas(paisId, campaniaId, cantidadCampaniaConsecutiva, consultoraId);
        }

        public BEMiCertificado ObtenerCertificadoDigital(int paisId, int campaniaId, long consultoraId, Int16 tipoCert)
        {
            return BLPedidoWeb.ObtenerCertificadoDigital(paisId, campaniaId, consultoraId, tipoCert);
        }
        #endregion

        #region Pago en Linea

        public int InsertPagoEnLineaResultadoLog(int paisId, BEPagoEnLineaResultadoLog entidad)
        {
            return BLPagoEnLinea.InsertPagoEnLineaResultadoLog(paisId, entidad);
        }

        public string ObtenerTokenTarjetaGuardadaByConsultora(int paisId, string codigoConsultora)
        {
            return BLPagoEnLinea.ObtenerTokenTarjetaGuardadaByConsultora(paisId, codigoConsultora);
        }

        public void UpdateMontoDeudaConsultora(int paisId, string codigoConsultora, decimal montoDeuda)
        {
            BLPagoEnLinea.UpdateMontoDeudaConsultora(paisId, codigoConsultora, montoDeuda);
        }

        public BEPagoEnLineaResultadoLog ObtenerPagoEnLineaById(int paisId, int pagoEnLineaResultadoLogId)
        {
            return BLPagoEnLinea.ObtenerPagoEnLineaById(paisId, pagoEnLineaResultadoLogId);
        }

        #endregion
    }
}
