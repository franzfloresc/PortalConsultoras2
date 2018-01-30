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
using Portal.Consultoras.Common;

namespace Portal.Consultoras.Service
{
    public class ContenidoService : IContenidoService
    {
        private BLNavidadConsultora _BLNavidadConsultora;
        private BLItemCarruselInicio _BLItemCarruselInicio;

        private BLMailing _BLMailing;
		public ContenidoService()
        {
            _BLNavidadConsultora = new BLNavidadConsultora();
            _BLItemCarruselInicio = new BLItemCarruselInicio();
            _BLMailing = new BLMailing();
        }

        #region Gestion Banners

        public IList<BEBanner> SelectBanner(int campaniaID)
        {
            var BLBanner = new BLBanner();
            return BLBanner.SelectBanner(campaniaID);
        }

        public IList<BEGrupoBanner> SelectGrupoBanner(int campaniaID)
        {
            var BLBanner = new BLBanner();
            return BLBanner.SelectGrupoBanner(campaniaID);
        }

        public int SaveBanner(BEBanner banner)
        {
            var BLBanner = new BLBanner();
            return BLBanner.SaveBanner(banner);
        }

        public List<int> SaveListBanner(List<BEBanner> listBanner)
        {
            var BLBanner = new BLBanner();
            return BLBanner.SaveListBanner(listBanner);
        }

        public void SaveGrupoBanner(BEGrupoBanner grupoBanner)
        {
            var BLBanner = new BLBanner();
            BLBanner.SaveGrupoBanner(grupoBanner);
        }

        public void DeleteBanner(int campaniaID, int bannerID)
        {
            var BLBanner = new BLBanner();
            BLBanner.DeleteBanner(campaniaID, bannerID);
        }

        public IList<BEBannerInfo> SelectBannerByConsultora(int paisID, int campaniaID, string codigoConsultora, bool consultoraNueva)
        {
            var BLBanner = new BLBanner();
            return BLBanner.SelectBannerByConsultora(paisID, campaniaID, codigoConsultora, consultoraNueva);
        }

        public int UpdOrdenNumberBanner(int paisID, List<BEBannerOrden> lstBanners)
        {
            var BLBanner = new BLBanner();
            return BLBanner.UpdOrdenNumberBanner(paisID, lstBanners);
        }

		public int GetPaisBannerMarquesina(string CampaniaID, int IdBanner)
        {
            int result;
            var BLBanner = new BLBanner();
            result = BLBanner.GetPaisBannerMarquesina(CampaniaID, IdBanner);
            return result;
        }
        public IList<BEParametro> GetParametrosBanners()
        {
            var BLBanner = new BLBanner();
            return BLBanner.GetParametrosBanners();
        }

        public IList<BEBannerInfo> SelectBannerByConsultoraBienvenida(int paisID, int campaniaID, string codigoConsultora, bool consultoraNueva)
        {
            var BLBanner = new BLBanner();
            return BLBanner.SelectBannerByConsultoraBienvenida(paisID, campaniaID, codigoConsultora, consultoraNueva);
        }

        #endregion

        #region Gestion Formularios Informativos
        public void InsertFormularioDato(BEFormularioDato formularioDato)
        {
            var BLFormularioDato = new BLFormularioDato();
            BLFormularioDato.Insert(formularioDato);
        }

        public void UpdateFormularioDato(BEFormularioDato formularioDato)
        {
            var BLFormularioDato = new BLFormularioDato();
            BLFormularioDato.Update(formularioDato);
        }

        public void DeleteFormularioDato(int paisID, ETipoFormulario tipoFormulario, int formularioDatoID)
        {
            var BLFormularioDato = new BLFormularioDato();
            BLFormularioDato.Delete(paisID, tipoFormulario, formularioDatoID);
        }

        public IList<BEFormularioDato> SelectFormularioDatoByPais(int paisID, ETipoFormulario tipoFormulario)
        {
            var BLFormularioDato = new BLFormularioDato();
            return BLFormularioDato.Select(paisID, tipoFormulario);
        }

        public BEFormularioDato SelectFormularioDato(ETipoFormulario tipoFormulario)
        {
            var BLFormularioDato = new BLFormularioDato();
            return BLFormularioDato.Select(tipoFormulario);
        }

        #endregion

        #region Gestion Resumen Campania

        public IList<BEResumenCampania> GetPedidoWebAcumulado(int paisID, int CampaniaID, int ConsultoraID)
        {
            var BLResumenCampania = new BLResumenCampania();
            return BLResumenCampania.GetPedidoWebAcumulado(paisID, CampaniaID, ConsultoraID);
        }

        public decimal GetMontoDeuda(int paisID, int campaniaID, long consultoraID, string codigoUsuario, bool revisarHana)
        {
            var BLResumenCampania = new BLResumenCampania();
            return BLResumenCampania.GetMontoDeuda(paisID, campaniaID, Convert.ToInt32(consultoraID), codigoUsuario, revisarHana);
        }

        public IList<BEResumenCampania> GetSaldoPendiente(int paisID, int CampaniaID, int ConsultoraID)
        {
            var BLResumenCampania = new BLResumenCampania();
            return BLResumenCampania.GetSaldoPendiente(paisID, CampaniaID, ConsultoraID);
        }

        public IList<BEResumenCampania> GetProductosSolicitados(int paisID, int CampaniaID, int ConsultoraID)
        {
            var BLResumenCampania = new BLResumenCampania();
            return BLResumenCampania.GetProductosSolicitados(paisID, CampaniaID, ConsultoraID);
        }

        public IList<BEResumenCampania> GetValorAPagar(int paisID, int CampaniaID, int ConsultoraID)
        {
            var BLResumenCampania = new BLResumenCampania();
            return BLResumenCampania.GetValorAPagar(paisID, CampaniaID, ConsultoraID);
        }

        public IList<BEResumenCampania> GetFlexipago(int paisID, int CampaniaID, int ConsultoraID)
        {
            var BLResumenCampania = new BLResumenCampania();
            return BLResumenCampania.GetFlexipago(paisID, CampaniaID, ConsultoraID);
        }

        public IList<BEResumenCampania> GetDeudaTotal(int paisID, int ConsultoraID)
        {
            var BLResumenCampania = new BLResumenCampania();
            return BLResumenCampania.GetDeudaTotal(paisID, ConsultoraID);
        }      

        #endregion

        #region Gestion ContenidoDato

        public IList<BEContenidoDato> SelectContenidoDato(int paisID, int campaniaID)
        {
            var BLContenidoDato = new BLContenidoDato();
            return BLContenidoDato.SelectContenidoDato(paisID, campaniaID);
        }

        public void InsContenidoDato(BEContenidoDato contenidodato)
        {
            var BLContenidoDato = new BLContenidoDato();
            BLContenidoDato.InsContenidoDato(contenidodato);
        }

        public void UpdContenidoDato(BEContenidoDato contenidodato)
        {
            var BLContenidoDato = new BLContenidoDato();
            BLContenidoDato.UpdContenidoDato(contenidodato);
        }

        #endregion

        #region TipoLink

        public IList<BETipoLink> GetLinksPorPais(int paisID)
        {
            var BLContenidoDato = new BLContenidoDato();
            return BLContenidoDato.GetLinksPorPais(paisID);
        }

        #endregion

        #region Configuración PayPal

        public IList<BEPayPalConfiguracion> GetConfiguracionPayPal(int paisID)
        {
            var BLPayPalConfiguracion = new BLPayPalConfiguracion();
            return BLPayPalConfiguracion.GetConfiguracionPayPal(paisID);
        }

        public int InsDatosPago(int paisID, string chrCodigoConsultora, string chrCodigoTerritorio, decimal montoAbono, string chrNumeroTarjeta, DateTime datFechaTransaccion, Int16 estado)
        {
            var BLPayPalConfiguracion = new BLPayPalConfiguracion();
            return BLPayPalConfiguracion.InsDatosPago(paisID, chrCodigoConsultora, chrCodigoTerritorio, montoAbono, chrNumeroTarjeta, datFechaTransaccion, estado);
        }

        public int InsAbonoPago(int paisID, string chrCodigoPais, string chrCodigoConsultora, decimal mnyMontoAbono, string chrCodigoAutorizacionBanco, string chrCodigoTransaccion, int chrResultado)
        {
            var BLPayPalConfiguracion = new BLPayPalConfiguracion();
            return BLPayPalConfiguracion.InsAbonoPago(paisID, chrCodigoPais, chrCodigoConsultora, mnyMontoAbono, chrCodigoAutorizacionBanco, chrCodigoTransaccion, chrResultado);
        }

        public bool ExistePagoPendiente(int paisID, decimal mnyMontoAbono, string chrNumeroTarjeta, DateTime datFecha)
        {
            var BLPayPalConfiguracion = new BLPayPalConfiguracion();
            return BLPayPalConfiguracion.ExistePagoPendiente(paisID, mnyMontoAbono, chrNumeroTarjeta, datFecha);
        }

        public IList<BEPayPalConfiguracion> GetReporteAbonos(int paisID, string chrCodigoPais, string chrCodigoConsultora, int intDia, int intMes, int intAnho, string chrRETCodigoTransaccion)
        {
            var BLPayPalConfiguracion = new BLPayPalConfiguracion();
            return BLPayPalConfiguracion.GetReporteAbonos(paisID, chrCodigoPais, chrCodigoConsultora, intDia, intMes, intAnho, chrRETCodigoTransaccion);
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
            var BLBelcorpResponde = new BLBelcorpResponde();
            return BLBelcorpResponde.GetBelcorpResponde(paisID);
        }

        public IList<BEBelcorpResponde> GetBelcorpRespondeAdministrador(int paisID)
        {
            var BLBelcorpResponde = new BLBelcorpResponde();
            return BLBelcorpResponde.GetBelcorpRespondeAdministrador(paisID);
        }

        public void InsBelcorpResponde(BEBelcorpResponde BEBelcorpResponde)
        {
            var BLBelcorpResponde = new BLBelcorpResponde();
            BLBelcorpResponde.InsBelcorpResponde(BEBelcorpResponde);
        }
        public void DeleteBelcorpRespondeCache(int paisID)
        {
            var BLBelcorpResponde = new BLBelcorpResponde();
            BLBelcorpResponde.DeleteBelcorpRespondeCache(paisID);
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
            var BLBanner = new BLBanner();
            return BLBanner.GetBannerSegmentoSeccion(CampaniaId, BannerId, PaisId);
        }

        public List<BEBannerSegmentoZona> GetBannerPaisesAsignados(int CampaniaId, int BannerId)
        {
            var BLBanner = new BLBanner();
            return BLBanner.GetBannerPaisesAsignados(CampaniaId, BannerId);
        }

        public void UpdBannerPaisSegmentoZona(int CampaniaId, int BannerId, int PaisId, int Segmento, string ConfiguracionZona, string SegmentoInterno)
        {
            var BLBanner = new BLBanner();
            BLBanner.UpdBannerPaisSegmentoZona(CampaniaId, BannerId, PaisId, Segmento, ConfiguracionZona, SegmentoInterno);
        }

        public void DeleteCacheBanner(int CampaniaID)
        {
            var BLBanner = new BLBanner();
            BLBanner.DeleteCacheBanner(CampaniaID);
        }
    
		public int ActualizarEstadoPaqueteDocumentario(int paisID,string codigo, int campania)
        {
            var blPaquete = new BLPaqueteDocumentario();
            return blPaquete.ActualizarEstadoPaqueteDocumentario(paisID,codigo, campania);
        }

        public bool ValidarInvitacionPaqueteDocumentario(int paisID,string codigo)
        {
            var blPaquete = new BLPaqueteDocumentario();
            return blPaquete.ValidarInvitacionPaqueteDocumentario(paisID,codigo);
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
            var BLConsultoraLider = new BLConsultoraLider();
            return BLConsultoraLider.GetLiderCampaniaActual(paisID, ConsultoraID, CodigoPais);
        }
	
        public IList<string> GetProyectaNivel(int paisID, long ConsultoraID)
        {
            var BLConsultoraLider = new BLConsultoraLider();
            return BLConsultoraLider.GetProyectaNivel(paisID, ConsultoraID);
        }

        public DataSet ObtenerParametrosSuperateLider(int paisID, long ConsultoraID, int CampaniaVenta)
        {
            var BLConsultoraLider = new BLConsultoraLider();
            return BLConsultoraLider.ObtenerParametrosSuperateLider(paisID, ConsultoraID, CampaniaVenta);
        }

        public IList<BEItemCarruselInicio> GetItemCarruselInicio(int paisID)
        {
            return _BLItemCarruselInicio.GetItemCarruselInicio(paisID);
        }

        #region Emailing para SE
        public List<BEPlantillasMailing> ObtenerPlantillasEmailingSE()
        {
           return  _BLMailing.ObtenerPlantillasEmailingSE();
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
