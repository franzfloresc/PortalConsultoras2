using Portal.Consultoras.BizLogic.Pedido;
using Portal.Consultoras.BizLogic.RevistaDigital;
using Portal.Consultoras.Common;
using Portal.Consultoras.Data;
using Portal.Consultoras.Data.Hana;
using Portal.Consultoras.Entities;
using Portal.Consultoras.Entities.Cupon;
using Portal.Consultoras.Entities.RevistaDigital;
using Portal.Consultoras.PublicService.Cryptography;
using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.IO;
using System.Linq;
using System.Threading.Tasks;

namespace Portal.Consultoras.BizLogic
{
    public partial class BLUsuario : IUsuarioBusinessLogic
    {
        private string CodigoUsuarioLog = string.Empty;
        private int PaisIDLog = 0;

        private readonly ITablaLogicaDatosBusinessLogic _tablaLogicaDatosBusinessLogic;
        private readonly IConsultoraConcursoBusinessLogic _consultoraConcursoBusinessLogic;
        private readonly IRevistaDigitalSuscripcionBusinessLogic _revistaDigitalSuscripcionBusinessLogic;
        private readonly IConfiguracionPaisBusinessLogic _configuracionPaisBusinessLogic;
        private readonly ICuponConsultoraBusinessLogic _cuponConsultoraBusinessLogic;
        private readonly IConfiguracionPaisDatosBusinessLogic _configuracionPaisDatosBusinessLogic;
        private readonly IPedidoRechazadoBusinessLogic _pedidoRechazadoBusinessLogic;
        private readonly IResumenCampaniaBusinessLogic _resumenCampaniaBusinessLogic;
        private readonly IShowRoomEventoBusinessLogic _showRoomEventoBusinessLogic;
        private readonly IConsultoraLiderBusinessLogic _consultoraLiderBusinessLogic;


        public BLUsuario() : this(new BLTablaLogicaDatos(),
                                    new BLConsultoraConcurso(),
                                    new BLRevistaDigitalSuscripcion(),
                                    new BLConfiguracionPais(),
                                    new BLCuponConsultora(),
                                    new BLConfiguracionPaisDatos(),
                                    new BLPedidoRechazado(),
                                    new BLResumenCampania(),
                                    new BLShowRoomEvento(),
                                    new BLConsultoraLider())
        { }

        public BLUsuario(ITablaLogicaDatosBusinessLogic tablaLogicaDatosBusinessLogic,
                        IConsultoraConcursoBusinessLogic consultoraConcursoBusinessLogic,
                        IRevistaDigitalSuscripcionBusinessLogic revistaDigitalSuscripcionBusinessLogic,
                        IConfiguracionPaisBusinessLogic configuracionPaisBusinessLogic,
                        ICuponConsultoraBusinessLogic cuponConsultoraBusinessLogic,
                        IConfiguracionPaisDatosBusinessLogic configuracionPaisDatosBusinessLogic,
                        IPedidoRechazadoBusinessLogic pedidoRechazadoBusinessLogic,
                        IResumenCampaniaBusinessLogic resumenCampaniaBusinessLogic,
                        IShowRoomEventoBusinessLogic showRoomEventoBusinessLogic,
                        IConsultoraLiderBusinessLogic consultoraLiderBusinessLogic)
        {
            _tablaLogicaDatosBusinessLogic = tablaLogicaDatosBusinessLogic;
            _consultoraConcursoBusinessLogic = consultoraConcursoBusinessLogic;
            _revistaDigitalSuscripcionBusinessLogic = revistaDigitalSuscripcionBusinessLogic;
            _configuracionPaisBusinessLogic = configuracionPaisBusinessLogic;
            _cuponConsultoraBusinessLogic = cuponConsultoraBusinessLogic;
            _configuracionPaisDatosBusinessLogic = configuracionPaisDatosBusinessLogic;
            _pedidoRechazadoBusinessLogic = pedidoRechazadoBusinessLogic;
            _resumenCampaniaBusinessLogic = resumenCampaniaBusinessLogic;
            _showRoomEventoBusinessLogic = showRoomEventoBusinessLogic;
            _consultoraLiderBusinessLogic = consultoraLiderBusinessLogic;
        }

        public BEUsuario Select(int paisID, string codigoUsuario)
        {
            BEUsuario usuario = null;
            using (IDataReader reader = SelectByCodigoOrEmail(paisID, codigoUsuario))
                if (reader.Read())
                    usuario = new BEUsuario(reader);
            return usuario;
        }

        public BEConsultoraDatos GetDatosConsultora(int paisID, string codigoUsuario)
        {
            BEConsultoraDatos consultora = null;
            var daUsuario = new DAUsuario(paisID);
            using (IDataReader reader = daUsuario.GetDatosConsultora(codigoUsuario))
                if (reader.Read())
                    consultora = new BEConsultoraDatos(reader);
            return consultora;
        }

        public List<BEUsuario> SelectByNombre(int paisID, string NombreUsuario)
        {
            List<BEUsuario> usuario = new List<BEUsuario>();

            var daUsuarioRol = new DAUsuario(paisID);
            using (IDataReader reader = daUsuarioRol.GetUsuarioByNombre(NombreUsuario))
                while (reader.Read())
                {
                    usuario.Add(new BEUsuario(reader));
                }
            return usuario;
        }

        private IDataReader SelectByCodigoOrEmail(int paisID, string codigoUsuario)
        {
            var daUsuario = new DAUsuario(paisID);
            if (codigoUsuario.Contains('@'))
                return daUsuario.GetUsuarioByEMail(codigoUsuario);

            return daUsuario.GetUsuario(codigoUsuario);
        }

        public List<BEUsuarioRol> SelectUsuarioRol(int paisID, string RolDescripcion, string NombreUsuario)
        {
            List<BEUsuarioRol> usuarioRol = new List<BEUsuarioRol>();

            var daUsuarioRol = new DAUsuario(paisID);
            using (IDataReader reader = daUsuarioRol.GetUsuarioRol(RolDescripcion, NombreUsuario))
                while (reader.Read())
                {
                    usuarioRol.Add(new BEUsuarioRol(reader));
                }
            return usuarioRol;
        }

        public List<BEUsuarioCorreo> SelectByEmail(string Email, int paisID)
        {
            List<BEUsuarioCorreo> usuarioCorreo = new List<BEUsuarioCorreo>();

            var daUsuario = new DAUsuario(paisID);
            using (IDataReader reader = daUsuario.GetUsuarioCorreo(Email, paisID))
                while (reader.Read())
                {
                    usuarioCorreo.Add(new BEUsuarioCorreo(reader));
                }
            return usuarioCorreo;
        }

        public int DelUsuarioRol(int paisID, string codigoUsuario, int RolID)
        {
            var daUsuario = new DAUsuario(paisID);
            return daUsuario.DelUsuarioRol(codigoUsuario, RolID);
        }

        public void Insert(BEUsuario usuario)
        {
            var daUsuario = new DAUsuario(usuario.PaisID);
            daUsuario.InsUsuario(usuario);
        }

        public void Update(BEUsuario usuario)
        {
            var daUsuario = new DAUsuario(usuario.PaisID);
            daUsuario.UpdUsuario(usuario);
        }

        public int UpdUsuarioRechazarInvitacion(int PaisID, string CodigoUsuario)
        {
            var daUsuario = new DAUsuario(PaisID);
            return daUsuario.UpdUsuarioRechazarInvitacion(CodigoUsuario);
        }

        public void UpdateDatos(BEUsuario usuario, string CorreoAnterior)
        {
            var daUsuario = new DAUsuario(usuario.PaisID);
            daUsuario.UpdUsuarioDatos(usuario, CorreoAnterior);
        }

        public void AceptarContrato(BEUsuario usuario)
        {
            var daUsuario = new DAUsuario(usuario.PaisID);
            daUsuario.AceptarContrato(usuario);
        }

        public int UpdateDatosPrimeraVez(int paisID, string codigoUsuario, string email, string telefono, string telefonoTrabajo, string celular, string correoAnterior, bool aceptoContrato)
        {
            var daUsuario = new DAUsuario(paisID);
            return daUsuario.UpdUsuarioDatosPrimeraVez(codigoUsuario, email, telefono, telefonoTrabajo, celular, correoAnterior, aceptoContrato);
        }

        public int UpdUsuarioDatosPrimeraVezEstado(int PaisID, string CodigoUsuario)
        {
            var daUsuario = new DAUsuario(PaisID);
            return daUsuario.UpdUsuarioDatosPrimeraVezEstado(CodigoUsuario);
        }

        public void UpdatePassword(int paisID, string codigoUsuario, string claveSecreta, bool cambioClave)
        {
            var daUsuario = new DAUsuario(paisID);
            daUsuario.UpdUsuarioClaveSecreta(codigoUsuario, claveSecreta, cambioClave);
        }

        public bool ActiveEmail(int paisID, string codigoUsuario, string iso, string email)
        {
            var daUsuario = new DAUsuario(paisID);
            bool activado = daUsuario.ActiveEmail(codigoUsuario);
            return activado;
        }

        public int setUsuarioVideoIntroductorio(int paisID, string CodigoUsuario)
        {
            var daUsuario = new DAUsuario(paisID);
            return daUsuario.setUsuarioVideoIntroductorio(CodigoUsuario);
        }

        public int setUsuarioVerTutorial(int paisID, string CodigoUsuario)
        {
            var daUsuario = new DAUsuario(paisID);
            return daUsuario.setUsuarioVerTutorial(CodigoUsuario);
        }

        public int SetUsuarioVerTutorialDesktop(int paisID, string CodigoUsuario)
        {
            var daUsuario = new DAUsuario(paisID);
            return daUsuario.SetUsuarioVerTutorialDesktop(CodigoUsuario);
        }

        public BEUsuario GetSesionUsuario(int paisID, string codigoUsuario)
        {
            BEUsuario usuario = null;
            try
            {

                BEConfiguracionCampania configuracion = null;
                var daUsuario = new DAUsuario(paisID);
                var daConfiguracionCampania = new DAConfiguracionCampania(paisID);

                using (IDataReader reader = daUsuario.GetSesionUsuario(codigoUsuario))
                {
                    if (reader.Read())
                        usuario = new BEUsuario(reader, true);
                }

                if (usuario == null)
                    return null;

                if (usuario.ConsultoraID != 0)
                {
                    using (IDataReader reader = daConfiguracionCampania.GetConfiguracionCampania(paisID, usuario.ZonaID, usuario.RegionID, usuario.ConsultoraID))
                    {
                        if (reader.Read())
                            configuracion = new BEConfiguracionCampania(reader);
                    }

                    if (configuracion != null)
                    {
                        usuario.CampaniaID = configuracion.CampaniaID;
                        usuario.FechaInicioFacturacion = configuracion.FechaInicioFacturacion;
                        usuario.FechaFinFacturacion = configuracion.FechaFinFacturacion;
                        usuario.CampaniaDescripcion = configuracion.CampaniaDescripcion;
                        usuario.HoraInicio = configuracion.HoraInicio;
                        usuario.HoraFin = configuracion.HoraFin;
                        usuario.ZonaValida = configuracion.ZonaValida;
                        usuario.HoraInicioNoFacturable = configuracion.HoraInicioNoFacturable;
                        usuario.HoraCierreNoFacturable = configuracion.HoraCierreNoFacturable;
                        usuario.DiasAntes = configuracion.DiasAntes;
                        usuario.HoraCierreZonaNormal = configuracion.HoraCierreZonaNormal;
                        usuario.HoraCierreZonaDemAnti = configuracion.HoraCierreZonaDemAnti;
                        usuario.ZonaHoraria = configuracion.ZonaHoraria;
                        usuario.EsZonaDemAnti = configuracion.EsZonaDemAnti;
                        usuario.DiasDuracionCronograma = configuracion.DiasDuracionCronograma;
                        usuario.HabilitarRestriccionHoraria = configuracion.HabilitarRestriccionHoraria;
                        usuario.HorasDuracionRestriccion = configuracion.HorasDuracionRestriccion;
                        usuario.NroCampanias = configuracion.NroCampanias;
                        usuario.FechaFinFIC = configuracion.FechaFinFIC;
                        usuario.IndicadorOfertaFIC = configuracion.IndicadorOfertaFIC;
                        usuario.ImagenURLOfertaFIC = configuracion.ImagenURLOfertaFIC;
                        usuario.PROLSinStock = configuracion.PROLSinStock;
                        usuario.NuevoPROL = true;
                        usuario.ZonaNuevoPROL = true;
                        usuario.EstadoSimplificacionCUV = configuracion.EstadoSimplificacionCUV;
                        usuario.EsquemaDAConsultora = configuracion.EsquemaDAConsultora;
                        usuario.HoraCierreZonaDemAntiCierre = configuracion.HoraCierreZonaDemAntiCierre;
                        usuario.ValidacionInteractiva = configuracion.ValidacionInteractiva;
                        usuario.MensajeValidacionInteractiva = configuracion.MensajeValidacionInteractiva;
                        usuario.IndicadorGPRSB = configuracion.IndicadorGPRSB;
                        usuario.FechaActualPais = configuracion.FechaActualPais;
                        usuario.EstadoPedido = configuracion.EstadoPedido;
                        usuario.ValidacionAbierta = configuracion.ValidacionAbierta;
                        usuario.AceptacionConsultoraDA = configuracion.AceptacionConsultoraDA;
                    }
                }

                if (usuario.TipoUsuario == Constantes.TipoUsuario.Postulante)
                {
                    BEUsuarioPostulante postulante = null;

                    using (IDataReader reader = daUsuario.GetUsuarioPostulante(usuario.CodigoUsuario))
                    {
                        if (reader.Read())
                            postulante = new BEUsuarioPostulante(reader);
                    }

                    if (postulante != null)
                    {
                        usuario.ZonaID = postulante.ZonaID;
                        usuario.RegionID = postulante.RegionID;
                        usuario.ConsultoraID = postulante.ConsultoraID;

                        usuario.MensajePedidoDesktop = postulante.MensajeDesktop;
                        usuario.MensajePedidoMobile = postulante.MensajeMobile;

                        using (IDataReader reader = daConfiguracionCampania.GetConfiguracionCampaniaNoConsultora(paisID, usuario.ZonaID, usuario.RegionID))
                        {
                            if (reader.Read())
                                configuracion = new BEConfiguracionCampania(reader);
                        }

                        if (configuracion != null)
                        {
                            usuario.CampaniaID = configuracion.CampaniaID;
                            usuario.FechaInicioFacturacion = configuracion.FechaInicioFacturacion;
                            usuario.FechaFinFacturacion = configuracion.FechaFinFacturacion;
                            usuario.CampaniaDescripcion = configuracion.CampaniaDescripcion;
                            usuario.HoraInicio = configuracion.HoraInicio;
                            usuario.HoraFin = configuracion.HoraFin;
                            usuario.ZonaValida = configuracion.ZonaValida;
                            usuario.HoraInicioNoFacturable = configuracion.HoraInicioNoFacturable;
                            usuario.HoraCierreNoFacturable = configuracion.HoraCierreNoFacturable;
                            usuario.DiasAntes = configuracion.DiasAntes;
                            usuario.HoraCierreZonaNormal = configuracion.HoraCierreZonaNormal;
                            usuario.HoraCierreZonaDemAnti = configuracion.HoraCierreZonaDemAnti;
                            usuario.ZonaHoraria = configuracion.ZonaHoraria;
                            usuario.EsZonaDemAnti = configuracion.EsZonaDemAnti;
                            usuario.DiasDuracionCronograma = configuracion.DiasDuracionCronograma;
                            usuario.HabilitarRestriccionHoraria = configuracion.HabilitarRestriccionHoraria;
                            usuario.HorasDuracionRestriccion = configuracion.HorasDuracionRestriccion;
                            usuario.NroCampanias = configuracion.NroCampanias;
                            usuario.FechaFinFIC = configuracion.FechaFinFIC;
                            usuario.PROLSinStock = configuracion.PROLSinStock;
                            usuario.NuevoPROL = true;
                            usuario.ZonaNuevoPROL = true;
                            usuario.EstadoSimplificacionCUV = configuracion.EstadoSimplificacionCUV;
                            usuario.EsquemaDAConsultora = configuracion.EsquemaDAConsultora;
                            usuario.HoraCierreZonaDemAntiCierre = configuracion.HoraCierreZonaDemAntiCierre;
                            usuario.ValidacionInteractiva = configuracion.ValidacionInteractiva;
                            usuario.MensajeValidacionInteractiva = configuracion.MensajeValidacionInteractiva;
                            usuario.IndicadorGPRSB = configuracion.IndicadorGPRSB;
                            usuario.FechaActualPais = configuracion.FechaActualPais;
                            usuario.EstadoPedido = configuracion.EstadoPedido;
                            usuario.ValidacionAbierta = configuracion.ValidacionAbierta;
                            usuario.AceptacionConsultoraDA = configuracion.AceptacionConsultoraDA;
                        }
                    }
                }

                usuario.EsConsultoraNueva = EsConsultoraNueva(usuario);
                BEConsultorasProgramaNuevas beConsultoraProgramaNuevas = null;
                var daConsultoraProgramaNuevas = new DAConsultorasProgramaNuevas(paisID);

                using (IDataReader reader = daConsultoraProgramaNuevas.GetConsultorasProgramaNuevasByConsultoraId(usuario.ConsultoraID))
                {
                    if (reader.Read())
                        beConsultoraProgramaNuevas = new BEConsultorasProgramaNuevas(reader);
                }

                if (beConsultoraProgramaNuevas != null)
                {
                    usuario.ConsecutivoNueva = beConsultoraProgramaNuevas.ConsecutivoNueva;
                    usuario.CodigoPrograma = beConsultoraProgramaNuevas.CodigoPrograma ?? "";
                }

                if (!Common.Util.IsUrl(usuario.FotoPerfil) && !string.IsNullOrEmpty(usuario.FotoPerfil))
                    usuario.FotoPerfil = string.Concat(ConfigCdn.GetUrlCdn(Dictionaries.FileManager.Configuracion[Dictionaries.FileManager.TipoArchivo.FotoPerfilConsultora]), usuario.FotoPerfil);


            }
            catch (Exception ex)
            {
                LogManager.SaveLog(ex, codigoUsuario, paisID.ToString());
                usuario = null;
            }
            return usuario;
        }

        public bool EsConsultoraNueva(BEUsuario usuario)
        {
            var listEstadosValidos = new List<int> { Constantes.EstadoActividadConsultora.Registrada, Constantes.EstadoActividadConsultora.Retirada };
            if (!(listEstadosValidos.Contains(usuario.ConsultoraNueva))) return false;

            int campaniaAnterior = Common.Util.AddCampaniaAndNumero(usuario.CampaniaID, -1, usuario.NroCampanias);
            if (campaniaAnterior <= 0) return false;

            var existsPedidoAnterior = new BLPedidoWeb().ExistsPedidoWebByCampaniaConsultora(usuario.PaisID, campaniaAnterior, usuario.usuarioPrueba ? usuario.ConsultoraAsociadaID : usuario.ConsultoraID);
            return !existsPedidoAnterior;
        }

        public BEUsuario GetSesionUsuarioWS(int paisID, string codigoUsuario)
        {
            BEUsuario usuario = null;

            try
            {
                codigoUsuario = GetUsuarioRealPostulante(paisID, codigoUsuario);

                CodigoUsuarioLog = codigoUsuario;
                PaisIDLog = paisID;

                usuario = GetUsuario(paisID, codigoUsuario);
                if (usuario == null) return null;

                var configuracionConsultora = GetConfiguracionCampania(usuario, Constantes.TipoUsuario.Consultora);
                if (configuracionConsultora != null)
                {
                    usuario.CampaniaID = configuracionConsultora.CampaniaID;
                    usuario.FechaInicioFacturacion = configuracionConsultora.FechaInicioFacturacion;
                    usuario.FechaFinFacturacion = configuracionConsultora.FechaFinFacturacion;
                    usuario.CampaniaDescripcion = configuracionConsultora.CampaniaDescripcion;
                    usuario.HoraInicio = configuracionConsultora.HoraInicio;
                    usuario.HoraFin = configuracionConsultora.HoraFin;
                    usuario.ZonaValida = configuracionConsultora.ZonaValida;
                    usuario.HoraInicioNoFacturable = configuracionConsultora.HoraInicioNoFacturable;
                    usuario.HoraCierreNoFacturable = configuracionConsultora.HoraCierreNoFacturable;
                    usuario.DiasAntes = configuracionConsultora.DiasAntes;
                    usuario.HoraCierreZonaNormal = configuracionConsultora.HoraCierreZonaNormal;
                    usuario.HoraCierreZonaDemAnti = configuracionConsultora.HoraCierreZonaDemAnti;
                    usuario.ZonaHoraria = configuracionConsultora.ZonaHoraria;
                    usuario.EsZonaDemAnti = configuracionConsultora.EsZonaDemAnti;
                    usuario.DiasDuracionCronograma = configuracionConsultora.DiasDuracionCronograma;
                    usuario.HabilitarRestriccionHoraria = configuracionConsultora.HabilitarRestriccionHoraria;
                    usuario.HorasDuracionRestriccion = configuracionConsultora.HorasDuracionRestriccion;
                    usuario.NroCampanias = configuracionConsultora.NroCampanias;
                    usuario.FechaFinFIC = configuracionConsultora.FechaFinFIC;
                    usuario.IndicadorOfertaFIC = configuracionConsultora.IndicadorOfertaFIC;
                    usuario.ImagenURLOfertaFIC = configuracionConsultora.ImagenURLOfertaFIC;
                    usuario.PROLSinStock = configuracionConsultora.PROLSinStock;
                    usuario.NuevoPROL = true;
                    usuario.ZonaNuevoPROL = true;
                    usuario.EstadoSimplificacionCUV = configuracionConsultora.EstadoSimplificacionCUV;
                    usuario.EsquemaDAConsultora = configuracionConsultora.EsquemaDAConsultora;
                    usuario.HoraCierreZonaDemAntiCierre = configuracionConsultora.HoraCierreZonaDemAntiCierre;
                    usuario.ValidacionInteractiva = configuracionConsultora.ValidacionInteractiva;
                    usuario.MensajeValidacionInteractiva = configuracionConsultora.MensajeValidacionInteractiva;
                    usuario.IndicadorGPRSB = configuracionConsultora.IndicadorGPRSB;
                    usuario.FechaActualPais = configuracionConsultora.FechaActualPais;
                    usuario.EstadoPedido = configuracionConsultora.EstadoPedido;
                    usuario.ValidacionAbierta = configuracionConsultora.ValidacionAbierta;
                    usuario.AceptacionConsultoraDA = configuracionConsultora.AceptacionConsultoraDA;
                }

                if (usuario.TipoUsuario == Constantes.TipoUsuario.Postulante)
                {
                    var postulante = GetUsuarioPostulante(paisID, codigoUsuario);

                    if (postulante != null)
                    {
                        usuario.ZonaID = postulante.ZonaID;
                        usuario.RegionID = postulante.RegionID;
                        usuario.ConsultoraID = postulante.ConsultoraID;
                        usuario.Seccion = postulante.Seccion;
                        usuario.CodigorRegion = postulante.Region;
                        usuario.CodigoZona = postulante.CodigoZona;

                        var configuracion = GetConfiguracionCampania(usuario, Constantes.TipoUsuario.Postulante);

                        if (configuracion != null)
                        {
                            usuario.CampaniaID = configuracion.CampaniaID;
                            usuario.ZonaHoraria = configuracion.ZonaHoraria;
                            usuario.FechaInicioFacturacion = configuracion.FechaInicioFacturacion;
                            usuario.AceptacionConsultoraDA = configuracion.AceptacionConsultoraDA;
                            usuario.HoraFin = configuracion.HoraFin;
                            usuario.EsZonaDemAnti = configuracion.EsZonaDemAnti;
                            usuario.HoraCierreZonaNormal = configuracion.HoraCierreZonaNormal;
                            usuario.HoraCierreZonaDemAnti = configuracion.HoraCierreZonaDemAnti;
                            usuario.DiasAntes = configuracion.DiasAntes;
                            usuario.HoraInicio = configuracion.HoraInicio;
                            usuario.HoraInicioNoFacturable = configuracion.HoraInicioNoFacturable;
                            usuario.FechaFinFacturacion = configuracion.FechaFinFacturacion;
                            usuario.CampaniaDescripcion = configuracion.CampaniaDescripcion;
                            usuario.ZonaValida = configuracion.ZonaValida;
                            usuario.NuevoPROL = true;
                            usuario.ZonaNuevoPROL = true;
                            usuario.IndicadorGPRSB = configuracion.IndicadorGPRSB;
                            usuario.ValidacionAbierta = configuracion.ValidacionAbierta;
                            usuario.EstadoPedido = configuracion.EstadoPedido;
                            usuario.FechaActualPais = configuracion.FechaActualPais;
                        }
                    }
                }

                var terminosCondicionesTask = Task.Run(() => GetTerminosCondiciones(paisID, usuario.CodigoConsultora, Constantes.TipoTerminosCondiciones.AppTerminosCondiciones));
                var politicaPrivacidadTask = Task.Run(() => GetTerminosCondiciones(paisID, usuario.CodigoConsultora, Constantes.TipoTerminosCondiciones.AppPoliticaPrivacidad));
                var destinatariosFeedBack = Task.Run(() => _tablaLogicaDatosBusinessLogic.GetTablaLogicaDatos(paisID, Constantes.TablaLogica.CorreoFeedbackAppConsultora));
                var gprBannerTask = Task.Run(() => GetGPRBanner(usuario));
                var usuarioConsultoraTask = Task.Run(() => GetUsuarioConsultora(usuario));
                var consultoraAniversarioTask = Task.Run(() => GetConsultoraAniversario(usuario));
                var consultoraCumpleanioTask = Task.Run(() => GetConsultoraCumpleanio(usuario));
                var incentivosConcursosTask = Task.Run(() => GetIncentivosConcursos(usuario));
                var revistaDigitalSuscripcionTask = Task.Run(() => GetRevistaDigitalSuscripcion(usuario));
                var cuponTask = Task.Run(() => GetCupon(usuario));
                var programaNuevasTask = Task.Run(() => GetProgramaNuevas(usuario));
                var nivelProyectado = Task.Run(() => GetNivelProyectado(paisID,usuario.ConsultoraID,usuario.CampaniaID));

                Task.WaitAll(
                                terminosCondicionesTask,
                                politicaPrivacidadTask,
                                destinatariosFeedBack,
                                gprBannerTask,
                                usuarioConsultoraTask,
                                consultoraAniversarioTask,
                                consultoraCumpleanioTask,
                                incentivosConcursosTask,
                                revistaDigitalSuscripcionTask,
                                cuponTask,
                                programaNuevasTask,
                                nivelProyectado);

                if (!Common.Util.IsUrl(usuario.FotoPerfil) && !string.IsNullOrEmpty(usuario.FotoPerfil))
                    usuario.FotoPerfil = string.Concat(ConfigCdn.GetUrlCdn(Dictionaries.FileManager.Configuracion[Dictionaries.FileManager.TipoArchivo.FotoPerfilConsultora]), usuario.FotoPerfil);

                usuario.AceptaTerminosCondiciones = (terminosCondicionesTask.Result != null && terminosCondicionesTask.Result.Aceptado);
                usuario.AceptaPoliticaPrivacidad = (politicaPrivacidadTask.Result != null && politicaPrivacidadTask.Result.Aceptado);
                usuario.DestinatariosFeedback = string.Join(";", destinatariosFeedBack.Result.Select(x => x.Descripcion));

                usuario.GPRMostrarBannerRechazo = gprBannerTask.Result.MostrarBannerRechazo;
                usuario.GPRBannerTitulo = gprBannerTask.Result.BannerTitulo;
                usuario.GPRBannerMensaje = gprBannerTask.Result.BannerMensaje;
                usuario.GPRBannerUrl = gprBannerTask.Result.BannerUrl;
                usuario.GPRTextovinculo = (gprBannerTask.Result.BannerUrl == Enumeradores.RechazoBannerUrl.ModificaPedido ? gprBannerTask.Result.Textovinculo : string.Empty);

                usuario.DiasCierre = usuarioConsultoraTask.Result.DiasCierre;
                usuario.FechaVencimiento = usuarioConsultoraTask.Result.FechaVencimiento;

                usuario.EsAniversario = consultoraAniversarioTask.Result.Count == 2 ? (bool)consultoraAniversarioTask.Result[0] : false;
                usuario.EsCumpleanio = consultoraCumpleanioTask.Result;
                usuario.AniosPermanencia = consultoraAniversarioTask.Result.Count == 2 ? (int)consultoraAniversarioTask.Result[1] : 0;

                usuario.CodigosConcursos = incentivosConcursosTask.Result.Count == 2 ? incentivosConcursosTask.Result[0] : string.Empty;
                usuario.CodigosProgramaNuevas = incentivosConcursosTask.Result.Count == 2 ? incentivosConcursosTask.Result[1] : string.Empty;

                usuario.RevistaDigitalSuscripcion = revistaDigitalSuscripcionTask.Result.Count == 3 ? (short)revistaDigitalSuscripcionTask.Result[0] : Constantes.GanaMas.PaisSinRD;
                usuario.UrlBannerGanaMas = revistaDigitalSuscripcionTask.Result.Count == 3 ? (string)revistaDigitalSuscripcionTask.Result[1] : string.Empty;
                usuario.TieneGND = revistaDigitalSuscripcionTask.Result.Count == 3 ? (bool)revistaDigitalSuscripcionTask.Result[2] : false;

                usuario.CuponEstado = cuponTask.Result.EstadoCupon;
                usuario.CuponPctDescuento = cuponTask.Result.ValorAsociado;
                usuario.CuponMontoMaxDscto = cuponTask.Result.MontoMaximoDescuento;
                usuario.CuponTipoCondicion = cuponTask.Result.TipoCondicion;

                var programaNuevas = programaNuevasTask.Result;
                if (programaNuevas != null)
                {
                    usuario.ConsecutivoNueva = programaNuevas.ConsecutivoNueva;
                    usuario.CodigoPrograma = programaNuevas.CodigoPrograma ?? string.Empty;
                }

                usuario.NivelProyectado = nivelProyectado.Result;

                return usuario;
            }
            catch (Exception ex)
            {
                LogManager.SaveLog(ex, codigoUsuario, paisID);
            }

            return usuario;
        }

        private BEUsuarioExterno GetUsuarioExterno(BEUsuario usuario, string proveedor)
        {
            BEUsuarioExterno beUsuarioExterno = null;

            if (!usuario.TieneLoginExterno) return null;

            var listaLoginExterno = this.GetListaLoginExterno(usuario.PaisID, usuario.CodigoUsuario);
            if (listaLoginExterno.Any())
                beUsuarioExterno = listaLoginExterno.FirstOrDefault(x => x.Proveedor == proveedor);

            return beUsuarioExterno;
        }

        private BEGPRBanner GetGPRBanner(BEUsuario usuario)
        {
            var result = new BEGPRBanner();

            try
            {
                var montoDeuda = _resumenCampaniaBusinessLogic.GetMontoDeuda(usuario.PaisID, usuario.CampaniaID, (int)usuario.ConsultoraID, usuario.CodigoUsuario, false);

                var beGprUsuario = new BEGPRUsuario()
                {
                    IndicadorGPRSB = usuario.IndicadorGPRSB,
                    CampaniaID = usuario.CampaniaID,
                    PaisID = usuario.PaisID,
                    ConsultoraID = usuario.ConsultoraID,
                    MontoDeuda = montoDeuda,
                    Simbolo = usuario.Simbolo,
                    CodigoISO = usuario.CodigoISO,
                    MontoMinimoPedido = usuario.MontoMinimoPedido,
                    MontoMaximoPedido = usuario.MontoMaximoPedido,
                    ValidacionAbierta = usuario.ValidacionAbierta,
                    EstadoPedido = usuario.EstadoPedido
                };

                result = _pedidoRechazadoBusinessLogic.GetMotivoRechazo(beGprUsuario);
            }
            catch (Exception ex)
            {
                LogManager.SaveLog(ex, CodigoUsuarioLog, PaisIDLog);
            }

            return result;
        }

        private BEUsuario GetUsuarioConsultora(BEUsuario usuario)
        {
            var consultora = new BEUsuario();

            try
            {
                if (usuario.RolID == Constantes.TipoUsuario.Consultora)
                {
                    DateTime fechaHoy = DateTime.Now.AddHours(usuario.ZonaHoraria).Date;
                    DateTime fechaFin = usuario.FechaInicioFacturacion;
                    consultora.DiasCierre = fechaHoy >= fechaFin.Date ? 0 : (fechaFin.Subtract(DateTime.Now.AddHours(usuario.ZonaHoraria)).Days + 1);

                    if (usuario.TieneHana == 1)
                    {
                        var beUsuarioDatosHana = this.GetDatosConsultoraHana(usuario.PaisID, usuario.CodigoUsuario, usuario.CampaniaID);
                        if (beUsuarioDatosHana != null) consultora.FechaVencimiento = beUsuarioDatosHana.FechaLimPago.ToString("dd/MM/yyyy");
                    }
                    else
                    {
                        consultora.FechaVencimiento = usuario.FechaLimPago.ToString("dd/MM/yyyy");
                    }
                }
            }
            catch (Exception ex)
            {
                LogManager.SaveLog(ex, CodigoUsuarioLog, PaisIDLog);
            }

            return consultora;
        }

        private BEUsuario GetUsuario(int paisID, string codigoUsuario)
        {
            using (var reader = new DAUsuario(paisID).GetSesionUsuario(codigoUsuario))
            {
                return reader.MapToObject<BEUsuario>(true);
            }
        }

        private BEConfiguracionCampania GetConfiguracionCampania(BEUsuario beUsuario, int tipoUsuario)
        {
            BEConfiguracionCampania beConfiguracionCampania = null;
            var daConfiguracionCampania = new DAConfiguracionCampania(beUsuario.PaisID);

            if (tipoUsuario == Constantes.TipoUsuario.Consultora)
            {
                using (var reader = daConfiguracionCampania.GetConfiguracionCampania(beUsuario.PaisID, beUsuario.ZonaID, beUsuario.RegionID, beUsuario.ConsultoraID))
                {
                    beConfiguracionCampania = reader.MapToObject<BEConfiguracionCampania>(true);
                }
            }
            else if (tipoUsuario == Constantes.TipoUsuario.Postulante)
            {
                using (var reader = daConfiguracionCampania.GetConfiguracionCampaniaNoConsultora(beUsuario.PaisID, beUsuario.ZonaID, beUsuario.RegionID))
                {
                    beConfiguracionCampania = reader.MapToObject<BEConfiguracionCampania>(true);
                }
            }

            return beConfiguracionCampania;
        }

        private List<object> GetConsultoraAniversario(BEUsuario usuario)
        {
            var resultado = new List<object>();
            bool esAniversario = false;
            int aniosPermanencia = 0;

            try
            {
                if (usuario.RolID == Constantes.Rol.Consultora)
                {
                    if (usuario.ConsultoraNueva != Constantes.EstadoActividadConsultora.Registrada && usuario.ConsultoraNueva != Constantes.EstadoActividadConsultora.Ingreso_Nueva)
                    {
                        if (usuario.CampaniaDescripcion != null && usuario.AnoCampaniaIngreso.Trim() != "")
                        {
                            int campaniaActual = int.Parse(usuario.CampaniaDescripcion);
                            int campaniaIngreso = int.Parse(usuario.AnoCampaniaIngreso);
                            int diferencia = campaniaActual - campaniaIngreso;
                            if (diferencia >= 12)
                            {
                                if (usuario.AnoCampaniaIngreso.Trim().EndsWith(usuario.CampaniaDescripcion.Trim().Substring(4)))
                                {
                                    esAniversario = true;
                                    int anioActual = int.Parse(usuario.CampaniaDescripcion.Substring(0, 4));
                                    int anioIngreso = int.Parse(usuario.AnoCampaniaIngreso.Substring(0, 4));
                                    aniosPermanencia = anioActual - anioIngreso;
                                }
                            }
                        }
                    }
                }
            }
            catch (Exception ex)
            {
                LogManager.SaveLog(ex, CodigoUsuarioLog, PaisIDLog);
            }

            resultado.Add(esAniversario);
            resultado.Add(aniosPermanencia);

            return resultado;
        }

        private bool GetConsultoraCumpleanio(BEUsuario usuario)
        {
            bool esCumpleanio = false;

            var uFechaNacimiento = usuario.FechaNacimiento;
            var uFechaActual = usuario.FechaActualPais;

            if (uFechaNacimiento.Date != uFechaActual.Date)
            {
                if (uFechaNacimiento.Month == uFechaActual.Month && uFechaNacimiento.Day == uFechaActual.Day) esCumpleanio = true;
            }

            return esCumpleanio;
        }

        private List<string> GetIncentivosConcursos(BEUsuario usuario)
        {
            var lstConcursos = new List<string>();

            try
            {
                if (usuario.TipoUsuario == Constantes.TipoUsuario.Postulante) return lstConcursos;

                var arrCalculoPuntos = Constantes.Incentivo.CalculoPuntos.Split(';');
                var arrCalculoProgramaNuevas = Constantes.Incentivo.CalculoProgramaNuevas.Split(';');

                var result = _consultoraConcursoBusinessLogic.ObtenerConcursosXConsultora(usuario.PaisID, usuario.CampaniaDescripcion, usuario.CodigoConsultora, usuario.CodigorRegion, usuario.CodigoZona);

                if (result.Any())
                {
                    var concursos = result.Where(x => arrCalculoPuntos.Contains(x.TipoConcurso));
                    lstConcursos.Add(string.Join("|", concursos.Select(c => c.CodigoConcurso)));

                    var programaNuevas = result.Where(x => arrCalculoProgramaNuevas.Contains(x.TipoConcurso));
                    lstConcursos.Add(string.Join("|", programaNuevas.Select(c => c.CodigoConcurso)));
                }
            }
            catch (Exception ex)
            {
                LogManager.SaveLog(ex, CodigoUsuarioLog, PaisIDLog);
            }

            return lstConcursos;
        }

        private List<object> GetRevistaDigitalSuscripcion(BEUsuario usuario)
        {
            var lst = new List<object>();

            try
            {
                var resultado = Constantes.GanaMas.PaisSinRD;
                var UrlBannerGanaMas = string.Empty;
                var tieneGND = false;

                var configPais = new BEConfiguracionPais()
                {
                    Detalle = new BEConfiguracionPaisDetalle()
                    {
                        PaisID = usuario.PaisID,
                        CodigoRegion = usuario.CodigorRegion,
                        CodigoZona = usuario.CodigoZona,
                        CodigoSeccion = usuario.Seccion,
                        CodigoConsultora = usuario.CodigoConsultora
                    }
                };

                var lstCnfigPais = _configuracionPaisBusinessLogic.GetList(configPais);

                var configRD = lstCnfigPais.Where(x => x.Codigo == Constantes.ConfiguracionPais.RevistaDigital);

                if (configRD.Any())
                {
                    var oRequest = new BERevistaDigitalSuscripcion()
                    {
                        CodigoConsultora = usuario.CodigoConsultora,
                        PaisID = usuario.PaisID
                    };

                    var oResponse = _revistaDigitalSuscripcionBusinessLogic.GetLast(oRequest);

                    if (oResponse.RevistaDigitalSuscripcionID > 0)
                    {
                        if (oResponse.FechaSuscripcion > oResponse.FechaDesuscripcion)
                        {
                            if (oResponse.CampaniaEfectiva <= usuario.CampaniaID) resultado = Constantes.GanaMas.PaisConRD_SuscritaActiva;
                            else resultado = Constantes.GanaMas.PaisConRD_SuscritaNoActiva;
                        }
                        else if (oResponse.FechaSuscripcion < oResponse.FechaDesuscripcion)
                        {
                            if (oResponse.CampaniaEfectiva <= usuario.CampaniaID) resultado = Constantes.GanaMas.PaisConRD_NoSuscritaNoActiva;
                            else resultado = Constantes.GanaMas.PaisConRD_NoSuscritaActiva;
                        }
                    }
                    else
                    {
                        resultado = Constantes.GanaMas.PaisConRD_NoSuscritaNoActiva;
                    }
                }

                lst.Add(resultado);

                var tablaLogica = _tablaLogicaDatosBusinessLogic.GetTablaLogicaDatos(usuario.PaisID, Constantes.TablaLogica.ExtensionBannerGanaMasApp);
                var oSuscrita = tablaLogica.Where(x => x.Codigo == Constantes.GanaMas.Banner.TablaLogicaSuscrita).FirstOrDefault();
                var extensionSuscrita = oSuscrita == null ? string.Empty : oSuscrita.Descripcion;
                var oNoSuscrita = tablaLogica.Where(x => x.Codigo == Constantes.GanaMas.Banner.TablaLogicaNoSuscrita).FirstOrDefault();
                var extensionNoSuscrita = oNoSuscrita == null ? string.Empty : oNoSuscrita.Descripcion;

                var carpetaPais = string.Format(Constantes.GanaMas.Banner.CarpetaPais, usuario.CodigoISO);
                if ((resultado == Constantes.GanaMas.PaisConRD_SuscritaActiva || resultado == Constantes.GanaMas.PaisConRD_SuscritaNoActiva) && !string.IsNullOrEmpty(extensionSuscrita))
                    UrlBannerGanaMas = ConfigCdn.GetUrlFileCdn(carpetaPais, string.Format("{0}.{1}", Constantes.GanaMas.Banner.ImagenSuscrita, extensionSuscrita));
                else if ((resultado == Constantes.GanaMas.PaisConRD_NoSuscritaActiva || resultado == Constantes.GanaMas.PaisConRD_NoSuscritaNoActiva) && !string.IsNullOrEmpty(extensionNoSuscrita))
                    UrlBannerGanaMas = ConfigCdn.GetUrlFileCdn(carpetaPais, string.Format("{0}.{1}", Constantes.GanaMas.Banner.ImagenNoSuscrita, extensionNoSuscrita));

                lst.Add(UrlBannerGanaMas);

                if (resultado == Constantes.GanaMas.PaisSinRD || resultado == Constantes.GanaMas.PaisConRD_NoSuscritaActiva || resultado == Constantes.GanaMas.PaisConRD_NoSuscritaNoActiva)
                {
                    var configGND = lstCnfigPais.Where(x => x.Codigo == Constantes.ConfiguracionPais.GuiaDeNegocioDigitalizada);
                    tieneGND = configGND.Any();
                }

                lst.Add(tieneGND);
            }
            catch (Exception ex)
            {
                LogManager.SaveLog(ex, CodigoUsuarioLog, PaisIDLog);
            }

            return lst;
        }

        private BECuponConsultora GetCupon(BEUsuario usuario)
        {
            decimal MontoMaximoDescuento = 0;
            var oResponse = new BECuponConsultora();

            try
            {
                var oRequest = new BECuponConsultora()
                {
                    CodigoConsultora = usuario.CodigoConsultora,
                    CampaniaId = usuario.CampaniaID
                };

                oResponse = _cuponConsultoraBusinessLogic.GetCuponConsultoraByCodigoConsultoraCampaniaId(usuario.PaisID, oRequest);
                if (oResponse != null)
                {
                    var lst = _tablaLogicaDatosBusinessLogic.GetTablaLogicaDatos(usuario.PaisID, Constantes.TablaLogica.MontoLimiteCupon);
                    var result = lst.Where(x => x.Codigo == usuario.CampaniaID.ToString()).FirstOrDefault();
                    if (result != null)
                    {
                        decimal.TryParse(result.Descripcion, out MontoMaximoDescuento);
                        oResponse.MontoMaximoDescuento = MontoMaximoDescuento;
                    }
                }
            }
            catch (Exception ex)
            {
                LogManager.SaveLog(ex, CodigoUsuarioLog, PaisIDLog);
            }

            return oResponse ?? new BECuponConsultora();
        }

        public BEConsultorasProgramaNuevas GetProgramaNuevas(BEUsuario usuario)
        {
            BEConsultorasProgramaNuevas beConsultoraProgramaNuevas = null;

            try
            {
                using (IDataReader reader = new DAConsultorasProgramaNuevas(usuario.PaisID).GetConsultorasProgramaNuevasByConsultoraId(usuario.ConsultoraID))
                {
                    beConsultoraProgramaNuevas = reader.MapToObject<BEConsultorasProgramaNuevas>(true);
                }
            }
            catch (Exception ex)
            {
                LogManager.SaveLog(ex, CodigoUsuarioLog, PaisIDLog);
            }

            return beConsultoraProgramaNuevas;
        }

        public string GetUsuarioAsociado(int paisID, string codigoConsultora)
        {
            var daUsuario = new DAUsuario(paisID);
            return daUsuario.GetUsuarioAsociado(codigoConsultora);
        }

        public string GetUsuarioPermisos(int paisID, string codigoUsuario, string codigoConsultora, short tipoUsuario, short rolID)
        {
            var daUsuario = new DAUsuario(paisID);
            return daUsuario.GetUsuarioPermisos(paisID, codigoUsuario, codigoConsultora, tipoUsuario, rolID);
        }

        public bool IsUserExist(int paisID, string CodigoUsuario)
        {
            var daUsuario = new DAUsuario(paisID);
            var existe = false;

            using (IDataReader reader = daUsuario.GetUsuario(CodigoUsuario))
            {
                if (reader.Read())
                    existe = true;
            }

            return existe;
        }

        public string IsConsultoraExist(int paisID, string CodigoConsultora)
        {
            var daUsuario = new DAUsuario(paisID);

            var retorno = "0|0";
            using (IDataReader reader = daUsuario.GetUsuarioByConsultora(CodigoConsultora))
            {
                if (reader.Read())
                    retorno = "1" + "|" + reader["CodigoUsuario"].ToString();
            }

            return retorno;
        }

        public bool ChangePasswordUser(int paisID, string codigoUsuarioAutenticado, string emailCodigoUsuarioModificado, string password, string emailUsuarioModificado, EAplicacionOrigen origen)
        {
            var daUsuario = new DAUsuario(paisID);
            daUsuario.InsLogCambioContrasenia(codigoUsuarioAutenticado, emailCodigoUsuarioModificado, password, emailUsuarioModificado, Enum.GetName(typeof(EAplicacionOrigen), origen));

            return true;
        }

        public int ValidarEmailConsultora(int PaisID, string Email, string CodigoUsuario)
        {
            var daUsuario = new DAUsuario(PaisID);
            return daUsuario.ValidarEmailConsultora(Email, CodigoUsuario);
        }

        public int ValidarTelefonoConsultora(int PaisID, string Telefono, string CodigoUsuario)
        {
            var daUsuario = new DAUsuario(PaisID);
            return daUsuario.ValidarTelefonoConsultora(Telefono, CodigoUsuario);
        }

        public List<int> GetEstadosRestringidos(int paisID)
        {
            List<int> estadosRestringidos = new List<int>();

            var daUsuario = new DAUsuario(paisID);
            using (IDataReader reader = daUsuario.GetEstadosRestringidos())
                while (reader.Read())
                {
                    estadosRestringidos.Add(Convert.ToInt32(reader["estados"] != DBNull.Value ? reader["estados"] : 0));
                }
            return estadosRestringidos;
        }

        public int UpdActualizarDatos(int paisID, string CodigoUsuario, string Email, string Celular, string Telefono)
        {
            var daUsuario = new DAUsuarioOP(paisID);
            return daUsuario.UpdActualizarDatos(CodigoUsuario, Email, Celular, Telefono);
        }

        public string GetNroDocumentoConsultora(int paisID, string CodigoConsultora)
        {
            var daUsuario = new DAUsuario(paisID);
            return daUsuario.GetNroDocumentoConsultora(CodigoConsultora);
        }

        public BEValidaLoginSB2 GetValidarLoginSB2(int paisID, string codigoUsuario, string contrasenia)
        {
            BEValidaLoginSB2 validaLogin = null;
            string paisIso = string.Empty;

            try
            {
                paisIso = Common.Util.GetPaisISO(paisID);
                paisIso = (!string.IsNullOrEmpty(paisIso)) ? paisIso : paisID.ToString();
                var daUsuario = new DAUsuario(paisID);

                using (IDataReader reader = daUsuario.GetValidarLoginSB2(codigoUsuario, contrasenia))
                {
                    if (reader.Read())
                        validaLogin = new BEValidaLoginSB2(reader);
                }
            }
            catch (Exception ex)
            {
                LogManager.SaveLog(ex, codigoUsuario, paisIso);
            }

            return validaLogin;
        }

        public BEValidaLoginSB2 GetValidarLoginJsonWebToken(int paisID, string documento)
        {
            BEValidaLoginSB2 validaLogin = null;
            string paisIso = string.Empty;

            try
            {
                paisIso = Common.Util.GetPaisISO(paisID);
                paisIso = (!string.IsNullOrEmpty(paisIso)) ? paisIso : paisID.ToString();
                var daUsuario = new DAUsuario(paisID);

                using (IDataReader reader = daUsuario.GetValidarLoginJsonWebToken(documento))
                {
                    if (reader.Read())
                        validaLogin = new BEValidaLoginSB2(reader);
                }
            }
            catch (Exception ex)
            {
                LogManager.SaveLog(ex, documento, paisIso);
            }

            return validaLogin;
        }

        public BEValidaLoginSB2 GetValidarAutoLogin(int paisID, string codigoUsuario, string proveedor)
        {
            BEValidaLoginSB2 validaLogin = null;
            string paisIso = string.Empty;

            try
            {
                paisIso = Common.Util.GetPaisISO(paisID);
                paisIso = (!string.IsNullOrEmpty(paisIso)) ? paisIso : paisID.ToString();
                var daUsuario = new DAUsuario(paisID);

                using (IDataReader reader = daUsuario.GetValidarAutoLogin(codigoUsuario, proveedor))
                {
                    if (reader.Read())
                        validaLogin = new BEValidaLoginSB2(reader);
                }
            }
            catch (Exception ex)
            {
                LogManager.SaveLog(ex, codigoUsuario, paisIso);
            }

            return validaLogin;
        }

        public int InsUsuarioExternoPais(int paisID, BEUsuarioExternoPais entidad)
        {
            var daUsuario = new DAUsuario(paisID);

            return daUsuario.InsUsuarioExternoPais(entidad);
        }

        public int GetInfoPreLogin(int paisID, string CodigoUsuario)
        {
            int result;
            string usuario = string.Empty;
            int rolId = 0;
            string autorizaPedido = string.Empty;
            int idEstadoActividad = -1;
            int ultimaCampania = 0;
            int campaniaActual = 0;

            var daUsuario = new DAUsuario(paisID);
            using (IDataReader reader = daUsuario.GetInfoPreLogin(CodigoUsuario))
            {
                if (reader.Read())
                {
                    usuario = Convert.ToString(reader["CodigoUsuario"]);
                    rolId = Convert.ToInt32(reader["RolId"]);
                    idEstadoActividad = Convert.ToInt32(reader["IdEstadoActividad"]);
                    autorizaPedido = Convert.ToString(reader["AutorizaPedido"]);
                    ultimaCampania = Convert.ToInt32(reader["UltimaCampania"]);
                    campaniaActual = Convert.ToInt32(reader["CampaniaActual"]);
                }
            }

            //0: Usuario No Existe
            //1: Usuario No es del Portal
            //2: Usuario Esta dentro de la Lista / Autoriza Pedido NULL o N
            //3: Usuario OK

            BLTablaLogicaDatos oblTablaLogicaDatos = new BLTablaLogicaDatos();
            List<BETablaLogicaDatos> tablaRetirada = oblTablaLogicaDatos.GetTablaLogicaDatos(paisID, 12);
            List<BETablaLogicaDatos> tablaReingresada = oblTablaLogicaDatos.GetTablaLogicaDatos(paisID, 18);
            List<BETablaLogicaDatos> tablaEgresada = oblTablaLogicaDatos.GetTablaLogicaDatos(paisID, 19);

            if (!string.IsNullOrEmpty(usuario))
            {
                if (rolId != 0)
                {
                    if (!string.IsNullOrEmpty(autorizaPedido))
                    {
                        if (idEstadoActividad != -1)
                        {
                            // Validamos si pertenece a Peru, Bolivia, Chile, Guatemala, El Salvador, Colombia (Paises ESIKA)
                            if (paisID == 11 || paisID == 2 || paisID == 3 || paisID == 8 || paisID == 7 || paisID == 4)
                            {
                                //Validamos si el estado es retirada
                                BETablaLogicaDatos restriccion = tablaRetirada.Find(p => Convert.ToInt32(p.Codigo.Trim()) == idEstadoActividad);
                                if (restriccion != null)
                                {
                                    //Validamos si el pais es SICC
                                    if (paisID == 11 || paisID == 3 || paisID == 8 || paisID == 7 || paisID == 4)
                                    {
                                        //Caso Colombia
                                        if (paisID == 4)
                                            return 2;
                                        else
                                        {
                                            if (autorizaPedido == "N")
                                                return 2;
                                            else
                                                return 3;
                                        }
                                    }
                                    else
                                    {
                                        //Para bolivia (FOX) se hace la validación del campo AutorizaPedido
                                        if (paisID == 2)
                                        {
                                            if (autorizaPedido == "N")
                                                return 2;
                                            else
                                                return 3;
                                        }
                                        else
                                        {
                                            return 3;
                                        }
                                    }
                                }
                                else
                                {
                                    //Validamos si el estado es reingresada
                                    BETablaLogicaDatos restriccionReingreso = tablaReingresada.Find(p => Convert.ToInt32(p.Codigo.Trim()) == idEstadoActividad);
                                    if (restriccionReingreso != null)
                                    {
                                        if (paisID == 3)
                                        {
                                            //Se valida las campañas que no ha ingresado
                                            if (ultimaCampania != 0 && campaniaActual.ToString().Length == 6 && ultimaCampania.ToString().Length == 6)
                                            {
                                                string ca = campaniaActual.ToString().Substring(0, 4);
                                                string uc = ultimaCampania.ToString().Substring(0, 4);
                                                if (ca != uc)
                                                {
                                                    ca = campaniaActual.ToString().Substring(4, 2);
                                                    uc = ultimaCampania.ToString().Substring(4, 2);
                                                    campaniaActual = Convert.ToInt32(uc) + Convert.ToInt16(ca);
                                                    ultimaCampania = Convert.ToInt32(uc);
                                                }
                                            }

                                            if (campaniaActual - ultimaCampania > 3 && ultimaCampania != 0)
                                                return 2;
                                            else
                                            {
                                                //Validamos el Autoriza Pedido
                                                if (autorizaPedido == "N")
                                                    return 2;
                                                else
                                                    return 3;
                                            }
                                        }
                                        else
                                        {
                                            //Caso Colombia
                                            if (paisID == 4)
                                                return 2;
                                            else
                                            {
                                                if (autorizaPedido == "N")
                                                {
                                                    //Validamos si es SICC o Bolivia
                                                    if (paisID == 11 || paisID == 3 || paisID == 8 || paisID == 7 || paisID == 2)
                                                        return 2;
                                                    else
                                                        return 3;
                                                }
                                                else
                                                    return 3;
                                            }
                                        }
                                    }
                                    else
                                    {
                                        //Caso Colombia
                                        if (paisID == 4)
                                        {
                                            //Egresada o Posible Egreso
                                            BETablaLogicaDatos restriccionEgresada = tablaEgresada.Find(p => Convert.ToInt32(p.Codigo.Trim()) == idEstadoActividad);
                                            if (restriccionEgresada != null)
                                            {
                                                return 2;
                                            }
                                        }

                                        //Validamos el Autoriza Pedido
                                        if (autorizaPedido == "N")
                                        {
                                            //Validamos si es SICC o Bolivia
                                            if (paisID == 11 || paisID == 3 || paisID == 8 || paisID == 7 || paisID == 2 || paisID == 4)
                                                return 2;
                                            else
                                                return 3;
                                        }
                                        else
                                            return 3;

                                    }
                                }
                            }
                            // Validamos si pertenece a Costa Rica, Panama, Mexico, Puerto Rico, Dominicana, Ecuador, Argentina (Paises MyLbel)
                            else if (paisID == 5 || paisID == 10 || paisID == 9 || paisID == 12 || paisID == 13 || paisID == 6 || paisID == 1 || paisID == 14)
                            {
                                // Validamos si la consultora es retirada
                                BETablaLogicaDatos restriccion = tablaRetirada.Find(p => Convert.ToInt32(p.Codigo.Trim()) == idEstadoActividad);
                                if (restriccion != null)
                                {
                                    //Validamos si el pais es SICC
                                    if (paisID == 5 || paisID == 10 || paisID == 6 || paisID == 14)
                                    {
                                        //Validamos el Autoriza Pedido
                                        if (autorizaPedido == "N")
                                        {
                                            return 2;
                                        }
                                        else
                                            return 3;
                                    }
                                    else
                                    {
                                        //Se valida las campañas que no ha ingresado
                                        //Validamos el Autoriza Pedido
                                        if (autorizaPedido == "N")
                                        {
                                            return 2;
                                        }
                                        else
                                            return 3;
                                    }
                                }
                                else
                                {
                                    //Validamos si el estado es retirada
                                    BETablaLogicaDatos restriccionEgresada = tablaEgresada.Find(p => Convert.ToInt32(p.Codigo.Trim()) == idEstadoActividad);
                                    if (restriccionEgresada != null)
                                    {
                                        if (autorizaPedido == "N")
                                        {
                                            //Validamos si es SICC
                                            if (paisID == 5 || paisID == 10 || paisID == 6 || paisID == 14 || paisID == 9 || paisID == 12 || paisID == 13)
                                                return 2;
                                            else
                                                return 3;
                                        }
                                        else
                                            return 3;
                                    }
                                    else
                                    {
                                        //Validamos el Autoriza Pedido
                                        if (autorizaPedido == "N")
                                        {
                                            //Validamos si es SICC
                                            if (paisID == 5 || paisID == 10 || paisID == 6 || paisID == 14 || paisID == 9 || paisID == 12 || paisID == 13)
                                                return 2;
                                            else
                                                return 3;
                                        }
                                        else
                                            return 3;
                                    }
                                }
                            }
                            else
                                result = 3;
                        }
                        else
                            result = 3; //Se asume para usuarios del tipo SAC
                    }
                    else
                        result = 3; //Se asume para usuarios del tipo SAC
                }
                else
                    result = 1;
            }
            else
                result = 0;

            return result;
        }

        public int GetInfoPreLoginConsultoraCatalogo(int paisID, string CodigoUsuario)
        {
            string usuario = string.Empty;
            int rolId = 0;
            string autorizaPedido = string.Empty;
            bool autorizado = false;
            int idEstadoActividad = -1;
            int ultimaCampania = 0;
            int campaniaActual = 0;

            var daUsuario = new DAUsuario(paisID);
            using (IDataReader reader = daUsuario.GetInfoPreLoginConsultoraCatalogo(CodigoUsuario))
            {
                if (reader.Read())
                {
                    usuario = Convert.ToString(reader["CodigoUsuario"]);
                    rolId = Convert.ToInt32(reader["RolId"]);
                    idEstadoActividad = Convert.ToInt32(reader["IdEstadoActividad"]);
                    autorizaPedido = Convert.ToString(reader["AutorizaPedido"]);
                    var esAfiliado = Convert.ToBoolean(reader["EsAfiliado"]);
                    ultimaCampania = Convert.ToInt32(reader["UltimaCampania"]);
                    campaniaActual = Convert.ToInt32(reader["CampaniaActual"]);
                    autorizado = (autorizaPedido != "N" && esAfiliado);
                }
            }

            //0: Usuario No Existe
            //1: Usuario No es del Portal
            //2: Usuario Esta dentro de la Lista / Autoriza Pedido NULL o N
            //3: Usuario OK

            int nroCampanias = new BLZonificacion().GetPaisNumeroCampaniasByPaisID(paisID);
            BLTablaLogicaDatos oblTablaLogicaDatos = new BLTablaLogicaDatos();
            List<BETablaLogicaDatos> tablaRetirada = oblTablaLogicaDatos.GetTablaLogicaDatos(paisID, 12);
            List<BETablaLogicaDatos> tablaReingresada = oblTablaLogicaDatos.GetTablaLogicaDatos(paisID, 18);
            List<BETablaLogicaDatos> tablaEgresada = oblTablaLogicaDatos.GetTablaLogicaDatos(paisID, 19);

            if (string.IsNullOrEmpty(usuario)) return 0;
            if (string.IsNullOrEmpty(autorizaPedido)) return 0; //Se asume para usuarios del tipo SAC
            if (rolId == 0) return 1;
            if (idEstadoActividad == -1) return 3; //Se asume para usuarios del tipo SAC

            // Validamos si pertenece a Peru, Bolivia, Chile, Guatemala, El Salvador, Colombia (Paises ESIKA)
            if (paisID == 11 || paisID == 2 || paisID == 3 || paisID == 8 || paisID == 7 || paisID == 4)
            {
                //Validamos si el estado es retirada
                BETablaLogicaDatos restriccion = tablaRetirada.Find(p => Convert.ToInt32(p.Codigo.Trim()) == idEstadoActividad);
                if (restriccion != null)
                {
                    if (paisID == 4) return 2; //Caso Colombia
                    return autorizado ? 3 : 2;
                }

                //Validamos si el estado es reingresada
                BETablaLogicaDatos restriccionReingreso = tablaReingresada.Find(p => Convert.ToInt32(p.Codigo.Trim()) == idEstadoActividad);
                if (restriccionReingreso != null)
                {
                    if (paisID == 3)
                    {
                        //Se valida las campañas que no ha ingresado
                        int campaniaSinIngresar = 0;
                        if (campaniaActual.ToString().Length == 6 && ultimaCampania.ToString().Length == 6)
                        {
                            campaniaSinIngresar = campaniaActual - Common.Util.AddCampaniaAndNumero(ultimaCampania, 3, nroCampanias);
                        }
                        if (campaniaSinIngresar > 0) return 2;
                    }
                    else if (paisID == 4) return 2; //Caso Colombia
                }
                else if (paisID == 4) //Caso Colombia
                {
                    //Egresada o Posible Egreso
                    BETablaLogicaDatos restriccionEgresada = tablaEgresada.Find(p => Convert.ToInt32(p.Codigo.Trim()) == idEstadoActividad);
                    if (restriccionEgresada != null) return 2;
                }
                return autorizado ? 3 : 2;
            }
            // Validamos si pertenece a Costa Rica, Panama, Mexico, Puerto Rico, Dominicana, Ecuador, Argentina (Paises MyLbel)
            else if (paisID == 5 || paisID == 10 || paisID == 9 || paisID == 12 || paisID == 13 || paisID == 6 || paisID == 1 || paisID == 14)
            {
                // Validamos si la consultora es retirada
                BETablaLogicaDatos restriccion = tablaRetirada.Find(p => Convert.ToInt32(p.Codigo.Trim()) == idEstadoActividad);
                if (restriccion != null) return 2; //Validamos el Autoriza Pedido

                return autorizado ? 3 : 2; //Validamos el Autoriza Pedido
            }
            return 3;
        }

        public List<BEKitNueva> GetValidarConsultoraNueva(int paisID, string CodigoConsultora)
        {
            List<BEKitNueva> list = new List<BEKitNueva>();

            var daUsuario = new DAUsuario(paisID);
            using (IDataReader reader = daUsuario.GetValidarConsultoraNueva(CodigoConsultora))
                while (reader.Read())
                {
                    list.Add(new BEKitNueva(reader));
                }
            return list;
        }

        public int ValidarUsuarioPrueba(string CodigoUsuario, int paisID)
        {
            var daUsuario = new DAUsuario(paisID);
            return daUsuario.ValidarUsuarioPrueba(CodigoUsuario);
        }

        public int ValidarEnvioCatalogo(int paisID, string CodigoConsultora, int CampaniaActual, int Cantidad)
        {
            var daUsuario = new DAUsuario(paisID);
            return daUsuario.ValidarEnvioCatalogo(CodigoConsultora, CampaniaActual, Cantidad);
        }

        public int GetValidarColaboradorZona(int paisID, string CodigoZona)
        {
            var daUsuario = new DAUsuario(paisID);
            return daUsuario.GetValidarColaboradorZona(CodigoZona);
        }

        public DateTime GetFechaFacturacion(string CampaniaCodigo, int ZonaID, int PaisID)
        {
            var daUsuario = new DAUsuario(PaisID);
            return daUsuario.GetFechaFacturacion(CampaniaCodigo, ZonaID, PaisID);
        }

        public void UpdateIndicadorAyudaWebTracking(int paisID, string codigoConsultora, bool indicador)
        {
            var daUsuario = new DAUsuario(paisID);
            daUsuario.UpdateIndicadorAyudaWebTracking(codigoConsultora, indicador);
        }

        public void InsLogIngresoPortal(int paisID, string CodigoConsultora, string IPOrigen, byte Tipo, string DetalleError, string Canal)
        {
            var daUsuario = new DAUsuario(paisID);
            daUsuario.InsLogIngresoPortal(CodigoConsultora, IPOrigen, Tipo, DetalleError, Canal);
        }

        public BEUsuario GetSesionUsuarioLoginDD(int paisID, string codigoUsuario, string claveSecreta)
        {
            BEUsuario usuario = null;
            var daUsuario = new DAUsuario(paisID);

            using (IDataReader reader = daUsuario.GetSesionUsuarioLoginDD(codigoUsuario, claveSecreta))
                if (reader.Read())
                    usuario = new BEUsuario(reader);

            return usuario;
        }

        public List<BEUsuario> GetUsuarioDigitadorByFfVv(int paisID, string codigoFfvv)
        {
            List<BEUsuario> usuario = new List<BEUsuario>();

            var daUsuario = new DAUsuario(paisID);
            using (IDataReader reader = daUsuario.GetUsuarioDigitadorByFfVv(codigoFfvv))
                while (reader.Read())
                {
                    usuario.Add(new BEUsuario(reader));
                }
            return usuario;
        }

        public BEUsuario GetSesionUsuarioLoginDDByRol(int paisID, int rolID, string email)
        {
            BEUsuario beUsuario = null;
            DAUsuario daUsuario = new DAUsuario(paisID);

            using (IDataReader reader = daUsuario.GetSesionUsuarioLoginDDByRol(rolID, email))
                if (reader.Read())
                    beUsuario = new BEUsuario(reader);

            return beUsuario;
        }

        public void UpdUsuarioDigitador(BEUsuario usuario)
        {
            var daUsuario = new DAUsuario(usuario.PaisID);
            daUsuario.UpdUsuarioDigitador(usuario);
        }

        public List<BEUsuario> GetUsuario(int paisID, int rol, string codigoUsuario, string codigoFFVV, string nombres, bool estado)
        {

            List<BEUsuario> usuario = new List<BEUsuario>();
            var daUsuario = new DAUsuario(paisID);

            using (IDataReader reader = daUsuario.GetUsuario(rol, codigoUsuario, codigoFFVV, nombres, estado))
                while (reader.Read())
                {
                    usuario.Add(new BEUsuario(reader));
                }
            return usuario;
        }

        public void UpdUsuarioDD(BEUsuario usuario)
        {
            var daUsuario = new DAUsuario(usuario.PaisID);
            daUsuario.UpdUsuarioDD(usuario);
        }
        public int SelectDatosActualizados(int paisID, string codigoUsuario)
        {
            var daUsuario = new DAUsuario(paisID);
            if (daUsuario.GetUsuarioDatosActualizados(codigoUsuario).Read())
                return 0;
            else
                return 1;

        }
        public int SelectSegmento(int paisID, int segmentoID)
        {
            var daUsuario = new DAUsuario(paisID);
            if (daUsuario.GetSegmento(segmentoID).Read())
                return 1;
            else
                return 0;

        }
        public int SelectTiempo(int paisID)
        {
            var daUsuario = new DAUsuario(paisID);
            int tiempo = 0;
            if (daUsuario.GetTiempo().Read())
            {
                tiempo = 1;
            }
            return tiempo;
        }
        public int UpdateDatosPrimeraVezMexico(int PaisID, string CodigoUsuario, string Nombre, string Apellidos, string Telefono, string TelefonoTrabajo, string Celular, string Email, long IdConsultora, string CodigoConsultora, int CampaniaID_Actual, int CampaniaID_UltimaF, int RegionID, int ZonaID, string EmailAnterior)
        {
            var daUsuario = new DAUsuario(PaisID);
            return daUsuario.UpdUsuarioDatosPrimeraVezMexico(CodigoUsuario, Nombre, Apellidos, Telefono, TelefonoTrabajo, Celular, Email, IdConsultora, CodigoConsultora, CampaniaID_Actual, CampaniaID_UltimaF, RegionID, ZonaID, EmailAnterior);
        }

        public int ValidarEstadoSubscripcion(int PaisID, string CodigoUsuario, int NroDiasPermitidos)
        {
            var daUsuario = new DAUsuario(PaisID);
            return daUsuario.ValidarEstadoSubscripcion(CodigoUsuario, NroDiasPermitidos);
        }

        public BEUsuario ObtenerDatosPorUsuario(int PaisID, string CodigoUsuario)
        {
            BEUsuario usuario = null;
            var daUsuario = new DAUsuario(PaisID);

            using (IDataReader reader = daUsuario.ObtenerDatosPorUsuario(CodigoUsuario))
            {
                while (reader.Read())
                {
                    usuario = new BEUsuario(reader, "Lideres");
                }
            }
            return usuario;
        }

        public int UpdUsuarioLider(int PaisID, string CodigoUsuario, string Telefono, string Celular, string Email)
        {
            var daUsuario = new DAUsuario(PaisID);
            return daUsuario.UpdUsuarioLider(CodigoUsuario, Telefono, Celular, Email);
        }

        public int UpdCorreoUsuarioLider(int PaisID, string CodigoUsuario, string Email)
        {
            var daUsuario = new DAUsuario(PaisID);
            return daUsuario.UpdCorreoUsuarioLider(CodigoUsuario, Email);
        }

        public int CancelarSubscripcion(int PaisID, string Email)
        {
            var daUsuario = new DAUsuario(PaisID);
            return daUsuario.CancelarSubscripcion(Email);
        }

        public int ConfirmarSuscripcion(int PaisID, string Email)
        {
            var daUsuario = new DAUsuario(PaisID);
            return daUsuario.ConfirmarSuscripcion(Email);
        }

        public List<BEUsuario> GenerarReporteSuscripcionLideres(int PaisID, string TipoReporte)
        {
            List<BEUsuario> usuariosLideres = new List<BEUsuario>();
            int[] paises = { 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14 };

            for (int i = 0; i < paises.Length; i++)
            {
                var daUsuario = new DAUsuario(paises[i]);
                using (IDataReader reader = daUsuario.GenerarReporteSuscripcionLideres(TipoReporte))
                {
                    while (reader.Read())
                    {
                        BEUsuario usuario = new BEUsuario(reader, "Lideres");
                        usuariosLideres.Add(usuario);
                    }
                }
            }
            return usuariosLideres;
        }

        public List<BEUsuario> ObtenerResultadoEncuesta(int paisID, int campaniaInicio, int campaniaFin)
        {
            List<BEUsuario> usuariosLideres = new List<BEUsuario>();
            DAUsuario daUsuario = new DAUsuario(11);
            using (IDataReader reader = daUsuario.GenerarReporteResultadoEncuesta(paisID, campaniaInicio, campaniaFin))
            {
                while (reader.Read())
                {
                    BEUsuario usuario = new BEUsuario(reader, "Lideres", "Lideres");
                    usuariosLideres.Add(usuario);
                }
            }
            return usuariosLideres;

        }

        public void GuardarContrasenia(int paisID, string codigoUsuario, string contrasenia)
        {
            var contraseniaEncriptada = AESAlgorithm.Encrypt(contrasenia);

            var daUsuario = new DAUsuario(paisID);
            daUsuario.GuardarContrasenia(codigoUsuario, contraseniaEncriptada);
        }

        public int UpdateUsuarioTutoriales(int paisID, string CodigoUsuario, int tipo)
        {
            var daUsuario = new DAUsuario(paisID);
            return daUsuario.UpdateUsuarioTutoriales(CodigoUsuario, tipo);
        }

        public BEUsuario GetDatosConsultoraHana(int paisID, string codigoUsuario, int campaniaId)
        {
            var dahInformacionOnlineConsultora = new DAHInformacionOnlineConsultora();

            BEUsuario consultora = dahInformacionOnlineConsultora.GetDatosConsultoraHana(paisID, codigoUsuario, campaniaId);

            return consultora;
        }

        public int UpdateUsuarioEmailTelefono(int paisID, long ConsultoraID, string Email, string Telefono)
        {
            var daUsuario = new DAUsuario(paisID);
            return daUsuario.UpdateUsuarioEmailTelefono(ConsultoraID, Email, Telefono);
        }

        public bool CambiarClaveUsuario(int paisId, string paisIso, string codigoUsuario, string nuevacontrasena, string correo, string codigoUsuarioAutenticado, EAplicacionOrigen origen)
        {
            bool resultado;

            try
            {
                var daUsuario = new DAUsuario(paisId);
                daUsuario.CambiarClaveUsuario(codigoUsuario, nuevacontrasena, correo);
                daUsuario.InsLogCambioContrasenia(codigoUsuarioAutenticado, paisIso + codigoUsuario, nuevacontrasena,
                    correo, Enum.GetName(typeof(EAplicacionOrigen), origen));
                resultado = true;
            }
            catch (Exception ex)
            {
                LogManager.SaveLog(ex, codigoUsuario, paisIso);
                resultado = false;
            }

            return resultado;
        }

        public int ExisteUsuario(int paisId, string codigoUsuario, string clave)
        {
            int resultado;

            try
            {
                var daUsuario = new DAUsuario(paisId);
                resultado = daUsuario.ExisteUsuario(codigoUsuario, clave);
            }
            catch (Exception)
            {
                resultado = 0;
            }

            return resultado;
        }

        public bool ValidarUsuario(int paisId, string codigoUsuario, string clave)
        {
            bool resultado;

            try
            {
                var daUsuario = new DAUsuario(paisId);
                resultado = daUsuario.ValidarUsuario(codigoUsuario, clave);
            }
            catch (Exception)
            {
                resultado = false;
            }

            return resultado;
        }

        public string ActualizarMisDatos(BEUsuario usuario, string CorreoAnterior)
        {
            string resultado = string.Empty;

            try
            {
                if (usuario.EMail != string.Empty)
                {
                    int cantidad = this.ValidarEmailConsultora(usuario.PaisID, usuario.EMail, usuario.CodigoUsuario);

                    if (cantidad > 0)
                    {
                        resultado = string.Format("{0}|{1}|{2}|{3}", "0", "1", "La dirección de correo electrónico ingresada ya pertenece a otra Consultora.", cantidad);
                    }
                    else
                    {
                        this.UpdateDatos(usuario, CorreoAnterior);

                        if (usuario.EMail != CorreoAnterior)
                        {
                            string emailFrom = "no-responder@somosbelcorp.com";
                            string emailTo = usuario.EMail;
                            string titulo = "Confirmación de Correo";
                            string displayname = usuario.Nombre;
                            string url = ConfigurationManager.AppSettings["CONTEXTO_BASE"];
                            string nomconsultora = (string.IsNullOrEmpty(usuario.Sobrenombre) ? usuario.PrimerNombre : usuario.Sobrenombre);

                            string[] parametros = new string[] { usuario.CodigoUsuario, usuario.PaisID.ToString(), usuario.CodigoISO, usuario.EMail };
                            string paramQuerystring = Common.Util.Encrypt(string.Join(";", parametros));
                            LogManager.SaveLog(new Exception(), usuario.CodigoUsuario, usuario.CodigoISO, " | data=" + paramQuerystring + " | parametros = " + string.Join("|", parametros));
                            bool esEsika = ConfigurationManager.AppSettings.Get("PaisesEsika").Contains(usuario.CodigoISO);
                            string logo = (esEsika ? Globals.RutaCdn + "/ImagenesPortal/Iconos/logo.png" : Globals.RutaCdn + "/ImagenesPortal/Iconos/logod.png");
                            string fondo = (esEsika ? "e81c36" : "642f80");

                            MailUtilities.EnviarMailProcesoActualizaMisDatos(emailFrom, emailTo, titulo, displayname, logo, nomconsultora, url, fondo, paramQuerystring);

                            resultado = string.Format("{0}|{1}|{2}|0", "1", "2", "- Sus datos se actualizaron correctamente.\n - Se ha enviado un correo electrónico de verificación a la dirección ingresada.");
                        }
                        else
                        {
                            resultado = string.Format("{0}|{1}|{2}|0", "1", "3", "- Sus datos se actualizaron correctamente");
                        }
                    }
                }
            }
            catch (Exception ex)
            {
                resultado = string.Format("{0}|{1}|{2}|0", "0", "4", "Ocurrió un error al acceder al servicio, intente nuevamente.");
                LogManager.SaveLog(ex, usuario.CodigoUsuario, string.Empty);
            }

            return resultado;
        }

        public string AceptarContratoColombia(BEUsuario usuario)
        {
            string resultado;

            try
            {
                this.AceptarContrato(usuario);
                resultado = string.Format("{0}|{1}|{2}|0", "1", "3", "- Sus datos se actualizaron correctamente");
            }
            catch (Exception ex)
            {
                resultado = string.Format("{0}|{1}|{2}|0", "0", "4", "Ocurrió un error al acceder al servicio, intente nuevamente.");
                LogManager.SaveLog(ex, usuario.CodigoUsuario, string.Empty);
            }

            return resultado;
        }

        public int InsUsuarioPostulante(int paisID, string paisISO, BEUsuarioPostulante entidad)
        {
            int r = 0;

            try
            {
                if (!string.IsNullOrEmpty(entidad.NumeroDocumento) &&
                    !string.IsNullOrEmpty(entidad.NombreCompleto) &&
                    !string.IsNullOrEmpty(entidad.Zona) &&
                    !string.IsNullOrEmpty(entidad.Seccion))
                {
                    var daUsuario = new DAUsuario(paisID);

                    BEUsuario usuario = new BEUsuario
                    {
                        CodigoUsuario = entidad.NumeroDocumento,
                        PaisID = paisID,
                        CodigoConsultora = entidad.NumeroDocumento,
                        Nombre = entidad.NombreCompleto,
                        ClaveSecreta = entidad.NumeroDocumento,
                        EMail = entidad.Correo,
                        Activo = true,
                        TipoUsuario = 2,
                        DocumentoIdentidad = entidad.NumeroDocumento
                    };

                    // insertar usuario
                    int r1 = daUsuario.InsUsuario(usuario);
                    if (r1 > 0)
                    {
                        // encriptar clave
                        daUsuario.UpdUsuarioClaveSecreta(usuario.CodigoUsuario, usuario.ClaveSecreta, false);

                        BEUsuarioRol usuarioRol = new BEUsuarioRol
                        {
                            CodigoUsuario = entidad.NumeroDocumento,
                            RolID = 1,
                            Activo = true
                        };

                        var daRol = new DARol(paisID);
                        int r2 = daRol.InsUsuarioRol(usuarioRol);

                        if (r2 > 0)
                        {
                            entidad.CodigoUsuario = entidad.NumeroDocumento;
                            // insertar usuario postulante
                            int r3 = daUsuario.InsUsuarioPostulante(entidad);
                            r = (r3 > 0) ? 1 : 0;

                            if (!string.IsNullOrEmpty(entidad.Correo))
                            {
                                BEConsultoraEmail consultoraEmail = null;
                                using (IDataReader reader = daUsuario.GetUsuarioPostulanteEmail(entidad.NumeroDocumento))
                                {
                                    if (reader.Read())
                                        consultoraEmail = new BEConsultoraEmail(reader);
                                }

                                if (consultoraEmail != null)
                                {
                                    var asuntoEmail = consultoraEmail.EsPostulante ? "Creacion de cuenta de Somos Belcorp" : "Mensaje de bienvenida";
                                    string[] paisesLbel = { Constantes.CodigosISOPais.Mexico, Constantes.CodigosISOPais.CostaRica, Constantes.CodigosISOPais.Panama, Constantes.CodigosISOPais.PuertoRico };

                                    var eslbel = paisesLbel.Contains(paisISO);


                                    var pathTemplate = AppDomain.CurrentDomain.BaseDirectory + "bin\\Templates\\esika_email_consultora.html";
                                    if (eslbel)
                                    {
                                        pathTemplate = AppDomain.CurrentDomain.BaseDirectory + "bin\\Templates\\lbel_email_consultora.html";
                                    }

                                    string htmlTemplate;
                                    using (StreamReader reader = new StreamReader(pathTemplate))
                                    {
                                        htmlTemplate = reader.ReadToEnd();
                                    }

                                    if (!string.IsNullOrEmpty(htmlTemplate))
                                    {
                                        string gznombre = consultoraEmail.GerenteZonaNombre.Length > 0 ? consultoraEmail.GerenteZonaNombre : "";
                                        string gzemail = consultoraEmail.GerenteZonaEmail.Length > 0 ? consultoraEmail.GerenteZonaEmail : "";
                                        string telefono1 = ConfigurationManager.AppSettings.Get("TelefonoCentroAtencion").ToString();
                                        string codusuario = consultoraEmail.Codigo;

                                        if (eslbel)
                                        {
                                            if (paisISO == Constantes.CodigosISOPais.Mexico || paisISO == Constantes.CodigosISOPais.CostaRica)
                                            {
                                                htmlTemplate.Replace("#DISPLAY1#", "");
                                            }
                                            else
                                            {
                                                htmlTemplate.Replace("#DISPLAY1#", "nomostrar");
                                            }
                                        }

                                        htmlTemplate = htmlTemplate.Replace("#TELEFONO1#", telefono1);
                                        htmlTemplate = htmlTemplate.Replace("#TELEFONO2#", "");
                                        htmlTemplate = htmlTemplate.Replace("#PRIMER_NOMBRE#", consultoraEmail.NombreCompleto);
                                        htmlTemplate = htmlTemplate.Replace("#NOMBRE_CONTACTO#", gznombre);
                                        htmlTemplate = htmlTemplate.Replace("#EMAIL_CONTACTO#", gzemail);

                                        Common.Util.EnviarMail("no-responder@somosbelcorp.com", entidad.Correo, asuntoEmail, htmlTemplate, true, null);

                                        daUsuario.InsLogEnvioEmailConsultora(consultoraEmail);
                                        //Actualizando flag envio de correo
                                        daUsuario.UpdFlagEnvioCorreo(codusuario);
                                    }
                                    else
                                    {
                                        throw new ArgumentException("No se encontro la ruta del template: " + pathTemplate);
                                    }
                                }// consultoraEmail
                            }

                        }
                    }
                }
            }
            catch (Exception ex)
            {
                LogManager.SaveLog(ex, "", paisISO);
            }

            return r;
        }

        public int DelUsuarioPostulante(int paisID, string numeroDocumento)
        {
            var r = 0;

            try
            {
                if (!string.IsNullOrEmpty(numeroDocumento))
                {
                    var daUsuario = new DAUsuario(paisID);
                    var r1 = daUsuario.DelUsuarioPostulante(numeroDocumento);
                    r = (r1 > 0) ? 1 : 0;
                }
            }
            catch (Exception ex)
            {
                LogManager.SaveLog(ex, numeroDocumento, paisID.ToString());
            }

            return r;
        }

        public BEUsuarioPostulante GetUsuarioPostulante(int paisID, string numeroDocumento)
        {
            var postulante = new BEUsuarioPostulante();

            try
            {
                var daUsuario = new DAUsuario(paisID);
                using (IDataReader reader = daUsuario.GetUsuarioPostulante(numeroDocumento))
                {
                    if (reader.Read())
                        postulante = new BEUsuarioPostulante(reader);
                }
            }
            catch (Exception ex)
            {
                LogManager.SaveLog(ex, numeroDocumento, paisID.ToString());
            }

            return postulante;
        }

        public int InsertUsuarioExterno(int paisID, BEUsuarioExterno usuarioExterno)
        {
            var daUsuario = new DAUsuario(paisID);
            daUsuario.InsUsuarioExterno(usuarioExterno);
            return daUsuario.UpdUsuarioFotoPerfil(usuarioExterno.CodigoUsuario, usuarioExterno.FotoPerfil);
        }

        public BEUsuarioExterno GetUsuarioExternoByCodigoUsuario(int paisID, string codigoUsuario)
        {
            var daUsuario = new DAUsuario(paisID);
            BEUsuarioExterno entidad = null;

            using (IDataReader reader = daUsuario.GetUsuarioExternoByCodigoUsuario(codigoUsuario))
            {
                if (reader.Read()) entidad = new BEUsuarioExterno(reader);
            }

            return entidad;
        }

        public BEUsuarioExterno GetUsuarioExternoByProveedorAndIdApp(string proveedor, string idAplicacion, string fotoPerfil)
        {
            BEUsuarioExternoPais entidad1 = null;
            BEUsuarioExterno entidad2 = null;

            try
            {
                var daUsuarioPeru = new DAUsuario(11);

                using (IDataReader reader = daUsuarioPeru.GetUsuarioExternoPaisByProveedorAndIdApp(proveedor, idAplicacion))
                {
                    if (reader.Read()) entidad1 = new BEUsuarioExternoPais(reader);
                }

                if (entidad1 != null)
                {
                    var daUsuarioPais = new DAUsuario(entidad1.PaisID);
                    using (IDataReader reader = daUsuarioPais.GetUsuarioExternoByProveedorAndIdApp(proveedor, idAplicacion))
                    {
                        entidad2 = reader.MapToObject<BEUsuarioExterno>();
                    }

                    entidad2.PaisID = entidad1.PaisID;
                    entidad2.CodigoISO = entidad1.CodigoISO;

                    if (!String.IsNullOrEmpty(fotoPerfil) && fotoPerfil != entidad2.FotoPerfil)
                    {
                        entidad2.FotoPerfil = fotoPerfil;
                        daUsuarioPais.UpdUsuarioExterno(entidad2);

                        if (Common.Util.IsUrl(entidad2.UsuarioFotoPerfil))
                            daUsuarioPais.UpdUsuarioFotoPerfil(entidad2.CodigoUsuario, entidad2.FotoPerfil);
                    }
                }
            }
            catch (Exception ex)
            {
                if (entidad2 != null) LogManager.SaveLog(ex, entidad2.CodigoUsuario, entidad2.CodigoISO);
            }

            return entidad2;
        }

        public List<BEUsuarioExterno> GetListaLoginExterno(int paisID, string codigoUsuario)
        {
            List<BEUsuarioExterno> lista = new List<BEUsuarioExterno>();
            var daUsuario = new DAUsuario(paisID);

            using (IDataReader reader = daUsuario.GetListaLoginExterno(codigoUsuario))
            {
                if (reader.Read())
                    lista.Add(new BEUsuarioExterno(reader));
            }

            return lista;
        }

        public void UpdatePostulantesMensajes(int paisID, string CodigoUsuario, int tipo)
        {
            var daUsuario = new DAUsuario(paisID);
            daUsuario.UpdatePostulanteMensajes(CodigoUsuario, tipo);
        }


        public BEUsuarioConfiguracion ObtenerUsuarioConfiguracion(int paisID, int consultoraID, int campania, bool usuarioPrueba, int aceptacionConsultoraDA)
        {
            BEUsuario usuario = null;
            using (var reader = (new DAConfiguracionCampania(paisID)).GetConfiguracionByUsuarioAndCampania(paisID, consultoraID, campania, usuarioPrueba, aceptacionConsultoraDA))
            {
                if (reader.Read()) usuario = new BEUsuario(reader, true);
            }

            if (usuario == null)
                return null;

            var usuarioConfiguracion = new BEUsuarioConfiguracion()
            {
                PaisID = usuario.PaisID,
                CodigoISO = usuario.CodigoISO,
                TieneHana = usuario.TieneHana,
                Simbolo = usuario.Simbolo,
                EstadoSimplificacionCUV = usuario.EstadoSimplificacionCUV,
                ZonaHoraria = usuario.ZonaHoraria,
                PROLSinStock = usuario.PROLSinStock,
                NuevoPROL = true,
                ZonaNuevoPROL = true,
                ZonaValida = usuario.ZonaValida,
                DiasAntes = usuario.DiasAntes,
                HoraInicio = usuario.HoraInicio,
                HoraFin = usuario.HoraFin,
                HoraInicioNoFacturable = usuario.HoraInicioNoFacturable,
                HoraCierreNoFacturable = usuario.HoraCierreNoFacturable,
                ValidacionInteractiva = usuario.ValidacionInteractiva,
                HabilitarRestriccionHoraria = usuario.HabilitarRestriccionHoraria,
                HorasDuracionRestriccion = usuario.HorasDuracionRestriccion,
                CampaniaID = usuario.CampaniaID,
                ConsultoraID = usuario.ConsultoraID,
                PrimerNombre = usuario.PrimerNombre,
                MontoMinimoPedido = usuario.MontoMinimoPedido,
                MontoMaximoPedido = usuario.MontoMaximoPedido,
                ConsultoraNueva = usuario.ConsultoraNueva,
                CodigoConsultora = usuario.CodigoConsultora,
                CodigoUsuario = usuario.CodigoUsuario,
                NombreCompleto = usuario.Nombre,
                Email = usuario.EMail,
                UsuarioPrueba = usuario.UsuarioPrueba,
                RegionID = usuario.RegionID,
                CodigorRegion = usuario.CodigorRegion,
                ZonaID = usuario.ZonaID,
                CodigoZona = usuario.CodigoZona,
                ConsultoraAsociadoID = usuario.ConsultoraAsociadaID,
                ConsultoraAsociada = usuario.ConsultoraAsociada,
                FechaInicioFacturacion = usuario.FechaInicioFacturacion,
                FechaFinFacturacion = usuario.FechaFinFacturacion,
                HoraCierreZonaNormal = usuario.HoraCierreZonaNormal,
                HoraCierreZonaDemAnti = usuario.HoraCierreZonaDemAnti,
                EsZonaDemAnti = usuario.EsZonaDemAnti,
                TipoUsuario = usuario.TipoUsuario,
                TieneOfertaDelDia = usuario.OfertaDelDia
            };

            return usuarioConfiguracion;
        }

        public BEUsuarioChatEmtelco GetUsuarioChatEmtelco(int paisID, string codigoUsuario)
        {
            return new DAUsuario(paisID).GetUsuarioChatEmtelco(codigoUsuario);
        }

        #region TerminosCondiciones
        public bool InsertTerminosCondiciones(BETerminosCondiciones terminos)
        {
            var daTerminosCondiciones = new DATerminosCondiciones(terminos.PaisID);
            return daTerminosCondiciones.InsertTerminosCondiciones(terminos);
        }

        public bool InsertTerminosCondicionesMasivo(int paisID, List<BETerminosCondiciones> terminos)
        {
            var daTerminosCondiciones = new DATerminosCondiciones(paisID);
            var result = false;

            foreach (var item in terminos)
            {
                result = daTerminosCondiciones.InsertTerminosCondiciones(item);
                if (!result) break;
            }

            return result;
        }

        private BETerminosCondiciones GetTerminosCondiciones(int PaisID, string CodigoConsultora, short Tipo)
        {
            var terminos = new BETerminosCondiciones();

            try
            {
                if (string.IsNullOrEmpty(CodigoConsultora)) return terminos;

                using (IDataReader reader = new DATerminosCondiciones(PaisID).GetTerminosCondiciones(CodigoConsultora, Tipo))
                {
                    if (reader.Read()) terminos = new BETerminosCondiciones(reader);
                }
            }
            catch (Exception ex)
            {
                LogManager.SaveLog(ex, CodigoUsuarioLog, PaisID);
            }

            return terminos;
        }
        #endregion

        #region EventoFestivo

        public IList<BEEventoFestivo> GetEventoFestivo(int paisId, string alcance, int campaniaId)
        {
            IList<BEEventoFestivo> listaEvento;
            try
            {
                if (paisId == 0)
                {
                    paisId = int.Parse(ConfigurationManager.AppSettings["masterCountry"]);
                }

                string customKey = alcance + "_" + campaniaId;
                listaEvento = CacheManager<BEEventoFestivo>.GetData(paisId, ECacheItem.ConfiguracionEventoFestivo, customKey);
                if (listaEvento == null || listaEvento.Count == 0)
                {
                    var daUsuario = new DAUsuario(paisId);
                    listaEvento = new List<BEEventoFestivo>();
                    using (IDataReader reader = daUsuario.GetEventoFestivo(alcance, campaniaId))
                    {
                        while (reader.Read())
                        {
                            var evento = new BEEventoFestivo(reader);
                            listaEvento.Add(evento);
                        }
                    }

                    CacheManager<BEEventoFestivo>.AddData(paisId, ECacheItem.ConfiguracionEventoFestivo, customKey, listaEvento);
                }

            }
            catch (Exception ex)
            {
                LogManager.SaveLog(ex, "", paisId.ToString(), "alcance = " + alcance);
                listaEvento = new List<BEEventoFestivo>();
            }

            return listaEvento;
        }

        #endregion

        public int UpdUsuarioFotoPerfil(int paisID, string codigoUsuario, string fileName)
        {
            return new DAUsuario(paisID).UpdUsuarioFotoPerfil(codigoUsuario, fileName);
        }

        public string RecuperarContrasenia(int paisId, string textoRecuperacion)
        {
            string resultado = string.Empty;

            try
            {
                string urlportal = ConfigurationManager.AppSettings["CONTEXTO_BASE"];
                var lst = SelectByValorRestauracion(textoRecuperacion, paisId).ToList();

                string v_codigousuario = lst[0].CodigoUsuario;
                string v_nombre = lst[0].NombreCompleto.Trim().Split(' ').First();
                string v_clave = lst[0].Clave;

                if (lst[0].Cantidad == 0 && lst[0].Correo.Trim().Length == 0)
                {
                    resultado = "0" + "|" + "2";
                }
                else
                {
                    resultado = "1" + "|" + "4" + "|" + lst[0].Correo + "|" + v_nombre + "|" + v_clave + "|" + v_codigousuario + "|" + urlportal;
                }
            }
            catch (Exception ex)
            {
                resultado = "0" + "|" + "6" + "|" + ex.Message;
                LogManager.SaveLog(ex, string.Empty, paisId);
            }

            return resultado;
        }

        public List<BEUsuarioCorreo> SelectByValorRestauracion(string ValorRestauracion, int paisID)
        {
            List<BEUsuarioCorreo> UsuarioCorreo = new List<BEUsuarioCorreo>();
            var DAUsuario = new DAUsuario(paisID);

            using (IDataReader reader = DAUsuario.GetRestaurarClaveUsuario(ValorRestauracion, paisID))
                while (reader.Read())
                {
                    UsuarioCorreo.Add(new BEUsuarioCorreo(reader));
                }

            return UsuarioCorreo;
        }

        #region Restaurar Contraseña
        public BEUsuarioCorreo GetRestaurarClaveByCodUsuario(string ValorRestauracion, int paisID)
        {
            BEUsuarioCorreo oRecuperar = null;

            var DAUsuario = new DAUsuario(paisID);
            using (IDataReader reader = DAUsuario.GetRestaurarClaveUsuario(ValorRestauracion, paisID))
                if (reader.Read())
                {
                    oRecuperar = new BEUsuarioCorreo(reader);
                }

            if (oRecuperar != null)
            {
                using (IDataReader rd = DAUsuario.GetOpcionHabilitada(oRecuperar.CodigoUsuario, Constantes.EnviarCorreoYSms.RecuperarClave))
                    if (rd.Read())
                    {
                        oRecuperar.OpcionCorreoActiva = rd.GetString(0);
                        oRecuperar.OpcionSmsActiva = rd.GetString(1);
                        oRecuperar.HoraRestanteCorreo = rd.GetInt32(2);
                        oRecuperar.HoraRestanteSms = rd.GetInt32(3);
                    }
            }

            return oRecuperar;
        }

        public bool EnviarEmail(int paisId, BEUsuarioCorreo objEmail)
        {
            bool resul = false;

            try
            {
                switch (objEmail.OrigenID)
                {
                    case 1:
                        resul = EnviaClaveAEmail(paisId, objEmail);
                        break;

                    case 2:
                        resul = EnviarPinAEmail(paisId, objEmail);
                        break;
                }

                return resul;
            }
            catch (Exception ex)
            {
                LogManager.SaveLog(ex, string.Empty, Common.Util.GetPaisISO(paisId));
                return false;
            }
        }

        public bool EnviaClaveAEmail(int paisId, BEUsuarioCorreo oUsuCorreo)
        {
            bool resultado = false;

            try
            {
                if (oUsuCorreo.Cantidad < 3)
                {
                    string paisISO = Portal.Consultoras.Common.Util.GetPaisISO(paisId);
                    string paisesEsika = ConfigurationManager.AppSettings["PaisesEsika"] ?? "";
                    var esEsika = paisesEsika.Contains(paisISO);
                    string v_correo = String.Empty;

                    //List<BEUsuarioCorreo> lst = SelectByValorRestauracion(textoRecuperacion, paisId).ToList();
                    v_correo = oUsuCorreo.Correo; //lst[0].Correo;

                    string urlportal = ConfigurationManager.AppSettings["CONTEXTO_BASE"];
                    DateTime diasolicitud = DateTime.Now; //.AddMinutes(DateTime.Now.Minute + 5);
                    string fechasolicitud = diasolicitud.ToString("d/M/yyyy HH:mm:ss");
                    string paisiso = paisISO;
                    string codigousuario = oUsuCorreo.CodigoUsuario;
                    string nombre = oUsuCorreo.PrimerNombre;
                    var newUri = Portal.Consultoras.Common.Util.GetUrlRecuperarContrasenia(urlportal, paisId, oUsuCorreo.Correo, paisiso, codigousuario, fechasolicitud, nombre);

                    string emailFrom = "no-responder@somosbelcorp.com";
                    string emailTo = v_correo;
                    string titulo = "(" + paisISO + ") Cambio de contraseña de Somosbelcorp";
                    string logo = (esEsika ? Globals.RutaCdn + "/Correo/logo_esika.png" : Globals.RutaCdn + "/Correo/logo_lbel.png");
                    string nombrecorreo = oUsuCorreo.NombreCompleto.Trim().Split(' ').First();
                    string fondo = (esEsika ? "e81c36" : "642f80");
                    string displayname = "Somos Belcorp";

                    if (emailTo.Trim().Length > 0)
                    {
                        Portal.Consultoras.Common.MailUtilities.EnviarMailProcesoRecuperaContrasenia(emailFrom, emailTo, titulo, displayname, logo, nombrecorreo, newUri.ToString(), fondo);
                    }

                    oUsuCorreo.opcionHabilitar = true;
                    if (oUsuCorreo.Cantidad >= 2)
                        oUsuCorreo.opcionHabilitar = false;

                    resultado = true;
                }

                oUsuCorreo.codigoGenerado = ""; //En recuperar contraseña no hay codigo generado.
                oUsuCorreo.tipoEnvio = Constantes.EnviarCorreoYSms.EnviarPorEmail;

                var DAUsuario = new DAUsuario(paisId);
                DAUsuario.InsCodigoGenerado(oUsuCorreo);
            }
            catch (Exception ex)
            {
                resultado = false;
                LogManager.SaveLog(ex, string.Empty, string.Empty);
            }

            return resultado;
        }
        #endregion

        #region Pin Autenticacion
        public BEPinAutenticacion GetPinAutenticidad(int paisID, string CodigoUsuario)
        {
            BEPinAutenticacion oPin = null;

            var DAUsuario = new DAUsuario(paisID);
            using (IDataReader reader = DAUsuario.GetPinAutenticidad(CodigoUsuario))
                if (reader.Read())
                {
                    oPin = new BEPinAutenticacion(reader);
                }

            if (oPin != null)
            {
                using (IDataReader rd = DAUsuario.GetOpcionHabilitada(CodigoUsuario, Constantes.EnviarCorreoYSms.Autenticacion))
                    if (rd.Read())
                    {
                        oPin.OpcionCorreoActiva = rd.GetString(0);
                        oPin.OpcionSmsActiva = rd.GetString(1);
                        oPin.HoraRestanteCorreo = rd.GetInt32(2);
                        oPin.HoraRestanteSms = rd.GetInt32(3);
                    }
            }

            return oPin;
        }

        public bool EnviarPinAEmail(int paisID, BEUsuarioCorreo objUsuCorreo)
        {
            bool resultado = false;

            try
            {
                if (objUsuCorreo.Cantidad < 3)
                {
                    string paisISO = Portal.Consultoras.Common.Util.GetPaisISO(paisID);
                    string paisesEsika = ConfigurationManager.AppSettings["PaisesEsika"] ?? "";
                    var esEsika = paisesEsika.Contains(paisISO);
                    string v_correo = objUsuCorreo.Correo;

                    string emailFrom = "no-responder@somosbelcorp.com";
                    string emailTo = v_correo;
                    string titulo = "(" + paisISO + ") PIN de autenticación de Somosbelcorp";
                    string logo = (esEsika ? Globals.RutaCdn + "/Correo/logo_esika.png" : Globals.RutaCdn + "/Correo/logo_lbel.png");
                    string nombrecorreo = objUsuCorreo.PrimerNombre.Trim();
                    string fondo = (esEsika ? "e81c36" : "642f80");
                    string displayname = "Somos Belcorp";

                    objUsuCorreo.codigoGenerado = Common.Util.GenerarCodigoRandom();

                    if (emailTo.Trim().Length > 0)
                    {
                        Portal.Consultoras.Common.MailUtilities.EnviarMailPinAutenticacion(emailFrom, emailTo, titulo, displayname, logo, nombrecorreo, objUsuCorreo.codigoGenerado);
                    }

                    objUsuCorreo.opcionHabilitar = true;
                    if (objUsuCorreo.Cantidad >= 2)
                        objUsuCorreo.opcionHabilitar = false;

                    //Registrando PIN
                    objUsuCorreo.tipoEnvio = Constantes.EnviarCorreoYSms.EnviarPorEmail;

                    var DAUsuario = new DAUsuario(paisID);
                    DAUsuario.InsCodigoGenerado(objUsuCorreo);
                }

                resultado = true;
            }
            catch (Exception ex)
            {
                resultado = false;
                LogManager.SaveLog(ex, objUsuCorreo.CodigoUsuario, paisID);
            }

            return resultado;
        }

        public string GetCodigoGenerado(int PaisID, BEUsuarioCorreo oUsuCorreo, string CodIngresado)
        {
            var DAUsuario = new DAUsuario(PaisID);
            return DAUsuario.GetCodigoGenerado(oUsuCorreo, CodIngresado);
        }

        public BEUsuarioCorreo GetOpcionHabilitada(int PaisID, BEUsuarioCorreo oUsuCorreo)
        {
            var DAUsuario = new DAUsuario(PaisID);
            return null;// DAUsuario.GetOpcionHabilitada(oUsuCorreo);
        }

        public void UpdFlagAutenticacion(int paisID, string CodigoUsuario)
        {
            var DAUsuario = new DAUsuario(paisID);
            DAUsuario.UpdFlagAutenticacion(CodigoUsuario);
        }
        #endregion

        #region UserData
        public BEUsuario ConfiguracionPaisUsuario(BEUsuario usuario, string codigoConfiguracionPais)
        {
            try
            {
                CodigoUsuarioLog = usuario.CodigoUsuario;
                PaisIDLog = usuario.PaisID;

                var configuraciones = GetConfiguracionPais(usuario);

                var lstCodigo = codigoConfiguracionPais.Split('|');
                var configuracion = configuraciones.Where(x => lstCodigo.Any(y => y == x.Codigo)).FirstOrDefault();

                if (configuracion == null) return usuario;

                switch (configuracion.Codigo)
                {
                    case Constantes.ConfiguracionPais.RevistaDigital:
                        var revistaDigitalModel = new BERevistaDigital();
                        var configuracionPaisDatosAll = GetConfiguracionPaisDatos(usuario);
                        var configuracionPaisDatos = configuracionPaisDatosAll.Where(d => d.ConfiguracionPaisID == configuracion.ConfiguracionPaisID).ToList();
                        revistaDigitalModel = ConfiguracionPaisDatosRevistaDigital(revistaDigitalModel, configuracionPaisDatos, usuario.CodigoISO);
                        revistaDigitalModel = ConfiguracionPaisRevistaDigital(revistaDigitalModel, usuario);
                        revistaDigitalModel.BloqueoRevistaImpresa = configuracion.BloqueoRevistaImpresa;
                        usuario.RevistaDigital = revistaDigitalModel;
                        break;
                    case Constantes.ConfiguracionPais.ValidacionMontoMaximo:
                        usuario.TieneValidacionMontoMaximo = configuracion.Estado;
                        break;
                    case Constantes.ConfiguracionPais.OfertaFinalTradicional:
                    case Constantes.ConfiguracionPais.OfertaFinalCrossSelling:
                    case Constantes.ConfiguracionPais.OfertaFinalRegaloSorpresa:
                        var ofertaFinalModel = new BEOfertaFinal()
                        {
                            Algoritmo = configuracion.Codigo,
                            Estado = configuracion.Estado
                        };
                        if (configuracion.Estado)
                        {
                            usuario.OfertaFinal = 1;
                            usuario.EsOfertaFinalZonaValida = true;
                        }
                        usuario._OfertaFinal = ofertaFinalModel;
                        break;
                }
            }
            catch (Exception ex)
            {
                LogManager.SaveLog(ex, CodigoUsuarioLog, PaisIDLog);
            }

            return usuario;
        }

        private List<BEConfiguracionPais> GetConfiguracionPais(BEUsuario usuario)
        {
            var listaConfigPais = new List<BEConfiguracionPais>();

            try
            {
                var config = new BEConfiguracionPais
                {
                    DesdeCampania = usuario.CampaniaID,
                    Detalle = new BEConfiguracionPaisDetalle
                    {
                        PaisID = usuario.PaisID,
                        CodigoConsultora = usuario.CodigoConsultora,
                        CodigoRegion = usuario.CodigorRegion,
                        CodigoZona = usuario.CodigoZona,
                        CodigoSeccion = usuario.SeccionAnalytics
                    }
                };

                listaConfigPais = _configuracionPaisBusinessLogic.GetList(config);
            }
            catch(Exception ex)
            {
                LogManager.SaveLog(ex, CodigoUsuarioLog, PaisIDLog);
            }

            return listaConfigPais ?? new List<BEConfiguracionPais>();
        }

        private List<BEConfiguracionPaisDatos> GetConfiguracionPaisDatos(BEUsuario usuario)
        {
            var listaEntidad = new List<BEConfiguracionPaisDatos>();

            try
            {
                var entidad = new BEConfiguracionPaisDatos
                {
                    PaisID = usuario.PaisID,
                    CampaniaID = usuario.CampaniaID,
                    ConfiguracionPais = new BEConfiguracionPais
                    {
                        Detalle = new BEConfiguracionPaisDetalle
                        {
                            CodigoConsultora = usuario.CodigoConsultora,
                            CodigoRegion = usuario.CodigorRegion,
                            CodigoZona = usuario.CodigoZona,
                            CodigoSeccion = usuario.SeccionAnalytics
                        }
                    }
                };

                listaEntidad = _configuracionPaisDatosBusinessLogic.GetList(entidad);
            }
            catch(Exception ex)
            {
                LogManager.SaveLog(ex, CodigoUsuarioLog, PaisIDLog);
            }

            return listaEntidad ?? new List<BEConfiguracionPaisDatos>();
        }

        private BERevistaDigital ConfiguracionPaisDatosRevistaDigital(BERevistaDigital revistaDigitalModel, List<BEConfiguracionPaisDatos> configuracionesPaisDatos, string codigoIso)
        {
            if (revistaDigitalModel == null)
                throw new ArgumentNullException("revistaDigitalModel", "no puede ser nulo");

            if (configuracionesPaisDatos == null || !configuracionesPaisDatos.Any() || string.IsNullOrEmpty(codigoIso))
                return revistaDigitalModel;

            revistaDigitalModel.CantidadCampaniaEfectiva = GetValor1ToIntAndDelete(configuracionesPaisDatos, Constantes.ConfiguracionPaisDatos.RD.CantidadCampaniaEfectiva);
            revistaDigitalModel.BloquearRevistaImpresaGeneral = GetValor1ToIntAndDelete(configuracionesPaisDatos, Constantes.ConfiguracionPaisDatos.RD.BloquearPedidoRevistaImp);
            revistaDigitalModel.ActivoMdo = GetValor1ToBoolAndDelete(configuracionesPaisDatos, Constantes.ConfiguracionPaisDatos.ActivoMdo);

            return revistaDigitalModel;
        }

        private BERevistaDigital ConfiguracionPaisRevistaDigital(BERevistaDigital revistaDigitalModel, BEUsuario usuarioModel)
        {
            revistaDigitalModel.TieneRDC = true;
            ActualizarSubscripciones(revistaDigitalModel, usuarioModel);

            #region Campanias y Estados Es Activas - Es Suscrita
            if (revistaDigitalModel.SuscripcionEfectiva.EstadoRegistro == Constantes.EstadoRDSuscripcion.Activo)
            {
                var ca = Common.Util.AddCampaniaAndNumero(revistaDigitalModel.SuscripcionEfectiva.CampaniaID,
                                                            revistaDigitalModel.CantidadCampaniaEfectiva, usuarioModel.NroCampanias);

                if (ca >= revistaDigitalModel.SuscripcionEfectiva.CampaniaEfectiva)
                    ca = revistaDigitalModel.SuscripcionEfectiva.CampaniaEfectiva;

                revistaDigitalModel.EsActiva = ca <= usuarioModel.CampaniaID;
            }
            else if (revistaDigitalModel.SuscripcionEfectiva.EstadoRegistro ==
                     Constantes.EstadoRDSuscripcion.SinRegistroDB)
            {
                if (revistaDigitalModel.SuscripcionModel.EstadoRegistro == Constantes.EstadoRDSuscripcion.Activo)
                {
                    var ca = Common.Util.AddCampaniaAndNumero(revistaDigitalModel.SuscripcionModel.CampaniaID,
                        revistaDigitalModel.CantidadCampaniaEfectiva, usuarioModel.NroCampanias);
                    if (ca >= revistaDigitalModel.SuscripcionModel.CampaniaEfectiva)
                        ca = revistaDigitalModel.SuscripcionModel.CampaniaEfectiva;

                    revistaDigitalModel.EsActiva = ca <= usuarioModel.CampaniaID;
                }
                else
                {
                    revistaDigitalModel.EsActiva = false;
                }
            }
            else
            {
                var ca = Common.Util.AddCampaniaAndNumero(revistaDigitalModel.SuscripcionEfectiva.CampaniaID,
                    revistaDigitalModel.CantidadCampaniaEfectiva, usuarioModel.NroCampanias);

                if (ca < revistaDigitalModel.SuscripcionEfectiva.CampaniaEfectiva)
                    ca = revistaDigitalModel.SuscripcionEfectiva.CampaniaEfectiva;

                revistaDigitalModel.EsActiva = ca > usuarioModel.CampaniaID;
            }
            #endregion

            return revistaDigitalModel;
        }

        private void ActualizarSubscripciones(BERevistaDigital revistaDigitalModel, BEUsuario usuarioModel)
        {
            var rds = new BERevistaDigitalSuscripcion
            {
                PaisID = usuarioModel.PaisID,
                CodigoConsultora = usuarioModel.CodigoConsultora
            };

            revistaDigitalModel.SuscripcionModel = _revistaDigitalSuscripcionBusinessLogic.Single(rds);
            rds.CampaniaID = usuarioModel.CampaniaID;
            revistaDigitalModel.SuscripcionEfectiva = _revistaDigitalSuscripcionBusinessLogic.SingleActiva(rds);
        }

        public string ObtenerCodigoRevistaFisica(int paisId)
        {
            var result = string.Empty;

            try
            {
                var lst = _tablaLogicaDatosBusinessLogic.GetTablaLogicaDatos(paisId, Constantes.TablaLogica.CodigoRevistaFisica);
                var tablaLogicaDatos = lst.FirstOrDefault();
                result = (tablaLogicaDatos == null ? string.Empty : tablaLogicaDatos.Codigo);
            }
            catch (Exception ex)
            {
                LogManager.SaveLog(ex, CodigoUsuarioLog, PaisIDLog);
            }

            return result;
        }

        private int GetValor1ToIntAndDelete(List<BEConfiguracionPaisDatos> configuracionesPaisDatos, string codigo)
        {
            var result = 0;

            var dato = configuracionesPaisDatos.FirstOrDefault(d => d.Codigo == codigo);
            if (dato != null)
            {
                result = Convert.ToInt32(dato.Valor1);
                configuracionesPaisDatos.RemoveAll(d => d.Codigo == codigo);
            }

            return result;
        }

        private bool GetValor1ToBoolAndDelete(List<BEConfiguracionPaisDatos> configuracionesPaisDatos, string codigo)
        {
            var result = false;
            var dato = configuracionesPaisDatos.FirstOrDefault(d => d.Codigo == codigo);
            if (dato != null)
            {
                result = dato.Valor1 == "1";
                configuracionesPaisDatos.RemoveAll(d => d.Codigo == codigo);
            }

            return result;
        }
        #endregion

        private string GetUsuarioRealPostulante(int paisID, string codigoUsuario)
        {
            try
            {
                codigoUsuario = new DAUsuario(paisID).GetUsuarioRealPostulante(codigoUsuario);
            }
            catch (Exception ex)
            {
                LogManager.SaveLog(ex, codigoUsuario, paisID);
            }

            return codigoUsuario;
        }
        
        public bool GetConsultoraParticipaEnPrograma(int paisID, string codigoPrograma, string codigoConsultora, int campaniaID)
        {
            return new DAUsuario(paisID).GetConsultoraParticipaEnPrograma(codigoPrograma, codigoConsultora, campaniaID);
        }

        private string GetNivelProyectado(int paisID, long consultoraId, int campaniaId)
        {
            string nivelProyectado = "";
            BEParametrosLider oBEParametrosLider;

            oBEParametrosLider = _consultoraLiderBusinessLogic.ObtenerParametrosConsultoraLider(paisID, consultoraId, campaniaId);
            if (oBEParametrosLider != null  )
            {
                nivelProyectado = oBEParametrosLider.NivelProyectado;
            }

            return nivelProyectado;
        }
    }
}