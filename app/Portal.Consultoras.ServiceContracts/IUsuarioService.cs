using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.ServiceModel;
using Portal.Consultoras.Entities;

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
        
        //1796 Inicio
        [OperationContract]
        int UpdUsuarioRechazarInvitacion(int PaisID, string CodigoUsuario);
        //1796 Fin

        [OperationContract]
        int UpdateDatosPrimeraVez(int PaisID, string CodigoUsuario, string Email, string Telefono, string Celular, string CorreoAnterior, bool AceptoContrato);

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
        BEUsuario GetSesionUsuario(int paisID, string codigoUsuario);

        [OperationContract]
        bool IsUserExist(string CodigoUsuario);

        [OperationContract]
        string GetUserUPN(string Email);

        [OperationContract]
        bool ChangePasswordUser(int paisID, string codigoUsuarioAutenticado, string emailCodigoUsuarioModificado, string password, string emailUsuarioModificado, EAplicacionOrigen origen);

        [OperationContract]
        int ValidateUserCredentialsActiveDirectory(int paisID, string codigoUsuarioAutenticado, string codigoUsuarioModificado, string OldPassword, string NewPassword);

        [OperationContract]
        int UpdUsuarioDatosPrimeraVezEstado(int PaisID, string CodigoUsuario);

        [OperationContract]
        int ValidarEmailConsultora(int PaisID, string Email, string CodigoUsuario);

        [OperationContract]
        List<int> GetEstadosRestringidos(int paisID);

        [OperationContract]
        int UpdActualizarDatos(int paisID, string CodigoUsuario, string Email, string Celular, string Telefono);

        [OperationContract]
        string GetNroDocumentoConsultora(int paisID, string CodigoConsultora);

        [OperationContract]
        string GetUsuarioAsociado(int paisID, string CodigoConsultora);

        [OperationContract]
        List<BEKitNueva> GetValidarConsultoraNueva(int paisID, string CodigoConsultora);

        [OperationContract]
        bool CreateActiveDirectoryUser(string login, string alias, string firstname, string lastname, string PaisISO, string Clave);

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
        void InsLogIngresoPortal(int paisID, string CodigoConsultora, string IPOrigen, byte Tipo, string DetalleError);

        [OperationContract]
        int AceptarContratoAceptacion(int paisID, long consultoraid, string codigoConsultora);

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

        //CCSS_JZ_PROL2

        [OperationContract]
        IList<BENotificaciones> GetNotificacionesConsultora(int PaisID, long ConsultoraId);

        [OperationContract]
        IList<BENotificacionesDetalle> GetNotificacionesConsultoraDetalle(int PaisID, long ValAutomaticaPROLLogId, int TipoOrigen); //R2073

        [OperationContract]
        IList<BENotificacionesDetallePedido> GetNotificacionesConsultoraDetallePedido(int PaisID, long ValAutomaticaPROLLogId, int TipoOrigen); //R2073

        [OperationContract]
        //IList<BEMisPedidos> GetNotificacionesConsultoraOnline(int PaisID, long ConsultoraId);
        IList<BEMisPedidos> GetMisPedidosConsultoraOnline(int PaisID, long ConsultoraId, int Campania);

        [OperationContract]
        IList<BEMisPedidosDetalle> GetMisPedidosDetalleConsultoraOnline(int PaisID, int PedidoID);

        [OperationContract]
        IList<BEMisPedidos> GetMisPedidosClienteOnline(int paisID, long consultoraId, int campania);

        //[OperationContract]
        //IList<BEProducto> GetValidarCUVMisPedidos(int PaisID, int Campania, string InputCUV, int RegionID, int ZonaID, string CodigoRegion, string CodigoZona);

        [OperationContract]
        void UpdNotificacionesConsultoraVisualizacion(int PaisID, long ValAutomaticaPROLLogId, int TipoOrigen); //R2073

        [OperationContract]
        BEConsultoraDatoSAC DatoConsultoraSAC(string paisID, string codigoConsultora, string documento);

        [OperationContract]
        BEConsultoraEstadoSAC ConsultoraEstadoSAC(string paisID, string codigoConsultora);

        //RQ_NS - R2133
        [OperationContract]
        IList<BENotificacionesDetallePedido> GetValidacionStockProductos(int PaisID, long ConsultoraId, long ValAutomaticaPROLLogId);

        //RQ_FP - R2161
        [OperationContract]
        String GetFechaPromesaCronogramaByCampania(int PaisID, int CampaniaId, string CodigoConsultora, DateTime Fechafact);

        //R2116 INICIO
        [OperationContract]
        int UpdateDatosPrimeraVezMexico(int PaisID, string CodigoUsuario, string Nombre, string Apellidos, string Telefono, string Celular, string Email, long IdConsultora, string CodigoConsultora, int CampaniaID_Actual, int CampaniaID_UltimaF, int RegionID, int ZonaID, string EmailAnterior);
        [OperationContract]
        int SelectDatosActualizados(int paisID, string codigoUsuario);
        [OperationContract]
        int SelectSegmento(int paisID, int segmentoID);
        [OperationContract]
        int SelectTiempo(int paisID);
        //R2116 FIN 

        /* R2392 - AHAA - LIDERES - INICIO */
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
        /* R2392 - AHAA - LIDERES - FIN */

        //R2319
        [OperationContract]
        void UpdNotificacionSolicitudClienteVisualizacion(int paisID, long SolicitudClienteId);     
        /*20150802*/
        [OperationContract]
        void UpdNotificacionSolicitudClienteCatalogoVisualizacion(int paisID, long SolicitudClienteCatalogoId);

        [OperationContract]
        BENotificacionesDetalleCatalogo ObtenerDetalleNotificacion(int PaisID, long SolicitudClienteCatalogoId);

        /*R2520 - JICM - LIDERES - INI*/
        [OperationContract]
        List<BEUsuario> ObtenerResultadoEncuesta(int paisID, int campaniaInicio, int campaniaFin);
        /*R2520 - JICM - LIDERES - FIN*/

        [OperationContract]
        int GetCantidadPedidosConsultoraOnline(int PaisID, long ConsultoraId);

        [OperationContract]
        void GuardarContrasenia(string paisISO, string codigoUsuario, string contrasenia);

        [OperationContract]
        int UpdateUsuarioTutoriales(int paisID, string codigoUsuario, int tipo);
    }
}
