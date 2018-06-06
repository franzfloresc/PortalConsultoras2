using Portal.Consultoras.Common;
using Portal.Consultoras.Web.Models;
using Portal.Consultoras.Web.ServiceUsuario;
using System;
using System.Configuration;
using System.ServiceModel;
using System.Web.Mvc;

namespace Portal.Consultoras.Web.Controllers
{
    public class MiPerfilController : BaseController
    {
        public ActionResult Index()
        {
            return View();
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
    }
}