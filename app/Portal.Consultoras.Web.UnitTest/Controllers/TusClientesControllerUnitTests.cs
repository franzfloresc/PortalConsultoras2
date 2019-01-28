using Microsoft.VisualStudio.TestTools.UnitTesting;
using Moq;
using MvcContrib.TestHelper;
using Portal.Consultoras.Common;
using Portal.Consultoras.Web.Controllers;
using Portal.Consultoras.Web.LogManager;
using Portal.Consultoras.Web.Models;
using Portal.Consultoras.Web.Models.TusClientes;
using Portal.Consultoras.Web.Providers;
using Portal.Consultoras.Web.SessionManager;
using System;
using System.Reflection;
using System.Web.Mvc;

namespace Portal.Consultoras.Web.UnitTest.Controllers
{
    [TestClass]
    public class TusClientesControllerUnitTests
    {
        static Mock<ClienteProvider> clienteProvider;

        [TestClass]
        public class Consultar : Base
        {
            [TestInitialize]
            public override void Test_Initialize()
            {
                base.Test_Initialize();
                clienteProvider = new Mock<ClienteProvider>();
                ConfigureUserDataWithCampaniaActualAndConsultoraId(201901, 999888777);
            }

            [TestCleanup]
            public override void Test_Cleanup()
            {
                base.Test_Cleanup();
                clienteProvider = null;
            }

            [TestMethod]
            public void Consultar_textIsEmpty_shouldCallServiceAllClientes()
            {
                //Arrange
                var controller = new TusClientesController(clienteProvider.Object
                    ,SessionManager.Object
                    ,LogManager.Object);
                

                //Act
                controller.Consultar(string.Empty);

                //Assert    
                clienteProvider.Verify(x => x.SelectByConsultora(
                        It.Is<int>(p => p.Equals(11)),
                        It.Is<long>(p => p.Equals(999888777))
                        )
                    );
            }
        }
    }
}
