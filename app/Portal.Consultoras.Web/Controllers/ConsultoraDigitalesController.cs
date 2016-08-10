using AutoMapper;
using Portal.Consultoras.Web.Models;
using Portal.Consultoras.Web.ServiceZonificacion;
using System;
using System.Collections.Generic;
using System.Data.SqlTypes;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using System.Threading;
using System.Threading.Tasks;
using System.ServiceModel;
using Portal.Consultoras.Web.ServicePedido;
using System.Configuration;

namespace Portal.Consultoras.Web.Controllers
{
    public class ConsultoraDigitalesController : BaseController
    {

        public ActionResult Index()
        {

             DateTime fecha = DateTime.Now;

             using (ServiceSAC.SACServiceClient sv = new ServiceSAC.SACServiceClient())
             {
                 ViewBag.CampaniaActiva  = sv.GetCampaniaActivaPais(UserData().PaisID, fecha).AnoCampana;
             }


            return View();
        }

        [HttpPost]
        public JsonResult RealizarDescarga()
        {
            string mensaje = string.Empty;
            try
            {
                    string fechaproceso;

                    using (ServiceSAC.SACServiceClient sv = new ServiceSAC.SACServiceClient())
                    {

                        DateTime theDate = DateTime.Now;
                        fechaproceso = theDate.ToString("yyyyMMdd", System.Globalization.CultureInfo.InvariantCulture);

                        sv.GetConsultoraDigitalesDescarga(UserData().PaisID, UserData().CodigoISO, fechaproceso, UserData().CodigoUsuario);
                    }

                    return Json(new
                    {
                        success = true,
                        mensaje = "El proceso de generación de consultoras digitales ha finalizado satisfactoriamente."
                    });
                

            }
            catch (FaultException ex)
            {
                LogManager.LogManager.LogErrorWebServicesPortal(ex, UserData().CodigoConsultora, UserData().CodigoISO);
                return Json(new
                {
                    success = false,
                    mensaje = ex.Message,
                }, JsonRequestBehavior.AllowGet);
            }
        }


    }
}
