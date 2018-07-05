//using Portal.Consultoras.Common;
//using Portal.Consultoras.Web.Controllers;
//using System;
//using System.Web.Mvc;

//namespace Portal.Consultoras.Web.Areas.Mobile.Controllers
//{
//    public class OfertasParaTiController : BaseController //  BaseEstrategiaController
//    {
//        //public ActionResult Detalle(int id, int origen)
//        //{
//        //    try
//        //    {
//        //        return RenderDetalle(id, origen);

//        //    }
//        //    catch (Exception ex)
//        //    {
//        //        logManager.LogErrorWebServicesBusWrap(ex, userData.CodigoConsultora, userData.CodigoISO, string.Empty);
//        //    }

//        //    return RedirectToAction("Index", "Bienvenida", new { area = "Mobile" });
//        //}

//        //public virtual ActionResult RenderDetalle(int id, int origen)
//        //{
//        //    var modelo = EstrategiaGetDetalle(id);
//        //    var origenPantalla = GetPantallaOrigenPedidoWeb(origen);

//        //    if (modelo == null || modelo.EstrategiaID <= 0)
//        //        return GetRedirectTo(origenPantalla);
            
//        //    ViewBag.OrigenUrl = GetActionTo(origenPantalla, origen);

//        //    ViewBag.EstadoSuscripcion = revistaDigital.SuscripcionModel.EstadoRegistro;
//        //    ViewBag.origenPedidoWebEstrategia = GetOrigenPedidoWebDetalle(origen);

//        //    return View(modelo);
//        //}

//        //public virtual Enumeradores.PantallaOrigenPedidoWeb GetPantallaOrigenPedidoWeb(int origen)
//        //{
//        //    var pantallaString = Util.SubStr(
//        //        origen.ToString(),
//        //        Constantes.OrigenPedidoWeb.Campos.PANTALLA_INICIO,
//        //        Constantes.OrigenPedidoWeb.Campos.PANTALLA_TAMANO
//        //        );

//        //    var pantalla = Enumeradores.PantallaOrigenPedidoWeb.Default;

//        //    Enum.TryParse<Enumeradores.PantallaOrigenPedidoWeb>(pantallaString, out pantalla);

//        //    return pantalla;
//        //}

//        //public virtual int GetOrigenPedidoWebDetalle(int origenPantalla)
//        //{
//        //    var result = 0;

//        //    switch (origenPantalla)
//        //    {
//        //        case Constantes.OrigenPedidoWeb.OfertasParaTiMobileHome:
//        //            result = Constantes.OrigenPedidoWeb.OfertasParaTiMobileHomePopUp;
//        //            break;
//        //        case Constantes.OrigenPedidoWeb.OfertasParaTiMobilePedido:
//        //            result = Constantes.OrigenPedidoWeb.OfertasParaTiMobilePedidoPopUp;
//        //            break;
//        //        case Constantes.OrigenPedidoWeb.OfertasParaTiMobileContenedor:
//        //            result = Constantes.OrigenPedidoWeb.OfertasParaTiMobileContenedorPopup;
//        //            break;
//        //        case Constantes.OrigenPedidoWeb.CatalogoPersonalizadoMobile:
//        //            result = Constantes.OrigenPedidoWeb.CatalogoPersonalizadoMobilePopUp;
//        //            break;
//        //        case Constantes.OrigenPedidoWeb.RevistaDigitalMobileHomeSeccion:
//        //            result = Constantes.OrigenPedidoWeb.RevistaDigitalMobileHomePopUp;
//        //            break;
//        //        case Constantes.OrigenPedidoWeb.RevistaDigitalMobilePedidoSeccion:
//        //            result = Constantes.OrigenPedidoWeb.RevistaDigitalMobilePedidoPopUp;
//        //            break;
//        //        case Constantes.OrigenPedidoWeb.RevistaDigitalMobileLanding:
//        //            result = Constantes.OrigenPedidoWeb.RevistaDigitalMobileLandingPopUp;
//        //            break;
//        //        case Constantes.OrigenPedidoWeb.RevistaDigitalMobileHomeLanzamiento:
//        //            result = Constantes.OrigenPedidoWeb.LanzamientoMobileHomePopup;
//        //            break;
//        //        case Constantes.OrigenPedidoWeb.LanzamientoMobileContenedor:
//        //            result = Constantes.OrigenPedidoWeb.LanzamientoMobileContenedorPopup;
//        //            break;
//        //        case Constantes.OrigenPedidoWeb.GNDMobileLanding:
//        //            result = Constantes.OrigenPedidoWeb.GNDMobileLandingPopup;
//        //            break;
//        //        case Constantes.OrigenPedidoWeb.HVMobileLanding:
//        //            result = Constantes.OrigenPedidoWeb.HVMobileLandingPopup;
//        //            break;
//        //        case Constantes.OrigenPedidoWeb.LanzamientoMobileProductPage:
//        //            result = Constantes.OrigenPedidoWeb.LanzamientoMobileProductPage;
//        //            break;
//        //    }

//        //    result = result == 0 ? Constantes.OrigenPedidoWeb.OfertasParaTiMobileDetalle : result;

//        //    return result;
//        //}

//        //public virtual ActionResult GetRedirectTo(Enumeradores.PantallaOrigenPedidoWeb origenPantalla)
//        //{
//        //    switch (origenPantalla)
//        //    {
//        //        case Enumeradores.PantallaOrigenPedidoWeb.Default:
//        //            return RedirectToAction("Index", "Ofertas", new { area = "Mobile" });
//        //        case Enumeradores.PantallaOrigenPedidoWeb.Home:
//        //            return RedirectToAction("Index", "Bienvenida", new { area = "Mobile" });
//        //        case Enumeradores.PantallaOrigenPedidoWeb.Pedido:
//        //            return RedirectToAction("Index", "Pedido", new { area = "Mobile" });
//        //        case Enumeradores.PantallaOrigenPedidoWeb.RevistaDigital:
//        //            return RedirectToAction("Comprar", "RevistaDigital", new { area = "Mobile" });
//        //        case Enumeradores.PantallaOrigenPedidoWeb.GuiaNegocioDigital:
//        //            return RedirectToAction("Index", "GuiaNegocio", new { area = "Mobile" });
//        //        case Enumeradores.PantallaOrigenPedidoWeb.Liquidacion:
//        //        case Enumeradores.PantallaOrigenPedidoWeb.CatalogoPersonalizado:
//        //        case Enumeradores.PantallaOrigenPedidoWeb.ShowRoom:
//        //        case Enumeradores.PantallaOrigenPedidoWeb.OfertaParaTi:
//        //        case Enumeradores.PantallaOrigenPedidoWeb.General:
//        //            return RedirectToAction("Index", "Bienvenida", new { area = "Mobile" });
//        //        default:
//        //            return RedirectToAction("Index", "Bienvenida", new { area = "Mobile" });
//        //    }
//        //}

//        //public virtual string GetActionTo(Enumeradores.PantallaOrigenPedidoWeb origenPantalla, int origenPedidoWeb)
//        //{
//        //    string result = "";

//        //    switch (origenPedidoWeb)
//        //    {
//        //        case Constantes.OrigenPedidoWeb.GNDMobileLanding:
//        //        case Constantes.OrigenPedidoWeb.GNDMobileLandingPopup:
//        //            result = Url.Action("Index", "GuiaNegocio", new { area = "Mobile" });
//        //            break;
//        //        case Constantes.OrigenPedidoWeb.LanzamientoMobileContenedor:
//        //        case Constantes.OrigenPedidoWeb.LanzamientoMobileContenedorPopup:
//        //            result = Url.Action("Index", "Ofertas", new { area = "Mobile" });
//        //            break;
//        //        case Constantes.OrigenPedidoWeb.HVMobileLanding:
//        //            result = Url.Action("Comprar", "HerramientasVenta", new { area = "Mobile" });
//        //            break;
//        //        case Constantes.OrigenPedidoWeb.LanzamientoMobileProductPage:
//        //            result = Url.Action("Index", "Ofertas", new { area = "Mobile" });
//        //            break;
//        //    }

//        //    if (result != "")
//        //        return result;

//        //    switch (origenPantalla)
//        //    {
//        //        case Enumeradores.PantallaOrigenPedidoWeb.Default:
//        //            result = Url.Action("Index", "Ofertas", new { area = "Mobile" });
//        //            break;
//        //        case Enumeradores.PantallaOrigenPedidoWeb.Home:
//        //            result = Url.Action("Index", "Bienvenida", new { area = "Mobile" });
//        //            break;
//        //        case Enumeradores.PantallaOrigenPedidoWeb.Pedido:
//        //            result = Url.Action("Index", "Pedido", new { area = "Mobile" });
//        //            break;
//        //        case Enumeradores.PantallaOrigenPedidoWeb.RevistaDigital:
//        //            result = Url.Action("Comprar", "RevistaDigital", new { area = "Mobile" });
//        //            break;
//        //        case Enumeradores.PantallaOrigenPedidoWeb.GuiaNegocioDigital:
//        //            result = Url.Action("Index", "GuiaNegocio", new { area = "Mobile" });
//        //            if (origenPedidoWeb == Constantes.OrigenPedidoWeb.OfertasParaTiMobileContenedor)
//        //                result = Url.Action("Index", "Ofertas", new { area = "Mobile" });
                    
//        //            break;
//        //        case Enumeradores.PantallaOrigenPedidoWeb.HerramientasVentaComprar:
//        //            result = Url.Action("Comprar", "HerramientasVenta", new { area = "Mobile" });
//        //            break;
//        //        case Enumeradores.PantallaOrigenPedidoWeb.HerramientasVentaRevisar:
//        //            result = Url.Action("Revisar", "HerramientasVenta", new { area = "Mobile" });
//        //            break;
//        //        case Enumeradores.PantallaOrigenPedidoWeb.Liquidacion:
//        //        case Enumeradores.PantallaOrigenPedidoWeb.CatalogoPersonalizado:
//        //        case Enumeradores.PantallaOrigenPedidoWeb.ShowRoom:
//        //        case Enumeradores.PantallaOrigenPedidoWeb.OfertaParaTi:
//        //        case Enumeradores.PantallaOrigenPedidoWeb.General:
//        //            result = Url.Action("Index", "Bienvenida", new { area = "Mobile" });
//        //            break;
//        //        default:
//        //            result = Url.Action("Index", "Bienvenida", new { area = "Mobile" });
//        //            break;
//        //    }

//        //    return result;
//        //}

//    }
//}