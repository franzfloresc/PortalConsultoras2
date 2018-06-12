using Portal.Consultoras.Common;
using Portal.Consultoras.Web.LogManager;
using Portal.Consultoras.Web.Models;
using Portal.Consultoras.Web.ServiceSAC;
using Portal.Consultoras.Web.SessionManager;
using System.Collections.Generic;
using System.Configuration;
using System.Linq;
using System.Web.Mvc;

namespace Portal.Consultoras.Web.Controllers
{
    public class BaseRevistaDigitalController : BaseEstrategiaController
    {
        public BaseRevistaDigitalController()
            : base()
        {
        }

        public BaseRevistaDigitalController(ISessionManager sessionManager)
            : base(sessionManager)
        {
        }

        public BaseRevistaDigitalController(ISessionManager sessionManager, ILogManager logManager)
            : base(sessionManager, logManager)
        {
        }

        public ActionResult IndexModel()
        {
            if (revistaDigital.TieneRDI)
                return View("template-informativa-rdi");

            var esMobile = IsMobile();
            if (!revistaDigital.TieneRDC && !revistaDigital.TieneRDS)
                return RedirectToAction("Index", "Ofertas", new { area = esMobile ? "Mobile" : "" });
            
            var modelo = _revistaDigitalProvider.InformativoModel(IsMobile());
            return View("template-informativa", modelo);
        }

        //public bool EsSuscripcionInmediata()
        //{
        //    return revistaDigital.SuscripcionModel != null ? (revistaDigital.ActivoMdo&&(revistaDigital.SuscripcionModel.CampaniaEfectiva == revistaDigital.SuscripcionModel.CampaniaID)&& revistaDigital.CantidadCampaniaEfectiva==0) : false;
        //}

        public ActionResult ViewLanding(int tipo)
        {
            var id = tipo == 1 ? userData.CampaniaID : Util.AddCampaniaAndNumero(userData.CampaniaID, 1, userData.NroCampanias);

            var model = new RevistaDigitalLandingModel
            {
                CampaniaID = id,
                IsMobile = IsMobile(),
                FiltersBySorting = _ofertasViewProvider.GetFiltersBySorting(IsMobile()),
                FiltersByBrand = _ofertasViewProvider.GetFiltersByBrand(),
                Success = true,
                MensajeProductoBloqueado = _ofertasViewProvider.MensajeProductoBloqueado(IsMobile()),
                CantidadFilas = 15
            };

            var dato = _ofertasViewProvider.ObtenerPerdioTitulo(model.CampaniaID, IsMobile());
            model.ProductosPerdio = dato.Estado;
            model.PerdioTitulo = dato.Valor1;
            model.PerdioSubTitulo = dato.Valor2;
            
            model.MostrarFiltros = !model.ProductosPerdio && !(revistaDigital.TieneRDC && !revistaDigital.EsActiva);

            return PartialView("template-landing", model);
        }

        public ActionResult DetalleModel(string cuv, int campaniaId)
        {
            var modelo = sessionManager.GetProductoTemporal();
            if (modelo == null || modelo.EstrategiaID == 0 || modelo.CUV2 != cuv || modelo.CampaniaID != campaniaId)
            {
                return RedirectToAction("Index", "Ofertas", new { area = IsMobile() ? "Mobile" : "" });
            }

            if (!revistaDigital.TieneRevistaDigital())
            {
                return RedirectToAction("Index", "Ofertas", new { area = IsMobile() ? "Mobile" : "" });
            }

            if (_ofertaPersonalizadaProvider.EsCampaniaFalsa(modelo.CampaniaID))
            {
                return RedirectToAction("Index", "Ofertas", new { area = IsMobile() ? "Mobile" : "" });
            }
            if (modelo.EstrategiaID <= 0)
            {
                return RedirectToAction("Index", "Ofertas", new { area = IsMobile() ? "Mobile" : "" });
            }

            modelo.TipoEstrategiaDetalle = modelo.TipoEstrategiaDetalle ?? new EstrategiaDetalleModelo();
            modelo.ListaDescripcionDetalle = modelo.ListaDescripcionDetalle ?? new List<string>();

            ViewBag.EstadoSuscripcion = revistaDigital.SuscripcionModel.EstadoRegistro;

            var dato = _ofertasViewProvider.ObtenerPerdioTitulo(modelo.CampaniaID, IsMobile());
            ViewBag.TieneProductosPerdio = dato.Estado;
            ViewBag.PerdioTitulo = dato.Valor1;
            ViewBag.PerdioSubTitulo = dato.Valor2;

            ViewBag.Campania = campaniaId;
            return View(modelo);

        }
        
        //private string GetVideoInformativo()
        //{
        //    var dato = revistaDigital.ConfiguracionPaisDatos.FirstOrDefault(d => d.Codigo == Constantes.ConfiguracionPaisDatos.RD.InformativoVideo) ?? new ConfiguracionPaisDatosModel();
        //    return Util.Trim(IsMobile() ? dato.Valor2 : dato.Valor1);
        //}

        //public string GetValorDato(string codigo, int valor = 1)
        //{
        //    var dato = revistaDigital.ConfiguracionPaisDatos.FirstOrDefault(d => d.Codigo == codigo) ?? new ConfiguracionPaisDatosModel();
        //    var valorDato = "";
        //    switch (valor)
        //    {
        //        case 0: valorDato = IsMobile() ? dato.Valor2 : dato.Valor1; break;
        //        case 1: valorDato = dato.Valor1; break;
        //        case 2: valorDato = dato.Valor2; break;
        //        case 3: valorDato = dato.Valor3; break;
        //        default: valorDato = dato.Valor1; break;
        //    }
        //    return Util.Trim(valorDato);
        //}

        //private bool CancelarSuscripcion(string origen, string pais)
        //{
        //    if (origen.IsNullOrEmptyTrim()) return false;
        //    string paises;
        //    if (origen.Equals(Constantes.RevistaDigitalOrigen.Unete))
        //    {
        //        paises = ConfigurationManager.AppSettings.Get(Constantes.ConfiguracionManager.PaisesCancelarSuscripcionRDUnete) ?? string.Empty;
        //        if (paises.Contains(pais)) return true;
        //    }
        //    else if (origen.Equals(Constantes.RevistaDigitalOrigen.Nueva))
        //    {
        //        paises = ConfigurationManager.AppSettings.Get(Constantes.ConfiguracionManager.PaisesCancelarSuscripcionRDNuevas) ?? string.Empty;
        //        if (paises.Contains(pais)) return true;
        //    }
        //    return false;
        //}
    }
}