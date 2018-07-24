using Portal.Consultoras.Web.Areas.Mobile.Models;
using Portal.Consultoras.Web.Models;
using Portal.Consultoras.Web.ServiceContenido;
using Portal.Consultoras.Web.ServiceODS;
using System;
using System.Collections.Generic;
using System.Linq;
using System.ServiceModel;
using System.Web.Mvc;

namespace Portal.Consultoras.Web.Areas.Mobile.Controllers
{
    public class PaypalController : BaseMobileController
    {
        #region Acciones

        public ActionResult Index()
        {
            var model = new PaypalMobileModel();

            try
            {
                //var userData = UserData();
                model.PaisID = userData.PaisID;
                model.CodigoConsultora = userData.CodigoConsultora;
                model.NombreConsultora = userData.NombreConsultora;
                model.CorreoConsultora = userData.EMail;
                model.SaldoActual = GetSaldoActualConsultora(userData);

                var parametros = GetParametrosConfiguracion(userData);
                if (parametros == null || parametros.Count == 0)
                {
                    throw new ArgumentException("Ocurrió un error al cargar la configuración de Paypal, por favor intente más tarde.");
                }

                model.Login = parametros[1].chrValor;
                model.Partner = parametros[3].chrValor;
                model.Type = parametros[6].chrValor;
                model.Method = parametros[2].chrValor;
                model.ReturnUrl = parametros[5].chrValor.Replace("Paypal", "Mobile/Paypal");
                model.PostUrl = parametros[4].chrValor;
                model.FailedUrl = parametros[0].chrValor;

                model.Anios = new List<string>();

                var anio = DateTime.Now.Year;
                var fin = anio + 7;

                for (var i = anio; i <= fin; i++)
                {
                    model.Anios.Add((i).ToString());
                }
            }
            catch (Exception ex)
            {
                ViewBag.ErrorMessage = ex.Message;
            }
            return View(model);
        }

        public JsonResult InsertDatosPago(string nroTarjeta, decimal monto)
        {
            //var userData = UserData();
            try
            {
                bool result;
                using (var sv = new ContenidoServiceClient())
                {
                    result = sv.ExistePagoPendiente(userData.PaisID, monto, nroTarjeta, DateTime.Now);
                }

                if (result)
                    return Json(new
                    {
                        success = false,
                        message = "Pendiente"
                    });

                using (var sv = new ContenidoServiceClient())
                {
                    sv.InsDatosPago(userData.PaisID, userData.CodigoConsultora, userData.CodigoTerritorio, monto, nroTarjeta, DateTime.Now, 1);
                }

                return Json(new
                {
                    success = true,
                    message = "Exito"
                });
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
                success = false,
                message = "Hubo un problema con el servicio, intente nuevamente"
            });
        }

        public ActionResult TransaccionSuccess()
        {
            return View();
        }

        public ActionResult TransaccionError()
        {
            return View();
        }

        #endregion

        #region Metodos

        private decimal GetSaldoActualConsultora(UsuarioModel userData)
        {
            var saldo = 0m;
            try
            {
                using (var sv = new ODSServiceClient())
                {
                    saldo = sv.GetSaldoActualConsultora(userData.PaisID, userData.CodigoConsultora);
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
            return saldo;
        }

        private List<BEPayPalConfiguracion> GetParametrosConfiguracion(UsuarioModel userData)
        {
            var lst = new List<BEPayPalConfiguracion>();
            try
            {
                using (var sv = new ContenidoServiceClient())
                {
                    lst = sv.GetConfiguracionPayPal(userData.PaisID).ToList();
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
            return lst;
        }

        #endregion
    }
}
