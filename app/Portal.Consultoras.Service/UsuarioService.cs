using Portal.Consultoras.BizLogic;
using Portal.Consultoras.Entities;
using Portal.Consultoras.ServiceContracts;
using System;
using System.Collections.Generic;
using System.Linq;
using Portal.Consultoras.BizLogic.CDR;
using Portal.Consultoras.Entities.CDR;

namespace Portal.Consultoras.Service
{
    public class UsuarioService : IUsuarioService
    {
        public BEUsuario Select(int paisID, string codigoUsuario)
        {
            var BLUsuario = new BLUsuario();
            return BLUsuario.Select(paisID, codigoUsuario);
        }

        public BEConsultoraDatos GetDatosConsultora(int paisID, string codigoUsuario)
        {
            var BLUsuario = new BLUsuario();
            return BLUsuario.GetDatosConsultora(paisID, codigoUsuario);
        }

        public List<BEUsuario> SelectByNombre(int paisID, string Nombre)
        {
            var BLUsuario = new BLUsuario();
            return BLUsuario.SelectByNombre(paisID, Nombre);
        }

        public List<BEUsuarioRol> SelectUsuarioRol(int paisID, string RolDescripcion, string NombreUsuario)
        {
            var BLUsuario = new BLUsuario();
            return BLUsuario.SelectUsuarioRol(paisID, RolDescripcion, NombreUsuario);
        }

        public List<BEUsuarioCorreo> SelectByEmail(string Email, int PaisID)
        {
            var BLUsuario = new BLUsuario();
            return BLUsuario.SelectByEmail(Email, PaisID);
        }

        public int DelUsuarioRol(int paisID, string codigoUsuario, int RolID)
        {
            var BLUsuario = new BLUsuario();

            return BLUsuario.DelUsuarioRol(paisID, codigoUsuario, RolID);
        }

        public int setUsuarioVideoIntroductorio(int paisID, string codigoUsuario)
        {
            var BLUsuario = new BLUsuario();

            return BLUsuario.setUsuarioVideoIntroductorio(paisID, codigoUsuario);
        }

        public int setUsuarioVerTutorial(int paisID, string codigoUsuario)
        {
            var BLUsuario = new BLUsuario();

            return BLUsuario.setUsuarioVerTutorial(paisID, codigoUsuario);
        }

        public int SetUsuarioVerTutorialDesktop(int paisID, string codigoUsuario)
        {
            var BLUsuario = new BLUsuario();
            return BLUsuario.SetUsuarioVerTutorialDesktop(paisID, codigoUsuario);
        }

        public void Insert(BEUsuario usuario)
        {
            var BLUsuario = new BLUsuario();
            BLUsuario.Insert(usuario);
        }

        public void Update(BEUsuario usuario)
        {
            var BLUsuario = new BLUsuario();
            BLUsuario.Update(usuario);
        }

        //1796 Inicio
        public int UpdUsuarioRechazarInvitacion(int PaisID,  string CodigoUsuario)
        {
            var BLUsuario = new BLUsuario();
            return BLUsuario.UpdUsuarioRechazarInvitacion(PaisID, CodigoUsuario);
        }
        //1796 Fin

        public void UpdateDatos(BEUsuario usuario, string CorreoAnterior)
        {
            var BLUsuario = new BLUsuario();
            BLUsuario.UpdateDatos(usuario, CorreoAnterior);
        }

        public int UpdateDatosPrimeraVez(int paisID, string codigoUsuario, string email, string telefono, string telefonoTrabajo, string celular, string correoAnterior, bool aceptoContrato)
        {
            var BLUsuario = new BLUsuario();
            return BLUsuario.UpdateDatosPrimeraVez(paisID, codigoUsuario, email, telefono, telefonoTrabajo, celular, correoAnterior, aceptoContrato);
        }

        public void UpdatePassword(int paisID, string codigoUsuario, string claveSecreta, bool cambioClave)
        {
            var BLUsuario = new BLUsuario();
            BLUsuario.UpdatePassword(paisID, codigoUsuario, claveSecreta, cambioClave);
        }

        public BEDupla SelectDupla(int paisID, string codigoUsuario)
        {
            var BLDupla = new BLDupla();
            return BLDupla.Select(paisID, codigoUsuario);
        }

        public void InsertDupla(BEDupla dupla)
        {
            var BLDupla = new BLDupla();
            BLDupla.Insert(dupla);
        }

        public void UpdateDupla(BEDupla dupla)
        {
            var BLDupla = new BLDupla();
            BLDupla.Update(dupla);
        }

        public bool ActiveEmail(int paisID, string codigoUsuario, string iso, string email)
        {
            var BLUsuario = new BLUsuario();
            return BLUsuario.ActiveEmail(paisID, codigoUsuario, iso, email);
        }


        public BEUsuario GetSesionUsuario(int paisID, string codigoUsuario)
        {
            var BLUsuario = new BLUsuario();
            return BLUsuario.GetSesionUsuario(paisID, codigoUsuario);
        }

        public string GetUsuarioAsociado(int paisID, string codigoUsuario)
        {
            var BLUsuario = new BLUsuario();
            return BLUsuario.GetUsuarioAsociado(paisID, codigoUsuario);
        }

        public bool IsUserExist(string CodigoUsuario)
        {
            var BLUsuario = new BLUsuario();
            return BLUsuario.IsUserExist(CodigoUsuario);
        }

        public bool ChangePasswordUser(int paisID, string codigoUsuarioAutenticado, string emailCodigoUsuarioModificado, string password, string emailUsuarioModificado, EAplicacionOrigen origen)
        {
            var BLUsuario = new BLUsuario();
            return BLUsuario.ChangePasswordUser(paisID, codigoUsuarioAutenticado, emailCodigoUsuarioModificado, password, emailUsuarioModificado, origen);
        }

        public string GetUserUPN(string Email)
        {
            var BLUsuario = new BLUsuario();
            return BLUsuario.GetUserUPN(Email);
        }

        public int ValidateUserCredentialsActiveDirectory(int paisID, string codigoUsuarioAutenticado, string codigoUsuarioModificado, string OldPassword, string NewPassword)
        {
            var BLUsuario = new BLUsuario();
            return BLUsuario.ValidateUserCredentialsActiveDirectory(paisID, codigoUsuarioAutenticado, codigoUsuarioModificado, OldPassword, NewPassword);
        }

        public int UpdUsuarioDatosPrimeraVezEstado(int PaisID, string CodigoUsuario)
        {
            var BLUsuario = new BLUsuario();
            return BLUsuario.UpdUsuarioDatosPrimeraVezEstado(PaisID, CodigoUsuario);
        }

        public int ValidarEmailConsultora(int PaisID, string Email, string CodigoUsuario)
        {
            var BLUsuario = new BLUsuario();
            return BLUsuario.ValidarEmailConsultora(PaisID, Email, CodigoUsuario);
        }

        public int ValidarTelefonoConsultora(int PaisID, string Telefono, string CodigoUsuario)
        {
            var BLUsuario = new BLUsuario();
            return BLUsuario.ValidarTelefonoConsultora(PaisID, Telefono, CodigoUsuario);
        }

        public List<int> GetEstadosRestringidos(int paisID)
        {
            var BLUsuario = new BLUsuario();
            return BLUsuario.GetEstadosRestringidos(paisID);
        }

        public int UpdActualizarDatos(int paisID, string CodigoUsuario, string Email, string Celular, string Telefono)
        {
            var BLUsuario = new BLUsuario();
            return BLUsuario.UpdActualizarDatos(paisID, CodigoUsuario, Email, Celular, Telefono);
        }

        public string GetNroDocumentoConsultora(int paisID, string CodigoConsultora)
        {
            var BLUsuario = new BLUsuario();
            return BLUsuario.GetNroDocumentoConsultora(paisID, CodigoConsultora);
        }
        public List<BEKitNueva> GetValidarConsultoraNueva(int paisID, string CodigoConsultora)
        {
            var BLUsuario = new BLUsuario();
            return BLUsuario.GetValidarConsultoraNueva(paisID, CodigoConsultora);
        }

        public bool CreateActiveDirectoryUser(string login, string alias, string firstname, string lastname, string PaisISO, string Clave)
        {
            var BLUsuario = new BLUsuario();
            return BLUsuario.CreateActiveDirectoryUser(login, alias, firstname, lastname, PaisISO, Clave);
        }

        public int ValidarUsuarioPrueba(string CodigoUsuario, int paisID)
        {
            var BLUsuario = new BLUsuario();
            return BLUsuario.ValidarUsuarioPrueba(CodigoUsuario, paisID);
        }

        public int ValidarEnvioCatalogo(int paisID, string CodigoConsultora, int CampaniaActual, int Cantidad)
        {
            var BLUsuario = new BLUsuario();
            return BLUsuario.ValidarEnvioCatalogo(paisID, CodigoConsultora, CampaniaActual, Cantidad);
        }

        public int GetValidarColaboradorZona(int paisID, string CodigoZona)
        {
            var BLUsuario = new BLUsuario();
            return BLUsuario.GetValidarColaboradorZona(paisID, CodigoZona);
        }

        public DateTime GetFechaFacturacion(string CampaniaCodigo, int ZonaID, int PaisID)
        {
            var BLUsuario = new BLUsuario();
            return BLUsuario.GetFechaFacturacion(CampaniaCodigo, ZonaID, PaisID);
        }

        public void UpdateIndicadorAyudaWebTracking(int paisID, string codigoConsultora, bool indicador)
        {
            var BLUsuario = new BLUsuario();
            BLUsuario.UpdateIndicadorAyudaWebTracking(paisID, codigoConsultora, indicador);
        }

        public void InsLogIngresoPortal(int paisID, string CodigoConsultora, string IPOrigen, byte Tipo, string DetalleError)
        {
            var BLUsuario = new BLUsuario();
            BLUsuario.InsLogIngresoPortal(paisID, CodigoConsultora, IPOrigen, Tipo, DetalleError);
        }
        public int AceptarContratoAceptacion(int paisID, long consultoraid, string codigoConsultora)
        {
            var BLContratoAceptacion = new BLContratoAceptacion();
            return BLContratoAceptacion.AceptarContratoAceptacion(paisID, consultoraid, codigoConsultora);
        }

        public BEUsuario GetSesionUsuarioLoginDD(int paisID, string codigoUsuario, string claveSecreta)
        {
            var BLUsuario = new BLUsuario();
            return BLUsuario.GetSesionUsuarioLoginDD(paisID, codigoUsuario, claveSecreta);
        }

        public IList<BEUsuario> GetUsuarioDigitadorByFfVv(int paisID, string codigoFfvv)
        {
            var BLUsuario = new BLUsuario();
            return BLUsuario.GetUsuarioDigitadorByFfVv(paisID, codigoFfvv);
        }

        public void UpdUsuarioDigitador(BEUsuario usuario)
        {
            var BLUsuario = new BLUsuario();
            BLUsuario.UpdUsuarioDigitador(usuario);
        }

        public BEUsuario GetSesionUsuarioLoginDDByRol(int paisID, int rolID, string email)
        {
            var BLUsuario = new BLUsuario();
            return BLUsuario.GetSesionUsuarioLoginDDByRol(paisID, rolID, email);
        }

        public IList<BEUsuario> GetUsuario(int paisID, int rol, string codigoUsuario, string codigoFFVV, string nombres, bool estado)
        {
            var BLUsuario = new BLUsuario();
            return BLUsuario.GetUsuario(paisID, rol, codigoUsuario, codigoFFVV, nombres, estado);
        }

        public void UpdUsuarioDD(BEUsuario usuario)
        {
            var BLUsuario = new BLUsuario();
            BLUsuario.UpdUsuarioDD(usuario);
        }

        //CCSS_JZ_PROL2
        public IList<BENotificaciones> GetNotificacionesConsultora(int PaisID, long ConsultoraId, int indicadorBloqueoCDR)
        {
            var BLNotificaciones = new BLNotificaciones();
            return BLNotificaciones.GetNotificacionesConsultora(PaisID, ConsultoraId, indicadorBloqueoCDR);
        }

        //R2073
        public IList<BENotificacionesDetalle> GetNotificacionesConsultoraDetalle(int PaisID, long ValAutomaticaPROLLogId, int TipoOrigen)
        {
            var BLNotificaciones = new BLNotificaciones();
            return BLNotificaciones.GetNotificacionesConsultoraDetalle(PaisID, ValAutomaticaPROLLogId, TipoOrigen);
        }

        //R2073
        public IList<BENotificacionesDetallePedido> GetNotificacionesConsultoraDetallePedido(int PaisID, long ValAutomaticaPROLLogId, int TipoOrigen)
        {
            var BLNotificaciones = new BLNotificaciones();
            return BLNotificaciones.GetNotificacionesConsultoraDetallePedido(PaisID, ValAutomaticaPROLLogId, TipoOrigen);
        }


        //ConsultoraOnline
        //public IList<BEMisPedidos> GetNotificacionesConsultoraOnlineCab(int PaisID, long ConsultoraId)
        public IList<BEMisPedidos> GetMisPedidosConsultoraOnline(int PaisID, long ConsultoraId, int Campania)
        {
            var BLMisPedidos = new BLConsultoraOnline();
            //return BLMisPedidos.GetMisPedidos(PaisID, ConsultoraId);
            return BLMisPedidos.GetMisPedidos(PaisID, ConsultoraId, Campania);
        }

        public IList<BEMisPedidosDetalle> GetMisPedidosDetalleConsultoraOnline(int PaisID, long PedidoID)
        {
            var BLMisPedidos = new BLConsultoraOnline();
            return BLMisPedidos.GetMisPedidosDetalle(PaisID, PedidoID);
        }

        /* SB20-463 - INICIO */
        public int GetCantidadSolicitudesPedido(int PaisID, long ConsultoraId, int Campania)
        {
            var BLMisPedidos = new BLConsultoraOnline();
            return BLMisPedidos.GetCantidadSolicitudesPedido(PaisID, ConsultoraId, Campania);
        }

        public string GetSaldoHorasSolicitudesPedido(int PaisID, long ConsultoraId, int Campania)
        {
            var BLMisPedidos = new BLConsultoraOnline();
            return BLMisPedidos.GetSaldoHorasSolicitudesPedido(PaisID, ConsultoraId, Campania);
        }

        /* SB20-463 - FIN */

        public IList<BEMisPedidos> GetMisPedidosClienteOnline(int paisID, long consultoraId, int campania)
        {
            return new BLConsultoraOnline().GetMisPedidosClienteOnline(paisID, consultoraId, campania);
        }

        public BEMisPedidos GetPedidoClienteOnlineBySolicitudClienteId(int paisID, long solicitudClienteId)
        {
            return new BLConsultoraOnline().GetPedidoClienteOnlineBySolicitudClienteId(paisID, solicitudClienteId);
        }

        //R2073
        public void UpdNotificacionesConsultoraVisualizacion(int PaisID, long ValAutomaticaPROLLogId, int TipoOrigen)
        {
            var BLNotificaciones = new BLNotificaciones();
            BLNotificaciones.UpdNotificacionesConsultoraVisualizacion(PaisID, ValAutomaticaPROLLogId, TipoOrigen);
        }

        public BEConsultoraDatoSAC DatoConsultoraSAC(string paisID, string codigoConsultora, string documento)
        {
            var BLUsuario = new BLConsultora();
            BEConsultoraDatoSAC consultoraDato = BLUsuario.GetConsultoraDatoSAC(paisID, codigoConsultora, documento);
            return consultoraDato;
        }

        public BEConsultoraEstadoSAC ConsultoraEstadoSAC(string paisID, string codigoConsultora)
        {
            var BLUsuario = new BLConsultora();
            BEConsultoraEstadoSAC consultoraEstado = BLUsuario.GetConsultoraEstadoSAC(paisID, codigoConsultora);
            return consultoraEstado;
        }

        //RQ_NS - R2133
        public IList<BENotificacionesDetallePedido> GetValidacionStockProductos(int PaisID, long ConsultoraId, long ValAutomaticaPROLLogId)
        {
            var BLNotificaciones = new BLNotificaciones();
            return BLNotificaciones.GetValidacionStockProductos(PaisID, ConsultoraId, ValAutomaticaPROLLogId);
        }

        //RQ_FP - R2161
        public String GetFechaPromesaCronogramaByCampania(int PaisID, int CampaniaId, string CodigoConsultora, DateTime Fechafact)
        {
            var BLNotificaciones = new BLNotificaciones();
            return BLNotificaciones.GetFechaPromesaCronogramaByCampania(PaisID, CampaniaId, CodigoConsultora, Fechafact);
        }

        //R2116
        public int UpdateDatosPrimeraVezMexico(int PaisID, string CodigoUsuario, string Nombre, string Apellidos, string Telefono, string TelefonoTrabajo, string Celular, string Email, long IdConsultora, string CodigoConsultora, int CampaniaID_Actual, int CampaniaID_UltimaF, int RegionID, int ZonaID, string EmailAnterior)
        {
            var BLUsuario = new BLUsuario();
            return BLUsuario.UpdateDatosPrimeraVezMexico(PaisID, CodigoUsuario, Nombre, Apellidos, Telefono, TelefonoTrabajo, Celular, Email, IdConsultora, CodigoConsultora, CampaniaID_Actual, CampaniaID_UltimaF, RegionID, ZonaID, EmailAnterior);
        }
        public int SelectDatosActualizados(int paisID, string codigoUsuario)
        {
            var DAUsuario = new BLUsuario();
            if (DAUsuario.SelectDatosActualizados(paisID, codigoUsuario) == 0)
                return 0;
            else
                return 1;

        }
        public int SelectSegmento(int paisID, int segmentoID)
        {
            var DAUsuario = new BLUsuario();
            if (DAUsuario.SelectSegmento(paisID, segmentoID) == 1)
                return 1;
            else
                return 0;

        }
        public int SelectTiempo(int paisID)
        {
            var DAUsuario = new BLUsuario();
            return DAUsuario.SelectTiempo(paisID);


        }
        //R2116

        /* R2392 - AHAA - LIDERES - INICIO */
        public int ValidarEstadoSubscripcion(string PaisISO, string CodigoUsuario, int NroDiasPermitidos)
        {
            int PaisID = GetPaisID(PaisISO);

            BLUsuario oBLUsuario = new BLUsuario();
            return oBLUsuario.ValidarEstadoSubscripcion(PaisID, CodigoUsuario, NroDiasPermitidos);
        }

        public BEUsuario ObtenerDatosPorUsuario(string PaisISO, string CodigoUsuario)
        {
            int PaisID = GetPaisID(PaisISO);

            BLUsuario oBLUsuario = new BLUsuario();
            return oBLUsuario.ObtenerDatosPorUsuario(PaisID, CodigoUsuario);
        }

        public int UpdUsuarioLider(string PaisISO, string CodigoUsuario, string Telefono, string Celular, string Email)
        {
            int PaisID = GetPaisID(PaisISO);

            BLUsuario oBLUsuario = new BLUsuario();
            return oBLUsuario.UpdUsuarioLider(PaisID, CodigoUsuario, Telefono, Celular, Email);
        }

        public int UpdCorreoUsuarioLider(string PaisISO, string CodigoUsuario, string Email)
        {
            int PaisID = GetPaisID(PaisISO);

            BLUsuario oBLUsuario = new BLUsuario();
            return oBLUsuario.UpdCorreoUsuarioLider(PaisID, CodigoUsuario, Email);
        }

        public int CancelarSubscripcion(string PaisISO, string email)
        {
            int PaisID = GetPaisID(PaisISO);

            BLUsuario oBLUsuario = new BLUsuario();
            return oBLUsuario.CancelarSubscripcion(PaisID, email);
        }

        public int ConfirmarSuscripcion(string PaisISO, string email)
        {
            int PaisID = GetPaisID(PaisISO);

            BLUsuario oBLUsuario = new BLUsuario();
            return oBLUsuario.ConfirmarSuscripcion(PaisID, email);
        }

        public List<BEUsuario> GenerarReporteSuscripcionLideres(string PaisISO, string TipoReporte)
        {
            int PaisID = GetPaisID(PaisISO);

            BLUsuario oBLUsuario = new BLUsuario();
            return oBLUsuario.GenerarReporteSuscripcionLideres(PaisID, TipoReporte);
        }
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
        /* R2392 - AHAA - LIDERES - FIN */

        //R2319
        public void UpdNotificacionSolicitudClienteVisualizacion(int paisID, long SolicitudClienteId)
        {
            var BLNotificaciones = new BLNotificaciones();
            BLNotificaciones.UpdNotificacionSolicitudClienteVisualizacion(paisID, SolicitudClienteId);
        }

        #region Miembros de IUsuarioService

        /* R2520 - JICM - LIDERES - INI */
        public List<BEUsuario> ObtenerResultadoEncuesta(int paisID, int campaniaInicio, int campaniaFin)
        {
            return new BLUsuario().ObtenerResultadoEncuesta(paisID, campaniaInicio, campaniaFin);
        }
        /* R2520 - JICM - LIDERES - FIN */
        #endregion

        /*R20150802 */
        public void UpdNotificacionSolicitudClienteCatalogoVisualizacion(int paisID, long SolicitudClienteCatalogoId)
        {
            var BLSolicitudClienteCatalogo = new BLSolicitudClienteCatalogo();
            BLSolicitudClienteCatalogo.UpdNotificacionSolicitudClienteCatalogoVisualizacion(paisID, SolicitudClienteCatalogoId);
        }

        public void UpdNotificacionPedidoRechazadoVisualizacion(int paisID, long procesoId)
        {
            var bLPedidoRechazado = new BLPedidoRechazado();
            bLPedidoRechazado.UpdatePedidoRechazadoVisualizado(paisID, procesoId);
        }

        public BENotificacionesDetalleCatalogo ObtenerDetalleNotificacion(int PaisID, long SolicitudClienteCatalogoId)
        {
            BLSolicitudClienteCatalogo SolicitudClienteCatalogo = new BLSolicitudClienteCatalogo();
            return SolicitudClienteCatalogo.ObtenerDetalleNotificacionCatalogo(PaisID, SolicitudClienteCatalogoId);
        }

        public int GetCantidadPedidosConsultoraOnline(int PaisID, long ConsultoraId)
        {
            BLConsultoraOnline BLConsultoraOnline = new BLConsultoraOnline();
            return BLConsultoraOnline.GetCantidadPedidosConsultoraOnline(PaisID, ConsultoraId);
        }

        public void GuardarContrasenia(string paisISO, string codigoUsuario, string contrasenia)
        {
            int paisID = GetPaisID(paisISO);

            BLUsuario BLUsuario = new BLUsuario();
            BLUsuario.GuardarContrasenia(paisID, codigoUsuario, contrasenia);
        }

        public int UpdateUsuarioTutoriales(int paisID, string codigoUsuario, int tipo)
        {
            var BLUsuario = new BLUsuario();
            return BLUsuario.UpdateUsuarioTutoriales(paisID, codigoUsuario, tipo);
        }

        public BEUsuario GetDatosConsultoraHana(int paisID, string codigoUsuario, int campaniaId)
        {
            var BLUsuario = new BLUsuario();
            return BLUsuario.GetDatosConsultoraHana(paisID, codigoUsuario, campaniaId);
        }

        public void UpdNotificacionSolicitudCdrVisualizacion(int paisID, long procesoId)
        {
            var bLLogCDRWeb = new BLLogCDRWeb();
            bLLogCDRWeb.UpdateVisualizado(paisID, procesoId);
        }

        public void UpdNotificacionCdrCulminadoVisualizacion(int paisID, long procesoId)
        {
            var bLLogCDRWebCulminado = new BLLogCDRWebCulminado();
            bLLogCDRWebCulminado.UpdateVisualizado(paisID, procesoId);
        }

        public int UpdateUsuarioEmailTelefono(int paisID, long ConsultoraID, string Email, string Telefono)
        {
            var BLUsuario = new BLUsuario();
            return BLUsuario.UpdateUsuarioEmailTelefono(paisID, ConsultoraID, Email, Telefono);
        }
    }
}
