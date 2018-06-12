using Portal.Consultoras.BizLogic;
using Portal.Consultoras.Entities;
using Portal.Consultoras.ServiceContracts;
using System;
using System.Collections.Generic;
using System.Data;
using System.ServiceModel;

namespace Portal.Consultoras.Service
{
    public class ContenidoService : IContenidoService
    {
        private readonly BLNavidadConsultora _BLNavidadConsultora;
        private readonly BLItemCarruselInicio _BLItemCarruselInicio;
        private readonly BLMailing _BLMailing;

        public ContenidoService()
        {
            _BLNavidadConsultora = new BLNavidadConsultora();
            _BLItemCarruselInicio = new BLItemCarruselInicio();
            _BLMailing = new BLMailing();
        }

        #region Gestion Banners

        public IList<BEBanner> SelectBanner(int campaniaID)
        {
            var blBanner = new BLBanner();
            return blBanner.SelectBanner(campaniaID);
        }

        public IList<BEGrupoBanner> SelectGrupoBanner(int campaniaID)
        {
            var blBanner = new BLBanner();
            return blBanner.SelectGrupoBanner(campaniaID);
        }

        public int SaveBanner(BEBanner banner)
        {
            var blBanner = new BLBanner();
            return blBanner.SaveBanner(banner);
        }

        public List<int> SaveListBanner(List<BEBanner> listBanner)
        {
            var blBanner = new BLBanner();
            return blBanner.SaveListBanner(listBanner);
        }

        public void SaveGrupoBanner(BEGrupoBanner grupoBanner)
        {
            var blBanner = new BLBanner();
            blBanner.SaveGrupoBanner(grupoBanner);
        }

        public void DeleteBanner(int campaniaID, int bannerID)
        {
            var blBanner = new BLBanner();
            blBanner.DeleteBanner(campaniaID, bannerID);
        }

        public IList<BEBannerInfo> SelectBannerByConsultora(int paisID, int campaniaID, string codigoConsultora, bool consultoraNueva)
        {
            var blBanner = new BLBanner();
            return blBanner.SelectBannerByConsultora(paisID, campaniaID, codigoConsultora, consultoraNueva);
        }

        public int UpdOrdenNumberBanner(int paisID, List<BEBannerOrden> lstBanners)
        {
            var blBanner = new BLBanner();
            return blBanner.UpdOrdenNumberBanner(paisID, lstBanners);
        }

        public int GetPaisBannerMarquesina(string CampaniaID, int IdBanner)
        {
            var blBanner = new BLBanner();
            var result = blBanner.GetPaisBannerMarquesina(CampaniaID, IdBanner);
            return result;
        }

        public IList<BEParametro> GetParametrosBanners()
        {
            var blBanner = new BLBanner();
            return blBanner.GetParametrosBanners();
        }

        public IList<BEBannerInfo> SelectBannerByConsultoraBienvenida(int paisID, int campaniaID, string codigoConsultora, bool consultoraNueva)
        {
            var blBanner = new BLBanner();
            return blBanner.SelectBannerByConsultoraBienvenida(paisID, campaniaID, codigoConsultora, consultoraNueva);
        }

        #endregion

        #region Gestion Formularios Informativos
        public void InsertFormularioDato(BEFormularioDato formularioDato)
        {
            var blFormularioDato = new BLFormularioDato();
            blFormularioDato.Insert(formularioDato);
        }

        public void UpdateFormularioDato(BEFormularioDato formularioDato)
        {
            var blFormularioDato = new BLFormularioDato();
            blFormularioDato.Update(formularioDato);
        }

        public void DeleteFormularioDato(int paisID, ETipoFormulario tipoFormulario, int formularioDatoID)
        {
            var blFormularioDato = new BLFormularioDato();
            blFormularioDato.Delete(paisID, tipoFormulario, formularioDatoID);
        }

        public IList<BEFormularioDato> SelectFormularioDatoByPais(int paisID, ETipoFormulario tipoFormulario)
        {
            var blFormularioDato = new BLFormularioDato();
            return blFormularioDato.Select(paisID, tipoFormulario);
        }

        public BEFormularioDato SelectFormularioDato(ETipoFormulario tipoFormulario)
        {
            var blFormularioDato = new BLFormularioDato();
            return blFormularioDato.Select(tipoFormulario);
        }

        #endregion

        #region Gestion Resumen Campania

        public IList<BEResumenCampania> GetPedidoWebAcumulado(int paisID, int CampaniaID, int ConsultoraID)
        {
            var blResumenCampania = new BLResumenCampania();
            return blResumenCampania.GetPedidoWebAcumulado(paisID, CampaniaID, ConsultoraID);
        }

        public decimal GetMontoDeuda(int paisID, int campaniaID, long consultoraID, string codigoUsuario, bool revisarHana)
        {
            var blResumenCampania = new BLResumenCampania();
            return blResumenCampania.GetMontoDeuda(paisID, campaniaID, Convert.ToInt32(consultoraID), codigoUsuario, revisarHana);
        }

        public IList<BEResumenCampania> GetSaldoPendiente(int paisID, int CampaniaID, int ConsultoraID)
        {
            var blResumenCampania = new BLResumenCampania();
            return blResumenCampania.GetSaldoPendiente(paisID, CampaniaID, ConsultoraID);
        }

        public IList<BEResumenCampania> GetProductosSolicitados(int paisID, int CampaniaID, int ConsultoraID)
        {
            var blResumenCampania = new BLResumenCampania();
            return blResumenCampania.GetProductosSolicitados(paisID, CampaniaID, ConsultoraID);
        }

        public IList<BEResumenCampania> GetValorAPagar(int paisID, int CampaniaID, int ConsultoraID)
        {
            var blResumenCampania = new BLResumenCampania();
            return blResumenCampania.GetValorAPagar(paisID, CampaniaID, ConsultoraID);
        }

        public IList<BEResumenCampania> GetFlexipago(int paisID, int CampaniaID, int ConsultoraID)
        {
            var blResumenCampania = new BLResumenCampania();
            //solucion a error en producción :Parameters to 'GetFlexipago' have the same names but not the same order as the method arguments.
            return blResumenCampania.GetFlexipago(paisID, ConsultoraID , CampaniaID);
        }

        public IList<BEResumenCampania> GetDeudaTotal(int paisID, int ConsultoraID)
        {
            var blResumenCampania = new BLResumenCampania();
            return blResumenCampania.GetDeudaTotal(paisID, ConsultoraID);
        }

        #endregion

        #region Gestion ContenidoDato

        public IList<BEContenidoDato> SelectContenidoDato(int paisID, int campaniaID)
        {
            var blContenidoDato = new BLContenidoDato();
            return blContenidoDato.SelectContenidoDato(paisID, campaniaID);
        }

        public void InsContenidoDato(BEContenidoDato contenidodato)
        {
            var blContenidoDato = new BLContenidoDato();
            blContenidoDato.InsContenidoDato(contenidodato);
        }

        public void UpdContenidoDato(BEContenidoDato contenidodato)
        {
            var blContenidoDato = new BLContenidoDato();
            blContenidoDato.UpdContenidoDato(contenidodato);
        }

        #endregion

        #region TipoLink

        public IList<BETipoLink> GetLinksPorPais(int paisID)
        {
            var blContenidoDato = new BLContenidoDato();
            return blContenidoDato.GetLinksPorPais(paisID);
        }

        #endregion

        #region Configuración PayPal

        public IList<BEPayPalConfiguracion> GetConfiguracionPayPal(int paisID)
        {
            var blPayPalConfiguracion = new BLPayPalConfiguracion();
            return blPayPalConfiguracion.GetConfiguracionPayPal(paisID);
        }

        public int InsDatosPago(int paisID, string chrCodigoConsultora, string chrCodigoTerritorio, decimal montoAbono, string chrNumeroTarjeta, DateTime datFechaTransaccion, Int16 estado)
        {
            var blPayPalConfiguracion = new BLPayPalConfiguracion();
            return blPayPalConfiguracion.InsDatosPago(paisID, chrCodigoConsultora, chrCodigoTerritorio, montoAbono, chrNumeroTarjeta, datFechaTransaccion, estado);
        }

        public int InsAbonoPago(int paisID, string chrCodigoPais, string chrCodigoConsultora, decimal mnyMontoAbono, string chrCodigoAutorizacionBanco, string chrCodigoTransaccion, int chrResultado)
        {
            var blPayPalConfiguracion = new BLPayPalConfiguracion();
            return blPayPalConfiguracion.InsAbonoPago(paisID, chrCodigoPais, chrCodigoConsultora, mnyMontoAbono, chrCodigoAutorizacionBanco, chrCodigoTransaccion, chrResultado);
        }

        public bool ExistePagoPendiente(int paisID, decimal mnyMontoAbono, string chrNumeroTarjeta, DateTime datFecha)
        {
            var blPayPalConfiguracion = new BLPayPalConfiguracion();
            return blPayPalConfiguracion.ExistePagoPendiente(paisID, mnyMontoAbono, chrNumeroTarjeta, datFecha);
        }

        public IList<BEPayPalConfiguracion> GetReporteAbonos(int paisID, string chrCodigoPais, string chrCodigoConsultora, int intDia, int intMes, int intAnho, string chrRETCodigoTransaccion)
        {
            var blPayPalConfiguracion = new BLPayPalConfiguracion();
            return blPayPalConfiguracion.GetReporteAbonos(paisID, chrCodigoPais, chrCodigoConsultora, intDia, intMes, intAnho, chrRETCodigoTransaccion);
        }

        #endregion        

        #region RevistaGana
        public Int32 CrearContenidoRevista(int paisId, string nroCampania, string rutaImagenPortada)
        {
            using (var blContenidoRevista = new BLContenidoRevista(paisId))
            {
                return blContenidoRevista.Insertar(nroCampania, rutaImagenPortada);
            }
        }

        public Int32 ActualizarContenidoRevista(int paisId, int id, string rutaImagenPortada)
        {
            using (var blContenidoRevista = new BLContenidoRevista(paisId))
            {
                return blContenidoRevista.ActualizarById(id, rutaImagenPortada);
            }
        }

        public Int32 EliminarContenidoRevista(int paisId, int id)
        {
            using (var blContenidoRevista = new BLContenidoRevista(paisId))
            {
                return blContenidoRevista.EliminarById(id);
            }
        }

        public BEContenidoRevista ObtenerContenidoRevistaCampania(int paisId, string campania)
        {
            using (var blContenidoRevista = new BLContenidoRevista(paisId))
            {
                return blContenidoRevista.ObtenerByCampania(campania);
            }
        }

        public IList<BEContenidoRevista> ContenidoRevistaPaginado(int paisId, string campania, int pageSize, int pageNum, out int totalRows)
        {
            using (var blContenidoRevista = new BLContenidoRevista(paisId))
            {
                return blContenidoRevista.ObtenerByCampania(campania, pageSize, pageNum, out totalRows);
            }
        }

        public BEContenidoRevista ObtenerContenidoRevistaId(int paisId, int id)
        {
            using (var blContenidoRevista = new BLContenidoRevista(paisId))
            {
                return blContenidoRevista.ObtenerById(id);
            }
        }
        #endregion

        #region Belcorp Reponde

        public IList<BEBelcorpResponde> GetBelcorpResponde(int paisID)
        {
            var blBelcorpResponde = new BLBelcorpResponde();
            return blBelcorpResponde.GetBelcorpResponde(paisID);
        }

        public IList<BEBelcorpResponde> GetBelcorpRespondeAdministrador(int paisID)
        {
            var blBelcorpResponde = new BLBelcorpResponde();
            return blBelcorpResponde.GetBelcorpRespondeAdministrador(paisID);
        }

        public void InsBelcorpResponde(BEBelcorpResponde BEBelcorpResponde)
        {
            var blBelcorpResponde = new BLBelcorpResponde();
            blBelcorpResponde.InsBelcorpResponde(BEBelcorpResponde);
        }

        public void DeleteBelcorpRespondeCache(int paisID)
        {
            var blBelcorpResponde = new BLBelcorpResponde();
            blBelcorpResponde.DeleteBelcorpRespondeCache(paisID);
        }

        #endregion

        public string[] DescargaPaypal(int paisID, string codigoUsuario, DateTime fechaEjecucion)
        {
            try
            {
                var bLPayPalConfiguracion = new BLPayPalConfiguracion();
                return bLPayPalConfiguracion.DescargaPaypal(paisID, codigoUsuario, fechaEjecucion);
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

        public BEBannerSegmentoZona GetBannerSegmentoSeccion(int CampaniaId, int BannerId, int PaisId)
        {
            var blBanner = new BLBanner();
            return blBanner.GetBannerSegmentoSeccion(CampaniaId, BannerId, PaisId);
        }

        public List<BEBannerSegmentoZona> GetBannerPaisesAsignados(int CampaniaId, int BannerId)
        {
            var blBanner = new BLBanner();
            return blBanner.GetBannerPaisesAsignados(CampaniaId, BannerId);
        }

        public void UpdBannerPaisSegmentoZona(BEBannerSegmentoZona segmentoZona)
        {
            var blBanner = new BLBanner();
            blBanner.UpdBannerPaisSegmentoZona(segmentoZona);
        }

        public void DeleteCacheBanner(int CampaniaID)
        {
            var blBanner = new BLBanner();
            blBanner.DeleteCacheBanner(CampaniaID);
        }

        public int ActualizarEstadoPaqueteDocumentario(int paisID, string codigo, int campania)
        {
            var blPaquete = new BLPaqueteDocumentario();
            return blPaquete.ActualizarEstadoPaqueteDocumentario(paisID, codigo, campania);
        }

        public bool ValidarInvitacionPaqueteDocumentario(int paisID, string codigo)
        {
            var blPaquete = new BLPaqueteDocumentario();
            return blPaquete.ValidarInvitacionPaqueteDocumentario(paisID, codigo);
        }

        public string[] GetPaqueteDocumentario(int paisID)
        {
            var blPaquete = new BLPaqueteDocumentario();
            string[] file = blPaquete.GenerarPaqueteDocumentario(paisID);
            return file;
        }

        #region navidad 

        public int InsertarNavidadConsultora(BENavidadConsultora entidad)
        {
            var aviso = _BLNavidadConsultora.InsertarNavidadConsultora(entidad);
            return aviso;
        }

        public void EditarNavidadConsultora(BENavidadConsultora entidad)
        {
            _BLNavidadConsultora.EditarNavidadConsultora(entidad);
        }

        public void EliminarNavidadConsultora(BENavidadConsultora entidad)
        {
            _BLNavidadConsultora.EliminarNavidadConsultora(entidad);
        }

        public IList<BENavidadConsultora> BuscarNavidadConsultora(BENavidadConsultora entidad)
        {
            return _BLNavidadConsultora.BuscarNavidadConsultora(entidad);
        }

        public IList<BENavidadConsultora> SeleccionarNavidadConsultora(BENavidadConsultora entidad)
        {
            return _BLNavidadConsultora.SeleccionarNavidadConsultora(entidad);
        }
        #endregion

        public IList<string> GetLiderCampaniaActual(int paisID, long ConsultoraID, string CodigoPais)
        {
            var blConsultoraLider = new BLConsultoraLider();
            return blConsultoraLider.GetLiderCampaniaActual(paisID, ConsultoraID, CodigoPais);
        }

        public IList<string> GetProyectaNivel(int paisID, long ConsultoraID)
        {
            var blConsultoraLider = new BLConsultoraLider();
            return blConsultoraLider.GetProyectaNivel(paisID, ConsultoraID);
        }

        public DataSet ObtenerParametrosSuperateLider(int paisID, long ConsultoraID, int CampaniaVenta)
        {
            var blConsultoraLider = new BLConsultoraLider();
            return blConsultoraLider.ObtenerParametrosSuperateLider(paisID, ConsultoraID, CampaniaVenta);
        }

        public IList<BEItemCarruselInicio> GetItemCarruselInicio(int paisID)
        {
            return _BLItemCarruselInicio.GetItemCarruselInicio(paisID);
        }

        #region Emailing para SE
        public List<BEPlantillasMailing> ObtenerPlantillasEmailingSE()
        {
            return _BLMailing.ObtenerPlantillasEmailingSE();
        }

        public List<BEMailing> CargarPaisesPlantillaEmailing(int plantillaID)
        {
            return _BLMailing.CargarPaisesPlantillaEmailing(plantillaID);
        }

        public void RegistrarContenidoEmailingSE(BEMailing BEMailing)
        {
            _BLMailing.RegistrarContenidoEmailingSE(BEMailing);
        }

        public bool AgregarPaisPlantillaEmailingSE(int PaisID, int PlantillaID, string CodigoUsuario)
        {
            return _BLMailing.AgregarPaisPlantillaEmailingSE(PaisID, PlantillaID, CodigoUsuario);
        }

        public bool QuitarPaisPlantillaEmailingSE(int PaisID, int PlantillaID)
        {
            return _BLMailing.QuitarPaisPlantillaEmailingSE(PaisID, PlantillaID);
        }

        public bool CopiarPaisPlantillaEmailingSE(int PaisID, int PlantillaID, int PaisDestinoID, string CodigoUsuario)
        {
            return _BLMailing.CopiarPaisPlantillaEmailingSE(PaisID, PlantillaID, PaisDestinoID, CodigoUsuario);
        }

        public List<BEConsultoraMailing> CondicionesConsultoraSE(int PaisID)
        {
            return _BLMailing.CondicionesConsultoraSE(PaisID);
        }

        public void RegistrarLogEnvioAutomatico(int PaisID, BEConsultoraMailing BEConsultora)
        {
            _BLMailing.RegistrarLogEnvioAutomatico(PaisID, BEConsultora);
        }

        public DateTime GetPaisZonaHoraria(int PaisID)
        {
            return _BLMailing.GetPaisZonaHoraria(PaisID);
        }

        public List<BEPlantillasMailing> GetPlantillasPais(int PaisID)
        {
            return _BLMailing.GetPlantillasPais(PaisID);
        }

        public string ObtenerCorreoEmisor(int PaisID)
        {
            return _BLMailing.ObtenerCorreoEmisor(PaisID);
        }
        #endregion

        #region Miembros de IContenidoService

        #endregion

    }
}