using AutoMapper;
using Portal.Consultoras.Common;
using Portal.Consultoras.Web.Models;
using Portal.Consultoras.Web.ServiceSAC;
using Portal.Consultoras.Web.ServiceUsuario;
using Portal.Consultoras.Web.ServiceZonificacion;
using System;
using System.Linq;
using System.ServiceModel;
using System.Web.Mvc;

namespace Portal.Consultoras.Web.Controllers
{
    public class MisDatosController : BaseController
    {
        #region Actions

        public ActionResult Index()
        {
            BEUsuario beusuario;
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
                model.NombreArchivoContrato = GetConfiguracionManager(Constantes.ConfiguracionManager.Contrato_ActualizarDatos + UserData().CodigoISO);

                BEZona[] bezona;
                using (ZonificacionServiceClient sv = new ZonificacionServiceClient())
                {
                    bezona = sv.SelectZonaById(UserData().PaisID, UserData().ZonaID);
                }
                model.NombreGerenteZonal = bezona.ToList().Count == 0 ? "" : bezona[0].NombreGerenteZona;

                if (beusuario.EMailActivo) model.CorreoAlerta = "";
                if ((!beusuario.EMailActivo) && beusuario.EMail != "") model.CorreoAlerta = "Su correo aun no ha sido activado";

                if (model.UsuarioPrueba == 1)
                {
                    using (SACServiceClient sv = new SACServiceClient())
                    {
                        model.NombreConsultoraAsociada = sv.GetNombreConsultoraAsociada(UserData().PaisID, UserData().CodigoUsuario) + " (" + sv.GetCodigoConsultoraAsociada(UserData().PaisID, UserData().CodigoUsuario) + ")";
                    }
                }

                string paisesDigitoControl = GetConfiguracionManager(Constantes.ConfiguracionManager.PaisesDigitoControl);
                model.DigitoVerificador = string.Empty;
                if (paisesDigitoControl.Contains(model.PaisISO))
                {
                    model.DigitoVerificador = beusuario.DigitoVerificador;
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
                    var resultExiste = sv.ExisteUsuario(userData.PaisID, userData.CodigoUsuario, OldPassword);

                    if (resultExiste == Constantes.ValidacionExisteUsuario.Existe)
                    {
                        var result = sv.CambiarClaveUsuario(userData.PaisID, userData.CodigoISO, userData.CodigoUsuario,
                            NewPassword, "", userData.CodigoUsuario, EAplicacionOrigen.MisDatosConsultora);

                        rslt = result ? 2 : 1;
                    }
                    else
                    {
                        if (resultExiste == Constantes.ValidacionExisteUsuario.ExisteDiferenteClave)
                            rslt = 0;
                    }
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
                var entidad = Mapper.Map<MisDatosModel, BEUsuario>(model);
                var CorreoAnterior = model.CorreoAnterior;

                entidad.CodigoUsuario = (entidad.CodigoUsuario == null) ? "" : userData.CodigoUsuario;
                entidad.EMail = (entidad.EMail == null) ? "" : entidad.EMail;
                entidad.Telefono = (entidad.Telefono == null) ? "" : entidad.Telefono;
                entidad.TelefonoTrabajo = (entidad.TelefonoTrabajo == null) ? "" : entidad.TelefonoTrabajo;
                entidad.Celular = (entidad.Celular == null) ? "" : entidad.Celular;
                entidad.Sobrenombre = (entidad.Sobrenombre == null) ? "" : entidad.Sobrenombre;
                entidad.ZonaID = userData.ZonaID;
                entidad.RegionID = userData.RegionID;
                entidad.ConsultoraID = userData.ConsultoraID;
                entidad.PaisID = userData.PaisID;
                entidad.PrimerNombre = userData.PrimerNombre;
                entidad.CodigoISO = userData.CodigoISO;

                string resultado = string.Empty;
                using (UsuarioServiceClient svr = new UsuarioServiceClient())
                {
                    resultado = svr.ActualizarMisDatos(entidad, CorreoAnterior);
                }

                if (model != null)
                    ActualizarDatosLogDynamoDB(model, "MI NEGOCIO/MIS DATOS", Constantes.LogDynamoDB.AplicacionPortalConsultoras, "Modificacion");

                var lst = resultado.Split('|');

                JsonResult v_retorno = null;
                if (lst[0] == "0")
                {
                    v_retorno = Json(new
                    {
                        Cantidad = lst[3],
                        success = false,
                        message = lst[2],
                        extra = ""
                    });
                }
                else
                {
                    v_retorno = Json(new
                    {
                        Cantidad = 0,
                        success = true,
                        message = lst[2],
                        extra = ""
                    });
                }

                return v_retorno;
            }
            catch (FaultException ex)
            {
                LogManager.LogManager.LogErrorWebServicesPortal(ex, UserData().CodigoConsultora, UserData().CodigoISO);
            }
            catch (Exception ex)
            {
                LogManager.LogManager.LogErrorWebServicesBus(ex, UserData().CodigoConsultora, UserData().CodigoISO);
            }

            return Json(new
            {
                Cantidad = 0,
                success = false,
                message = "Ocurrió un error al acceder al servicio, intente nuevamente.",
                extra = ""
            });
        }

        [HttpPost]
        public JsonResult AceptarContrato(MisDatosModel model)
        {
            try
            {
                BEUsuario entidad = Mapper.Map<MisDatosModel, BEUsuario>(model);

                entidad.CodigoUsuario = (entidad.CodigoUsuario == null) ? "" : UserData().CodigoUsuario;
                entidad.ZonaID = UserData().ZonaID;
                entidad.RegionID = UserData().RegionID;
                entidad.ConsultoraID = UserData().ConsultoraID;
                entidad.PaisID = UserData().PaisID;
                entidad.PrimerNombre = userData.PrimerNombre;
                entidad.CodigoISO = UserData().CodigoISO;

                using (UsuarioServiceClient svr = new UsuarioServiceClient())
                {
                    string resultado = svr.AceptarContrato(entidad);
                    string[] lst = resultado.Split('|');

                    if (lst[0] == "0")
                    {
                        return Json(new
                        {
                            Cantidad = lst[3],
                            success = false,
                            message = lst[2],
                            extra = ""
                        });
                    }
                    else
                    {
                        return Json(new
                        {
                            Cantidad = 0,
                            success = true,
                            message = lst[2],
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
