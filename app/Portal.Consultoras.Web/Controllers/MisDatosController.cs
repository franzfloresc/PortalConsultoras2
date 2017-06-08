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

                string PaisesDigitoControl = ConfigurationManager.AppSettings["PaisesDigitoControl"].ToString();
                model.DigitoVerificador = string.Empty;
                if (PaisesDigitoControl.Contains(model.PaisISO))
                {
                    model.DigitoVerificador = beusuario.DigitoVerificador.ToString();
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
                    //rslt = sv.ValidateUserCredentialsActiveDirectory(UserData().PaisID, UserData().CodigoUsuario, UserData().CodigoISO + UserData().CodigoUsuario, OldPassword.ToUpper(), NewPassword.ToUpper());
                    int resultExiste;
                    bool result;

                    resultExiste = sv.ExisteUsuario(userData.PaisID, userData.CodigoUsuario, OldPassword);

                    if (resultExiste == Constantes.ValidacionExisteUsuario.Existe)
                    {
                        result = sv.CambiarClaveUsuario(userData.PaisID, userData.CodigoISO, userData.CodigoUsuario,
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

                entidad.CodigoUsuario = (entidad.CodigoUsuario == null) ? "" : UserData().CodigoUsuario;
                entidad.EMail = (entidad.EMail == null) ? "" : entidad.EMail;
                entidad.Telefono = (entidad.Telefono == null) ? "" : entidad.Telefono;
                entidad.TelefonoTrabajo = (entidad.TelefonoTrabajo == null) ? "" : entidad.TelefonoTrabajo;
                entidad.Celular = (entidad.Celular == null) ? "" : entidad.Celular;
                entidad.Sobrenombre = (entidad.Sobrenombre == null) ? "" : entidad.Sobrenombre;
                entidad.ZonaID = UserData().ZonaID;           
                entidad.RegionID = UserData().RegionID;       
                entidad.ConsultoraID = UserData().ConsultoraID;
                entidad.PaisID = UserData().PaisID;
                entidad.PrimerNombre = userData.PrimerNombre;
                entidad.CodigoISO = UserData().CodigoISO;

                using (UsuarioServiceClient svr = new UsuarioServiceClient())
                {
                    string resultado = svr.ActualizarMisDatos(entidad, CorreoAnterior);
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
