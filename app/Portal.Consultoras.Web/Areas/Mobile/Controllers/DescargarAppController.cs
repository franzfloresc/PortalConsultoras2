﻿using Portal.Consultoras.Common;
using Portal.Consultoras.Web.ServiceSAC;
using System.Collections.Generic;
using System.Configuration;
using System.Linq;
using System.Threading.Tasks;
using System.Web.Mvc;

namespace Portal.Consultoras.Web.Areas.Mobile.Controllers
{
    public class DescargarAppController : BaseMobileController
    {
        public async Task<ActionResult> Index()
        {
            var lstComunicados = await ObtenerComunicadoPorConsultoraAsync();
            //HD-3550 EINCA
            //var oComunicado = lstComunicados.FirstOrDefault(x => x.Descripcion == Constantes.Comunicado.BannerDescargarAppNuevas);
            var oComunicado = lstComunicados.FirstOrDefault(x => x.TipoComunicado == Constantes.Comunicado.TipoComunicado.Banner);

            if (oComunicado != null) ViewBag.Url = oComunicado.DescripcionAccion;
            else return RedirectToAction("Index", "Bienvenida", new { area = "Mobile" });

            ViewBag.ComunicadoId = oComunicado.ComunicadoId;
            ViewBag.EsPaisEsika = ConfigurationManager.AppSettings.Get("PaisesEsika").Contains(userData.CodigoISO) ? "1" : "0";

            SessionManager.SetConsultoraNuevaBannerAppMostrar(true);

            return View();
        }

        private async Task<List<BEComunicado>> ObtenerComunicadoPorConsultoraAsync()
        {
            using (var sac = new SACServiceClient())
            {
                var lstComunicados = await sac.ObtenerComunicadoPorConsultoraAsync(userData.PaisID, userData.CodigoConsultora,
                        Constantes.ComunicadoTipoDispositivo.Desktop, userData.CodigorRegion, userData.CodigoZona, userData.ConsultoraNueva);

                return lstComunicados.ToList();
            }
        }
    }
}