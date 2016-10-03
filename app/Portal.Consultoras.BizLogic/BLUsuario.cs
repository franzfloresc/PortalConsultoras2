using Portal.Consultoras.Data;
using Portal.Consultoras.Entities;
using Portal.Consultoras.PublicService.Cryptography;
using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.DirectoryServices;
using System.DirectoryServices.AccountManagement;
using System.Linq;

namespace Portal.Consultoras.BizLogic
{
    public class BLUsuario
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

        public int UpdateDatosPrimeraVez(int PaisID, string CodigoUsuario, string Email, string Telefono, string Celular, string CorreoAnterior, bool AceptoContrato)
        {
            var DAUsuario = new DAUsuario(PaisID);
            return DAUsuario.UpdUsuarioDatosPrimeraVez(CodigoUsuario, Email, Telefono, Celular, CorreoAnterior, AceptoContrato); //2532 EGL
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

        public BEUsuario GetSesionUsuario(int paisID, string codigoUsuario)
        {
            BEUsuario usuario = null;
            BEConfiguracionCampania configuracion = null;
            var DAUsuario = new DAUsuario(paisID);
            var DAConfiguracionCampania = new DAConfiguracionCampania(paisID);
            using (IDataReader reader = DAUsuario.GetSesionUsuario(codigoUsuario))
                if (reader.Read())
                    usuario = new BEUsuario(reader, true);

            if (usuario != null)
            {
                if (usuario.ConsultoraID != 0)
                {
                    using (IDataReader reader = DAConfiguracionCampania.GetConfiguracionCampania(paisID, usuario.ZonaID, usuario.RegionID, usuario.ConsultoraID))
                        if (reader.Read())
                            configuracion = new BEConfiguracionCampania(reader);
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
                        //usuario.IndicadorEnviado = configuracion.IndicadorEnviado;
                        usuario.IndicadorRechazado = configuracion.IndicadorRechazado;
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
        public int UpdateDatosPrimeraVezMexico(int PaisID, string CodigoUsuario, string Nombre, string Apellidos, string Telefono, string Celular, string Email, long IdConsultora, string CodigoConsultora, int CampaniaID_Actual, int CampaniaID_UltimaF, int RegionID, int ZonaID, string EmailAnterior)
        {
            var DAUsuario = new DAUsuario(PaisID);
            return DAUsuario.UpdUsuarioDatosPrimeraVezMexico(CodigoUsuario, Nombre, Apellidos, Telefono, Celular, Email, IdConsultora, CodigoConsultora, CampaniaID_Actual, CampaniaID_UltimaF, RegionID, ZonaID, EmailAnterior);
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
    }
}
