﻿using Microsoft.VisualStudio.TestTools.UnitTesting;
using Moq;
using Portal.Consultoras.Web.Controllers;
using Portal.Consultoras.Web.Models;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Web.Mvc;

namespace Portal.Consultoras.Web.UnitTest.Controllers
{
    [TestClass]
    public class BaseLanzamientosControllerUnitTest
    {
        BaseLanzamientosController controller;

        [TestClass]
        public class Detalle : Base
        {
            BaseLanzamientosController controller;

            public virtual BaseLanzamientosController GetLanzamientosController()
            {
                return new BaseLanzamientosController(sessionManager.Object, logManager.Object);
            }

            [TestInitialize]
            public override void Test_Initialize()
            {
                base.Test_Initialize();
                controller = GetLanzamientosController();
            }

            [TestCleanup]
            public override void Test_Cleanup()
            {
                base.Test_Cleanup();
                controller.Dispose();
            }

            [TestMethod]
            public void Detalle_RevistaDigitalEsNula_DebeEscribirEnLog()
            {
                controller.RevistaDigital = null;
                ActionResult result;

                try
                {
                    result = controller.Detalle(string.Empty, 0);
                }
                catch
                {
                }

                logManager.Verify(x => x.LogErrorWebServicesBusWrap(
                    It.Is<Exception>(e=> e.Message.Contains("revistaDigital no puede ser nulo.")),
                    It.IsAny<string>(),
                    It.IsAny<string>(),
                    It.Is<string>(str => str.Contains("BaseLanzamientosController.Detalle"))
                    ));
            }

            [TestMethod]
            [ExpectedException(typeof(Exception))]
            public void Detalle_RevistaDigitalEsNula_DebeLanzarExcepcion()
            {
                controller.RevistaDigital = null;

                var result = controller.Detalle(string.Empty, 0);
            }

            [TestMethod]
            public void Detalle_ConsultoraNoTieneRevistaDigitalYEsNoActiva_DebeRedireccionarABienvenida()
            {
                controller.RevistaDigital = new RevistaDigitalModel
                {
                    TieneRDC = false,
                    EsActiva = false
                };

                var result = controller.Detalle(string.Empty, 0) as RedirectToRouteResult;

                Assert.AreEqual("Bienvenida", result.RouteValues["controller"]);
                Assert.AreEqual("Index", result.RouteValues["action"]);
            }

            [TestMethod]
            public void Detalle_ConsultoraTieneRevistaDigitalYEsActivaYProductoTemporalEsNulo_DebeRedireccionarAOfertas()
            {
                sessionManager.Setup(x => x.ProductoTemporal).Returns((EstrategiaPersonalizadaProductoModel)null);
                controller.RevistaDigital = new RevistaDigitalModel
                {
                    TieneRDC = true,
                    EsActiva = true
                };

                var result = controller.Detalle(string.Empty, 0) as RedirectToRouteResult;

                Assert.AreEqual("Ofertas", result.RouteValues["controller"]);
                Assert.AreEqual("Index", result.RouteValues["action"]);
            }

            [TestMethod]
            public void Detalle_ConsultoraTieneRevistaDigitalYEsActivaProductoTemporalIdEsCero_DebeRedireccionarAOfertas()
            {
                sessionManager
                    .Setup(x => x.ProductoTemporal)
                    .Returns(new EstrategiaPersonalizadaProductoModel { });
                controller.RevistaDigital = new RevistaDigitalModel
                {
                    TieneRDC = true,
                    EsActiva = true
                };

                var result = controller.Detalle(string.Empty, 0) as RedirectToRouteResult;

                Assert.AreEqual("Ofertas", result.RouteValues["controller"]);
                Assert.AreEqual("Index", result.RouteValues["action"]);
            }

            [DataTestMethod]
            [DataRow(-1, DisplayName = "Menor a campania de usuario")]
            [DataRow(3, DisplayName = "Mayor a campania de usuario")]
            public void Detalle_ConsultoraTieneRevistaDigitalYEsActivaProductoTemporalTieneCampaniaInvalida_DebeRedireccionarAOfertas(int campaniaId)
            {
                sessionManager
                    .Setup(x => x.ProductoTemporal)
                    .Returns(new EstrategiaPersonalizadaProductoModel { EstrategiaID = 1, CampaniaID = campaniaId });
                controller.RevistaDigital = new RevistaDigitalModel
                {
                    TieneRDC = true,
                    EsActiva = true
                };

                var result = controller.Detalle(string.Empty, 0) as RedirectToRouteResult;

                Assert.AreEqual("Ofertas", result.RouteValues["controller"]);
                Assert.AreEqual("Index", result.RouteValues["action"]);
            }

            [TestMethod]
            public void Detalle_ConsultoraTieneRevistaDigitalYEsActivaCuvDelUrlNoCoincideConProductoTemporal_DebeRedireccionarAOfertas()
            {
                sessionManager
                    .Setup(x => x.ProductoTemporal)
                    .Returns(new EstrategiaPersonalizadaProductoModel { EstrategiaID = 1,CUV2 = "99988" });
                controller.RevistaDigital = new RevistaDigitalModel
                {
                    TieneRDC = true,
                    EsActiva = true
                };

                var result = controller.Detalle(string.Empty, 0) as RedirectToRouteResult;

                Assert.AreEqual("Ofertas", result.RouteValues["controller"]);
                Assert.AreEqual("Index", result.RouteValues["action"]);
            }

            [TestMethod]
            public void Detalle_ConsultoraTieneRevistaDigitalYEsActivaCampaniaIdDelUrlNoCoincideConProductoTemporal_DebeRedireccionarAOfertas()
            {
                sessionManager
                    .Setup(x => x.ProductoTemporal)
                    .Returns(new EstrategiaPersonalizadaProductoModel { EstrategiaID = 1, CUV2 = "99988", CampaniaID = 0 });
                controller.RevistaDigital = new RevistaDigitalModel
                {
                    TieneRDC = true,
                    EsActiva = true
                };

                var result = controller.Detalle("99988", 1) as RedirectToRouteResult;

                Assert.AreEqual("Ofertas", result.RouteValues["controller"]);
                Assert.AreEqual("Index", result.RouteValues["action"]);
            }
        }
    }
}