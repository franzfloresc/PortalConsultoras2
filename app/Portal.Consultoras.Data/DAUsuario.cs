using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Data;
using System.Data.Common;
using OpenSource.Library.DataAccess;
using Portal.Consultoras.Entities;

namespace Portal.Consultoras.Data
{
    public class DAUsuario : DataAccess
    {
        public DAUsuario(int paisID)
            : base(paisID, EDbSource.Portal)
        {

        }

        public int setUsuarioVideoIntroductorio(string CodigoUsuario) {
            DbCommand command = Context.Database.GetStoredProcCommand("dbo.setUsuarioVideoIntroductorio_SB2");
            Context.Database.AddInParameter(command, "@codigoUsuario", DbType.AnsiString, CodigoUsuario);

            return Convert.ToInt32(Context.ExecuteScalar(command));
        }

        public int setUsuarioVerTutorial(string CodigoUsuario)
        {
            DbCommand command = Context.Database.GetStoredProcCommand("dbo.setUsuarioVerTutorial_SB2");
            Context.Database.AddInParameter(command, "@codigoUsuario", DbType.AnsiString, CodigoUsuario);

            return Convert.ToInt32(Context.ExecuteScalar(command));
        }

        public int SetUsuarioVerTutorialDesktop(string CodigoUsuario)
        {
            DbCommand command = Context.Database.GetStoredProcCommand("dbo.setUsuarioVerTutorialDesktop_SB2");
            Context.Database.AddInParameter(command, "@codigoUsuario", DbType.AnsiString, CodigoUsuario);
            return Convert.ToInt32(Context.ExecuteScalar(command));
        }

        public IDataReader GetUsuario(string CodigoUsuario)
        {
            DbCommand command = Context.Database.GetStoredProcCommand("dbo.GetUsuario");
            Context.Database.AddInParameter(command, "@CodigoUsuario", DbType.AnsiString, CodigoUsuario);

            return Context.ExecuteReader(command);
        }

        public IDataReader GetDatosConsultora(string CodigoUsuario)
        {
            DbCommand command = Context.Database.GetStoredProcCommand("dbo.GetDatosConsultora");
            Context.Database.AddInParameter(command, "@CodigoConsultora", DbType.AnsiString, CodigoUsuario);

            return Context.ExecuteReader(command);
        }

        public IDataReader GetUsuarioByNombre(string NombreUsuario)
        {
            DbCommand command = Context.Database.GetStoredProcCommand("dbo.GetUsuarioByNombre");
            Context.Database.AddInParameter(command, "@Nombre", DbType.AnsiString, NombreUsuario);

            return Context.ExecuteReader(command);
        }

        public IDataReader GetUsuarioRol(string RolDescripcion, string NombreUsuario)
        {
            DbCommand command = Context.Database.GetStoredProcCommand("dbo.GetUsuarioRol");
            Context.Database.AddInParameter(command, "@RolDescripcion", DbType.AnsiString, RolDescripcion);
            Context.Database.AddInParameter(command, "@NombreUsuario", DbType.AnsiString, NombreUsuario);

            return Context.ExecuteReader(command);
        }

        public IDataReader GetUsuarioCorreo(string Email, int PaisID)
        {
            DbCommand command = Context.Database.GetStoredProcCommand("dbo.ValidateEmail");
            Context.Database.AddInParameter(command, "@Email", DbType.AnsiString, Email);
            Context.Database.AddInParameter(command, "@PaisID", DbType.AnsiString, PaisID);

            return Context.ExecuteReader(command);
        }

        public int DelUsuarioRol(string CodigoUsuario, int RolID)
        {
            DbCommand command = Context.Database.GetStoredProcCommand("dbo.DelUsuarioRol");
            Context.Database.AddInParameter(command, "@CodigoUsuario", DbType.AnsiString, CodigoUsuario);
            Context.Database.AddInParameter(command, "@RolID", DbType.Int32, RolID);

            return Convert.ToInt32(Context.ExecuteScalar(command));
        }

        public IDataReader GetUsuarioByEMail(string EMail)
        {
            DbCommand command = Context.Database.GetStoredProcCommand("dbo.GetUsuarioByEMail");
            Context.Database.AddInParameter(command, "@EMail", DbType.AnsiString, EMail);

            return Context.ExecuteReader(command);
        }

        public int InsUsuario(BEUsuario usuario)
        {
            DbCommand command = Context.Database.GetStoredProcCommand("dbo.InsUsuario");
            Context.Database.AddInParameter(command, "@CodigoUsuario", DbType.AnsiString, usuario.CodigoUsuario);
            Context.Database.AddInParameter(command, "@PaisID", DbType.Byte, usuario.PaisID);
            Context.Database.AddInParameter(command, "@Nombre", DbType.AnsiString, usuario.Nombre);
            Context.Database.AddInParameter(command, "@ClaveSecreta", DbType.AnsiString, usuario.ClaveSecreta);
            Context.Database.AddInParameter(command, "@EMail", DbType.AnsiString, usuario.EMail);
            Context.Database.AddInParameter(command, "@EMailActivo", DbType.Boolean, usuario.EMailActivo);
            Context.Database.AddInParameter(command, "@Telefono", DbType.AnsiString, usuario.Telefono);
            Context.Database.AddInParameter(command, "@Celular", DbType.AnsiString, usuario.Celular);
            Context.Database.AddInParameter(command, "@Sobrenombre", DbType.AnsiString, usuario.Sobrenombre);
            Context.Database.AddInParameter(command, "@CompartirDatos", DbType.Boolean, usuario.CompartirDatos);
            Context.Database.AddInParameter(command, "@Activo", DbType.Boolean, usuario.Activo);
            Context.Database.AddInParameter(command, "@TipoUsuario", DbType.Byte, usuario.TipoUsuario);
            Context.Database.AddInParameter(command, "@CambioClave", DbType.Boolean, usuario.CambioClave);
            Context.Database.AddInParameter(command, "@DocumentoIdentidad", DbType.AnsiString, usuario.DocumentoIdentidad); //EPD-1836

            return Context.ExecuteNonQuery(command);
        }

        public int InsLogCambioContrasenia(string codigoUsuarioAutenticado, string emailCodigoUsuarioModificado, string password, string emailUsuarioModificado, string origen)
        {
            DbCommand command = Context.Database.GetStoredProcCommand("dbo.InsLogCambioContrasenia");
            Context.Database.AddInParameter(command, "@codigoUsuarioAutenticado", DbType.AnsiString, codigoUsuarioAutenticado);
            Context.Database.AddInParameter(command, "@emailCodigoUsuarioModificado", DbType.AnsiString, emailCodigoUsuarioModificado);
            Context.Database.AddInParameter(command, "@password", DbType.AnsiString, password);
            Context.Database.AddInParameter(command, "@emailUsuarioModificado", DbType.AnsiString, emailUsuarioModificado);
            Context.Database.AddInParameter(command, "@origen", DbType.AnsiString, origen);

            return Context.ExecuteNonQuery(command);
        }

        public int UpdUsuario(BEUsuario usuario)
        {
            DbCommand command = Context.Database.GetStoredProcCommand("dbo.UpdUsuario");
            Context.Database.AddInParameter(command, "@CodigoUsuario", DbType.AnsiString, usuario.CodigoUsuario);
            Context.Database.AddInParameter(command, "@Nombre", DbType.AnsiString, usuario.Nombre);
            Context.Database.AddInParameter(command, "@EMail", DbType.AnsiString, usuario.EMail);
            Context.Database.AddInParameter(command, "@EMailActivo", DbType.Boolean, usuario.EMailActivo);
            Context.Database.AddInParameter(command, "@Telefono", DbType.AnsiString, usuario.Telefono);
            Context.Database.AddInParameter(command, "@Celular", DbType.AnsiString, usuario.Celular);
            Context.Database.AddInParameter(command, "@Sobrenombre", DbType.AnsiString, usuario.Sobrenombre);
            Context.Database.AddInParameter(command, "@CompartirDatos", DbType.Boolean, usuario.CompartirDatos);
            Context.Database.AddInParameter(command, "@Activo", DbType.Boolean, usuario.Activo);
            Context.Database.AddInParameter(command, "@CambioClave", DbType.Boolean, usuario.CambioClave);

            return Context.ExecuteNonQuery(command);
        }

        public int UpdUsuarioDatos(BEUsuario usuario, string CorreoAnterior)
        {
            DbCommand command = Context.Database.GetStoredProcCommand("dbo.UpdUsuarioDatos");
            Context.Database.AddInParameter(command, "@CodigoUsuario", DbType.AnsiString, usuario.CodigoUsuario);
            Context.Database.AddInParameter(command, "@EMail", DbType.AnsiString, usuario.EMail);
            Context.Database.AddInParameter(command, "@Telefono", DbType.AnsiString, usuario.Telefono);
            Context.Database.AddInParameter(command, "@TelefonoTrabajo", DbType.AnsiString, usuario.TelefonoTrabajo);
            Context.Database.AddInParameter(command, "@Celular", DbType.AnsiString, usuario.Celular);
            Context.Database.AddInParameter(command, "@Sobrenombre", DbType.AnsiString, usuario.Sobrenombre);
            Context.Database.AddInParameter(command, "@CorreoAnterior", DbType.AnsiString, CorreoAnterior);
            Context.Database.AddInParameter(command, "@CompartirDatos", DbType.Boolean, usuario.CompartirDatos);
            Context.Database.AddInParameter(command, "@AceptoContrato", DbType.Boolean, usuario.AceptoContrato);

            return Context.ExecuteNonQuery(command);
        }

        public int UpdUsuarioDatosPrimeraVez(string codigoUsuario, string email, string telefono, string telefonoTrabajo, string celular, string correoAnterior, bool aceptoContrato)
        {
            DbCommand command = Context.Database.GetStoredProcCommand("dbo.UpdUsuarioDatosPrimeraVez");
            Context.Database.AddInParameter(command, "@CodigoUsuario", DbType.AnsiString, codigoUsuario);
            Context.Database.AddInParameter(command, "@EMail", DbType.AnsiString, email);
            Context.Database.AddInParameter(command, "@Telefono", DbType.AnsiString, telefono);
            Context.Database.AddInParameter(command, "@TelefonoTrabajo", DbType.AnsiString, telefonoTrabajo);
            Context.Database.AddInParameter(command, "@Celular", DbType.AnsiString, celular);
            Context.Database.AddInParameter(command, "@CorreoAnterior", DbType.AnsiString, correoAnterior);
            Context.Database.AddInParameter(command, "@AceptoContrato", DbType.Boolean, aceptoContrato); //2532 EGL

            return Context.ExecuteNonQuery(command);
        }

        public int UpdUsuarioDatosPrimeraVezEstado(string CodigoUsuario)
        {
            DbCommand command = Context.Database.GetStoredProcCommand("dbo.UpdUsuarioDatosPrimeraVezEstado");
            Context.Database.AddInParameter(command, "@CodigoUsuario", DbType.AnsiString, CodigoUsuario);

            return Context.ExecuteNonQuery(command);
        }

        public int UpdUsuarioClaveSecreta(string CodigoUsuario, string ClaveSecreta, bool CambioClave)
        {
            DbCommand command = Context.Database.GetStoredProcCommand("dbo.UpdUsuarioClaveSecreta");
            Context.Database.AddInParameter(command, "@CodigoUsuario", DbType.AnsiString, CodigoUsuario);
            Context.Database.AddInParameter(command, "@ClaveSecreta", DbType.AnsiString, ClaveSecreta);
            Context.Database.AddInParameter(command, "@CambioClave", DbType.Boolean, CambioClave);

            return Context.ExecuteNonQuery(command);
        }

        public IDataReader GetUsuarioPostulanteEmail(string numeroDocumento)
        {
            DbCommand command = Context.Database.GetStoredProcCommand("dbo.GetUsuarioPostulanteEmail");
            Context.Database.AddInParameter(command, "@DocumentoIdentidad", DbType.AnsiString, numeroDocumento);

            return Context.ExecuteReader(command);
        }

        public int InsLogEnvioEmailConsultora(BEConsultoraEmail entidad)
        {
            DbCommand command = Context.Database.GetStoredProcCommand("dbo.InsLogEnvioEmails");
            Context.Database.AddInParameter(command, "@CodigoConsultora", DbType.AnsiString, entidad.Codigo);
            Context.Database.AddInParameter(command, "@CodigoZona", DbType.AnsiString, entidad.CodigoZona);
            Context.Database.AddInParameter(command, "@FlgEnvio", DbType.Int16, 0);
            Context.Database.AddInParameter(command, "@ConsecutivoNueva", DbType.Int16, -1);
            Context.Database.AddInParameter(command, "@EstadoEnvio", DbType.Int16, 1);
            Context.Database.AddInParameter(command, "@EsPostulante", DbType.Int16, entidad.EsPostulante);
            Context.Database.AddInParameter(command, "@CodigoUsuario", DbType.AnsiString, entidad.CodigoUsuario);

            return Context.ExecuteNonQuery(command);
        }

        //1796 Inicio 
        public int UpdUsuarioRechazarInvitacion(string CodigoUsuario)
        {
            DbCommand command = Context.Database.GetStoredProcCommand("dbo.UpdUsuarioRechazarInvitacion");
            Context.Database.AddInParameter(command, "@CodigoUsuario", DbType.AnsiString, CodigoUsuario);
            return Context.ExecuteNonQuery(command);
        }
        //1796 Fin 

        public bool ActiveEmail(string CodigoUsuario)
        {
            DbCommand command = Context.Database.GetStoredProcCommand("dbo.UpdUsuarioEMailActivo");
            Context.Database.AddInParameter(command, "@CodigoUsuario", DbType.AnsiString, CodigoUsuario);

            return Convert.ToBoolean(Context.ExecuteScalar(command));
        }

        public IDataReader GetSesionUsuario(string CodigoUsuario)
        {
            DbCommand command = Context.Database.GetStoredProcCommand("dbo.GetSesionUsuario_SB2");
            Context.Database.AddInParameter(command, "@CodigoConsultora", DbType.AnsiString, CodigoUsuario);

            return Context.ExecuteReader(command);
        }

        public string GetUsuarioAsociado(string CodigoConsultora)
        {
            DbCommand command = Context.Database.GetStoredProcCommand("dbo.GetUsuarioAsociado");
            Context.Database.AddInParameter(command, "@CodigoConsultora", DbType.AnsiString, CodigoConsultora);

            return Convert.ToString(Context.ExecuteScalar(command));
        }

        public int ValidarEmailConsultora(string Email, string CodigoUsuario)
        {
            DbCommand command = Context.Database.GetStoredProcCommand("dbo.ValidateConsultoraEmail");
            Context.Database.AddInParameter(command, "@Email", DbType.AnsiString, Email);
            Context.Database.AddInParameter(command, "@CodigoUsuario", DbType.AnsiString, CodigoUsuario);

            return Convert.ToInt32(Context.ExecuteScalar(command));
        }

        public int ValidarTelefonoConsultora(string Telefono, string CodigoUsuario)
        {
            DbCommand command = Context.Database.GetStoredProcCommand("dbo.ValidateConsultoraTelefono");
            Context.Database.AddInParameter(command, "@Telefono", DbType.AnsiString, Telefono);
            Context.Database.AddInParameter(command, "@CodigoUsuario", DbType.AnsiString, CodigoUsuario);

            return Convert.ToInt32(Context.ExecuteScalar(command));
        }

        public IDataReader GetEstadosRestringidos()
        {
            DbCommand command = Context.Database.GetStoredProcCommand("dbo.GetEstadosRestringidos");

            return Context.ExecuteReader(command);
        }

        public string GetNroDocumentoConsultora(string CodigoConsultora)
        {
            DbCommand command = Context.Database.GetStoredProcCommand("dbo.GetNroDocumentoConsultora");
            Context.Database.AddInParameter(command, "@CODIGO", DbType.AnsiString, CodigoConsultora);

            return Convert.ToString(Context.ExecuteScalar(command));
        }

        public IDataReader GetValidarConsultoraNueva(string CodigoConsultora)
        {
            DbCommand command = Context.Database.GetStoredProcCommand("dbo.ValidarConsultoraNueva");
            Context.Database.AddInParameter(command, "@CodigoConsultora", DbType.AnsiString, CodigoConsultora);

            return Context.ExecuteReader(command);
        }

        public IDataReader GetInfoPreLogin(string CodigoUsuario)
        {
            DbCommand command = Context.Database.GetStoredProcCommand("dbo.GetInfoPreLogin");
            Context.Database.AddInParameter(command, "@CodigoUsuario", DbType.AnsiString, CodigoUsuario);

            return Context.ExecuteReader(command);
        }

        /*EPD-1012*/
        public IDataReader GetValidarLoginSB2(string codigoUsuario, string contrasenia)
        {
            //DbCommand command = Context.Database.GetStoredProcCommand("dbo.ValidarLogin2_SB2");
            DbCommand command = Context.Database.GetStoredProcCommand("dbo.ValidarLogin_SB2");
            Context.Database.AddInParameter(command, "@CodigoUsuario", DbType.AnsiString, codigoUsuario);
            Context.Database.AddInParameter(command, "@Contrasenia", DbType.AnsiString, contrasenia);

            return Context.ExecuteReader(command);
        }
        /*EPD-1012*/

        /*EPD-2340*/
        public IDataReader GetValidarAutoLoginSB2(string codigoUsuario, string proveedor)
        {
            DbCommand command = Context.Database.GetStoredProcCommand("dbo.ValidarAutoLogin_SB2");
            Context.Database.AddInParameter(command, "@CodigoUsuario", DbType.AnsiString, codigoUsuario);
            Context.Database.AddInParameter(command, "@Proveedor", DbType.AnsiString, proveedor);

            return Context.ExecuteReader(command);
        }
        /*EPD-2340*/

        public IDataReader GetInfoPreLoginConsultoraCatalogo(string CodigoUsuario)
        {
            DbCommand command = Context.Database.GetStoredProcCommand("dbo.GetInfoPreLoginConsultoraCatalogo");
            Context.Database.AddInParameter(command, "@CodigoUsuario", DbType.AnsiString, CodigoUsuario);

            return Context.ExecuteReader(command);
        }

        public int ValidarUsuarioPrueba(string CodigoUsuario)
        {
            DbCommand command = Context.Database.GetStoredProcCommand("dbo.ValidarUsuarioPrueba");
            Context.Database.AddInParameter(command, "@CodigoUsuario", DbType.AnsiString, CodigoUsuario);

            return Convert.ToInt32(Context.ExecuteScalar(command));
        }

        public int ValidarEnvioCatalogo(string CodigoConsultora, int CampaniaActual, int Cantidad)
        {
            DbCommand command = Context.Database.GetStoredProcCommand("dbo.ValidarEnvioCatalogo");
            Context.Database.AddInParameter(command, "@CodigoConsultora", DbType.AnsiString, CodigoConsultora);
            Context.Database.AddInParameter(command, "@CampaniaActual", DbType.Int32, CampaniaActual);
            Context.Database.AddInParameter(command, "@Cantidad", DbType.Int32, Cantidad);

            return Convert.ToInt32(Context.ExecuteScalar(command));
        }

        public int GetValidarColaboradorZona(string CodigoZona)
        {
            DbCommand command = Context.Database.GetStoredProcCommand("dbo.GetZonaColaborador");
            Context.Database.AddInParameter(command, "@CodigoZona", DbType.AnsiString, CodigoZona);

            return Convert.ToInt32(Context.ExecuteScalar(command));
        }

        public DateTime GetFechaFacturacion(string CampaniaCodigo, int ZonaID, int PaisID)
        {
            DbCommand command = Context.Database.GetStoredProcCommand("dbo.GetFechaFacturacion");
            Context.Database.AddInParameter(command, "@CampaniaCodigo", DbType.AnsiString, CampaniaCodigo);
            Context.Database.AddInParameter(command, "@ZonaID", DbType.AnsiString, ZonaID);
            Context.Database.AddInParameter(command, "@PaisID", DbType.AnsiString, PaisID);

            return Convert.ToDateTime(Context.ExecuteScalar(command));
        }

        public void UpdateIndicadorAyudaWebTracking(string codigoConsultora, bool indicador)
        {
            DbCommand command = Context.Database.GetStoredProcCommand("dbo.UpdateUsuarioIndicadorAyudaWebTracking");
            Context.Database.AddInParameter(command, "@CodigoConsultora", DbType.AnsiString, codigoConsultora);
            Context.Database.AddInParameter(command, "@MostrarAyudaWebTracking", DbType.Boolean, indicador);

            Context.ExecuteScalar(command);
        }

        public void InsLogIngresoPortal(string CodigoConsultora, string IPOrigen, byte Tipo, string DetalleError)
        {
            DbCommand command = Context.Database.GetStoredProcCommand("dbo.InsLogIngresoPortal");
            Context.Database.AddInParameter(command, "@CodigoConsultora", DbType.AnsiString, CodigoConsultora);
            Context.Database.AddInParameter(command, "@IPOrigen", DbType.AnsiString, IPOrigen);
            Context.Database.AddInParameter(command, "@Tipo", DbType.Byte, Tipo);
            Context.Database.AddInParameter(command, "@DetalleError", DbType.AnsiString, DetalleError);

            Context.ExecuteNonQuery(command);
        }

        public IDataReader GetSesionUsuarioLoginDD(string CodigoUsuario, string ClaveSecreta)
        {
            DbCommand command = Context.Database.GetStoredProcCommand("dbo.GetSesionUsuarioLoginDD");
            Context.Database.AddInParameter(command, "@CodigoUsuario", DbType.AnsiString, CodigoUsuario);
            Context.Database.AddInParameter(command, "@ClaveSecreta", DbType.AnsiString, ClaveSecreta);

            return Context.ExecuteReader(command);
        }
        public IDataReader GetUsuarioDigitadorByFfVv(string codigoFfvv)
        {
            DbCommand command = Context.Database.GetStoredProcCommand("dbo.GetUsuariosDigitadoresByFFVV");
            Context.Database.AddInParameter(command, "@CodigoFFVV", DbType.AnsiString, codigoFfvv);

            return Context.ExecuteReader(command);
        }

        public void UpdUsuarioDigitador(BEUsuario usuario)
        {
            DbCommand command = Context.Database.GetStoredProcCommand("dbo.UpdUsuarioDigitador");
            Context.Database.AddInParameter(command, "@CodigoUsuario", DbType.AnsiString, usuario.CodigoUsuario);
            Context.Database.AddInParameter(command, "@Nombre", DbType.AnsiString, usuario.Nombre);
            Context.Database.AddInParameter(command, "@CodigoFFVV", DbType.AnsiString, usuario.CodigoConsultora);
            Context.Database.AddInParameter(command, "@PaisID", DbType.AnsiString, usuario.PaisID);
            Context.Database.AddInParameter(command, "@ClaveSecreta", DbType.AnsiString, usuario.ClaveSecreta);
            Context.Database.AddInParameter(command, "@Activo", DbType.Boolean, usuario.Activo);
            Context.Database.AddInParameter(command, "@RolID", DbType.AnsiString, usuario.RolID);

            Context.ExecuteScalar(command);
        }

        public IDataReader GetSesionUsuarioLoginDDByRol(int rolID, string email)
        {
            DbCommand command = Context.Database.GetStoredProcCommand("dbo.GetSesionUsuarioLoginDDByRol");
            Context.Database.AddInParameter(command, "@RolID", DbType.AnsiString, rolID);
            Context.Database.AddInParameter(command, "@EMail", DbType.AnsiString, email);

            return Context.ExecuteReader(command);
        }

        public IDataReader GetUsuario(int rol, string codigoUsuario, string codigoFFVV, string nombres, bool estado)
        {
            DbCommand command = Context.Database.GetStoredProcCommand("dbo.GetUsuarios");
            Context.Database.AddInParameter(command, "@Rol", DbType.AnsiString, rol);
            Context.Database.AddInParameter(command, "@CodigoUsuario", DbType.AnsiString, codigoUsuario);
            Context.Database.AddInParameter(command, "@CodigoFFVV", DbType.AnsiString, codigoFFVV);
            Context.Database.AddInParameter(command, "@Nombres", DbType.AnsiString, nombres);
            Context.Database.AddInParameter(command, "@Estado", DbType.AnsiString, estado);
            return Context.ExecuteReader(command);
        }

        public void UpdUsuarioDD(BEUsuario usuario)
        {
            DbCommand command = Context.Database.GetStoredProcCommand("dbo.UpdUsuarioDD");
            Context.Database.AddInParameter(command, "@CodigoUsuario", DbType.AnsiString, usuario.CodigoUsuario);
            Context.Database.AddInParameter(command, "@Nombre", DbType.AnsiString, usuario.Nombre);
            Context.Database.AddInParameter(command, "@CodigoFFVV", DbType.AnsiString, usuario.CodigoConsultora);
            Context.Database.AddInParameter(command, "@PaisID", DbType.AnsiString, usuario.PaisID);
            Context.Database.AddInParameter(command, "@ClaveSecreta", DbType.AnsiString, usuario.ClaveSecreta);
            Context.Database.AddInParameter(command, "@Activo", DbType.Boolean, usuario.Activo);
            Context.Database.AddInParameter(command, "@RolID", DbType.AnsiString, usuario.RolID);
            Context.Database.AddInParameter(command, "@Email", DbType.AnsiString, usuario.EMail);

            Context.ExecuteScalar(command);
        }
        /* 2116-inicio*/
        public int UpdUsuarioDatosPrimeraVezMexico(string CodigoUsuario, string Nombre, string Apellidos, string Telefono, string TelefonoTrabajo, string Celular, string Email, long IdConsultora, string CodigoConsultora, int CampaniaID_Actual, int CampaniaID_UltimaF, int RegionID, int ZonaID, string EmailAnterior)
        {

            DbCommand command = Context.Database.GetStoredProcCommand("dbo.UpdUsuarioDatosPrimeraVezMexico");
            Context.Database.AddInParameter(command, "@CodigoUsuario", DbType.AnsiString, CodigoUsuario);
            Context.Database.AddInParameter(command, "@Nombre", DbType.AnsiString, Nombre);
            Context.Database.AddInParameter(command, "@Apellidos", DbType.AnsiString, Apellidos);
            Context.Database.AddInParameter(command, "@Telefono", DbType.AnsiString, Telefono);
            Context.Database.AddInParameter(command, "@TelefonoTrabajo", DbType.AnsiString, TelefonoTrabajo);
            Context.Database.AddInParameter(command, "@Celular", DbType.AnsiString, Celular);
            Context.Database.AddInParameter(command, "@Email", DbType.AnsiString, Email);
            Context.Database.AddInParameter(command, "@IdConsultora", DbType.Int32, Convert.ToInt32(IdConsultora.ToString()));
            Context.Database.AddInParameter(command, "@CodigoConsultora", DbType.AnsiString, CodigoConsultora);
            Context.Database.AddInParameter(command, "@CampaniaID_Actual", DbType.AnsiString, CampaniaID_Actual);
            Context.Database.AddInParameter(command, "@CampaniaID_UltimaF", DbType.AnsiString, CampaniaID_UltimaF);
            Context.Database.AddInParameter(command, "@RegionID", DbType.Int32, RegionID);
            Context.Database.AddInParameter(command, "@ZonaID", DbType.Int32, ZonaID);
            Context.Database.AddInParameter(command, "@EmailAnterior", DbType.Int32, ZonaID);
            return Context.ExecuteNonQuery(command);
        }
        public IDataReader GetUsuarioDatosActualizados(string CodigoUsuario)
        {
            DbCommand command = Context.Database.GetStoredProcCommand("dbo.GetUsuarioDatosActualizados");
            Context.Database.AddInParameter(command, "@CodigoUsuario", DbType.AnsiString, CodigoUsuario);

            return Context.ExecuteReader(command);
        }
        public IDataReader GetSegmento(int SegmentoID)
        {
            DbCommand command = Context.Database.GetStoredProcCommand("dbo.GetSegmentoConfigurable");
            Context.Database.AddInParameter(command, "@SegmentoID", DbType.AnsiString, SegmentoID);

            return Context.ExecuteReader(command);
        }
        public IDataReader GetTiempo()
        {
            DbCommand command = Context.Database.GetStoredProcCommand("dbo.GetTiempoVentana");
            return Context.ExecuteReader(command);
        }
        /* 2116 -fin*/

        /* R2392 - AHAA - LIDERES - INICIO */
        public int ValidarEstadoSubscripcion(string CodigoUsuario, int NroDiasPermitidos)
        {
            DbCommand command = Context.Database.GetStoredProcCommand("dbo.ValidarEstadoSuscripcion");
            Context.Database.AddInParameter(command, "@CodigoUsuario", DbType.AnsiString, CodigoUsuario);
            Context.Database.AddInParameter(command, "@DiasPermitido", DbType.Int32, NroDiasPermitidos);
            return Convert.ToInt32(Context.ExecuteScalar(command));
        }

        public IDataReader ObtenerDatosPorUsuario(string CodigoUsuario)
        {
            DbCommand command = Context.Database.GetStoredProcCommand("dbo.ValidarEstadoSuscripcion");
            Context.Database.AddInParameter(command, "@CodigoUsuario", DbType.AnsiString, CodigoUsuario);
            return Context.ExecuteReader(command);
        }

        public int UpdUsuarioLider(string CodigoUsuario, string Telefono, string Celular, string Email)
        {
            DbCommand command = Context.Database.GetStoredProcCommand("dbo.ActualizarUsuarioLider");
            Context.Database.AddInParameter(command, "@CodigoUsuario", DbType.AnsiString, CodigoUsuario);
            Context.Database.AddInParameter(command, "@Telefono", DbType.AnsiString, Telefono);
            Context.Database.AddInParameter(command, "@Celular", DbType.AnsiString, Celular);
            Context.Database.AddInParameter(command, "@Email", DbType.AnsiString, Email);
            return Context.ExecuteNonQuery(command);
        }

        public int UpdCorreoUsuarioLider(string CodigoUsuario, string Email)
        {
            DbCommand command = Context.Database.GetStoredProcCommand("dbo.ActualizarCorreoUsuarioLider");
            Context.Database.AddInParameter(command, "@CodigoUsuario", DbType.AnsiString, CodigoUsuario);
            Context.Database.AddInParameter(command, "@Email", DbType.AnsiString, Email);
            return Context.ExecuteNonQuery(command);
        }

        public int CancelarSubscripcion(string Email)
        {
            DbCommand command = Context.Database.GetStoredProcCommand("dbo.CancelarSuscripcion");
            Context.Database.AddInParameter(command, "@Email", DbType.AnsiString, Email);
            return Context.ExecuteNonQuery(command);
        }

        public int ConfirmarSuscripcion(string Email)
        {
            DbCommand command = Context.Database.GetStoredProcCommand("dbo.ConfirmarSuscripcion");
            Context.Database.AddInParameter(command, "@Email", DbType.AnsiString, Email);
            return Context.ExecuteNonQuery(command);
        }

        public IDataReader GenerarReporteSuscripcionLideres(string TipoReporte)
        {
            DbCommand command = Context.Database.GetStoredProcCommand("dbo.GenerarReporteSuscripcionLideres");
            Context.Database.AddInParameter(command, "@TipoReporte", DbType.AnsiString, TipoReporte);
            return Context.ExecuteReader(command);
        }
        /* R2392 - AHAA - LIDERES - INICIO */

        /*R2520 - JICM - LIDERES - INICIO*/
        public IDataReader GenerarReporteResultadoEncuesta(int paisId, int campaniaIncio, int campaniaFin)
        {
            DbCommand command = Context.Database.GetStoredProcCommand("dbo.GetResultadoEncuesta");
            Context.Database.AddInParameter(command, "@CodigoPais", DbType.Int32, paisId);
            Context.Database.AddInParameter(command, "@CampaniaInicio", DbType.Int32, campaniaIncio);
            Context.Database.AddInParameter(command, "@CampaniaFin", DbType.Int32, campaniaFin);
            return Context.ExecuteReader(command);
        }

        /*R2520 - JICM - LIDERES - FIN*/

        public void GuardarContrasenia(string codigoUsuario, string contrasenia)
        {
            DbCommand command = Context.Database.GetStoredProcCommand("dbo.UpdUsuarioContrasenia");
            Context.Database.AddInParameter(command, "@CodigoUsuario", DbType.String, codigoUsuario);
            Context.Database.AddInParameter(command, "@Contrasenia", DbType.String, contrasenia);
            Context.ExecuteNonQuery(command);
        }

        public int UpdateUsuarioTutoriales(string CodigoUsuario, int tipo)
        {
            DbCommand command = Context.Database.GetStoredProcCommand("dbo.UpdateUsuarioTutoriales_SB2");
            Context.Database.AddInParameter(command, "@codigoUsuario", DbType.AnsiString, CodigoUsuario);
            Context.Database.AddInParameter(command, "@tipo", DbType.AnsiString, tipo);
            return Convert.ToInt32(Context.ExecuteScalar(command));
        }

        public void CambiarClaveUsuario(string codigoUsuario, string nuevacontrasena, string correo)
        {
            DbCommand command = Context.Database.GetStoredProcCommand("dbo.CambiarClaveUsuario");
            Context.Database.AddInParameter(command, "@CodigoUsuario", DbType.AnsiString, codigoUsuario);
            Context.Database.AddInParameter(command, "@NuevaContrasenia", DbType.AnsiString, nuevacontrasena);
            Context.Database.AddInParameter(command, "@Correo", DbType.AnsiString, correo);

            Context.ExecuteNonQuery(command);
        }

        public int ExisteUsuario(string codigoUsuario, string clave)
        {
            DbCommand command = Context.Database.GetStoredProcCommand("dbo.ExisteUsuario");
            Context.Database.AddInParameter(command, "@CodigoUsuario", DbType.AnsiString, codigoUsuario);            
            Context.Database.AddInParameter(command, "@Clave", DbType.AnsiString, clave);            
            return Convert.ToInt32(Context.ExecuteScalar(command));
        }

        public bool ValidarUsuario(string codigoUsuario, string clave)
        {
            DbCommand command = Context.Database.GetStoredProcCommand("dbo.ValidarUsuario");
            Context.Database.AddInParameter(command, "@CodigoUsuario", DbType.AnsiString, codigoUsuario);
            Context.Database.AddInParameter(command, "@Clave", DbType.AnsiString, clave);
            return Convert.ToBoolean(Context.ExecuteScalar(command));
        }

        
        public int UpdateUsuarioEmailTelefono(long ConsultoraID, string Email, string Telefono)
        {
            DbCommand command = Context.Database.GetStoredProcCommand("dbo.UpdUsuarioEMailCDRWeb");
            Context.Database.AddInParameter(command, "@ConsultoraID", DbType.Int64, ConsultoraID);
            Context.Database.AddInParameter(command, "@EMail", DbType.String, Email);
            Context.Database.AddInParameter(command, "@Telefono", DbType.String, Telefono);
            Context.Database.AddOutParameter(command, "@RetornoSiNoCorreoNuevo", DbType.Int32, 10);
            Context.ExecuteNonQuery(command);

            return Convert.ToInt32(command.Parameters["@RetornoSiNoCorreoNuevo"].Value);
        }
        /*PL20-1226*/
        //public int GetEsOfertaDelDia(int codCampania, string codConsultora, DateTime fechaInicioFact)
        //{
        //    DbCommand command = Context.Database.GetStoredProcCommand("dbo.GetEsOfertaDelDia");
        //    Context.Database.AddInParameter(command, "@CodCampania", DbType.Int32, codCampania);
        //    Context.Database.AddInParameter(command, "@CodConsultora", DbType.AnsiString, codConsultora);
        //    Context.Database.AddInParameter(command, "@FechaInicioFact", DbType.DateTime, fechaInicioFact);

        //    return Convert.ToInt16(Context.ExecuteScalar(command));
        //}

        //EPD-1836
        public int InsUsuarioPostulante(BEUsuarioPostulante entidad)
        {
            DbCommand command = Context.Database.GetStoredProcCommand("dbo.InsUsuarioPostulante");
            Context.Database.AddInParameter(command, "@CodigoUsuario", DbType.AnsiString, entidad.CodigoUsuario);
            //Context.Database.AddInParameter(command, "@NombreCompleto", DbType.AnsiString, entidad.NombreCompleto);
            //Context.Database.AddInParameter(command, "@TipoDocumento", DbType.AnsiString, entidad.TipoDocumento);
            //Context.Database.AddInParameter(command, "@NumeroDocumento", DbType.AnsiString, entidad.NumeroDocumento);
            Context.Database.AddInParameter(command, "@Zona", DbType.AnsiString, entidad.Zona);
            Context.Database.AddInParameter(command, "@Seccion", DbType.AnsiString, entidad.Seccion);
            //Context.Database.AddInParameter(command, "@Correo", DbType.AnsiString, entidad.Correo);
            Context.Database.AddInParameter(command, "@EnvioCorreo", DbType.AnsiString, entidad.EnvioCorreo);
            Context.Database.AddInParameter(command, "@UsuarioReal", DbType.AnsiString, entidad.UsuarioReal);

            return Context.ExecuteNonQuery(command);
        }

        public int DelUsuarioPostulante(string numeroDocumento)
        {
            DbCommand command = Context.Database.GetStoredProcCommand("dbo.DelUsuarioPostulante");
            //Context.Database.AddInParameter(command, "@Pais", DbType.AnsiString, Pais);
            Context.Database.AddInParameter(command, "@NumeroDocumento", DbType.AnsiString, numeroDocumento);

            return Context.ExecuteNonQuery(command);
        }

        //EPD-2058
        public IDataReader GetUsuarioPostulante(string numeroDocumento)
        {
            DbCommand command = Context.Database.GetStoredProcCommand("dbo.GetUsuarioPostulante");
            //Context.Database.AddInParameter(command, "@Pais", DbType.AnsiString, Pais);
            Context.Database.AddInParameter(command, "@NumeroDocumento", DbType.AnsiString, numeroDocumento);

            return Context.ExecuteReader(command);
        }
        
        /*EPD-1837*/
        public int InsUsuarioExterno(BEUsuarioExterno usuarioExterno)
        {
            DbCommand command = Context.Database.GetStoredProcCommand("dbo.InsUsuarioExterno");
            Context.Database.AddInParameter(command, "@CodigoUsuario", DbType.AnsiString, usuarioExterno.CodigoUsuario);
            Context.Database.AddInParameter(command, "@Proveedor", DbType.AnsiString, usuarioExterno.Proveedor);
            Context.Database.AddInParameter(command, "@IdAplicacion", DbType.AnsiString, usuarioExterno.IdAplicacion);
            Context.Database.AddInParameter(command, "@Login", DbType.AnsiString, usuarioExterno.Login);
            Context.Database.AddInParameter(command, "@Nombres", DbType.AnsiString, usuarioExterno.Nombres);
            Context.Database.AddInParameter(command, "@Apellidos", DbType.AnsiString, usuarioExterno.Apellidos);
            Context.Database.AddInParameter(command, "@FechaNacimiento", DbType.AnsiString, usuarioExterno.FechaNacimiento);
            Context.Database.AddInParameter(command, "@Correo", DbType.AnsiString, usuarioExterno.Correo);
            Context.Database.AddInParameter(command, "@Genero", DbType.AnsiString, usuarioExterno.Genero);
            Context.Database.AddInParameter(command, "@Ubicacion", DbType.AnsiString, usuarioExterno.Ubicacion);
            Context.Database.AddInParameter(command, "@LinkPerfil", DbType.AnsiString, usuarioExterno.LinkPerfil);
            Context.Database.AddInParameter(command, "@FotoPerfil", DbType.AnsiString, usuarioExterno.FotoPerfil);

            return Context.ExecuteNonQuery(command);
        }

        public IDataReader GetUsuarioExterno(string proveedor, string idAplicacion)
        {
            DbCommand command = Context.Database.GetStoredProcCommand("dbo.GetUsuarioExterno");
            Context.Database.AddInParameter(command, "@Proveedor", DbType.AnsiString, proveedor);
            Context.Database.AddInParameter(command, "@IdAplicacion", DbType.AnsiString, idAplicacion);

            return Context.ExecuteReader(command);
        }

        public bool GetExisteEmailActivo(string email)
        {
            DbCommand command = Context.Database.GetStoredProcCommand("dbo.GetExisteEmailActivo");
            Context.Database.AddInParameter(command, "@Email", DbType.AnsiString, email);

            return Convert.ToBoolean(Context.ExecuteScalar(command));
        }

        
        public IDataReader GetListaLoginExterno(string codigoUsuario)
        {
            DbCommand command = Context.Database.GetStoredProcCommand("dbo.GetListaLoginExterno");
            Context.Database.AddInParameter(command, "@CodigoUsuario", DbType.AnsiString, codigoUsuario);

            return Context.ExecuteReader(command);
        }
        /*EPD-1837*/

        public int UpdatePostulanteMensajes(string CodigoUsuario, int tipo)
        {
            DbCommand command = Context.Database.GetStoredProcCommand("dbo.UpdatePostulanteMensajes");
            Context.Database.AddInParameter(command, "@CodigoUsuario", DbType.AnsiString, CodigoUsuario);
            Context.Database.AddInParameter(command, "@Tipo", DbType.AnsiString, tipo);
            return Convert.ToInt32(Context.ExecuteScalar(command));
        }
    }
}
