using AutoMapper;
using Portal.Consultoras.Common;
using Portal.Consultoras.Web.Models;
using Portal.Consultoras.Web.ServiceODS;
using System;
using System.Collections.Generic;
using System.Linq;
using System.ServiceModel;
using System.Web.Mvc;

namespace Portal.Consultoras.Web.Controllers
{
    public class PagoEnLineaController : BaseController
    {
        // GET: PagoEnLinea
        public ActionResult Index()
        {
            PagoEnlineaInfoModel PagoLinea = GetPagoEnlineaInfo();
            ViewBag.NombreCompleto = PagoLinea.Nombre;
            ViewBag.SaldoActual = PagoLinea.MontoSaldoActual;
            ViewBag.FechaVencimiento = PagoLinea.FechaConferencia;
           
            return View();
        }

        public PagoEnlineaInfoModel GetPagoEnlineaInfo()
        {
            PagoEnlineaInfoModel PagoLineaModel = new PagoEnlineaInfoModel();
            try
            {
                using (ServiceODS.ODSServiceClient sv = new ServiceODS.ODSServiceClient())
                {
                    BEPagoEnLineaInfo PagoInfo = sv.GetPagoEnLineaInfo(userData.PaisID, userData.CodigoConsultora, userData.CampaniaID, userData.ZonaID);
                    PagoLineaModel = Mapper.Map<BEPagoEnLineaInfo, PagoEnlineaInfoModel>(PagoInfo);
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
            return PagoLineaModel;
        }
    }
}