using Portal.Consultoras.Common;
using Portal.Consultoras.Web.Models;
using Portal.Consultoras.Web.ServiceSAC;
using Portal.Consultoras.Web.ServiceUsuario;
using Portal.Consultoras.Web.ServiceZonificacion;
using System;
using System.Configuration;
using System.Linq;
using System.ServiceModel;
using System.Threading.Tasks;
using System.Web.Mvc;
using Portal.Consultoras.Common.Validator;
using Portal.Consultoras.Web.Infraestructure.Validator.Phone;

namespace Portal.Consultoras.Web.Controllers
{
    public class MiPerfilController : BaseController
    {
        public ActionResult Index()
        {
            ServiceUsuario.BEUsuario beusuario;
            var model = new MisDatosModel();

            using (var sv = new UsuarioServiceClient())
            {
                beusuario = sv.Select(userData.PaisID, userData.CodigoUsuario);
            }

            if (beusuario != null)
            {
                model.PaisISO = userData.CodigoISO;

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
                model.NombreArchivoContrato = GetConfiguracionManager(Constantes.ConfiguracionManager.Contrato_ActualizarDatos + userData.CodigoISO);

                BEZona[] bezona;
                using (var sv = new ZonificacionServiceClient())
                {
                    bezona = sv.SelectZonaById(userData.PaisID, userData.ZonaID);
                }
                model.NombreGerenteZonal = bezona.ToList().Count == 0 ? "" : bezona[0].NombreGerenteZona;

                if (beusuario.EMailActivo) model.CorreoAlerta = "";
                if (!beusuario.EMailActivo && beusuario.EMail != "") model.CorreoAlerta = "Su correo aun no ha sido activado";

                if (model.UsuarioPrueba == 1)
                {
                    using (var sv = new SACServiceClient())
                    {
                        model.NombreConsultoraAsociada = sv.GetNombreConsultoraAsociada(userData.PaisID, userData.CodigoUsuario) + " (" + sv.GetCodigoConsultoraAsociada(userData.PaisID, userData.CodigoUsuario) + ")";
                    }
                }

                model.DigitoVerificador = string.Empty;
                model.CodigoUsuario = userData.CodigoUsuario;
                model.Zona = userData.CodigoZona;
                model.ServiceSMS = userData.ServicioSMS;
                model.ActualizaDatos = userData.ActualizaDatos;

                var paisesDigitoControl = GetConfiguracionManager(Constantes.ConfiguracionManager.PaisesDigitoControl);
                if (paisesDigitoControl.Contains(model.PaisISO)
                    && !String.IsNullOrEmpty(beusuario.DigitoVerificador))
                {
                    model.CodigoUsuario = string.Format("{0} - {1} (Zona:{2})", userData.CodigoUsuario, beusuario.DigitoVerificador, userData.CodigoZona);
                }
                model.CodigoUsuarioReal = userData.CodigoUsuario;

                #region limite Min - Max Telef
                int limiteMinimoTelef, limiteMaximoTelef;
                GetLimitNumberPhone(out limiteMinimoTelef, out limiteMaximoTelef);
                model.limiteMinimoTelef = limiteMinimoTelef;
                model.limiteMaximoTelef = limiteMaximoTelef;
                #endregion
            }

            return View(model);
        }

        public ActionResult CambiarContrasenia()
        {
            return View();
        }

        public ActionResult ActualizarCorreo()
        {
            return View();
        }

        public ActionResult ConfirmacionCorreo(string data)
        {
            if (string.IsNullOrEmpty(data))
            {
                ViewBag.Mensaje = Constantes.MensajesError.MiPerfil_ConfirmacionCorreo;
                return View();
            }

            string mensaje;
            try
            {
                var paramDesencriptados = Util.Decrypt(data);
                string[] arrayParam = paramDesencriptados.Split(';');

                bool success;
                using (UsuarioServiceClient srv = new UsuarioServiceClient())
                {
                    success = srv.ActiveEmail(Convert.ToInt32(arrayParam[1]), arrayParam[0], arrayParam[2], arrayParam[3]);
                }
                mensaje = success ? Constantes.CambioCorreoResult.Valido : Constantes.CambioCorreoResult.Invalido;
            }
            catch (Exception ex)
            {
                LogManager.LogManager.LogErrorWebServicesBus(ex, userData.CodigoUsuario, userData.CodigoISO, "EncryptData=" + data);
                mensaje = Constantes.MensajesError.MiPerfil_ConfirmacionCorreo;
            }

            ViewBag.Mensaje = mensaje;
            return View();
        }

        public ActionResult ActualizarCelular()
        {
            return View();
        }

        public ActionResult CambiarFotoPerfil()
        {
            return View();
        }

        public async Task<ActionResult> EnviarSmsCodigo(string celular)
        {
            var validator = GetPhoneValidator();

            var result = await validator.Valid(celular);
            if (!result.Success)
            {
                return Json(result, JsonRequestBehavior.AllowGet); 
            }

            var code = Util.GenerarCodigoRandom();

            // send SmsCode
            // save SmsCode
            return Json(new
            {
                Success = true
            }, JsonRequestBehavior.AllowGet);
        }

        public async Task<ActionResult> ConfirmarSmsCode(string smsCode)
        {
            // verify timeout and code
            
            var result = await new NotExistingPhone().Valid("");
            if (!result.Success)
            {
                return Json(result, JsonRequestBehavior.AllowGet); 
            }
            // update number phone

            return Json(new
            {
                Success = true
            }, JsonRequestBehavior.AllowGet);
        }

        private MultiPhoneValidator GetPhoneValidator()
        {
            var matchCountry = new MatchCountryPhone {IsoPais = userData.CodigoISO};

            var validators = new IPhoneValidator[]
            {
                matchCountry,
                new NotExistingPhone()
            };
            var validator = new MultiPhoneValidator(validators);
            return validator;
        }
    }
}