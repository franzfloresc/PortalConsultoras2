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

namespace Portal.Consultoras.Web.Areas.Mobile.Controllers
{
    public class MisDatosController : BaseMobileController
    {
        public ActionResult Index(bool vc = false, string opcionCambiaClave = "")
        {
            ViewBag.DatosIniciales = new BienvenidaHomeModel();

            var model = new MisDatosModel();

            model.VerCambiarClave = opcionCambiaClave;

            int limiteMinimoTelef, limiteMaximoTelef;
            Util.GetLimitNumberPhone(userData.PaisID, out limiteMinimoTelef, out limiteMaximoTelef);
            ViewBag.limiteMinimoTelef = limiteMinimoTelef;
            ViewBag.limiteMaximoTelef = limiteMaximoTelef;

            BEUsuario beusuario;
            using (UsuarioServiceClient sv = new UsuarioServiceClient())
            {
                beusuario = sv.Select(userData.PaisID, userData.CodigoUsuario);
            }

            if (beusuario != null)
            {
                model.PaisISO = userData.CodigoISO;
                ViewBag.PaisId = userData.PaisID;
                model.NombreCompleto = beusuario.Nombre;
                model.NombreGerenteZonal = userData.NombreGerenteZonal;
                model.EMail = beusuario.EMail;
                model.NombreGerenteZonal = userData.NombreGerenteZonal;
                model.Telefono = beusuario.Telefono;
                model.TelefonoTrabajo = beusuario.TelefonoTrabajo;
                model.Celular = beusuario.Celular;
                model.Sobrenombre = beusuario.Sobrenombre;
                model.CompartirDatos = beusuario.CompartirDatos;
                model.AceptoContrato = beusuario.AceptoContrato;
                model.UsuarioPrueba = userData.UsuarioPrueba;
                model.CodigoUsuarioReal = userData.CodigoUsuario;
                model.NombreArchivoContrato = _configuracionManagerProvider.GetConfiguracionManager(Constantes.ConfiguracionManager.Contrato_ActualizarDatos + userData.CodigoISO);
                model.IndicadorConsultoraDigital = beusuario.IndicadorConsultoraDigital;

                BEZona[] bezona;
                using (ZonificacionServiceClient sv = new ZonificacionServiceClient())
                {
                    bezona = sv.SelectZonaById(userData.PaisID, userData.ZonaID);
                }
                model.NombreGerenteZonal = bezona.ToList().Count == 0 ? "" : bezona[0].NombreGerenteZona;

                if (beusuario.EMailActivo) model.CorreoAlerta = "";
                if (!beusuario.EMailActivo && beusuario.EMail != "") model.CorreoAlerta = "Su correo aun no ha sido activado";

                if (model.UsuarioPrueba == 1)
                {
                    using (SACServiceClient sv = new SACServiceClient())
                    {
                        model.NombreConsultoraAsociada = sv.GetNombreConsultoraAsociada(userData.PaisID, userData.CodigoUsuario) + " (" + sv.GetCodigoConsultoraAsociada(userData.PaisID, userData.CodigoUsuario) + ")";
                    }
                }
                model.CodigoUsuario = userData.CodigoUsuario + " (Zona: " + userData.CodigoZona + ")";
                string paisesDigitoControl = _configuracionManagerProvider.GetConfiguracionManager(Constantes.ConfiguracionManager.PaisesDigitoControl);
                model.DigitoVerificador = string.Empty;

                if (paisesDigitoControl.Contains(model.PaisISO) && !String.IsNullOrEmpty(beusuario.DigitoVerificador))
                {
                    model.CodigoUsuario = string.Format("{0} - {1} (Zona:{2})", userData.CodigoUsuario, beusuario.DigitoVerificador, userData.CodigoZona);
                }
            }

            ViewBag.VC_Datos = vc;
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
                LogManager.LogManager.LogErrorWebServicesPortal(ex, userData.CodigoConsultora, userData.CodigoISO);
                return Json(new
                {
                    success = false,
                    message = "Ocurrió un erro al Cambiar la Contraseña, Intente nuevamente.",
                    extra = ""
                });
            }
            catch (Exception ex)
            {
                LogManager.LogManager.LogErrorWebServicesBus(ex, userData.CodigoConsultora, userData.CodigoISO);
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
            JsonResult v_retorno = null;
            
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

                ActualizarDatosLogDynamoDB(model, "MI NEGOCIO|MIS DATOS", Constantes.LogDynamoDB.AplicacionPortalConsultoras, "Modificacion");

                var lst = resultado.Split('|');

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
                LogManager.LogManager.LogErrorWebServicesPortal(ex, userData.CodigoConsultora, userData.CodigoISO);

            }
            catch (Exception ex)
            {
                LogManager.LogManager.LogErrorWebServicesBus(ex, userData.CodigoConsultora, userData.CodigoISO);
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

                entidad.CodigoUsuario = (entidad.CodigoUsuario == null) ? "" : userData.CodigoUsuario;
                entidad.ZonaID = userData.ZonaID;
                entidad.RegionID = userData.RegionID;
                entidad.ConsultoraID = userData.ConsultoraID;
                entidad.PaisID = userData.PaisID;
                entidad.PrimerNombre = userData.PrimerNombre;
                entidad.CodigoISO = userData.CodigoISO;

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
                LogManager.LogManager.LogErrorWebServicesPortal(ex, userData.CodigoConsultora, userData.CodigoISO);
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
                LogManager.LogManager.LogErrorWebServicesBus(ex, userData.CodigoConsultora, userData.CodigoISO);
                return Json(new
                {
                    Cantidad = 0,
                    success = false,
                    message = "Ocurrió un error al acceder al servicio, intente nuevamente.",
                    extra = ""
                });
            }
        }

        public JsonResult ValidadTelefonoConsultora(string Telefono)
        {
            try
            {
                using (UsuarioServiceClient svr = new UsuarioServiceClient())
                {
                    var cantidad = svr.ValidarTelefonoConsultora(userData.PaisID, Telefono, userData.CodigoUsuario);
                    if (cantidad > 0)
                    {
                        return Json(new
                        {
                            success = false,
                            message = "",
                            extra = ""
                        }, JsonRequestBehavior.AllowGet);
                    }
                }

                return Json(new
                {
                    success = true,
                    message = "OK",
                    extra = ""
                }, JsonRequestBehavior.AllowGet);
            }
            catch (Exception ex)
            {
                LogManager.LogManager.LogErrorWebServicesBus(ex, userData.CodigoConsultora, userData.CodigoISO);
                return Json(new
                {
                    success = false,
                    message = "Error al intentar validar el celular.",
                    extra = ""
                }, JsonRequestBehavior.AllowGet);
            }
        }

    }
}
