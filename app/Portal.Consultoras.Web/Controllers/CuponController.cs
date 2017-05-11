using Portal.Consultoras.Common;
using Portal.Consultoras.Web.Models;
using Portal.Consultoras.Web.ServicePedido;
using Portal.Consultoras.Web.ServiceUsuario;
using System;
using System.Configuration;
using System.Web;
using System.Web.Mvc;

namespace Portal.Consultoras.Web.Controllers
{
    public class CuponController : BaseController
    {
        [HttpPost]
        public JsonResult ActualizarCupon()
        {
            try
            {
                ActivarCupon();
                return Json(new { success = true, message = "El cupón fue activado." });
            }
            catch (Exception ex) { return Json(new { success = false, message = "Ocurrió un error al ejecutar la operación. " + ex.Message }); }
        }

        [HttpPost]
        public JsonResult EnviarCorreoConfirmacionEmail(CuponEnviarCorreoConfirmacion confirmarModel)
        {
            try
            {
                if (ModelState.IsValid)
                {
                    BEUsuario entidad = new BEUsuario();
                    entidad.EMail = Util.Trim(confirmarModel.EMailNuevo);
                    entidad.Celular = Util.Trim(confirmarModel.Celular);
                    entidad.CodigoUsuario = userData.CodigoUsuario;
                    entidad.Telefono = userData.Telefono;
                    entidad.TelefonoTrabajo = userData.TelefonoTrabajo;
                    entidad.Sobrenombre = userData.Sobrenombre;
                    entidad.ZonaID = userData.ZonaID;
                    entidad.RegionID = userData.RegionID;
                    entidad.ConsultoraID = userData.ConsultoraID;
                    entidad.PaisID = userData.PaisID;

                    if (!string.IsNullOrEmpty(entidad.EMail))
                    {
                        bool correoDisponible = ValidarDisponibilidadDeNuevoEmail(entidad.EMail);
                        if (!correoDisponible)
                        {
                            return Json(new { success = false, message = "La dirección de correo electrónico ingresada ya pertenece a otra Consultora." }, JsonRequestBehavior.AllowGet);
                        }
                    }

                    string correoAnterior = Util.Trim(userData.EMail);
                    string correoNuevo = entidad.EMail;
                    bool emailActivo = userData.EMailActivo;
                    
                    ActualizarDatos(entidad, correoAnterior);
                    ActualizarDatosSesion(entidad, correoNuevo, correoAnterior);
                    
                    var emailValidado = userData.EMailActivo;

                    //if ((correoAnterior != correoNuevo) || (correoAnterior == correoNuevo && !userData.EMailActivo))
                    //{
                    //    string[] parametros = new string[] { userData.CodigoUsuario, userData.PaisID.ToString(), userData.CodigoISO, correoNuevo, "UrlReturn,sr" };
                    //    string param_querystring = Util.EncriptarQueryString(parametros);
                    //    HttpRequestBase request = this.HttpContext.Request;

                    //    bool tipopais = ConfigurationManager.AppSettings.Get("PaisesEsika").Contains(userData.CodigoISO);

                    //    var cadena = MailUtilities.CuerpoMensajePersonalizado(Util.GetUrlHost(this.HttpContext.Request).ToString(), userData.Sobrenombre, param_querystring, tipopais);

                    //    Util.EnviarMailMasivoColas("no-responder@somosbelcorp.com", correoNuevo, "Confirmación de Correo", cadena, true, userData.NombreConsultora);
                    //}

                    string[] parametros = new string[] { userData.CodigoUsuario, userData.PaisID.ToString(), userData.CodigoISO, correoNuevo, "UrlReturn,sr" };
                    string param_querystring = Util.EncriptarQueryString(parametros);
                    HttpRequestBase request = this.HttpContext.Request;

                    bool tipopais = ConfigurationManager.AppSettings.Get("PaisesEsika").Contains(userData.CodigoISO);

                    var cadena = MailUtilities.CuerpoMensajePersonalizado(Util.GetUrlHost(this.HttpContext.Request).ToString(), userData.Sobrenombre, param_querystring, tipopais);

                    Util.EnviarMailMasivoColas("no-responder@somosbelcorp.com", correoNuevo, "Confirmación de Correo", cadena, true, userData.NombreConsultora);


                    return Json(new { success = true, message = "Se envió el correo de confirmar email." });
                }
                else
                {
                    return Json(new { success = false, message = "Ocurrió un error al ejecutar la operación. Algunos campos no son correctos." });
                }
            }
            catch (Exception ex) { return Json(new { success = false, message = "Ocurrió un error al ejecutar la operación. " + ex.Message }); }
        }

        [HttpGet]
        public JsonResult ObtenerCupon()
        {
            try
            {
                CuponModel cuponModel = ObtenerDatosCupon();
                return Json(new { success = true, data = cuponModel }, JsonRequestBehavior.AllowGet);
            }
            catch (Exception ex) { return Json(new { success = false, message = "Ocurrió un error al ejecutar la operación. " + ex.Message }); }
        }

        private CuponModel ObtenerDatosCupon()
        {
            CuponModel cuponModel;
            BECuponConsultora cuponResult = ObtenerCuponDesdeServicio();
            
            if (cuponResult != null)
                cuponModel = MapearBECuponACuponModel(cuponResult);
            else
                throw new Exception();

            return cuponModel;
        }

        private BECuponConsultora ObtenerCuponDesdeServicio()
        {
            using (PedidoServiceClient svClient = new PedidoServiceClient())
            {
                int paisId = userData.PaisID;
                BECuponConsultora cuponBE = new BECuponConsultora();
                cuponBE.CodigoConsultora = userData.CodigoConsultora;
                cuponBE.CampaniaId = userData.CampaniaID;

                var cuponResult = svClient.GetCuponConsultoraByCodigoConsultoraCampaniaId(paisId, cuponBE);
                return cuponResult;
            }
        }

        private bool ValidarDisponibilidadDeNuevoEmail(string email)
        {
            using (UsuarioServiceClient svr = new UsuarioServiceClient())
            {
                int cantidad = svr.ValidarEmailConsultora(userData.PaisID, email, userData.CodigoUsuario);
                return (cantidad <= 0);
            }
        }

        private void ActualizarDatos(BEUsuario entidad, string correoAnterior)
        {
            using (UsuarioServiceClient sv = new UsuarioServiceClient())
            {
                sv.UpdateDatos(entidad, correoAnterior);
            }
        }

        private void ActualizarDatosSesion(BEUsuario entidad, string correoNuevo, string correoAnterior)
        {
            userData.EMail = entidad.EMail;
            userData.Celular = entidad.Celular;
            userData.EMailActivo = correoNuevo == correoAnterior ? userData.EMailActivo : false;
            SetUserData(userData);
        }

        private void ActivarCupon()
        {
            using (PedidoServiceClient svClient = new PedidoServiceClient())
            {
                BECuponConsultora cuponBE = new BECuponConsultora();
                cuponBE.CodigoConsultora = userData.CodigoConsultora;
                cuponBE.CampaniaId = userData.CampaniaID;
                cuponBE.EstadoCupon = Constantes.EstadoCupon.Activo;
                cuponBE.EnvioCorreo = true;

                svClient.UpdateCuponConsultoraEstadoCupon(userData.PaisID, cuponBE);
                svClient.UpdateCuponConsultoraEnvioCorreo(userData.PaisID, cuponBE);
            }
        }

        private CuponModel MapearBECuponACuponModel(BECuponConsultora cuponBE)
        {
            var codigoISO = userData.CodigoISO;

            return new CuponModel(codigoISO) {
                CuponConsultoraId = cuponBE.CuponConsultoraId,
                CodigoConsultora = cuponBE.CodigoConsultora,
                CampaniaId = cuponBE.CampaniaId,
                CuponId = cuponBE.CuponId,
                ValorAsociado = cuponBE.ValorAsociado,
                EstadoCupon = cuponBE.EstadoCupon,
                CorreoGanasteEnviado = cuponBE.EnvioCorreo,
                FechaCreacion = cuponBE.FechaCreacion,
                FechaModificacion = cuponBE.FechaModificacion,
                UsuarioCreacion = cuponBE.UsuarioCreacion,
                UsuarioModificacion = cuponBE.UsuarioModificacion,
                TipoCupon = cuponBE.TipoCupon
            };
        }
    }
}