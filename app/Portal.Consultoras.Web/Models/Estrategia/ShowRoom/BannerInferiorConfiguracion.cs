using System;
using System.Collections.Generic;
using System.Linq;

namespace Portal.Consultoras.Web.Models.Estrategia.ShowRoom
{
    public class BannerInferiorConfiguracion : IBannerInferiorConfiguracion
    {
        public bool Activo { get; set; }

        public string UrlImagen { get; set; }

        public string UrlRedireccion { get; set; }

        public IEnumerable<string> RutasParcialesExcluidas { get; set; }

        public bool SeDebeMostrar(System.Web.HttpRequestBase request)
        {
            var baseRoute = string.Format("/{0}/{1}",
                request.RequestContext.RouteData.Values["controller"],
                request.RequestContext.RouteData.Values["action"]);

            // si NO esta en las rutas excluidas
            return !RutasParcialesExcluidas.Any(r =>
                            r.Equals(request.Url.AbsolutePath, StringComparison.InvariantCultureIgnoreCase)
                        || r.Equals(baseRoute, StringComparison.InvariantCultureIgnoreCase));
        }
    }
}
