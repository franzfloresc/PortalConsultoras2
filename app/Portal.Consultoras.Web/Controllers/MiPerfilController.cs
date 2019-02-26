﻿using Portal.Consultoras.Common;
using Portal.Consultoras.Web.Models;
using Portal.Consultoras.Web.ServiceSAC;
using Portal.Consultoras.Web.ServiceUsuario;
using Portal.Consultoras.Web.ServiceZonificacion;
using System;
using System.Linq;
using System.Web;
using System.Threading.Tasks;
using System.Web.Mvc;
using System.IO;
using Portal.Consultoras.Common.Validator;
using Portal.Consultoras.Web.Infraestructure.Validator.Phone;
using AutoMapper;
using System.ServiceModel;
using Portal.Consultoras.Web.Infraestructure.Sms;
using Portal.Consultoras.Web.Providers;

namespace Portal.Consultoras.Web.Controllers
{
    public class MiPerfilController : BaseController
    {
        private readonly ZonificacionProvider _zonificacionProvider;

        public MiPerfilController()
        {
            _zonificacionProvider = new ZonificacionProvider();
        }

        public ActionResult Index()
        {
            BEUsuario beusuario;
            var model = new MisDatosModel();

            using (var sv = new UsuarioServiceClient())
            {
                beusuario = sv.Select(userData.PaisID, userData.CodigoUsuario);
            }

            if (beusuario == null)
            {
                return View(model);
            }

            model.PaisISO = userData.CodigoISO;

            model.NombreCompleto = beusuario.Nombre;
            model.NombreGerenteZonal = userData.NombreGerenteZonal;
            model.EMail = beusuario.EMail;
            if (!userData.EMail.Contains(string.IsNullOrEmpty(model.EMail) ? "" : model.EMail)) userData.EMail = model.EMail;
            model.NombreGerenteZonal = userData.NombreGerenteZonal;
            model.Telefono = beusuario.Telefono;
            model.TelefonoTrabajo = beusuario.TelefonoTrabajo;
            model.Celular = beusuario.Celular;
            if (!userData.Celular.Contains(string.IsNullOrEmpty(model.Celular) ? "" : model.Celular)) userData.Celular = model.Celular;
            model.Sobrenombre = beusuario.Sobrenombre;
            model.CompartirDatos = beusuario.CompartirDatos;
            model.AceptoContrato = beusuario.AceptoContrato;
            model.UsuarioPrueba = userData.UsuarioPrueba;
            model.NombreArchivoContrato = _configuracionManagerProvider.GetConfiguracionManager(Constantes.ConfiguracionManager.Contrato_ActualizarDatos + userData.CodigoISO);
            model.IndicadorConsultoraDigital = beusuario.IndicadorConsultoraDigital;

            var bezona = _zonificacionProvider.GetZonaById(userData.PaisID, userData.ZonaID);

            model.NombreGerenteZonal = bezona.NombreGerenteZona;

            if (beusuario.EMailActivo) model.CorreoAlerta = "";
            if (!beusuario.EMailActivo && beusuario.EMail != "") model.CorreoAlerta = "Su correo aun no ha sido activado";

            if (model.UsuarioPrueba == 1)
            {
                using (var sv = new SACServiceClient())
                {
                    model.NombreConsultoraAsociada = sv.GetNombreConsultoraAsociada(userData.PaisID, userData.CodigoUsuario) + " (" + sv.GetCodigoConsultoraAsociada(userData.PaisID, userData.CodigoUsuario) + ")";
                }
            }

           
            model.DigitoVerificador = beusuario.DigitoVerificador;
            model.CodigoUsuario = userData.CodigoUsuario;
            model.Zona = userData.CodigoZona;
            model.ServiceSMS = userData.PuedeEnviarSMS;
            model.ActualizaDatos = userData.PuedeActualizar;
            model.PaisID = userData.PaisID;

            var paisesDigitoControl = _configuracionManagerProvider.GetConfiguracionManager(Constantes.ConfiguracionManager.PaisesDigitoControl);
            model.CodigoUsuarioReal = userData.CodigoUsuario;
            ViewBag.UrlPdfTerminosyCondiciones = _revistaDigitalProvider.GetUrlTerminosCondicionesDatosUsuario(userData.CodigoISO);
            ViewBag.PaisesDigitoControl = paisesDigitoControl;

            #region limite Min - Max Telef
            int limiteMinimoTelef, limiteMaximoTelef;
            Util.GetLimitNumberPhone(userData.PaisID, out limiteMinimoTelef, out limiteMaximoTelef);
            model.limiteMinimoTelef = limiteMinimoTelef;
            model.limiteMaximoTelef = limiteMaximoTelef;
            #endregion
            int numero;
            bool valida;
            Util.ObtenerIniciaNumeroCelular(userData.PaisID, out valida, out numero);
            model.IniciaNumeroCelular = valida ? numero : -1;

            
            return View(model);
        }

        public ActionResult CambiarContrasenia()
        {
            return View();
        }

        public ActionResult ActualizarCorreo()
        {
            ViewBag.CorreoActual = userData.EMail;
            ViewBag.UrlPdfTerminosyCondiciones = _revistaDigitalProvider.GetUrlTerminosCondicionesDatosUsuario(userData.CodigoISO);
            return View();
        }

        public JsonResult ActualizarEnviarCorreo(string correoNuevo)
        {
            try
            {
                BERespuestaServicio respuesta;
                BEUsuario usuario = Mapper.Map<BEUsuario>(userData);
                using (UsuarioServiceClient sv = new UsuarioServiceClient())
                {
                    respuesta = sv.ActualizarEmail(usuario, correoNuevo);
                }
                return Json(new { success = respuesta.Succcess, message = respuesta.Message });
            }
            catch (Exception ex)
            {
                LogManager.LogManager.LogErrorWebServicesBus(ex, userData.CodigoConsultora, userData.CodigoISO);
                return ErrorJson(Constantes.MensajesError.UpdCorreoConsultora);
            }
        }

        public ActionResult ConfirmacionCorreo(string data)
        {
            if (string.IsNullOrEmpty(data))
            {
                ViewBag.Mensaje = Constantes.MensajesError.ActivacionCorreo;
                return View();
            }

            string mensaje;
            try
            {
                var paramDesencriptados = Util.Decrypt(data);
                var arrayParam = paramDesencriptados.Split(';');
                var codigoUsuario = arrayParam[0];
                var paisId = Convert.ToInt32(arrayParam[1]);
                var email = arrayParam[2];

                BERespuestaActivarEmail respuesta;
                using (UsuarioServiceClient srv = new UsuarioServiceClient())
                {
                    respuesta = srv.ActivarEmail(paisId, codigoUsuario, email);
                }
                mensaje = respuesta.Succcess ? Constantes.CambioCorreoResult.Valido : respuesta.Message;

                try
                {
                    BEUsuario usuario = Mapper.Map<BEUsuario>(userData);
                    var misDatosModel = Mapper.Map<MisDatosModel>(usuario);
                    misDatosModel.EMail = email;
                    ActualizarDatosLogDynamoDB(misDatosModel, "MI NEGOCIO/MI PERFIL", Constantes.LogDynamoDB.AplicacionPortalConsultoras, "Modificacion");
                }
                catch (Exception ex) { LogManager.LogManager.LogErrorWebServicesBus(ex, userData.CodigoConsultora, userData.CodigoISO); }
            }
            catch (Exception ex)
            {
                LogManager.LogManager.LogErrorWebServicesBus(ex, userData.CodigoUsuario, userData.CodigoISO, "EncryptData=" + data);
                mensaje = Constantes.MensajesError.ActivacionCorreo;
            }

            ViewBag.Mensaje = mensaje;
            return View();
        }

        public ActionResult ActualizarCelular()
        {
            if (!userData.PuedeActualizar || !userData.PuedeEnviarSMS)
            {
                return RedirectToAction("Index");
            }

            ViewBag.Celular = userData.Celular;

            var numero = 0;
            var valida = false;
            Util.ObtenerIniciaNumeroCelular(userData.PaisID, out valida, out numero);
            ViewBag.IniciaNumeroCelular = valida ? numero : -1;
            ViewBag.UrlPdfTerminosyCondiciones = _revistaDigitalProvider.GetUrlTerminosCondicionesDatosUsuario(userData.CodigoISO);
            return View();
        }

        public ActionResult CambiarFotoPerfil()
        {
            return View();
        }

        [HttpPost]
        public ActionResult MoverFotoPerfil(string qqfile)
        {
            try
            {
                if (String.IsNullOrEmpty(Request["qqfile"]))
                {
                    HttpPostedFileBase postedFile = Request.Files[0];
                    if (postedFile == null)
                        return Json(new { success = false, message = "" }, "text/html");

                    var fileName = Path.GetFileName(postedFile.FileName) ?? "";
                    var path = Path.Combine(Globals.RutaTemporales, fileName);
                    if (!System.IO.File.Exists(Globals.RutaTemporales))
                        Directory.CreateDirectory(Globals.RutaTemporales);
                    postedFile.SaveAs(path);
                    path = Url.Content(Path.Combine(Globals.RutaTemporales, fileName));
                    return Json(new { success = true, name = Path.GetFileName(path) }, "text/html");
                }
                else
                {
                    Stream inputStream = Request.InputStream;
                    byte[] fileBytes = ReadFully(inputStream);
                    string ffFileName = qqfile;
                    var path = Path.Combine(Globals.RutaTemporales, ffFileName);
                    System.IO.File.WriteAllBytes(path, fileBytes);
                    if (!System.IO.File.Exists(Globals.RutaTemporales))
                        Directory.CreateDirectory(Globals.RutaTemporales);
                    return Json(new { success = true, name = Path.GetFileName(path) }, "text/html");
                }
            }
            catch (Exception ex)
            {
                LogManager.LogManager.LogErrorWebServicesBus(ex, "", "");
                return Json(new { success = false, message = "Hubo un error al cargar el archivo, intente nuevamente." }, "text/html");
            }
        }

        [HttpPost]
        public ActionResult SubirImagen(string nameImage)
        {
            try
            {
                var carpetaPais = Dictionaries.FileManager.Configuracion[Dictionaries.FileManager.TipoArchivo.FotoPerfilConsultora];
                var result = false;

                if (!string.IsNullOrEmpty(nameImage))
                {
                    var upLoadedImagenPrincipal = ConfigS3.SetFileS3(Path.Combine(Globals.RutaTemporales, nameImage),
                        carpetaPais,
                        nameImage,
                        true, true, true);
                    if (!upLoadedImagenPrincipal)
                        return Json(new { success = false, name = nameImage }, "text/html");

                    using (var sv = new UsuarioServiceClient())
                    {
                        sv.UpdUsuarioFotoPerfil(userData.PaisID, userData.CodigoUsuario, nameImage);
                    }

                    if (!Util.IsUrl(userData.FotoOriginalSinModificar) && !string.IsNullOrEmpty(userData.FotoOriginalSinModificar))
                    {
                        ConfigS3.DeleteFileS3(carpetaPais, userData.FotoOriginalSinModificar);
                    }

                    var imagenS3 = string.Concat(ConfigS3.GetUrlS3(Dictionaries.FileManager.Configuracion[Dictionaries.FileManager.TipoArchivo.FotoPerfilConsultora]), nameImage);
                    userData.FotoPerfil = string.Concat(ConfigCdn.GetUrlCdn(Dictionaries.FileManager.Configuracion[Dictionaries.FileManager.TipoArchivo.FotoPerfilConsultora]), nameImage);

                    if (Util.IsUrl(userData.FotoPerfil))
                    {
                        userData.FotoPerfilAncha = Util.EsImagenAncha(imagenS3);
                        ViewBag.FotoPerfilAncha = userData.FotoPerfilAncha;
                    }

                    userData.FotoOriginalSinModificar = nameImage;
                    ViewBag.FotoPerfilSinModificar = nameImage;

                    SessionManager.SetUserData(userData);
                    result = true;
                }

                return Json(new { success = result, message = nameImage }, "text/html");
            }
            catch (Exception ex)
            {
                LogManager.LogManager.LogErrorWebServicesBus(ex, "", "");
                return Json(new { success = false, message = "Hubo un error al cargar el archivo, intente nuevamente." }, "text/html");
            }
        }

        [HttpPost]
        public ActionResult EliminarFoto()
        {
            try
            {
                using (var sv = new UsuarioServiceClient())
                {
                    sv.UpdUsuarioFotoPerfil(userData.PaisID, userData.CodigoUsuario, null);
                }

                var carpetaPais = Dictionaries.FileManager.Configuracion[Dictionaries.FileManager.TipoArchivo.FotoPerfilConsultora];

                if (!Util.IsUrl(userData.FotoOriginalSinModificar) && !string.IsNullOrEmpty(userData.FotoOriginalSinModificar))
                {
                    ConfigS3.DeleteFileS3(carpetaPais, userData.FotoOriginalSinModificar);
                }

                userData.FotoPerfil = "../../Content/Images/icono_avatar.svg";
                userData.FotoOriginalSinModificar = null;
                userData.FotoPerfilAncha = false;
                ViewBag.FotoPerfilAncha = userData.FotoPerfilAncha;
                ViewBag.FotoPerfilSinModificar = "";

                SessionManager.SetUserData(userData);

                return Json(new { success = true, message = "Foto de perfil eliminada correctamente." }, "text/html");
            }
            catch (Exception ex)
            {
                LogManager.LogManager.LogErrorWebServicesBus(ex, "", "");
                return Json(new { success = false, message = "Error." }, "text/html");
            }
        }

        [HttpPost]
        public async Task<ActionResult> EnviarSmsCodigo(string celular)
        {
            var validator = GetPhoneValidator();

            var result = await validator.Valid(celular);
            if (!result.Success)
            {
                return Json(result);
            }

            ISmsSender sender = new SmsProcess
            {
                User = userData,
                Mobile = EsDispositivoMovil()
            };

            result = await sender.Send(celular);

            return Json(result);
        }

        [HttpPost]
        public async Task<ActionResult> ConfirmarSmsCode(string smsCode)
        {
            ISmsConfirm sender = new SmsProcess
            {
                User = userData
            };

            var result = await sender.Confirm(smsCode);

            if (!result.Success)
            {
                return Json(result);
            }

            var celularNuevo = result.Message;
            UpdateCelularLogDynamo(celularNuevo);

            return Json(new { Success = true });
        }

        [HttpPost]
        public JsonResult ActualizarDatos(MisDatosModel model)
        {
            JsonResult vRetorno;

            try
            {
                var entidad = Mapper.Map<MisDatosModel, BEUsuario>(model);
                var correoAnterior = model.CorreoAnterior;

                entidad.CodigoUsuario = (entidad.CodigoUsuario == null) ? "" : userData.CodigoUsuario;
                entidad.EMail = entidad.EMail ?? "";
                entidad.Telefono = entidad.Telefono ?? "";
                entidad.TelefonoTrabajo = entidad.TelefonoTrabajo ?? "";
                entidad.Celular = entidad.Celular ?? "";
                entidad.Sobrenombre = entidad.Sobrenombre ?? "";
                entidad.ZonaID = userData.ZonaID;
                entidad.RegionID = userData.RegionID;
                entidad.ConsultoraID = userData.ConsultoraID;
                entidad.PaisID = userData.PaisID;
                entidad.PrimerNombre = userData.PrimerNombre;
                entidad.CodigoISO = userData.CodigoISO;

                using (UsuarioServiceClient svr = new UsuarioServiceClient())
                {
                    var resultado = svr.ActualizarMisDatos(entidad, correoAnterior);

                    ActualizarDatosLogDynamoDB(model, "MI PERFIL", Constantes.LogDynamoDB.AplicacionPortalConsultoras, "Modificacion");

                    var lst = resultado.Split('|');

                    if (lst[0] == "0")
                    {
                        vRetorno = Json(new
                        {
                            Cantidad = lst[3],
                            success = false,
                            message = lst[2],
                            extra = ""
                        });
                    }
                    else
                    {
                        vRetorno = Json(new
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

                vRetorno = Json(new
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

                vRetorno = Json(new
                {
                    Cantidad = 0,
                    success = false,
                    message = "Ocurrió un error al acceder al servicio, intente nuevamente.",
                    extra = ""
                });
            }

            return vRetorno;
        }

        [HttpPost]
        public JsonResult CambiarConsultoraPass(string OldPassword, string NewPassword)
        {
            int rslt = 0;
            try
            {
                using (UsuarioServiceClient sv = new UsuarioServiceClient())
                {
                    var resultExiste = sv.ExisteUsuario(userData.PaisID, userData.CodigoUsuario, OldPassword);
                    if (resultExiste == Constantes.ValidacionExisteUsuario.Existe)
                    {
                        var lstClave = sv.SelectByNombre(Convert.ToInt32(userData.PaisID), userData.CodigoUsuario).ToList();
                        var contraseniaAnt = lstClave[0].ClaveSecreta;

                        var result = sv.CambiarClaveUsuario(userData.PaisID, userData.CodigoISO, userData.CodigoUsuario,
                            NewPassword, "", userData.CodigoUsuario, EAplicacionOrigen.MisDatosConsultora);

                        rslt = result ? 2 : 1;

                        var lst = sv.SelectByNombre(Convert.ToInt32(userData.PaisID), userData.CodigoUsuario).ToList();
                        var contraseniaCambiada = lst[0].ClaveSecreta;

                        RegistrarLogDynamoCambioClave("MODIFICACION", userData.CodigoConsultora, contraseniaCambiada, contraseniaAnt, "Mi PERFIL", "ACTUALIZAR CONTRASEÑA");
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
        public JsonResult validaPass(string pass)
        {
            try
            {
                var rslt = 0;
                using (var sv = new UsuarioServiceClient())
                {
                    var resultExiste = sv.ExisteUsuario(userData.PaisID, userData.CodigoUsuario, pass);
                    if (resultExiste == Constantes.ValidacionExisteUsuario.Existe)
                    {
                        rslt = 1;
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

        private MultiPhoneValidator GetPhoneValidator()
        {
            var validators = new IPhoneValidator[]
            {
                new MatchCountryPhone
                {
                    PaisId = userData.PaisID
                },
                new NotExistingPhone
                {
                    PaisId = userData.PaisID,
                    CodigoConsultora = userData.CodigoConsultora
                }
            };

            var validator = new MultiPhoneValidator(validators);

            return validator;
        }

        private static byte[] ReadFully(Stream input)
        {
            byte[] buffer = new byte[16 * 1024];
            using (MemoryStream ms = new MemoryStream())
            {
                int read;
                while ((read = input.Read(buffer, 0, buffer.Length)) > 0)
                {
                    ms.Write(buffer, 0, read);
                }
                return ms.ToArray();
            }
        }

        private void UpdateCelularLogDynamo(string celularNuevo)
        {
            try
            {
                var usuario = Mapper.Map<BEUsuario>(userData);
                var misDatosModel = Mapper.Map<MisDatosModel>(usuario);
                misDatosModel.Celular = celularNuevo;
                ActualizarDatosLogDynamoDB(misDatosModel, "MI PERFIL/ACTUALIZACIÓN DE CELULAR",
                    Constantes.LogDynamoDB.AplicacionPortalConsultoras, "Modificacion");
            }
            catch (Exception ex)
            {
                LogManager.LogManager.LogErrorWebServicesBus(ex, userData.CodigoConsultora, userData.CodigoISO);
            }
        }


        public string CancelarAtualizacionEmail(string tipoEnvio)
        {
            try
            {

                using (var svClient = new UsuarioServiceClient())
                {
                    var result = svClient.CancelarAtualizacionEmail(userData.PaisID, userData.CodigoUsuario, tipoEnvio);
                    return result;
                }

            }
            catch (Exception ex)
            {
                LogManager.LogManager.LogErrorWebServicesBus(ex, userData.CodigoConsultora, userData.CodigoISO);
                return "";
            }
        }




    }

}