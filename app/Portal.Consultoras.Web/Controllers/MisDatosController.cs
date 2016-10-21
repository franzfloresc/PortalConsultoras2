using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using Portal.Consultoras.Common;
using Portal.Consultoras.Web.Models;
using AutoMapper;
using Portal.Consultoras.Web.ServiceUsuario;
using Portal.Consultoras.Web.ServiceSAC;
using PE = Portal.Consultoras.Web.ServiceActualizaDatosConsultoraPeru;
using CL = Portal.Consultoras.Web.ServiceActualizaDatosConsultoraChile;
using EC = Portal.Consultoras.Web.ServiceActualizaDatosConsultoraEcuador;
using Portal.Consultoras.Web.ServiceZonificacion;
using System.Configuration;
using System.ServiceModel;

namespace Portal.Consultoras.Web.Controllers
{
    public class MisDatosController : BaseController
    {
        //
        // GET: /MisDatos/

        #region Actions

        public ActionResult Index()
        {
            BEUsuario beusuario = new BEUsuario();
            var model = new MisDatosModel();

            using (UsuarioServiceClient sv = new UsuarioServiceClient())
            {
                beusuario = sv.Select(UserData().PaisID, UserData().CodigoUsuario);
            }

            if (beusuario != null)
            {
                model.PaisISO = UserData().CodigoISO;
                model.CodigoUsuario = UserData().CodigoUsuario + " (Zona: " + UserData().CodigoZona + ")";
                model.NombreCompleto = beusuario.Nombre;
                model.EMail = beusuario.EMail;
                model.Telefono = beusuario.Telefono;
                model.Celular = beusuario.Celular;
                model.Sobrenombre = beusuario.Sobrenombre;
                model.CompartirDatos = beusuario.CompartirDatos;
                model.AceptoContrato = beusuario.AceptoContrato;
                model.UsuarioPrueba = UserData().UsuarioPrueba;
                model.NombreArchivoContrato = ConfigurationManager.AppSettings["Contrato_ActualizarDatos_" + UserData().CodigoISO].ToString();

                BEZona[] bezona;
                using (ZonificacionServiceClient sv = new ZonificacionServiceClient())
                {
                    bezona = sv.SelectZonaById(UserData().PaisID, UserData().ZonaID);
                }
                if (bezona.ToList().Count == 0) model.NombreGerenteZonal = "";
                else model.NombreGerenteZonal = bezona[0].NombreGerenteZona;

                if (beusuario.EMailActivo) model.CorreoAlerta = "";
                if ((!beusuario.EMailActivo) && beusuario.EMail != "") model.CorreoAlerta = "Su correo aun no ha sido activado";

                if (model.UsuarioPrueba == 1)
                {
                    using (SACServiceClient sv = new SACServiceClient())
                    {
                        model.NombreConsultoraAsociada = sv.GetNombreConsultoraAsociada(UserData().PaisID, UserData().CodigoUsuario) + " (" + sv.GetCodigoConsultoraAsociada(UserData().PaisID, UserData().CodigoUsuario) + ")";
                    }
                }
            }

            return View(model);
        }

        [HttpPost]
        public JsonResult CambiarContrasenia(string OldPassword, string NewPassword)
        {
            int rslt = 0;
            try
            {
                using (UsuarioServiceClient sv = new UsuarioServiceClient())
                {
                    rslt = sv.ValidateUserCredentialsActiveDirectory(UserData().PaisID, UserData().CodigoUsuario, UserData().CodigoISO + UserData().CodigoUsuario, OldPassword.ToUpper(), NewPassword.ToUpper());
                }

                return Json(new
                {
                    success = true,
                    message = rslt
                });
            }
            catch (FaultException ex)
            {
                LogManager.LogManager.LogErrorWebServicesPortal(ex, UserData().CodigoConsultora, UserData().CodigoISO);
                return Json(new
                {
                    success = false,
                    message = "Ocurrió un erro al Cambiar la Contraseña, Intente nuevamente.",
                    extra = ""
                });
            }
            catch (Exception ex)
            {
                LogManager.LogManager.LogErrorWebServicesBus(ex, UserData().CodigoConsultora, UserData().CodigoISO);
                return Json(new
                {
                    success = false,
                    message = "Ocurrió un erro al Cambiar la Contraseña, Intente nuevamente.",
                    extra = ""
                });
            }
        }

        [HttpPost]
        public JsonResult ActualizarDatos(MisDatosModel model)
        {
            try
            {
                Mapper.CreateMap<MisDatosModel, BEUsuario>()
                    .ForMember(t => t.CodigoUsuario, f => f.MapFrom(c => c.CodigoUsuario))
                    .ForMember(t => t.EMail, f => f.MapFrom(c => c.EMail))
                    .ForMember(t => t.Telefono, f => f.MapFrom(c => c.Telefono))
                    .ForMember(t => t.TelefonoTrabajo, f => f.MapFrom(c => c.TelefonoTrabajo))
                    .ForMember(t => t.Celular, f => f.MapFrom(c => c.Celular))
                    .ForMember(t => t.Sobrenombre, f => f.MapFrom(c => c.Sobrenombre))
                    .ForMember(t => t.Nombre, f => f.MapFrom(c => c.NombreCompleto))
                    .ForMember(t => t.CompartirDatos, f => f.MapFrom(c => c.CompartirDatos))
                    .ForMember(t => t.AceptoContrato, f => f.MapFrom(c => c.AceptoContrato));

                BEUsuario entidad = Mapper.Map<MisDatosModel, BEUsuario>(model);
                string CorreoAnterior = model.CorreoAnterior;
                string cadena = "";
                string resultado = "";

                entidad.CodigoUsuario = (entidad.CodigoUsuario == null) ? "" : UserData().CodigoUsuario;
                entidad.EMail = (entidad.EMail == null) ? "" : entidad.EMail;
                entidad.Telefono = (entidad.Telefono == null) ? "" : entidad.Telefono;
                entidad.TelefonoTrabajo = (entidad.TelefonoTrabajo == null) ? "" : entidad.TelefonoTrabajo;
                entidad.Celular = (entidad.Celular == null) ? "" : entidad.Celular;
                entidad.Sobrenombre = (entidad.Sobrenombre == null) ? "" : entidad.Sobrenombre;
                entidad.ZonaID = UserData().ZonaID;             /*20150907*/
                entidad.RegionID = UserData().RegionID;         /*20150907*/
                entidad.ConsultoraID = UserData().ConsultoraID; /*20150907*/

                if (entidad.EMail != string.Empty)
                {
                    int cantidad = 0;
                    using (UsuarioServiceClient svr = new UsuarioServiceClient())
                    {
                        cantidad = svr.ValidarEmailConsultora(userData.PaisID, entidad.EMail, userData.CodigoUsuario);

                        if (cantidad > 0)
                        {
                            return Json(new
                            {
                                Cantidad = cantidad,
                                success = false,
                                message = "La dirección de correo electrónico ingresada ya pertenece a otra Consultora.",
                                extra = ""
                            });
                        }
                    }
                }

                //try
                //{
                //    using (UsuarioServiceClient svr = new UsuarioServiceClient())
                //    {
                //        resultado = Convert.ToString(svr.UpdActualizarDatos(UserData().PaisID, UserData().CodigoConsultora, entidad.EMail, entidad.Celular, entidad.Telefono));
                //    }
                //}
                //catch (Exception ex)
                //{
                //    LogManager.LogManager.LogErrorWebServicesBus(ex, UserData().CodigoConsultora, UserData().CodigoISO);
                //    resultado = "0";
                //}
                resultado = "1";

                if (resultado == "1")
                {
                    using (UsuarioServiceClient sv = new UsuarioServiceClient())
                    {
                        entidad.PaisID = UserData().PaisID;
                        sv.UpdateDatos(entidad, CorreoAnterior);
                    }

                    UsuarioModel UsuarioModelSession = userData;
                    UsuarioModelSession.Celular = entidad.Celular;
                    UsuarioModelSession.Telefono = entidad.Telefono;
                    UsuarioModelSession.TelefonoTrabajo = entidad.TelefonoTrabajo;
                    if (!string.IsNullOrEmpty(entidad.Sobrenombre)) UsuarioModelSession.Sobrenombre = entidad.Sobrenombre.ToUpper();
                    else UsuarioModelSession.Sobrenombre = UsuarioModelSession.SobrenombreOriginal;
                    SetUserData(UsuarioModelSession);

                    /*R20150907*/
                    string[] parametros = new string[] { entidad.CodigoUsuario, entidad.PaisID.ToString(), userData.CodigoISO, entidad.EMail };
                    string param_querystring = Util.EncriptarQueryString(parametros);
                    //Mejora - Correo
                    //string nomPais = Util.ObtenerNombrePaisPorISO(UserData().CodigoISO);
                    HttpRequestBase request = this.HttpContext.Request;

                    if (model.CorreoAnterior == null) model.CorreoAnterior = "";

                    if (entidad.EMail.Trim() != model.CorreoAnterior.Trim())
                    {

                        UsuarioModelSession.EMail = entidad.EMail;
                        SetUserData(UsuarioModelSession);

                        cadena = cadena + "<br /><br /> Estimada consultora " + entidad.Nombre + " Para confirmar la dirección de correo electrónico ingresada haga click " +
                                      "<br /> <a href='" + Util.GetUrlHost(request) + "WebPages/MailConfirmation.aspx?data=" + param_querystring + "'>aquí</a><br/><br/>Belcorp";//2442
                        Util.EnviarMailMasivoColas("no-responder@somosbelcorp.com", entidad.EMail, "(" + userData.CodigoISO + ") Confimacion de Correo", cadena, true, entidad.Nombre);
                        //Util.EnviarMail("no-responder@somosbelcorp.com", entidad.EMail, "(" + userData.CodigoISO + ") Confimacion de Correo", cadena, true, entidad.Nombre);

                        return Json(new
                        {
                            Cantidad = 0,
                            success = true,
                            message = "- Sus datos se actualizaron correctamente.\n - Se ha enviado un correo electrónico de verificación a la dirección ingresada.",
                            extra = ""
                        });
                    }
                    else
                    {
                        return Json(new
                        {
                            Cantidad = 0,
                            success = true,
                            message = "- Sus datos se actualizaron correctamente.",
                            extra = ""
                        });
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
            catch (FaultException ex)
            {
                LogManager.LogManager.LogErrorWebServicesPortal(ex, UserData().CodigoConsultora, UserData().CodigoISO);
                return Json(new
                {
                    Cantidad = 0,
                    success = false,
                    message = "Ocurrió un error al acceder al servicio, intente nuevamente.",
                    extra = ""
                });
            }
            catch (Exception ex)
            {
                LogManager.LogManager.LogErrorWebServicesBus(ex, UserData().CodigoConsultora, UserData().CodigoISO);
                return Json(new
                {
                    Cantidad = 0,
                    success = false,
                    message = "Ocurrió un error al acceder al servicio, intente nuevamente.",
                    extra = ""
                });
            }
        }

        #endregion

    }
}
