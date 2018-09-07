using Portal.Consultoras.Common;
using Portal.Consultoras.Entities;
using Portal.Consultoras.Entities.OpcionesVerificacion;
using Portal.Consultoras.Entities.Usuario;
using System;
using System.Collections.Generic;
using System.ServiceModel;

namespace Portal.Consultoras.ServiceContracts
{
    [ServiceContract]
    public interface IUsuarioService
    {
        [OperationContract]
        BEUsuario Select(int paisID, string codigoUsuario);

        [OperationContract]
        BEConsultoraDatos GetDatosConsultora(int paisID, string codigoUsuario);

        [OperationContract]
        List<BEUsuarioRol> SelectUsuarioRol(int paisID, string RolDescripcion, string NombreUsuario);

        [OperationContract]
        List<BEUsuarioCorreo> SelectByEmail(string Email, int PaisID);

        [OperationContract]
        List<BEUsuario> SelectByNombre(int paisID, string Nombre);

        [OperationContract]
        int DelUsuarioRol(int paisID, string codigoUsuario, int RolID);

        [OperationContract]
        int setUsuarioVideoIntroductorio(int paisID, string codigoUsuario);

        [OperationContract]
        int setUsuarioVerTutorial(int paisID, string codigoUsuario);

        [OperationContract]
        int SetUsuarioVerTutorialDesktop(int paisID, string codigoUsuario);

        [OperationContract]
        void Insert(BEUsuario usuario);

        [OperationContract]
        void Update(BEUsuario usuario);

        [OperationContract]
        void UpdateDatos(BEUsuario usuario, string CorreoAnterior);

        [OperationContract]
        int UpdUsuarioRechazarInvitacion(int PaisID, string CodigoUsuario);

        [OperationContract]
        int UpdateDatosPrimeraVez(int PaisID, string CodigoUsuario, string Email, string Telefono, string TelefonoTrabajo, string Celular, string CorreoAnterior, bool AceptoContrato);

        [OperationContract]
        void UpdatePassword(int paisID, string codigoUsuario, string claveSecreta, bool cambioClave);

        [OperationContract]
        BEDupla SelectDupla(int paisID, string codigoUsuario);

        [OperationContract]
        void InsertDupla(BEDupla dupla);

        [OperationContract]
        void UpdateDupla(BEDupla dupla);

        [OperationContract]
        bool ActiveEmail(int paisID, string codigoUsuario, string iso, string email);

        [OperationContract]
        BERespuestaActivarEmail ActivarEmail(int paisID, string codigoConsultora, string email);

        [OperationContract]
        BEUsuario GetSesionUsuario(int paisID, string codigoUsuario);

        [OperationContract]
        BEUsuario GetSesionUsuarioWS(int paisID, string codigoUsuario);

        [OperationContract]
        bool IsUserExist(int paisID, string CodigoUsuario);

        [OperationContract]
        string IsConsultoraExist(int paisID, string CodigoConsultora);

        [OperationContract]
        bool ChangePasswordUser(int paisID, string codigoUsuarioAutenticado, string emailCodigoUsuarioModificado, string password, string emailUsuarioModificado, EAplicacionOrigen origen);

        [OperationContract]
        int UpdUsuarioDatosPrimeraVezEstado(int PaisID, string CodigoUsuario);

        [OperationContract]
        int ValidarEmailConsultora(int PaisID, string Email, string CodigoUsuario);

        [OperationContract]
        int ValidarTelefonoConsultora(int PaisID, string Telefono, string CodigoUsuario);

        [OperationContract]
        List<int> GetEstadosRestringidos(int paisID);

        [OperationContract]
        int UpdActualizarDatos(int paisID, string CodigoUsuario, string Email, string Celular, string Telefono);

        [OperationContract]
        string GetNroDocumentoConsultora(int paisID, string CodigoConsultora);

        [OperationContract]
        string GetUsuarioAsociado(int paisID, string CodigoConsultora);

        [OperationContract]
        string GetUsuarioPermisos(int paisID, string codigoUsuario, string codigoConsultora, short tipoUsuario, short rolID);

        [OperationContract]
        List<BEKitNueva> GetValidarConsultoraNueva(int paisID, string CodigoConsultora);

        [OperationContract]
        int ValidarUsuarioPrueba(string CodigoUsuario, int paisID);

        [OperationContract]
        int ValidarEnvioCatalogo(int paisID, string CodigoConsultora, int CampaniaActual, int Cantidad);

        [OperationContract]
        int GetValidarColaboradorZona(int paisID, string CodigoZona);

        [OperationContract]
        DateTime GetFechaFacturacion(string CampaniaCodigo, int ZonaID, int PaisID);

        [OperationContract]
        void UpdateIndicadorAyudaWebTracking(int paisID, string codigoConsultora, bool indicador);

        [OperationContract]
        void InsLogIngresoPortal(int paisID, string CodigoConsultora, string IPOrigen, byte Tipo, string DetalleError, string Canal);

        [OperationContract]
        String AceptarContrato(BEUsuario usuario);

        [OperationContract]
        int AceptarContratoAceptacion(int paisID, long consultoraid, string codigoConsultora, string origen, string direccionIP, string InformacionSOMobile);

        [OperationContract]
        List<BeReporteContrato> ReporteContratoAceptacion(int paisID, string codigoConsultora, string cedula, DateTime? FechaInicio, DateTime? FechaFin);

        [OperationContract]
        BEUsuario GetSesionUsuarioLoginDD(int paisID, string codigoUsuario, string claveSecreta);

        [OperationContract]
        IList<BEUsuario> GetUsuarioDigitadorByFfVv(int paisID, string codigoFfvv);

        [OperationContract]
        BEUsuario GetSesionUsuarioLoginDDByRol(int paisID, int rolID, string email);

        [OperationContract]
        void UpdUsuarioDigitador(BEUsuario usuario);

        [OperationContract]
        IList<BEUsuario> GetUsuario(int paisID, int rol, string codigoUsuario, string codigoFFVV, string nombres, bool estado);

        [OperationContract]
        void UpdUsuarioDD(BEUsuario usuario);


        [OperationContract]
        IList<BENotificaciones> GetNotificacionesConsultora(int PaisID, long ConsultoraId, int indicadorBloqueoCDR, bool tienePagoEnLinea);

        [OperationContract]
        int GetNotificacionesSinLeer(int PaisID, long ConsultoraId, int indicadorBloqueoCDR, bool tienePagoEnLinea);

        [OperationContract]
        IList<BENotificacionesDetalle> GetNotificacionesConsultoraDetalle(int PaisID, long ValAutomaticaPROLLogId, int TipoOrigen);

        [OperationContract]
        IList<BENotificacionesDetallePedido> GetNotificacionesConsultoraDetallePedido(int PaisID, long ValAutomaticaPROLLogId, int TipoOrigen);

        [OperationContract]
        IList<BEMisPedidos> GetMisPedidosConsultoraOnline(int PaisID, long ConsultoraId, int Campania);

        [OperationContract]
        IList<BEMisPedidosDetalle> GetMisPedidosDetalleConsultoraOnline(int PaisID, long PedidoID);

        [OperationContract]
        int GetCantidadSolicitudesPedido(int PaisID, long ConsultoraId, int Campania);

        [OperationContract]
        string GetSaldoHorasSolicitudesPedido(int PaisID, long ConsultoraId, int Campania);

        [OperationContract]
        IList<BEMisPedidos> GetMisPedidosClienteOnline(int paisID, long consultoraId, int campania);

        [OperationContract]
        BEMisPedidos GetPedidoClienteOnlineBySolicitudClienteId(int paisID, long solicitudClienteId);

        [OperationContract]
        void UpdNotificacionesConsultoraVisualizacion(int PaisID, long ValAutomaticaPROLLogId, int TipoOrigen);

        [OperationContract]
        BEConsultoraDatoSAC DatoConsultoraSAC(string paisID, string codigoConsultora, string documento);

        [OperationContract]
        BEConsultoraEstadoSAC ConsultoraEstadoSAC(string paisID, string codigoConsultora);

        [OperationContract]
        IList<BENotificacionesDetallePedido> GetValidacionStockProductos(int PaisID, long ConsultoraId, long ValAutomaticaPROLLogId);

        [OperationContract]
        String GetFechaPromesaCronogramaByCampania(int PaisID, int CampaniaId, string CodigoConsultora, DateTime Fechafact);

        [OperationContract]
        int UpdateDatosPrimeraVezMexico(int PaisID, string CodigoUsuario, string Nombre, string Apellidos, string Telefono, string TelefonoTrabajo, string Celular, string Email, long IdConsultora, string CodigoConsultora, int CampaniaID_Actual, int CampaniaID_UltimaF, int RegionID, int ZonaID, string EmailAnterior);
        [OperationContract]
        int SelectDatosActualizados(int paisID, string codigoUsuario);
        [OperationContract]
        int SelectSegmento(int paisID, int segmentoID);
        [OperationContract]
        int SelectTiempo(int paisID);

        [OperationContract]
        int ValidarEstadoSubscripcion(string PaisISO, string CodigoUsuario, int NroDiasPermitidos);
        [OperationContract]
        BEUsuario ObtenerDatosPorUsuario(string PaisISO, string CodigoUsuario);
        [OperationContract]
        int UpdUsuarioLider(string PaisISO, string CodigoUsuario, string Telefono, string Celular, string Email);
        [OperationContract]
        int UpdCorreoUsuarioLider(string PaisISO, string CodigoUsuario, string Email);
        [OperationContract]
        int CancelarSubscripcion(string PaisISO, string email);
        [OperationContract]
        int ConfirmarSuscripcion(string PaisISO, string Email);
        [OperationContract]
        List<BEUsuario> GenerarReporteSuscripcionLideres(string PaisISO, string TipoReporte);

        [OperationContract]
        void UpdNotificacionSolicitudClienteVisualizacion(int paisID, long SolicitudClienteId);

        [OperationContract]
        void UpdNotificacionSolicitudClienteCatalogoVisualizacion(int paisID, long SolicitudClienteCatalogoId);

        [OperationContract]
        void UpdNotificacionPedidoRechazadoVisualizacion(int paisID, long procesoId);

        [OperationContract]
        BENotificacionesDetalleCatalogo ObtenerDetalleNotificacion(int PaisID, long SolicitudClienteCatalogoId);

        [OperationContract]
        List<BEUsuario> ObtenerResultadoEncuesta(int paisID, int campaniaInicio, int campaniaFin);

        [OperationContract]
        int GetCantidadPedidosConsultoraOnline(int PaisID, long ConsultoraId);

        [OperationContract]
        void GuardarContrasenia(string paisISO, string codigoUsuario, string contrasenia);

        [OperationContract]
        int UpdateUsuarioTutoriales(int paisID, string codigoUsuario, int tipo);

        [OperationContract]
        BEUsuario GetDatosConsultoraHana(int paisID, string codigoUsuario, int campaniaId);

        [OperationContract]
        void UpdNotificacionSolicitudCdrVisualizacion(int paisID, long procesoId);

        [OperationContract]
        void UpdNotificacionCdrCulminadoVisualizacion(int paisID, long procesoId);

        [OperationContract]
        void UpdNotificacionPagoEnLineaVisualizacion(int paisId, int procesoId);

        [OperationContract]
        int UpdateUsuarioEmailTelefono(int paisID, long ConsultoraID, string Email, string Telefono);

        [OperationContract]
        BEValidaLoginSB2 GetValidarLoginSB2(int paisID, string codigoUsuario, string contrasenia);

        [OperationContract]
        BEValidaLoginSB2 GetValidarLoginJsonWebToken(int paisID, string documento);

        [OperationContract]
        BEValidaLoginSB2 GetValidarAutoLogin(int paisID, string codigoUsuario, string proveedor);

        [OperationContract]
        int InsUsuarioExternoPais(int paisID, BEUsuarioExternoPais entidad);

        [OperationContract]
        bool CambiarClaveUsuario(int paisId, string paisIso, string codigoUsuario, string nuevacontrasena, string correo,
            string codigoUsuarioAutenticado, EAplicacionOrigen origen);


        [OperationContract]
        int ExisteUsuario(int paisId, string codigoUsuario, string clave);

        [OperationContract]
        bool ValidarUsuario(string paisIso, string codigoUsuario, string clave);

        [OperationContract]
        List<BEConfiguracionPais> GetConfiguracionPais(BEConfiguracionPais entidad);

        [OperationContract]
        List<BEConfiguracionPaisDatos> GetConfiguracionPaisComponente(BEConfiguracionPaisDatos entidad);

        [OperationContract]
        List<BEConfiguracionPaisDatos> GetConfiguracionPaisComponenteDatos(BEConfiguracionPaisDatos entidad);

        [OperationContract]
        bool ConfiguracionPaisComponenteDeshabilitar(BEConfiguracionPaisDatos entidad);

        [OperationContract]
        int ConfiguracionPaisDatosGuardar(int paisId, List<BEConfiguracionPaisDatos> entidad);

        [OperationContract]
        bool ValidarConfiguracionPaisDetalle(BEConfiguracionPaisDetalle entidad);

        [OperationContract]
        List<BEConfiguracionPaisDatos> GetConfiguracionPaisDatos(BEConfiguracionPaisDatos entidad);

        [OperationContract]
        int RegistrarUsuarioPostulante(string paisISO, BEUsuarioPostulante entidad);

        [OperationContract]
        string ActualizarMisDatos(BEUsuario usuario, string CorreoAnterior);

        [OperationContract]
        BERespuestaServicio ActualizarEmail(BEUsuario usuario, string correoNuevo);

        [OperationContract]
        BERespuestaServicio ActualizarEmailWS(BEUsuario usuario, string correoNuevo);

        [OperationContract]
        BERespuestaServicio RegistrarEnvioSms(int paisId, string codigoUsuario, string codigoConsultora, int campaniaId, bool esMobile, string celularActual, string celularNuevo);

        [OperationContract]
        BERespuestaServicio ConfirmarCelularPorCodigoSms(int paisId, string codigoUsuario, string codigoSms, int campania, bool soloValidar);

        [OperationContract]
        int EliminarUsuarioPostulante(string paisISO, string numeroDocumento);

        [OperationContract]
        BEUsuarioPostulante GetUsuarioPostulante(int paisId, string numeroDocumento);

        [OperationContract]
        int InsertUsuarioExterno(int paisID, BEUsuarioExterno usuarioExterno);

        [OperationContract]
        BEUsuarioExterno GetUsuarioExternoByCodigoUsuario(int paisID, string codigoUsuario);

        [OperationContract]
        BEUsuarioExterno GetUsuarioExternoByProveedorAndIdApp(string proveedor, string idAplicacion, string fotoPerfil);

        [OperationContract]
        List<BEUsuarioExterno> GetListaLoginExterno(int paisID, string codigoUsuario);

        [OperationContract]
        void UpdatePosutlanteMensajes(int paisID, string codigoUsuario, int tipo);

        [OperationContract]
        BEUsuarioConfiguracion ObtenerUsuarioConfiguracion(int paisID, int consultoraID, int campania,
            bool usuarioPrueba, int aceptacionConsultoraDA);
        
        [OperationContract]
        BEUsuarioChatEmtelco GetUsuarioChatEmtelco(int paisID, string codigoUsuario);
        
        #region TerminosCondiciones
        [OperationContract]
        bool InsertTerminosCondiciones(BETerminosCondiciones terminos);
        [OperationContract]
        bool InsertTerminosCondicionesMasivo(int paisID, List<BETerminosCondiciones> terminos);
        #endregion

        #region EventoFestivo
        [OperationContract]
        IList<BEEventoFestivo> GetEventoFestivo(int paisID, string Alcance, int Campania);
        #endregion

        [OperationContract]
        int UpdUsuarioFotoPerfil(int paisID, string codigoUsuario, string fileName);

        [OperationContract]
        string RecuperarContrasenia(int paisId, string textoRecuperacion);

        #region OLVIDE CONTRASENIA
        [OperationContract]
        BEUsuarioDatos GetRestaurarClaveByValor(int paisID, string valorIngresado, int prioridad);

        [OperationContract]
        bool ProcesaEnvioEmail(int paisID, BEUsuarioDatos oUsu, int CantidadEnvios);

        [OperationContract]
        BERespuestaSMS ProcesaEnvioSms(int paisID, BEUsuarioDatos oUsu, int CantidadEnvios);

        [OperationContract]
        bool VerificarIgualdadCodigoIngresado(int paisID, BEUsuarioDatos oUsu, string codigoIngresado);
        #endregion

        #region Pin Autenticidad
        [OperationContract]
        BEUsuarioDatos GetVerificacionAutenticidad(int paisID, string CodigoUsuario);
        #endregion

        [OperationContract]
        bool GetConsultoraParticipaEnPrograma(int paisID, string codigoPrograma, string codigoConsultora, int campaniaID);

        [OperationContract]
        string GetActualizacionEmail(int paisID, string codigoUsuario);

        [OperationContract]
        string CancelarAtualizacionEmail(int paisID, string codigoUsuario);

        [OperationContract]
        BEUsuarioDireccion GetDireccionConsultora(int paisID, string codigoUsuario);

        [OperationContract]
        List<BEBuscadorYFiltros> listaProductos(int paisID, int CampaniaID, int filas, string CodigoDescripcion, int regionId, int zonaId, int codigoRegion, int codigoZona);
        #region ActualizacionDatos
        [OperationContract]
        BERespuestaServicio EnviarSmsCodigo(int paisID, string codigoUsuario, string codigoConsultora, int campaniaID, bool esMobile, string celularActual, string celularNuevo);
        #endregion
    }
}