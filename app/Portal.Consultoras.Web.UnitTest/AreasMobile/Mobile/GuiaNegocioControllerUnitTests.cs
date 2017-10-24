﻿using System;
using Microsoft.VisualStudio.TestTools.UnitTesting;
using Portal.Consultoras.Web.Areas.Mobile.Controllers;
using System.Web.Mvc;
using Moq;
using Portal.Consultoras.Web.SessionManager;
using Portal.Consultoras.Web.LogManager;

namespace Portal.Consultoras.Web.UnitTest.AreasMobile.Mobile
{
    [TestClass]
    public class GuiaNegocioControllerUnitTests
    {
        [TestClass]
        public class Base
        {
            public Mock<ISessionManager> sessionManager;
            public Mock<ILogManager> logManager;

            [TestInitialize]
            public void Test_Initialize()
            {
                sessionManager = new Mock<ISessionManager>();
                logManager = new Mock<ILogManager>();

            }

            [TestCleanup]
            public void Test_Cleanup()
            {
                sessionManager = null;
                logManager = null;
            }
        }

        [TestClass]
        public class Index : Base
        {
            public class GuiaNegocioControllerStub01: GuiaNegocioController
            {
                public override ActionResult RenderIndex()
                {
                    throw new Exception("Error Render Index");
                }

                public GuiaNegocioControllerStub01(ILogManager logManager)  
                {
                    this.logManager = logManager;
                }
            }

            [TestMethod]
            public void Index_WhenRenderIndexThrowException_LogsErrorAndRedirectsToBienvenida()
            {
                //Arrange
                var controller = new GuiaNegocioControllerStub01(logManager.Object);

                //Act
                var result = controller.Index() as RedirectToRouteResult;

                //Assert
                logManager.Verify(x => x.LogErrorWebServicesBusWrap(
                    It.Is<Exception>(e => e.Message =="Error Render Index"),
                    It.IsAny<string>(), 
                    It.IsAny<string>(), 
                    It.IsAny<string>()),
                    Times.Once);
                //
                Assert.AreEqual("Bienvenida", result.RouteValues["controller"]);
                Assert.AreEqual("Index", result.RouteValues["action"]);
            }
        }
    }
}