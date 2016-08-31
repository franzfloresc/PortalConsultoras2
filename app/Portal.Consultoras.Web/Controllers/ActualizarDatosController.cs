using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using Portal.Consultoras.Web.ServiceUsuario;
using Portal.Consultoras.Common;
using Portal.Consultoras.Web.Models;
using AutoMapper;
using PE = Portal.Consultoras.Web.ServiceActualizaDatosConsultoraPeru;
using CL = Portal.Consultoras.Web.ServiceActualizaDatosConsultoraChile;
using EC = Portal.Consultoras.Web.ServiceActualizaDatosConsultoraEcuador;
using System.Configuration;
using System.ServiceModel;

namespace Portal.Consultoras.Web.Controllers
{
    public class ActualizarDatosController : BaseController
    {
        public ActionResult Index()
        {
            BEUsuario beusuario = new BEUsuario();
            var model = new ActualizarDatosModel();

            try
            {
                using (UsuarioServiceClient sv = new UsuarioServiceClient())
                {
                    beusuario = sv.Select(userData.PaisID, userData.CodigoUsuario);
                }

                if (beusuario != null)
                {
                    model.NombreCompleto = beusuario.Nombre;
                    model.EMail = beusuario.EMail;
                    model.Telefono = beusuario.Telefono;
                    model.Celular = beusuario.Celular;
                }
            }
            catch (FaultException ex)
            {
                LogManager.LogManager.LogErrorWebServicesPortal(ex, userData.CodigoConsultora, userData.CodigoISO);
            }
            catch (Exception ex)
            {
                LogManager.LogManager.LogErrorWebServicesBus(ex, userData.CodigoConsultora, userData.CodigoISO);
            }

            return View(model);
        }

        [HttpPost]
        public JsonResult Registrar(ConsultoraFicticiaModel model)
        {
            try
            {
                string sEmail = string.Empty;
                string sTelefono = string.Empty;
                string sCelular = string.Empty;

                if (model.ActualizarClave == null) model.ActualizarClave = "";
                if (model.ConfirmarClave == null) model.ConfirmarClave = "";
                if (model.Email != null)
                    sEmail = model.Email;
                if (model.Telefono != null)
                    sTelefono = model.Telefono;
                if (model.Celular != null)
                    sCelular = model.Celular;

                int result;
                bool cambio;
                string resultado = string.Empty;

                if (model.Email != string.Empty)
                {
                    int cantidad = 0;
                    using (UsuarioServiceClient svr = new UsuarioServiceClient())
                    {
                        cantidad = svr.ValidarEmailConsultora(userData.PaisID, model.Email, userData.CodigoUsuario);

                        if (cantidad > 0)
                        {
                            return Json(new
                            {
                                success = false,
                                message = "La dirección de correo electrónico ingresada ya pertenece a otra Consultora.",
                                extra = ""
                            });
                        }
                    }
                }

                using (UsuarioServiceClient sv = new UsuarioServiceClient())
                {
                    result = sv.UpdateDatosPrimeraVez(userData.PaisID, userData.CodigoUsuario, model.Email, model.Telefono, model.Celular, model.CorreoAnterior, model.AceptoContrato);

                    if (result == 0)
                    {
                        return Json(new
                        {
                            success = false,
                            message = "Error al actualizar datos, intentelo mas tarde",
                            extra = ""
                        });
                    }
                    else
                    {
                        string message = string.Empty;

                        if (model.ActualizarClave != "")
                        {
                            cambio = sv.ChangePasswordUser(userData.PaisID, userData.CodigoUsuario, userData.CodigoISO + userData.CodigoUsuario, model.ConfirmarClave.ToUpper(), string.Empty, EAplicacionOrigen.BienvenidaConsultora);

                            if (cambio)
                            {
                                message = "- Los datos han sido actualizados correctamente.\n ";
                            }
                            else
                            {
                                message = "- Los datos han sido actualizados correctamente.\n - La contraseña no ha sido modificada, intentelo mas tarde.\n ";
                            }

                        }
                        else
                        {
                            message = "- Los datos han sido actualizados correctamente.\n ";
                        }
                        if (!string.IsNullOrEmpty(model.Email))
                        {
                            //try
                            //{
                            //    resultado = Convert.ToString(sv.UpdActualizarDatos(UserData().PaisID, UserData().CodigoConsultora, model.Email, model.Celular, model.Telefono));
                            //}
                            //catch (Exception ex)
                            //{
                            //    LogManager.LogManager.LogErrorWebServicesBus(ex, UserData().CodigoConsultora, UserData().CodigoISO);
                            //    resultado = "0";
                            //}
                            resultado = "1";
                            if (resultado == "1")
                            {
                                try
                                {
                                    //UsuarioModel UsuarioModelSession = UserData();
                                    //UsuarioModelSession.EMail = model.Email;
                                    //if (model.Celular == null)
                                    //    UsuarioModelSession.Celular = model.Celular;
                                    //if (model.Telefono == null)
                                    //    UsuarioModelSession.Telefono = model.Telefono;
                                    //SetUserData(UsuarioModelSession);

                                    string[] parametros = new string[] { userData.CodigoUsuario, userData.PaisID.ToString(), userData.CodigoISO, model.Email };
                                    string param_querystring = Util.EncriptarQueryString(parametros);
                                    //Mejora-Correo
                                    //string nomPais = Util.ObtenerNombrePaisPorISO(userData.CodigoISO);
                                    HttpRequestBase request = this.HttpContext.Request;

                                    string cadena = "<br /><br /> Estimada consultora " + userData.NombreConsultora + " Para confirmar la dirección de correo electrónico ingresada haga click " +
                                                      "<br /> <a href='" + Util.GetUrlHost(request) + "WebPages/MailConfirmation.aspx?data=" + param_querystring + "'>aquí</a><br/><br/>Belcorp";//R2442
                                    //Mejora-Correo
                                    //string cadena = "<br /><br /> Estimada consultora " + userData.NombreConsultora + " Para confirmar la dirección de correo electrónico ingresada haga click " +
                                    //                  "<a href='" + Util.GetUrlHost(request) + "WebPages/MailConfirmation.aspx?data=" + param_querystring + "'>aquí</a>" +
                                    //                  "<div style='font-family:Arial, Helvetica, sans-serif, serif; font-weight:bold; font-size:12px; text-align:right; padding-top:8px;'>Belcorp - " + nomPais + "</div>";

                                    //Mejora-Correo
                                    //Util.EnviarMail("no-responder@somosbelcorp.com", model.Email, "Confimación de Correo", cadena, true, string.Format("{0} - Confirmacion de correo", Util.SinAcentosCaracteres(nomPais.ToUpper())));
                                    Util.EnviarMail("no-responder@somosbelcorp.com", model.Email, "(" + userData.CodigoISO + ") Confimacion de Correo", cadena, true, userData.NombreConsultora);
                                    message += "- Se ha enviado un correo electrónico de verificación a la dirección ingresada.";
                                }
                                catch (Exception ex)
                                {
                                    message += ex.Message;//"- Ha ocurrido un error en el envío del correo de verificación.";
                                }
                            }
                            else
                            {
                                return Json(new
                                {
                                    Cantidad = 0,
                                    success = true,
                                    message = "- El servicio de actualización de datos no se encuentra disponible en estos momentos. Por favor, inténtelo más tarde.",
                                    extra = ""
                                });
                            }
                        }
                        userData.CambioClave = 1;
                        userData.EMail = sEmail;
                        userData.Telefono = sTelefono;
                        userData.Celular = sCelular;

                        return Json(new
                        {
                            success = true,
                            message = message,
                            extra = ""
                        });
                    }
                }
            }
            catch (FaultException ex)
            {
                LogManager.LogManager.LogErrorWebServicesPortal(ex, userData.CodigoConsultora, userData.CodigoISO);
                return Json(new
                {
                    success = false,
                    message = ex.Message,
                    extra = ""
                });
            }
            catch (Exception ex)
            {
                LogManager.LogManager.LogErrorWebServicesBus(ex, userData.CodigoConsultora, userData.CodigoISO);
                return Json(new
                {
                    success = false,
                    message = ex.Message,
                    extra = ""
                });
            }
        }
        //1796 
        [HttpPost]
        public JsonResult RechazarInvitacionFlexipago()
        {

            try
            {
                int result = 0;
                using (UsuarioServiceClient sv = new UsuarioServiceClient())
                {
                    result = sv.UpdUsuarioRechazarInvitacion(userData.PaisID, userData.CodigoUsuario);
                    if (result == 0)
                    {
                        return Json(new
                        {
                            success = false,
                            message = "Error al actualizar Rechazo de Incitación, intentelo mas tarde",
                            extra = ""
                        });
                    }
                    else
                    {
                        return Json(new
                        {
                            success = true,
                            message = ""
                        });
                    }
                }
            }
            catch (FaultException ex)
            {
                LogManager.LogManager.LogErrorWebServicesPortal(ex, userData.CodigoConsultora, userData.CodigoISO);
                return Json(new
                {
                    success = false,
                    message = ex.Message,
                    extra = ""
                });
            }
            catch (Exception ex)
            {
                LogManager.LogManager.LogErrorWebServicesBus(ex, userData.CodigoConsultora, userData.CodigoISO);
                return Json(new
                {
                    success = false,
                    message = ex.Message,
                    extra = ""
                });
            }


        }
        //1796
        [HttpPost]
        public JsonResult Cancelar(ConsultoraFicticiaModel model)
        {
            try
            {
                int result = 0;

                using (UsuarioServiceClient sv = new UsuarioServiceClient())
                {

                    result = sv.UpdUsuarioDatosPrimeraVezEstado(userData.PaisID, userData.CodigoUsuario);

                    if (result == 0)
                    {
                        return Json(new
                        {
                            success = false,
                            message = "Error al actualizar datos, intentelo mas tarde",
                            extra = ""
                        });
                    }
                    else
                    {
                        userData.CambioClave = 1;
                        Session["PrimeraVezSession"] = null;

                        return Json(new
                        {
                            success = true,
                            message = "Los datos han sido actualizados correctamente."
                        });
                    }
                }
            }
            catch (FaultException ex)
            {
                LogManager.LogManager.LogErrorWebServicesPortal(ex, userData.CodigoConsultora, userData.CodigoISO);
                return Json(new
                {
                    success = false,
                    message = ex.Message,
                    extra = ""
                });
            }
            catch (Exception ex)
            {
                LogManager.LogManager.LogErrorWebServicesBus(ex, userData.CodigoConsultora, userData.CodigoISO);
                return Json(new
                {
                    success = false,
                    message = ex.Message,
                    extra = ""
                });
            }
        }
    

        //R2116 INICIO
        public JsonResult RegistrarMexico(ConsultoraFicticiaModel model)
        {
            try
            {
                string sEmail = string.Empty;
                string sTelefono = string.Empty;
                string sCelular = string.Empty;
                string sNombre = string.Empty;
                string sApellidos = string.Empty;
                long sConsultorioID = 0;
                string sCodigoConsultora = string.Empty;
                string sEmailAnterior = string.Empty;
                int campaniaID = 0;
                int campaniaUltimo = 0;
                int result;
                int regionID = 0;
                int zonaID = 0;

                if (model.m_Nombre != null) sNombre = model.m_Nombre;
                if (model.m_Apellidos != null) sApellidos = model.m_Apellidos;
                if (model.Email != null) sEmail = model.Email;
                if (model.Telefono != null) sTelefono = model.Telefono;
                if (model.Celular != null) sCelular = model.Celular;
                sConsultorioID = model.ConsultoraID;
                if (model.CodigoConsultora != null) sCodigoConsultora = model.CodigoConsultora;
                campaniaID = userData.CampaniaID;
                regionID = userData.RegionID;
                zonaID = userData.ZonaID;
                
                if (model.Email != string.Empty)
                {
                    int cantidad = 0;
                    using (UsuarioServiceClient svr = new UsuarioServiceClient())
                    {
                        cantidad = svr.ValidarEmailConsultora(userData.PaisID, model.Email, userData.CodigoUsuario);

                        if (cantidad > 0)
                        {
                            return Json(new
                            {
                                success = false,
                                message = "La dirección de correo electrónico ingresada ya pertenece a otra Consultora.",
                                extra = ""
                            });
                        }
                    }
                }

                using (UsuarioServiceClient sv = new UsuarioServiceClient())
                {


                    result = sv.UpdateDatosPrimeraVezMexico(userData.PaisID, userData.CodigoUsuario, sNombre, sApellidos, sTelefono, sCelular, sEmail, sConsultorioID, sCodigoConsultora, campaniaID, campaniaUltimo, regionID, zonaID, sEmailAnterior);

                    if (result == 0)
                    {
                        return Json(new
                        {
                            success = false,
                            message = "Error al actualizar datos, intentelo mas tarde",
                            extra = ""
                        });
                    }
                    else
                    {
                        string message = string.Empty;

                        message = "Gracias por actualizar tus datos.</br> Junto con tu próximo pedido recibirás un </br> regalo sorpresa";
                        userData.NombreConsultora = sNombre + ' ' + sApellidos;
                        userData.EMail = sEmail;
                        userData.Telefono = sTelefono;
                        userData.Celular = sCelular;

                        return Json(new
                        {
                            success = true,
                            message = message,
                            extra = ""
                        });
                    }
                }
            }
            catch (FaultException ex)
            {
                LogManager.LogManager.LogErrorWebServicesPortal(ex, userData.CodigoConsultora, userData.CodigoISO);
                return Json(new
                {
                    success = false,
                    message = ex.Message,
                    extra = ""
                });
            }
            catch (Exception ex)
            {
                LogManager.LogManager.LogErrorWebServicesBus(ex, userData.CodigoConsultora, userData.CodigoISO);
                return Json(new
                {
                    success = false,
                    message = ex.Message,
                    extra = ""
                });
            }
        }
        //R2116 FIN
    }
}
