using Portal.Consultoras.BizLogic;
using Portal.Consultoras.BizLogic.CDR;
using Portal.Consultoras.Common;
using Portal.Consultoras.Entities;
using Portal.Consultoras.ServiceContracts;
using System;
using System.Collections.Generic;
using System.Linq;

namespace Portal.Consultoras.Service
{
    public class UsuarioService : IUsuarioService
    {
        private readonly IUsuarioBusinessLogic _usuarioBusinessLogic;

        public UsuarioService() : this(new BLUsuario())
        {

        }

        public UsuarioService(IUsuarioBusinessLogic usuarioBusinessLogic)
        {
            _usuarioBusinessLogic = usuarioBusinessLogic;
        }

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

        public int UpdUsuarioRechazarInvitacion(int PaisID,  string CodigoUsuario)
        {
            var BLUsuario = new BLUsuario();
            return BLUsuario.UpdUsuarioRechazarInvitacion(PaisID, CodigoUsuario);
        }

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

        public BEUsuario GetSesionUsuarioWS(int paisID, string codigoUsuario)
        {
            return _usuarioBusinessLogic.GetSesionUsuarioWS(paisID, codigoUsuario);
        }

        public string GetUsuarioAsociado(int paisID, string codigoUsuario)
        {
            var BLUsuario = new BLUsuario();
            return BLUsuario.GetUsuarioAsociado(paisID, codigoUsuario);
        }

        public string GetUsuarioPermisos(int paisID, string codigoUsuario, string codigoConsultora, short tipoUsuario, short rolID)
        {
            var BLUsuario = new BLUsuario();
            return BLUsuario.GetUsuarioPermisos(paisID, codigoUsuario, codigoConsultora, tipoUsuario, rolID);
        }

        public bool IsUserExist(int paisID, string CodigoUsuario)
        {
            var BLUsuario = new BLUsuario();
            return BLUsuario.IsUserExist(paisID, CodigoUsuario);
        }

        public string IsConsultoraExist(int paisID, string CodigoConsultora)
        {
            var BLUsuario = new BLUsuario();
            return BLUsuario.IsConsultoraExist(paisID, CodigoConsultora);
        }

        public bool ChangePasswordUser(int paisID, string codigoUsuarioAutenticado, string emailCodigoUsuarioModificado, string password, string emailUsuarioModificado, EAplicacionOrigen origen)
        {
            var BLUsuario = new BLUsuario();
            return BLUsuario.ChangePasswordUser(paisID, codigoUsuarioAutenticado, emailCodigoUsuarioModificado, password, emailUsuarioModificado, origen);
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

        public void InsLogIngresoPortal(int paisID, string CodigoConsultora, string IPOrigen, byte Tipo, string DetalleError, string Canal)
        {
            var BLUsuario = new BLUsuario();
            BLUsuario.InsLogIngresoPortal(paisID, CodigoConsultora, IPOrigen, Tipo, DetalleError, Canal);
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

        public IList<BENotificaciones> GetNotificacionesConsultora(int PaisID, long ConsultoraId, int indicadorBloqueoCDR)
        {
            var BLNotificaciones = new BLNotificaciones();
            return BLNotificaciones.GetNotificacionesConsultora(PaisID, ConsultoraId, indicadorBloqueoCDR);
        }

        public int GetNotificacionesSinLeer(int PaisID, long ConsultoraId, int indicadorBloqueoCDR)
        {
            var BLNotificaciones = new BLNotificaciones();
            return BLNotificaciones.GetNotificacionesSinLeer(PaisID, ConsultoraId, indicadorBloqueoCDR);
        }       

        public IList<BENotificacionesDetalle> GetNotificacionesConsultoraDetalle(int PaisID, long ValAutomaticaPROLLogId, int TipoOrigen)
        {
            var BLNotificaciones = new BLNotificaciones();
            return BLNotificaciones.GetNotificacionesConsultoraDetalle(PaisID, ValAutomaticaPROLLogId, TipoOrigen);
        }

        public IList<BENotificacionesDetallePedido> GetNotificacionesConsultoraDetallePedido(int PaisID, long ValAutomaticaPROLLogId, int TipoOrigen)
        {
            var BLNotificaciones = new BLNotificaciones();
            return BLNotificaciones.GetNotificacionesConsultoraDetallePedido(PaisID, ValAutomaticaPROLLogId, TipoOrigen);
        }


        public IList<BEMisPedidos> GetMisPedidosConsultoraOnline(int PaisID, long ConsultoraId, int Campania)
        {
            var BLMisPedidos = new BLConsultoraOnline();
            return BLMisPedidos.GetMisPedidos(PaisID, ConsultoraId, Campania);
        }

        public IList<BEMisPedidosDetalle> GetMisPedidosDetalleConsultoraOnline(int PaisID, long PedidoID)
        {
            var BLMisPedidos = new BLConsultoraOnline();
            return BLMisPedidos.GetMisPedidosDetalle(PaisID, PedidoID);
        }

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

        public IList<BEMisPedidos> GetMisPedidosClienteOnline(int paisID, long consultoraId, int campania)
        {
            return new BLConsultoraOnline().GetMisPedidosClienteOnline(paisID, consultoraId, campania);
        }

        public BEMisPedidos GetPedidoClienteOnlineBySolicitudClienteId(int paisID, long solicitudClienteId)
        {
            return new BLConsultoraOnline().GetPedidoClienteOnlineBySolicitudClienteId(paisID, solicitudClienteId);
        }

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

        public IList<BENotificacionesDetallePedido> GetValidacionStockProductos(int PaisID, long ConsultoraId, long ValAutomaticaPROLLogId)
        {
            var BLNotificaciones = new BLNotificaciones();
            return BLNotificaciones.GetValidacionStockProductos(PaisID, ConsultoraId, ValAutomaticaPROLLogId);
        }

        public String GetFechaPromesaCronogramaByCampania(int PaisID, int CampaniaId, string CodigoConsultora, DateTime Fechafact)
        {
            var BLNotificaciones = new BLNotificaciones();
            return BLNotificaciones.GetFechaPromesaCronogramaByCampania(PaisID, CampaniaId, CodigoConsultora, Fechafact);
        }

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

        public void UpdNotificacionSolicitudClienteVisualizacion(int paisID, long SolicitudClienteId)
        {
            var BLNotificaciones = new BLNotificaciones();
            BLNotificaciones.UpdNotificacionSolicitudClienteVisualizacion(paisID, SolicitudClienteId);
        }

        #region Miembros de IUsuarioService

        public List<BEUsuario> ObtenerResultadoEncuesta(int paisID, int campaniaInicio, int campaniaFin)
        {
            return new BLUsuario().ObtenerResultadoEncuesta(paisID, campaniaInicio, campaniaFin);
        }
        #endregion

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

        public BEValidaLoginSB2 GetValidarLoginSB2(int paisID, string codigoUsuario, string contrasenia)
        {
            var BLUsuario = new BLUsuario();
            return BLUsuario.GetValidarLoginSB2(paisID, codigoUsuario, contrasenia);
        }

        public BEValidaLoginSB2 GetValidarAutoLogin(int paisID, string codigoUsuario, string proveedor)
        {
            var BLUsuario = new BLUsuario();
            return BLUsuario.GetValidarAutoLogin(paisID, codigoUsuario, proveedor);
        }

        public int InsUsuarioExternoPais(int paisID, BEUsuarioExternoPais entidad)
        {
            var BLUsuario = new BLUsuario();
            return BLUsuario.InsUsuarioExternoPais(paisID, entidad);
        }

        public bool CambiarClaveUsuario(int paisId, string paisIso, string codigoUsuario, string nuevacontrasena, string correo, string codigoUsuarioAutenticado, EAplicacionOrigen origen)
        {
            var BLUsuario = new BLUsuario();
            return BLUsuario.CambiarClaveUsuario(paisId, paisIso, codigoUsuario, nuevacontrasena, correo, codigoUsuarioAutenticado, origen);
        }

        ///<summary>
        ///Verifica si existe el usuario con/sin el ingreso de la clave  
        ///</summary>
        ///<param name="paisId">
        /// Id del Pais del Usuario
        /// </param>
        /// <param name="codigoUsuario">
        /// Codigo de Usuario
        /// </param>
        /// <param name="clave">
        /// Clave del Usuario a validar (sin encriptar) o valor vacio (no valida con la clave)
        /// </param> 
        /// <returns>
        /// 0: no existe; 1: existe pero la clave es diferente; 2: existe con/sin validacion de clave
        /// </returns>
        public int ExisteUsuario(int paisId, string codigoUsuario, string clave)
        {
            var BLUsuario = new BLUsuario();
            return BLUsuario.ExisteUsuario(paisId, codigoUsuario, clave);
        }

        ///<summary>
        ///Verifica si el usuario existe con la clave correcta.       
        ///</summary>
        ///<param name="paisIso">
        /// Prefijo del Pais del Usuario
        /// </param>
        /// <param name="codigoUsuario">
        /// Codigo de Usuario o Email
        /// </param>
        /// <param name="clave">
        /// Clave del Usuario a validar (sin encriptar)
        /// </param>      
        public bool ValidarUsuario(string paisIso, string codigoUsuario, string clave)
        {
            int paisId = Util.GetPaisID(paisIso);

            var BLUsuario = new BLUsuario();
            return BLUsuario.ValidarUsuario(paisId, codigoUsuario, clave);
        }

        public List<BEConfiguracionPais> GetConfiguracionPais(BEConfiguracionPais entidad)
        {
            var bl = new BLConfiguracionPais();
            return bl.GetList(entidad);
        }

        public bool ValidarConfiguracionPaisDetalle(BEConfiguracionPaisDetalle entidad)
        {
            var bl = new BLConfiguracionPaisDetalle();
            return bl.Validar(entidad);
        }
        
        public List<BEConfiguracionPaisDatos> GetConfiguracionPaisDatos(BEConfiguracionPaisDatos entidad)
        {
            var bl = new BLConfiguracionPaisDatos();
            return bl.GetList(entidad);
        }

        public int RegistrarUsuarioPostulante(string paisISO, BEUsuarioPostulante entidad)
        {
            int paisID = GetPaisID(paisISO);
            var BLUsuario = new BLUsuario();
            return BLUsuario.InsUsuarioPostulante(paisID, paisISO, entidad);
        }
        
        public string RecuperarContrasenia(int paisId, string correo)
        {
            var BLUsuario = new BLUsuario();
            return BLUsuario.RecuperarContrasenia(paisId, correo);
        }

        public string ActualizarMisDatos(BEUsuario usuario, string CorreoAnterior)
        {
            var BLUsuario = new BLUsuario();
            return BLUsuario.ActualizarMisDatos(usuario, CorreoAnterior);
        }

        public string AceptarContrato(BEUsuario usuario)
        {
            var BLUsuario = new BLUsuario();
            return BLUsuario.AceptarContratoColombia(usuario);
        }

        public int EliminarUsuarioPostulante(string paisISO, string numeroDocumento)
        {
            int paisID = GetPaisID(paisISO);
            var BLUsuario = new BLUsuario();
            return BLUsuario.DelUsuarioPostulante(paisID, numeroDocumento);
        }

        public BEUsuarioPostulante GetUsuarioPostulante(int paisID, string numeroDocumento)
        {
            var BLUsuario = new BLUsuario();
            return BLUsuario.GetUsuarioPostulante(paisID, numeroDocumento);
        }

        public int InsertUsuarioExterno(int paisID, BEUsuarioExterno usuarioExterno)
        {
            var BLUsuario = new BLUsuario();
            return BLUsuario.InsertUsuarioExterno(paisID, usuarioExterno);
        }

        public BEUsuarioExterno GetUsuarioExternoByCodigoUsuario(int paisID, string codigoUsuario)
        {
            var BLUsuario = new BLUsuario();
            return BLUsuario.GetUsuarioExternoByCodigoUsuario(paisID, codigoUsuario);
        }

        public BEUsuarioExterno GetUsuarioExternoByProveedorAndIdApp(string proveedor, string idAplicacion, string fotoPerfil)
        {
            BLUsuario obj_Usuario = new BLUsuario();
            return obj_Usuario.GetUsuarioExternoByProveedorAndIdApp(proveedor, idAplicacion, fotoPerfil);
        }

        public List<BEUsuarioExterno> GetListaLoginExterno(int paisID, string codigoUsuario)
        {
            var BLUsuario = new BLUsuario();
            return BLUsuario.GetListaLoginExterno(paisID, codigoUsuario);
        }

        public BEUsuarioConfiguracion ObtenerUsuarioConfiguracion(int paisID, int consultoraID, int campania, bool usuarioPrueba,
            int aceptacionConsultoraDA)
        {
            return new BLUsuario().ObtenerUsuarioConfiguracion(paisID, consultoraID, campania, usuarioPrueba,
                aceptacionConsultoraDA);
        }

        public void UpdatePosutlanteMensajes(int paisID, string codigoUsuario, int tipo)
        {
            var BLUsuario = new BLUsuario();
            BLUsuario.UpdatePostulantesMensajes(paisID, codigoUsuario, tipo);
        }

        #region TerminosCondiciones
        public bool InsertTerminosCondiciones(BETerminosCondiciones terminos)
        {
            return _usuarioBusinessLogic.InsertTerminosCondiciones(terminos);
        }
        public bool InsertTerminosCondicionesMasivo(int paisID, List<BETerminosCondiciones> terminos)
        {
            return _usuarioBusinessLogic.InsertTerminosCondicionesMasivo(paisID, terminos);
        }
        #endregion

        #region EventoFestivo
        public IList<BEEventoFestivo> GetEventoFestivo(int paisID, string Alcance, int Campania)
        {
            var BLUsuario = new BLUsuario();
            return BLUsuario.GetEventoFestivo(paisID, Alcance, Campania);
        }
        #endregion

        public int UpdUsuarioFotoPerfil(int paisID, string codigoUsuario, string fileName)
        {
            return _usuarioBusinessLogic.UpdUsuarioFotoPerfil(paisID, codigoUsuario, fileName);
        }
    }
}
