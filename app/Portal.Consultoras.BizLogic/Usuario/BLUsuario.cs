using Portal.Consultoras.Common;
using Portal.Consultoras.Data;
using Portal.Consultoras.Data.Hana;
using Portal.Consultoras.Entities;
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
        private readonly ITablaLogicaDatosBusinessLogic _tablaLogicaDatosBusinessLogic;
        private readonly IConsultoraConcursoBusinessLogic _consultoraConcursoBusinessLogic;

        public BLUsuario() : this(new BLTablaLogicaDatos(), new BLConsultoraConcurso())
        { }

        public BLUsuario(ITablaLogicaDatosBusinessLogic tablaLogicaDatosBusinessLogic, 
                        IConsultoraConcursoBusinessLogic consultoraConcursoBusinessLogic)
        {
            _tablaLogicaDatosBusinessLogic = tablaLogicaDatosBusinessLogic;
            _consultoraConcursoBusinessLogic = consultoraConcursoBusinessLogic;
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
            var DAUsuario = new DAUsuario(paisID);
            using (IDataReader reader = DAUsuario.GetDatosConsultora(codigoUsuario))
                if (reader.Read())
                    consultora = new BEConsultoraDatos(reader);
            return consultora;
        }

        public List<BEUsuario> SelectByNombre(int paisID, string NombreUsuario)
        {
            List<BEUsuario> Usuario = new List<BEUsuario>();

            var DAUsuarioRol = new DAUsuario(paisID);
            using (IDataReader reader = DAUsuarioRol.GetUsuarioByNombre(NombreUsuario))
                while (reader.Read())
                {
                    Usuario.Add(new BEUsuario(reader));
                }
            return Usuario;
        }

        private IDataReader SelectByCodigoOrEmail(int paisID, string codigoUsuario)
        {
            var DAUsuario = new DAUsuario(paisID);
            if (codigoUsuario.Contains('@'))
                return DAUsuario.GetUsuarioByEMail(codigoUsuario);
            else
                return DAUsuario.GetUsuario(codigoUsuario);
        }

        public List<BEUsuarioRol> SelectUsuarioRol(int paisID, string RolDescripcion, string NombreUsuario)
        {
            List<BEUsuarioRol> UsuarioRol = new List<BEUsuarioRol>();

            var DAUsuarioRol = new DAUsuario(paisID);
            using (IDataReader reader = DAUsuarioRol.GetUsuarioRol(RolDescripcion, NombreUsuario))
                while (reader.Read())
                {
                    UsuarioRol.Add(new BEUsuarioRol(reader));
                }
            return UsuarioRol;
        }

        public List<BEUsuarioCorreo> SelectByEmail(string Email, int paisID)
        {
            List<BEUsuarioCorreo> UsuarioCorreo = new List<BEUsuarioCorreo>();

            var DAUsuario = new DAUsuario(paisID);
            using (IDataReader reader = DAUsuario.GetUsuarioCorreo(Email, paisID))
                while (reader.Read())
                {
                    UsuarioCorreo.Add(new BEUsuarioCorreo(reader));
                }
            return UsuarioCorreo;
        }

        public int DelUsuarioRol(int paisID, string codigoUsuario, int RolID)
        {
            var DAUsuario = new DAUsuario(paisID);
            return DAUsuario.DelUsuarioRol(codigoUsuario, RolID);
        }

        public void Insert(BEUsuario usuario)
        {
            var DAUsuario = new DAUsuario(usuario.PaisID);
            DAUsuario.InsUsuario(usuario);
        }

        public void Update(BEUsuario usuario)
        {
            var DAUsuario = new DAUsuario(usuario.PaisID);
            DAUsuario.UpdUsuario(usuario);
        }

        public int UpdUsuarioRechazarInvitacion(int PaisID, string CodigoUsuario)
        {
            var DAUsuario = new DAUsuario(PaisID);
            return DAUsuario.UpdUsuarioRechazarInvitacion(CodigoUsuario);
        }

        public void UpdateDatos(BEUsuario usuario, string CorreoAnterior)
        {
            var DAUsuario = new DAUsuario(usuario.PaisID);
            DAUsuario.UpdUsuarioDatos(usuario, CorreoAnterior);
        }

        public void AceptarContrato(BEUsuario usuario)
        {
            var DAUsuario = new DAUsuario(usuario.PaisID);
            DAUsuario.AceptarContrato(usuario);
        }

        public int UpdateDatosPrimeraVez(int paisID, string codigoUsuario, string email, string telefono, string telefonoTrabajo, string celular, string correoAnterior, bool aceptoContrato)
        {
            var DAUsuario = new DAUsuario(paisID);
            return DAUsuario.UpdUsuarioDatosPrimeraVez(codigoUsuario, email, telefono, telefonoTrabajo, celular, correoAnterior, aceptoContrato);
        }

        public int UpdUsuarioDatosPrimeraVezEstado(int PaisID, string CodigoUsuario)
        {
            var DAUsuario = new DAUsuario(PaisID);
            return DAUsuario.UpdUsuarioDatosPrimeraVezEstado(CodigoUsuario);
        }

        public void UpdatePassword(int paisID, string codigoUsuario, string claveSecreta, bool cambioClave)
        {
            var DAUsuario = new DAUsuario(paisID);
            DAUsuario.UpdUsuarioClaveSecreta(codigoUsuario, claveSecreta, cambioClave);
        }

        public bool ActiveEmail(int paisID, string codigoUsuario, string iso, string email)
        {
            var DAUsuario = new DAUsuario(paisID);
            bool Activado = DAUsuario.ActiveEmail(codigoUsuario);
            return Activado;
        }

        public int setUsuarioVideoIntroductorio(int paisID, string CodigoUsuario)
        {
            var DAUsuario = new DAUsuario(paisID);
            return DAUsuario.setUsuarioVideoIntroductorio(CodigoUsuario);
        }

        public int setUsuarioVerTutorial(int paisID, string CodigoUsuario)
        {
            var DAUsuario = new DAUsuario(paisID);
            return DAUsuario.setUsuarioVerTutorial(CodigoUsuario);
        }

        public int SetUsuarioVerTutorialDesktop(int paisID, string CodigoUsuario)
        {
            var DAUsuario = new DAUsuario(paisID);
            return DAUsuario.SetUsuarioVerTutorialDesktop(CodigoUsuario);
        }

        public BEUsuario GetSesionUsuario(int paisID, string codigoUsuario)
        {
            BEUsuario usuario = null;
            try
            {

            BEConfiguracionCampania configuracion = null;
            var DAUsuario = new DAUsuario(paisID);
            var DAConfiguracionCampania = new DAConfiguracionCampania(paisID);

            using (IDataReader reader = DAUsuario.GetSesionUsuario(codigoUsuario))
            {
                if (reader.Read())
                    usuario = new BEUsuario(reader, true);
            }

            if (usuario != null)
            {
                if (usuario.ConsultoraID != 0)
                {
                    using (IDataReader reader = DAConfiguracionCampania.GetConfiguracionCampania(paisID, usuario.ZonaID, usuario.RegionID, usuario.ConsultoraID))
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
                        usuario.NuevoPROL = configuracion.NuevoPROL;
                        usuario.ZonaNuevoPROL = configuracion.ZonaNuevoPROL;
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

                    using (IDataReader reader = DAUsuario.GetUsuarioPostulante(usuario.CodigoUsuario))
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

                        using (IDataReader reader = DAConfiguracionCampania.GetConfiguracionCampaniaNoConsultora(paisID, usuario.ZonaID, usuario.RegionID))
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
                            usuario.NuevoPROL = configuracion.NuevoPROL;
                            usuario.ZonaNuevoPROL = configuracion.ZonaNuevoPROL;
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
            }

            if (!Common.Util.IsUrl(usuario.FotoPerfil) && !string.IsNullOrEmpty(usuario.FotoPerfil))
                usuario.FotoPerfil = string.Concat(ConfigS3.GetUrlS3(Dictionaries.FileManager.Configuracion[Dictionaries.FileManager.TipoArchivo.FotoPerfilConsultora]), usuario.FotoPerfil);

            }
            catch (Exception ex)
            {
                LogManager.SaveLog(ex, codigoUsuario, paisID.ToString());
                usuario = null;
            }
            return usuario;
        }

        protected bool EsConsultoraNueva(BEUsuario usuario)
        {
            var listEstadosValidos = new List<int> { Constantes.EstadoActividadConsultora.Registrada, Constantes.EstadoActividadConsultora.Retirada };
            if (!(listEstadosValidos.Contains(usuario.ConsultoraNueva))) return false;

            return true;
        }

        public BEUsuario GetSesionUsuarioWS(int paisID, string codigoUsuario)
        {
            var usuario = GetUsuario(paisID, codigoUsuario);
            if (usuario == null) return null;
            if (usuario.ConsultoraID == 0) return null;
            
            var configuracionConsultora = this.GetConfiguracionCampania(usuario, Constantes.TipoUsuario.Consultora);
            if (configuracionConsultora != null)
            {
                usuario.CampaniaID = configuracionConsultora.CampaniaID;
                usuario.ZonaHoraria = configuracionConsultora.ZonaHoraria;
                usuario.FechaInicioFacturacion = configuracionConsultora.FechaInicioFacturacion;
                usuario.AceptacionConsultoraDA = configuracionConsultora.AceptacionConsultoraDA;
                usuario.HoraFin = configuracionConsultora.HoraFin;
                usuario.EsZonaDemAnti = configuracionConsultora.EsZonaDemAnti;
                usuario.HoraCierreZonaNormal = configuracionConsultora.HoraCierreZonaNormal;
                usuario.HoraCierreZonaDemAnti = configuracionConsultora.HoraCierreZonaDemAnti;
                usuario.DiasAntes = configuracionConsultora.DiasAntes;
                usuario.HoraInicio = configuracionConsultora.HoraInicio;
                usuario.HoraInicioNoFacturable = configuracionConsultora.HoraInicioNoFacturable;
                usuario.FechaFinFacturacion = configuracionConsultora.FechaFinFacturacion;
                usuario.CampaniaDescripcion = configuracionConsultora.CampaniaDescripcion;
                usuario.ZonaValida = configuracionConsultora.ZonaValida;
                usuario.NuevoPROL = configuracionConsultora.NuevoPROL;
                usuario.ZonaNuevoPROL = configuracionConsultora.ZonaNuevoPROL;
                usuario.IndicadorGPRSB = configuracionConsultora.IndicadorGPRSB;
                usuario.ValidacionAbierta = configuracionConsultora.ValidacionAbierta;
                usuario.EstadoPedido = configuracionConsultora.EstadoPedido;
                usuario.FechaActualPais = configuracionConsultora.FechaActualPais;
            }
            
            if (usuario.TipoUsuario == Constantes.TipoUsuario.Postulante)
            {
                var postulante = GetUsuarioPostulante(paisID, codigoUsuario);

                if (postulante != null)
                {
                    usuario.ZonaID = postulante.ZonaID;
                    usuario.RegionID = postulante.RegionID;
                    usuario.ConsultoraID = postulante.ConsultoraID;

                    var configuracion = this.GetConfiguracionCampania(usuario, Constantes.TipoUsuario.Postulante);

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
                        usuario.NuevoPROL = configuracion.NuevoPROL;
                        usuario.ZonaNuevoPROL = configuracion.ZonaNuevoPROL;
                        usuario.IndicadorGPRSB = configuracion.IndicadorGPRSB;
                        usuario.ValidacionAbierta = configuracion.ValidacionAbierta;
                        usuario.EstadoPedido = configuracion.EstadoPedido;
                        usuario.FechaActualPais = configuracion.FechaActualPais;
                    }
                }
            }

            var terminosCondicionesTask = Task.Run(() => this.GetTerminosCondiciones(paisID, usuario.CodigoConsultora, Constantes.TipoTerminosCondiciones.AppTerminosCondiciones));
            var politicaPrivacidadTask = Task.Run(() => this.GetTerminosCondiciones(paisID, usuario.CodigoConsultora, Constantes.TipoTerminosCondiciones.AppPoliticaPrivacidad));
            var destinatariosFeedBack = Task.Run(() => _tablaLogicaDatosBusinessLogic.GetTablaLogicaDatos(paisID, Constantes.TablaLogica.CorreoFeedbackAppConsultora));
            var gprBannerTask = Task.Run(() => this.GetGPRBanner(usuario));
            var usuarioConsultoraTask = Task.Run(() => this.GetUsuarioConsultora(usuario));
            var consultoraAniversarioTask = Task.Run(() => this.GetConsultoraAniversario(usuario));
            var consultoraCumpleanioTask = Task.Run(() => this.GetConsultoraCumpleanio(usuario));
            var IncentivosConcursosTask = Task.Run(() => this.GetIncentivosConcursos(usuario));

            Task.WaitAll(
                            terminosCondicionesTask,
                            politicaPrivacidadTask,
                            destinatariosFeedBack, 
                            gprBannerTask, 
                            usuarioConsultoraTask,
                            consultoraAniversarioTask,
                            consultoraCumpleanioTask,
                            IncentivosConcursosTask);

            if (!Common.Util.IsUrl(usuario.FotoPerfil) && !string.IsNullOrEmpty(usuario.FotoPerfil))
                usuario.FotoPerfil = string.Concat(ConfigS3.GetUrlS3(Dictionaries.FileManager.Configuracion[Dictionaries.FileManager.TipoArchivo.FotoPerfilConsultora]), usuario.FotoPerfil);
            
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

            usuario.EsAniversario = (bool)consultoraAniversarioTask.Result[0];
            usuario.EsCumpleanio = consultoraCumpleanioTask.Result;
            usuario.AniosPermanencia = (int)consultoraAniversarioTask.Result[1];

            usuario.CodigosConcursos = IncentivosConcursosTask.Result.Count == 2 ? IncentivosConcursosTask.Result[0] : string.Empty;
            usuario.CodigosProgramaNuevas = IncentivosConcursosTask.Result.Count == 2 ? IncentivosConcursosTask.Result[1] : string.Empty;

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
            var MontoDeuda = new BLResumenCampania().GetMontoDeuda(usuario.PaisID, usuario.CampaniaID, (int)usuario.ConsultoraID, usuario.CodigoUsuario, false);

            var beGPRUsuario = new BEGPRUsuario()
            {
                IndicadorGPRSB = usuario.IndicadorGPRSB,
                CampaniaID = usuario.CampaniaID,
                PaisID = usuario.PaisID,
                ConsultoraID = usuario.ConsultoraID,
                MontoDeuda = MontoDeuda,
                Simbolo = usuario.Simbolo,
                CodigoISO = usuario.CodigoISO,
                MontoMinimoPedido = usuario.MontoMinimoPedido,
                MontoMaximoPedido = usuario.MontoMaximoPedido,
                ValidacionAbierta = usuario.ValidacionAbierta,
                EstadoPedido = usuario.EstadoPedido
            };
            return new BLPedidoRechazado().GetMotivoRechazo(beGPRUsuario);
        }

        private BEUsuario GetUsuarioConsultora(BEUsuario usuario)
        {
            BEUsuario consultora = new BEUsuario();

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

            return consultora;
        }

        private BEUsuario GetUsuario(int paisID, string codigoUsuario)
        {
            var daUsuario = new DAUsuario(paisID);

            using (IDataReader reader = daUsuario.GetSesionUsuario(codigoUsuario))
            {
                return reader.MapToObject<BEUsuario>();
            }
        }

        private BEConfiguracionCampania GetConfiguracionCampania(BEUsuario beUsuario, int tipoUsuario)
        {
            var beConfiguracionCampania = new BEConfiguracionCampania();
            var daConfiguracionCampania = new DAConfiguracionCampania(beUsuario.PaisID);

            if (tipoUsuario == Constantes.TipoUsuario.Consultora)
            {
                using (IDataReader reader = daConfiguracionCampania.GetConfiguracionCampania(beUsuario.PaisID, beUsuario.ZonaID, beUsuario.RegionID, beUsuario.ConsultoraID))
                {
                    beConfiguracionCampania = reader.MapToObject<BEConfiguracionCampania>();
                }
            }
            else if (tipoUsuario == Constantes.TipoUsuario.Postulante)
            {
                using (IDataReader readerCampania = daConfiguracionCampania.GetConfiguracionCampaniaNoConsultora(beUsuario.PaisID, beUsuario.ZonaID, beUsuario.RegionID))
                {
                    beConfiguracionCampania = readerCampania.MapToObject<BEConfiguracionCampania>();
                }
            }

            return beConfiguracionCampania;
        }

        private List<object> GetConsultoraAniversario(BEUsuario usuario)
        {
            var resultado = new List<object>();
            bool esAniversario = false;
            int aniosPermanencia = 0;

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

            resultado.Add(esAniversario);
            resultado.Add(aniosPermanencia);

            return resultado;
        }

        private bool GetConsultoraCumpleanio(BEUsuario usuario)
        {
            bool esCumpleanio = false;

            var uFechaNacimiento = usuario.FechaNacimiento;
            var uFechaActual = usuario.FechaActualPais;

            if (uFechaNacimiento != uFechaActual)
            {
                if (uFechaNacimiento.Month == uFechaActual.Month && uFechaNacimiento.Day == uFechaActual.Day) esCumpleanio = true;
            }

            return esCumpleanio;
        }

        private List<string> GetIncentivosConcursos(BEUsuario usuario)
        {
            var lstConcursos = new List<string>();

            var arrCalculoPuntos = Constantes.Incentivo.CalculoPuntos.Split(';');
            var arrCalculoProgramaNuevas = Constantes.Incentivo.CalculoProgramaNuevas.Split(';');

            var result = _consultoraConcursoBusinessLogic.ObtenerConcursosXConsultora(usuario.PaisID, usuario.CampaniaDescripcion, usuario.CodigoConsultora, usuario.CodigorRegion, usuario.CodigoZona);

            if (result.Any())
            {
                var Concursos = result.Where(x => arrCalculoPuntos.Contains(x.TipoConcurso));
                lstConcursos.Add(string.Join("|", Concursos.Select(c => c.CodigoConcurso)));

                var ProgramaNuevas = result.Where(x => arrCalculoProgramaNuevas.Contains(x.TipoConcurso));
                lstConcursos.Add(string.Join("|", ProgramaNuevas.Select(c => c.CodigoConcurso)));
            }

            return lstConcursos;
        }

        public string GetUsuarioAsociado(int paisID, string codigoConsultora)
        {
            var DAUsuario = new DAUsuario(paisID);
            return DAUsuario.GetUsuarioAsociado(codigoConsultora);
        }

        public string GetUsuarioPermisos(int paisID, string codigoUsuario, string codigoConsultora, short tipoUsuario, short rolID)
        {
            var DAUsuario = new DAUsuario(paisID);
            return DAUsuario.GetUsuarioPermisos(paisID, codigoUsuario, codigoConsultora, tipoUsuario, rolID);
        }

        public bool IsUserExist(int paisID, string CodigoUsuario)
        {
            var DAUsuario = new DAUsuario(paisID);
            var existe = false;

            using (IDataReader reader = DAUsuario.GetUsuario(CodigoUsuario))
            {
                if (reader.Read())
                    existe = true;
            }

            return existe;
        }

        public string IsConsultoraExist(int paisID, string CodigoConsultora)
        {
            var DAUsuario = new DAUsuario(paisID);
            string retorno = string.Empty;

            retorno = "0|0";
            using (IDataReader reader = DAUsuario.GetUsuarioByConsultora(CodigoConsultora))
            {
                if (reader.Read())
                    retorno = "1" + "|" + reader["CodigoUsuario"].ToString();
            }

            return retorno;
        }

        public bool ChangePasswordUser(int paisID, string codigoUsuarioAutenticado, string emailCodigoUsuarioModificado, string password, string emailUsuarioModificado, EAplicacionOrigen origen)
        {
            var DAUsuario = new DAUsuario(paisID);
            DAUsuario.InsLogCambioContrasenia(codigoUsuarioAutenticado, emailCodigoUsuarioModificado, password, emailUsuarioModificado, Enum.GetName(typeof(EAplicacionOrigen), origen));

            return true;
        }

        public int ValidarEmailConsultora(int PaisID, string Email, string CodigoUsuario)
        {
            var DAUsuario = new DAUsuario(PaisID);
            return DAUsuario.ValidarEmailConsultora(Email, CodigoUsuario);
        }

        public int ValidarTelefonoConsultora(int PaisID, string Telefono, string CodigoUsuario)
        {
            var DAUsuario = new DAUsuario(PaisID);
            return DAUsuario.ValidarTelefonoConsultora(Telefono, CodigoUsuario);
        }

        public List<int> GetEstadosRestringidos(int paisID)
        {
            List<int> EstadosRestringidos = new List<int>();

            var DAUsuario = new DAUsuario(paisID);
            using (IDataReader reader = DAUsuario.GetEstadosRestringidos())
                while (reader.Read())
                {
                    EstadosRestringidos.Add(Convert.ToInt32(reader["estados"] != DBNull.Value ? reader["estados"] : 0));
                }
            return EstadosRestringidos;
        }

        public int UpdActualizarDatos(int paisID, string CodigoUsuario, string Email, string Celular, string Telefono)
        {
            var DAUsuario = new DAUsuarioOP(paisID);
            return DAUsuario.UpdActualizarDatos(CodigoUsuario, Email, Celular, Telefono);
        }

        public string GetNroDocumentoConsultora(int paisID, string CodigoConsultora)
        {
            var DAUsuario = new DAUsuario(paisID);
            return DAUsuario.GetNroDocumentoConsultora(CodigoConsultora);
        }

        public BEValidaLoginSB2 GetValidarLoginSB2(int paisID, string codigoUsuario, string contrasenia)
        {
            BEValidaLoginSB2 validaLogin = null;
            string pasoLog = string.Empty;
            string paisISO = string.Empty;

            try
            {
                paisISO = Portal.Consultoras.Common.Util.GetPaisISO(paisID);
                paisISO = (!string.IsNullOrEmpty(paisISO)) ? paisISO : paisID.ToString();
                var DAUsuario = new DAUsuario(paisID);

                using (IDataReader reader = DAUsuario.GetValidarLoginSB2(codigoUsuario, contrasenia))
                {
                    if (reader.Read())
                        validaLogin = new BEValidaLoginSB2(reader);
                }
            }
            catch (Exception ex)
            {
                LogManager.SaveLog(ex, codigoUsuario, paisISO);
            }

            return validaLogin;
        }

        public BEValidaLoginSB2 GetValidarAutoLogin(int paisID, string codigoUsuario, string proveedor)
        {
            BEValidaLoginSB2 validaLogin = null;
            string pasoLog = string.Empty;
            string paisISO = string.Empty;

            try
            {
                paisISO = Portal.Consultoras.Common.Util.GetPaisISO(paisID);
                paisISO = (!string.IsNullOrEmpty(paisISO)) ? paisISO : paisID.ToString();
                var DAUsuario = new DAUsuario(paisID);

                using (IDataReader reader = DAUsuario.GetValidarAutoLogin(codigoUsuario, proveedor))
                {
                    if (reader.Read())
                        validaLogin = new BEValidaLoginSB2(reader);
                }
            }
            catch (Exception ex)
            {
                LogManager.SaveLog(ex, codigoUsuario, paisISO);
            }

            return validaLogin;
        }

        public int InsUsuarioExternoPais(int paisID, BEUsuarioExternoPais entidad)
        {
            var DAUsuario = new DAUsuario(paisID);

            return DAUsuario.InsUsuarioExternoPais(entidad);
        }

        public int GetInfoPreLogin(int paisID, string CodigoUsuario)
        {
            int Result = -1;
            string Usuario = string.Empty;
            int RolID = 0;
            string AutorizaPedido = string.Empty;
            int IdEstadoActividad = -1;
            int UltimaCampania = 0;
            int CampaniaActual = 0;

            var DAUsuario = new DAUsuario(paisID);
            using (IDataReader reader = DAUsuario.GetInfoPreLogin(CodigoUsuario))
            {
                if (reader.Read())
                {
                    Usuario = Convert.ToString(reader["CodigoUsuario"]);
                    RolID = Convert.ToInt32(reader["RolId"]);
                    IdEstadoActividad = Convert.ToInt32(reader["IdEstadoActividad"]);
                    AutorizaPedido = Convert.ToString(reader["AutorizaPedido"]);
                    UltimaCampania = Convert.ToInt32(reader["UltimaCampania"]);
                    CampaniaActual = Convert.ToInt32(reader["CampaniaActual"]);
                }
            }

            //0: Usuario No Existe
            //1: Usuario No es del Portal
            //2: Usuario Esta dentro de la Lista / Autoriza Pedido NULL o N
            //3: Usuario OK

            BLTablaLogicaDatos oBLTablaLogicaDatos = new BLTablaLogicaDatos();
            List<BETablaLogicaDatos> tabla_Retirada = oBLTablaLogicaDatos.GetTablaLogicaDatos(paisID, 12);
            List<BETablaLogicaDatos> tabla_Reingresada = oBLTablaLogicaDatos.GetTablaLogicaDatos(paisID, 18);
            List<BETablaLogicaDatos> tabla_Egresada = oBLTablaLogicaDatos.GetTablaLogicaDatos(paisID, 19);

            if (!string.IsNullOrEmpty(Usuario))
            {
                if (RolID != 0)
                {
                    if (!string.IsNullOrEmpty(AutorizaPedido))
                    {
                        if (IdEstadoActividad != -1)
                        {
                            // Validamos si pertenece a Peru, Bolivia, Chile, Guatemala, El Salvador, Colombia (Paises ESIKA)
                            if (paisID == 11 || paisID == 2 || paisID == 3 || paisID == 8 || paisID == 7 || paisID == 4)
                            {
                                //Validamos si el estado es retirada
                                BETablaLogicaDatos Restriccion = tabla_Retirada.Find(p => Convert.ToInt32(p.Codigo.Trim()) == IdEstadoActividad);
                                if (Restriccion != null)
                                {
                                    //Validamos si el pais es SICC
                                    if (paisID == 11 || paisID == 3 || paisID == 8 || paisID == 7 || paisID == 4)
                                    {
                                        //Caso Colombia
                                        if (paisID == 4)
                                            return 2;
                                        else
                                        {
                                            if (AutorizaPedido == "N")
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
                                            if (AutorizaPedido == "N")
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
                                    BETablaLogicaDatos Restriccion_reingreso = tabla_Reingresada.Find(p => Convert.ToInt32(p.Codigo.Trim()) == IdEstadoActividad);
                                    if (Restriccion_reingreso != null)
                                    {
                                        if (paisID == 3)
                                        {
                                            //Se valida las campañas que no ha ingresado
                                            if (UltimaCampania != 0 && CampaniaActual.ToString().Length == 6 && UltimaCampania.ToString().Length == 6)
                                            {
                                                string CA = CampaniaActual.ToString().Substring(0, 4);
                                                string UC = UltimaCampania.ToString().Substring(0, 4);
                                                if (CA != UC)
                                                {
                                                    CA = CampaniaActual.ToString().Substring(4, 2);
                                                    UC = UltimaCampania.ToString().Substring(4, 2);
                                                    CampaniaActual = Convert.ToInt32(UC) + Convert.ToInt16(CA);
                                                    UltimaCampania = Convert.ToInt32(UC);
                                                }
                                            }

                                            if (CampaniaActual - UltimaCampania > 3 && UltimaCampania != 0)
                                                return 2;
                                            else
                                            {
                                                //Validamos el Autoriza Pedido
                                                if (AutorizaPedido == "N")
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
                                                if (AutorizaPedido == "N")
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
                                            BETablaLogicaDatos Restriccion_Egresada = tabla_Egresada.Find(p => Convert.ToInt32(p.Codigo.Trim()) == IdEstadoActividad);
                                            if (Restriccion_Egresada != null)
                                            {
                                                return 2;
                                            }
                                        }

                                        //Validamos el Autoriza Pedido
                                        if (AutorizaPedido == "N")
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
                                BETablaLogicaDatos Restriccion = tabla_Retirada.Find(p => Convert.ToInt32(p.Codigo.Trim()) == IdEstadoActividad);
                                if (Restriccion != null)
                                {
                                    //Validamos si el pais es SICC
                                    if (paisID == 5 || paisID == 10 || paisID == 6 || paisID == 14)
                                    {
                                        //Validamos el Autoriza Pedido
                                        if (AutorizaPedido == "N")
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
                                        if (AutorizaPedido == "N")
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
                                    BETablaLogicaDatos Restriccion_Egresada = tabla_Egresada.Find(p => Convert.ToInt32(p.Codigo.Trim()) == IdEstadoActividad);
                                    if (Restriccion_Egresada != null)
                                    {
                                        if (AutorizaPedido == "N")
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
                                        if (AutorizaPedido == "N")
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
                                Result = 3;
                        }
                        else
                            Result = 3; //Se asume para usuarios del tipo SAC
                    }
                    else
                        Result = 3; //Se asume para usuarios del tipo SAC
                }
                else
                    Result = 1;
            }
            else
                Result = 0;

            return Result;
        }

        public int GetInfoPreLoginConsultoraCatalogo(int paisID, string CodigoUsuario)
        {
            string Usuario = string.Empty;
            int RolID = 0;
            string AutorizaPedido = string.Empty;
            bool esAfiliado = false;
            bool autorizado = false;
            int IdEstadoActividad = -1;
            int UltimaCampania = 0;
            int CampaniaActual = 0;

            var DAUsuario = new DAUsuario(paisID);
            using (IDataReader reader = DAUsuario.GetInfoPreLoginConsultoraCatalogo(CodigoUsuario))
            {
                if (reader.Read())
                {
                    Usuario = Convert.ToString(reader["CodigoUsuario"]);
                    RolID = Convert.ToInt32(reader["RolId"]);
                    IdEstadoActividad = Convert.ToInt32(reader["IdEstadoActividad"]);
                    AutorizaPedido = Convert.ToString(reader["AutorizaPedido"]);
                    esAfiliado = Convert.ToBoolean(reader["EsAfiliado"]);
                    UltimaCampania = Convert.ToInt32(reader["UltimaCampania"]);
                    CampaniaActual = Convert.ToInt32(reader["CampaniaActual"]);
                    autorizado = (AutorizaPedido != "N" && esAfiliado);
                }
            }

            //0: Usuario No Existe
            //1: Usuario No es del Portal
            //2: Usuario Esta dentro de la Lista / Autoriza Pedido NULL o N
            //3: Usuario OK

            int nroCampanias = new BLZonificacion().GetPaisNumeroCampaniasByPaisID(paisID);
            BLTablaLogicaDatos oBLTablaLogicaDatos = new BLTablaLogicaDatos();
            List<BETablaLogicaDatos> tabla_Retirada = oBLTablaLogicaDatos.GetTablaLogicaDatos(paisID, 12);
            List<BETablaLogicaDatos> tabla_Reingresada = oBLTablaLogicaDatos.GetTablaLogicaDatos(paisID, 18);
            List<BETablaLogicaDatos> tabla_Egresada = oBLTablaLogicaDatos.GetTablaLogicaDatos(paisID, 19);

            if (string.IsNullOrEmpty(Usuario)) return 0;
            if (string.IsNullOrEmpty(AutorizaPedido)) return 0; //Se asume para usuarios del tipo SAC
            if (RolID == 0) return 1;
            if (IdEstadoActividad == -1) return 3; //Se asume para usuarios del tipo SAC

            // Validamos si pertenece a Peru, Bolivia, Chile, Guatemala, El Salvador, Colombia (Paises ESIKA)
            if (paisID == 11 || paisID == 2 || paisID == 3 || paisID == 8 || paisID == 7 || paisID == 4)
            {
                //Validamos si el estado es retirada
                BETablaLogicaDatos Restriccion = tabla_Retirada.Find(p => Convert.ToInt32(p.Codigo.Trim()) == IdEstadoActividad);
                if (Restriccion != null)
                {
                    if (paisID == 4) return 2; //Caso Colombia
                    return autorizado ? 3 : 2;
                }

                //Validamos si el estado es reingresada
                BETablaLogicaDatos Restriccion_reingreso = tabla_Reingresada.Find(p => Convert.ToInt32(p.Codigo.Trim()) == IdEstadoActividad);
                if (Restriccion_reingreso != null)
                {
                    if (paisID == 3)
                    {
                        //Se valida las campañas que no ha ingresado
                        int campaniaSinIngresar = 0;
                        if (CampaniaActual.ToString().Length == 6 && UltimaCampania.ToString().Length == 6)
                        {
                            campaniaSinIngresar = CampaniaActual - Common.Util.AddCampaniaAndNumero(UltimaCampania, 3, nroCampanias);
                        }
                        if (campaniaSinIngresar > 0) return 2;
                    }
                    else if (paisID == 4) return 2; //Caso Colombia
                }
                else if (paisID == 4) //Caso Colombia
                {
                    //Egresada o Posible Egreso
                    BETablaLogicaDatos Restriccion_Egresada = tabla_Egresada.Find(p => Convert.ToInt32(p.Codigo.Trim()) == IdEstadoActividad);
                    if (Restriccion_Egresada != null) return 2;
                }
                return autorizado ? 3 : 2;
            }
            // Validamos si pertenece a Costa Rica, Panama, Mexico, Puerto Rico, Dominicana, Ecuador, Argentina (Paises MyLbel)
            else if (paisID == 5 || paisID == 10 || paisID == 9 || paisID == 12 || paisID == 13 || paisID == 6 || paisID == 1 || paisID == 14)
            {
                // Validamos si la consultora es retirada
                BETablaLogicaDatos Restriccion = tabla_Retirada.Find(p => Convert.ToInt32(p.Codigo.Trim()) == IdEstadoActividad);
                if (Restriccion != null) return 2; //Validamos el Autoriza Pedido

                return autorizado ? 3 : 2; //Validamos el Autoriza Pedido
            }
            return 3;
        }

        public List<BEKitNueva> GetValidarConsultoraNueva(int paisID, string CodigoConsultora)
        {
            List<BEKitNueva> list = new List<BEKitNueva>();

            var DAUsuario = new DAUsuario(paisID);
            using (IDataReader reader = DAUsuario.GetValidarConsultoraNueva(CodigoConsultora))
                while (reader.Read())
                {
                    list.Add(new BEKitNueva(reader));
                }
            return list;
        }

        public int ValidarUsuarioPrueba(string CodigoUsuario, int paisID)
        {
            var DAUsuario = new DAUsuario(paisID);
            return DAUsuario.ValidarUsuarioPrueba(CodigoUsuario);
        }

        public int ValidarEnvioCatalogo(int paisID, string CodigoConsultora, int CampaniaActual, int Cantidad)
        {
            var DAUsuario = new DAUsuario(paisID);
            return DAUsuario.ValidarEnvioCatalogo(CodigoConsultora, CampaniaActual, Cantidad);
        }

        public int GetValidarColaboradorZona(int paisID, string CodigoZona)
        {
            var DAUsuario = new DAUsuario(paisID);
            return DAUsuario.GetValidarColaboradorZona(CodigoZona);
        }

        public DateTime GetFechaFacturacion(string CampaniaCodigo, int ZonaID, int PaisID)
        {
            var DAUsuario = new DAUsuario(PaisID);
            return DAUsuario.GetFechaFacturacion(CampaniaCodigo, ZonaID, PaisID);
        }

        public void UpdateIndicadorAyudaWebTracking(int paisID, string codigoConsultora, bool indicador)
        {
            var DAUsuario = new DAUsuario(paisID);
            DAUsuario.UpdateIndicadorAyudaWebTracking(codigoConsultora, indicador);
        }

        public void InsLogIngresoPortal(int paisID, string CodigoConsultora, string IPOrigen, byte Tipo, string DetalleError, string Canal)
        {
            var DAUsuario = new DAUsuario(paisID);
            DAUsuario.InsLogIngresoPortal(CodigoConsultora, IPOrigen, Tipo, DetalleError, Canal);
        }

        public BEUsuario GetSesionUsuarioLoginDD(int paisID, string codigoUsuario, string claveSecreta)
        {
            BEUsuario usuario = null;
            var DAUsuario = new DAUsuario(paisID);

            using (IDataReader reader = DAUsuario.GetSesionUsuarioLoginDD(codigoUsuario, claveSecreta))
                if (reader.Read())
                    usuario = new BEUsuario(reader);

            return usuario;
        }

        public List<BEUsuario> GetUsuarioDigitadorByFfVv(int paisID, string codigoFfvv)
        {
            List<BEUsuario> Usuario = new List<BEUsuario>();

            var DAUsuario = new DAUsuario(paisID);
            using (IDataReader reader = DAUsuario.GetUsuarioDigitadorByFfVv(codigoFfvv))
                while (reader.Read())
                {
                    Usuario.Add(new BEUsuario(reader));
                }
            return Usuario;
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
            var DAUsuario = new DAUsuario(usuario.PaisID);
            DAUsuario.UpdUsuarioDigitador(usuario);
        }

        public List<BEUsuario> GetUsuario(int paisID, int rol, string codigoUsuario, string codigoFFVV, string nombres, bool estado)
        {

            List<BEUsuario> Usuario = new List<BEUsuario>();
            var DAUsuario = new DAUsuario(paisID);

            using (IDataReader reader = DAUsuario.GetUsuario(rol, codigoUsuario, codigoFFVV, nombres, estado))
                while (reader.Read())
                {
                    Usuario.Add(new BEUsuario(reader));
                }
            return Usuario;
        }

        public void UpdUsuarioDD(BEUsuario usuario)
        {
            var DAUsuario = new DAUsuario(usuario.PaisID);
            DAUsuario.UpdUsuarioDD(usuario);
        }
        public int SelectDatosActualizados(int paisID, string codigoUsuario)
        {
            var DAUsuario = new DAUsuario(paisID);
            if (DAUsuario.GetUsuarioDatosActualizados(codigoUsuario).Read())
                return 0;
            else
                return 1;

        }
        public int SelectSegmento(int paisID, int segmentoID)
        {
            var DAUsuario = new DAUsuario(paisID);
            if (DAUsuario.GetSegmento(segmentoID).Read())
                return 1;
            else
                return 0;

        }
        public int SelectTiempo(int paisID)
        {
            var DAUsuario = new DAUsuario(paisID);
            int tiempo = 0;
            if (DAUsuario.GetTiempo().Read())
            {
                tiempo = 1;
            }
            return tiempo;
        }
        public int UpdateDatosPrimeraVezMexico(int PaisID, string CodigoUsuario, string Nombre, string Apellidos, string Telefono, string TelefonoTrabajo, string Celular, string Email, long IdConsultora, string CodigoConsultora, int CampaniaID_Actual, int CampaniaID_UltimaF, int RegionID, int ZonaID, string EmailAnterior)
        {
            var DAUsuario = new DAUsuario(PaisID);
            return DAUsuario.UpdUsuarioDatosPrimeraVezMexico(CodigoUsuario, Nombre, Apellidos, Telefono, TelefonoTrabajo, Celular, Email, IdConsultora, CodigoConsultora, CampaniaID_Actual, CampaniaID_UltimaF, RegionID, ZonaID, EmailAnterior);
        }

        public int ValidarEstadoSubscripcion(int PaisID, string CodigoUsuario, int NroDiasPermitidos)
        {
            var DAUsuario = new DAUsuario(PaisID);
            return DAUsuario.ValidarEstadoSubscripcion(CodigoUsuario, NroDiasPermitidos);
        }

        public BEUsuario ObtenerDatosPorUsuario(int PaisID, string CodigoUsuario)
        {
            BEUsuario usuario = null;
            var DAUsuario = new DAUsuario(PaisID);

            using (IDataReader reader = DAUsuario.ObtenerDatosPorUsuario(CodigoUsuario))
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
            var DAUsuario = new DAUsuario(PaisID);
            return DAUsuario.UpdUsuarioLider(CodigoUsuario, Telefono, Celular, Email);
        }

        public int UpdCorreoUsuarioLider(int PaisID, string CodigoUsuario, string Email)
        {
            var DAUsuario = new DAUsuario(PaisID);
            return DAUsuario.UpdCorreoUsuarioLider(CodigoUsuario, Email);
        }

        public int CancelarSubscripcion(int PaisID, string Email)
        {
            var DAUsuario = new DAUsuario(PaisID);
            return DAUsuario.CancelarSubscripcion(Email);
        }

        public int ConfirmarSuscripcion(int PaisID, string Email)
        {
            var DAUsuario = new DAUsuario(PaisID);
            return DAUsuario.ConfirmarSuscripcion(Email);
        }

        public List<BEUsuario> GenerarReporteSuscripcionLideres(int PaisID, string TipoReporte)
        {
            List<BEUsuario> usuariosLideres = new List<BEUsuario>();
            DAUsuario DAUsuario = null;
            int[] paises = { 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14 };

            for (int i = 0; i < paises.Length; i++)
            {
                DAUsuario = new DAUsuario(paises[i]);
                using (IDataReader reader = DAUsuario.GenerarReporteSuscripcionLideres(TipoReporte))
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
            DAUsuario DAUsuario = new DAUsuario(11);
            using (IDataReader reader = DAUsuario.GenerarReporteResultadoEncuesta(paisID, campaniaInicio, campaniaFin))
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

            var DAUsuario = new DAUsuario(paisID);
            DAUsuario.GuardarContrasenia(codigoUsuario, contraseniaEncriptada);
        }

        public int UpdateUsuarioTutoriales(int paisID, string CodigoUsuario, int tipo)
        {
            var DAUsuario = new DAUsuario(paisID);
            return DAUsuario.UpdateUsuarioTutoriales(CodigoUsuario, tipo);
        }

        public BEUsuario GetDatosConsultoraHana(int paisID, string codigoUsuario, int campaniaId)
        {
            var DAHInformacionOnlineConsultora = new DAHInformacionOnlineConsultora();

            BEUsuario consultora = DAHInformacionOnlineConsultora.GetDatosConsultoraHana(paisID, codigoUsuario, campaniaId);

            return consultora;
        }

        public int UpdateUsuarioEmailTelefono(int paisID, long ConsultoraID, string Email, string Telefono)
        {
            var DAUsuario = new DAUsuario(paisID);
            return DAUsuario.UpdateUsuarioEmailTelefono(ConsultoraID, Email, Telefono);
        }

        public bool CambiarClaveUsuario(int paisId, string paisIso, string codigoUsuario, string nuevacontrasena, string correo, string codigoUsuarioAutenticado, EAplicacionOrigen origen)
        {
            bool resultado;

            try
            {
                var DAUsuario = new DAUsuario(paisId);
                DAUsuario.CambiarClaveUsuario(codigoUsuario, nuevacontrasena, correo);
                DAUsuario.InsLogCambioContrasenia(codigoUsuarioAutenticado, paisIso + codigoUsuario, nuevacontrasena,
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
                var DAUsuario = new DAUsuario(paisId);
                resultado = DAUsuario.ExisteUsuario(codigoUsuario, clave);
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
                var DAUsuario = new DAUsuario(paisId);
                resultado = DAUsuario.ValidarUsuario(codigoUsuario, clave);
            }
            catch (Exception)
            {
                resultado = false;
            }

            return resultado;
        }

        public string RecuperarContrasenia(int paisId, string correo)
        {
            var resultado = string.Empty;
            var paso = "1";

            try
            {
                string paisISO = Portal.Consultoras.Common.Util.GetPaisISO(paisId);
                string paisesEsika = ConfigurationManager.AppSettings["PaisesEsika"] ?? "";
                var esEsika = paisesEsika.Contains(paisISO);

                List<BEUsuarioCorreo> lst = SelectByEmail(correo, paisId).ToList();
                paso = "2";

                if (paisId.ToString().Trim() == "4")
                {
                    if (lst.Count == 0)
                    {
                        resultado = "0" + "|" + "1";
                        return resultado;
                    }
                    else
                    {
                        correo = lst[0].Descripcion;
                        if (correo.Trim() == "")
                        {
                            resultado = "0" + "|" + "2";
                            return resultado;
                        }
                    }
                }

                if (lst[0].Cantidad == 0)
                {
                    resultado = "0" + "|" + "3";
                    return resultado;
                }
                else
                {
                    string urlportal = ConfigurationManager.AppSettings["CONTEXTO_BASE"];
                    DateTime diasolicitud = DateTime.Now.AddHours(DateTime.Now.Hour + 24);
                    string fechasolicitud = diasolicitud.ToString("d/M/yyyy HH:mm:ss");
                    string paisiso = lst[0].CodigoISO;
                    string codigousuario = lst[0].CodigoUsuario;
                    string nombre = lst[0].Nombre.Trim().Split(' ').First();

                    var newUri = Portal.Consultoras.Common.Util.GetUrlRecuperarContrasenia(urlportal, paisId, correo, paisiso, codigousuario, fechasolicitud, nombre);

                    paso = "3";

                    string emailFrom = "no-responder@somosbelcorp.com";
                    string emailTo = correo;
                    string titulo = "(" + lst[0].CodigoISO + ") Cambio de contraseña de Somosbelcorp";
                    string logo = (esEsika ? "https://s3.amazonaws.com/consultorasQAS/SomosBelcorp/Correo/logo_esika.png" : "https://s3.amazonaws.com/consultorasQAS/SomosBelcorp/Correo/logo_lbel.png");
                    string nombrecorreo = lst[0].Nombre.Trim().Split(' ').First();
                    string fondo = (esEsika ? "e81c36" : "642f80");
                    string displayname = "Somos Belcorp";

                    Portal.Consultoras.Common.MailUtilities.EnviarMailProcesoRecuperaContrasenia(emailFrom, emailTo, titulo, displayname, logo, nombrecorreo, newUri.ToString(), fondo);

                    resultado = "1" + "|" + "4" + "|" + correo;
                }
            }
            catch (Exception ex)
            {
                resultado = "0" + "|" + "6" + "|" + ex.Message + "|" + paso;
                LogManager.SaveLog(ex, string.Empty, string.Empty);
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
                            string param_querystring = Common.Util.Encrypt(string.Join(";", parametros));
                            LogManager.SaveLog(new Exception(), usuario.CodigoUsuario + " | data=" + param_querystring, string.Join("|", parametros));
                            bool esEsika = ConfigurationManager.AppSettings.Get("PaisesEsika").Contains(usuario.CodigoISO);
                            string logo = (esEsika ? "http://www.genesis-peru.com/mailing-belcorp/logo.png" : "https://s3.amazonaws.com/uploads.hipchat.com/583104/4578891/jG6i4d6VUyIaUwi/logod.png");
                            string fondo = (esEsika ? "e81c36" : "642f80");

                            MailUtilities.EnviarMailProcesoActualizaMisDatos(emailFrom, emailTo, titulo, displayname, logo, nomconsultora, url, fondo, param_querystring);

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
            string resultado = string.Empty;

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
                    var DAUsuario = new DAUsuario(paisID);

                    BEUsuario usuario = new BEUsuario();
                    usuario.CodigoUsuario = entidad.NumeroDocumento;
                    usuario.PaisID = paisID;
                    usuario.CodigoConsultora = entidad.NumeroDocumento;
                    usuario.Nombre = entidad.NombreCompleto;
                    usuario.ClaveSecreta = entidad.NumeroDocumento;
                    usuario.EMail = entidad.Correo;
                    usuario.Activo = true;
                    usuario.TipoUsuario = 2;
                    usuario.DocumentoIdentidad = entidad.NumeroDocumento;

                    // insertar usuario
                    int r1 = DAUsuario.InsUsuario(usuario);
                    if (r1 > 0)
                    {
                        // encriptar clave
                        DAUsuario.UpdUsuarioClaveSecreta(usuario.CodigoUsuario, usuario.ClaveSecreta, false);

                        BEUsuarioRol usuarioRol = new BEUsuarioRol();
                        usuarioRol.CodigoUsuario = entidad.NumeroDocumento;
                        usuarioRol.RolID = 1;
                        usuarioRol.Activo = true;

                        var DARol = new DARol(paisID);
                        int r2 = DARol.InsUsuarioRol(usuarioRol);

                        if (r2 > 0)
                        {
                            entidad.CodigoUsuario = entidad.NumeroDocumento;
                            // insertar usuario postulante
                            int r3 = DAUsuario.InsUsuarioPostulante(entidad);
                            r = (r3 > 0) ? 1 : 0;

                            if (!string.IsNullOrEmpty(entidad.Correo))
                            {
                                BEConsultoraEmail consultoraEmail = null;
                                using (IDataReader reader = DAUsuario.GetUsuarioPostulanteEmail(entidad.NumeroDocumento))
                                {
                                    if (reader.Read())
                                        consultoraEmail = new BEConsultoraEmail(reader);
                                }

                                if (consultoraEmail != null)
                                {
                                    var asuntoEmail = consultoraEmail.EsPostulante ? "Creacion de cuenta de Somos Belcorp" : "Mensaje de bienvenida";
                                    string[] PaisesLbel = { "MX", "CR", "PA", "PR" };

                                    var eslbel = PaisesLbel.Contains(paisISO);
                                    

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
                                            if (paisISO == "MX" || paisISO == "CR")
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

                                        DAUsuario.InsLogEnvioEmailConsultora(consultoraEmail);
                                        //Actualizando flag envio de correo
                                        DAUsuario.UpdFlagEnvioCorreo(codusuario);
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
                    var DAUsuario = new DAUsuario(paisID);
                    var r1 = DAUsuario.DelUsuarioPostulante(numeroDocumento);
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
                var DAUsuario = new DAUsuario(paisID);
                using (IDataReader reader = DAUsuario.GetUsuarioPostulante(numeroDocumento))
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
            var DAUsuario = new DAUsuario(paisID);
            DAUsuario.InsUsuarioExterno(usuarioExterno);
            return DAUsuario.UpdUsuarioFotoPerfil(usuarioExterno.CodigoUsuario, usuarioExterno.FotoPerfil);
        }

        public BEUsuarioExterno GetUsuarioExternoByCodigoUsuario(int paisID, string codigoUsuario)
        {
            var DAUsuario = new DAUsuario(paisID);
            BEUsuarioExterno entidad = null;

            using (IDataReader reader = DAUsuario.GetUsuarioExternoByCodigoUsuario(codigoUsuario))
            {
                if (reader.Read())
                    entidad = new BEUsuarioExterno(reader);
            }

            return entidad;
        }

        public BEUsuarioExterno GetUsuarioExternoByProveedorAndIdApp(string proveedor, string idAplicacion, string fotoPerfil)
        {
            DAUsuario DAUsuarioPeru = null;
            BEUsuarioExternoPais entidad1 = null;
            BEUsuarioExterno entidad2 = null;
            DAUsuario DAUsuarioPais = null;

            try
            {
                DAUsuarioPeru = new DAUsuario(11);

                using (IDataReader reader = DAUsuarioPeru.GetUsuarioExternoPaisByProveedorAndIdApp(proveedor, idAplicacion))
                {
                    if (reader.Read()) entidad1 = new BEUsuarioExternoPais(reader);
                }

                if (entidad1 != null)
                {
                    DAUsuarioPais = new DAUsuario(entidad1.PaisID);
                    using (IDataReader reader = DAUsuarioPais.GetUsuarioExternoByProveedorAndIdApp(proveedor, idAplicacion))
                    {
                        entidad2 = reader.MapToObject<BEUsuarioExterno>();
                    }

                    entidad2.PaisID = entidad1.PaisID;
                    entidad2.CodigoISO = entidad1.CodigoISO;

                    if (!String.IsNullOrEmpty(fotoPerfil) && fotoPerfil != entidad2.FotoPerfil)
                    {
                        entidad2.FotoPerfil = fotoPerfil;
                        DAUsuarioPais.UpdUsuarioExterno(entidad2);

                        if (Common.Util.IsUrl(entidad2.UsuarioFotoPerfil))
                            DAUsuarioPais.UpdUsuarioFotoPerfil(entidad2.CodigoUsuario, entidad2.FotoPerfil);
                    }   
                }
            }
            catch (Exception ex)
            {
                LogManager.SaveLog(ex, entidad2.CodigoUsuario, entidad2.CodigoISO);
            }

            return entidad2;
        }

        public List<BEUsuarioExterno> GetListaLoginExterno(int paisID, string codigoUsuario)
        {
            List<BEUsuarioExterno> lista = new List<BEUsuarioExterno>();
            var DAUsuario = new DAUsuario(paisID);

            using (IDataReader reader = DAUsuario.GetListaLoginExterno(codigoUsuario))
            {
                if (reader.Read())
                    lista.Add(new BEUsuarioExterno(reader));
            }

            return lista;
        }

        public void UpdatePostulantesMensajes(int paisID, string CodigoUsuario, int tipo)
        {
            var DAUsuario = new DAUsuario(paisID);
            DAUsuario.UpdatePostulanteMensajes(CodigoUsuario, tipo);
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
                NuevoPROL = usuario.NuevoPROL,
                ZonaNuevoPROL = usuario.ZonaNuevoPROL,
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
            var daTerminosCondiciones = new DATerminosCondiciones(PaisID);

            using (IDataReader reader = daTerminosCondiciones.GetTerminosCondiciones(CodigoConsultora, Tipo))
            {
                if (reader.Read()) terminos = new BETerminosCondiciones(reader);
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
                listaEvento = CacheManager<BEEventoFestivo>.GetData(paisId,
                    ECacheItem.ConfiguracionEventoFestivo, customKey);
                if (listaEvento == null || listaEvento.Count == 0)
                {
                    var DAUsuario = new DAUsuario(paisId);
                    listaEvento = new List<BEEventoFestivo>();
                    using (IDataReader reader = DAUsuario.GetEventoFestivo(alcance, campaniaId))
                    {
                        while (reader.Read())
                        {
                            var evento = new BEEventoFestivo(reader);
                            listaEvento.Add(evento);
                        }
                    }

                    CacheManager<BEEventoFestivo>.AddData(paisId, ECacheItem.ConfiguracionEventoFestivo, customKey,
                        listaEvento);
                }

            }
            catch (Exception ex)
            {
                LogManager.SaveLog(ex, "alcance = " + alcance, paisId.ToString());
                listaEvento = new List<BEEventoFestivo>();
            }

            return listaEvento;
        }

        #endregion

        public int UpdUsuarioFotoPerfil(int paisID, string codigoUsuario, string fileName)
        {
            return new DAUsuario(paisID).UpdUsuarioFotoPerfil(codigoUsuario, fileName);
        }
    }
}
