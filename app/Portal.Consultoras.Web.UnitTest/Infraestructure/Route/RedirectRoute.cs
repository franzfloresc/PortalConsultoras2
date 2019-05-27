using System;
using System.Web;
using Microsoft.VisualStudio.TestTools.UnitTesting;
using Portal.Consultoras.Web.Areas.Mobile;
using Moq;
using System.Web.Mvc;
using System.Web.Routing;

namespace Portal.Consultoras.Web.UnitTest.Infraestructure.Route
{

    [TestClass]
    public class RedirectRoute
    {


        private HttpContextBase CreateHttpContext(string targetUrl = null, string httpMethod = "GET")
        {
            Mock<HttpRequestBase> mockRequest = new Mock<HttpRequestBase>();
            mockRequest.Setup(m => m.AppRelativeCurrentExecutionFilePath).Returns(targetUrl);
            mockRequest.Setup(m => m.HttpMethod).Returns(httpMethod);

            Mock<HttpResponseBase> mockResponse = new Mock<HttpResponseBase>();
            mockResponse.Setup(m => m.ApplyAppPathModifier(It.IsAny<string>())).Returns<string>(s => s);


            Mock<HttpContextBase> mockContext = new Mock<HttpContextBase>();
            mockContext.Setup(x => x.Request).Returns(mockRequest.Object);
            mockContext.Setup(x => x.Response).Returns(mockResponse.Object);

            return mockContext.Object;
        }

        private void RegisterRoutes(RouteCollection routes)
        {
            routes.IgnoreRoute("{resource}.axd/{*pathInfo}");
            routes.Redirect("Mobile/Catalogo").ToUrl("MisCatalogosRevistas/Index");
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

        }
        [TestMethod]
        public void HttpHandler_EsRedirectHttpHandler()
        {
            RouteCollection routes = new RouteCollection();
            HttpContextBase _httpContextBase = CreateHttpContext("~/Mobile/Catalogo");
            RegisterRoutes(routes);

            RouteData _routeData = routes.GetRouteData(_httpContextBase);
            RequestContext _requestContext = new RequestContext(_httpContextBase, _routeData);
            IRouteHandler _routeHandler = _routeData.RouteHandler;
            var _httpHandler = _routeHandler.GetHttpHandler(_requestContext);

            Assert.IsNotNull(_routeData);
            Assert.IsTrue(_routeHandler is RedirectHttpHandler);
            Assert.IsTrue(_httpHandler is RedirectHttpHandler);

        }
        [TestMethod]
        public void UrlDestino_EsCorrectamenteSeleccionado()
        {

            RouteCollection routes = new RouteCollection();
            HttpContextBase _httpContextBase = CreateHttpContext("~/Mobile/Catalogo");
            RegisterRoutes(routes);

            RouteData _routeData = routes.GetRouteData(_httpContextBase);
            RequestContext _requestContext = new RequestContext(_httpContextBase, _routeData);
            RedirectHttpHandler _routeHandler = _routeData.RouteHandler as RedirectHttpHandler;
            Assert.IsTrue(_routeHandler.UrlDestino == "MisCatalogosRevistas/Index");
        }
        [TestMethod]
        public void To_ConNullUrltarget_ThrowsException()
        {
            // Arrange
            RouteCollection routes = new RouteCollection();

            Assert.ThrowsException<ArgumentNullException>(() => routes.Redirect("Mobile/Catalogo").ToUrl(null));
        }

    }
}


