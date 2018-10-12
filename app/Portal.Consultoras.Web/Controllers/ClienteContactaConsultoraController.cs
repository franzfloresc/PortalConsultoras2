using Portal.Consultoras.Common;
using Portal.Consultoras.Web.Models;
using Portal.Consultoras.Web.ServiceUsuario;
using System;
using System.ServiceModel;
using System.Web;
using System.Web.Mvc;

namespace Portal.Consultoras.Web.Controllers
{
    public class ClienteContactaConsultoraController : BaseController
    {
        public ActionResult Index()
        {
            //Se ha migrado la funcionalidad a ConsultoraOnline
            return RedirectToAction("Informacion", "ConsultoraOnline");
        }

        public JsonResult AfiliarConsultora(bool esPrimera, long ConsultoraID, bool emailActivo)
        {
            string emailConsultora = userData.EMail;
            if (String.IsNullOrEmpty(emailConsultora.Trim()) || !emailActivo)
            {
                var data = new
                {
                    success = false,
                    message = "email"
                };
                return Json(data, JsonRequestBehavior.AllowGet);
            }

            if (esPrimera)
            {
                using (ServiceSAC.SACServiceClient sc = new ServiceSAC.SACServiceClient())
                {
                    sc.InsAfiliaClienteConsultora(userData.PaisID, ConsultoraID);
                }

                var data = new { success = true };
                return Json(data, JsonRequestBehavior.AllowGet);
            }
            else
            {
                using (ServiceSAC.SACServiceClient sc = new ServiceSAC.SACServiceClient())
                {
                    sc.UpdAfiliaClienteConsultora(userData.PaisID, ConsultoraID, true);
                }

                var data = new { success = true };
                return Json(data, JsonRequestBehavior.AllowGet);
            }
        }


        public JsonResult DesafiliarConsultora(long ConsultoraID)
        {
            using (ServiceSAC.SACServiceClient sc = new ServiceSAC.SACServiceClient())
            {
                sc.UpdAfiliaClienteConsultora(userData.PaisID, ConsultoraID, false);

                var data = new { success = true };
                return Json(data, JsonRequestBehavior.AllowGet);
            }
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
                if (model.Email != null) sEmail = model.Email;
                if (model.Telefono != null) sTelefono = model.Telefono;
                if (model.Celular != null) sCelular = model.Celular;

                if (model.Email != string.Empty)
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
                    var result = sv.UpdateDatosPrimeraVez(userData.PaisID, userData.CodigoUsuario, model.Email, model.Telefono, "", model.Celular, model.CorreoAnterior, model.AceptoContrato);

                    if (result == 0)
                    {
                        return Json(new
                        {
                            success = false,
                            message = "Error al actualizar datos, intentelo mas tarde",
                            extra = ""
                        });
                    }

                    string message;

                    if (model.ActualizarClave != "")
                    {
                        var cambio = sv.ChangePasswordUser(userData.PaisID, userData.CodigoUsuario, userData.CodigoISO + userData.CodigoUsuario, model.ConfirmarClave.ToUpper(), string.Empty, EAplicacionOrigen.BienvenidaConsultora);

                        message = cambio
                            ? "- Los datos han sido actualizados correctamente.\n "
                            : "- Los datos han sido actualizados correctamente.\n - La contraseña no ha sido modificada, intentelo mas tarde.\n ";
                    }
                    else
                    {
                        message = "- Los datos han sido actualizados correctamente.\n ";
                    }
                    if (!string.IsNullOrEmpty(model.Email))
                    {
                        var resultado = "1";
                        if (resultado == "1")
                        {
                            try
                            {
                                string[] parametros = new string[] { userData.CodigoUsuario, userData.PaisID.ToString(), userData.CodigoISO, model.Email };
                                string paramQuerystring = Util.EncriptarQueryString(parametros);
                                HttpRequestBase request = this.HttpContext.Request;

                                string cadena = "<br /><br /> Estimada consultora " + userData.NombreConsultora + " Para confirmar la dirección de correo electrónico ingresada haga click " +
                                                "<br /> <a href='" + Util.GetUrlHost(request) + "WebPages/MailConfirmation.aspx?data=" + paramQuerystring + "&tipo=ccc&utm_source=Marketing&utm_medium=email&utm_content=Confirmacion%20de%20correo&utm_campaign=CCC'>aquí</a><br/><br/>Belcorp";

                                Util.EnviarMail("no-responder@somosbelcorp.com", model.Email, "(" + userData.CodigoISO + ") Confimacion de Correo", cadena, true, "Somos Belcorp");
                                message += "- Se ha enviado un correo electrónico de verificación a la dirección ingresada.";
                            }
                            catch (Exception ex)
                            {
                                message += ex.Message;
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

                    SessionManager.SetUserData(userData);

                    return Json(new
                    {
                        success = true,
                        message = message,
                        extra = ""
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

    }
}
