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
    public class IncentivosSMSController : BaseController
    {
        readonly string IncentivoCUV = "96302";
        readonly string IncentivoPaisISO = Constantes.CodigosISOPais.Bolivia;
        readonly int IncentivoCampania = 201709;

        public ActionResult Index()
        {
            try
            {
                if (userData.RolID != Constantes.Rol.Consultora) return RedirectToAction("Index", "Bienvenida");
                if (userData.CodigoISO != IncentivoPaisISO) return RedirectToAction("Index", "Bienvenida");
                if (userData.CampaniaID != IncentivoCampania) return RedirectToAction("Index", "Bienvenida");

                List<BEProducto> listProducto;
                using (ODSServiceClient sv = new ODSServiceClient())
                {
                    listProducto = sv.SelectProductoByCodigoDescripcionSearchRegionZona(userData.PaisID, userData.CampaniaID, IncentivoCUV, userData.RegionID, userData.ZonaID, userData.CodigorRegion, userData.CodigoZona, 1, 1, true).ToList();
                }
                if (listProducto.Count == 0) return RedirectToAction("Index", "Bienvenida");

                var producto = listProducto[0];

                var model = new ProductoModel()
                {
                    CUV = producto.CUV,
                    Descripcion = producto.Descripcion.Trim(),
                    PrecioCatalogo = producto.PrecioCatalogo,
                    MarcaID = producto.MarcaID,
                    IndicadorMontoMinimo = producto.IndicadorMontoMinimo.ToString(),
                    TipoEstrategiaID = producto.TipoEstrategiaID
                };
                return View(model);
            }
            catch (FaultException ex)
            {
                LogManager.LogManager.LogErrorWebServicesPortal(ex, userData.CodigoConsultora, userData.CodigoISO);
            }
            catch (Exception ex)
            {
                LogManager.LogManager.LogErrorWebServicesBus(ex, userData.CodigoConsultora, userData.CodigoISO);
            }
            return RedirectToAction("Index", "Bienvenida");
        }
    }
}
