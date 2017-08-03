using Microsoft.VisualStudio.TestTools.UnitTesting;
using Moq;
using Portal.Consultoras.Web.Controllers;
using Portal.Consultoras.Web.Models;
using System;
using System.Collections.Generic;

namespace Portal.Consultoras.Web.UnitTest.Controllers
{
    [TestClass]
    public class LoginControllerUnitTest
    {
        [TestClass]
        public class Index
        {
            class LoginController_GetClientIpReturnsMultipleIps : LoginController
            {
                protected override bool EsUsuarioAutenticado()
                {
                    return false;
                }

                protected override IEnumerable<PaisModel> ObtenerPaises()
                {
                    return new List<PaisModel>();
                }

                protected override string GetIpCliente()
                {
                    return "190.57.170.225, 66.249.83.8";
                }

                protected override bool EstaActivoBuscarIsoPorIp()
                {
                    return true;
                }

                protected override string ObtenerRutaBaseDatosGeoLite()
                {
                    return AppDomain.CurrentDomain.SetupInformation.ApplicationBase + @"\MaxMind\GeoLite2-Country.mmdb";
                }
            }

            //[TestMethod]
            //public void Index_GetClientIpReturnsMultipleIps_LogsError()
            //{

            //    var controler = new LoginController_GetClientIpReturnsMultipleIps();

            //    controler.Index();

            //    LogManager.Verify(x => x.LogErrorWebServicesBus2(It.Is<Exception>(e => e.Message.Contains("The specified IP address was incorrectly formatted")),
            //        It.IsAny<string>(),
            //        It.IsAny<string>(),
            //        It.IsAny<string>()), Times.AtLeastOnce);
            //}

            class LoginController_GetClientIpReturnsOneIp : LoginController
            {
                protected override bool EsUsuarioAutenticado()
                {
                    return false;
                }

                protected override IEnumerable<PaisModel> ObtenerPaises()
                {
                    return new List<PaisModel>();
                }

                protected override string GetIpCliente()
                {
                    return "190.57.170.225";
                }

                protected override bool EstaActivoBuscarIsoPorIp()
                {
                    return true;
                }

                protected override string ObtenerRutaBaseDatosGeoLite()
                {
                    return AppDomain.CurrentDomain.SetupInformation.ApplicationBase + @"\MaxMind\GeoLite2-Country.mmdb";
                }
            }

        //    [TestMethod]
        //    public void Index_GetClientIpReturnsOneIp_LogsZeError()
        //    {
        //        var controler = new LoginController_GetClientIpReturnsOneIp();

        //        controler.Index();

        //        LogManager.Verify(x => x.LogErrorWebServicesBus2(It.Is<Exception>(e => e.Message.Contains("The specified IP address was incorrectly formatted")),
        //            It.IsAny<string>(),
        //            It.IsAny<string>(),
        //            It.IsAny<string>()), Times.Never);
        //    }
        }
    }
}
