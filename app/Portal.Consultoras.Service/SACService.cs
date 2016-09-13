using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using Portal.Consultoras.Entities;
using Portal.Consultoras.BizLogic;
using Portal.Consultoras.ServiceContracts;
using System.ServiceModel;
using System.Data;

namespace Portal.Consultoras.Service
{
    public class SACService : ISACService
    {
        private BLCronograma BLCronograma;
        private BLCronogramaAnticipado BLCronogramaAnticipado;
        private BLProductoFaltante BLproductofaltante;
        private BLConfiguracionValidacionZona BLConfiguracionValidacionZona;
        private BLConfiguracionValidacion BLConfiguracionValidacion;
        private BLProducto BLProducto;
        private BLOfertaWeb BLOfertaWeb;
        private BLConsultoraFicticia BLConsultoraFicticia;
        private BLDatosBelcorp BLDatosBelcorp;
        private BLServicio BLServicio;
        private BLFactorGanancia BLFactorGanancia;
        private BLSolicitudCredito BLSolicitudCredito;
        private BLLogModificacionCronograma BLLogModificacionCronograma;
        private BLLugarPago BLLugarPago;
        private BLIncentivo BLIncentivo;
        private BLBelcorpNoticia BLBelcorpNoticia;
        private BLTablaLogicaDatos BLTablaLogicaDatos;
        private BLFeErratas BLFeErratas;
        private BLCuv BLCUV;
        private BLBannerPedido BLBannerPedido;
        private BLComunicado BLComunicado; //R2004
        private BLEstadoCuenta BLEstadoCuenta; //R2073
        private BLPedidoFacturado BLPedidoFacturado; //R2073
        private BLAfiliaClienteConsultora BLAfiliaClienteConsultora;//R2319
        private BLSolicitudCliente BLSolicitudCliente;
        private BLConfiguracionPortal BLConfiguracionPortal;
        private BLConsultoraDigitales BLConsultoraDigitales;
        private BLProveedorDespachoCobranza BLProveedorDespachoCobranza;
        private BLConfiguracionParametroCarga BLConfiguracionParametroCarga; //R20151221
        private BLLogParametroDiasCargaPedido BLLogParametroDiasCargaPedido; //R20151221
        private BLParticipantesDemandaAnticipada BLParticipantesDemandaAnticipada; //R20160302

        public SACService()
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
            BLComunicado = new BLComunicado(); //R2004
            BLEstadoCuenta = new BLEstadoCuenta(); //R2073
            BLPedidoFacturado = new BLPedidoFacturado(); //R2073
            BLAfiliaClienteConsultora = new BLAfiliaClienteConsultora();//2319
            BLSolicitudCliente = new BLSolicitudCliente();
            BLConfiguracionPortal = new BLConfiguracionPortal();
            BLConsultoraDigitales = new BLConsultoraDigitales();
            BLProveedorDespachoCobranza = new BLProveedorDespachoCobranza();
            BLConfiguracionParametroCarga = new BLConfiguracionParametroCarga(); //R20151221
            BLLogParametroDiasCargaPedido = new BLLogParametroDiasCargaPedido(); //R20151221
            BLParticipantesDemandaAnticipada = new BLParticipantesDemandaAnticipada(); //R20160302
        }

        #region Cronograma Anticipado

        public IList<BECronograma> GetCronogramaByCampaniaAnticipado(int paisID, int CampaniaID, int ZonaID, Int16 TipoCronogramaID)
        {
            return BLCronogramaAnticipado.GetCronogramaByCampaniaAnticipado(paisID, CampaniaID, ZonaID, TipoCronogramaID);
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
        public IList<BECronograma> GetCronogramaByCampania(int paisID, int CampaniaID, int ZonaID, Int16 TipoCronogramaID)
        {
            return BLCronograma.GetCronogramaByCampania(paisID, CampaniaID, ZonaID, TipoCronogramaID);
        }

        //public void Update(BECronograma cronograma)
        //{
        //    BLCronograma.Update(cronograma);
        //}

        public BECronograma GetCronogramaByCampaniayZona(int paisID, int CampaniaID, int ZonaID)
        {
            return BLCronograma.GetCronogramaByCampaniayZona(paisID, CampaniaID, ZonaID);
        }

        public int MigrarCronogramaAnticipado(int paisID, int CampaniaID, int ZonaID)
        {
            return BLCronograma.MigrarCronogramaAnticipado(paisID, CampaniaID, ZonaID);
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

        public bool DelProductoFaltante(int paisID, string paisISO, string CodigoUsuario, BEProductoFaltante productofaltante)
        {
            return BLproductofaltante.DelProductoFaltante(paisID, paisISO, CodigoUsuario, productofaltante);
        }

        //R1957
        public int DelProductoFaltante2(int paisID, string paisISO, string CodigoUsuario, IList<BEProductoFaltante> productofaltante, int flag, int pais, int campania, int zona, string cuv, string e_producto, DateTime fecha)
        {
            return BLproductofaltante.DelProductoFaltante2(paisID, paisISO, CodigoUsuario, productofaltante, flag, pais, campania, zona, cuv, e_producto, fecha);
        }

        public IList<BEProductoFaltante> GetProductoFaltanteByEntity(int paisID, BEProductoFaltante productofaltante, string ColumnaOrden, string Ordenamiento, int PaginaActual, int FlagPaginacion, int RegistrosPorPagina)
        {
            return BLproductofaltante.GetProductoFaltanteByEntity(paisID, productofaltante, ColumnaOrden, Ordenamiento, PaginaActual, FlagPaginacion, RegistrosPorPagina);
        }

        public IList<BEProductoFaltante> GetProductoFaltanteByCampaniaAndZonaID(int paisID, int CampaniaID, int ZonaID)
        {
            return BLproductofaltante.GetProductoFaltanteByCampaniaAndZonaID(paisID, CampaniaID, ZonaID);
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
            return BLConfiguracionValidacion.GetConfiguracionValidacion(paisID, campaniaID);
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

        #endregion

        #region Oferta Web

        public IList<BEOfertaWeb> GetOfertaWebByCampania(int PaisID, int CampaniaID, int PedidoID, long ConsultoraID)
        {
            return BLOfertaWeb.GetOfertaWebByCampania(PaisID, CampaniaID, PedidoID, ConsultoraID);
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

        public void UpdConsultoraFicticia(string CodigoUsuario, string CodigoConsultora, int paisID, Int64 ConsultoraID)
        {
            BLConsultoraFicticia.UpdConsultoraFicticia(CodigoUsuario, CodigoConsultora, paisID, ConsultoraID);
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
        //public void UpdateCronogramaDD(int paisID, string CampaniaCodigo, string Codigos, int Tipo, DateTime FechaFacturacion, DateTime FechaReFacturacion, DateTime FechaFinFacturacion, string CodigoUsuario)
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
            int Result = 0;
            try
            {
                Result = BLFactorGanancia.InsertFactorGanancia(entidad);
            }
            catch
            {
                throw new FaultException("Error al realizar la inserción de Factor Ganancia.");
            }
            return Result;
        }

        public int UpdateFactorGanancia(BEFactorGanancia entidad)
        {
            int Result = 0;
            try
            {
                Result = BLFactorGanancia.UpdateFactorGanancia(entidad);
            }
            catch
            {
                throw new FaultException("Error al realizar la actualización de Factor Ganancia.");
            }
            return Result;
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
            BEFactorGanancia Result = null;
            try
            {
                Result = BLFactorGanancia.GetFactorGananciaSiguienteEscala(monto, paisID);
            }
            catch (Exception)
            {
                //throw new FaultException("Error al realizar la consulta de la siguiente escala de descuento.");
            }
            return Result;
        }

        public BEFactorGanancia GetFactorGananciaEscalaDescuento(decimal monto, int paisID)
        {
            BEFactorGanancia Result = null;
            try
            {
                Result = BLFactorGanancia.GetFactorGananciaEscalaDescuento(monto, paisID);
            }
            catch (Exception)
            {
                //throw new FaultException("Error al realizar la consulta de la Escala de Descuento.");
            }
            return Result;
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

        public void InsertLugarPago(BELugarPago entidad)
        {
            try
            {
                BLLugarPago.InsertLugarPago(entidad);
            }
            catch
            {
                throw new FaultException("Error al realizar la inserción de Lugar de Pago.");
            }
        }

        public void UpdateLugarPago(BELugarPago entidad)
        {
            try
            {
                BLLugarPago.UpdateLugarPago(entidad);
            }
            catch
            {
                throw new FaultException("Error al realizar la actualización de Lugar de Pago.");
            }
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

        //public BEIncentivo GetIncentivoById(int paisID, int incentivoID)
        //{
        //    try
        //    {
        //        return BLIncentivo.GetIncentivoById(paisID, incentivoID);
        //    }
        //    catch (Exception)
        //    {
        //        throw new FaultException("Error al realizar la consulta de Incentivo.");
        //    } 
        //}

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

        //public BELugarPago GetFeErratasById(int paisID, int feErratasID)
        //{
        //    try
        //    {
        //        return BLFeErratas.GetFeErratasById(paisID, feErratasID);
        //    }
        //    catch (Exception)
        //    {
        //        throw new FaultException("Error al realizar la consulta de Fe de Erratas.");
        //    } 
        //}

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

        #region "Banner en Pase de Pedido"
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
        //R20150909 - Inicio
        public DateTime GetFechaHoraPais(int paisID)
        {
            return BLSolicitudCredito.GetFechaHoraPais(paisID);
        }
        //R20150909 - Fin
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

        //AOB :Reportes
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


        //R20151221 Inicio

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

        //End R20151221


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


        //R2004
        public BEComunicado GetComunicadoByConsultora(int paisID, string CodigoConsultora)
        {
            return BLComunicado.GetComunicadoByConsultora(paisID, CodigoConsultora);
        }

        public List<BEComunicado> ObtenerComunicadoPorConsultora(int PaisID, string CodigoConsultora)
        {
            return BLComunicado.ObtenerComunicadoPorConsultora(PaisID, CodigoConsultora).ToList();
        }

        //R2004
        public void UpdComunicadoByConsultora(int paisID, string CodigoConsultora)
        {
            BLComunicado.UpdComunicadoByConsultora(paisID, CodigoConsultora);
        }

        public void InsertarComunicadoVisualizado(int PaisID, string CodigoConsultora, int ComunicadoID)
        {

            BLComunicado.InsertarComunicadoVisualizado(PaisID, CodigoConsultora, ComunicadoID);
        }

        public void InsertarDonacionConsultora(int PaisId, string CodigoISO, string CodigoConsultora, string Campania, string IPUsuario)
        {
            BLComunicado.InsertarDonacionConsultora(PaisId, CodigoISO, CodigoConsultora, Campania, IPUsuario);
        }

        // R2073 - Inicio
        public List<BEEstadoCuenta> GetEstadoCuentaConsultora(int PaisId, string CodigoConsultora)
        {
            return BLEstadoCuenta.GetEstadoCuentaConsultora(PaisId, CodigoConsultora);
        }

        public List<BEPedidoFacturado> GetPedidosFacturadosCabecera(int PaisId, string CodigoConsultora)
        {
            return BLPedidoFacturado.GetPedidosFacturadosCabecera(PaisId, CodigoConsultora);
        }

        public List<BEPedidoFacturado> GetPedidosFacturadosDetalle(int PaisId, string Campania, string Region, string Zona, string CodigoConsultora)
        {
            return BLPedidoFacturado.GetPedidosFacturadosDetalle(PaisId, Campania, Region, Zona, CodigoConsultora);
        }
        // R2073 - Fin

        //RQ_DC - R2133
        public void DeleteCacheServicio(string CodigoISO, int CampaniaId)
        {
            BLServicio.DeleteCacheServicio(CodigoISO, CampaniaId);
        }

        //RQ_PBS - R2161
        public BEServicioSegmentoZona GetServicioCampaniaSegmentoZona(int ServicioId, int CampaniaId, int PaisId)
        {
            return BLServicio.GetServicioCampaniaSegmentoZona(ServicioId, CampaniaId, PaisId);
        }

        //RQ_PBS - R2161
        public List<BEServicioSegmentoZona> GetServicioCampaniaSegmentoZonaAsignados(int ServicioId, int PaisId, int Tipo)
        {
            return BLServicio.GetServicioCampaniaSegmentoZonaAsignados(ServicioId, PaisId, Tipo);
        }

        //RQ_PBS - R2161
        /*RE2544 - CS(CGI)*/
        public void UpdServicioCampaniaSegmentoZona(int ServicioId, int CampaniaId, int PaisId, int Segmento, string ConfiguracionZona, string SegmentoInternoId)
        {
            BLServicio.UpdServicioCampaniaSegmentoZona(ServicioId, CampaniaId, PaisId, Segmento, ConfiguracionZona, SegmentoInternoId);
        }

        // 1957 - Inicio
        public int DelProductoFaltanteMasivo(int paisID, int campaniaID, string zona, string cuv, string fecha, string descripcion)
        {
            return BLproductofaltante.DelProductoFaltanteMasivo(paisID, campaniaID, zona, cuv, fecha, descripcion);
        }
        // 1957 - Fin

        // R2155 - Inicio
        public List<BETablaLogicaDatos> ListarColoniasByTerritorio(int paisID, string codigo)
        {
            return BLSolicitudCredito.ListarColoniasByTerritorio(paisID, codigo);
        }
        public string ValidarNumeroRFC(int paisID, string numeroRFC)
        {
            return BLSolicitudCredito.ValidarNumeroRFC(paisID, numeroRFC);
        }
        // R2155 - Fin

        #region Cliente Busca Consultora
        //R2319 - JLCS
        public BEAfiliaClienteConsultora GetAfiliaClienteConsultoraByConsultora(int paisID, string ConsultoraID)
        {
            return BLAfiliaClienteConsultora.GetAfiliaClienteConsultoraByConsultora(paisID, ConsultoraID);
        }
        //R2319 - JLCS
        public int InsAfiliaClienteConsultora(int paisID, long ConsultoraID)
        {
            return BLAfiliaClienteConsultora.InsAfiliaClienteConsultora(paisID, ConsultoraID);
        }
        //R2319 - JLCS
        public int UpdAfiliaClienteConsultora(int paisID, long ConsultoraID, bool EsAfiliacion)
        {
            return BLAfiliaClienteConsultora.UpdAfiliaClienteConsultora(paisID, ConsultoraID, EsAfiliacion);
        }

        public int UpdDesafiliaClienteConsultora(int paisID, long ConsultoraID, bool EsAfiliacion, int MotivoDesafiliacionID)
        {
            return BLAfiliaClienteConsultora.UpdAfiliaClienteConsultora(paisID, ConsultoraID, EsAfiliacion, MotivoDesafiliacionID);
        }
        #endregion

        //R2319 JLCS
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


        #endregion

        /* R2319 - AAHA 02022015 - Parte 6 - Inicio */
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
        /* R2319 - AAHA 02022015 - Parte 6 - Fin */

        public BEConfiguracionPortal ObtenerConfiguracionPortal(BEConfiguracionPortal beoConfiguracionPortal)
        {
            return BLConfiguracionPortal.ObtenerConfiguracionPortal(beoConfiguracionPortal);
        }

        public int ActualizarConfiguracionPortal(BEConfiguracionPortal beoConfiguracionPortal)
        {
            return BLConfiguracionPortal.ActualizarConfiguracionPortal(beoConfiguracionPortal);
        }

        /*R20150804 - MER - inico*/
        #region Descarga Curso Lider
        public void GetInformacionCursoLiderDescarga(int PaisId, string PaisISO, string FechaProceso, string Usuario)
        {
            new BLMiAcademia().GetInformacionCursoLiderDescarga(PaisId, PaisISO, FechaProceso, Usuario);
        }
        #endregion
        /*R20150804 - MER - fin*/



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
            new BLConsultoraDigitales().GetConsultoraDigitalesDescarga(PaisId, PaisISO, FechaProceso, Usuario);
        }

        public BEPaisCampana GetCampaniaActivaPais(int paisID, DateTime fechaConsulta)
        {
            return BLCronograma.GetCampaniaActivaPais(paisID, fechaConsulta).FirstOrDefault();
        }

        public List<BEProveedorDespachoCobranza> GetProveedorDespachoCobranza(int paisID)
        {
            return BLProveedorDespachoCobranza.GetProveedorDespachoCobranza(paisID);
        }

        //i R20151202

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

        //fR20151202

    }
}
