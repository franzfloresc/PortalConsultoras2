using Portal.Consultoras.Common;
using Portal.Consultoras.Web.Models;
using Portal.Consultoras.Web.ServiceSAC;
using Portal.Consultoras.Web.ServiceUsuario;
using System.Web.Mvc;
using System.Collections.Generic;
using System.ServiceModel.Channels;
using Portal.Consultoras.Web.Providers;
using Portal.Consultoras.Web.ServiceUnete;
using System.Threading.Tasks;
using System.Linq;

namespace Portal.Consultoras.Web.Areas.Mobile.Controllers
{
    public class MiPerfilController : BaseMobileController
    {
        protected MiPerfilProvider _miperfil;
		private readonly ZonificacionProvider _zonificacionProvider;

        public MiPerfilController()
        {
            _zonificacionProvider = new ZonificacionProvider();
        }

        public ActionResult Index()
        {
            BEUsuario beusuario;
            var model = new MisDatosModel();
            _miperfil = new MiPerfilProvider();

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

            model.DigitoVerificador = string.Empty;
            model.CodigoUsuario = userData.CodigoUsuario;
            model.Zona = userData.CodigoZona;
            model.ServiceSMS = userData.PuedeEnviarSMS;
            model.ActualizaDatos = userData.PuedeActualizar;
            model.PaisID = userData.PaisID;

            var paisesDigitoControl = _configuracionManagerProvider.GetConfiguracionManager(Constantes.ConfiguracionManager.PaisesDigitoControl);
            if (paisesDigitoControl.Contains(model.PaisISO)
                && !string.IsNullOrEmpty(beusuario.DigitoVerificador))
            {
                model.CodigoUsuario = string.Format("{0} - {1} (Zona:{2})", userData.CodigoUsuario, beusuario.DigitoVerificador, userData.CodigoZona);
            }
            model.CodigoUsuarioReal = userData.CodigoUsuario;
            ViewBag.UrlPdfTerminosyCondiciones = _revistaDigitalProvider.GetUrlTerminosCondicionesDatosUsuario(userData.CodigoISO);

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

            var objMenu = ((List<PermisoModel>)ViewBag.Permiso).Where(p =>
                p.Posicion.Trim().ToLower().Equals(Constantes.MenuPosicion.Body) &&
                p.Codigo.Trim().ToLower().Equals(Constantes.MenuCodigo.MiPerfil.ToLower())
            ).ToList();
            model.DireccionEntrega = _miPerfilProvider.ObtenerDireccionPorConsultora(new DireccionEntregaModel { ConsultoraID = (int)userData.ConsultoraID, PaisID = userData.PaisID });
            Binder(model.DireccionEntrega);
            model.PermisoMenu = new List<string>();
            foreach (var item in objMenu)
            {
                foreach (var subitem in item.SubMenus)
                {
                    model.PermisoMenu.Add(subitem.Descripcion);
                }
            }
            model.UsuarioOpciones = _miperfil.GetUsuarioOpciones(userData.PaisID, userData.CodigoUsuario, true);
            model.TieneDireccionEntrega = userData.TieneDireccionEntrega;
            model.TienePermisosCuenta = model.UsuarioOpciones.Count > 0;
            model.CodigoConsultoraAsociada = userData.CodigoConsultora;

            return View(model);
        }
        private void Binder(DireccionEntregaModel record)
        {
            
            record.DropDownUbigeo1 = DropDownUbigeoPrincipal();
        }

        private List<ParametroUneteBE> DropDownUbigeoPrincipal()
        {
            return _miPerfilProvider.ObtenerUbigeoPrincipal(userData.CodigoISO);
        }

        [HttpGet]
        public async Task<JsonResult> ObtenerUbigeoDependiente(int Nivel, int IdPadre)
        {
            var records = await _miPerfilProvider.ObtenerUbigeoDependiente(userData.CodigoISO, Nivel, IdPadre);
            return Json(records, JsonRequestBehavior.AllowGet);

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