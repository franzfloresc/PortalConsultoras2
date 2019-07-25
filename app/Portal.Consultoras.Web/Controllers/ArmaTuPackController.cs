using AutoMapper;
using Portal.Consultoras.Common;
using Portal.Consultoras.Common.OrigenPedidoWeb;
using Portal.Consultoras.Web.CustomFilters;
using Portal.Consultoras.Web.Infraestructure;
using Portal.Consultoras.Web.Models;
using Portal.Consultoras.Web.Providers;
using System.Linq;
using System.Web.Mvc;

namespace Portal.Consultoras.Web.Controllers
{
    [UniqueSession("UniqueRoute", UniqueRoute.IdentifierKey, "/g/")]
    [ClearSessionMobileApp(UniqueRoute.IdentifierKey, "MobileAppConfiguracion", "StartSession")]
    [RoutePrefix("ArmaTuPack")]
    public class ArmaTuPackController : BaseController
    {
        private readonly ConfiguracionOfertasHomeProvider _confiOfertasHomeProvider;

        public ArmaTuPackController() : this(new ConfiguracionOfertasHomeProvider()) { }

        public ArmaTuPackController(ConfiguracionOfertasHomeProvider configuracionOfertasHomeProvider) : base()
        {
            _confiOfertasHomeProvider = configuracionOfertasHomeProvider;
        }

        public ActionResult Index()
        {
            return RedirectToAction("Detalle", "ArmaTuPack");
        }

        [HttpGet()]
        public ActionResult Detalle()
        {
            var esMobile = EsDispositivoMovil() || IsMobile();
            var area = esMobile ? "mobile" : string.Empty;
            if (!(revistaDigital.TieneRevistaDigital() && revistaDigital.EsSuscrita))
            {
                return RedirectToAction("Index", "Ofertas", new { Area = area });
            }

            var lstPedidoAgrupado = ObtenerPedidoWebSetDetalleAgrupado();
            var listaOfertasATP = _ofertaPersonalizadaProvider.ConsultarEstrategiasModel(esMobile, userData.CodigoISO, userData.CampaniaID, userData.CampaniaID, Constantes.TipoEstrategiaCodigo.ArmaTuPack).ToList();

            if (listaOfertasATP == null || !listaOfertasATP.Any())
            {
                return RedirectToAction("Index", "Ofertas", new { Area = area });
            }

            var listModel = _ofertaPersonalizadaProvider.FormatearModelo1ToPersonalizado(listaOfertasATP, lstPedidoAgrupado, userData.CodigoISO, userData.CampaniaID, 0, userData.esConsultoraLider, userData.Simbolo);

            var OfertaATP = listModel.FirstOrDefault();

            var modelo = Mapper.Map<EstrategiaPersonalizadaProductoModel, DetalleEstrategiaFichaDisenoModel>(OfertaATP);

            #region Obtiene variables portal
            var listaVariable = _configuracionPaisProvider.getBaseVariablesPortal(userData.CodigoISO, userData.Simbolo);
            #endregion
            #region Asignacion de propiedades de diseño
            var listaSeccion = _confiOfertasHomeProvider
                .ObtenerConfiguracionSeccion(revistaDigital, esMobile)
                .FirstOrDefault(x => x.Codigo == Constantes.TipoPersonalizacion.ArmaTuPack);

            if (listaOfertasATP.Count > 0)
            {
                modelo.ImagenFondo = listaSeccion.ImagenFondo;
                modelo.ColorFondo = listaSeccion.ColorFondo;
                modelo.SubTitulo = listaSeccion.SubTitulo
                    .Replace("#Cantidad", modelo.CantidadPack.ToString())
                    .Replace("#PrecioTotal", listaVariable.SimboloMoneda + " " + modelo.PrecioVenta);
                modelo.ColorTexto = listaSeccion.ColorTexto;
            }
            #endregion

            var packAgregado = lstPedidoAgrupado != null ? lstPedidoAgrupado.FirstOrDefault(x => x.TipoEstrategiaCodigo == Constantes.TipoEstrategiaCodigo.ArmaTuPack) : null;

            modelo.EsEditable = packAgregado != null;
            modelo.IsMobile = esMobile;
            modelo.CodigoUbigeoPortal = CodigoUbigeoPortal.GuionContenedorArmaTuPack;


            var modeloOrigenPedido = new OrigenPedidoWebModel
            {
                Dispositivo = esMobile ? ConsOrigenPedidoWeb.Dispositivo.Mobile : ConsOrigenPedidoWeb.Dispositivo.Desktop,
                Pagina = ConsOrigenPedidoWeb.Pagina.ArmaTuPackDetalle,
                Palanca = ConsOrigenPedidoWeb.Palanca.ArmaTuPack,
                Seccion = ConsOrigenPedidoWeb.Seccion.Ficha
            };

            modelo.OrigenAgregar = UtilOrigenPedidoWeb.ToInt(modeloOrigenPedido);

            return View(modelo);
        }

        public ActionResult AgregarATPApp()
        {
            return new EmptyResult();
        }
    }
}