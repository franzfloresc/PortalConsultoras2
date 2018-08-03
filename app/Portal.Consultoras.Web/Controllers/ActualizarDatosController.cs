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
            var model = new ActualizarDatosModel();

            try
            {
                BEUsuario beusuario;
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
                string sEmail = "", sTelefono = "", sTelefonoTrabajo = "", sCelular = "";
                if (model.ActualizarClave == null) model.ActualizarClave = "";
                if (model.ConfirmarClave == null) model.ConfirmarClave = "";
                if (model.Email != null) sEmail = model.Email;
                if (model.Telefono != null) sTelefono = model.Telefono;
                if (model.TelefonoTrabajo != null) sTelefonoTrabajo = model.TelefonoTrabajo;
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
                    var result = sv.UpdateDatosPrimeraVez(userData.PaisID, userData.CodigoUsuario, model.Email, model.Telefono, model.TelefonoTrabajo, model.Celular, model.CorreoAnterior, model.AceptoContrato);

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
                        string message;
                        if (model.ActualizarClave != "")
                        {
                            var cambio = sv.CambiarClaveUsuario(userData.PaisID, userData.CodigoISO, userData.CodigoUsuario, model.ConfirmarClave.ToUpper(), "", userData.CodigoUsuario, EAplicacionOrigen.BienvenidaConsultora);

                            message = cambio
                                ? "Los datos han sido actualizados correctamente."
                                : "Los datos han sido actualizados correctamente.-La contraseña no ha sido modificada, intentelo mas tarde.";
                        }
                        else
                        {
                            message = "Los datos han sido actualizados correctamente.";
                        }

                        if (!string.IsNullOrEmpty(model.Email))
                        {
                            try
                            {
                                var paramQuerystring = Util.EncriptarQueryString(new string[] { userData.CodigoUsuario, userData.PaisID.ToString(), userData.CodigoISO, model.Email });

                                bool tipopais = _configuracionManagerProvider.GetPaisesEsikaFromConfig().Contains(userData.CodigoISO);

                                var nomconsultora = String.IsNullOrEmpty(userData.Sobrenombre)
                                    ? userData.PrimerNombre
                                    : userData.Sobrenombre;

                                var cadena = MailUtilities.CuerpoMensajePersonalizado(Util.GetUrlHost(this.HttpContext.Request).ToString(), nomconsultora, paramQuerystring, tipopais);

                                Util.EnviarMail("no-responder@somosbelcorp.com", model.Email, "Confirmación de Correo", cadena, true, userData.NombreConsultora);
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
                        userData.TelefonoTrabajo = sTelefonoTrabajo;
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

        [HttpPost]
        public JsonResult RechazarInvitacionFlexipago()
        {
            try
            {
                int result;
                using (UsuarioServiceClient sv = new UsuarioServiceClient())
                {
                    result = sv.UpdUsuarioRechazarInvitacion(userData.PaisID, userData.CodigoUsuario);
                }
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

        [HttpPost]
        public JsonResult Cancelar(ConsultoraFicticiaModel model = null)
        {
            try
            {
                int result;

                using (UsuarioServiceClient sv = new UsuarioServiceClient())
                {
                    result = sv.UpdUsuarioDatosPrimeraVezEstado(userData.PaisID, userData.CodigoUsuario);
                }

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

        public JsonResult RegistrarMexico(ConsultoraFicticiaModel model)
        {
            try
            {
                var sEmail = "";
                var sTelefono = "";
                var sTelefonoTrabajo = "";
                var sCelular = "";
                var sNombre = "";
                var sApellidos = "";
                var sCodigoConsultora = "";
                var sEmailAnterior = "";
                int campaniaUltimo = 0;
                int result;

                if (model.m_Nombre != null) sNombre = model.m_Nombre;
                if (model.m_Apellidos != null) sApellidos = model.m_Apellidos;
                if (model.Email != null) sEmail = model.Email;
                if (model.Telefono != null) sTelefono = model.Telefono;
                if (model.TelefonoTrabajo != null) sTelefonoTrabajo = model.TelefonoTrabajo;
                if (model.Celular != null) sCelular = model.Celular;
                if (model.CodigoConsultora != null) sCodigoConsultora = model.CodigoConsultora;

                var sConsultorioId = model.ConsultoraID;
                var campaniaId = userData.CampaniaID;
                var regionId = userData.RegionID;
                var zonaId = userData.ZonaID;

                if (model.Email != "")
                {
                    int cantidad;
                    using (UsuarioServiceClient svr = new UsuarioServiceClient())
                    {
                        cantidad = svr.ValidarEmailConsultora(userData.PaisID, model.Email, userData.CodigoUsuario);
                    }

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

                using (UsuarioServiceClient sv = new UsuarioServiceClient())
                {
                    result = sv.UpdateDatosPrimeraVezMexico(userData.PaisID, userData.CodigoUsuario, sNombre, sApellidos, sTelefono, sTelefonoTrabajo, sCelular, sEmail, sConsultorioId, sCodigoConsultora, campaniaId, campaniaUltimo, regionId, zonaId, sEmailAnterior);
                }

                if (result == 0)
                {
                    return Json(new
                    {
                        success = false,
                        message = "Error al actualizar datos, intentelo mas tarde",
                        extra = ""
                    });
                }

                var message = "Gracias por actualizar tus datos.</br> Junto con tu próximo pedido recibirás un </br> regalo sorpresa";
                userData.NombreConsultora = sNombre + ' ' + sApellidos;
                userData.EMail = sEmail;
                userData.Telefono = sTelefono;
                userData.TelefonoTrabajo = sTelefonoTrabajo;
                userData.Celular = sCelular;

                return Json(new
                {
                    success = true,
                    message = message,
                    extra = ""
                });
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

    }
}