﻿
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using System.Web.Routing;

namespace Portal.Consultoras.Web
{
    public class RouteConfig
    {
        public static void RegisterRoutes(RouteCollection routes)
        {
            routes.IgnoreRoute("{resource}.axd/{*pathInfo}");

            routes.MapRoute(
                name: "Set",
                url: "Set/{parameter}",
                defaults: new { controller = "Set", action = "Index", parameter = UrlParameter.Optional },
                namespaces: new[] { "Portal.Consultoras.Web.Controllers" }
                );

            routes.MapRoute(
                name: "ConsultoraOnlinePaginaPedido",
                url: "ConsultoraOnline/MisPedidos/Page/{Pagina}",
                defaults: new { controller = "ConsultoraOnline", action = "ObtenerPagina", Pagina = UrlParameter.Optional },
                namespaces: new[] { "Portal.Consultoras.Web.Controllers" }
            );

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

            //routes.MapRoute(
            //    name: "Custom",
            //    url: "{controller}/{action}/{id}/{Name}",
            //    defaults: new { controller = "Cliente", action = "PedidosWeb", id = UrlParameter.Optional }
            //);            
        }
    }
}
