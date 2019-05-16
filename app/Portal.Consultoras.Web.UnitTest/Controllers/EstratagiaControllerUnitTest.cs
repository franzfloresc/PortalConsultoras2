using Microsoft.VisualStudio.TestTools.UnitTesting;
using Moq;
using Portal.Consultoras.Web.LogManager;
using Portal.Consultoras.Web.Models;
using Portal.Consultoras.Web.SessionManager;
using Portal.Consultoras.Web.UnitTest.Attributes;
using System;
using System.Collections.Generic;
using Portal.Consultoras.Web.ServiceUsuario;
using Portal.Consultoras.Common;
using System.Threading.Tasks;
using Portal.Consultoras.Web.Controllers.Estrategias;

namespace Portal.Consultoras.Web.UnitTest.Controllers
{
    [TestClass]
    public class EstratagiaControllerUnitTest
    {
        [TestClass]
        public class Carrusel : Base
        {

            [TestMethod]
            public void Carrusel_test()
            {
                var controller = new EstrategiaController(SessionManager.Object, LogManager.Object);
                var result = controller.FichaObtenerProductosUpSellingCarrusel("","","");

                Assert.IsNotNull(result);
            }
            
        }
    }
}
