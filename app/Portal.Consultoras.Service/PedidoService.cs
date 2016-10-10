using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.ServiceModel;
using Portal.Consultoras.Entities;
using Portal.Consultoras.BizLogic;
using Portal.Consultoras.ServiceContracts;
using System.Collections;
using System.Data;

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
        private BLValidacionAutomatica BLValidacionAutomatica; //R2073
        private BLShowRoomEvento BLShowRoomEvento;  //GR-335
        private BLProductoSugerido BLProductoSugerido;
        private BLConfiguracionProgramaNuevas BLConfiguracionProgramaNuevas;
        private BLEscalaDescuento BLEscalaDescuento;
        private BLConsultorasProgramaNuevas BLConsultorasProgramaNuevas;
        private BLMensajeMetaConsultora BLMensajeMetaConsultora;
        private BLProcesoPedidoRechazado BLProcesoPedidoRechazado;

        public PedidoService()
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
            BLValidacionAutomatica = new BLValidacionAutomatica(); //R2073
            BLShowRoomEvento = new BLShowRoomEvento();  //GR-335
            BLProductoSugerido = new BLProductoSugerido();
            BLConfiguracionProgramaNuevas = new BLConfiguracionProgramaNuevas();
            BLEscalaDescuento = new BLEscalaDescuento();
            BLConsultorasProgramaNuevas = new BLConsultorasProgramaNuevas();
            BLMensajeMetaConsultora = new BLMensajeMetaConsultora();
            BLProcesoPedidoRechazado = new BLProcesoPedidoRechazado();
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

        public IList<BEPedidoWebDetalle> SelectByCampania(int paisID, int CampaniaID, long ConsultoraID, string Consultora)
        {
            return BLPedidoWebDetalle.GetPedidoWebDetalleByCampania(paisID, CampaniaID, ConsultoraID, Consultora);
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

        public string[] DescargaPedidosWeb(int paisID, DateTime fechaFacturacion, int tipoCronograma, bool marcarPedido, string usuario)
        {
            try
            {
                return BLPedidoWeb.DescargaPedidosWeb(paisID, fechaFacturacion, tipoCronograma, marcarPedido, usuario);
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
        // R20151003 - Inicio
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
        // R20151003 - Fin

        //public IAsyncResult BeginDescargaPedidosWeb(AsyncCallback callback, int paisID, DateTime fechaFacturacion, int tipoCronograma, bool marcarPedido)
        //{
        //    string[] parameters = new string[4];
        //    parameters[0] = paisID.ToString();
        //    parameters[1] = fechaFacturacion.ToShortDateString();
        //    parameters[2] = tipoCronograma.ToString();
        //    parameters[3] = Convert.ToInt32(marcarPedido).ToString();
        //    object state = parameters;
        //    var task = Task<int>.Factory.StartNew(DescargaPedidosWebAsincrono, state);
        //    return task.ContinueWith(res => callback(task));
        //}

        //public int EndDescargaPedidosWeb(IAsyncResult result)
        //{
        //    return ((Task<int>)result).Result;
        //}

        public BEConfiguracionCampania GetEstadoPedido(int PaisID, int CampaniaID, long ConsultoraID, int ZonaID, int RegionID)
        {
            return BLPedidoWeb.GetEstadoPedido(PaisID, CampaniaID, ConsultoraID, ZonaID, RegionID);
        }
        //ITG HFMG
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
        // R20151003 - Inicio
        public int ValidarCuvDescargado(int paisID, int anioCampania, string codigoVenta, string codigoConsultora)
        {
            return BLPedidoDD.ValidarCuvDescargado(paisID, anioCampania, codigoVenta, codigoConsultora);
        }
        // R20151003 - Fin
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

        //public int DescargaPedidosWebAsincrono(object obj)
        //{
        //    int rslt = 0;
        //    string[] item = ((IEnumerable)obj).Cast<object>()
        //                         .Select(x => x.ToString())
        //                         .ToArray();
        //    try
        //    {
        //        BLPedidoWeb.DescargaPedidosWeb(int.Parse(item[0]), DateTime.Parse(item[1]), int.Parse(item[2]), Convert.ToBoolean(item[3]));
        //        rslt = 1;
        //    }
        //    catch (BizLogicException ex)
        //    {
        //        throw new FaultException(ex.Message);
        //    }
        //    catch (Exception)
        //    {
        //        throw new FaultException("Error desconocido.");
        //    }
        //    return rslt;
        //}

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

        //public int UpdOfertaProductoStock(BEOfertaProducto entity)
        //{
        //    return new BLOfertaProducto().UpdOfertaProductoStock(entity);
        //}

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

        public IList<BEMatrizComercial> GetImagenesByCodigoSAP(int paisID, string codigoSAP)
        {
            return new BLOfertaProducto().GetImagenesByCodigoSAP(paisID, codigoSAP);
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

        //public int InsPedidoWebOferta(BEPedidoWeb entity)
        //{
        //    return new BLOfertaProducto().InsPedidoWebOferta(entity);
        //}

        //public int UpdPedidoWebTotalesOferta(BEPedidoWeb entity)
        //{
        //    return new BLOfertaProducto().UpdPedidoWebTotalesOferta(entity);
        //}

        //public int InsPedidoWebDetalleOferta(BEPedidoWebDetalle entity)
        //{
        //    return new BLOfertaProducto().InsPedidoWebDetalleOferta(entity);
        //}

        //public int UpdPedidoWebOferta(BEPedidoWebDetalle entity)
        //{
        //    return new BLOfertaProducto().UpdPedidoWebOferta(entity);
        //}

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
        }//1673
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

        //public int ValidarPriorizacionFlexipago(int paisID, int ConfiguracionOfertaID, int CampaniaID, int Orden)
        //{
        //    return new BLOfertaFlexipago().ValidarPriorizacionFlexipago(paisID, ConfiguracionOfertaID, CampaniaID, Orden);
        //}

        //public int GetOrdenPriorizacionFlexipago(int paisID, int ConfiguracionOfertaID, int CampaniaID)
        //{
        //    return new BLOfertaFlexipago().GetOrdenPriorizacionFlexipago(paisID, ConfiguracionOfertaID, CampaniaID);
        //}

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

        public List<BETracking> GetPedidosByConsultora(int paisID, string codigoConsultora)
        {
            return BLTracking.GetPedidosByConsultora(paisID, codigoConsultora);
        }

        public BETracking GetPedidoByConsultoraAndCampania(int paisID, string codigoConsultora, int campania)
        {
            return BLTracking.GetPedidoByConsultoraAndCampania(paisID, codigoConsultora, campania);
        }

        public List<BETracking> GetTrackingByPedido(int paisID, string codigo, string campana, string nropedido)
        {
            return BLTracking.GetTrackingByPedido(paisID, codigo, campana, nropedido);
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

        public List<BEEscalaDescuento> GetEscalaDescuento(int paisID)
        {
            return BLEscalaDescuento.GetEscalaDescuento(paisID);
        }

        public List<BEEscalaDescuento> GetParametriaOfertaFinal(int paisID)
        {
            return BLEscalaDescuento.GetParametriaOfertaFinal(paisID);
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

        //1793
        public List<BENovedadTracking> GetNovedadesTracking(int paisID, string NumeroPedido)
        {
            return BLTracking.GetNovedadesTracking(paisID, NumeroPedido);
        }

        // Req. 1717 - Inicio
        public int InsConfirmacionEntrega(int paisID, BEConfirmacionEntrega oBEConfirmacionEntrega)
        {
            return BLTracking.InsConfirmacionEntrega(paisID, oBEConfirmacionEntrega);
        }

        public int UpdConfirmacionEntrega(int paisID, BEConfirmacionEntrega oBEConfirmacionEntrega)
        {
            return BLTracking.UpdConfirmacionEntrega(paisID, oBEConfirmacionEntrega);
        }

        //RQ 20150711 - Inicio
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
        //RQ 20150711 - Fin

        // 1747 - Etiqueta
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

        // 1747 - Oferta
        public int InsertarOferta(BEOferta entidad)
        {
            return new BLOferta().InsertOferta(entidad);
        }

        public List<BEOferta> GetOfertas(BEOferta entidad)
        {
            return new BLOferta().GetOfertas(entidad);
        }

        // 1747 - TipoEstrategia
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

        // Req. 1747 - Estrategia
        public List<BEEstrategia> GetEstrategias(BEEstrategia entidad)
        {
            return new BLEstrategia().GetEstrategias(entidad);
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
            return new BLEstrategia().GetEstrategiasPedido(entidad);
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
        // 1747 - Fin
        public void InsPedidoWebDetallePROLv2(int PaisID, int CampaniaID, int PedidoID, short EstadoPedido, List<BEPedidoWebDetalle> olstPedidoWebDetalle, bool ValidacionAbierta, string CodigoUsuario, decimal MontoTotalProl, decimal DescuentoProl)
        {
            BLPedidoWebDetalle.InsPedidoWebDetallePROLv2(PaisID, CampaniaID, PedidoID, EstadoPedido, olstPedidoWebDetalle, ValidacionAbierta, CodigoUsuario, MontoTotalProl, DescuentoProl);
        }

        //R2004
        public BENovedadFacturacion GetPedidoRechazadoByConsultora(int PaisID, string CampaniaId, string CodigoConsultora, DateTime Fecha)
        {
            return BLTracking.GetPedidoRechazadoByConsultora(PaisID, CampaniaId, CodigoConsultora, Fecha);
        }

        //R2004
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

        /* Req. 1987 - Inicio */
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
        /* Req. 1987 - Fin */

        /* 2108 - Inicio */
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
        /* 2108 - Fin */

        /* 2024 - Inicio */
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
        /* 2024 - Fin */

        //R2154
        public int ValidarDesactivaRevistaGana(int paisID, int campaniaID, string codigoZona)
        {
            return new BLPedidoWeb().ValidarDesactivaRevistaGana(paisID, campaniaID, codigoZona);
        }

        /* 2140 - Inicio */
        public BECUVCredito ValidarCUVCreditoPorCUVRegular(int paisID, string codigoConsultora, string cuvRegular, int campaniaID)
        {
            return new BLPedidoWeb().ValidarCUVCreditoPorCUVRegular(paisID, codigoConsultora, cuvRegular, campaniaID);
        }
        /* 2140 - Fin */

        //R2264
        public bool InsLogEnvioCorreoPedidoValidado(int paisID, BELogCabeceraEnvioCorreo beLogCabeceraEnvioCorreo, List<BELogDetalleEnvioCorreo> listLogDetalleEnvioCorreo)
        {
            return new BLLogEnvioCorreo().InsLogEnvioCorreoPedidoValidado(paisID, beLogCabeceraEnvioCorreo, listLogDetalleEnvioCorreo);
        }

        /*RQ 2370 - EC*/
        public int RemoverOfertaLiquidacion(BEOfertaProducto entity)
        {
            return new BLOfertaProducto().RemoverOfertaLiquidacion(entity);
        }

        // R2319 - AHA - Inicio
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

                    /*R2613-LR*/
                    return blSolicitudCliente.InsertarSolicitudCliente(paisID, entidadSolicitud);
                }
            }
            catch (Exception ex)
            {
                mensaje = ex.Message.ToString();
                return new BEResultadoSolicitud(resultado, mensaje);
            }
        }
        // R2319 - AHA - Fin

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

        public int CargarMasivaDescripcionSets(int paisID, int campaniaID, string usuarioCreacion, List<BEShowRoomOfertaDetalle> listaShowRoomOfertaDetalle)
        {
            return BLShowRoomEvento.CargarMasivaDescripcionSets(paisID, campaniaID, usuarioCreacion, listaShowRoomOfertaDetalle);
        }

        public BEShowRoomEventoConsultora GetShowRoomConsultora(int paisID, int campaniaID, string codigoConsultora)
        {
            return BLShowRoomEvento.GetShowRoomConsultora(paisID, campaniaID, codigoConsultora);
        }

        public void UpdateShowRoomConsultoraMostrarPopup(int paisID, int campaniaID, string codigoConsultora, bool mostrarPopup)
        {
            BLShowRoomEvento.UpdateShowRoomConsultoraMostrarPopup(paisID, campaniaID, codigoConsultora, mostrarPopup);
        }

        public IList<BEShowRoomOferta> GetProductosShowRoom(int paisID, int tipoOfertaSisID, int campaniaID, string codigoOferta)
        {
            return BLShowRoomEvento.GetProductosShowRoom(paisID, tipoOfertaSisID, campaniaID, codigoOferta);
        }

        public int GetOrdenPriorizacionShowRoom(int paisID, int ConfiguracionOfertaID, int CampaniaID)
        {
            return BLShowRoomEvento.GetOrdenPriorizacionShowRoom(paisID, ConfiguracionOfertaID, CampaniaID);
        }

        public int ValidarPriorizacionShowRoom(int paisID, int ConfiguracionOfertaID, int CampaniaID, int Orden)
        {
            return BLShowRoomEvento.ValidarPriorizacionShowRoom(paisID, ConfiguracionOfertaID, CampaniaID, Orden);
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

        public int RemoverOfertaShowRoom(int paisID, BEShowRoomOferta entity)
        {
            return BLShowRoomEvento.RemoverOfertaShowRoom(paisID, entity);
        }

        public IList<BEShowRoomOferta> GetShowRoomOfertas(int paisID, int campaniaID)
        {
            return BLShowRoomEvento.GetShowRoomOfertas(paisID, campaniaID);
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

        public IList<BEShowRoomOferta> GetShowRoomOfertasConsultora(int paisID, int campaniaID, string codigoConsultora)
        {
            return BLShowRoomEvento.GetShowRoomOfertasConsultora(paisID, campaniaID, codigoConsultora);
        }

        #endregion

        #region Producto SUgerido

        public IList<BEProductoSugerido> GetPaginateProductoSugerido(int PaisID, int CampaniaID, string CUVAgotado, string CUVSugerido) {
            return BLProductoSugerido.GetPaginateProductoSugerido(PaisID, CampaniaID, CUVAgotado, CUVSugerido);
        }

        public IList<BEMatrizComercial> GetImagenesByCUV(int paisID, int campaniaID, string cuv)
        {
            return BLProductoSugerido.GetImagenesByCUV(paisID, campaniaID, cuv);
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

        public List<BEPedidoWeb> GetPedidosIngresadoFacturado(int paisID, int consultoraID, int campaniaID)
        {
            return BLPedidoWeb.GetPedidosIngresadoFacturado(paisID, consultoraID, campaniaID);
        }

        /*GR2089*/
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
        
        public void InsLogOfertaFinal(int PaisID, int CampaniaID, string CodigoConsultora, string CUV, int cantidad, string tipoOfertaFinal, decimal GAP)
        {
            BLPedidoWeb.InsLogOfertaFinal(PaisID, CampaniaID, CodigoConsultora, CUV, cantidad, tipoOfertaFinal, GAP);
        }
    }
}
