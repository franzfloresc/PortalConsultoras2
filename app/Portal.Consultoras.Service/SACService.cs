using Portal.Consultoras.BizLogic;
using Portal.Consultoras.BizLogic.Estrategia;
using Portal.Consultoras.BizLogic.Mobile;
using Portal.Consultoras.BizLogic.Producto;
using Portal.Consultoras.Entities;
using Portal.Consultoras.Entities.Estrategia;
using Portal.Consultoras.Entities.Mobile;
using Portal.Consultoras.Entities.Producto;
using Portal.Consultoras.ServiceContracts;

using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.ServiceModel;

namespace Portal.Consultoras.Service
{
    public class SACService : ISACService
    {
        private readonly BLCronograma BLCronograma;
        private readonly BLCronogramaAnticipado BLCronogramaAnticipado;
        private readonly BLProductoFaltante BLproductofaltante;
        private readonly BLConfiguracionValidacionZona BLConfiguracionValidacionZona;
        private readonly BLConfiguracionValidacion BLConfiguracionValidacion;
        private readonly BLProducto BLProducto;
        private readonly BLOfertaWeb BLOfertaWeb;
        private readonly BLConsultoraFicticia BLConsultoraFicticia;
        private readonly BLDatosBelcorp BLDatosBelcorp;
        private readonly BLServicio BLServicio;
        private readonly BLFactorGanancia BLFactorGanancia;
        private readonly BLSolicitudCredito BLSolicitudCredito;
        private readonly BLLogModificacionCronograma BLLogModificacionCronograma;
        private readonly BLLugarPago BLLugarPago;
        private readonly BLIncentivo BLIncentivo;
        private readonly BLBelcorpNoticia BLBelcorpNoticia;
        private readonly BLTablaLogicaDatos BLTablaLogicaDatos;
        private readonly BLFeErratas BLFeErratas;
        private readonly BLCuv BLCUV;
        private readonly BLBannerPedido BLBannerPedido;
        private readonly BLComunicado BLComunicado;
        private readonly BLEstadoCuenta BLEstadoCuenta;
        private readonly BLPedidoFacturado BLPedidoFacturado;
        private readonly BLAfiliaClienteConsultora BLAfiliaClienteConsultora;
        private readonly BLSolicitudCliente BLSolicitudCliente;
        private readonly BLConfiguracionPortal BLConfiguracionPortal;
        private readonly BLConsultoraDigitales BLConsultoraDigitales;
        private readonly BLProveedorDespachoCobranza BLProveedorDespachoCobranza;
        private readonly BLConfiguracionParametroCarga BLConfiguracionParametroCarga;
        private readonly BLLogParametroDiasCargaPedido BLLogParametroDiasCargaPedido;
        private readonly BLParticipantesDemandaAnticipada BLParticipantesDemandaAnticipada;
        private readonly BLPopupPais BLPopupPais;
        private readonly BLApp _blApp;
        private readonly BLAdministrarEstrategia _blAdministrarEstrategia;
        private readonly IComunicadoBusinessLogic _comunicadoBusinessLogic;
        private readonly IBuscadorBusinessLogic _buscadorBusinessLogic;

        private readonly BLCategoria _blCategoria;
        private readonly BLCatalogo _bLCatalogo;  

        public SACService() : this(new BLComunicado(), new BLBuscador())
        {
            BLCronograma = new BLCronograma();
            BLCronogramaAnticipado = new BLCronogramaAnticipado();
            BLproductofaltante = new BLProductoFaltante();
            BLConfiguracionValidacionZona = new BLConfiguracionValidacionZona();
            BLConfiguracionValidacion = new BLConfiguracionValidacion();
            BLProducto = new BLProducto();
            BLOfertaWeb = new BLOfertaWeb();
            BLConsultoraFicticia = new BLConsultoraFicticia();
            BLDatosBelcorp = new BLDatosBelcorp();
            BLServicio = new BLServicio();
            BLFactorGanancia = new BLFactorGanancia();
            BLSolicitudCredito = new BLSolicitudCredito();
            BLLogModificacionCronograma = new BLLogModificacionCronograma();
            BLLugarPago = new BLLugarPago();
            BLIncentivo = new BLIncentivo();
            BLBelcorpNoticia = new BLBelcorpNoticia();
            BLTablaLogicaDatos = new BLTablaLogicaDatos();
            BLFeErratas = new BLFeErratas();
            BLCUV = new BLCuv();
            BLBannerPedido = new BLBannerPedido();
            BLComunicado = new BLComunicado();
            BLEstadoCuenta = new BLEstadoCuenta();
            BLPedidoFacturado = new BLPedidoFacturado();
            BLAfiliaClienteConsultora = new BLAfiliaClienteConsultora();
            BLSolicitudCliente = new BLSolicitudCliente();
            BLConfiguracionPortal = new BLConfiguracionPortal();
            BLConsultoraDigitales = new BLConsultoraDigitales();
            BLProveedorDespachoCobranza = new BLProveedorDespachoCobranza();
            BLConfiguracionParametroCarga = new BLConfiguracionParametroCarga();
            BLLogParametroDiasCargaPedido = new BLLogParametroDiasCargaPedido();
            BLParticipantesDemandaAnticipada = new BLParticipantesDemandaAnticipada();
            BLPopupPais = new BLPopupPais();
            _blApp = new BLApp();
            _blAdministrarEstrategia = new BLAdministrarEstrategia();
            _blCategoria = new BLCategoria();
            _bLCatalogo = new BLCatalogo();
        }

        public SACService(IComunicadoBusinessLogic comunicadoBusinessLogic,
                           IBuscadorBusinessLogic buscadorBusinessLogic)
        {
            _comunicadoBusinessLogic = comunicadoBusinessLogic;
            _buscadorBusinessLogic = buscadorBusinessLogic;
        }

        #region Cronograma Anticipado

        public IList<BECronograma> GetCronogramaByCampaniaAnticipado(int paisID, int campaniaID, int ZonaID, Int16 TipoCronogramaID)
        {
            return BLCronogramaAnticipado.GetCronogramaByCampaniaAnticipado(paisID, campaniaID, ZonaID, TipoCronogramaID);
        }

        public int InsertCronogramaAnticipado(BECronograma cronograma)
        {
            return BLCronogramaAnticipado.InsertCronogramaAnticipado(cronograma);
        }

        public void UpdateCronogramaAnticipado(BECronograma cronograma)
        {
            BLCronogramaAnticipado.UpdateCronogramaAnticipado(cronograma);
        }

        public void DeleteCronogramaAnticipado(BECronograma cronograma)
        {
            BLCronogramaAnticipado.DeleteCronogramaAnticipado(cronograma);
        }

        public int InsConfiguracionConsultoraDA(int paisID, BEConfiguracionConsultoraDA configuracionConsultoraDA)
        {
            return BLCronogramaAnticipado.InsConfiguracionConsultoraDA(paisID, configuracionConsultoraDA);
        }

        public int GetConfiguracionConsultoraDA(int paisID, BEConfiguracionConsultoraDA configuracionConsultoraDA)
        {
            return BLCronogramaAnticipado.GetConfiguracionConsultoraDA(paisID, configuracionConsultoraDA);
        }

        public int GetCronogramaDA(int paisID, DateTime fechaFacturacion)
        {
            return BLCronogramaAnticipado.GetCronogramaDA(paisID, fechaFacturacion);
        }

        #endregion

        #region Cronograma
        public IList<BECronograma> GetCronogramaByCampania(int paisID, int campaniaID, int ZonaID, Int16 TipoCronogramaID)
        {
            return BLCronograma.GetCronogramaByCampania(paisID, campaniaID, ZonaID, TipoCronogramaID);
        }

        public BECronograma GetCronogramaByCampaniayZona(int paisID, int campaniaID, int ZonaID)
        {
            return BLCronograma.GetCronogramaByCampaniayZona(paisID, campaniaID, ZonaID);
        }

        public int MigrarCronogramaAnticipado(int paisID, int campaniaID, int ZonaID)
        {
            return BLCronograma.MigrarCronogramaAnticipado(paisID, campaniaID, ZonaID);
        }

        public bool GetCronogramaAutomaticoActivacion(int paisID)
        {
            return BLCronograma.GetCronogramaAutomaticoActivacion(paisID);
        }

        public int GetCampaniaFacturacionPais(int paisID)
        {
            return BLCronograma.GetCampaniaFacturacionPais(paisID);
        }

        #endregion

        #region Producto Faltante
        public void InsProductoFaltante(int paisID, string paisISO, string CodigoUsuario, IList<BEProductoFaltante> productosFaltantes, bool FaltanteUltimoMinuto)
        {
            BLproductofaltante.InsProductoFaltante(paisID, paisISO, CodigoUsuario, productosFaltantes, FaltanteUltimoMinuto);
        }

        public bool DelProductoFaltante(int paisID, string paisISO, string CodigoUsuario, BEProductoFaltante productoFaltante)
        {
            return BLproductofaltante.DelProductoFaltante(paisID, paisISO, CodigoUsuario, productoFaltante);
        }

        public int DelProductoFaltante2(int paisID, string paisISO, string CodigoUsuario, IList<BEProductoFaltante> productoFaltante, int flag, int pais, int campania, int zona, string cuv, string e_producto, DateTime fecha)
        {
            return BLproductofaltante.DelProductoFaltante2(paisID, paisISO, CodigoUsuario, productoFaltante, flag, pais, campania, zona, cuv, e_producto, fecha);
        }

        public IList<BEProductoFaltante> GetProductoFaltanteByEntity(int paisID, BEProductoFaltante productofaltante, string ColumnaOrden, string Ordenamiento, int PaginaActual, int FlagPaginacion, int RegistrosPorPagina)
        {
            return BLproductofaltante.GetProductoFaltanteByEntity(paisID, productofaltante, ColumnaOrden, Ordenamiento, PaginaActual, FlagPaginacion, RegistrosPorPagina);
        }

        public IList<BEProductoFaltante> GetProductoFaltanteByCampaniaAndZonaID(int paisID, int campaniaID, int ZonaID, string cuv, string descripcion , string codCategoria , string codCatalogoRevista)
        {
            return BLproductofaltante.GetProductoFaltanteByCampaniaAndZonaID(paisID, campaniaID, ZonaID, cuv, descripcion , codCategoria  , codCatalogoRevista);
        }

        public string InsProductoFaltanteMasivo(int paisID, string paisISO, string CodigoUsuario, int campaniaID, IList<BEProductoFaltante> productosFaltantes, bool FaltanteUltimoMinuto)
        {
            return BLproductofaltante.InsProductoFaltanteMasivo(paisID, paisISO, CodigoUsuario, campaniaID, productosFaltantes, FaltanteUltimoMinuto);
        }

        public void InsLogIngresoFAD(int PaisID, int CampaniaId, long ConsultoraId, string CUV, int Cantidad, decimal PrecioUnidad, int ZonaId)
        {
            BLproductofaltante.InsLogIngresoFAD(PaisID, CampaniaId, ConsultoraId, CUV, Cantidad, PrecioUnidad, ZonaId);
        }

        #endregion

        #region ConfiguracionValidacionZona

        public IList<BEConfiguracionValidacionZona> GetCampaniasActivas(int paisID, int campaniaID)
        {
            return BLConfiguracionValidacionZona.GetCampaniasActivas(paisID, campaniaID);
        }

        public void InsConfiguracionValidacionZona(BEConfiguracionValidacion ent, List<BEConfiguracionValidacionZona> lista)
        {
            BLConfiguracionValidacionZona.InsConfiguracionValidacionZona(ent, lista);
        }

        public void UpdConfiguracionValidacionZona(BEConfiguracionValidacion ent, List<BEConfiguracionValidacionZona> lista)
        {
            BLConfiguracionValidacionZona.UpdConfiguracionValidacionZona(ent, lista);
        }

        public void DelConfiguracionValidacionZona(int paisID, int campaniaID)
        {
            BLConfiguracionValidacionZona.DelConfiguracionValidacionZona(paisID, campaniaID);
        }

        #endregion

        #region ConfiguracionValidacion

        public void InsertConfiguracionValidacion(BEConfiguracionValidacion entidad)
        {
            BLConfiguracionValidacion.InsertConfiguracionValidacion(entidad);
        }

        public void UpdateConfiguracionValidacion(BEConfiguracionValidacion entidad)
        {
            BLConfiguracionValidacion.UpdateConfiguracionValidacion(entidad);
        }

        public IList<BEConfiguracionValidacion> GetConfiguracionValidacion(int paisID, int campaniaID)
        {
            return BLConfiguracionValidacion.GetListConfiguracionValidacion(paisID);
        }

        public BEConfiguracionValidacionZona GetConfiguracionValidacionZona(int paisID, int campaniaID, int zonaID)
        {
            return BLConfiguracionValidacionZona.GetConfiguracionValidacionZona(paisID, campaniaID, zonaID);
        }

        #endregion

        #region ProductoDescripcion

        public List<BEProductoDescripcion> GetProductoDescripcionByCUVandCampania(int paisID, int campaniaID, string CUV)
        {
            return BLProducto.GetProductoDescripcionByCUVandCampania(paisID, campaniaID, CUV);
        }

        public void UpdProductoDescripcion(BEProductoDescripcion producto, string codigoUsuario)
        {
            BLProducto.UpdProductoDescripcion(producto, codigoUsuario);
        }


        public void UpdProductoDescripcionMasivo(int paisID, int campaniaID, IList<BEProductoDescripcion> listaProductos, string codigoUsuario)
        {
            BLProducto.UpdProductoDescripcionMasivo(paisID, campaniaID, listaProductos, codigoUsuario);
        }
        public string ValidarMatrizCampaniaMasivo(int paisID, string CUVs, int AnioCampania)
        {
            return BLProducto.ValidarMatrizCampaniaMasivo(paisID, CUVs, AnioCampania);
        }

        public string RegistrarProductoMasivo(int paisID, string data)
        {
            return BLProducto.RegistrarProductoMasivo(paisID, data);
        }

        #endregion

        #region Oferta Web

        public IList<BEOfertaWeb> GetOfertaWebByCampania(int PaisID, int campaniaID, int PedidoID, long ConsultoraID)
        {
            return BLOfertaWeb.GetOfertaWebByCampania(PaisID, campaniaID, PedidoID, ConsultoraID);
        }

        #endregion

        #region Consultora Ficticia

        public int InsConsultoraFicticia(BEConsultoraFicticia BEConsultoraFicticia)
        {
            return BLConsultoraFicticia.InsConsultoraFicticia(BEConsultoraFicticia);
        }

        public IList<BEConsultoraFicticia> SelectConsultoraFicticia(int paisID, string CodigoUsuario, string NombreCompleto)
        {
            return BLConsultoraFicticia.SelectConsultoraFicticia(paisID, CodigoUsuario, NombreCompleto);
        }

        public void DelConsultoraFicticia(int paisID, string CodigoConsultora)
        {
            BLConsultoraFicticia.DelConsultoraFicticia(paisID, CodigoConsultora);
        }

        public void UpdConsultoraFicticia(string CodigoUsuario, string CodigoConsultora, int paisID, Int64 ConsultoraID, string Clave)
        {
            BLConsultoraFicticia.UpdConsultoraFicticia(CodigoUsuario, CodigoConsultora, paisID, ConsultoraID, Clave);
        }

        public string GetCodigoConsultoraAsociada(int paisID, string CodigoUsuario)
        {
            return BLConsultoraFicticia.GetCodigoConsultoraAsociada(paisID, CodigoUsuario);
        }

        public string GetNombreConsultoraAsociada(int paisID, string CodigoUsuario)
        {
            return BLConsultoraFicticia.GetNombreConsultoraAsociada(paisID, CodigoUsuario);
        }
        #endregion

        #region DatosBelcorp
        public IList<BEDatosBelcorp> GetDatosBelcorp(int paisID)
        {
            return BLDatosBelcorp.GetDatosBelcorp(paisID);
        }
        #endregion

        #region ActualizacionFacturacion
        public IList<BELogActualizacionFacturacion> LogActualizacionFacturacion(int paisID)
        {
            return BLCronograma.GetLogActualizacionFacturacion(paisID);
        }
        public IList<BELogActualizacionFacturacion> UpdLogActualizacionFacturacion(int paisID, string CampaniaCodigo, string Codigos, int Tipo, DateTime FechaFacturacion, DateTime FechaReFacturacion, string CodigoUsuario)
        {
            return BLCronograma.UpdLogActualizacionFacturacion(paisID, CampaniaCodigo, Codigos, Tipo, FechaFacturacion, FechaReFacturacion, CodigoUsuario);
        }

        public void UpdateCronogramaDD(int paisID, string CampaniaCodigo, string Codigos, int Tipo, DateTime FechaFacturacion, DateTime FechaFinFacturacion, DateTime FechaReFacturacion, string CodigoUsuario)
        {
            BLCronograma.UpdateCronogramaDD(paisID, CampaniaCodigo, Codigos, Tipo, FechaFacturacion, FechaFinFacturacion, FechaReFacturacion, CodigoUsuario);
        }
        public void InsCronogramaDemandaAnticipadaDD(int paisID, string CampaniaCodigo, string ZonaCodigo, DateTime FechaFacturacion, DateTime FechaReFacturacion)
        {
            BLCronograma.InsCronogramaDemandaAnticipada(paisID, CampaniaCodigo, ZonaCodigo, FechaFacturacion, FechaReFacturacion);
        }
        public void UpdCronogramaDemandaAnticipadaDD(int paisID, string CampaniaCodigo, string ZonaCodigo, DateTime FechaFacturacion, DateTime FechaReFacturacion)
        {
            BLCronograma.UpdCronogramaDemandaAnticipada(paisID, CampaniaCodigo, ZonaCodigo, FechaFacturacion, FechaReFacturacion);
        }
        public void DelCronogramaDemandaAnticipadaDD(int paisID, string ZonaCodigo)
        {
            BLCronograma.DelCronogramaDemandaAnticipada(paisID, ZonaCodigo);
        }
        #endregion

        #region Servicio
        public IList<BEServicio> GetServicios(string Descripcion)
        {
            return BLServicio.SelectServicio(Descripcion);
        }
        public IList<BEServicioCampania> GetServicioByCampaniaPais(int PaisId, int CampaniaId)
        {
            return BLServicio.SelectServicioByCampaniaPais(PaisId, CampaniaId);
        }
        public IList<BEServicioCampania> GetServicioByCampaniaPaisAdministrador(int PaisId, int CampaniaId)
        {
            return BLServicio.SelectServicioByCampaniaPaisAdministrador(PaisId, CampaniaId);
        }
        public IList<BEServicioParametro> GetParametrosbyServicio(int ServicioId)
        {
            return BLServicio.SelectParametrosbyServicio(ServicioId);
        }
        public IList<BEEstadoServicio> GetEstadoServiciobyPais(int ServicioId, int CampaniaId)
        {
            return BLServicio.SelectEstadoServiciobyPais(ServicioId, CampaniaId);
        }

        public int InsServicio(BEServicio servicio)
        {
            return BLServicio.InsServicio(servicio);
        }
        public int UpdServicio(BEServicio servicio)
        {
            return BLServicio.UpdServicio(servicio);
        }
        public int DelServicio(int ServicioId)
        {
            return BLServicio.DelServicio(ServicioId);
        }
        public int DelServicioParametro(int ServicioId, int ParametroId)
        {
            return BLServicio.DelServicioParametro(ServicioId, ParametroId);
        }
        public int InsServicioParametro(int ServicioId, int ParametroId)
        {
            return BLServicio.InsServicioParametro(ServicioId, ParametroId);
        }
        public int InsServicioCampania(int CampaniaId, int ServicioId, string CodigoISO)
        {
            return BLServicio.InsServicioCampania(CampaniaId, ServicioId, CodigoISO);
        }
        public int InsServicioCampaniaRango(int CampaniaId, int CampaniaFinalId, int ServicioId, string CodigoISO)
        {
            return BLServicio.InsServicioCampaniaRango(CampaniaId, CampaniaFinalId, ServicioId, CodigoISO);
        }
        public int DelServicioCampania(int CampaniaId, int ServicioId, string CodigoISO)
        {
            return BLServicio.DelServicioCampania(CampaniaId, ServicioId, CodigoISO);
        }
        public int DelServicioCampaniaRango(int CampaniaId, int CampaniaFinalId, int ServicioId, string CodigoISO)
        {
            return BLServicio.DelServicioCampaniaRango(CampaniaId, CampaniaFinalId, ServicioId, CodigoISO);
        }
        #endregion

        #region parametros
        public IList<BEParametro> SelectParametros()
        {
            return BLServicio.SelectParametros();
        }
        #endregion

        #region Factor de Ganancia
        public IList<BEFactorGanancia> SelectFactorGanancia(int paisID)
        {
            try
            {
                return BLFactorGanancia.SelectFactorGanancia(paisID);
            }
            catch (Exception)
            {
                throw new FaultException("Error al realizar la consulta de Factor Ganancia.");
            }
        }

        public IList<BEFactorGanancia> GetFactorGananciaById(int paisID)
        {
            try
            {
                return BLFactorGanancia.GetFactorGananciaById(paisID);
            }
            catch (Exception)
            {
                throw new FaultException("Error al realizar la consulta de Factor Ganancia.");
            }
        }

        public int InsertFactorGanancia(BEFactorGanancia entidad)
        {
            int result;
            try
            {
                result = BLFactorGanancia.InsertFactorGanancia(entidad);
            }
            catch
            {
                throw new FaultException("Error al realizar la inserción de Factor Ganancia.");
            }
            return result;
        }

        public int UpdateFactorGanancia(BEFactorGanancia entidad)
        {
            int result;
            try
            {
                result = BLFactorGanancia.UpdateFactorGanancia(entidad);
            }
            catch
            {
                throw new FaultException("Error al realizar la actualización de Factor Ganancia.");
            }
            return result;
        }

        public void DeleteFactorGanancia(int paisID, int factorGananciaID)
        {
            try
            {
                BLFactorGanancia.DeleteFactorGanancia(paisID, factorGananciaID);
            }
            catch
            {
                throw new FaultException("Error al realizar la eliminación de Factor Ganancia.");
            }
        }

        public IList<BEFactorGanancia> GetFactorGananciaByPaisRango(decimal monto, int paisId)
        {
            try
            {
                return BLFactorGanancia.GetFactorGananciaByPaisRango(monto, paisId);
            }
            catch
            {
                throw new FaultException("Error al realizar la consulta de Factor de Ganancia.");
            }
        }

        public IList<BEPedidoWebDetalleDescuento> GetIndicadorDescuentoByPedidoWebDetalle(int paisID, int campaniaId, int pedidoId)
        {
            try
            {
                return BLFactorGanancia.GetProductoComercialIndicadorDescuentoByPedidoWebDetalle(paisID, campaniaId, pedidoId);
            }
            catch
            {
                throw new FaultException("Error al realizar la consulta de Indicadores de Descuento.");
            }
        }

        public void UpdatePedidoWebEstimadoGanancia(int paisID, int campaniaId, int pedidoId, decimal estimadoGanancia)
        {
            try
            {
                BLFactorGanancia.UpdatePedidoWebEstimadoGanancia(paisID, campaniaId, pedidoId, estimadoGanancia);
            }
            catch
            {
                throw new FaultException("Error al realizar la actualización de Factor Ganancia en el Pedido.");
            }
        }

        public BEFactorGanancia GetFactorGananciaSiguienteEscala(decimal monto, int paisID)
        {
            return BLFactorGanancia.GetFactorGananciaSiguienteEscala(monto, paisID);
        }

        public BEFactorGanancia GetFactorGananciaEscalaDescuento(decimal monto, int paisID)
        {
            return BLFactorGanancia.GetFactorGananciaEscalaDescuento(monto, paisID);
        }

        #endregion

        #region Modificacion Cronograma

        public IList<BEConfiguracionValidacionZona> GetRegionZonaDiasDuracionCronograma(int PaisID, int RegionID, int ZonaID)
        {
            return BLConfiguracionValidacionZona.GetRegionZonaDiasDuracionCronograma(PaisID, RegionID, ZonaID);
        }

        public void UpdConfiguracionValidacionZonaCronograma(int paisID, List<BEConfiguracionValidacionZona> listaEntidades)
        {
            BLConfiguracionValidacionZona.UpdConfiguracionValidacionZonaCronograma(paisID, listaEntidades);
        }

        public IList<BELogModificacionCronograma> GetLogModificacionCronograma(int PaisID)
        {
            return BLLogModificacionCronograma.GetLogModificacionCronograma(PaisID);
        }

        public void InsLogModificacionCronogramaMasivo(int paisID, string CodigoUsuario, List<BELogModificacionCronograma> listaEntidades)
        {
            BLLogModificacionCronograma.InsLogModificacionCronogramaMasivo(paisID, CodigoUsuario, listaEntidades);
        }

        public void InsLogConfiguracionCronogramaMasivo(int paisID, string CodigoUsuario, List<BELogConfiguracionCronograma> listaEntidades)
        {
            BLLogModificacionCronograma.InsLogConfiguracionCronogramaMasivo(paisID, CodigoUsuario, listaEntidades);
        }

        #endregion

        #region Lugares de Pago

        public IList<BELugarPago> SelectLugarPago(int paisID)
        {
            try
            {
                return BLLugarPago.SelectLugarPago(paisID);
            }
            catch (Exception)
            {
                throw new FaultException("Error al realizar la consulta de Lugar de Pago.");
            }
        }

        public BELugarPago GetLugarPagoById(int paisID, int lugarPagoID)
        {
            try
            {
                return BLLugarPago.GetLugarPagoById(paisID, lugarPagoID);
            }
            catch (Exception)
            {
                throw new FaultException("Error al realizar la consulta de Lugar de Pago.");
            }
        }

        public int InsertLugarPago(BELugarPago entidad)
        {
            int lintPosicion;
            try
            {
                lintPosicion = BLLugarPago.InsertLugarPago(entidad);
            }
            catch
            {
                throw new FaultException("Error al realizar la inserción de Lugar de Pago.");
            }
            return lintPosicion;
        }

        public int UpdateLugarPago(BELugarPago entidad)
        {
            int lintPosicion;
            try
            {
                lintPosicion = BLLugarPago.UpdateLugarPago(entidad);
            }
            catch
            {
                throw new FaultException("Error al realizar la actualización de Lugar de Pago.");
            }
            return lintPosicion;
        }

        public void DeleteLugarPago(int paisID, int lugarPagoID)
        {
            try
            {
                BLLugarPago.DeleteLugarPago(paisID, lugarPagoID);
            }
            catch
            {
                throw new FaultException("Error al realizar la eliminación de Lugar de Pago.");
            }
        }

        #endregion

        #region Incentivos

        public IList<BEIncentivo> SelectIncentivos(int paisID, int campaniaID)
        {
            try
            {
                return BLIncentivo.SelectIncentivo(paisID, campaniaID);
            }
            catch (Exception)
            {
                throw new FaultException("Error al realizar la consulta de Incentivo.");
            }
        }

        public void InsertIncentivo(BEIncentivo entidad)
        {
            try
            {
                BLIncentivo.InsertIncentivo(entidad);
            }
            catch
            {
                throw new FaultException("Error al realizar la inserción de Incentivo.");
            }
        }

        public void UpdateIncentivo(BEIncentivo entidad)
        {
            try
            {
                BLIncentivo.UpdateIncentivo(entidad);
            }
            catch
            {
                throw new FaultException("Error al realizar la actualización de Incentivo.");
            }
        }

        public void DeleteIncentivo(int paisID, int incentivoID)
        {
            try
            {
                BLIncentivo.DeleteIncentivo(paisID, incentivoID);
            }
            catch
            {
                throw new FaultException("Error al realizar la eliminación de Incentivo.");
            }
        }

        #endregion

        #region Belcorp Noticias

        public IList<BEBelcorpNoticia> SelectBelcorpNoticias(int paisID, int campaniaID)
        {
            try
            {
                return BLBelcorpNoticia.SelectBelcorpNoticias(paisID, campaniaID);
            }
            catch (Exception)
            {
                throw new FaultException("Error al realizar la consulta de Belcorp Noticias.");
            }
        }

        public BEBelcorpNoticia GetBelcorpNoticiaById(int paisID, int belcorpNoticiaID)
        {
            try
            {
                return BLBelcorpNoticia.GetBelcorpNoticiaById(paisID, belcorpNoticiaID);
            }
            catch (Exception)
            {
                throw new FaultException("Error al realizar la consulta de Belcorp Noticia.");
            }
        }

        public void InsertBelcorpNoticia(BEBelcorpNoticia entidad)
        {
            try
            {
                BLBelcorpNoticia.InsertBelcorpNoticia(entidad);
            }
            catch
            {
                throw new FaultException("Error al realizar la inserción de Belcorp Noticia.");
            }
        }

        public void UpdateBelcorpNoticia(BEBelcorpNoticia entidad)
        {
            try
            {
                BLBelcorpNoticia.UpdateBelcorpNoticia(entidad);
            }
            catch
            {
                throw new FaultException("Error al realizar la actualización de Belcorp Noticia.");
            }
        }

        public void DeleteBelcorpNoticia(int paisID, int belcorpNoticiaID)
        {
            try
            {
                BLBelcorpNoticia.DeleteBelcorpNoticia(paisID, belcorpNoticiaID);
            }
            catch
            {
                throw new FaultException("Error al realizar la eliminación de Belcorp Noticia.");
            }
        }

        #endregion

        #region Tabla Logica Datos
        public List<BETablaLogicaDatos> GetTablaLogicaDatos(int paisID, Int16 TablaLogicaID)
        {
            return BLTablaLogicaDatos.GetTablaLogicaDatos(paisID, TablaLogicaID);
        }
        #endregion

        #region Fe de Erratas

        public IList<BEFeErratas> SelectFeErratas(int paisID, int campaniaID)
        {
            try
            {
                return BLFeErratas.SelectFeErratas(paisID, campaniaID);
            }
            catch (Exception)
            {
                throw new FaultException("Error al realizar la consulta de Fe de Erratas.");
            }
        }

        public void InsertFeErratas(BEFeErratas entidad)
        {
            try
            {
                BLFeErratas.InsertFeErratas(entidad);
            }
            catch
            {
                throw new FaultException("Error al realizar la inserción de Fe de Erratas.");
            }
        }

        public void UpdateFeErratas(BEFeErratas entidad)
        {
            try
            {
                BLFeErratas.UpdateFeErratas(entidad);
            }
            catch
            {
                throw new FaultException("Error al realizar la actualización de Fe de Erratas.");
            }
        }

        public void DeleteFeErratas(int paisID, int feErratasID)
        {
            try
            {
                BLFeErratas.DeleteFeErratas(paisID, feErratasID);
            }
            catch
            {
                throw new FaultException("Error al realizar la eliminación de Fe de Erratas.");
            }
        }
        public void SaveChangesFeErratas(int paisID, List<BEFeErratas> erratasUpdate, List<BEFeErratas> erratasDel)
        {
            try
            {
                BLFeErratas.SaveMultiple(paisID, erratasUpdate, erratasDel);
            }
            catch
            {
                throw new FaultException("Error al guardar los cambios de Fe de Erratas.");
            }
        }

        public IList<BEFeErratas> SelectFeErratasEntradas(int paisID, int campaniaID, string titulo)
        {
            try
            {
                return BLFeErratas.SelectFeErratasEntradas(paisID, campaniaID, titulo);
            }
            catch (Exception)
            {
                throw new FaultException("Error al realizar la consulta de Fe de Erratas.");
            }
        }

        #endregion

        #region CUV_Automatico

        public void InsCuvAutomatico(int paisID, IList<BECUVAutomatico> cuvautomatico)
        {
            BLCUV.InsCuvAutomatico(paisID, cuvautomatico);
        }
        public IList<BECUVAutomatico> GetProductoCuvAutomatico(int paisID, BECUVAutomatico cuvautomatico, string ColumnaOrden, string Ordenamiento, int PaginaActual, int FlagPaginacion, int RegistrosPorPagina)
        {
            return BLCUV.GetProductoCuvAutomatico(paisID, cuvautomatico, ColumnaOrden, Ordenamiento, PaginaActual, FlagPaginacion, RegistrosPorPagina);
        }
        public bool DelCUVAutomatico(int paisID, BECUVAutomatico cuvautomatico)
        {
            return BLCUV.DelCUVAutomatico(paisID, cuvautomatico);
        }

        #endregion

        #region Oferta_FIC
        public void InsOfertaFIC(int paisID, IList<BEOfertaFIC> ofertaFIC)
        {
            BLCUV.InsOfertaFIC(paisID, ofertaFIC);
        }
        public IList<BEOfertaFIC> GetProductoOfertaFIC(int paisID, BEOfertaFIC cuvautomatico, string ColumnaOrden, string Ordenamiento, int PaginaActual, int FlagPaginacion, int RegistrosPorPagina)
        {
            return BLCUV.GetProductoOfertaFIC(paisID, cuvautomatico, ColumnaOrden, Ordenamiento, PaginaActual, FlagPaginacion, RegistrosPorPagina);
        }
        public bool DelOfertaFIC(int paisID, BEOfertaFIC cuvautomatico)
        {
            return BLCUV.DelOfertaFIC(paisID, cuvautomatico);
        }
        #endregion

        #region Banner en Pase de Pedido
        public IList<BEBannerPedido> SelectBannerPedido(int paisID, int campaniaID)
        {
            try
            {
                return BLBannerPedido.SelectBannerPedido(paisID, campaniaID);
            }
            catch (Exception)
            {
                throw new FaultException("Error al realizar la consulta de Banner de Pedido.");
            }
        }

        public void InsertBannerPedido(BEBannerPedido entidad)
        {
            try
            {
                BLBannerPedido.InsertBannerPedido(entidad);
            }
            catch
            {
                throw new FaultException("Error al realizar la inserción de Banner de Pedido.");
            }
        }

        public void UpdateBannerPedido(BEBannerPedido entidad)
        {
            try
            {
                BLBannerPedido.UpdateBannerPedido(entidad);
            }
            catch
            {
                throw new FaultException("Error al realizar la actualización de Banner de Pedido.");
            }
        }

        public void DeleteBannerPedido(int paisID, int BannerPedidoID)
        {
            try
            {
                BLBannerPedido.DeleteBannerPedido(paisID, BannerPedidoID);
            }
            catch
            {
                throw new FaultException("Error al realizar la eliminación de Banner de Pedido.");
            }
        }
        #endregion

        #region Solicitud Credito
        public DateTime GetFechaHoraPais(int paisID)
        {
            return BLSolicitudCredito.GetFechaHoraPais(paisID);
        }
        public IList<BESolicitudCredito> GetSolicitudCreditos(BESolicitudCredito objSolCredito)
        {
            return BLSolicitudCredito.GetSolicitudCreditos(objSolCredito);
        }

        public BESolicitudCredito ValidarSolicitudPendiente(int paisID, string numeroDocumento)
        {
            return BLSolicitudCredito.ValidarSolicitudPendiente(paisID, numeroDocumento);
        }

        public int InsertarSolicitudCredito(int paisID, BESolicitudCredito beSolicitudCredito)
        {
            return BLSolicitudCredito.InsertarSolicitudCredito(paisID, beSolicitudCredito);
        }

        public IList<BECiudad> GetCiudades(int paisID, string codigoRegion)
        {
            return BLSolicitudCredito.GetCiudades(paisID, codigoRegion);
        }

        public IList<BESolicitudCredito> BuscarSolicitudCredito(int paisID, string codigoZona, string codigoTerritorio, DateTime? fechaInicioSolicitud, DateTime? fechaFinSolicitud, string numeroDocumento, int estadoSolicitud, string TipoSolicitud, string CodigoConsultora)
        {
            return BLSolicitudCredito.BuscarSolicitudCredito(paisID, codigoZona, codigoTerritorio, fechaInicioSolicitud, fechaFinSolicitud, numeroDocumento, estadoSolicitud, TipoSolicitud, CodigoConsultora);
        }

        public BESolicitudCredito BuscarSolicitudCreditoPorID(int paisID, int solicitudCreditoID)
        {
            return BLSolicitudCredito.BuscarSolicitudCreditoPorID(paisID, solicitudCreditoID);
        }

        public BESolicitudCredito ObtenerInfoActDatos(int paisID, string codigoConsultora)
        {
            BLSolicitudCredito blSolicitudCredito = new BLSolicitudCredito();
            return blSolicitudCredito.ObtenerInfoActDatos(paisID, codigoConsultora);
        }

        public string[] DescargaSolicitudes(int paisID, string codigoUsuario)
        {
            try
            {
                return BLSolicitudCredito.DescargaSolicitudes(paisID, codigoUsuario);
            }
            catch (BizLogicException ex)
            {
                if (ex.InnerException != null)
                {
                    throw new FaultException(string.Format("{0} ## {1}", ex.Message, ex.InnerException.Message));
                }
                throw new FaultException(ex.Message);
            }
        }

        public DataTable ReporteSolidCreditDia(int paisID, string codigoRegion, DateTime? fechaInicioSolicitud, DateTime? fechaFinSolicitud)
        {
            return BLSolicitudCredito.ReporteSolidCreditDia(paisID, codigoRegion, fechaInicioSolicitud, fechaFinSolicitud);
        }


        #endregion

        #region Configuracion Validacion Nuevo PROL

        public IList<BEConfiguracionValidacionNuevoPROL> GetConfiguracionValidacionNuevoPROL(int PaisID, int TipoPROL)
        {
            return new BLConfiguracionValidacionNuevoPROL().GetConfiguracionValidacionNuevoPROL(PaisID, TipoPROL);
        }

        public int InsConfiguracionValidacionNuevoPROL(int PaisID, string Usuario, IList<BEConfiguracionValidacionNuevoPROL> ZonasNuevoPROL)
        {
            return new BLConfiguracionValidacionNuevoPROL().InsConfiguracionValidacionNuevoPROL(PaisID, Usuario, ZonasNuevoPROL);
        }

        #endregion

        #region Configuracion Tipo Proceso Carga Pedidos
        public IList<BEConfiguracionTipoProcesoCargaPedidos> GetConfiguracionTipoProcesoCargaPedidos(int PaisID, int TipoPROL)
        {
            return new BLConfiguracionTipoProcesoCargaPedidos().GetConfiguracionTipoProcesoCargaPedidos(PaisID, TipoPROL);
        }

        public int InsConfiguracionTipoProcesoCargaPedidos(int PaisID, string Usuario, IList<BEConfiguracionTipoProcesoCargaPedidos> ZonasNuevoPROL)
        {
            return new BLConfiguracionTipoProcesoCargaPedidos().InsConfiguracionTipoProcesoCargaPedidos(PaisID, Usuario, ZonasNuevoPROL);
        }
        #endregion

        #region ConfiguracionParametroCarga

        public IList<BEConfiguracionParametroCarga> GetCampaniasActivasConfiguracionParametroCarga(int paisID, int campaniaID)
        {
            return BLConfiguracionParametroCarga.GetCampaniasActivasConfiguracionParametroCarga(paisID, campaniaID);
        }

        public void InsConfiguracionParametroCarga(BEConfiguracionValidacion ent, List<BEConfiguracionParametroCarga> lista)
        {
            BLConfiguracionParametroCarga.InsConfiguracionParametroCarga(ent, lista);
        }

        public void UpdConfiguracionParametroCarga(BEConfiguracionValidacion ent, List<BEConfiguracionParametroCarga> lista)
        {
            BLConfiguracionParametroCarga.UpdConfiguracionParametroCarga(ent, lista);
        }

        public void DelConfiguracionParametroCarga(int paisID, int campaniaID)
        {
            BLConfiguracionParametroCarga.DelConfiguracionParametroCarga(paisID, campaniaID);
        }

        #endregion

        #region ParametroDiasCargaPedido

        public IList<BEConfiguracionParametroCarga> GetRegionZonaDiasParametroCarga(int PaisID, int RegionID, int ZonaID)
        {
            return BLConfiguracionParametroCarga.GetRegionZonaDiasParametroCarga(PaisID, RegionID, ZonaID);
        }

        public void UpdConfiguracionParametroCargaPedido(int paisID, List<BEConfiguracionParametroCarga> listaEntidades)
        {
            BLConfiguracionParametroCarga.UpdConfiguracionParametroCargaPedido(paisID, listaEntidades);
        }

        public IList<BELogParametroDiasCargaPedido> GetLogParametroDiasCargaPedido(int PaisID)
        {
            return BLLogParametroDiasCargaPedido.GetLogParametroDiasCargaPedido(PaisID);
        }

        public void InsLogParametroDiasCargaPedido(int paisID, string CodigoUsuario, List<BELogParametroDiasCargaPedido> listaEntidades)
        {
            BLLogParametroDiasCargaPedido.InsLogParametroDiasCargaPedido(paisID, CodigoUsuario, listaEntidades);
        }

        #endregion


        public IList<BEConfiguracionPortal> GetConfiguracionPortal(int paisID)
        {
            return BLConfiguracionPortal.GetConfiguracionPortal(paisID);
        }

        #region Participantes Demanada Anticipada - R20160302

        public IList<BEParticipantesDemandaAnticipada> GetParticipantesConfiguracionConsultoraDA(int PaisID, string CodigoCampania, string CodigoConsultora)
        {
            return BLParticipantesDemandaAnticipada.GetParticipantesConfiguracionConsultoraDA(PaisID, CodigoCampania, CodigoConsultora);
        }

        public int InsParticipantesDemandaAnticipada(int paisID, BEParticipantesDemandaAnticipada participantesDemandaAnticipada)
        {
            return BLParticipantesDemandaAnticipada.InsParticipantesDemandaAnticipada(paisID, participantesDemandaAnticipada);
        }

        public BEParticipantesDemandaAnticipada GetConsultoraByCodigo(int paisID, string CodigoConsultora)
        {
            return BLParticipantesDemandaAnticipada.GetConsultoraByCodigo(paisID, CodigoConsultora);
        }


        #endregion

        public BEComunicado GetComunicadoByConsultora(int paisID, string CodigoConsultora)
        {
            return BLComunicado.GetComunicadoByConsultora(paisID, CodigoConsultora);
        }

        public List<BEComunicado> ObtenerComunicadoPorConsultora(int PaisID, string CodigoConsultora, short TipoDispositivo, string CodigoRegion,
            string CodigoZona, int IdEstadoActividad)
        {
            return _comunicadoBusinessLogic.ObtenerComunicadoPorConsultora(PaisID, CodigoConsultora, TipoDispositivo, CodigoRegion, CodigoZona, IdEstadoActividad);
        }

        public List<BEPopupPais> ObtenerOrdenPopUpMostrar(int PaisID)
        {
            return BLPopupPais.ObtenerOrdenPopUpMostrar(PaisID).ToList();
        }

        public void UpdComunicadoByConsultora(int paisID, string CodigoConsultora)
        {
            BLComunicado.UpdComunicadoByConsultora(paisID, CodigoConsultora);
        }

        public void InsertarComunicadoVisualizado(int PaisID, string CodigoConsultora, int ComunicadoID)
        {
            BLComunicado.InsertarComunicadoVisualizado(PaisID, CodigoConsultora, ComunicadoID);
        }

        public void ActualizarVisualizoComunicado(int PaisId, string CodigoConsultora, int ComunicadoId)
        {
            BLComunicado.ActualizarVisualizoComunicado(PaisId, CodigoConsultora, ComunicadoId);
        }

        public void InsertarDonacionConsultora(int PaisId, string CodigoISO, string CodigoConsultora, string Campania, string IPUsuario)
        {
            BLComunicado.InsertarDonacionConsultora(PaisId, CodigoISO, CodigoConsultora, Campania, IPUsuario);
        }

        public List<BEEstadoCuenta> GetEstadoCuentaConsultora(int PaisId, long consultoraId)
        {
            return BLEstadoCuenta.GetEstadoCuentaConsultora(PaisId, consultoraId);
        }

        public string GetDeudaActualConsultora(int PaisId, long consultoraId)
        {
            return BLEstadoCuenta.GetDeudaActualConsultora(PaisId, consultoraId);
        }

        public List<BEPedidoFacturado> GetPedidosFacturadosCabecera(int PaisId, string CodigoConsultora)
        {
            return BLPedidoFacturado.GetPedidosFacturadosCabecera(PaisId, CodigoConsultora);
        }

        public List<BEPedidoFacturado> GetPedidosFacturadosDetalle(int PaisId, string Campania, string Region, string Zona, string CodigoConsultora, int pedidoId)
        {
            return BLPedidoFacturado.GetPedidosFacturadosDetalle(PaisId, Campania, Region, Zona, CodigoConsultora, pedidoId);
        }

        public void DeleteCacheServicio(string CodigoISO, int CampaniaId)
        {
            BLServicio.DeleteCacheServicio(CodigoISO, CampaniaId);
        }

        public BEServicioSegmentoZona GetServicioCampaniaSegmentoZona(int ServicioId, int CampaniaId, int PaisId)
        {
            return BLServicio.GetServicioCampaniaSegmentoZona(ServicioId, CampaniaId, PaisId);
        }

        public List<BEServicioSegmentoZona> GetServicioCampaniaSegmentoZonaAsignados(int ServicioId, int PaisId, int Tipo)
        {
            return BLServicio.GetServicioCampaniaSegmentoZonaAsignados(ServicioId, PaisId, Tipo);
        }

        public void UpdServicioCampaniaSegmentoZona(int ServicioId, int CampaniaId, int PaisId, int Segmento, string ConfiguracionZona, string SegmentoInternoId)
        {
            BLServicio.UpdServicioCampaniaSegmentoZona(ServicioId, CampaniaId, PaisId, Segmento, ConfiguracionZona, SegmentoInternoId);
        }

        public int DelProductoFaltanteMasivo(int paisID, int campaniaID, string zona, string cuv, string fecha, string descripcion)
        {
            return BLproductofaltante.DelProductoFaltanteMasivo(paisID, campaniaID, zona, cuv, fecha, descripcion);
        }

        public List<BETablaLogicaDatos> ListarColoniasByTerritorio(int paisID, string codigo)
        {
            return BLSolicitudCredito.ListarColoniasByTerritorio(paisID, codigo);
        }
        public string ValidarNumeroRFC(int paisID, string numeroRFC)
        {
            return BLSolicitudCredito.ValidarNumeroRFC(paisID, numeroRFC);
        }

        #region Cliente Busca Consultora
        public BEAfiliaClienteConsultora GetAfiliaClienteConsultoraByConsultora(int paisID, string ConsultoraID)
        {
            return BLAfiliaClienteConsultora.GetAfiliaClienteConsultoraByConsultora(paisID, ConsultoraID);
        }
        public int InsAfiliaClienteConsultora(int paisID, long ConsultoraID)
        {
            return BLAfiliaClienteConsultora.InsAfiliaClienteConsultora(paisID, ConsultoraID);
        }
        public int UpdAfiliaClienteConsultora(int paisID, long ConsultoraID, bool EsAfiliacion)
        {
            return BLAfiliaClienteConsultora.UpdAfiliaClienteConsultora(paisID, ConsultoraID, EsAfiliacion);
        }

        public int UpdDesafiliaClienteConsultora(int paisID, long ConsultoraID, bool EsAfiliacion, int MotivoDesafiliacionID)
        {
            return BLAfiliaClienteConsultora.UpdAfiliaClienteConsultora(paisID, ConsultoraID, EsAfiliacion, MotivoDesafiliacionID);
        }
        #endregion

        #region Solicitud Cliente
        public BESolicitudCliente GetSolicitudCliente(int paisID, long SolicitudClienteId)
        {
            return BLSolicitudCliente.GetSolicitudClienteBySolicitudId(paisID, SolicitudClienteId);
        }

        public List<BESolicitudClienteDetalle> GetSolicitudClienteDetalle(int paisID, long SolicitudClienteId)
        {
            return BLSolicitudCliente.GetSolicitudClienteDetalleBySolicitudId(paisID, SolicitudClienteId);
        }

        public void UpdSolicitudCliente(int paisID, BESolicitudCliente entidadSolicitud)
        {
            BLSolicitudCliente.UpdSolicitudCliente(paisID, entidadSolicitud);
        }

        public void UpdSolicitudClienteDetalle(int paisID, BESolicitudClienteDetalle entidadSolicitudDetalle)
        {
            BLSolicitudCliente.UpdSolicitudClienteDetalle(paisID, entidadSolicitudDetalle);
        }

        public void RechazarSolicitudCliente(int paisID, long solicitudId, bool definitivo, int opcionRechazo, string razonMotivoRechazo)
        {
            BLSolicitudCliente.RechazarSolicitudCliente(paisID, solicitudId, definitivo, opcionRechazo, razonMotivoRechazo);
        }

        public BESolicitudNuevaConsultora ReasignarSolicitudCliente(int paisID, long solicitudId, string codigoUbigeo, string campania, int marcaId, int opcionRechazo, string razonMotivoRechazo)
        {
            return BLSolicitudCliente.ReasignarSolicitudCliente(paisID, solicitudId, codigoUbigeo, campania, marcaId, opcionRechazo, razonMotivoRechazo);
        }

        public void CancelarSolicitudCliente(int paisID, long solicitudId, int opcionCancelacion, string razonMotivoCancelacion)
        {
            BLSolicitudCliente.CancelarSolicitudCliente(paisID, solicitudId, opcionCancelacion, razonMotivoCancelacion);
        }

        public void CancelarSolicitudClienteYRemoverPedido(int paisID, int campaniaID, long consultoraID, string codigoUsuario, long solicitudId, int opcionCancelacion, string razonMotivoCancelacion)
        {
            string error = BLSolicitudCliente.CancelarSolicitudClienteYRemoverPedido(paisID, campaniaID, consultoraID, codigoUsuario, solicitudId, opcionCancelacion, razonMotivoCancelacion);
            if (!string.IsNullOrEmpty(error)) throw new FaultException(error);
        }

        public List<BEMotivoSolicitud> GetMotivosRechazo(int paisID)
        {
            return BLSolicitudCliente.GetMotivosRechazo(paisID);
        }

        #endregion

        public int EnviarSolicitudClienteaGZ(int paisID, BESolicitudCliente entidadSolicitudCliente)
        {
            return BLSolicitudCliente.EnviarSolicitudClienteaGZ(paisID, entidadSolicitudCliente);
        }

        public List<BESolicitudCliente> BuscarSolicitudAnuladasRechazadas(int paisID, BESolicitudCliente entidadSolicitudCliente)
        {
            return BLSolicitudCliente.BuscarSolicitudAnuladasRechazadas(paisID, entidadSolicitudCliente);
        }

        public BESolicitudCliente DetalleSolicitudAnuladasRechazadas(int paisID, BESolicitudCliente entidadSolicitudCliente)
        {
            return BLSolicitudCliente.DetalleSolicitudAnuladasRechazadas(paisID, entidadSolicitudCliente);
        }

        public BEConfiguracionPortal ObtenerConfiguracionPortal(BEConfiguracionPortal beoConfiguracionPortal)
        {
            return BLConfiguracionPortal.ObtenerConfiguracionPortal(beoConfiguracionPortal);
        }

        public int ActualizarConfiguracionPortal(BEConfiguracionPortal beoConfiguracionPortal)
        {
            return BLConfiguracionPortal.ActualizarConfiguracionPortal(beoConfiguracionPortal);
        }

        #region Descarga Curso Lider
        public void GetInformacionCursoLiderDescarga(int PaisId, string PaisISO, string FechaProceso, string Usuario)
        {
            new BLMiAcademia().GetInformacionCursoLiderDescarga(PaisId, PaisISO, FechaProceso, Usuario);
        }
        #endregion

        public List<BEEstadoSolicitudCliente> GetEstadoSolicitudCliente(int paisID)
        {
            return BLSolicitudCliente.GetEstadoSolicitudCliente(paisID);
        }

        public List<BEReporteAfiliados> GetReporteAfiliados(int paisID, DateTime FechaInicio, DateTime FechaFin)
        {
            return BLSolicitudCliente.GetReporteAfiliado(FechaInicio, FechaFin, paisID);
        }

        public List<BEReportePedidos> GetReportePedidos(DateTime FechaInicio, DateTime FechaFin, int estado, string marca, string campania, int paisID)
        {
            return BLSolicitudCliente.GetReportePedidos(FechaInicio, FechaFin, estado, marca, campania, paisID);
        }

        public void GetConsultoraDigitalesDescarga(int PaisId, string PaisISO, string FechaProceso, string Usuario)
        {
            BLConsultoraDigitales.GetConsultoraDigitalesDescarga(PaisId, PaisISO, FechaProceso, Usuario);
        }

        public BEPaisCampana GetCampaniaActivaPais(int paisID, DateTime fechaConsulta)
        {
            return BLCronograma.GetCampaniaActivaPais(paisID, fechaConsulta).FirstOrDefault();
        }

        public List<BEProveedorDespachoCobranza> GetProveedorDespachoCobranza(int paisID)
        {
            return BLProveedorDespachoCobranza.GetProveedorDespachoCobranza(paisID);
        }

        public int DelProveedorDespachoCobranza(int paisID, int ProveedorDespachoCobanzaID)
        {
            return BLProveedorDespachoCobranza.DelProveedorDespachoCobranza(paisID, ProveedorDespachoCobanzaID);
        }

        public void UpdProveedorDespachoCobranzaCabecera(int paisID, BEProveedorDespachoCobranza entidad)
        {
            BLProveedorDespachoCobranza.UpdProveedorDespachoCobranzaCabecera(paisID, entidad);
        }

        public void InsProveedorDespachoCobranzaCabecera(int paisID, BEProveedorDespachoCobranza entidad)
        {
            try
            {
                BLProveedorDespachoCobranza.InsDespachoCobranzaCabecera(entidad);
            }
            catch
            {
                throw new FaultException("Error al realizar la inserción de Proveedor Despacho Cobranza.");
            }
        }

        public void MntoCampoProveedorDespachoCobranza(BEProveedorDespachoCobranza entidad, int accion, int campoid, string valor, string valorAntiguo)
        {
            BLProveedorDespachoCobranza.MntoCampoProveedorDespachoCobranza(entidad, accion, campoid, valor, valorAntiguo);
        }

        public List<BEProveedorDespachoCobranza> GetProveedorDespachoCobranzaMnto(int paisID, BEProveedorDespachoCobranza entidad)
        {
            return BLProveedorDespachoCobranza.GetProveedorDespachoCobranzaMnto(paisID, entidad);
        }

        public List<BEProveedorDespachoCobranza> GetProveedorDespachoCobranzaBYiD(int paisID, BEProveedorDespachoCobranza entity)
        {
            return BLProveedorDespachoCobranza.GetProveedorDespachoCobranzaBYiD(paisID, entity);
        }

        public bool EnviarProactivaChatbot(string paisISO, string urlRelativa, List<BEChatbotProactivaMensaje> listMensajeProactiva)
        {

            return new BLProactivaChatbot().SendMessage(paisISO, urlRelativa, listMensajeProactiva);
        }

        public List<BEPedidoFacturado> GetPedidosFacturadosDetalleMobile(int PaisId, int campaniaID, long ConsultoraID, short ClienteID, string CodigoConsultora)
        {
            return BLPedidoFacturado.GetPedidosFacturadosDetalleMobile(PaisId, campaniaID, ConsultoraID, ClienteID, CodigoConsultora);
        }

        public int UpdateClientePedidoFacturado(int paisID, int codigoPedido, int ClienteID)
        {
            return BLPedidoFacturado.UpdateClientePedidoFacturado(paisID, codigoPedido, ClienteID);
        }
        public string GetCampaniaActualAndSiguientePais(int paisID, string codigoIso)
        {
            return BLCronograma.GetCampaniaActualAndSiguientePais(paisID, codigoIso);

        }

        #region Mobile
        public IList<BEApp> ListarApps(int paisID)
        {
            return _blApp.ObtenerApps(paisID);
        }
        #endregion

        #region ConfiguracionPais
        public List<BEConfiguracionPais> ListConfiguracionPais(int paisId, bool tienePerfil)
        {
            var bl = new BLConfiguracionPais();
            return bl.GetList(paisId, tienePerfil);
        }
        public BEConfiguracionPais GetConfiguracionPais(int paisId, int configuracionPaisId)
        {
            var bl = new BLConfiguracionPais();
            return bl.Get(paisId, configuracionPaisId);
        }
        public BEConfiguracionPais GetConfiguracionPaisByCode(int paisId, string codigo)
        {
            var bl = new BLConfiguracionPais();
            return bl.Get(paisId, codigo);
        }
        public void UpdateConfiguracionPais(BEConfiguracionPais configuracionPais)
        {
            var bl = new BLConfiguracionPais();
            bl.Update(configuracionPais);
        }

        public BEConfiguracionPaisDatos GetConfiguracionPaisDatos(BEConfiguracionPaisDatos configuracionPaisDatos)
        {
            var bl = new BLConfiguracionPaisDatos();
            return bl.Get(configuracionPaisDatos);
        }
        #endregion

        #region ConfiguracionOfertasHome
        public List<BEConfiguracionOfertasHome> ListConfiguracionOfertasHome(int paisId, int campaniaId)
        {
            var bl = new BLConfiguracionOfertasHome();
            return bl.GetList(paisId, campaniaId);
        }

        public BEConfiguracionOfertasHome GetConfiguracionOfertasHome(int paisId, int configuracionOfertasHomeId)
        {
            var bl = new BLConfiguracionOfertasHome();
            return bl.Get(paisId, configuracionOfertasHomeId);
        }

        public void UpdateConfiguracionOfertasHome(BEConfiguracionOfertasHome configuracionOfertasHome)
        {
            var bl = new BLConfiguracionOfertasHome();
            bl.Update(configuracionOfertasHome);
        }
        public IList<BEConfiguracionOfertasHome> ListarSeccionConfiguracionOfertasHome(int paisId, int campaniaId)
        {
            var bl = new BLConfiguracionOfertasHome();
            return bl.GetListarSeccion(paisId, campaniaId);
        }
        #endregion

        #region Estrategia
        public List<BEDescripcionEstrategia> ActualizarDescripcionEstrategia(int paisId, int campaniaId, int tipoEstrategiaId, List<BEDescripcionEstrategia> listaDescripcionEstrategias)
        {
            var bl = new BLAdministrarEstrategia();
            return bl.ActualizarDescripcionEstrategia(paisId, campaniaId, tipoEstrategiaId, listaDescripcionEstrategias);
        }
        #endregion

        #region UpSelling

        public IEnumerable<UpSelling> UpSellingObtener(int paisId, string codigoCampana, bool incluirDetalle = false)
        {
            return new UpSellingBusinessLogic(paisId).Obtener(codigoCampana, incluirDetalle);
        }

        public UpSelling UpSellingInsertar(int paisId, UpSelling upSelling)
        {
            var upSellingBusinessLogic = new UpSellingBusinessLogic(paisId);

            if (upSelling.UpSellingId != default(int))
                throw new ArgumentException("UpSellingId debe ser 0 para insertar");

            return upSellingBusinessLogic.Insertar(upSelling);
        }

        public UpSelling UpSellingActualizar(int paisId, UpSelling upSelling, bool soloCabecera)
        {
            return new UpSellingBusinessLogic(paisId).Actualizar(upSelling, soloCabecera);
        }

        public void UpSellingEliminar(int paisId, int upSellingId)
        {
            new UpSellingBusinessLogic(paisId).Eliminar(upSellingId);
        }

        public UpSellingDetalle UpSellingDetalleObtener(int paisId, int upSellingDetalleId)
        {
            return new UpSellingBusinessLogic(paisId).ObtenerDetalle(upSellingDetalleId);
        }

        public IEnumerable<UpSellingDetalle> UpSellingDetallesObtener(int paisId, int upSellingId)
        {
            return new UpSellingBusinessLogic(paisId).ObtenerDetalles(upSellingId);
        }

        public UpSellingRegalo UpSellingObtenerMontoMeta(int paisId, int campaniaId, long consultoraId)
        {
            var upSellingBusinessLogic = new UpSellingBusinessLogic(paisId);

            return upSellingBusinessLogic.ObtenerMontoMeta(campaniaId, consultoraId);
        }

        public int UpSellingInsertarRegalo(int paisId, UpSellingRegalo entidad)
        {
            var upSellingBusinessLogic = new UpSellingBusinessLogic(paisId);

            return upSellingBusinessLogic.InsertarRegalo(entidad);
        }

        public UpSellingRegalo UpSellingObtenerRegaloGanado(int paisId, int campaniaId, long consultoraId)
        {
            var upSellingBusinessLogic = new UpSellingBusinessLogic(paisId);

            return upSellingBusinessLogic.ObtenerRegaloGanado(campaniaId, consultoraId);
        }

        public IEnumerable<UpSellingMontoMeta> UpSellingReporteMontoMeta(int paisId, int upSellingId)
        {
            var upSellingBusinessLogic = new UpSellingBusinessLogic(paisId);

            return upSellingBusinessLogic.ListarReporteMontoMeta(upSellingId);
        }

        #endregion

        public List<string> GetListEnumStringCache()
        {
            return new BLCache().GetListEnumString();
        }
        public string RemoveDataCache(int paisID, string cacheItemString, string customKey)
        {
            return new BLCache().RemoveData(paisID, cacheItemString, customKey);
        }

        #region MarcaCategoria Apoyadas

        public IEnumerable<UpsellingMarcaCategoria> UpsellingMarcaCategoriaObtener(int paisId,int upSellingId, string MarcaID, string CategoriaID)
        {
            return new UpsellingMarcaCategoriaBusinessLogic(paisId).UpsellingMarcaCategoriaObtener(upSellingId, MarcaID, CategoriaID);
        }

        public UpsellingMarcaCategoria UpsellingMarcaCategoriaInsertar(int paisId, int upSellingId, string MarcaID, string CategoriaID)
        {
            return new UpsellingMarcaCategoriaBusinessLogic(paisId).UpsellingMarcaCategoriaInsertar(upSellingId, MarcaID, CategoriaID);
        }


        public bool UpsellingMarcaCategoriaEliminar(int paisId, int upSellingId, string MarcaID, string CategoriaID)
        {
            return new UpsellingMarcaCategoriaBusinessLogic(paisId).UpsellingMarcaCategoriaEliminar(upSellingId, MarcaID, CategoriaID);
        }


        public bool UpsellingMarcaCategoriaFlagsEditar(int paisId, int upSellingId, bool CategoriaApoyada, bool CategoriaMonto)
        {
            return new UpsellingMarcaCategoriaBusinessLogic(paisId).UpsellingMarcaCategoriaFlagsEditar(upSellingId, CategoriaApoyada, CategoriaMonto);
        }

        #endregion

        #region Categoria 

        public IList<BECategoria> SelectCategoria(int paisID)
        {
            return _blCategoria.SelectCategorias(paisID);
        }
      
        #endregion

        #region Catálogos y Revistas
      
        public IList<BECatalogoRevista_ODS> SelectCatalogoRevista_Filtro(int paisID)
        {
            return _bLCatalogo.PS_CatalogoRevistas_ODS(paisID);
        }

        public IList<BECatalogoRevista_ODS> SelectCatalogoRevista_ODS(int paisID)
        {
            return _bLCatalogo.SelectCatalogoRevistas_ODS(paisID);
        }
        #endregion

        #region Nuevo Masivo

        public int GetCantidadOfertasPersonalizadas(int paisId, int campaniaId, int tipoConfigurado, string codigoEstrategia)
        {
            return _blAdministrarEstrategia.GetCantidadOfertasPersonalizadas(paisId, campaniaId, tipoConfigurado, codigoEstrategia);
        }
        
        public List<BEEstrategia> GetOfertasPersonalizadasByTipoConfigurado(int paisId, int campaniaId, int tipoConfigurado, string estrategiaCodigo, int pagina, int cantidadCuv)
        {
            return _blAdministrarEstrategia.GetOfertasPersonalizadasByTipoConfigurado(paisId, campaniaId, tipoConfigurado, estrategiaCodigo, pagina, cantidadCuv);
        }

        public int GetCantidadOfertasPersonalizadasTemporal(int paisId, int nroLote, int tipoConfigurado)
        {
            return _blAdministrarEstrategia.GetCantidadOfertasPersonalizadasTemporal(paisId, nroLote, tipoConfigurado);
        }

        public int EstrategiaTemporalDelete(int paisId, int nroLote)
        {
            return _blAdministrarEstrategia.EstrategiaTemporalDelete(paisId, nroLote);
        }
        
        public List<BEEstrategia> GetOfertasPersonalizadasByTipoConfiguradoTemporal(int paisId, int tipoConfigurado, int nroLote)
        {
            return _blAdministrarEstrategia.GetOfertasPersonalizadasByTipoConfiguradoTemporal(paisId, tipoConfigurado, nroLote);
        }

        public int EstrategiaTemporalInsertarMasivo(int paisId, int campaniaId, string estrategiaCodigo, int pagina, int cantidadCuv, int nroLote)
        {
            return _blAdministrarEstrategia.EstrategiaTemporalInsertarMasivo(paisId, campaniaId, estrategiaCodigo, pagina, cantidadCuv, nroLote);
        }

        public bool EstrategiaTemporalActualizarPrecioNivel(int paisId, int nroLote, int pagina)
        {
            return _blAdministrarEstrategia.EstrategiaTemporalActualizarPrecioNivel(paisId, nroLote, pagina);
        }

        public bool EstrategiaTemporalActualizarSetDetalle(int paisId, int nroLote, int pagina)
        {
            return _blAdministrarEstrategia.EstrategiaTemporalActualizarSetDetalle(paisId, nroLote, pagina);
        }

        public int EstrategiaTemporalInsertarEstrategiaMasivo(int paisId, int nroLote)
        {
            return _blAdministrarEstrategia.EstrategiaTemporalInsertarEstrategiaMasivo(paisId, nroLote);
        }
        #endregion

        public List<BEBuscadorResponse> ObtenerBuscadorComplemento(int paisID, string codigoUsuario, bool suscripcionActiva, List<BEBuscadorResponse> lst, bool isApp)
        {
            return _buscadorBusinessLogic.ObtenerBuscadorComplemento(paisID, codigoUsuario, suscripcionActiva, lst, isApp);
        }
    }
}