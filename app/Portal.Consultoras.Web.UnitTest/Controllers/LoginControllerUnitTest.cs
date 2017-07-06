﻿using System;
using System.Collections.Generic;
using Microsoft.VisualStudio.TestTools.UnitTesting;
using Portal.Consultoras.Web.Controllers;
using Portal.Consultoras.Web.Models;
using Moq;
using Portal.Consultoras.Web.LogManager;

namespace Portal.Consultoras.Web.UnitTest.Controllers
{
    [TestClass]
    public class LoginControllerUnitTest
    {
        [TestClass]
        public class Base
        {
            public Mock<ILogManager> logManager;

            [TestInitialize]
            public void Test_Initialize()
            {
                logManager = new Mock<ILogManager>();

            }

            [TestCleanup]
            public void Test_Cleanup()
            {
                logManager = null;
            }
        }
        

        [TestClass]
        public class Index : Base
        {
            class LoginController_GetClientIpReturnsMultipleIps : LoginController
            {
                public LoginController_GetClientIpReturnsMultipleIps(ILogManager logManager):base(logManager)
                {

                }

                protected override bool EsUsuarioAutenticado()
                {
                    return false;
                }

                protected override IEnumerable<PaisModel> ObtenerPaises()
                {
                    return new List<PaisModel>();
                }

                protected override string GetIPCliente()
                {
                    return "190.57.170.225, 66.249.83.8";
                }

                protected override bool EstaActivoBuscarISOPorIP()
                {
                    return true;
                }

                protected override string ObtenerRutaBaseDatosGeoLite()
                {
                    return AppDomain.CurrentDomain.SetupInformation.ApplicationBase + @"\MaxMind\GeoLite2-Country.mmdb";
                }
            }

            [TestMethod]
            public void Index_GetClientIpReturnsMultipleIps_LogsError()
            {
                
                var controler = new LoginController_GetClientIpReturnsMultipleIps(logManager.Object);

                controler.Index();

                logManager.Verify(x => x.LogErrorWebServicesBus2(It.Is<Exception>( e => e.Message.Contains("The specified IP address was incorrectly formatted")),
                    It.IsAny<string>(),
                    It.IsAny<string>(),
                    It.IsAny<string>()), Times.AtLeastOnce);
            }

            class LoginController_GetClientIpReturnsOneIp : LoginController
            {
                public LoginController_GetClientIpReturnsOneIp(ILogManager logManager) : base(logManager)
                {

                }

                protected override bool EsUsuarioAutenticado()
                {
                    return false;
                }

                protected override IEnumerable<PaisModel> ObtenerPaises()
                {
                    return new List<PaisModel>();
                }

                protected override string GetIPCliente()
                {
                    return "190.57.170.225";
                }

                protected override bool EstaActivoBuscarISOPorIP()
                {
                    return true;
                }

                protected override string ObtenerRutaBaseDatosGeoLite()
                {
                    return AppDomain.CurrentDomain.SetupInformation.ApplicationBase + @"\MaxMind\GeoLite2-Country.mmdb";
                }
            }

            [TestMethod]
            public void Index_GetClientIpReturnsOneIp_LogsZeError()
            {

                var controler = new LoginController_GetClientIpReturnsOneIp(logManager.Object);

                controler.Index();

                logManager.Verify(x => x.LogErrorWebServicesBus2(It.Is<Exception>(e => e.Message.Contains("The specified IP address was incorrectly formatted")),
                    It.IsAny<string>(),
                    It.IsAny<string>(),
                    It.IsAny<string>()), Times.Never);
            }
        }
    }
}
