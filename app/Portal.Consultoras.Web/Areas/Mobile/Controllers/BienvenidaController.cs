using Portal.Consultoras.Common;
using Portal.Consultoras.Web.Areas.Mobile.Models;
using Portal.Consultoras.Web.Models;
using Portal.Consultoras.Web.ServiceContenido;
using Portal.Consultoras.Web.ServicePedido;
using Portal.Consultoras.Web.ServiceSAC;
using Portal.Consultoras.Web.ServiceUsuario;
using System;
using System.Collections.Generic;
using System.Configuration;
using System.Linq;
using System.ServiceModel;
using System.Web.Mvc;

namespace Portal.Consultoras.Web.Areas.Mobile.Controllers
{
    public class BienvenidaController : BaseMobileController
    {
        public ActionResult Index()
        {
            var model = new BienvenidaModel();
            try
            {
                var bePedidoWeb = ObtenerPedidoWeb();
                if (bePedidoWeb != null)
                {
                    model.MontoAhorroCatalogo = bePedidoWeb.MontoAhorroCatalogo;
                    model.MontoAhorroRevista = bePedidoWeb.MontoAhorroRevista;
                }

                var bePedidoWebDetalle = ObtenerPedidoWebDetalle();
                if (bePedidoWebDetalle != null)
                {
                    model.MontoPedido = bePedidoWebDetalle.Sum(p => p.ImporteTotal);
                }

                if (!string.IsNullOrEmpty(ViewBag.MensajeCumpleanos))
                {
                    model.Saludo = ViewBag.MensajeCumpleanos;
                }
                else if (!string.IsNullOrEmpty(ViewBag.MensajeAniversario))
                {
                    model.Saludo = ViewBag.MensajeAniversario;
                }
                else
                {
                    model.Saludo = ViewBag.Usuario;
                }
                
                model.codigoConsultora = userData.CodigoConsultora;
                model.Simbolo = userData.Simbolo;
                model.NombreConsultora = (string.IsNullOrEmpty(userData.Sobrenombre) ? userData.NombreConsultora : userData.Sobrenombre);
                model.PaisID = userData.PaisID;
                model.CodigoISO = userData.CodigoISO;
                model.NombrePais = userData.NombrePais;
                model.CodigoZona = userData.CodigoZona;                
                model.NumeroCampania = userData.CampaniaID == 0 ? "" : userData.CampaniaID.ToString().Substring(4);                
                model.DiasParaCierre = ViewBag.Dias;
                model.MensajeCierreCampania = ViewBag.MensajeCierreCampania;
                model.TieneFechaPromesa = ViewBag.TieneFechaPromesa;
                model.DiaFechaPromesa = (ViewBag.DiaFechaPromesa == null ? 0 : ViewBag.DiaFechaPromesa);
                model.MensajeFechaPromesa = ViewBag.MensajeFechaPromesa;
                model.IndicadorPermisoFIC = ViewBag.IndicadorPermisoFIC;
                model.InscritaFlexipago = userData.InscritaFlexipago;
                model.InvitacionRechazada = userData.InvitacionRechazada;
                model.Lider = userData.Lider;
                model.PortalLideres = userData.PortalLideres;
                model.DiaPROL = userData.DiaPROL;
                model.VioTutorial = userData.VioTutorialModelo;
                model.UrlEnterateMas = ConfigS3.GetUrlFileS3("Mobile/AppCatalogo/" + userData.CodigoISO, "enteratemas.png", String.Empty);

                model.CatalogoPersonalizadoMobile = userData.CatalogoPersonalizado;

                if (userData.CodigoISO == "CL" || userData.CodigoISO == "CO")
                {
                    var tabla = new List<BETablaLogicaDatos>();
                    using (SACServiceClient sac = new SACServiceClient())
                    {
                        tabla = sac.GetTablaLogicaDatos(userData.PaisID, 60).ToList();

                        if (userData.CodigoISO == "CL")
                        {
                            model.RutaChile = ConfigurationManager.AppSettings.Get("UrlPagoLineaChile");
                        }
                        else
                        {
                            model.RutaChile = string.Empty;
                        }
                    }
                }
                else
                {
                    model.RutaChile = string.Empty; 
                }
                var parametro = userData.CodigoConsultora + "|" + DateTime.Now.ToShortDateString() + " 23:59:59" + "|" + userData.CodigoISO;
                var urlChile = Util.EncriptarQueryString(parametro);
                model.UrlChileEncriptada = urlChile;

                BEConfiguracionCampania beConfiguracionCampania;
                using (var sv = new PedidoServiceClient())
                {
                    beConfiguracionCampania = sv.GetEstadoPedido(userData.PaisID, userData.CampaniaID, userData.ConsultoraID, userData.ZonaID, userData.RegionID);
                }

                if (beConfiguracionCampania.ZonaValida)
                {
                    if (!userData.PROLSinStock)
                    {
                        if (!(userData.NuevoPROL && userData.ZonaNuevoPROL))
                        {
                            model.PROL1 = true;
                        }
                    }
                }

                var fechaVencimientoTemp = userData.FechaLimPago;
                model.FechaVencimiento = fechaVencimientoTemp.ToString("dd/MM/yyyy") == "01/01/0001" ? "--/--" : fechaVencimientoTemp.ToString("dd/MM/yyyy");

                using (ContenidoServiceClient sv = new ContenidoServiceClient())
                {
                    if (userData.PaisID == 4 || userData.PaisID == 11) //Colombia y Perú
                        model.MontoDeuda = sv.GetDeudaTotal(userData.PaisID, int.Parse(userData.ConsultoraID.ToString()))[0].SaldoPendiente;
                    else
                        model.MontoDeuda = sv.GetSaldoPendiente(userData.PaisID, userData.CampaniaID, int.Parse(userData.ConsultoraID.ToString()))[0].SaldoPendiente;
                }

                using (var sv = new UsuarioServiceClient())
                {
                    model.IsConsultoraOnline = sv.GetCantidadPedidosConsultoraOnline(userData.PaisID, userData.ConsultoraID);
                }

                model.UrlImagenAppCatalogo = ConfigS3.GetUrlFileS3("Mobile/AppCatalogo/" + userData.CodigoISO, "app.png", String.Empty);
                model.UrlImagenMiAcademia = ConfigS3.GetUrlFileS3("Mobile/MiAcademia/" + userData.CodigoISO, "miacademia.png", String.Empty);
                model.UrlImagenLiquidaciones = ConfigS3.GetUrlFileS3("Mobile/Liquidaciones/" + userData.CodigoISO, "liquidaciones.png", String.Empty);
                model.UrlImagenCatalogoPersonalizado = ConfigS3.GetUrlFileS3("Mobile/CatalogoPersonalizado/" + userData.CodigoISO, "catalogo.png", String.Empty);
                model.EsCatalogoPersonalizadoZonaValida = userData.EsCatalogoPersonalizadoZonaValida;
            }
            catch (FaultException ex)
            {
                LogManager.LogManager.LogErrorWebServicesPortal(ex, userData.CodigoConsultora, userData.CodigoISO);
            }
            catch (Exception ex)
            {
                LogManager.LogManager.LogErrorWebServicesBus(ex, userData.CodigoConsultora, userData.CodigoISO);
            }
           
            return View(model);
        }

        [HttpPost]
        public JsonResult ValidacionConsultoraDA()
        {
            bool validar = false;
            string mensajeFechaDA = null;
            UsuarioModel userData = this.UserData();

            if (userData.EsquemaDAConsultora == true)
            {
                if (userData.EsZonaDemAnti == 1)
                {
                    int consultoraDA = 0;
                    using (SACServiceClient sv = new SACServiceClient())
                    {
                        BEConfiguracionConsultoraDA configuracionConsultoraDA = new BEConfiguracionConsultoraDA();
                        configuracionConsultoraDA.CampaniaID = Convert.ToString(userData.CampaniaID);
                        configuracionConsultoraDA.ConsultoraID = Convert.ToInt32(userData.ConsultoraID);
                        configuracionConsultoraDA.ZonaID = userData.ZonaID;

                        consultoraDA = sv.GetConfiguracionConsultoraDA(userData.PaisID, configuracionConsultoraDA);
                        if (consultoraDA == 0)
                        {
                            BECronograma cronograma = sv.GetCronogramaByCampaniaAnticipado(userData.PaisID, userData.CampaniaID, userData.ZonaID, 2).FirstOrDefault();
                            DateTime fechaDA = ((DateTime)cronograma.FechaInicioWeb) + userData.HoraCierreZonaDemAntiCierre;
                            mensajeFechaDA = fechaDA.ToString(@"dddd dd \de MMMM (hh:mm tt)");

                            validar = true;
                        }
                    }
                }
            }

            return Json(new { success = validar, mensajeFechaDA = mensajeFechaDA });
        }

        [HttpGet]
        public JsonResult JSONSetUsuarioTutorial()
        {
            int retorno;
            using (UsuarioServiceClient sv = new UsuarioServiceClient())
            {
                retorno = sv.setUsuarioVerTutorial(userData.PaisID, userData.CodigoUsuario);
                userData.VioTutorialModelo = retorno;
            }
            SetUserData(userData);
            return Json(new
            {
                result = retorno
            }, JsonRequestBehavior.AllowGet);
        }
    }
}
