using System;
using System.Collections.Generic;
using Microsoft.VisualStudio.TestTools.UnitTesting;
using Portal.Consultoras.Web.Controllers;
using Portal.Consultoras.Web.Models;
using Moq;
using Portal.Consultoras.Web.LogManager;
using Portal.Consultoras.Web.SessionManager;

namespace Portal.Consultoras.Web.UnitTest.Controllers
{
    [TestClass]
    public class GestionContenidoControllerUnitTest
    {
        [TestClass]
        public class Base
        {
            public Mock<ISessionManager> sessionManager;

            [TestInitialize]
            public void Test_Initialize()
            {
                sessionManager = new Mock<ISessionManager>();

            }

            [TestCleanup]
            public void Test_Cleanup()
            {
                sessionManager = null;
            }
        }

        [TestClass]
        public class GetResumenCampania
        {
            [TestMethod]
            public void GetResumenCampania__()
            {
                
            }
        }

    }
}
