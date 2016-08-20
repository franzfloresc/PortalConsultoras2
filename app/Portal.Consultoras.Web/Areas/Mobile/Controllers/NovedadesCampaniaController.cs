using Portal.Consultoras.Common;
using Portal.Consultoras.Web.ServiceContenido;
using System;
using System.Collections.Generic;
using System.Linq;
using System.ServiceModel;
using System.Web.Mvc;

namespace Portal.Consultoras.Web.Areas.Mobile.Controllers
{
    public class NovedadesCampaniaController : BaseMobileController
    {
        #region Acciones

        public ActionResult Index()
        {
            SessionKeys.ClearSessionCantidadProductos();

            var userData = UserData();

            var model = new List<BEBannerInfo>();
            try
            {
                int SegmentoID;
                if (userData.CodigoISO == Constantes.CodigosISOPais.Venezuela)
                {
                    SegmentoID = userData.SegmentoID;
                }
                else
                {
                    SegmentoID = (userData.SegmentoInternoID == null) ? userData.SegmentoID : (int)userData.SegmentoInternoID;
                }

                var esConsultoraNueva = userData.ConsultoraNueva == 2 ? true : false;

                BEBannerInfo[] lstBannerInfoTemp;

                using (var service = new ContenidoServiceClient())
                {
                    lstBannerInfoTemp = service.SelectBannerByConsultoraBienvenida(userData.PaisID, userData.CampaniaID, userData.CodigoConsultora, esConsultoraNueva);
                }

                var lstBannerInfoPorZona = lstBannerInfoTemp.Where(p => p.ConfiguracionZona == string.Empty || p.ConfiguracionZona.Contains(userData.ZonaID.ToString()));

                var lstBannerInfo = lstBannerInfoPorZona.Where(p => p.Segmento == -1 || p.Segmento == SegmentoID);

                if (lstBannerInfo.Count() > 0)
                {
                    model.AddRange(lstBannerInfo.Where(x => x.GrupoBannerID == 1).OrderBy(x => x.Orden));
                    model.Update(x => x.Archivo = ConfigS3.GetUrlFileS3(Globals.UrlBanner, x.Archivo, Globals.RutaImagenesBanners));
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

        #endregion
    }
}
