﻿using Portal.Consultoras.Entities;
using Portal.Consultoras.Entities.Usuario;
using Portal.Consultoras.Entities.Pedido;

using System;
using System.Collections.Generic;

namespace Portal.Consultoras.BizLogic
{
    public interface IUsuarioBusinessLogic
    {
        List<BEUsuarioCorreo> SelectByValorRestauracion(string ValorRestauracion, int paisID);
        void AceptarContrato(BEUsuario usuario);
        string AceptarContratoColombia(BEUsuario usuario);
        bool ActiveEmail(int paisID, string codigoUsuario, string iso, string email);
        string ActualizarMisDatos(BEUsuario usuario, string CorreoAnterior);
        bool CambiarClaveUsuario(int paisId, string paisIso, string codigoUsuario, string nuevacontrasena, string correo, string codigoUsuarioAutenticado, EAplicacionOrigen origen);
        int CancelarSubscripcion(int PaisID, string Email);
        bool ChangePasswordUser(int paisID, string codigoUsuarioAutenticado, string emailCodigoUsuarioModificado, string password, string emailUsuarioModificado, EAplicacionOrigen origen);
        int ConfirmarSuscripcion(int PaisID, string Email);
        int DelUsuarioPostulante(int paisID, string numeroDocumento);
        int DelUsuarioRol(int paisID, string codigoUsuario, int RolID);
        int ExisteUsuario(int paisId, string codigoUsuario, string clave);
        List<BEUsuario> GenerarReporteSuscripcionLideres(int PaisID, string TipoReporte);
        BEConsultoraDatos GetDatosConsultora(int paisID, string codigoUsuario);
        BEUsuario GetDatosConsultoraHana(int paisID, string codigoUsuario, int campaniaId);
        List<int> GetEstadosRestringidos(int paisID);
        IList<BEEventoFestivo> GetEventoFestivo(int paisID, string Alcance, int Campania);
        DateTime GetFechaFacturacion(string CampaniaCodigo, int ZonaID, int PaisID);
        int GetInfoPreLogin(int paisID, string CodigoUsuario);
        int GetInfoPreLoginConsultoraCatalogo(int paisID, string CodigoUsuario);
        List<BEUsuarioExterno> GetListaLoginExterno(int paisID, string codigoUsuario);
        string GetNroDocumentoConsultora(int paisID, string CodigoConsultora);
        BEUsuario GetSesionUsuario(int paisID, string codigoUsuario);
        BEUsuario GetSesionUsuarioLoginDD(int paisID, string codigoUsuario, string claveSecreta);
        BEUsuario GetSesionUsuarioLoginDDByRol(int paisID, int rolID, string email);
        BEUsuario GetSesionUsuarioWS(int paisID, string codigoUsuario);
        List<BEUsuario> GetUsuario(int paisID, int rol, string codigoUsuario, string codigoFFVV, string nombres, bool estado);
        string GetUsuarioAsociado(int paisID, string codigoConsultora);
        List<BEUsuario> GetUsuarioDigitadorByFfVv(int paisID, string codigoFfvv);
        BEUsuarioExterno GetUsuarioExternoByCodigoUsuario(int paisID, string codigoUsuario);
        BEUsuarioExterno GetUsuarioExternoByProveedorAndIdApp(string proveedor, string idAplicacion, string fotoPerfil);
        string GetUsuarioPermisos(int paisID, string codigoUsuario, string codigoConsultora, short tipoUsuario, short rolID);
        BEUsuarioPostulante GetUsuarioPostulante(int paisID, string numeroDocumento);
        BEValidaLoginSB2 GetValidarAutoLogin(int paisID, string codigoUsuario, string proveedor);
        int GetValidarColaboradorZona(int paisID, string CodigoZona);
        List<BEKitNueva> GetValidarConsultoraNueva(int paisID, string CodigoConsultora);
        BEValidaLoginSB2 GetValidarLoginSB2(int paisID, string codigoUsuario, string contrasenia);
        void GuardarContrasenia(int paisID, string codigoUsuario, string contrasenia);
        void Insert(BEUsuario usuario);
        bool InsertTerminosCondiciones(BETerminosCondiciones terminos);
        bool InsertTerminosCondicionesMasivo(int paisID, List<BETerminosCondiciones> terminos);
        int InsertUsuarioExterno(int paisID, BEUsuarioExterno usuarioExterno);
        void InsLogIngresoPortal(int paisID, string CodigoConsultora, string IPOrigen, byte Tipo, string DetalleError, string Canal);
        int InsUsuarioExternoPais(int paisID, BEUsuarioExternoPais entidad);
        int InsUsuarioPostulante(int paisID, string paisISO, BEUsuarioPostulante entidad);
        bool IsUserExist(int paisID, string CodigoUsuario);
        BEUsuario ObtenerDatosPorUsuario(int PaisID, string CodigoUsuario);
        List<BEUsuario> ObtenerResultadoEncuesta(int paisID, int campaniaInicio, int campaniaFin);
        BEUsuarioConfiguracion ObtenerUsuarioConfiguracion(int paisID, int consultoraID, int campania, bool usuarioPrueba, int aceptacionConsultoraDA);
        BEUsuario Select(int paisID, string codigoUsuario);
        List<BEUsuarioCorreo> SelectByEmail(string Email, int paisID);
        List<BEUsuario> SelectByNombre(int paisID, string NombreUsuario);
        int SelectDatosActualizados(int paisID, string codigoUsuario);
        int SelectSegmento(int paisID, int segmentoID);
        int SelectTiempo(int paisID);
        List<BEUsuarioRol> SelectUsuarioRol(int paisID, string RolDescripcion, string NombreUsuario);
        int setUsuarioVerTutorial(int paisID, string CodigoUsuario);
        int SetUsuarioVerTutorialDesktop(int paisID, string CodigoUsuario);
        int setUsuarioVideoIntroductorio(int paisID, string CodigoUsuario);
        int UpdActualizarDatos(int paisID, string CodigoUsuario, string Email, string Celular, string Telefono);
        void Update(BEUsuario usuario);
        void UpdateDatos(BEUsuario usuario, string CorreoAnterior);
        int UpdateDatosPrimeraVez(int paisID, string codigoUsuario, string email, string telefono, string telefonoTrabajo, string celular, string correoAnterior, bool aceptoContrato);
        int UpdateDatosPrimeraVezMexico(int PaisID, string CodigoUsuario, string Nombre, string Apellidos, string Telefono, string TelefonoTrabajo, string Celular, string Email, long IdConsultora, string CodigoConsultora, int CampaniaID_Actual, int CampaniaID_UltimaF, int RegionID, int ZonaID, string EmailAnterior);
        void UpdateIndicadorAyudaWebTracking(int paisID, string codigoConsultora, bool indicador);
        void UpdatePassword(int paisID, string codigoUsuario, string claveSecreta, bool cambioClave);
        void UpdatePostulantesMensajes(int paisID, string CodigoUsuario, int tipo);
        int UpdateUsuarioEmailTelefono(int paisID, long ConsultoraID, string Email, string Telefono);
        int UpdateUsuarioTutoriales(int paisID, string CodigoUsuario, int tipo);
        int UpdCorreoUsuarioLider(int PaisID, string CodigoUsuario, string Email);
        int UpdUsuarioDatosPrimeraVezEstado(int PaisID, string CodigoUsuario);
        void UpdUsuarioDD(BEUsuario usuario);
        void UpdUsuarioDigitador(BEUsuario usuario);
        int UpdUsuarioLider(int PaisID, string CodigoUsuario, string Telefono, string Celular, string Email);
        int UpdUsuarioRechazarInvitacion(int PaisID, string CodigoUsuario);
        BERespuestaServicio RegistrarEnvioSms(int paisId, string codigoUsuario, string codigoConsultora, int campaniaId, bool esMobile, string celularActual, string celularNuevo);
        BERespuestaServicio ConfirmarCelularPorCodigoSms(int paisId, string codigoUsuario, string codigoSms, int campania, bool soloValidar);
        int ValidarEmailConsultora(int PaisID, string Email, string CodigoUsuario);
        int ValidarEnvioCatalogo(int paisID, string CodigoConsultora, int CampaniaActual, int Cantidad);
        int ValidarEstadoSubscripcion(int PaisID, string CodigoUsuario, int NroDiasPermitidos);
        int ValidarTelefonoConsultora(int PaisID, string Telefono, string CodigoUsuario);
        bool ValidarUsuario(int paisId, string codigoUsuario, string clave);
        int ValidarUsuarioPrueba(string CodigoUsuario, int paisID);
        BEUsuarioChatEmtelco GetUsuarioChatEmtelco(int paisID, string codigoUsuario);
        int UpdUsuarioFotoPerfil(int paisID, string codigoUsuario, string fileName);
        bool EsConsultoraNueva(BEUsuario usuario);
        string ObtenerCodigoRevistaFisica(int paisId);
        BEUsuarioDireccion GetDireccionConsultora(int paisID, string codigoUsuario);
        BEUsuario ConfiguracionPaisUsuario(BEUsuario usuario, string codigoConfiguracionPais);
        string ActuaizarNovedadBuscador(int paisId, string codigoUsuario);
        void UpdUsuarioProgramaNuevas(BEUsuario usuario);
        #region ActualizacionDatos
        BERespuestaServicio ActualizarEmailWS(BEUsuario usuario, string correoNuevo);
        BERespuestaServicio EnviarSmsCodigo(int paisID, string codigoUsuario, string codigoConsultora, int campaniaID, bool esMobile, string celularActual, string celularNuevo);
        #endregion
        #region UsuariosOpciones
        List<BEUsuarioOpciones> GetUsuarioOpciones(int paisID, string codigoUsuario);
        #endregion
        void RegistrarDireccionEntrega(string codigoISO, BEDireccionEntrega direccionEntrega, bool conTransaccion);
        BEUsuario GetBasicSesionUsuario(int paisID, string codigoUsuario);
    }
}