using Portal.Consultoras.Common;
using Portal.Consultoras.Web.Models;
using Portal.Consultoras.Web.Providers;
using Portal.Consultoras.Web.ServiceSAC;
using Portal.Consultoras.Web.ServiceUsuario;
using System.Web.Mvc;

namespace Portal.Consultoras.Web.Areas.Mobile.Controllers
{
    public class MiPerfilController : BaseMobileController
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

        public ActionResult CambiarFotoPerfil()
        {
            return View();
        }

        public ActionResult ActualizarCorreo()
        {
            ViewBag.CorreoActual = userData.EMail;
            ViewBag.UrlPdfTerminosyCondiciones = _revistaDigitalProvider.GetUrlTerminosCondicionesDatosUsuario(userData.CodigoISO);
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

    }
}