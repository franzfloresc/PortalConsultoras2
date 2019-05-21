﻿using Portal.Consultoras.Web.Infraestructure;
using System.Web.Mvc;
using System.Web.Routing;

namespace Portal.Consultoras.Web
{
    public static class RouteConfig
    {
        public static void RegisterRoutes(RouteCollection routes)
        {
            routes.IgnoreRoute("{resource}.axd/{*pathInfo}");

            routes.MapMvcAttributeRoutes();

            routes.MapRoute(
                name: "ConsultoraOnlinePaginaPedido",
                url: "ConsultoraOnline/MisPedidos/Page/{Pagina}",
                defaults: new { controller = "ConsultoraOnline", action = "ObtenerPagina", Pagina = UrlParameter.Optional },
                namespaces: new[] { "Portal.Consultoras.Web.Controllers" }
            );

            //Ejm: ~/DetalleResponsive/GanaMas/2018010/0006/1101
            routes.MapRoute(
                name: "DetalleEstrategiaFichaResponsive",
                url: "Detalles/{palanca}/{campaniaId}/{cuv}/{origen}",
                defaults: new { controller = "DetalleEstrategia", action = "FichaResponsive", origen = UrlParameter.Optional },
                namespaces: new[] { "Portal.Consultoras.Web.Controllers" }
            );

            routes.MapRoute(
                name: "MobileDetalleEstrategiaFichaResponsive",
                url: "Mobile/Detalles/{palanca}/{campaniaId}/{cuv}/{origen}",
                defaults: new { controller = "DetalleEstrategia", action = "FichaResponsive", origen = UrlParameter.Optional },
                namespaces: new[] { "Portal.Consultoras.Web.Controllers" }
            );

            //Ejm: ~/Detalle/GanaMas/2018010/0006/1101
            routes.MapRoute(
                name: "DetalleEstrategiaFicha",
                url: "Detalle/{palanca}/{campaniaId}/{cuv}/{origen}",
                defaults: new { controller = "DetalleEstrategia", action = "Ficha", origen = UrlParameter.Optional },
                namespaces: new[] { "Portal.Consultoras.Web.Controllers" }
            );

            //Ejm: ~/Detalle/GanaMas/2018010/0006/1101
            routes.Add(
                "MobileDetalleEstrategiaFicha",
                new UniqueRoute(
                    "Mobile/Detalle/{palanca}/{campaniaId}/{cuv}/{origen}",
                    new { controller = "DetalleEstrategia", action = "Ficha", origen = "" },
                    new RouteValueDictionary(new
                    {
                        Area = "Mobile",
                        Namespaces = new[] { "Portal.Consultoras.Web.Areas.Mobile.Controllers" }
                    })
            ));
            
            routes.Add("UniqueRoute", new UniqueRoute(
                "g/{guid}/{controller}/{action}/{id}",
                new { controller = "Login", action = "Index", guid = "", id = UrlParameter.Optional },
                new RouteValueDictionary(new
                {
                    Area = "Mobile",
                    Namespaces = new[] { "Portal.Consultoras.Web.Areas.Mobile.Controllers" }
                })));

            routes.Add("UniqueRouteAnchor", new UniqueRoute(
                "g/{guid}/{controller}/{action}#{anchor}",
                new { controller = "Login", action = "Index", guid = "", anchor = UrlParameter.Optional },
                new RouteValueDictionary(new
                {
                    Area = "Mobile",
                    Namespaces = new[] { "Portal.Consultoras.Web.Areas.Mobile.Controllers" }
                })));

            routes.MapRoute(
                name: "Default",
                url: "{controller}/{action}/{id}",
                defaults: new { controller = "Login", action = "Index", id = UrlParameter.Optional },
                namespaces: new[] { "Portal.Consultoras.Web.Controllers" }
            );

            routes.MapRoute(
                name: "Servicios",
                url: "{controller}/{action}/{ServicioId}/{Url}",
                defaults: new { controller = "Servicios", action = "Index", ServicioId = UrlParameter.Optional, Url = UrlParameter.Optional },
                namespaces: new[] { "Portal.Consultoras.Web.Controllers" }
            );

        }
    }
}
