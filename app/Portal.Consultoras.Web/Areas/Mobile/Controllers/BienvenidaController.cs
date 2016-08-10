using Portal.Consultoras.Common;
using Portal.Consultoras.Web.Areas.Mobile.Models;
using Portal.Consultoras.Web.Models;
using Portal.Consultoras.Web.ServicePedido;
using Portal.Consultoras.Web.ServiceSAC;
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
            BEPedidoWeb bePedidoWeb = new BEPedidoWeb();

            try
            {
                using (PedidoServiceClient sv = new PedidoServiceClient())
                {
                    bePedidoWeb = sv.GetPedidoWebByCampaniaConsultora(userData.PaisID, userData.CampaniaID, userData.ConsultoraID);
                }
                model.MontoAhorroCatalogo = 0;
                model.MontoAhorroRevista = 0;

                if (bePedidoWeb != null)
                {
                    model.MontoAhorroCatalogo = bePedidoWeb.MontoAhorroCatalogo;
                    model.MontoAhorroRevista = bePedidoWeb.MontoAhorroRevista;
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

                model.Simbolo = userData.Simbolo;
                model.NombreConsultora = (string.IsNullOrEmpty(userData.Sobrenombre) ? userData.NombreConsultora : userData.Sobrenombre);
                model.NombrePais = userData.NombrePais;
                model.CodigoZona = userData.CodigoZona;                
                model.NumeroCampania = userData.CampaniaID == 0 ? "" : userData.CampaniaID.ToString().Substring(4);                
                model.DiasParaCierre = ViewBag.Dias;
                model.MensajeCierreCampania = ViewBag.MensajeCierreCampania;
                model.TieneFechaPromesa = ViewBag.TieneFechaPromesa;
                model.PaisID = userData.PaisID;
                //r20151104M
                model.DiaFechaPromesa = (ViewBag.DiaFechaPromesa == null ? 0 : ViewBag.DiaFechaPromesa);
                //r20151104M
                model.MensajeFechaPromesa = ViewBag.MensajeFechaPromesa;
                model.IndicadorPermisoFIC = ViewBag.IndicadorPermisoFIC;
                model.InscritaFlexipago = userData.InscritaFlexipago;
                model.InvitacionRechazada = userData.InvitacionRechazada;
                model.Lider = userData.Lider;
                model.PortalLideres = userData.PortalLideres;
                model.DiaPROL = userData.DiaPROL;
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
                    model.RutaChile = string.Empty; // CAH - R20150931
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
    }
}
