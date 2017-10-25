using Portal.Consultoras.Common;
using Portal.Consultoras.Web.Controllers;
using System;
using System.Web.Mvc;

namespace Portal.Consultoras.Web.Areas.Mobile.Controllers
{
    public class OfertasParaTiController : BaseEstrategiaController
    {

        public ActionResult Detalle(int id, int origen)
        {
            try
            {
                return RenderDetalle(id, origen);

            }
            catch (System.Exception ex)
            {
                logManager.LogErrorWebServicesBusWrap(ex, userData.CodigoConsultora, userData.CodigoISO, string.Empty);
            }

            return RedirectToAction("Index", "Bienvenida", new { area = "Mobile" });
        }

        public virtual ActionResult RenderDetalle(int id, int origen)
        {
            var modelo = EstrategiaGetDetalle(id);
            var origenPantalla = GetPantallaOrigenPedidoWeb(origen);

            if (modelo == null || modelo.EstrategiaID <= 0)
            {
                return GetRedirectTo(origenPantalla);
            }

            ViewBag.OrigenUrl = GetActionTo(origenPantalla);
            ViewBag.EstadoSuscripcion = revistaDigital.SuscripcionModel.EstadoRegistro;
            ViewBag.CampaniaMasDos = AddCampaniaAndNumero(userData.CampaniaID, 2) % 100;

            ViewBag.origenPedidoWebEstrategia = Constantes.OrigenPedidoWeb.MobileOfertasParaTiDetalle;
            if (origenPantalla == Enumeradores.PantallaOrigenPedidoWeb.RevistaDigital)
            {
                ViewBag.origenPedidoWebEstrategia = origen;
                ViewBag.Codigo = Constantes.ConfiguracionPais.RevistaDigital;
            }

            return View(modelo);
        }

        public virtual Enumeradores.PantallaOrigenPedidoWeb GetPantallaOrigenPedidoWeb(int origen)
        {
            var pantallaString = Util.SubStr(
                origen.ToString(),
                Constantes.OrigenPedidoWeb.Campos.PANTALLA_INICIO,
                Constantes.OrigenPedidoWeb.Campos.PANTALLA_TAMANO
                );

            var pantalla = Enumeradores.PantallaOrigenPedidoWeb.Default;

            Enum.TryParse<Enumeradores.PantallaOrigenPedidoWeb>(pantallaString,out pantalla);

            return pantalla;
        }

        public virtual ActionResult GetRedirectTo(Enumeradores.PantallaOrigenPedidoWeb origenPantalla)
        {
            switch (origenPantalla)
            {
                case Enumeradores.PantallaOrigenPedidoWeb.Default:
                    return RedirectToAction("Index", "Ofertas", new { area = "Mobile" });
                case Enumeradores.PantallaOrigenPedidoWeb.Home:
                    return RedirectToAction("Index", "Bienvenida", new { area = "Mobile" });
                case Enumeradores.PantallaOrigenPedidoWeb.Pedido:
                    return RedirectToAction("Index", "Pedido", new { area = "Mobile" });
                case Enumeradores.PantallaOrigenPedidoWeb.RevistaDigital:
                    return RedirectToAction("Index", "RevistaDigital", new { area = "Mobile" });
                case Enumeradores.PantallaOrigenPedidoWeb.GuiaNegocioDigital:
                    return RedirectToAction("Index", "GuiaNegocio", new { area = "Mobile" });
                //
                case Enumeradores.PantallaOrigenPedidoWeb.Liquidacion:
                case Enumeradores.PantallaOrigenPedidoWeb.CatalogoPersonalizado:
                case Enumeradores.PantallaOrigenPedidoWeb.ShowRoom:
                case Enumeradores.PantallaOrigenPedidoWeb.OfertaParaTi:
                case Enumeradores.PantallaOrigenPedidoWeb.General:
                default:
                    return RedirectToAction("Index", "Bienvenida", new { area = "Mobile" });
            }
        }

        public virtual string GetActionTo(Enumeradores.PantallaOrigenPedidoWeb origenPantalla)
        {
            var result = string.Empty;

            switch (origenPantalla)
            {
                case Enumeradores.PantallaOrigenPedidoWeb.Default:
                    result = Url.Action("Index", "Ofertas", new { area = "Mobile" });
                    break;
                case Enumeradores.PantallaOrigenPedidoWeb.Home:
                    result = Url.Action("Index", "Bienvenida", new { area = "Mobile" });
                    break;
                case Enumeradores.PantallaOrigenPedidoWeb.Pedido:
                    result = Url.Action("Index", "Pedido", new { area = "Mobile" });
                    break;
                case Enumeradores.PantallaOrigenPedidoWeb.RevistaDigital:
                    result = Url.Action("Index", "RevistaDigital", new { area = "Mobile" });
                    break;
                case Enumeradores.PantallaOrigenPedidoWeb.GuiaNegocioDigital:
                    result = Url.Action("Index", "GuiaNegocio", new { area = "Mobile" });
                    break;
                //
                case Enumeradores.PantallaOrigenPedidoWeb.Liquidacion:
                case Enumeradores.PantallaOrigenPedidoWeb.CatalogoPersonalizado:
                case Enumeradores.PantallaOrigenPedidoWeb.ShowRoom:
                case Enumeradores.PantallaOrigenPedidoWeb.OfertaParaTi:
                case Enumeradores.PantallaOrigenPedidoWeb.General:
                default:
                    result = Url.Action("Index", "Bienvenida", new { area = "Mobile" });
                    break;
            }

            return result;
        }

    }
}