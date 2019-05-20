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

namespace Portal.Consultoras.Web.UnitTest.Controllers
{
    [TestClass]
    public class EstratagiaControllerUnitTest
    {
        [TestClass]
        public class Carrusel : Base
        {
            protected Mock<TablaLogicaProvider> tablaLogicaProvider;

            [TestInitialize]
            public override void Test_Initialize()
            {
                base.Test_Initialize();
                tablaLogicaProvider = GetOfertaPersonalizadaProvider();
            }

            protected virtual Mock<TablaLogicaProvider> GetOfertaPersonalizadaProvider()
            {
                tablaLogicaProvider = new Mock<TablaLogicaProvider>
                {
                    //CallBase = true
                };
                tablaLogicaProvider.Setup(x => x.GetTablaLogicaDatos(
                    It.IsAny<int>(),
                    It.IsAny<short>(),
                    It.IsAny<bool>()
                    )).Returns(new List<TablaLogicaDatosModel> { new TablaLogicaDatosModel { Codigo= ":P"} });

                return tablaLogicaProvider;
            }

            [TestMethod]
            public void Carrusel_test()
            {
                //SessionManager.Setup(x => x.GetTablaLogicaDatos(It.IsAny<string>())).Returns(new TablaLogicaDatosModel { Codigo="" });
                var controller = new EstrategiaController(SessionManager.Object, LogManager.Object, tablaLogicaProvider.Object);
                var codigosProductos = new string[1];
                codigosProductos[0] = "321564987";

                var result = controller.FichaObtenerProductosUpSellingCarrusel("", "", codigosProductos,0);

                Assert.IsNotNull(result);
            }
            
        }
    }
}
