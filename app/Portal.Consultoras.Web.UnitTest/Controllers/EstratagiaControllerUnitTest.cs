using Microsoft.VisualStudio.TestTools.UnitTesting;
using Moq;
using Portal.Consultoras.Web.LogManager;
using Portal.Consultoras.Web.Models;
//using Portal.Consultoras.Web.SessionManager;
using Portal.Consultoras.Web.UnitTest.Attributes;
using System;
using System.Collections.Generic;
using Portal.Consultoras.Web.ServiceUsuario;
using Portal.Consultoras.Common;
using System.Threading.Tasks;
using Portal.Consultoras.Web.Controllers.Estrategias;
using Portal.Consultoras.Web.Providers;
using Portal.Consultoras.Web.Models.ElasticSearch;

namespace Portal.Consultoras.Web.UnitTest.Controllers
{
    [TestClass]
    public class EstratagiaControllerUnitTest
    {
        [TestClass]
        public class Carrusel : Base
        {
            protected Mock<TablaLogicaProvider> tablaLogicaProvider;
            protected Mock<CarruselUpSellingProvider> carruselUpSellingProvider;

            [TestInitialize]
            public override void Test_Initialize()
            {
                base.Test_Initialize();
                tablaLogicaProvider = getTablaLogicaDatosProvider();
                carruselUpSellingProvider = getCarruselUpSellingProvider();
            }

            protected virtual Mock<CarruselUpSellingProvider> getCarruselUpSellingProvider()
            {
                carruselUpSellingProvider = new Mock<CarruselUpSellingProvider> { };
                carruselUpSellingProvider.Setup(x => x.ObtenerProductosCarruselUpSelling(
                    It.IsAny<string>(),
                    It.IsAny<string[]>(),
                    It.IsAny<double>()
                    )).Returns(
                        Task.FromResult(new OutputProductosUpSelling())
                    );
                return carruselUpSellingProvider;
            }

            protected virtual Mock<TablaLogicaProvider> getTablaLogicaDatosProvider()
            {
                tablaLogicaProvider = new Mock<TablaLogicaProvider> { };
                tablaLogicaProvider.Setup(x => x.GetTablaLogicaDatoValorInt(
                    It.IsAny<int>(),
                    It.IsAny<short>(),
                    It.IsAny<string>(),
                    It.IsAny<bool>()
                    )).Returns(1);

                return tablaLogicaProvider;
            }

            [TestMethod]
            public void CarruselObtener()
            {
                //SessionManager.Setup(x => x.GetTablaLogicaDatos(It.IsAny<string>())).Returns(new TablaLogicaDatosModel { Codigo="" });
                var controller = new EstrategiaController(SessionManager.Object, LogManager.Object, tablaLogicaProvider.Object);
                var codigosProductos = new string[1];
                codigosProductos[0] = "321564987";

                var result = controller.FichaObtenerProductosCarrusel("", "");//, codigosProductos, 0);

                Assert.IsNotNull(result);
            }

        }
    }
}
