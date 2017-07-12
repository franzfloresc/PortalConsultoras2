using Portal.Consultoras.Data;
using Portal.Consultoras.Data.Hana;
using Portal.Consultoras.Entities;
using Portal.Consultoras.PublicService.Cryptography;
using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.DirectoryServices;
using System.DirectoryServices.AccountManagement;
using System.IO;
using System.Linq;

using Portal.Consultoras.Common;

namespace Portal.Consultoras.BizLogic
{
    public partial class BLUsuario
    {
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
        
        //1796 Inicio
        public int UpdUsuarioRechazarInvitacion(int PaisID, string CodigoUsuario)
        {
            var DAUsuario = new DAUsuario(PaisID);
            return DAUsuario.UpdUsuarioRechazarInvitacion(CodigoUsuario);
        }
        //1796 Fin

        public void UpdateDatos(BEUsuario usuario, string CorreoAnterior)
        {
            var DAUsuario = new DAUsuario(usuario.PaisID);
            DAUsuario.UpdUsuarioDatos(usuario, CorreoAnterior);
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

            try
            {
                DirectoryEntry entry = new DirectoryEntry(ConfigurationManager.AppSettings["cnxActiveDirectoryUser"], ConfigurationManager.AppSettings["UserAD"], ConfigurationManager.AppSettings["PassAD"], AuthenticationTypes.Secure | AuthenticationTypes.Sealing | AuthenticationTypes.ServerBind);
                DirectorySearcher search = new DirectorySearcher(entry);
                search.Filter = "(samaccountname= " + iso + codigoUsuario + ")";
                SearchResult resEnt = search.FindOne();
                if (resEnt != null)
                {
                    DirectoryEntry dey = resEnt.GetDirectoryEntry();
                    dey.Properties["mail"].Value = email;
                    dey.CommitChanges();
                    dey.Close();
                }
                entry.Close();
            }
            catch (Exception)
            {
                Activado = false;
            }
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
                        usuario.PROLSinStock = configuracion.PROLSinStock; //1510
                        usuario.NuevoPROL = configuracion.NuevoPROL; //RQ_NP - R2133
                        usuario.ZonaNuevoPROL = configuracion.ZonaNuevoPROL; //RQ_NP - R2133
                        usuario.EstadoSimplificacionCUV = configuracion.EstadoSimplificacionCUV; /*R20150701*/
                        usuario.EsquemaDAConsultora = configuracion.EsquemaDAConsultora;
                        usuario.HoraCierreZonaDemAntiCierre = configuracion.HoraCierreZonaDemAntiCierre; //R20151126
                        usuario.ValidacionInteractiva = configuracion.ValidacionInteractiva; //R20160306
                        usuario.MensajeValidacionInteractiva = configuracion.MensajeValidacionInteractiva; //R20160306
                        usuario.IndicadorGPRSB = configuracion.IndicadorGPRSB;
                        usuario.FechaActualPais = configuracion.FechaActualPais;
                        usuario.EstadoPedido = configuracion.EstadoPedido;
                        usuario.ValidacionAbierta = configuracion.ValidacionAbierta;
                        usuario.AceptacionConsultoraDA = configuracion.AceptacionConsultoraDA;
                    }
                }

                // EPD-2058
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

                        //EPD-2311 (Mostrar mensaje al ingresar al pase de pedido)
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
            }

            return usuario;
        }

        public string GetUsuarioAsociado(int paisID, string codigoConsultora)
        {
            var DAUsuario = new DAUsuario(paisID);
            return DAUsuario.GetUsuarioAsociado(codigoConsultora);
        }

        public bool IsUserExist(string CodigoUsuario)
        {
            bool _Existe = false;
            DirectoryEntry entry = new DirectoryEntry(ConfigurationManager.AppSettings["cnxActiveDirectoryUser"], ConfigurationManager.AppSettings["UserAD"], ConfigurationManager.AppSettings["PassAD"]);
            DirectorySearcher search = new DirectorySearcher(entry);
            search.Filter = "(samaccountname= " + CodigoUsuario + ")";
            search.PropertiesToLoad.Add("mail");
            search.PropertiesToLoad.Add("samaccountname");
            search.PropertiesToLoad.Add("givenname");
            search.PropertiesToLoad.Add("sn");
            SearchResult resEnt = search.FindOne();

            if (resEnt != null)
                _Existe = true;
            return _Existe;
        }

        public string GetUserUPN(string Email)
        {
            string UserUPN = string.Empty;

            DirectoryEntry entry = new DirectoryEntry(ConfigurationManager.AppSettings["cnxActiveDirectoryUser"], ConfigurationManager.AppSettings["UserAD"], ConfigurationManager.AppSettings["PassAD"]);
            DirectorySearcher search = new DirectorySearcher(entry);
            search.Filter = "(mail= " + Email + ")";
            search.PropertiesToLoad.Add("mail");
            search.PropertiesToLoad.Add("samaccountname");
            search.PropertiesToLoad.Add("givenname");
            search.PropertiesToLoad.Add("sn");
            SearchResult resEnt = search.FindOne();

            if (resEnt != null)
                UserUPN = (string)resEnt.Properties["samaccountname"][0];

            return UserUPN;
        }

        public bool ChangePasswordUser(int paisID, string codigoUsuarioAutenticado, string emailCodigoUsuarioModificado, string password, string emailUsuarioModificado, EAplicacionOrigen origen)
        {
            bool isChanged = false;

            DirectoryEntry userEntry = GetUserEntry(emailCodigoUsuarioModificado);

            if (userEntry != null)
            {
                userEntry.UsePropertyCache = true;

                userEntry.Invoke("SetPassword", new object[] { password });
                userEntry.CommitChanges();
                userEntry.Close();

                var DAUsuario = new DAUsuario(paisID);
                DAUsuario.InsLogCambioContrasenia(codigoUsuarioAutenticado, emailCodigoUsuarioModificado, password, emailUsuarioModificado, Enum.GetName(typeof(EAplicacionOrigen), origen));

                isChanged = true;
            }
            return isChanged;
        }

        public DirectoryEntry GetUserEntry(string CodigoEmail)
        {
            bool isEmail = CodigoEmail.Contains('@');
            DirectoryEntry directoryEntry = new DirectoryEntry(ConfigurationManager.AppSettings["cnxActiveDirectoryUser"], ConfigurationManager.AppSettings["UserAD"], ConfigurationManager.AppSettings["PassAD"], AuthenticationTypes.Secure | AuthenticationTypes.Sealing | AuthenticationTypes.ServerBind);
            DirectorySearcher search = new DirectorySearcher(directoryEntry);

            if (isEmail)
                search.Filter = "(mail= " + CodigoEmail + ")";
            else
                search.Filter = "(samaccountname=" + CodigoEmail + ")";

            SearchResult resEnt = search.FindOne();

            if (resEnt != null)
            {
                DirectoryEntry userEntry = resEnt.GetDirectoryEntry();
                return userEntry;
            }
            else
                return null;
        }

        public int ValidateUserCredentialsActiveDirectory(int paisID, string codigoUsuarioAutenticado, string codigoUsuarioModificado, string OldPassword, string NewPassword)
        {
            /*
                0 ==> Password Incorrecto
             *  1 ==> Cambio de Password Falló 
             */
            int isValid = 0;
            try
            {
                using (PrincipalContext pc = new PrincipalContext(ContextType.Domain, ConfigurationManager.AppSettings["ServerAD"], ConfigurationManager.AppSettings["ContainerAD"], ConfigurationManager.AppSettings["UserAdmin"], ConfigurationManager.AppSettings["UserPass"]))
                {
                    isValid = Convert.ToInt32(pc.ValidateCredentials(codigoUsuarioModificado, OldPassword));
                }
                if (Convert.ToBoolean(isValid))
                {
                    bool rslt = ChangePasswordUser(paisID, codigoUsuarioAutenticado, codigoUsuarioModificado, NewPassword, string.Empty, EAplicacionOrigen.MisDatosConsultora);
                    if (!rslt)
                        isValid = 1;
                    else
                        isValid = 2;
                }
            }

            catch (Exception)
            {
                isValid = 0;
            }
            return isValid;
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

        /*EPD-1012*/
        public BEValidaLoginSB2 GetValidarLoginSB2(int paisID, string codigoUsuario, string contrasenia)
        {
            BEValidaLoginSB2 validaLogin = null; 
            var DAUsuario = new DAUsuario(paisID);

            using (IDataReader reader = DAUsuario.GetValidarLoginSB2(codigoUsuario, contrasenia))
            {
                if (reader.Read())
                    validaLogin = new BEValidaLoginSB2(reader);
            }

            return validaLogin;
        }
        /*EPD-1012*/

        /*EPD-2340*/
        public BEValidaLoginSB2 GetValidarAutoLogin(int paisID, string codigoUsuario, string proveedor)
        {
            BEValidaLoginSB2 validaLogin = null;
            var DAUsuario = new DAUsuario(paisID);

            using (IDataReader reader = DAUsuario.GetValidarAutoLogin(codigoUsuario, proveedor))
            {
                if (reader.Read())
                    validaLogin = new BEValidaLoginSB2(reader);
            }

            return validaLogin;
        }

        public int InsUsuarioExternoPais(int paisID, BEUsuarioExternoPais entidad)
        {
            var DAUsuario = new DAUsuario(paisID);

            return DAUsuario.InsUsuarioExternoPais(entidad);
        }
        /*EPD-2340*/

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
                                        //return 2;
                                    }
                                    else
                                    {
                                        //Se valida las campañas que no ha ingresado
                                        //if (CampaniaActual - UltimaCampania > 100 && UltimaCampania != 0)
                                        //    return 2;
                                        //else
                                        //{
                                        //Validamos el Autoriza Pedido
                                        if (AutorizaPedido == "N")
                                        {
                                            return 2;
                                        }
                                        else
                                            return 3;
                                        //return 3;
                                        //}
                                    }
                                }
                                else
                                {
                                    //Validamos si el estado es retirada
                                    BETablaLogicaDatos Restriccion_Egresada = tabla_Egresada.Find(p => Convert.ToInt32(p.Codigo.Trim()) == IdEstadoActividad);
                                    if (Restriccion_Egresada != null)
                                    {
                                        //if (paisID == 6)  R2133
                                        //    return 2;
                                        //else
                                        //{
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
                                        //} R2133
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

                        if (CampaniaActual - UltimaCampania > 3 && UltimaCampania != 0) return 2;
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

        #region Funciones AD
        public bool CreateActiveDirectoryUser(string login, string alias, string firstname, string lastname, string PaisISO, string Clave)
        {
            bool _result = false;

            try
            {
                DirectoryEntry de = new DirectoryEntry(ConfigurationManager.AppSettings["cnxActiveDirectoryUser"], ConfigurationManager.AppSettings["UserAD"], ConfigurationManager.AppSettings["PassAD"], AuthenticationTypes.Secure | AuthenticationTypes.Sealing | AuthenticationTypes.ServerBind);
                DirectoryEntries users = de.Children;
                DirectoryEntry newuser = users.Add("CN=" + alias, "User");
                SetProperty(newuser, "givenname", firstname.Trim());
                SetProperty(newuser, "sn", lastname.Trim());
                SetProperty(newuser, "SAMAccountName", login);
                SetProperty(newuser, "userPrincipalName", alias);
                newuser.CommitChanges();
                newuser.RefreshCache();
                DirectoryEntry dr = GetUserBySamaccountname(login);


                if (dr != null)
                {
                    SetPassword(dr, Clave);
                    EnableAccount(dr);
                    newuser.CommitChanges();
                    newuser.RefreshCache();
                    newuser.Close();
                    de.RefreshCache();
                    de.Close();
                    _result = true;
                }
            }
            catch (DirectoryServicesCOMException)
            {
                _result = false;
            }
            return _result;
        }
        private void SetProperty(DirectoryEntry de, string PropertyName, string PropertyValue)
        {
            if (PropertyValue != null)
            {
                if (de.Properties.Contains(PropertyName))
                {
                    de.Properties[PropertyName][0] = PropertyValue;
                }
                else
                {
                    de.Properties[PropertyName].Add(PropertyValue);
                }
            }
        }
        private DirectoryEntry GetUserBySamaccountname(string samaccountname)
        {
            DirectoryEntry directoryEntry = new DirectoryEntry(ConfigurationManager.AppSettings["cnxActiveDirectoryUser"], ConfigurationManager.AppSettings["UserAD"], ConfigurationManager.AppSettings["PassAD"], AuthenticationTypes.Secure | AuthenticationTypes.Sealing | AuthenticationTypes.ServerBind);

            DirectorySearcher search = new DirectorySearcher(directoryEntry);
            search.Filter = "(samaccountname=" + samaccountname + ")";
            SearchResult resEnt = search.FindOne();

            if (resEnt != null)
            {
                DirectoryEntry userEntry = resEnt.GetDirectoryEntry();
                return userEntry;
            }
            else
            {
                return null;
            }
        }
        private void SetPassword(DirectoryEntry usr, string pass)
        {
            usr.UsePropertyCache = true;
            usr.Invoke("SetPassword", new object[] { pass });
            usr.CommitChanges();
            usr.RefreshCache();
            usr.Close();
        }
        private void EnableAccount(DirectoryEntry de)
        {
            int exp = (int)de.Properties["userAccountControl"].Value;
            de.Properties["userAccountControl"].Value = exp | 0x0001;
            de.CommitChanges();
            de.RefreshCache();
            int val = (int)de.Properties["userAccountControl"].Value;
            de.Properties["userAccountControl"].Value = val & ~0x0002;
            de.CommitChanges();
            de.RefreshCache();
        }
        #endregion

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

        public void InsLogIngresoPortal(int paisID, string CodigoConsultora, string IPOrigen, byte Tipo, string DetalleError)
        {
            var DAUsuario = new DAUsuario(paisID);
            DAUsuario.InsLogIngresoPortal(CodigoConsultora, IPOrigen, Tipo, DetalleError);
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
        /*2116 -inicio*/
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
        /*2116-fin */

        /* R2392 - AHAA - LIDERES - INICIO */
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
            int[] paises = { 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14};

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
        /* R2392 - AHAA - LIDERES - FIN */

        /*R2520 - JICM - LIDERES - INI*/
      

        public List<BEUsuario> ObtenerResultadoEncuesta(int paisID, int campaniaInicio, int campaniaFin)
        {
            List<BEUsuario> usuariosLideres = new List<BEUsuario>();
            /*R2520 - ICM Lider - Solo conectará a la Base de Datos BelcorpPerú,
             Para la consulta hacia la tabla Líderes.Encuesta,
             Pero el filtro si se realizará por el pais que se esté
             enviando como parámetro.*/
            DAUsuario DAUsuario = new DAUsuario(11);
            using (IDataReader reader = DAUsuario.GenerarReporteResultadoEncuesta(paisID, campaniaInicio, campaniaFin))
            {
                while (reader.Read())
                {
                    BEUsuario usuario = new BEUsuario(reader, "Lideres","Lideres");
                    usuariosLideres.Add(usuario);
                }
            }
            return usuariosLideres;

        }  

        /*R2520 - JICM - LIDERES - FIN*/

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
                    correo, Enum.GetName(typeof (EAplicacionOrigen), origen));
                resultado = true;
            }
            catch (Exception ex)
            {
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
                        correo = lst[0].Descripcion;// contiene el correo del destinatario
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

                        if(usuario.EMail != CorreoAnterior)
                        {
                            string emailFrom = "no-responder@somosbelcorp.com"; 
                            string emailTo = usuario.EMail;
                            string titulo = "Confirmación de Correo";
                            string displayname = usuario.Nombre;
                            string url = ConfigurationManager.AppSettings["CONTEXTO_BASE"];
                            string nomconsultora = (string.IsNullOrEmpty(usuario.Sobrenombre) ? usuario.PrimerNombre : usuario.Sobrenombre);

                            string[] parametros = new string[] { usuario.CodigoUsuario, usuario.PaisID.ToString(), usuario.CodigoISO, usuario.EMail };
                            string param_querystring = Portal.Consultoras.Common.Util.EncriptarQueryString(parametros);
                            //este Log para hacer verificar error al DesencriptarQueryString
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

        //EPD-1836
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
                                    string asuntoEmail = consultoraEmail.EsPostulante ? "Creacion de cuenta de Somos Belcorp" : "Mensaje de bienvenida";
                                    string[] PaisesLbel = { "MX", "CR", "PA", "PR" };

                                    bool eslbel = false;
                                    if (PaisesLbel.Contains(paisISO)) {
                                        eslbel = true;
                                    }

                                    string pathTemplate = AppDomain.CurrentDomain.BaseDirectory + "bin\\Templates\\esika_email_consultora.html";
                                    if (eslbel) {
                                        pathTemplate = AppDomain.CurrentDomain.BaseDirectory + "bin\\Templates\\lbel_email_consultora.html";
                                    }

                                    string htmlTemplate;
                                    using (StreamReader reader = new StreamReader(pathTemplate))
                                    {
                                        htmlTemplate = reader.ReadToEnd();
                                    }

                                    if (!string.IsNullOrEmpty(htmlTemplate))
                                    {
                                        //string[] configuracionCorreo = ConfiguracionCorreo(PaisISO);
                                        //string UrlValidacion = Settings.Default.UrlValidacion;
                                        //string UrlPortal = Settings.Default.UrlPortal;

                                        //string telefono1 = configuracionCorreo[1];
                                        //string msgbox_nombre = Consultora.GerenteZonaNombre.Length > 0 ? Consultora.GerenteZonaNombre : "";
                                        //string msgbox_email = Consultora.GerenteZonaEmail.Length > 0 ? Consultora.GerenteZonaEmail : "";
                                        //string param_querystring = login.Substring(2) + "," + ObtenerPaisIDByISO(PaisISO) + "," + PaisISO + "," + email;
                                        //param_querystring = encriptar(param_querystring).Replace("+", "ABCDE");

                                        string gznombre = consultoraEmail.GerenteZonaNombre.Length > 0 ? consultoraEmail.GerenteZonaNombre : "";
                                        string gzemail = consultoraEmail.GerenteZonaEmail.Length > 0 ? consultoraEmail.GerenteZonaEmail : "";
                                        string telefono1 = ConfigurationManager.AppSettings.Get("TelefonoCentroAtencion").ToString();
                                        //string codusuario = consultoraEmail.Codigo.Substring(2);
                                        string codusuario = consultoraEmail.Codigo;

                                        if (eslbel)
                                        {
                                            if (paisISO == "MX" || paisISO == "CR") {
                                                htmlTemplate.Replace("#DISPLAY1#", "");
                                            }
                                            else {
                                                htmlTemplate.Replace("#DISPLAY1#", "nomostrar");
                                            }
                                        }

                                        htmlTemplate = htmlTemplate.Replace("#TELEFONO1#", telefono1);
                                        htmlTemplate = htmlTemplate.Replace("#TELEFONO2#", "");
                                        //htmlTemplate = htmlTemplate.Replace("#CODIGO_USUARIO#", codusuario);
                                        //htmlTemplate = htmlTemplate.Replace("#PASSWORD#", consultoraEmail.Clave);
                                        htmlTemplate = htmlTemplate.Replace("#PRIMER_NOMBRE#", consultoraEmail.NombreCompleto);
                                        htmlTemplate = htmlTemplate.Replace("#NOMBRE_CONTACTO#", gznombre);
                                        htmlTemplate = htmlTemplate.Replace("#EMAIL_CONTACTO#", gzemail);

                                        //EnviarMail("no-responder@somosbelcorp.com", email, asuntoEmail, mensaje, true, "", PaisISO);
                                        Common.Util.EnviarMail("no-responder@somosbelcorp.com", entidad.Correo, asuntoEmail, htmlTemplate, true, null);

                                        //InsLogEnvioEmailBienvenida(PaisISO, Consultora, EsConsultoraReactivada);
                                        DAUsuario.InsLogEnvioEmailConsultora(consultoraEmail);
                                        //Actualizando flag envio de correo
                                        DAUsuario.UpdFlagEnvioCorreo(codusuario);
                                    }
                                    else
                                    {
                                        throw new Exception("No se encontro la ruta del template: " + pathTemplate);
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
            int r = 0;

            try
            {
                if (!string.IsNullOrEmpty(numeroDocumento))
                {
                    var DAUsuario = new DAUsuario(paisID);
                    int r1 = DAUsuario.DelUsuarioPostulante(numeroDocumento);
                    r = (r1 > 0) ? 1 : 0;
                }
            }
            catch (Exception ex)
            {
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
            }

            return postulante;
        }
        
        /*EPD-1837*/
        public int InsertUsuarioExterno(int paisID, BEUsuarioExterno usuarioExterno)
        {
            var DAUsuario = new DAUsuario(paisID);
            return DAUsuario.InsUsuarioExterno(usuarioExterno);
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

        public BEUsuarioExterno GetUsuarioExternoByProveedorAndIdApp(string proveedor, string idAplicacion)
        {
            var DAUsuario1 = new DAUsuario(11);
            BEUsuarioExternoPais entidad1 = null;
            BEUsuarioExterno entidad2 = null;

            using (IDataReader reader = DAUsuario1.GetUsuarioExternoPaisByProveedorAndIdApp(proveedor, idAplicacion))
            {
                if (reader.Read())
                    entidad1 = new BEUsuarioExternoPais(reader);
            }

            if (entidad1 != null)
            {
                var DAUsuario2 = new DAUsuario(entidad1.PaisID);
                using (IDataReader reader = DAUsuario2.GetUsuarioExternoByProveedorAndIdApp(proveedor, idAplicacion))
                {
                    if (reader.Read())
                        entidad2 = new BEUsuarioExterno(reader);
                }

                entidad2.PaisID = entidad1.PaisID;
                entidad2.CodigoISO = entidad1.CodigoISO;
            }

            return entidad2;
        }

        public List<BEUsuarioExterno> GetListaLoginExterno(int paisID, String codigoUsuario)
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

        /*
        public bool GetExisteEmailActivo(int paisID, string email)
        {
            var DAUsuario = new DAUsuario(paisID);
            return DAUsuario.GetExisteEmailActivo(email);
        }
         * */

        /*EPD-1837*/

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
    }
}
