﻿using Portal.Consultoras.Common;
using Portal.Consultoras.Web.Models;
using Portal.Consultoras.Web.ServiceUsuario;
using System;
using System.Configuration;
using System.ServiceModel;
using System.Web;
using System.Web.Mvc;

namespace Portal.Consultoras.Web.Controllers
{
    public class ClienteContactaConsultoraController : BaseController
    {
        public ActionResult Index()
        {
            return RedirectToAction("Informacion", "ConsultoraOnline");

            string strpaises = ConfigurationManager.AppSettings.Get("Permisos_CCC");
            if (strpaises.Contains(UserData().CodigoISO))
            { }
            else
                return RedirectToAction("Index", "Bienvenida");

            var consultoraAfiliar = new ClienteContactaConsultoraModel();
            consultoraAfiliar.NombreConsultora = UserData().PrimerNombre;

            string emailConsultora = UserData().EMail;

            using (ServiceSAC.SACServiceClient sc = new ServiceSAC.SACServiceClient())
            {
                ServiceSAC.BEAfiliaClienteConsultora beAfiliaCliente = sc.GetAfiliaClienteConsultoraByConsultora(UserData().PaisID, UserData().CodigoConsultora);

                consultoraAfiliar.Afiliado = beAfiliaCliente.EsAfiliado > 0;

                consultoraAfiliar.EsPrimeraVez = beAfiliaCliente.EsAfiliado < 0;

                consultoraAfiliar.ConsultoraID = beAfiliaCliente.ConsultoraID;

                consultoraAfiliar.EmailActivo = beAfiliaCliente.EmailActivo;

                consultoraAfiliar.NombreCompleto = beAfiliaCliente.NombreCompleto;

                consultoraAfiliar.Email = beAfiliaCliente.Email;

                consultoraAfiliar.Celular = beAfiliaCliente.Celular;

                consultoraAfiliar.Telefono = beAfiliaCliente.Telefono;
            }


            return View(consultoraAfiliar);
        }

        public JsonResult AfiliarConsultora(bool esPrimera, long ConsultoraID, bool emailActivo)
        {

            string emailConsultora = UserData().EMail;
            if (String.IsNullOrEmpty(emailConsultora.Trim()) || emailActivo == false)
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
                    sc.InsAfiliaClienteConsultora(UserData().PaisID, ConsultoraID);
                }

                var data = new
                {
                    success = true

                };
                return Json(data, JsonRequestBehavior.AllowGet);
            }
            else
            {
                using (ServiceSAC.SACServiceClient sc = new ServiceSAC.SACServiceClient())
                {
                    sc.UpdAfiliaClienteConsultora(UserData().PaisID, ConsultoraID, true);
                }

                var data = new
                {
                    success = true

                };
                return Json(data, JsonRequestBehavior.AllowGet);
            }

        }


        public JsonResult DesafiliarConsultora(long ConsultoraID)
        {
            using (ServiceSAC.SACServiceClient sc = new ServiceSAC.SACServiceClient())
            {
                sc.UpdAfiliaClienteConsultora(UserData().PaisID, ConsultoraID, false);

                var data = new
                {
                    success = true
                };
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
                        cantidad = svr.ValidarEmailConsultora(UserData().PaisID, model.Email, UserData().CodigoUsuario);

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

                    result = sv.UpdateDatosPrimeraVez(UserData().PaisID, UserData().CodigoUsuario, model.Email, model.Telefono, "", model.Celular, model.CorreoAnterior, model.AceptoContrato);

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
                            cambio = sv.ChangePasswordUser(UserData().PaisID, UserData().CodigoUsuario, UserData().CodigoISO + UserData().CodigoUsuario, model.ConfirmarClave.ToUpper(), string.Empty, EAplicacionOrigen.BienvenidaConsultora);

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
                            resultado = "1";
                            if (resultado == "1")
                            {
                                try
                                {
                                    string[] parametros = new string[] { UserData().CodigoUsuario, UserData().PaisID.ToString(), UserData().CodigoISO, model.Email };
                                    string param_querystring = Util.EncriptarQueryString(parametros);
                                    HttpRequestBase request = this.HttpContext.Request;

                                    string cadena = "<br /><br /> Estimada consultora " + UserData().NombreConsultora + " Para confirmar la dirección de correo electrónico ingresada haga click " +
                                                      "<br /> <a href='" + Util.GetUrlHost(request) + "WebPages/MailConfirmation.aspx?data=" + param_querystring + "&tipo=ccc&utm_source=Marketing&utm_medium=email&utm_content=Confirmacion%20de%20correo&utm_campaign=CCC'>aquí</a><br/><br/>Belcorp";

                                    Util.EnviarMail("no-responder@somosbelcorp.com", model.Email, "(" + UserData().CodigoISO + ") Confimacion de Correo", cadena, true, "Somos Belcorp");
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
                        UserData().CambioClave = 1;
                        UserData().EMail = sEmail;
                        UserData().Telefono = sTelefono;
                        UserData().Celular = sCelular;

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
                LogManager.LogManager.LogErrorWebServicesPortal(ex, UserData().CodigoConsultora, UserData().CodigoISO);
                return Json(new
                {
                    success = false,
                    message = ex.Message,
                    extra = ""
                });
            }
            catch (Exception ex)
            {
                LogManager.LogManager.LogErrorWebServicesBus(ex, UserData().CodigoConsultora, UserData().CodigoISO);
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
