using Portal.Consultoras.Entities;
using System;
using System.Collections.Generic;
using System.Data;
using System.ServiceModel;

namespace Portal.Consultoras.ServiceContracts
{
    [ServiceContract]
    public interface IContenidoService
    {
        #region Gestion Banners
        [OperationContract]
        IList<BEBanner> SelectBanner(int campaniaID);

        [OperationContract]
        IList<BEBannerInfo> SelectBannerByConsultora(int paisID, int campaniaID, string codigoConsultora, bool consultoraNueva);

        [OperationContract]
        int UpdOrdenNumberBanner(int paisID, List<BEBannerOrden> lstBanners);

        [OperationContract]
        IList<BEGrupoBanner> SelectGrupoBanner(int campaniaID);

        [OperationContract]
        int SaveBanner(BEBanner banner);
        [OperationContract]
        List<int> SaveListBanner(List<BEBanner> listBanner);
        [OperationContract]
        int GetPaisBannerMarquesina(string CampaniaID, int IdBanner);

        [OperationContract]
        void SaveGrupoBanner(BEGrupoBanner grupoBanner);

        [OperationContract]
        void DeleteBanner(int campaniaID, int bannerID);

        [OperationContract]
        IList<BEParametro> GetParametrosBanners();

        [OperationContract]
        IList<BEBannerInfo> SelectBannerByConsultoraBienvenida(int paisID, int campaniaID, string codigoConsultora, bool consultoraNueva);

        #endregion

        #region Gestion Formularios Informativos

        [OperationContract]
        void InsertFormularioDato(BEFormularioDato formularioDato);

        [OperationContract]
        void UpdateFormularioDato(BEFormularioDato formularioDato);

        [OperationContract]
        void DeleteFormularioDato(int paisID, ETipoFormulario tipoFormulario, int formularioDatoID);

        [OperationContract]
        IList<BEFormularioDato> SelectFormularioDatoByPais(int paisID, ETipoFormulario tipoFormulario);

        [OperationContract]
        BEFormularioDato SelectFormularioDato(ETipoFormulario tipoFormulario);
        #endregion

        #region Gestion Resumen Campania

        [OperationContract]
        IList<BEResumenCampania> GetPedidoWebAcumulado(int paisID, int CampaniaID, int ConsultoraID);

        [OperationContract]
        decimal GetMontoDeuda(int paisID, int campaniaID, long consultoraID, string codigoUsuario, bool revisarHana);

        [OperationContract]
        IList<BEResumenCampania> GetSaldoPendiente(int paisID, int CampaniaID, int ConsultoraID);

        [OperationContract]
        IList<BEResumenCampania> GetProductosSolicitados(int paisID, int CampaniaID, int ConsultoraID);

        [OperationContract]
        IList<BEResumenCampania> GetValorAPagar(int paisID, int CampaniaID, int ConsultoraID);

        [OperationContract]
        IList<BEResumenCampania> GetFlexipago(int paisID, int CampaniaID, int ConsultoraID);

        [OperationContract]
        IList<BEResumenCampania> GetDeudaTotal(int paisID, int ConsultoraID);

        #endregion

        #region Gestion ContenidoDato

        [OperationContract]
        void InsContenidoDato(BEContenidoDato contenidodato);

        [OperationContract]
        void UpdContenidoDato(BEContenidoDato contenidodato);

        [OperationContract]
        IList<BEContenidoDato> SelectContenidoDato(int paisID, int campaniaID);

        #endregion

        #region TipoLink

        [OperationContract]
        IList<BETipoLink> GetLinksPorPais(int paisID);

        #endregion

        [OperationContract]
        IList<BEPayPalConfiguracion> GetConfiguracionPayPal(int paisID);

        [OperationContract]
        int InsDatosPago(int paisID, string chrCodigoConsultora, string chrCodigoTerritorio, decimal montoAbono, string chrNumeroTarjeta, DateTime datFechaTransaccion, Int16 estado);

        [OperationContract]
        int InsAbonoPago(int paisID, string chrCodigoPais, string chrCodigoConsultora, decimal mnyMontoAbono, string chrCodigoAutorizacionBanco, string chrCodigoTransaccion, int chrResultado);

        [OperationContract]
        bool ExistePagoPendiente(int paisID, decimal mnyMontoAbono, string chrNumeroTarjeta, DateTime datFecha);

        [OperationContract]
        IList<BEPayPalConfiguracion> GetReporteAbonos(int paisID, string chrCodigoPais, string chrCodigoConsultora, int intDia, int intMes, int intAnho, string chrRETCodigoTransaccion);

        [OperationContract]
        string[] DescargaPaypal(int paisID, string codigoUsuario, DateTime fechaEjecucion);

        #region RevistaGana
        /// <summary>
        /// Crear un nuevo registro contenido revista
        /// </summary>
        /// <param name="paisId">Código pais</param>
        /// <param name="nroCampania">Numero campaña</param>
        /// <param name="rutaImagenPortada">Nombre de la imagen portada a guardar</param>
        /// <returns>Indentificar nuevo item creado</returns>
        [OperationContract]
        Int32 CrearContenidoRevista(int paisId, string nroCampania, string rutaImagenPortada);
        /// <summary>
        /// Actualizar un item contenido revista
        /// </summary>
        /// <param name="paisId">Código pais</param>
        /// <param name="id">Identificador item contenido revista</param>
        /// <param name="rutaImagenPortada">Nombre de la imagen portada a guardar</param>
        /// <returns>Cantidad registros afectados</returns>
        [OperationContract]
        Int32 ActualizarContenidoRevista(int paisId, int id, string rutaImagenPortada);
        /// <summary>
        /// Elimina un item contenido revista
        /// </summary>
        /// <param name="paisId">Código pais</param>
        /// <param name="id">Identificador item contenido revista</param>
        /// <returns>Cantidad de registros afectados</returns>
        [OperationContract]
        Int32 EliminarContenidoRevista(int paisId, int id);
        /// <summary>
        /// Obtiene un listado de contenido de revista
        /// </summary>
        /// <param name="paisId">Código pais</param>
        /// <param name="campania">Campaña</param>
        /// <returns>Listado contenido revista</returns>
        [OperationContract]
        BEContenidoRevista ObtenerContenidoRevistaCampania(int paisId, string campania);
        /// <summary>
        /// Obtiene un item contenido revista
        /// </summary>
        /// <param name="paisId">Código pais</param>
        /// <param name="id">Identificador registro</param>
        /// <returns>Contenido revista</returns>
        [OperationContract]
        BEContenidoRevista ObtenerContenidoRevistaId(int paisId, int id);
        /// <summary>
        /// Obtiene un listado de contenido de revista
        /// </summary>
        /// <param name="paisId">Código pais</param>
        /// <param name="campania">Campaña</param>
        /// <param name="pageSize">Campaña</param>
        /// <param name="pageNum">Campaña</param>
        /// <param name="totalRows">Campaña</param>
        /// <returns>Listado contenido revista</returns>
        [OperationContract]
        IList<BEContenidoRevista> ContenidoRevistaPaginado(int paisId, string campania, int pageSize, int pageNum, out int totalRows);
        #endregion

        #region Belcorp Responde

        [OperationContract]
        IList<BEBelcorpResponde> GetBelcorpResponde(int paisID);

        [OperationContract]
        IList<BEBelcorpResponde> GetBelcorpRespondeAdministrador(int paisID);

        [OperationContract]
        void InsBelcorpResponde(BEBelcorpResponde BEBelcorpResponde);
        [OperationContract]
        void DeleteBelcorpRespondeCache(int paisID);


        #endregion

        [OperationContract]
        BEBannerSegmentoZona GetBannerSegmentoSeccion(int CampaniaId, int BannerId, int PaisId);

        [OperationContract]
        List<BEBannerSegmentoZona> GetBannerPaisesAsignados(int CampaniaId, int BannerId);

        [OperationContract]
        void UpdBannerPaisSegmentoZona(BEBannerSegmentoZona segmentoZona);

        [OperationContract]
        void DeleteCacheBanner(int CampaniaID);

        [OperationContract]
        int ActualizarEstadoPaqueteDocumentario(int paisID, string codigo, int campania);

        [OperationContract]
        bool ValidarInvitacionPaqueteDocumentario(int paisID, string codigo);

        [OperationContract]
        string[] GetPaqueteDocumentario(int paisID);

        #region Navidad
        [OperationContract]
        int InsertarNavidadConsultora(BENavidadConsultora entidad);

        [OperationContract]
        void EditarNavidadConsultora(BENavidadConsultora entidad);

        [OperationContract]
        void EliminarNavidadConsultora(BENavidadConsultora entidad);

        [OperationContract]
        IList<BENavidadConsultora> BuscarNavidadConsultora(BENavidadConsultora entidad);

        [OperationContract]
        IList<BENavidadConsultora> SeleccionarNavidadConsultora(BENavidadConsultora entidad);
        #endregion

        [OperationContract]
        IList<string> GetLiderCampaniaActual(int paisID, long ConsultoraID, string CodigoPais);

        [OperationContract]
        IList<string> GetProyectaNivel(int paisID, long ConsultoraID);
        [OperationContract]
        DataSet ObtenerParametrosSuperateLider(int paisID, long ConsultoraID, int CampaniaVenta);

        [OperationContract]
        IList<BEItemCarruselInicio> GetItemCarruselInicio(int paisID);

        #region Emailing para SE
        [OperationContract]
        List<BEPlantillasMailing> ObtenerPlantillasEmailingSE();

        [OperationContract]
        List<BEMailing> CargarPaisesPlantillaEmailing(int plantillaID);

        [OperationContract]
        void RegistrarContenidoEmailingSE(BEMailing BEMailing);

        [OperationContract]
        bool AgregarPaisPlantillaEmailingSE(int PaisID, int PlantillaID, string CodigoUsuario);

        [OperationContract]
        bool QuitarPaisPlantillaEmailingSE(int PaisID, int PlantillaID);

        [OperationContract]
        bool CopiarPaisPlantillaEmailingSE(int PaisID, int PlantillaID, int PaisDestinoID, string CodigoUsuario);

        [OperationContract]
        List<BEConsultoraMailing> CondicionesConsultoraSE(int PaisID);

        [OperationContract]
        void RegistrarLogEnvioAutomatico(int PaisID, BEConsultoraMailing BEConsultora);

        [OperationContract]
        DateTime GetPaisZonaHoraria(int PaisID);

        [OperationContract]
        List<BEPlantillasMailing> GetPlantillasPais(int PaisID);
        [OperationContract]
        string ObtenerCorreoEmisor(int PaisID);

        #endregion
    }
}