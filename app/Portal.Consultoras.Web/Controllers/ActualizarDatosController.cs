using Portal.Consultoras.Common;
using Portal.Consultoras.Web.Models;
using Portal.Consultoras.Web.ServiceUsuario;
using System;
using System.ServiceModel;
using System.Web.Mvc;

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
                var sEmail = "";
                var sTelefono = "";
                var sCelular = "";

                if (model.ActualizarClave == null) model.ActualizarClave = "";
                if (model.ConfirmarClave == null) model.ConfirmarClave = "";
                if (model.Email != null) sEmail = model.Email;
                if (model.Telefono != null) sTelefono = model.Telefono;
                if (model.Celular != null) sCelular = model.Celular;

                if (model.Email != "")
                {
                    using (UsuarioServiceClient svr = new UsuarioServiceClient())
                    {
                        var cantidad = svr.ValidarEmailConsultora(userData.PaisID, model.Email, userData.CodigoUsuario);
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
                    var result = sv.UpdateDatosPrimeraVez(userData.PaisID, userData.CodigoUsuario, model.Email, model.Telefono, model.Celular, model.CorreoAnterior, model.AceptoContrato);

                    if (result == 0)
                    {
                        return Json(new
                        {
                            success = false,
                            message = "Error al actualizar datos, intentelo mas tarde.",
                            extra = ""
                        });
                    }
                    else
                    {
                        var message = "";
                        if (model.ActualizarClave != "")
                        {
                            var cambio = sv.ChangePasswordUser(userData.PaisID, userData.CodigoUsuario, userData.CodigoISO + userData.CodigoUsuario, model.ConfirmarClave.ToUpper(), "", EAplicacionOrigen.BienvenidaConsultora);

                            if (cambio)
                            {
                                message = "Los datos han sido actualizados correctamente.";
                            }
                            else
                            {
                                message = "Los datos han sido actualizados correctamente.-La contraseña no ha sido modificada, intentelo mas tarde.";
                            }
                        }
                        else
                        {
                            message = "Los datos han sido actualizados correctamente.";
                        }

                        if (!string.IsNullOrEmpty(model.Email))
                        {
                            try
                            {
                                var param_querystring = Util.EncriptarQueryString(new string[] { userData.CodigoUsuario, userData.PaisID.ToString(), userData.CodigoISO, model.Email });

                                var cadena = "<br /><br /> Estimada consultora " + userData.NombreConsultora + " Para confirmar la dirección de correo electrónico ingresada haga click " +
                                                  "<br /> <a href='" + Util.GetUrlHost(this.HttpContext.Request) + "WebPages/MailConfirmation.aspx?data=" + param_querystring + "'>aquí</a><br/><br/>Belcorp";

                                Util.EnviarMail("no-responder@somosbelcorp.com", model.Email, "(" + userData.CodigoISO + ") Confimacion de Correo", cadena, true, userData.NombreConsultora);
                                message += "-Se ha enviado un correo electrónico de verificación a la dirección ingresada.";
                            }
                            catch (Exception ex)
                            {
                                LogManager.LogManager.LogErrorWebServicesBus(ex, userData.CodigoConsultora, userData.CodigoISO);
                                message += "-Hubo un problema al tratar de enviar el correo electronico de verificacion.";
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
                var sEmail = "";
                var sTelefono = "";
                var sCelular = "";
                var sNombre = "";
                var sApellidos = "";
                long sConsultorioID = 0;
                var sCodigoConsultora = "";
                var sEmailAnterior = "";
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
                if (model.CodigoConsultora != null) sCodigoConsultora = model.CodigoConsultora;

                sConsultorioID = model.ConsultoraID;
                campaniaID = userData.CampaniaID;
                regionID = userData.RegionID;
                zonaID = userData.ZonaID;

                if (model.Email != "")
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
                        var message = "";

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