﻿using Portal.Consultoras.Common;
using Portal.Consultoras.Web.Models;
using Portal.Consultoras.Web.Providers;
using System;
using System.Linq;
using System.Web.Mvc;

namespace Portal.Consultoras.Web.Areas.Mobile.Controllers
{
    public class FichaProductoController : BaseMobileController
    {
        private readonly VCFichaProductoProvider _vcFichaProductoProvider;

        public FichaProductoController()
        {
            _vcFichaProductoProvider = new VCFichaProductoProvider();
        }

        public ActionResult Index()
        {
            return View();
        }

        public ActionResult Detalle(string param)
        {
            try
            {
                var cuv = param.Substring(0, 5);
                var campanaId = Convert.ToInt32(param.Substring(5, 6));
                var producto = (FichaProductoDetalleModel)null;
                if (userData.CampaniaID == campanaId)
                {
                    var listaPedido = ObtenerPedidoWebDetalle();
                    var lst = _vcFichaProductoProvider.ConsultarFichaProductoPorCuv(listaPedido, cuv, campanaId);
                    producto = _vcFichaProductoProvider.FichaProductoFormatearModelo(lst, listaPedido).SingleOrDefault();
                    producto = _vcFichaProductoProvider.FichaProductoHermanos(producto, listaPedido, userData.CampaniaID);
                    if (producto != null)
                    {
                        producto.FotoProducto01 = ConfigCdn.GetUrlFileCdnMatriz(userData.CodigoISO, producto.FotoProducto01);
                        SessionManager.SetFichaProductoTemporal(producto);
                    }
                }
                if (producto == null)
                {
                    return View("ProductoNotFound");
                }
                else
                {
                    ViewBag.OrigenUrl = Url.Action("Index", "Pedido", new { area = "Mobile" });

                    ViewBag.EstadoSuscripcion = revistaDigital.SuscripcionModel.EstadoRegistro;
                    ViewBag.VirtualCoachCuv = cuv;
                    ViewBag.VirtualCoachCampana = campanaId;
                    return View(producto);
                }
            }
            catch (Exception ex)
            {
                LogManager.LogManager.LogErrorWebServicesBus(ex, userData.CodigoConsultora, userData.CodigoISO);
            }
            return RedirectToAction("Index", "Bienvenida", new { area = "Mobile" });
        }

    }
}