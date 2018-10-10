using Portal.Consultoras.BizLogic;
using Portal.Consultoras.BizLogic.CDR;
using Portal.Consultoras.BizLogic.PagoEnlinea;
using Portal.Consultoras.Common;
using Portal.Consultoras.Entities;
using Portal.Consultoras.Entities.OpcionesVerificacion;
using Portal.Consultoras.Entities.Usuario;
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
            var blUsuario = new BLUsuario();
            return blUsuario.Select(paisID, codigoUsuario);
        }

        public BEConsultoraDatos GetDatosConsultora(int paisID, string codigoUsuario)
        {
            var blUsuario = new BLUsuario();
            return blUsuario.GetDatosConsultora(paisID, codigoUsuario);
        }

        public List<BEUsuario> SelectByNombre(int paisID, string Nombre)
        {
            var blUsuario = new BLUsuario();
            return blUsuario.SelectByNombre(paisID, Nombre);
        }

        public List<BEUsuarioRol> SelectUsuarioRol(int paisID, string RolDescripcion, string NombreUsuario)
        {
            var blUsuario = new BLUsuario();
            return blUsuario.SelectUsuarioRol(paisID, RolDescripcion, NombreUsuario);
        }

        public List<BEUsuarioCorreo> SelectByEmail(string Email, int PaisID)
        {
            var blUsuario = new BLUsuario();
            return blUsuario.SelectByEmail(Email, PaisID);
        }

        public int DelUsuarioRol(int paisID, string codigoUsuario, int RolID)
        {
            var blUsuario = new BLUsuario();
            return blUsuario.DelUsuarioRol(paisID, codigoUsuario, RolID);
        }

        public int setUsuarioVideoIntroductorio(int paisID, string codigoUsuario)
        {
            var blUsuario = new BLUsuario();
            return blUsuario.setUsuarioVideoIntroductorio(paisID, codigoUsuario);
        }

        public int setUsuarioVerTutorial(int paisID, string codigoUsuario)
        {
            var blUsuario = new BLUsuario();
            return blUsuario.setUsuarioVerTutorial(paisID, codigoUsuario);
        }

        public int SetUsuarioVerTutorialDesktop(int paisID, string codigoUsuario)
        {
            var blUsuario = new BLUsuario();
            return blUsuario.SetUsuarioVerTutorialDesktop(paisID, codigoUsuario);
        }

        public void Insert(BEUsuario usuario)
        {
            var blUsuario = new BLUsuario();
            blUsuario.Insert(usuario);
        }

        public void Update(BEUsuario usuario)
        {
            var blUsuario = new BLUsuario();
            blUsuario.Update(usuario);
        }

        public int UpdUsuarioRechazarInvitacion(int PaisID, string CodigoUsuario)
        {
            var blUsuario = new BLUsuario();
            return blUsuario.UpdUsuarioRechazarInvitacion(PaisID, CodigoUsuario);
        }

        public void UpdateDatos(BEUsuario usuario, string CorreoAnterior)
        {
            var blUsuario = new BLUsuario();
            blUsuario.UpdateDatos(usuario, CorreoAnterior);
        }

        public int UpdateDatosPrimeraVez(int PaisID, string CodigoUsuario, string Email, string Telefono, string TelefonoTrabajo, string Celular, string CorreoAnterior, bool AceptoContrato)
        {
            var blUsuario = new BLUsuario();
            return blUsuario.UpdateDatosPrimeraVez(PaisID, CodigoUsuario, Email, Telefono, TelefonoTrabajo, Celular, CorreoAnterior, AceptoContrato);
        }

        public void UpdatePassword(int paisID, string codigoUsuario, string claveSecreta, bool cambioClave)
        {
            var blUsuario = new BLUsuario();
            blUsuario.UpdatePassword(paisID, codigoUsuario, claveSecreta, cambioClave);
        }

        public BEDupla SelectDupla(int paisID, string codigoUsuario)
        {
            var blDupla = new BLDupla();
            return blDupla.Select(paisID, codigoUsuario);
        }

        public void InsertDupla(BEDupla dupla)
        {
            var blDupla = new BLDupla();
            blDupla.Insert(dupla);
        }

        public void UpdateDupla(BEDupla dupla)
        {
            var blDupla = new BLDupla();
            blDupla.Update(dupla);
        }

        public bool ActiveEmail(int paisID, string codigoUsuario, string iso, string email)
        {
            var blUsuario = new BLUsuario();
            return blUsuario.ActiveEmail(paisID, codigoUsuario, iso, email);
        }

        public BERespuestaActivarEmail ActivarEmail(int paisID, string codigoConsultora, string email)
        {
            return new BLUsuario().ActivarEmail(paisID, codigoConsultora, email);
        }

        public BEUsuario GetSesionUsuario(int paisID, string codigoUsuario)
        {
            var blUsuario = new BLUsuario();
            return blUsuario.GetSesionUsuario(paisID, codigoUsuario);
        }

        public BEUsuario GetSesionUsuarioWS(int paisID, string codigoUsuario)
        {
            return _usuarioBusinessLogic.GetSesionUsuarioWS(paisID, codigoUsuario);
        }

        public string GetUsuarioAsociado(int paisID, string CodigoConsultora)
        {
            var blUsuario = new BLUsuario();
            return blUsuario.GetUsuarioAsociado(paisID, CodigoConsultora);
        }

        public string GetUsuarioPermisos(int paisID, string codigoUsuario, string codigoConsultora, short tipoUsuario, short rolID)
        {
            var blUsuario = new BLUsuario();
            return blUsuario.GetUsuarioPermisos(paisID, codigoUsuario, codigoConsultora, tipoUsuario, rolID);
        }

        public bool IsUserExist(int paisID, string CodigoUsuario)
        {
            var blUsuario = new BLUsuario();
            return blUsuario.IsUserExist(paisID, CodigoUsuario);
        }

        public string IsConsultoraExist(int paisID, string CodigoConsultora)
        {
            var blUsuario = new BLUsuario();
            return blUsuario.IsConsultoraExist(paisID, CodigoConsultora);
        }

        public bool ChangePasswordUser(int paisID, string codigoUsuarioAutenticado, string emailCodigoUsuarioModificado, string password, string emailUsuarioModificado, EAplicacionOrigen origen)
        {
            var blUsuario = new BLUsuario();
            return blUsuario.ChangePasswordUser(paisID, codigoUsuarioAutenticado, emailCodigoUsuarioModificado, password, emailUsuarioModificado, origen);
        }

        public int UpdUsuarioDatosPrimeraVezEstado(int PaisID, string CodigoUsuario)
        {
            var blUsuario = new BLUsuario();
            return blUsuario.UpdUsuarioDatosPrimeraVezEstado(PaisID, CodigoUsuario);
        }

        public int ValidarEmailConsultora(int PaisID, string Email, string CodigoUsuario)
        {
            var blUsuario = new BLUsuario();
            return blUsuario.ValidarEmailConsultora(PaisID, Email, CodigoUsuario);
        }

        public int ValidarTelefonoConsultora(int PaisID, string Telefono, string CodigoUsuario)
        {
            var blUsuario = new BLUsuario();
            return blUsuario.ValidarTelefonoConsultora(PaisID, Telefono, CodigoUsuario);
        }

        public List<int> GetEstadosRestringidos(int paisID)
        {
            var blUsuario = new BLUsuario();
            return blUsuario.GetEstadosRestringidos(paisID);
        }

        public int UpdActualizarDatos(int paisID, string CodigoUsuario, string Email, string Celular, string Telefono)
        {
            var blUsuario = new BLUsuario();
            return blUsuario.UpdActualizarDatos(paisID, CodigoUsuario, Email, Celular, Telefono);
        }   

        public string GetNroDocumentoConsultora(int paisID, string CodigoConsultora)
        {
            var blUsuario = new BLUsuario();
            return blUsuario.GetNroDocumentoConsultora(paisID, CodigoConsultora);
        }

        public List<BEKitNueva> GetValidarConsultoraNueva(int paisID, string CodigoConsultora)
        {
            var blUsuario = new BLUsuario();
            return blUsuario.GetValidarConsultoraNueva(paisID, CodigoConsultora);
        }

        public int ValidarUsuarioPrueba(string CodigoUsuario, int paisID)
        {
            var blUsuario = new BLUsuario();
            return blUsuario.ValidarUsuarioPrueba(CodigoUsuario, paisID);
        }

        public int ValidarEnvioCatalogo(int paisID, string CodigoConsultora, int CampaniaActual, int Cantidad)
        {
            var blUsuario = new BLUsuario();
            return blUsuario.ValidarEnvioCatalogo(paisID, CodigoConsultora, CampaniaActual, Cantidad);
        }

        public int GetValidarColaboradorZona(int paisID, string CodigoZona)
        {
            var blUsuario = new BLUsuario();
            return blUsuario.GetValidarColaboradorZona(paisID, CodigoZona);
        }

        public DateTime GetFechaFacturacion(string CampaniaCodigo, int ZonaID, int PaisID)
        {
            var blUsuario = new BLUsuario();
            return blUsuario.GetFechaFacturacion(CampaniaCodigo, ZonaID, PaisID);
        }

        public void UpdateIndicadorAyudaWebTracking(int paisID, string codigoConsultora, bool indicador)
        {
            var blUsuario = new BLUsuario();
            blUsuario.UpdateIndicadorAyudaWebTracking(paisID, codigoConsultora, indicador);
        }

        public void InsLogIngresoPortal(int paisID, string CodigoConsultora, string IPOrigen, byte Tipo, string DetalleError, string Canal)
        {
            var blUsuario = new BLUsuario();
            blUsuario.InsLogIngresoPortal(paisID, CodigoConsultora, IPOrigen, Tipo, DetalleError, Canal);
        }

        public int AceptarContratoAceptacion(int paisID, long consultoraid, string codigoConsultora , string origen, string direccionIP, string InformacionSOMobile, string imei, string deviceID)
        {
            var blContratoAceptacion = new BLContratoAceptacion();
            return blContratoAceptacion.AceptarContratoAceptacion(paisID, consultoraid, codigoConsultora, origen, direccionIP, InformacionSOMobile, imei, deviceID);
        }

        public List<BeReporteContrato> ReporteContratoAceptacion(int paisID,string codigoConsultora, string cedula, DateTime? FechaInicio, DateTime? FechaFin)
        {
            var blContratoAceptacion = new BLContratoAceptacion();
            return blContratoAceptacion.ReporteContratoAceptacion(paisID, codigoConsultora, cedula, FechaInicio, FechaFin);
        }


        public BEUsuario GetSesionUsuarioLoginDD(int paisID, string codigoUsuario, string claveSecreta)
        {
            var blUsuario = new BLUsuario();
            return blUsuario.GetSesionUsuarioLoginDD(paisID, codigoUsuario, claveSecreta);
        }

        public IList<BEUsuario> GetUsuarioDigitadorByFfVv(int paisID, string codigoFfvv)
        {
            var blUsuario = new BLUsuario();
            return blUsuario.GetUsuarioDigitadorByFfVv(paisID, codigoFfvv);
        }

        public void UpdUsuarioDigitador(BEUsuario usuario)
        {
            var blUsuario = new BLUsuario();
            blUsuario.UpdUsuarioDigitador(usuario);
        }

        public BEUsuario GetSesionUsuarioLoginDDByRol(int paisID, int rolID, string email)
        {
            var blUsuario = new BLUsuario();
            return blUsuario.GetSesionUsuarioLoginDDByRol(paisID, rolID, email);
        }

        public IList<BEUsuario> GetUsuario(int paisID, int rol, string codigoUsuario, string codigoFFVV, string nombres, bool estado)
        {
            var blUsuario = new BLUsuario();
            return blUsuario.GetUsuario(paisID, rol, codigoUsuario, codigoFFVV, nombres, estado);
        }

        public void UpdUsuarioDD(BEUsuario usuario)
        {
            var blUsuario = new BLUsuario();
            blUsuario.UpdUsuarioDD(usuario);
        }

        public IList<BENotificaciones> GetNotificacionesConsultora(int PaisID, long ConsultoraId, int indicadorBloqueoCDR, bool tienePagoEnLinea)
        {
            var blNotificaciones = new BLNotificaciones();
            return blNotificaciones.GetNotificacionesConsultora(PaisID, ConsultoraId, indicadorBloqueoCDR, tienePagoEnLinea);
        }

        public int GetNotificacionesSinLeer(int PaisID, long ConsultoraId, int indicadorBloqueoCDR, bool tienePagoEnLinea)
        {
            var blNotificaciones = new BLNotificaciones();
            return blNotificaciones.GetNotificacionesSinLeer(PaisID, ConsultoraId, indicadorBloqueoCDR, tienePagoEnLinea);
        }

        public IList<BENotificacionesDetalle> GetNotificacionesConsultoraDetalle(int PaisID, long ValAutomaticaPROLLogId, int TipoOrigen)
        {
            var blNotificaciones = new BLNotificaciones();
            return blNotificaciones.GetNotificacionesConsultoraDetalle(PaisID, ValAutomaticaPROLLogId, TipoOrigen);
        }

        public IList<BENotificacionesDetallePedido> GetNotificacionesConsultoraDetallePedido(int PaisID, long ValAutomaticaPROLLogId, int TipoOrigen)
        {
            var blNotificaciones = new BLNotificaciones();
            return blNotificaciones.GetNotificacionesConsultoraDetallePedido(PaisID, ValAutomaticaPROLLogId, TipoOrigen);
        }

        public IList<BEMisPedidos> GetMisPedidosConsultoraOnline(int PaisID, long ConsultoraId, int Campania)
        {
            var blMisPedidos = new BLConsultoraOnline();
            return blMisPedidos.GetMisPedidos(PaisID, ConsultoraId, Campania);
        }

        public IList<BEMisPedidosDetalle> GetMisPedidosDetalleConsultoraOnline(int PaisID, long PedidoID)
        {
            var blMisPedidos = new BLConsultoraOnline();
            return blMisPedidos.GetMisPedidosDetalle(PaisID, PedidoID);
        }

        public int GetCantidadSolicitudesPedido(int PaisID, long ConsultoraId, int Campania)
        {
            var blMisPedidos = new BLConsultoraOnline();
            return blMisPedidos.GetCantidadSolicitudesPedido(PaisID, ConsultoraId, Campania);
        }

        public string GetSaldoHorasSolicitudesPedido(int PaisID, long ConsultoraId, int Campania)
        {
            var blMisPedidos = new BLConsultoraOnline();
            return blMisPedidos.GetSaldoHorasSolicitudesPedido(PaisID, ConsultoraId, Campania);
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
            var blNotificaciones = new BLNotificaciones();
            blNotificaciones.UpdNotificacionesConsultoraVisualizacion(PaisID, ValAutomaticaPROLLogId, TipoOrigen);
        }

        public BEConsultoraDatoSAC DatoConsultoraSAC(string paisID, string codigoConsultora, string documento)
        {
            var blUsuario = new BLConsultora();
            BEConsultoraDatoSAC consultoraDato = blUsuario.GetConsultoraDatoSAC(paisID, codigoConsultora, documento);
            return consultoraDato;
        }

        public BEConsultoraEstadoSAC ConsultoraEstadoSAC(string paisID, string codigoConsultora)
        {
            var blUsuario = new BLConsultora();
            BEConsultoraEstadoSAC consultoraEstado = blUsuario.GetConsultoraEstadoSAC(paisID, codigoConsultora);
            return consultoraEstado;
        }

        public IList<BENotificacionesDetallePedido> GetValidacionStockProductos(int PaisID, long ConsultoraId, long ValAutomaticaPROLLogId)
        {
            var blNotificaciones = new BLNotificaciones();
            return blNotificaciones.GetValidacionStockProductos(PaisID, ConsultoraId, ValAutomaticaPROLLogId);
        }

        public String GetFechaPromesaCronogramaByCampania(int PaisID, int CampaniaId, string CodigoConsultora, DateTime Fechafact)
        {
            var blNotificaciones = new BLNotificaciones();
            return blNotificaciones.GetFechaPromesaCronogramaByCampania(PaisID, CampaniaId, CodigoConsultora, Fechafact);
        }

        public int UpdateDatosPrimeraVezMexico(int PaisID, string CodigoUsuario, string Nombre, string Apellidos, string Telefono, string TelefonoTrabajo, string Celular, string Email, long IdConsultora, string CodigoConsultora, int CampaniaID_Actual, int CampaniaID_UltimaF, int RegionID, int ZonaID, string EmailAnterior)
        {
            var blUsuario = new BLUsuario();
            return blUsuario.UpdateDatosPrimeraVezMexico(PaisID, CodigoUsuario, Nombre, Apellidos, Telefono, TelefonoTrabajo, Celular, Email, IdConsultora, CodigoConsultora, CampaniaID_Actual, CampaniaID_UltimaF, RegionID, ZonaID, EmailAnterior);
        }

        public int SelectDatosActualizados(int paisID, string codigoUsuario)
        {
            var daUsuario = new BLUsuario();
            if (daUsuario.SelectDatosActualizados(paisID, codigoUsuario) == 0)
                return 0;

            return 1;
        }

        public int SelectSegmento(int paisID, int segmentoID)
        {
            var daUsuario = new BLUsuario();
            if (daUsuario.SelectSegmento(paisID, segmentoID) == 1)
                return 1;
            return 0;
        }

        public int SelectTiempo(int paisID)
        {
            var daUsuario = new BLUsuario();
            return daUsuario.SelectTiempo(paisID);
        }

        public int ValidarEstadoSubscripcion(string PaisISO, string CodigoUsuario, int NroDiasPermitidos)
        {
            int paisId = GetPaisID(PaisISO);

            BLUsuario oblUsuario = new BLUsuario();
            return oblUsuario.ValidarEstadoSubscripcion(paisId, CodigoUsuario, NroDiasPermitidos);
        }

        public BEUsuario ObtenerDatosPorUsuario(string PaisISO, string CodigoUsuario)
        {
            int paisId = GetPaisID(PaisISO);

            BLUsuario oblUsuario = new BLUsuario();
            return oblUsuario.ObtenerDatosPorUsuario(paisId, CodigoUsuario);
        }

        public int UpdUsuarioLider(string PaisISO, string CodigoUsuario, string Telefono, string Celular, string Email)
        {
            int paisId = GetPaisID(PaisISO);

            BLUsuario oblUsuario = new BLUsuario();
            return oblUsuario.UpdUsuarioLider(paisId, CodigoUsuario, Telefono, Celular, Email);
        }

        public int UpdCorreoUsuarioLider(string PaisISO, string CodigoUsuario, string Email)
        {
            int paisId = GetPaisID(PaisISO);

            BLUsuario oblUsuario = new BLUsuario();
            return oblUsuario.UpdCorreoUsuarioLider(paisId, CodigoUsuario, Email);
        }

        public int CancelarSubscripcion(string PaisISO, string email)
        {
            int paisId = GetPaisID(PaisISO);

            BLUsuario oblUsuario = new BLUsuario();
            return oblUsuario.CancelarSubscripcion(paisId, email);
        }

        public int ConfirmarSuscripcion(string PaisISO, string Email)
        {
            int paisId = GetPaisID(PaisISO);

            BLUsuario oblUsuario = new BLUsuario();
            return oblUsuario.ConfirmarSuscripcion(paisId, Email);
        }

        public List<BEUsuario> GenerarReporteSuscripcionLideres(string PaisISO, string TipoReporte)
        {
            int paisId = GetPaisID(PaisISO);

            BLUsuario oblUsuario = new BLUsuario();
            return oblUsuario.GenerarReporteSuscripcionLideres(paisId, TipoReporte);
        }

        public int GetPaisID(string ISO)
        {
            try
            {
                List<KeyValuePair<string, string>> listaPaises = new List<KeyValuePair<string, string>>()
                {
                    new KeyValuePair<string, string>("1", Constantes.CodigosISOPais.Argentina),
                    new KeyValuePair<string, string>("2", Constantes.CodigosISOPais.Bolivia),
                    new KeyValuePair<string, string>("3", Constantes.CodigosISOPais.Chile),
                    new KeyValuePair<string, string>("4", Constantes.CodigosISOPais.Colombia),
                    new KeyValuePair<string, string>("5", Constantes.CodigosISOPais.CostaRica),
                    new KeyValuePair<string, string>("6", Constantes.CodigosISOPais.Ecuador),
                    new KeyValuePair<string, string>("7", Constantes.CodigosISOPais.Salvador),
                    new KeyValuePair<string, string>("8", Constantes.CodigosISOPais.Guatemala),
                    new KeyValuePair<string, string>("9", Constantes.CodigosISOPais.Mexico),
                    new KeyValuePair<string, string>("10", Constantes.CodigosISOPais.Panama),
                    new KeyValuePair<string, string>("11", Constantes.CodigosISOPais.Peru),
                    new KeyValuePair<string, string>("12", Constantes.CodigosISOPais.PuertoRico),
                    new KeyValuePair<string, string>("13", Constantes.CodigosISOPais.Dominicana),
                    new KeyValuePair<string, string>("14", Constantes.CodigosISOPais.Venezuela),
                };

                string paisId = (from c in listaPaises
                                 where c.Value == ISO.ToUpper()
                                 select c.Key).SingleOrDefault() ?? "";

                int outVal;
                int.TryParse(paisId, out outVal);
                return outVal;
            }
            catch (Exception)
            {
                throw new Exception("Hubo un error en obtener el País");
            }
        }

        public void UpdNotificacionSolicitudClienteVisualizacion(int paisID, long SolicitudClienteId)
        {
            var blNotificaciones = new BLNotificaciones();
            blNotificaciones.UpdNotificacionSolicitudClienteVisualizacion(paisID, SolicitudClienteId);
        }

        #region Miembros de IUsuarioService

        public List<BEUsuario> ObtenerResultadoEncuesta(int paisID, int campaniaInicio, int campaniaFin)
        {
            return new BLUsuario().ObtenerResultadoEncuesta(paisID, campaniaInicio, campaniaFin);
        }
        #endregion

        public void UpdNotificacionSolicitudClienteCatalogoVisualizacion(int paisID, long SolicitudClienteCatalogoId)
        {
            var blSolicitudClienteCatalogo = new BLSolicitudClienteCatalogo();
            blSolicitudClienteCatalogo.UpdNotificacionSolicitudClienteCatalogoVisualizacion(paisID, SolicitudClienteCatalogoId);
        }

        public void UpdNotificacionPedidoRechazadoVisualizacion(int paisID, long procesoId)
        {
            var blPedidoRechazado = new BLPedidoRechazado();
            blPedidoRechazado.UpdatePedidoRechazadoVisualizado(paisID, procesoId);
        }

        public BENotificacionesDetalleCatalogo ObtenerDetalleNotificacion(int PaisID, long SolicitudClienteCatalogoId)
        {
            BLSolicitudClienteCatalogo solicitudClienteCatalogo = new BLSolicitudClienteCatalogo();
            return solicitudClienteCatalogo.ObtenerDetalleNotificacionCatalogo(PaisID, SolicitudClienteCatalogoId);
        }

        public int GetCantidadPedidosConsultoraOnline(int PaisID, long ConsultoraId)
        {
            BLConsultoraOnline blConsultoraOnline = new BLConsultoraOnline();
            return blConsultoraOnline.GetCantidadPedidosConsultoraOnline(PaisID, ConsultoraId);
        }

        public void GuardarContrasenia(string paisISO, string codigoUsuario, string contrasenia)
        {
            int paisId = GetPaisID(paisISO);

            BLUsuario blUsuario = new BLUsuario();
            blUsuario.GuardarContrasenia(paisId, codigoUsuario, contrasenia);
        }

        public int UpdateUsuarioTutoriales(int paisID, string codigoUsuario, int tipo)
        {
            var blUsuario = new BLUsuario();
            return blUsuario.UpdateUsuarioTutoriales(paisID, codigoUsuario, tipo);
        }

        public BEUsuario GetDatosConsultoraHana(int paisID, string codigoUsuario, int campaniaId)
        {
            var blUsuario = new BLUsuario();
            return blUsuario.GetDatosConsultoraHana(paisID, codigoUsuario, campaniaId);
        }

        public void UpdNotificacionSolicitudCdrVisualizacion(int paisID, long procesoId)
        {
            var blLogCdrWeb = new BLLogCDRWeb();
            blLogCdrWeb.UpdateVisualizado(paisID, procesoId);
        }

        public void UpdNotificacionCdrCulminadoVisualizacion(int paisID, long procesoId)
        {
            var blLogCdrWebCulminado = new BLLogCDRWebCulminado();
            blLogCdrWebCulminado.UpdateVisualizado(paisID, procesoId);
        }

        public void UpdNotificacionPagoEnLineaVisualizacion(int paisId, int procesoId)
        {
            var bLPagoEnLinea = new BLPagoEnLinea();
            bLPagoEnLinea.UpdateVisualizado(paisId, procesoId);
        }

        public int UpdateUsuarioEmailTelefono(int paisID, long ConsultoraID, string Email, string Telefono)
        {
            var blUsuario = new BLUsuario();
            return blUsuario.UpdateUsuarioEmailTelefono(paisID, ConsultoraID, Email, Telefono);
        }

        public BEValidaLoginSB2 GetValidarLoginSB2(int paisID, string codigoUsuario, string contrasenia)
        {
            var blUsuario = new BLUsuario();
            return blUsuario.GetValidarLoginSB2(paisID, codigoUsuario, contrasenia);
        }
      
        public BEValidaLoginSB2 GetValidarLoginJsonWebToken(int paisID, string documento)
        {
            var blUsuario = new BLUsuario();
            return blUsuario.GetValidarLoginJsonWebToken(paisID, documento);
        }
        
        public BEValidaLoginSB2 GetValidarAutoLogin(int paisID, string codigoUsuario, string proveedor)
        {
            var blUsuario = new BLUsuario();
            return blUsuario.GetValidarAutoLogin(paisID, codigoUsuario, proveedor);
        }

        public int InsUsuarioExternoPais(int paisID, BEUsuarioExternoPais entidad)
        {
            var blUsuario = new BLUsuario();
            return blUsuario.InsUsuarioExternoPais(paisID, entidad);
        }

        public bool CambiarClaveUsuario(int paisId, string paisIso, string codigoUsuario, string nuevacontrasena, string correo, string codigoUsuarioAutenticado, EAplicacionOrigen origen)
        {
            var blUsuario = new BLUsuario();
            return blUsuario.CambiarClaveUsuario(paisId, paisIso, codigoUsuario, nuevacontrasena, correo, codigoUsuarioAutenticado, origen);
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
            var blUsuario = new BLUsuario();
            return blUsuario.ExisteUsuario(paisId, codigoUsuario, clave);
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

            var blUsuario = new BLUsuario();
            return blUsuario.ValidarUsuario(paisId, codigoUsuario, clave);
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

        public List<BEConfiguracionPaisDatos> GetConfiguracionPaisComponente(BEConfiguracionPaisDatos entidad)
        {
            var bl = new BLConfiguracionPaisDatos();
            return bl.GetListComponente(entidad);
        }

        public List<BEConfiguracionPaisDatos> GetConfiguracionPaisComponenteDatos(BEConfiguracionPaisDatos entidad)
        {
            var bl = new BLConfiguracionPaisDatos();
            return bl.GetListComponenteDatos(entidad);
        }

        public bool ConfiguracionPaisComponenteDeshabilitar(BEConfiguracionPaisDatos entidad)
        {
            var bl = new BLConfiguracionPaisDatos();
            return bl.ConfiguracionPaisComponenteDeshabilitar(entidad);
        }

        public int ConfiguracionPaisDatosGuardar(int paisId, List<BEConfiguracionPaisDatos> entidad)
        {
            var bl = new BLConfiguracionPaisDatos();
            return bl.ConfiguracionPaisDatosGuardar(paisId, entidad);
        }

        public int RegistrarUsuarioPostulante(string paisISO, BEUsuarioPostulante entidad)
        {
            int paisId = GetPaisID(paisISO);
            var blUsuario = new BLUsuario();
            return blUsuario.InsUsuarioPostulante(paisId, paisISO, entidad);
        }

        public string ActualizarMisDatos(BEUsuario usuario, string CorreoAnterior)
        {
            var blUsuario = new BLUsuario();
            return blUsuario.ActualizarMisDatos(usuario, CorreoAnterior);
        }

        public BERespuestaServicio ActualizarEmail(BEUsuario usuario, string correoNuevo)
        {
            return new BLUsuario().ActualizarEmail(usuario, correoNuevo);
        }

        public BERespuestaServicio RegistrarEnvioSms(
            int paisId,
            string codigoUsuario,
            string codigoConsultora,
            int campaniaId,
            bool esMobile,
            string celularActual,
            string celularNuevo)
        {
            return _usuarioBusinessLogic.RegistrarEnvioSms(paisId, codigoUsuario, codigoConsultora, campaniaId, esMobile, celularActual, celularNuevo);
        }

        public BERespuestaServicio ConfirmarCelularPorCodigoSms(int paisId, string codigoUsuario, string codigoSms, int campania, bool soloValidar)
        {
            return _usuarioBusinessLogic.ConfirmarCelularPorCodigoSms(paisId, codigoUsuario, codigoSms, campania, soloValidar);
        }

        public string AceptarContrato(BEUsuario usuario)
        {
            var blUsuario = new BLUsuario();
            return blUsuario.AceptarContratoColombia(usuario);
        }

        public int EliminarUsuarioPostulante(string paisISO, string numeroDocumento)
        {
            int paisId = GetPaisID(paisISO);
            var blUsuario = new BLUsuario();
            return blUsuario.DelUsuarioPostulante(paisId, numeroDocumento);
        }

        public BEUsuarioPostulante GetUsuarioPostulante(int paisId, string numeroDocumento)
        {
            var blUsuario = new BLUsuario();
            return blUsuario.GetUsuarioPostulante(paisId, numeroDocumento);
        }

        public int InsertUsuarioExterno(int paisID, BEUsuarioExterno usuarioExterno)
        {
            var blUsuario = new BLUsuario();
            return blUsuario.InsertUsuarioExterno(paisID, usuarioExterno);
        }

        public BEUsuarioExterno GetUsuarioExternoByCodigoUsuario(int paisID, string codigoUsuario)
        {
            var blUsuario = new BLUsuario();
            return blUsuario.GetUsuarioExternoByCodigoUsuario(paisID, codigoUsuario);
        }

        public BEUsuarioExterno GetUsuarioExternoByProveedorAndIdApp(string proveedor, string idAplicacion, string fotoPerfil)
        {
            BLUsuario objUsuario = new BLUsuario();
            return objUsuario.GetUsuarioExternoByProveedorAndIdApp(proveedor, idAplicacion, fotoPerfil);
        }

        public List<BEUsuarioExterno> GetListaLoginExterno(int paisID, string codigoUsuario)
        {
            var blUsuario = new BLUsuario();
            return blUsuario.GetListaLoginExterno(paisID, codigoUsuario);
        }

        public BEUsuarioConfiguracion ObtenerUsuarioConfiguracion(int paisID, int consultoraID, int campania, bool usuarioPrueba,
            int aceptacionConsultoraDA)
        {
            return new BLUsuario().ObtenerUsuarioConfiguracion(paisID, consultoraID, campania, usuarioPrueba,
                aceptacionConsultoraDA);
        }

        public void UpdatePosutlanteMensajes(int paisID, string codigoUsuario, int tipo)
        {
            var blUsuario = new BLUsuario();
            blUsuario.UpdatePostulantesMensajes(paisID, codigoUsuario, tipo);
        }

        public BEUsuarioChatEmtelco GetUsuarioChatEmtelco(int paisID, string codigoUsuario)
        {
            return _usuarioBusinessLogic.GetUsuarioChatEmtelco(paisID, codigoUsuario);
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
            var blUsuario = new BLUsuario();
            return blUsuario.GetEventoFestivo(paisID, Alcance, Campania);
        }
        #endregion

        public int UpdUsuarioFotoPerfil(int paisID, string codigoUsuario, string fileName)
        {
            return _usuarioBusinessLogic.UpdUsuarioFotoPerfil(paisID, codigoUsuario, fileName);
        }

        public string RecuperarContrasenia(int paisId, string textoRecuperacion)
        {
            var BLUsuario = new BLUsuario();
            return BLUsuario.RecuperarContrasenia(paisId, textoRecuperacion);
        }

        #region OLVIDE CONTRASENIA

        public BEUsuarioDatos GetRestaurarClaveByValor(int paisID, string valorIngresado, int prioridad)
        {
            var BLUsuario = new BLUsuario();
            return BLUsuario.GetRestaurarClaveByValor(paisID, valorIngresado, prioridad);
        }

        public bool ProcesaEnvioEmail (int paisID, BEUsuarioDatos oUsu, int CantidadEnvios)
        {
            var BLUsuario = new BLUsuario();
            return BLUsuario.ProcesaEnvioEmail(paisID, oUsu, CantidadEnvios);
        }

        public BERespuestaSMS ProcesaEnvioSms(int paisID, BEUsuarioDatos oUsu, int CantidadEnvios)
        {
            var BLUsuario = new BLUsuario();
            return BLUsuario.ProcesaEnvioSms(paisID, oUsu, CantidadEnvios);
        }

        public bool VerificarIgualdadCodigoIngresado(int paisID, BEUsuarioDatos oUsu, string codigoIngresado, bool soloValidar)
        {
            var BLUsuario = new BLUsuario();
            return (BLUsuario.VerificarIgualdadCodigoIngresado(paisID, oUsu, codigoIngresado, soloValidar));
        }

        #endregion

        #region Verificacion de Autenticidad
        public BEUsuarioDatos GetVerificacionAutenticidad(int paisID, string CodigoUsuario, bool verificacionWeb)
        {
            var BLUsuario = new BLUsuario();
            return BLUsuario.GetVerificacionAutenticidad(paisID, CodigoUsuario, verificacionWeb); 
        }

        public BERespuestaSMS EnviarSmsVerificacionAutenticidad(int paisID, BEUsuarioDatos oUsu)
        {
            var BLUsuario = new BLUsuario();
            return BLUsuario.EnviarSmsVerificacionAutenticidad(paisID, oUsu);
        }

        #endregion

        public bool GetConsultoraParticipaEnPrograma(int paisID, string codigoPrograma, string codigoConsultora, int campaniaID)
        {
            var BLUsuario = new BLUsuario();
            return BLUsuario.GetConsultoraParticipaEnPrograma(paisID, codigoPrograma, codigoConsultora, campaniaID);
        }

        public string GetActualizacionEmail(int paisID, string codigoUsuario)
        {
            var BLUsuario = new BLUsuario();
            return BLUsuario.GetActualizacionEmail(paisID, codigoUsuario);
        }

        public BEMensajeToolTip GetActualizacionEmailySms(int paisID, string codigoUsuario)
        {
            var BLUsuario = new BLUsuario();
            return BLUsuario.GetActualizacionEmailySms(paisID, codigoUsuario);
        }

        public string CancelarAtualizacionEmail(int paisID, string codigoUsuario)
        {
            var BLUsuario = new BLUsuario();
            return BLUsuario.CancelarAtualizacionEmail(paisID, codigoUsuario);
        }

        public BEUsuarioDireccion GetDireccionConsultora(int paisID, string codigoUsuario)
        {
            return _usuarioBusinessLogic.GetDireccionConsultora(paisID, codigoUsuario);
        }

        public List<BEBuscadorYFiltros> listaProductos(int paisID, int CampaniaID, int filas, string CodigoDescripcion, int regionId, int zonaId, int codigoRegion, int codigoZona)
        {
            var BLUsuario = new BLUsuario();
            return BLUsuario.listaProductos(paisID,CampaniaID, filas, CodigoDescripcion, regionId, zonaId, codigoRegion, codigoZona);
        }
        
         public string ActualizarNovedadBuscador(int paisID, string codigoUsuario)
        {
            var BLUsuario = new BLUsuario();
            return BLUsuario.ActuaizarNovedadBuscador(paisID, codigoUsuario);
        }


        #region ActualizacionDatos
        public BERespuestaServicio ActualizarEmailWS(BEUsuario usuario, string correoNuevo)
        {
            return _usuarioBusinessLogic.ActualizarEmailWS(usuario, correoNuevo);
        }
        public BERespuestaServicio EnviarSmsCodigo(int paisID, string codigoUsuario, string codigoConsultora, int campaniaID, bool esMobile, string celularActual, string celularNuevo)
        {
            return _usuarioBusinessLogic.EnviarSmsCodigo(paisID, codigoUsuario, codigoConsultora, campaniaID, esMobile, celularActual, celularNuevo);
        }
        #endregion
    }
}