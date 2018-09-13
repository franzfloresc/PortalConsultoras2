using Portal.Consultoras.BizLogic.Pedido;
using Portal.Consultoras.BizLogic.RevistaDigital;
using Portal.Consultoras.Common;
using Portal.Consultoras.Data;
using Portal.Consultoras.Data.Hana;
using Portal.Consultoras.Entities;
using Portal.Consultoras.Entities.OpcionesVerificacion;
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
using System.Transactions;
using System.Net.Http;
using System.Text.RegularExpressions;

using JWT;
using Newtonsoft.Json;

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
        private readonly IConsultoraLiderBusinessLogic _consultoraLiderBusinessLogic;
        private readonly IConsultorasProgramaNuevasBusinessLogic _consultorasProgramaNuevasBusinessLogic;
        private readonly IBelcorpRespondeBusinessLogic _belcorpRespondeBusinessLogic;
        private readonly IContratoAceptacionBusinessLogic _contratoAceptacionBusinessLogic;

        public BLUsuario() : this(new BLTablaLogicaDatos(),
                                    new BLConsultoraConcurso(),
                                    new BLRevistaDigitalSuscripcion(),
                                    new BLConfiguracionPais(),
                                    new BLCuponConsultora(),
                                    new BLConfiguracionPaisDatos(),
                                    new BLPedidoRechazado(),
                                    new BLResumenCampania(),
                                    new BLConsultoraLider(),
                                    new BLConsultorasProgramaNuevas(),
                                    new BLBelcorpResponde(),
                                    new BLContratoAceptacion())
        { }

        public BLUsuario(ITablaLogicaDatosBusinessLogic tablaLogicaDatosBusinessLogic,
                        IConsultoraConcursoBusinessLogic consultoraConcursoBusinessLogic,
                        IRevistaDigitalSuscripcionBusinessLogic revistaDigitalSuscripcionBusinessLogic,
                        IConfiguracionPaisBusinessLogic configuracionPaisBusinessLogic,
                        ICuponConsultoraBusinessLogic cuponConsultoraBusinessLogic,
                        IConfiguracionPaisDatosBusinessLogic configuracionPaisDatosBusinessLogic,
                        IPedidoRechazadoBusinessLogic pedidoRechazadoBusinessLogic,
                        IResumenCampaniaBusinessLogic resumenCampaniaBusinessLogic,
                        IConsultoraLiderBusinessLogic consultoraLiderBusinessLogic,
                        IConsultorasProgramaNuevasBusinessLogic consultorasProgramaNuevasBusinessLogic,
                        IBelcorpRespondeBusinessLogic belcorpRespondeBusinessLogic,
                        IContratoAceptacionBusinessLogic contratoAceptacionBusinessLogic)
        {
            _tablaLogicaDatosBusinessLogic = tablaLogicaDatosBusinessLogic;
            _consultoraConcursoBusinessLogic = consultoraConcursoBusinessLogic;
            _revistaDigitalSuscripcionBusinessLogic = revistaDigitalSuscripcionBusinessLogic;
            _configuracionPaisBusinessLogic = configuracionPaisBusinessLogic;
            _cuponConsultoraBusinessLogic = cuponConsultoraBusinessLogic;
            _configuracionPaisDatosBusinessLogic = configuracionPaisDatosBusinessLogic;
            _pedidoRechazadoBusinessLogic = pedidoRechazadoBusinessLogic;
            _resumenCampaniaBusinessLogic = resumenCampaniaBusinessLogic;
            _consultoraLiderBusinessLogic = consultoraLiderBusinessLogic;
            _consultorasProgramaNuevasBusinessLogic = consultorasProgramaNuevasBusinessLogic;
            _belcorpRespondeBusinessLogic = belcorpRespondeBusinessLogic;
            _contratoAceptacionBusinessLogic = contratoAceptacionBusinessLogic;
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

        public BERespuestaActivarEmail ActivarEmail(int paisID, string codigoUsuario, string email)
        {
            BEUsuario usuario = null;
            try
            {
                var daUsuario = new DAUsuario(paisID);
                var dAValidacionDatos = new DAValidacionDatos(paisID);

                TransactionOptions transOptions = new TransactionOptions { IsolationLevel = System.Transactions.IsolationLevel.ReadCommitted };
                using (TransactionScope transScope = new TransactionScope(TransactionScopeOption.Required, transOptions))
                {
                    BEValidacionDatos validacionDato;
                    using (var reader = dAValidacionDatos.GetValidacionDatosByTipoEnvioAndUsuario(Constantes.TipoEnvioEmailSms.EnviarPorEmail, codigoUsuario))
                    {
                        validacionDato = MapUtil.MapToObject<BEValidacionDatos>(reader, true, true);
                    }
                    if (validacionDato == null || validacionDato.DatoNuevo != email)
                    {
                        return ActivacionEmailRespuesta(Constantes.ActualizacionDatosValidacion.Code.ERROR_CORREO_ACTIVACION_NO_EXISTE);
                    }
                    if (validacionDato.Estado == Constantes.ValidacionDatosEstado.Activo)
                    {
                        return ActivacionEmailRespuesta(Constantes.ActualizacionDatosValidacion.Code.ERROR_CORREO_ACTIVACION_YA_ACTIVADA);
                    }
                    usuario = GetBasicSesionUsuario(paisID, codigoUsuario);
                    if (!usuario.EMail.Contains(email) && daUsuario.ExistsUsuarioEmail(email))
                    {
                        if (daUsuario.ExistsUsuarioEmail(email))
                        {
                            return ActivacionEmailRespuesta(Constantes.ActualizacionDatosValidacion.Code.ERROR_CORREO_ACTIVACION_DUPLICADO, belcorpResponde: _belcorpRespondeBusinessLogic.GetBelcorpResponde(paisID).FirstOrDefault());
                        }
                    }
                    daUsuario.UpdUsuarioEmail(codigoUsuario, validacionDato.DatoNuevo, usuario.CampaniaID);
                    validacionDato.Estado = Constantes.ValidacionDatosEstado.Activo;
                    validacionDato.UsuarioModificacion = codigoUsuario;
                    validacionDato.CampaniaActivacionEmail = usuario.CampaniaID;
                    dAValidacionDatos.UpdValidacionDatos(validacionDato);

                    transScope.Complete();
                }
            }
            catch (Exception ex)
            {
                LogManager.SaveLog(ex, codigoUsuario, string.Empty);
                return ActivacionEmailRespuesta(Constantes.ActualizacionDatosValidacion.Code.ERROR_CORREO_ACTIVACION);
            }
            return new BERespuestaActivarEmail { Succcess = true, Usuario = usuario };
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
            try
            {
                var usuario = GetBasicSesionUsuario(paisID, codigoUsuario);
                if (usuario == null) return null;

                usuario.EsConsultoraNueva = EsConsultoraNueva(usuario);
                new BLUsuario().UpdUsuarioProgramaNuevas(usuario);
                usuario.FotoOriginalSinModificar = usuario.FotoPerfil;
                usuario.FotoPerfilAncha = false;

                var imagenS3 = usuario.FotoPerfil;
                if (!Common.Util.IsUrl(usuario.FotoPerfil) && !string.IsNullOrEmpty(usuario.FotoPerfil))
                {
                    imagenS3 = string.Concat(ConfigS3.GetUrlS3(Dictionaries.FileManager.Configuracion[Dictionaries.FileManager.TipoArchivo.FotoPerfilConsultora]), usuario.FotoPerfil);
                    usuario.FotoPerfil = string.Concat(ConfigCdn.GetUrlCdn(Dictionaries.FileManager.Configuracion[Dictionaries.FileManager.TipoArchivo.FotoPerfilConsultora]), usuario.FotoPerfil);
                }

                if (Common.Util.IsUrl(usuario.FotoPerfil))
                {
                    if (Common.Util.ExisteUrlRemota(imagenS3))
                    {
                        usuario.FotoPerfilAncha = Common.Util.EsImagenAncha(imagenS3);
                    }
                    else
                    {
                        usuario.FotoPerfil = "../../Content/Images/icono_avatar.svg";
                        usuario.FotoOriginalSinModificar = null;
                    }
                }

                if (string.IsNullOrEmpty(usuario.FotoPerfil))
                {
                    usuario.FotoPerfil = "../../Content/Images/icono_avatar.svg";
                    usuario.FotoOriginalSinModificar = null;
                }

                var tabla = new BLTablaLogicaDatos();

                var valores = tabla.GetTablaLogicaDatosCache(usuario.PaisID, Convert.ToInt16(Constantes.TablaLogica.ActualizaDatosEnabled));
                var listado = valores.FirstOrDefault(p => p.TablaLogicaDatosID == Convert.ToInt16(Constantes.TablaLogicaDato.ActualizaDatosEnabled));
                usuario.PuedeActualizar = Convert.ToBoolean(listado.Valor.ToInt());

                var verificacion = new BLOpcionesVerificacion();
                var verificacionResult = verificacion.GetOpcionesVerificacionCache(usuario.PaisID, Constantes.OpcionesDeVerificacion.OrigenActulizarDatos);
                usuario.PuedeEnviarSMS = (verificacionResult != null && verificacionResult.OpcionSms);

                return usuario;
            }
            catch (Exception ex)
            {
                LogManager.SaveLog(ex, codigoUsuario, paisID.ToString());
                return null;
            }
        }

        public BEUsuario GetBasicSesionUsuario(int paisID, string codigoUsuario)
        {
            BEUsuario usuario = null;
            try
            {
                var daUsuario = new DAUsuario(paisID);
                using (IDataReader reader = daUsuario.GetSesionUsuario(codigoUsuario))
                {
                    if (reader.Read()) usuario = new BEUsuario(reader, true);
                }
                if (usuario == null) return null;

                var daConfiguracionCampania = new DAConfiguracionCampania(paisID);
                BEConfiguracionCampania configuracion = null;
                if (usuario.TipoUsuario == Constantes.TipoUsuario.Postulante)
                {
                    BEUsuarioPostulante postulante = null;
                    using (IDataReader reader = daUsuario.GetUsuarioPostulante(usuario.CodigoUsuario))
                    {
                        if (reader.Read()) postulante = new BEUsuarioPostulante(reader);
                    }
                    if (postulante == null) return usuario;

                    UpdateUsuarioFromUsuarioPostulante(usuario, postulante);
                    using (IDataReader reader = daConfiguracionCampania.GetConfiguracionCampaniaNoConsultora(paisID, usuario.ZonaID, usuario.RegionID))
                    {
                        if (reader.Read()) configuracion = new BEConfiguracionCampania(reader);
                    }
                    UpdateUsuarioFromConfiguracionCampania(usuario, configuracion);
                }
                else if (usuario.ConsultoraID != 0)
                {
                    using (IDataReader reader = daConfiguracionCampania.GetConfiguracionCampania(paisID, usuario.ZonaID, usuario.RegionID, usuario.ConsultoraID))
                    {
                        if (reader.Read()) configuracion = new BEConfiguracionCampania(reader);
                    }
                    UpdateUsuarioFromConfiguracionCampania(usuario, configuracion);
                }

            }
            catch (Exception ex)
            {
                LogManager.SaveLog(ex, codigoUsuario, paisID);
                usuario = null;
            }
            return usuario;
        }

        private void UpdateUsuarioFromConfiguracionCampania(BEUsuario usuario, BEConfiguracionCampania configuracion)
        {
            if (configuracion == null) return;

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
        private void UpdateUsuarioFromUsuarioPostulante(BEUsuario usuario, BEUsuarioPostulante postulante)
        {
            if (postulante == null) return;

            usuario.ZonaID = postulante.ZonaID;
            usuario.RegionID = postulante.RegionID;
            usuario.ConsultoraID = postulante.ConsultoraID;
            usuario.MensajePedidoDesktop = postulante.MensajeDesktop;
            usuario.MensajePedidoMobile = postulante.MensajeMobile;
        }

        public bool EsConsultoraNueva(BEUsuario usuario)
        {
            var listEstadosValidos = new List<int> { Constantes.EstadoActividadConsultora.Registrada, Constantes.EstadoActividadConsultora.Retirada };
            return listEstadosValidos.Contains(usuario.ConsultoraNueva);
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
                    usuario.DiaFacturacion = (usuario.FechaInicioFacturacion - DateTime.Now).Days;
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

                try { UpdUsuarioProgramaNuevas(usuario); }
                catch (Exception ex) { LogManager.SaveLog(ex, CodigoUsuarioLog, PaisIDLog); }

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
                var actualizacionEmailTask = Task.Run(() => GetActualizacionEmail(paisID, usuario.CodigoUsuario));
                var actualizaDatosTask = Task.Run(() => _tablaLogicaDatosBusinessLogic.GetTablaLogicaDatosCache(paisID, Constantes.TablaLogica.ActualizaDatosEnabled));
                var actualizaDatosConfigTask = Task.Run(() => GetOpcionesVerificacion(paisID, Constantes.OpcionesDeVerificacion.OrigenActulizarDatos));
                var contratoAceptacionTask = Task.Run(() => GetContratoAceptacion(paisID, usuario.ConsultoraID));
                var buscadorTask = Task.Run(() => ConfiguracionPaisUsuario(usuario, Constantes.ConfiguracionPais.BuscadorYFiltros));
                var revistaDigitalTask = Task.Run(() => ConfiguracionPaisUsuario(usuario, string.Format("{0}|{1}|{2}", Constantes.ConfiguracionPais.RevistaDigital, Constantes.ConfiguracionPais.RevistaDigitalIntriga, Constantes.ConfiguracionPais.RevistaDigitalReducida)));

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
                                actualizacionEmailTask,
                                actualizaDatosTask,
                                actualizaDatosConfigTask,
                                contratoAceptacionTask,
                                buscadorTask,
                                revistaDigitalTask);

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

                usuario.EsAniversario = consultoraAniversarioTask.Result.Count == 2 && (bool)consultoraAniversarioTask.Result[0];
                usuario.EsCumpleanio = consultoraCumpleanioTask.Result;
                usuario.AniosPermanencia = consultoraAniversarioTask.Result.Count == 2 ? (int)consultoraAniversarioTask.Result[1] : 0;

                usuario.CodigosConcursos = incentivosConcursosTask.Result.Count == 2 ? incentivosConcursosTask.Result[0] : string.Empty;
                usuario.CodigosProgramaNuevas = incentivosConcursosTask.Result.Count == 2 ? incentivosConcursosTask.Result[1] : string.Empty;

                usuario.RevistaDigitalSuscripcion = revistaDigitalSuscripcionTask.Result.Count == 3 ? (short)revistaDigitalSuscripcionTask.Result[0] : Constantes.GanaMas.PaisSinRD;
                usuario.UrlBannerGanaMas = revistaDigitalSuscripcionTask.Result.Count == 3 ? (string)revistaDigitalSuscripcionTask.Result[1] : string.Empty;
                usuario.TieneGND = revistaDigitalSuscripcionTask.Result.Count == 3 && (bool)revistaDigitalSuscripcionTask.Result[2];

                usuario.CuponEstado = cuponTask.Result.EstadoCupon;
                usuario.CuponPctDescuento = cuponTask.Result.ValorAsociado;
                usuario.CuponMontoMaxDscto = cuponTask.Result.MontoMaximoDescuento;
                usuario.CuponTipoCondicion = cuponTask.Result.TipoCondicion;

                if(actualizacionEmailTask.Result != null)
                {
                    var resultActualizacionEmail = actualizacionEmailTask.Result.Split('|');
                    usuario.CambioCorreoPendiente = Constantes.ActualizacionDatosValidacion.CambioCorreoPendiente.Equals(resultActualizacionEmail[0]);
                    usuario.CorreoPendiente = resultActualizacionEmail.Length > 1 ? resultActualizacionEmail[1] : string.Empty;
                }
                if (actualizaDatosTask.Result != null)
                {
                    var item = actualizaDatosTask.Result.FirstOrDefault(p => p.TablaLogicaDatosID == Convert.ToInt16(Constantes.TablaLogicaDato.ActualizaDatosEnabled));
                    usuario.PuedeActualizar = (item!= null ?  item.Valor == "1" : false );
                }
                if(actualizaDatosConfigTask.Result != null)
                {
                    var opcionesVerificacion = actualizaDatosConfigTask.Result;
                    usuario.PuedeActualizarEmail = opcionesVerificacion.OpcionEmail;
                    usuario.PuedeActualizarCelular = opcionesVerificacion.OpcionSms;
                }
                if (contratoAceptacionTask.Result == null || usuario.TipoUsuario != Constantes.TipoUsuario.Consultora)
                {
                    usuario.IndicadorContratoAceptacion = -1;
                }
                else
                {
                    usuario.IndicadorContratoAceptacion = contratoAceptacionTask.Result.Where(e => e.AceptoContrato == 1).Count();
                }

                usuario = buscadorTask.Result ?? usuario;
                usuario = revistaDigitalTask.Result ?? usuario;

                return usuario;
            }
            catch (Exception ex)
            {
                LogManager.SaveLog(ex, codigoUsuario, paisID);
            }

            return usuario;
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
                if (usuario.RolID == Constantes.Rol.Consultora
                    && usuario.ConsultoraNueva != Constantes.EstadoActividadConsultora.Registrada && usuario.ConsultoraNueva != Constantes.EstadoActividadConsultora.Ingreso_Nueva
                    && usuario.CampaniaDescripcion != null && usuario.AnoCampaniaIngreso.Trim() != "")
                {
                    int campaniaActual = int.Parse(usuario.CampaniaDescripcion);
                    int campaniaIngreso = int.Parse(usuario.AnoCampaniaIngreso);
                    int diferencia = campaniaActual - campaniaIngreso;
                    if (diferencia >= 12
                        && usuario.AnoCampaniaIngreso.Trim().EndsWith(usuario.CampaniaDescripcion.Trim().Substring(4)))
                    {
                        esAniversario = true;
                        int anioActual = int.Parse(usuario.CampaniaDescripcion.Substring(0, 4));
                        int anioIngreso = int.Parse(usuario.AnoCampaniaIngreso.Substring(0, 4));
                        aniosPermanencia = anioActual - anioIngreso;
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
                esCumpleanio = uFechaNacimiento.Month == uFechaActual.Month && uFechaNacimiento.Day == uFechaActual.Day;
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

                var result = _consultoraConcursoBusinessLogic.ObtenerConcursosXConsultora(usuario);

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
                var oSuscrita = tablaLogica.FirstOrDefault(x => x.Codigo == Constantes.GanaMas.Banner.TablaLogicaSuscrita);
                var extensionSuscrita = oSuscrita == null ? string.Empty : oSuscrita.Descripcion;
                var oNoSuscrita = tablaLogica.FirstOrDefault(x => x.Codigo == Constantes.GanaMas.Banner.TablaLogicaNoSuscrita);
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
                    var result = lst.FirstOrDefault(x => x.Codigo == usuario.CampaniaID.ToString());
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
        
        public void UpdUsuarioProgramaNuevas(BEUsuario usuario, long consultoraId, int campania)
        {
            var consulProgNuevas = _consultorasProgramaNuevasBusinessLogic.GetByConsultoraIdAndCampania(usuario.PaisID, usuario.ConsultoraID, usuario.CampaniaID.ToString());
            if (consulProgNuevas != null)
            {
                usuario.ConsecutivoNueva = consulProgNuevas.ConsecutivoNueva;
                usuario.CodigoPrograma = consulProgNuevas.CodigoPrograma ?? "";
            }
        }
        public void UpdUsuarioProgramaNuevas(BEUsuario usuario)
        {
            UpdUsuarioProgramaNuevas(usuario, usuario.ConsultoraID, usuario.CampaniaID);
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
                                        //Para bolivia (FOX) se hace la validacion del campo AutorizaPedido
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
                            EnviarEmailActualizarCorreo(usuario, usuario.EMail);
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

        public BERespuestaServicio ActualizarEmail(BEUsuario usuario, string correoNuevo)
        {
            try
            {
                if (!usuario.PuedeActualizar) return ActualizacionDatosRespuesta(Constantes.ActualizacionDatosValidacion.Code.ERROR_CORREO_CAMBIO_NO_AUTORIZADO); 
                if (string.IsNullOrEmpty(correoNuevo)) return ActualizacionDatosRespuesta(Constantes.ActualizacionDatosValidacion.Code.ERROR_CORREO_VACIO);
                //if (usuario.EMail == correoNuevo) return new BERespuestaServicio { Message = Constantes.MensajesError.UpdCorreoConsultora_CorreoNoCambia };

                if (usuario.EMail != correoNuevo)
                {
                    var dAUsuario = new DAUsuario(usuario.PaisID);
                    if (dAUsuario.ExistsUsuarioEmail(correoNuevo)) return ActualizacionDatosRespuesta(Constantes.ActualizacionDatosValidacion.Code.ERROR_CORREO_YA_EXISTE); 
                }

                var dAValidacionDatos = new DAValidacionDatos(usuario.PaisID);
                TransactionOptions transOptions = new TransactionOptions { IsolationLevel = System.Transactions.IsolationLevel.ReadCommitted };
                using (TransactionScope transScope = new TransactionScope(TransactionScopeOption.Required, transOptions))
                {
                    BEValidacionDatos validacionDato;
                    using (var reader = dAValidacionDatos.GetValidacionDatosByTipoEnvioAndUsuario(Constantes.TipoEnvioEmailSms.EnviarPorEmail, usuario.CodigoUsuario))
                    {
                        validacionDato = MapUtil.MapToObject<BEValidacionDatos>(reader, true, true);
                    }

                    if (validacionDato == null)
                    {
                        dAValidacionDatos.InsValidacionDatos(new BEValidacionDatos
                        {
                            TipoEnvio = Constantes.TipoEnvioEmailSms.EnviarPorEmail,
                            DatoAntiguo = usuario.EMail,
                            DatoNuevo = correoNuevo,
                            CodigoUsuario = usuario.CodigoUsuario,
                            Estado = Constantes.ValidacionDatosEstado.Pendiente,
                            UsuarioCreacion = usuario.CodigoUsuario
                        });
                    }
                    else
                    {
                        validacionDato.DatoAntiguo = usuario.EMail;
                        validacionDato.DatoNuevo = correoNuevo;
                        validacionDato.Estado = Constantes.ValidacionDatosEstado.Pendiente;
                        validacionDato.UsuarioModificacion = usuario.CodigoUsuario;
                        dAValidacionDatos.UpdValidacionDatos(validacionDato);
                    }
                    
                    EnviarEmailActualizarCorreo(usuario, correoNuevo);
                    transScope.Complete();
                }
            }
            catch (Exception ex)
            {
                LogManager.SaveLog(ex, usuario.CodigoUsuario, string.Empty);
                return ActualizacionDatosRespuesta(Constantes.ActualizacionDatosValidacion.Code.ERROR_INTERNO, Constantes.MensajesError.UpdCorreoConsultora); 
            }
            return new BERespuestaServicio { Succcess = true, Code= Constantes.ActualizacionDatosValidacion.Code.SUCCESS };
        }

        public BERespuestaServicio ActualizarEmailWS(BEUsuario usuario, string correoNuevo) {

            var actualizaDatosPais = _tablaLogicaDatosBusinessLogic.GetTablaLogicaDatosCache(usuario.PaisID, Constantes.TablaLogica.ActualizaDatosEnabled).FirstOrDefault();            
            usuario.PuedeActualizar = (actualizaDatosPais != null ? actualizaDatosPais.Valor == "1" : false);
            if (!usuario.PuedeActualizar) return ActualizacionDatosRespuesta(Constantes.ActualizacionDatosValidacion.Code.ERROR_CORREO_CAMBIO_NO_AUTORIZADO);

            var actualizaDatosConfigTask = GetOpcionesVerificacion(usuario.PaisID, Constantes.OpcionesDeVerificacion.OrigenActulizarDatos);
            if(actualizaDatosConfigTask != null ? !actualizaDatosConfigTask.OpcionEmail : true) return ActualizacionDatosRespuesta(Constantes.ActualizacionDatosValidacion.Code.ERROR_CORREO_CAMBIO_NO_AUTORIZADO);

            var respuestaServicio = ActualizarEmail(usuario, correoNuevo);

            if (respuestaServicio.Code == Constantes.ActualizacionDatosValidacion.Code.SUCCESS)
                respuestaServicio.Message = Constantes.ActualizacionDatosValidacion.Message[Constantes.ActualizacionDatosValidacion.Code.SUCCESS];

            return respuestaServicio;
        }

        private void EnviarEmailActualizarCorreo(BEUsuario usuario, string correoNuevo)
        {
            string emailFrom = "no-responder@somosbelcorp.com";
            string emailTo = correoNuevo;
            string titulo = "Confirmación de Correo";
            string displayname = usuario.Nombre;
            string url = ConfigurationManager.AppSettings["CONTEXTO_BASE"];
            string nomconsultora = (string.IsNullOrEmpty(usuario.Sobrenombre) ? usuario.PrimerNombre : usuario.Sobrenombre);

            string[] parametros = new string[] { usuario.CodigoUsuario, usuario.PaisID.ToString(), correoNuevo };
            string paramQuerystring = Common.Util.Encrypt(string.Join(";", parametros));
            LogManager.SaveLog(new Exception(), usuario.CodigoUsuario, usuario.CodigoISO, " | data=" + paramQuerystring + " | parametros = " + string.Join("|", parametros));
            bool esEsika = ConfigurationManager.AppSettings.Get("PaisesEsika").Contains(usuario.CodigoISO);
            string logo = Globals.RutaCdn + (esEsika ? "/ImagenesPortal/Iconos/logo.png" : "/ImagenesPortal/Iconos/logod.png");
            string fondo = (esEsika ? "e81c36" : "642f80");

            MailUtilities.EnviarMailProcesoActualizaMisDatos(emailFrom, emailTo, titulo, displayname, logo, nomconsultora, url, fondo, paramQuerystring);
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
            if (string.IsNullOrEmpty(celularNuevo))
            {
                return new BERespuestaServicio(Constantes.MensajesError.ValorVacio);
            }

            try
            {
                var dAValidacionDatos = new DAValidacionDatos(paisId);

                BEValidacionDatos validacionDato;
                using (var reader = dAValidacionDatos.GetValidacionDatosByTipoEnvioAndUsuario(
                    Constantes.TipoEnvioEmailSms.EnviarPorSms,
                    codigoUsuario)
                )
                {
                    validacionDato = reader.MapToObject<BEValidacionDatos>();
                }

                var transOptions = new TransactionOptions
                {
                    IsolationLevel = System.Transactions.IsolationLevel.ReadCommitted
                };
                using (var transScope = new TransactionScope(TransactionScopeOption.Required, transOptions))
                {
                    if (validacionDato == null ||
                        string.IsNullOrEmpty(validacionDato.TipoEnvio))
                    {
                        validacionDato = new BEValidacionDatos
                        {
                            TipoEnvio = Constantes.TipoEnvioEmailSms.EnviarPorSms,
                            DatoAntiguo = celularActual,
                            DatoNuevo = celularNuevo,
                            CodigoUsuario = codigoUsuario,
                            Estado = Constantes.ValidacionDatosEstado.Pendiente,
                            FechaCreacion = DateTime.Now,
                            UsuarioCreacion = codigoUsuario,
                        };
                        dAValidacionDatos.InsValidacionDatos(validacionDato);
                    }
                    else
                    {
                        validacionDato.DatoAntiguo = celularActual;
                        validacionDato.DatoNuevo = celularNuevo;
                        validacionDato.Estado = Constantes.ValidacionDatosEstado.Pendiente;
                        validacionDato.FechaModificacion = DateTime.Now;
                        validacionDato.UsuarioModificacion = codigoUsuario;
                        dAValidacionDatos.UpdValidacionDatos(validacionDato);
                    }

                    ProcesaEnvioSms(paisId, new BEUsuarioDatos
                    {
                        CodigoUsuario = codigoUsuario,
                        CodigoConsultora = codigoConsultora,
                        OrigenID = Constantes.EnviarCorreoYSms.OrigenActualizarCelular,
                        OrigenDescripcion = Constantes.EnviarCorreoYSms.OrigenDescripcion,
                        campaniaID = campaniaId,
                        Celular = celularNuevo,
                        CodigoIso = Common.Util.GetPaisISO(paisId),
                        EsMobile = esMobile
                    }, 1, Constantes.EnviarSMS.CredencialesProvedoresSMS.Bolivia.MENSAJE_OPTIN);

                    transScope.Complete();
                }
            }
            catch (Exception ex)
            {
                LogManager.SaveLog(ex, codigoUsuario, string.Empty);
                return new BERespuestaServicio(Constantes.MensajesError.CelularActivacion);
            }

            return new BERespuestaServicio { Succcess = true };
        }

        public BERespuestaServicio ConfirmarCelularPorCodigoSms(int paisId, string codigoUsuario, string codigoSms, int campania, bool soloValidar)
        {
            var daValidacionDatos = new DAValidacionDatos(paisId);
            var daUsuario = new DAUsuario(paisId);
            
            try
            {
                if (string.IsNullOrEmpty(codigoSms))
                {
                    return new BERespuestaServicio(Constantes.MensajesError.ValorVacio);
                }

                var valid = daUsuario.ValidarCodigoIngresado(new BEUsuarioDatos
                {
                    CodigoUsuario = codigoUsuario,
                    OrigenID = Constantes.EnviarCorreoYSms.OrigenActualizarCelular
                }, Constantes.TipoEnvioEmailSms.EnviarPorSms, codigoSms);

                if (!valid)
                {
                    return new BERespuestaServicio(Constantes.MensajesError.CodigoIncorrecto);
                }

                BEValidacionDatos validacionDato;
                var result = GetSmsValidacionDatos(codigoUsuario, campania, daValidacionDatos, out validacionDato);
                if (!result.Succcess)
                {
                    return result;
                }

                var celularNuevo = validacionDato.DatoNuevo;
                var exist = ValidarTelefonoConsultora(paisId, celularNuevo, codigoUsuario);
                if (exist != 0)
                {
                    return new BERespuestaServicio(Constantes.MensajesError.CelularEnUso);
                }

                if (!soloValidar)
                {
                    var transOptions = new TransactionOptions
                    {
                        IsolationLevel = System.Transactions.IsolationLevel.ReadCommitted
                    };

                    using (var transScope = new TransactionScope(TransactionScopeOption.Required, transOptions))
                    {
                        daValidacionDatos.UpdValidacionDatos(validacionDato);
                        daUsuario.UpdUsuarioCelular(codigoUsuario, celularNuevo);

                        transScope.Complete();
                    }
                }

                return new BERespuestaServicio
                {
                    Succcess = true,
                    Message = celularNuevo
                };
            }
            catch (Exception ex)
            {
                LogManager.SaveLog(ex, codigoUsuario, string.Empty);
                return new BERespuestaServicio(Constantes.MensajesError.CelularActivacion);
            }
        }

        private BERespuestaServicio GetSmsValidacionDatos(string codigoUsuario, int campania, DAValidacionDatos daValidacionDatos, out BEValidacionDatos validacionDato)
        {
            using (var reader = daValidacionDatos.GetValidacionDatosByTipoEnvioAndUsuario(Constantes.TipoEnvioEmailSms.EnviarPorSms, codigoUsuario))
            {
                validacionDato = reader.MapToObject<BEValidacionDatos>();
            }

            if (validacionDato == null || validacionDato.Estado != Constantes.ValidacionDatosEstado.Pendiente)
            {
                {
                    return new BERespuestaServicio(Constantes.MensajesError.CelularActivacion);
                }
            }

            validacionDato.Estado = Constantes.ValidacionDatosEstado.Activo;
            validacionDato.UsuarioModificacion = codigoUsuario;
            validacionDato.CampaniaActivacionEmail = campania;

            return new BERespuestaServicio { Succcess = true };
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
                                            htmlTemplate = htmlTemplate.Replace("#DISPLAY1#", paisISO == Constantes.CodigosISOPais.Mexico || paisISO == Constantes.CodigosISOPais.CostaRica ? string.Empty : "nomostrar");
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

        private List<BEContrato> GetContratoAceptacion(int PaisID, long ConsultoraID)
        {
            if (PaisID != Constantes.PaisID.Colombia) return null;
            return _contratoAceptacionBusinessLogic.GetContratoAceptacion(PaisID, ConsultoraID);            
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

        #region OLVIDE CONTRASENIA

        public BEUsuarioDatos GetRestaurarClaveByValor(int paisID, string valorRestaurar, int prioridad)
        {
            var oUsu = new BEUsuarioDatos();
            oUsu.MostrarOpcion = Constantes.OlvideContrasenia.NombreOpcion.MostrarMensajeFueraHorario;
            oUsu = GetDatosUsuarioByValor(paisID, valorRestaurar);
            var opcion = GetOpcionesVerificacion(paisID, Constantes.OpcionesDeVerificacion.OrigenOlvideContrasenia);
            if (opcion == null) return oUsu;
            /*validando si tiene Zona*/
            if (opcion.TieneZonas)
            {
                if (opcion.oZona == null) return oUsu;
                if (!opcion.oZona.OlvideContrasenya) return oUsu;
            }
            /*Validando si corresponde al Usuario*/
            if (opcion.lstFiltros.Count > 0)
            {
                var usuFiltro = opcion.lstFiltros.FirstOrDefault(a => a.IdEstadoActividad == oUsu.IdEstadoActividad);
                if (usuFiltro == null) return oUsu;
                /*Validando campania*/
                if (!ValidaCampania(oUsu.campaniaID, usuFiltro.CampaniaInicio, usuFiltro.CampaniaFinal)) return oUsu;
                oUsu.MensajeSaludo = usuFiltro.MensajeSaludo;
            }


            oUsu.MostrarOpcion = Constantes.OlvideContrasenia.NombreOpcion.MostrarMensajeFueraHorario;
            if (oUsu == null) return null;
            if (oUsu.Cantidad == 0) return null;

            if (prioridad == 1)
            {
                if (opcion.OpcionEmail && oUsu.Correo != "")
                {
                    oUsu.CorreoEnmascarado = Common.Util.EnmascararCorreo(oUsu.Correo);
                    oUsu.MostrarOpcion = Constantes.OlvideContrasenia.NombreOpcion.MostrarEmail;
                }

                if (opcion.OpcionSms && oUsu.Celular != "")
                {
                    oUsu.CelularEnmascarado = Common.Util.EnmascararCelular(oUsu.Celular);
                    if (oUsu.MostrarOpcion == Constantes.OlvideContrasenia.NombreOpcion.MostrarEmail)
                        oUsu.MostrarOpcion = Constantes.OlvideContrasenia.NombreOpcion.MostrarEmailyCelular;
                    else
                        oUsu.MostrarOpcion = Constantes.OlvideContrasenia.NombreOpcion.MostrarCelular;
                }

                if (oUsu.MostrarOpcion == Constantes.OlvideContrasenia.NombreOpcion.MostrarMensajeFueraHorario)
                    prioridad = 2;
            }
            if (prioridad == 2)
            {
                if (opcion.OpcionChat)
                {
                    string descripcion;
                    if (GetHorarioByCodigo(paisID, Constantes.OlvideContrasenia.CodigoOpciones.ChatEmtelco, out descripcion))
                    {
                        oUsu.DescripcionHorario = descripcion;
                        oUsu.MostrarOpcion = Constantes.OlvideContrasenia.NombreOpcion.MostrarChat;
                    }
                    else prioridad = 3;
                }
                else prioridad = 3;
            }
            if (prioridad == 3)
            {
                if (opcion.OpcionBelcorpResponde)
                {
                    string descripcion;
                    if (GetHorarioByCodigo(paisID, Constantes.OlvideContrasenia.CodigoOpciones.BelcorpResponde, out descripcion))
                    {
                        oUsu.DescripcionHorario = descripcion;
                        oUsu.TelefonoCentral = GetNumeroBelcorpRespondeByPaisID(paisID);
                        oUsu.MostrarOpcion = Constantes.OlvideContrasenia.NombreOpcion.MostrarBelcorpResponde;
                    }
                    else prioridad = 4;
                }
                else prioridad = 4;
            }
            if (prioridad == 4)
            {
                oUsu.MostrarOpcion = Constantes.OlvideContrasenia.NombreOpcion.MostrarMensajeFueraHorario;
            }
            oUsu.OrigenID = opcion.OrigenID;
            oUsu.OrigenDescripcion = opcion.OrigenDescripcion;
            oUsu.CodigoIso = Common.Util.GetPaisISO(paisID);
            GetOpcionHabilitar(paisID, Constantes.OlvideContrasenia.Origen, ref oUsu);
            return oUsu;
        }

        public bool ProcesaEnvioEmail(int paisID, BEUsuarioDatos oUsu, int cantidadEnvios)
        {
            try
            {
                switch (oUsu.OrigenID)
                {
                    case Constantes.OpcionesDeVerificacion.OrigenOlvideContrasenia:
                        return EnviarEmailOlvideContrasenia(paisID, oUsu, cantidadEnvios);
                    case Constantes.OpcionesDeVerificacion.OrigenVericacionAutenticidad:
                        return EnviarEmailVerificacionAutenticidad(paisID, oUsu, cantidadEnvios);
                }
                return false;
            }
            catch (Exception ex)
            {
                LogManager.SaveLog(ex, string.Empty, Common.Util.GetPaisISO(paisID));
                return false;
            }
        }

        public bool VerificarIgualdadCodigoIngresado(int paisID, BEUsuarioDatos oUsu, string codigoIngresado)
        {
            var DAUsuario = new DAUsuario(paisID);
            return DAUsuario.VerificarIgualdadCodigoIngresado(oUsu, codigoIngresado);
        }

        #region METODOS OLVIDE CONTRASENIA
        private BEUsuarioDatos GetDatosUsuarioByValor(int paisID, string valorIngresado)
        {
            var DAUsuario = new DAUsuario(paisID);
            using (IDataReader reader = DAUsuario.GetUsuarioOlvideContrasenia(valorIngresado, paisID))
                if (reader.Read())
                    return new BEUsuarioDatos(reader);
            return null;
        }

        private BEUsuarioDatos GetOpcionHabilitar(int paisID, int origenID, ref BEUsuarioDatos oDatos)
        {
            var DAUsuario = new DAUsuario(paisID);
            using (IDataReader rd = DAUsuario.GetOpcionHabilitada(oDatos.CodigoUsuario, origenID))
                if (rd.Read())
                {
                    oDatos.OpcionCorreoDesabilitado = rd.GetString(0);
                    oDatos.OpcionSmsDesabilitado = rd.GetString(1);
                    oDatos.HoraRestanteCorreo = rd.GetInt32(2);
                    oDatos.HoraRestanteSms = rd.GetInt32(3);
                }
            return oDatos;
        }

        private bool GetHorarioByCodigo(int paisID, string origen, out string descripcion)
        {
            descripcion = string.Empty;
            BEHorario horarioChat = CacheManager<BEHorario>.ValidateDataElement(paisID, ECacheItem.HorarioChat, origen, () => new BLHorario().GetHorarioByCodigo(paisID, origen));
            if (horarioChat == null) return false;
            descripcion = horarioChat.Resumen;

            if (!horarioChat.EstaDisponible) return false;
            return true;
        }

        private string GetNumeroBelcorpRespondeByPaisID(int paisID)
        {
            switch (paisID)
            {
                case 2:
                    {
                        return "901-105678"; //BOLIVIA
                    }
                case 3:
                    {
                        return "02-28762100"; //CHILE
                    }
                case 4:
                    {
                        return "01-8000-9-37452,5948060"; //COLOMBIA
                    }
                case 5:
                    {
                        return "800-000-5235,22019601,22019602"; //COSTA RICA
                    }
                case 6:
                    {
                        return "1800-76667"; //ECUADOR
                    }
                case 7:
                    {
                        return "800-37452-000,25101198,25101199"; //EL SALVADOR
                    }
                case 8:
                    {
                        return "1-801-81-37452,22856185,23843795";  //GUATEMALA
                    }
                case 9:
                    {
                        return "01-800-2352677"; //MEXICO
                    }
                case 10:
                    {
                        return "800-5235,377-9399"; //PANAMA
                    }
                case 11:
                    {
                        return "01-2113614,080-11-3030"; //PERU
                    }
                case 12:
                    {
                        return "1-866-366-3235,787-622-3235"; //PUERTO RICO
                    }
                case 13:
                    {
                        return "1-809-200-5235,809-620-5235"; //REPUBLICA DOMINICANA
                    }
                case 14:
                    {
                        return "0501-2352677"; //VENEZUELA
                    }
            }
            return "";
        }

        private bool EnviarEmailOlvideContrasenia(int paisID, BEUsuarioDatos oUsu, int cantidadEnvios)
        {
            try
            {
                if (cantidadEnvios >= 3) return false;

                string paisISO = oUsu.CodigoIso;
                string paisesEsika = ConfigurationManager.AppSettings["PaisesEsika"] ?? "";
                var esEsika = paisesEsika.Contains(paisISO);
                string urlportal = ConfigurationManager.AppSettings["CONTEXTO_BASE"];
                DateTime diasolicitud = DateTime.Now;
                string fechasolicitud = diasolicitud.ToString("d/M/yyyy HH:mm:ss");
                string paisiso = paisISO;
                string codigousuario = oUsu.CodigoUsuario;
                string nombre = oUsu.PrimerNombre;
                var newUri = Portal.Consultoras.Common.Util.GetUrlRecuperarContrasenia(urlportal, paisID, oUsu.Correo, paisiso, codigousuario, fechasolicitud, nombre);
                string emailFrom = "no-responder@somosbelcorp.com";
                string emailTo = oUsu.Correo;
                string titulo = "(" + paisISO + ") Cambio de contraseña de Somosbelcorp";
                string logo = (esEsika ? Globals.RutaCdn + "/Correo/logo_esika.png" : Globals.RutaCdn + "/Correo/logo_lbel.png");
                string fondo = (esEsika ? "e81c36" : "642f80");
                string displayname = "Somos Belcorp";
                Portal.Consultoras.Common.MailUtilities.EnviarMailProcesoRecuperaContrasenia(emailFrom, emailTo, titulo, displayname, logo, nombre, newUri.ToString(), fondo);
                if (cantidadEnvios >= 2) oUsu.OpcionDesabilitado = true;
                InsCodigoGenerado(oUsu, paisID, Constantes.TipoEnvioEmailSms.EnviarPorEmail);
                return true;
            }
            catch (Exception ex)
            {
                LogManager.SaveLog(ex, string.Empty, paisID, "EnviarEmailOlvideContrasenia");
                return false;
            }
        }
        #endregion
        #endregion

        #region SMS
        private BEEnviarSms GetCredencialesSms(int paisID)
        {
            var blTablaLogicaDatos = new BLTablaLogicaDatos();
            var lstTabla = blTablaLogicaDatos.GetTablaLogicaDatosCache(paisID, Constantes.EnviarSMS.CredencialesProvedoresSMS.TablaLogicaID);
            if (lstTabla == null || lstTabla.Count == 0) return null;
            var objCreden = new BEEnviarSms();
            objCreden.UsuarioSms = lstTabla.Where(a => a.Codigo == Constantes.EnviarSMS.CredencialesProvedoresSMS.Bolivia.USUARIO).Select(b => b.Valor).FirstOrDefault();
            objCreden.ClaveSms = lstTabla.Where(a => a.Codigo == Constantes.EnviarSMS.CredencialesProvedoresSMS.Bolivia.CLAVE).Select(b => b.Valor).FirstOrDefault();
            objCreden.RequestUrl = lstTabla.Where(a => a.Codigo == Constantes.EnviarSMS.CredencialesProvedoresSMS.Bolivia.URL).Select(b => b.Valor).FirstOrDefault();
            objCreden.RecursoApi = lstTabla.Where(a => a.Codigo == Constantes.EnviarSMS.CredencialesProvedoresSMS.Bolivia.RECURSO).Select(b => b.Valor).FirstOrDefault();
            objCreden.Mensaje = lstTabla.Where(a => a.Codigo == Constantes.EnviarSMS.CredencialesProvedoresSMS.Bolivia.MENSAJE).Select(b => b.Valor).FirstOrDefault();
            objCreden.MensajeOptin = lstTabla.Where(a => a.Codigo == Constantes.EnviarSMS.CredencialesProvedoresSMS.Bolivia.MENSAJE_OPTIN).Select(b => b.Valor).FirstOrDefault();
            return objCreden;
        }

        private BEEnviarSms GetCredencialesSmsCache(int paisID)
        {
            return CacheManager<BEEnviarSms>.ValidateDataElement(paisID, ECacheItem.CredencialesSMS, paisID.ToString(), () => GetCredencialesSms(paisID));
        }

        public BERespuestaSMS ProcesaEnvioSms(int paisID, BEUsuarioDatos oUsu, int CantidadEnvios, string tipoMensaje = "")
        {
            BERespuestaSMS res = new BERespuestaSMS();

            if (oUsu.Celular == "")
            {
                res.resultado = false;
                res.mensaje = Constantes.MensajesError.ValorVacio;
            }
            else
            { 
                try
                {
                    BEEnviarSms oCredencial = GetCredencialesSmsCache(paisID);
                    string codGenerado = Common.Util.GenerarCodigoRandom();
                    oCredencial.Mensaje = string.Format(
                        tipoMensaje == Constantes.EnviarSMS.CredencialesProvedoresSMS.Bolivia.MENSAJE_OPTIN
                            ? oCredencial.MensajeOptin
                            : oCredencial.Mensaje,
                        codGenerado);

                    var data = new
                    {
                        OrigenID = oUsu.OrigenID,
                        CodigoUsuario = oUsu.CodigoUsuario,
                        CodigoConsultora = oUsu.CodigoConsultora,
                        OrigenDescripcion = oUsu.OrigenDescripcion,
                        UsuarioSms = oCredencial.UsuarioSms,
                        ClaveSms = oCredencial.ClaveSms,
                        CampaniaID = oUsu.campaniaID,
                        NroCelular = oUsu.Celular,
                        Mensaje = oCredencial.Mensaje,
                        CodigoIso = oUsu.CodigoIso,
                        EsMobile = oUsu.EsMobile,
                        RequestUrl = oCredencial.RequestUrl,
                        RecursoApi = oCredencial.RecursoApi
                    };

                    string requestUrl = ConfigurationManager.AppSettings.Get(Constantes.EnviarSMS.SmsConsultoraWs.urlKey);
                    string urlApiSms = Constantes.EnviarSMS.SmsConsultoraWs.RecursoApi;
                    var result = new BERespuestaSMS();

                    HttpClient httpClient = new HttpClient();
                    httpClient.BaseAddress = new Uri(requestUrl);

                    string secretKey = ConfigurationManager.AppSettings.Get("JsonWebTokenSecretKey");
                    var token = JsonWebToken.Encode(data, secretKey, JwtHashAlgorithm.HS512);

                    HttpResponseMessage response = httpClient.PostAsync(urlApiSms + "?id=" + token, null).GetAwaiter().GetResult();
                    if (response.IsSuccessStatusCode)
                    {
                        string jsonString = response.Content.ReadAsStringAsync().Result;
                        result = JsonConvert.DeserializeObject<BERespuestaSMS>(jsonString);
                    }
                    httpClient.Dispose();

                    if (CantidadEnvios >= 2) oUsu.OpcionDesabilitado = true;
                    InsCodigoGenerado(oUsu, paisID, Constantes.TipoEnvioEmailSms.EnviarPorSms, codGenerado);

                    if (result.codigo == "OK")
                    {
                        res.resultado = true;
                    }
                    else
                    {
                        res.resultado = false;
                        res.mensaje = result.mensaje;
                    }
                }
                catch (Exception ex)
                {
                    res.resultado = false;
                    res.mensaje = ex.Message;
                    LogManager.SaveLog(ex, oUsu.CodigoUsuario, paisID);
                }
            }
            return res;
        }

        private void InsCodigoGenerado(BEUsuarioDatos oUsu, int paisID, string TipoEnvio, string CodigoGenerado = "")
        {
            var DAUsuario = new DAUsuario(paisID);
            DAUsuario.InsCodigoGenerado(oUsu, TipoEnvio, CodigoGenerado);
        }
        #endregion

        #region Carga Opciones De Verificacion
        private BEOpcionesVerificacion GetOpcionesVerificacion(int paisID, int origenID)
        {
            var BLobj = new BLOpcionesVerificacion();
            return BLobj.GetOpcionesVerificacion(paisID, origenID);
        }

        private bool ValidaCampania(int campaniaActual, int campaniaInicio, int campaniaFin)
        {
            if (campaniaActual == 0)
                return true;

            if (campaniaInicio == 0 && campaniaFin == 0)
                return true;

            if (campaniaInicio != 0 && campaniaFin == 0
                && campaniaInicio <= campaniaActual)
                return true;

            if (campaniaInicio == 0 && campaniaFin != 0
                && campaniaFin >= campaniaActual)
                return true;

            if (campaniaInicio <= campaniaActual && campaniaActual <= campaniaFin)
                return true;

            return false;
        }
        #endregion

        #region Verificacion De Autenticidad
        public BEUsuarioDatos GetVerificacionAutenticidad(int paisID, string CodigoUsuario, bool verificacionWeb)
        {
            try
            {
                /*Verificando si tiene Verificacion*/
                var oUsu = GetUsuarioVerificacionAutenticidad(paisID, CodigoUsuario);
                if (oUsu.Cantidad == 0 && (verificacionWeb || oUsu.OpcionCambioClave != 0 )) return null;
                /*Obteniendo Datos de Verificacion de Autenticidad*/
                var opcion = GetOpcionesVerificacion(paisID, Constantes.OpcionesDeVerificacion.OrigenVericacionAutenticidad);
                if (opcion == null) return null;
                /*validando si tiene Zona*/
                if (opcion.TieneZonas)
                {
                    var tieneZona = new BLOpcionesVerificacion().GetZonasOpcionesVerificacion(paisID, oUsu.RegionID, oUsu.ZonaID);
                    if (tieneZona == null) return null;
                    if (!tieneZona.VerifAutenticidad) return null;
                }
                /*Validando si corresponde al Usuario*/
                if (opcion.lstFiltros.Count > 0)
                {
                    var usuFiltro = opcion.lstFiltros.FirstOrDefault(a => a.IdEstadoActividad == oUsu.IdEstadoActividad);
                    if (usuFiltro == null && verificacionWeb) return null;
                    if (usuFiltro != null)
                    {
                        /*Validando campania*/
                        if (!ValidaCampania(oUsu.campaniaID, usuFiltro.CampaniaInicio, usuFiltro.CampaniaFinal)) return null;
                        oUsu.MensajeSaludo = usuFiltro.MensajeSaludo;
                    }
                }

                oUsu.MostrarOpcion = Constantes.VerificacionAutenticidad.NombreOpcion.SinOpcion;
                if (opcion.OpcionEmail && oUsu.Correo!= null)
                {
                    oUsu.CorreoEnmascarado = Common.Util.EnmascararCorreo(oUsu.Correo);
                    oUsu.MostrarOpcion = Constantes.VerificacionAutenticidad.NombreOpcion.MostrarEmail;
                }
                if (opcion.OpcionSms && oUsu.Celular != null)
                {
                    oUsu.CelularEnmascarado = Common.Util.EnmascararCelular(oUsu.Celular);
                    if (oUsu.MostrarOpcion == Constantes.VerificacionAutenticidad.NombreOpcion.MostrarEmail)
                        oUsu.MostrarOpcion = Constantes.VerificacionAutenticidad.NombreOpcion.MostrarEmailyCelular;
                    else
                        oUsu.MostrarOpcion = Constantes.VerificacionAutenticidad.NombreOpcion.MostrarCelular;
                }
                if (oUsu.MostrarOpcion == Constantes.VerificacionAutenticidad.NombreOpcion.SinOpcion && (oUsu.OpcionCambioClave != 0 || !opcion.OpcionContrasena)) return null;
                oUsu.OpcionChat = opcion.OpcionChat;
                oUsu.TelefonoCentral = GetNumeroBelcorpRespondeByPaisID(paisID);
                oUsu.OrigenID = opcion.OrigenID;
                oUsu.OrigenDescripcion = opcion.OrigenDescripcion;
                oUsu.CodigoUsuario = CodigoUsuario;
                oUsu.CodigoIso = Common.Util.GetPaisISO(paisID);
                GetOpcionHabilitar(paisID, Constantes.VerificacionAutenticidad.Origen, ref oUsu);
                
                oUsu.OpcionVerificacionSMS = opcion.OpcionSms ? (oUsu.Cantidad == 0 ? 1 : 0) : -1;
                oUsu.OpcionVerificacionCorreo = opcion.OpcionEmail ? (oUsu.Cantidad == 0 ? 1 : 0) : -1;
                oUsu.OpcionCambioClave = opcion.OpcionContrasena ? oUsu.OpcionCambioClave : -1;

                return oUsu;
            }
            catch (Exception ex)
            {
                LogManager.SaveLog(ex, CodigoUsuario, Common.Util.GetPaisISO(paisID));
                return null;
            }
        }

        private BEUsuarioDatos GetUsuarioVerificacionAutenticidad(int paisID, string CodigoUsuario)
        {
            var DAUsuario = new DAUsuario(paisID);
            var datos = new BEUsuarioDatos();
            using (IDataReader rd = DAUsuario.GetUsuarioVerificacionAutenticidad(paisID, CodigoUsuario))
                if (rd.Read()) datos = new BEUsuarioDatos(rd);
            return datos;
        }

        public bool EnviarEmailVerificacionAutenticidad(int paisID, BEUsuarioDatos oUsu, int CantidadEnvios)
        {
            try
            {
                if (CantidadEnvios >= 3) return false;
                string paisISO = Portal.Consultoras.Common.Util.GetPaisISO(paisID);
                string paisesEsika = ConfigurationManager.AppSettings["PaisesEsika"] ?? "";
                var esEsika = paisesEsika.Contains(paisISO);
                string emailFrom = "no-responder@somosbelcorp.com";
                string emailTo = oUsu.Correo;
                string titulo = "(" + paisISO + ") Verificación de Autenticidad de Somosbelcorp";
                string logo = (esEsika ? Globals.RutaCdn + "/ImagenesPortal/Iconos/logo.png" : Globals.RutaCdn + "/ImagenesPortal/Iconos/logod.png");
                string nombrecorreo = oUsu.PrimerNombre.Trim();
                //string fondo = (esEsika ? "e81c36" : "642f80");
                string displayname = "Somos Belcorp";
                string codigoGenerado = Common.Util.GenerarCodigoRandom();
                Portal.Consultoras.Common.MailUtilities.EnviarMailPinAutenticacion(emailFrom, emailTo, titulo, displayname, logo, nombrecorreo, codigoGenerado);
                if (CantidadEnvios >= 2) oUsu.OpcionDesabilitado = true;
                InsCodigoGenerado(oUsu, paisID, Constantes.TipoEnvioEmailSms.EnviarPorEmail, codigoGenerado);
                return true;
            }
            catch (Exception ex)
            {
                LogManager.SaveLog(ex, oUsu.CodigoUsuario, paisID);
                return false;
            }
        }
        #endregion

        #region UserData
        public BEUsuario ConfiguracionPaisUsuario(BEUsuario usuario, string codigoConfiguracionPais)
        {
            var revistaDigitalModel = new BERevistaDigital();

            try
            {
                CodigoUsuarioLog = usuario.CodigoUsuario;
                PaisIDLog = usuario.PaisID;

                var configuraciones = GetConfiguracionPais(usuario);

                var lstCodigo = codigoConfiguracionPais.Split('|');
                var lstConfig = configuraciones.Where(x => lstCodigo.Any(y => y == x.Codigo));

                if (configuraciones.Any())
                {
                    var configuracionPaisDatosAll = GetConfiguracionPaisDatos(usuario);

                    foreach (var configuracion in lstConfig)
                    {
                        if (configuracion == null) return usuario;

                        var configuracionPaisDatos = configuracionPaisDatosAll.Where(d => d.ConfiguracionPaisID == configuracion.ConfiguracionPaisID).ToList();

                        switch (configuracion.Codigo)
                        {
                            case Constantes.ConfiguracionPais.RevistaDigital:
                                revistaDigitalModel = ConfiguracionPaisDatosRevistaDigital(revistaDigitalModel, configuracionPaisDatos, usuario.CodigoISO);
                                revistaDigitalModel = ConfiguracionPaisRevistaDigital(revistaDigitalModel, usuario);
                                revistaDigitalModel.BloqueoRevistaImpresa = configuracion.BloqueoRevistaImpresa;
                                usuario.RevistaDigital = revistaDigitalModel;
                                break;
                            case Constantes.ConfiguracionPais.RevistaDigitalReducida:
                                revistaDigitalModel.TieneRDCR = true;
                                revistaDigitalModel.BloqueoRevistaImpresa = revistaDigitalModel.BloqueoRevistaImpresa || configuracion.BloqueoRevistaImpresa;
                                continue;
                            case Constantes.ConfiguracionPais.RevistaDigitalIntriga:
                                revistaDigitalModel.TieneRDI = true;
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
                                usuario.beOfertaFinal = ofertaFinalModel;
                                break;
                            case Constantes.ConfiguracionPais.BuscadorYFiltros:
                                usuario.BuscadorYFiltrosConfiguracion = ConfiguracionPaisBuscadorYFiltro(configuracionPaisDatos);
                                break;
                        }
                    }
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
            catch (Exception ex)
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
            catch (Exception ex)
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
            revistaDigitalModel.EsActiva = revistaDigitalModel.SuscripcionEfectiva.EstadoRegistro == Constantes.EstadoRDSuscripcion.Activo;
            revistaDigitalModel.EsSuscrita = revistaDigitalModel.SuscripcionModel.EstadoRegistro == Constantes.EstadoRDSuscripcion.Activo;
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

        private BEBuscadorYFiltrosConfiguracion ConfiguracionPaisBuscadorYFiltro(List<BEConfiguracionPaisDatos> configuracionPaisDatos)
        {
            var buscadorYFiltrosConfiguracion = new BEBuscadorYFiltrosConfiguracion();
            short valor1 = 0;
            var mostrarBuscador = configuracionPaisDatos.Where(x => x.Codigo == Constantes.TipoConfiguracionBuscador.MostrarBuscador).FirstOrDefault();
            if (mostrarBuscador != null)
            {
                buscadorYFiltrosConfiguracion.MostrarBuscador = mostrarBuscador.Valor1 == "1";
            }
            mostrarBuscador = configuracionPaisDatos.Where(x => x.Codigo == Constantes.TipoConfiguracionBuscador.CaracteresBuscador).FirstOrDefault();
            if (mostrarBuscador != null)
            {
                short.TryParse(mostrarBuscador.Valor1, out valor1);
                buscadorYFiltrosConfiguracion.CaracteresBuscador = valor1;
            }
            mostrarBuscador = configuracionPaisDatos.Where(x => x.Codigo == Constantes.TipoConfiguracionBuscador.CaracteresBuscadorMostrar).FirstOrDefault();
            if (mostrarBuscador != null)
            {
                short.TryParse(mostrarBuscador.Valor1, out valor1);
                buscadorYFiltrosConfiguracion.CaracteresBuscadorMostrar = valor1;
            }
            mostrarBuscador = configuracionPaisDatos.Where(x => x.Codigo == Constantes.TipoConfiguracionBuscador.TotalResultadosBuscador).FirstOrDefault();
            if (mostrarBuscador != null)
            {
                short.TryParse(mostrarBuscador.Valor1, out valor1);
                buscadorYFiltrosConfiguracion.TotalResultadosBuscador = valor1;
            }

            return buscadorYFiltrosConfiguracion;
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

        public string GetActualizacionEmail(int paisID, string codigoUsuario)
        {
            return new DAUsuario(paisID).GetActualizacionEmail(codigoUsuario);
        }
        public string CancelarAtualizacionEmail(int paisID, string codigoUsuario)
        {
            return new DAUsuario(paisID).CancelarAtualizacionEmail(codigoUsuario);
        }

        public List<BEBuscadorYFiltros> listaProductos(int paisID, int CampaniaID, int filas, string CodigoDescripcion, int regionId, int zonaId, int codigoRegion, int codigoZona)
        {
            List<BEBuscadorYFiltros> BuscadorYFiltro = new List<BEBuscadorYFiltros>();
            var DAUsuario = new DAUsuario(paisID);
            using (IDataReader reader = DAUsuario.ListaProductos(CampaniaID, filas, CodigoDescripcion, regionId, zonaId, codigoRegion, codigoZona))
            {
                while (reader.Read())
                {
                    BuscadorYFiltro.Add(new BEBuscadorYFiltros(reader));
                }
            }
            return BuscadorYFiltro;
        }

        #region ActualizacionDatos
        public BERespuestaServicio EnviarSmsCodigo(int paisID, string codigoUsuario, string codigoConsultora, int campaniaID, bool esMobile, string celularActual, string celularNuevo)
        {
            int limiteMinimoTelef = 0, limiteMaximoTelef = 0, numero = 0;
            var valida = false;

            try
            {
                #region Validaciones
                celularNuevo = celularNuevo ?? string.Empty;
                Common.Util.GetLimitNumberPhone(paisID, out limiteMinimoTelef, out limiteMaximoTelef);
                if (celularNuevo.Length != limiteMaximoTelef)
                {
                    return ActualizacionDatosRespuesta(Constantes.ActualizacionDatosValidacion.Code.ERROR_CELULAR_LONGITUD, null, limiteMaximoTelef);
                }
                Common.Util.ObtenerIniciaNumeroCelular(paisID, out valida, out numero);
                if (valida)
                {
                    if (celularNuevo.Substring(0, 1) != numero.ToString())
                    {
                        return ActualizacionDatosRespuesta(Constantes.ActualizacionDatosValidacion.Code.ERROR_CELULAR_PRIMER_DIGITO, null, numero);
                    }
                }
                if (!Regex.IsMatch(celularNuevo, Constantes.ActualizacionDatosValidacion.ExpresionCelular))
                {
                    return ActualizacionDatosRespuesta(Constantes.ActualizacionDatosValidacion.Code.ERROR_CELULAR_INVALIDO);
                }
                var existe = ValidarTelefonoConsultora(paisID, celularNuevo, codigoUsuario);
                if (existe > 0)
                {
                    return ActualizacionDatosRespuesta(Constantes.ActualizacionDatosValidacion.Code.ERROR_CELULAR_USADO);
                }
                #endregion

                var response = RegistrarEnvioSms(paisID, codigoUsuario, codigoConsultora, campaniaID, esMobile, celularActual, celularNuevo);
                if (!response.Succcess)
                {
                    return ActualizacionDatosRespuesta(Constantes.ActualizacionDatosValidacion.Code.ERROR_INTERNO, response.Message);
                }

                return ActualizacionDatosRespuesta(Constantes.ActualizacionDatosValidacion.Code.SUCCESS);
            }
            catch (Exception ex)
            {
                LogManager.SaveLog(ex, codigoUsuario, paisID);
                return ActualizacionDatosRespuesta(Constantes.ActualizacionDatosValidacion.Code.ERROR_INTERNO, ex.Message);
            }
        }

        private BERespuestaServicio ActualizacionDatosRespuesta(string code, string message = null, params object[] args)
        {
            if (string.IsNullOrEmpty(message))
            {
                message = Constantes.ActualizacionDatosValidacion.Message.ContainsKey(code) ?
                                    Constantes.ActualizacionDatosValidacion.Message[code] : message;
            }

            return new BERespuestaServicio()
            {
                Code = code,
                Message = string.Format(message, args),
                Succcess = code == Constantes.ActualizacionDatosValidacion.Code.SUCCESS
            };
        }

        private BERespuestaActivarEmail ActivacionEmailRespuesta(string code, string message = null, BEBelcorpResponde belcorpResponde = null, params object[] args) {
            if (string.IsNullOrEmpty(message))
            {
                message = Constantes.ActualizacionDatosValidacion.Message.ContainsKey(code) ?
                                    Constantes.ActualizacionDatosValidacion.Message[code] : message;
            }

            return new BERespuestaActivarEmail()
            {
                Code = code,
                Message = string.Format(message, args),
                Succcess = code == Constantes.ActualizacionDatosValidacion.Code.SUCCESS,
                BelcorpResponde = belcorpResponde
            };
        }
        #endregion
    }
}
