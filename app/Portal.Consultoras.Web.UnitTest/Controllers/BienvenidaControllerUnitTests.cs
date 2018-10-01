using Microsoft.VisualStudio.TestTools.UnitTesting;
using Moq;
using Portal.Consultoras.Common;
using Portal.Consultoras.Web.Controllers;
using Portal.Consultoras.Web.LogManager;
using Portal.Consultoras.Web.Models;
using Portal.Consultoras.Web.SessionManager;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Portal.Consultoras.Web.UnitTest.Controllers
{
    [TestClass]
    public class BienvenidaControllerUnitTests
    {
        [TestClass]
        public class GetPartialSectionBptModel : Base
        {
            //[TestMethod]
            //public void GetPartialSectionBptModel_RevistaDigitalModelEsNulo_EscribeEnLog()
            //{
            //    var controller = new BienvenidaController(logManager.Object);
                

            //    var result = controller.GetPartialSectionBptModel(null);

            //    Assert.IsNotNull(result);
            //    logManager.Verify(x => x.LogErrorWebServicesBusWrap(
            //        It.Is<Exception>(e => e.Message.Contains("revistaDigital") && e.Message.Contains("no puede ser nulo")),
            //        It.IsAny<string>(),
            //        It.IsAny<string>(),
            //        It.Is<string>(s => s.Contains("LoginController.GetPartialSectionBptModel"))),
            //        Times.AtLeastOnce);
            //}




            [TestMethod]
            public void GetPartialSectionBptModel_RevistaDigitalModelNoTieneDBienvenidaInscritaActiva_ResultConfiguracionPaisDatosIsNotNull()
            {
                var controller = new BienvenidaController(LogManager.Object);
                var revistaDigitalModel = new RevistaDigitalModel
                {
                    TieneRDC = true,
                    EsActiva = true,
                    EsSuscrita = true,
                    ConfiguracionPaisDatos = new List<ConfiguracionPaisDatosModel>
                    {
                        new ConfiguracionPaisDatosModel
                        {
                            Codigo = Constantes.ConfiguracionPaisDatos.RD.DBienvenidaInscritaActiva
                        }
                    }
                };

                var result = controller.GetPartialSectionBptModel(revistaDigitalModel);


                Assert.IsNotNull(result.ConfiguracionPaisDatos);

            }

            [TestMethod]
            public void GetPartialSectionBptModel_RevistaDigitalModelTieneDBienvenidaInscritaActiva_ResultTieneDBienvenidaInscritaActiva()
            {
                var controller = new BienvenidaController(LogManager.Object);
                var revistaDigitalModel = new RevistaDigitalModel
                {
                    TieneRDC = true,
                    EsActiva = true,
                    EsSuscrita = true,
                    ConfiguracionPaisDatos = new List<ConfiguracionPaisDatosModel>
                    {
                        new ConfiguracionPaisDatosModel
                        {
                            Codigo = Constantes.ConfiguracionPaisDatos.RD.DBienvenidaInscritaActiva
                        }
                    }
                };

                var result = controller.GetPartialSectionBptModel(revistaDigitalModel);

                Assert.AreEqual(
                    revistaDigitalModel.ConfiguracionPaisDatos.First(x => x.Codigo == Constantes.ConfiguracionPaisDatos.RD.DBienvenidaInscritaActiva), 
                    result.ConfiguracionPaisDatos
                    );

            }

            [TestMethod]
            public void GetPartialSectionBptModel_RevistaDigitalModelNoTieneDBienvenidaNoInscritaActiva_ResultConfiguracionPaisDatosIsNotNull()
            {
                var controller = new BienvenidaController(LogManager.Object);
                var revistaDigitalModel = new RevistaDigitalModel
                {
                    TieneRDC = true,
                    EsActiva = true,
                    EsSuscrita = false,
                    ConfiguracionPaisDatos = new List<ConfiguracionPaisDatosModel> { }
                };

                var result = controller.GetPartialSectionBptModel(revistaDigitalModel);


                Assert.IsNotNull(result.ConfiguracionPaisDatos);
                Assert.IsNull(result.ConfiguracionPaisDatos.Codigo);

            }

            [TestMethod]
            public void GetPartialSectionBptModel_RevistaDigitalModelTieneDBienvenidaNoInscritaActiva_ResultTieneDBienvenidaInscritaActiva()
            {
                var controller = new BienvenidaController(LogManager.Object);
                var revistaDigitalModel = new RevistaDigitalModel
                {
                    TieneRDC = true,
                    EsActiva = true,
                    EsSuscrita = false,
                    ConfiguracionPaisDatos = new List<ConfiguracionPaisDatosModel>
                    {
                        new ConfiguracionPaisDatosModel
                        {
                            Codigo = Constantes.ConfiguracionPaisDatos.RD.DBienvenidaNoInscritaActiva
                        }
                    }
                };

                var result = controller.GetPartialSectionBptModel(revistaDigitalModel);


                Assert.IsNotNull(result.ConfiguracionPaisDatos);
                Assert.AreEqual(result.ConfiguracionPaisDatos.Codigo, Constantes.ConfiguracionPaisDatos.RD.DBienvenidaNoInscritaActiva);
            }

            [TestMethod]
            public void GetPartialSectionBptModel_RevistaDigitalModelNoTieneDBienvenidaInscritaNoActiva_ResultConfiguracionPaisDatosIsNotNull()
            {
                var controller = new BienvenidaController(LogManager.Object);
                var revistaDigitalModel = new RevistaDigitalModel
                {
                    TieneRDC = true,
                    EsActiva = false,
                    EsSuscrita = true,
                    ConfiguracionPaisDatos = new List<ConfiguracionPaisDatosModel> { }
                };

                var result = controller.GetPartialSectionBptModel(revistaDigitalModel);


                Assert.IsNotNull(result.ConfiguracionPaisDatos);
                Assert.IsNull(result.ConfiguracionPaisDatos.Codigo);

            }

            [TestMethod]
            public void GetPartialSectionBptModel_RevistaDigitalModelTieneDBienvenidaInscritaNoActiva_ResultTieneDBienvenidaInscritaNoActiva()
            {
                var controller = new BienvenidaController(LogManager.Object);
                var revistaDigitalModel = new RevistaDigitalModel
                {
                    TieneRDC = true,
                    EsActiva = false,
                    EsSuscrita = true,
                    ConfiguracionPaisDatos = new List<ConfiguracionPaisDatosModel>
                    {
                        new ConfiguracionPaisDatosModel
                        {
                            Codigo = Constantes.ConfiguracionPaisDatos.RD.DBienvenidaInscritaNoActiva
                        }
                    }
                };

                var result = controller.GetPartialSectionBptModel(revistaDigitalModel);


                Assert.IsNotNull(result.ConfiguracionPaisDatos);
                Assert.AreEqual(result.ConfiguracionPaisDatos.Codigo, Constantes.ConfiguracionPaisDatos.RD.DBienvenidaInscritaNoActiva);
            }

            [TestMethod]
            public void GetPartialSectionBptModel_RevistaDigitalModelNoTieneDBienvenidaNoInscritaNoActiva_ResultConfiguracionPaisDatosIsNotNull()
            {
                var controller = new BienvenidaController(LogManager.Object);
                var revistaDigitalModel = new RevistaDigitalModel
                {
                    TieneRDC = true,
                    EsActiva = false,
                    EsSuscrita = false,
                    ConfiguracionPaisDatos = new List<ConfiguracionPaisDatosModel> { }
                };

                var result = controller.GetPartialSectionBptModel(revistaDigitalModel);


                Assert.IsNotNull(result.ConfiguracionPaisDatos);
                Assert.IsNull(result.ConfiguracionPaisDatos.Codigo);

            }

            [TestMethod]
            public void GetPartialSectionBptModel_RevistaDigitalModelTieneDBienvenidaNoInscritaNoActiva_ResultTieneDBienvenidaNoInscritaNoActiva()
            {
                var controller = new BienvenidaController(LogManager.Object);
                var revistaDigitalModel = new RevistaDigitalModel
                {
                    TieneRDC = true,
                    EsActiva = false,
                    EsSuscrita = false,
                    ConfiguracionPaisDatos = new List<ConfiguracionPaisDatosModel>
                    {
                        new ConfiguracionPaisDatosModel
                        {
                            Codigo = Constantes.ConfiguracionPaisDatos.RD.DBienvenidaNoInscritaNoActiva
                        }
                    }
                };

                var result = controller.GetPartialSectionBptModel(revistaDigitalModel);


                Assert.IsNotNull(result.ConfiguracionPaisDatos);
                Assert.AreEqual(result.ConfiguracionPaisDatos.Codigo, Constantes.ConfiguracionPaisDatos.RD.DBienvenidaNoInscritaNoActiva);
            }
            

            [TestMethod]
            public void GetPartialSectionBptModel_RevistaDigitalModelNoTieneDBienvenidaIntriga_ResultConfiguracionPaisDatosIsNotNull()
            {
                var controller = new BienvenidaController(LogManager.Object);
                var revistaDigitalModel = new RevistaDigitalModel
                {
                    TieneRDI = true,
                    ConfiguracionPaisDatos = new List<ConfiguracionPaisDatosModel> { }
                };

                var result = controller.GetPartialSectionBptModel(revistaDigitalModel);


                Assert.IsNotNull(result.ConfiguracionPaisDatos);
                Assert.IsNull(result.ConfiguracionPaisDatos.Codigo);

            }

            [TestMethod]
            public void GetPartialSectionBptModel_RevistaDigitalModelTieneDBienvenidaIntriga_ResultTieneDBienvenidaIntriga()
            {
                var controller = new BienvenidaController(LogManager.Object);
                var revistaDigitalModel = new RevistaDigitalModel
                {
                    TieneRDI = true,
                    ConfiguracionPaisDatos = new List<ConfiguracionPaisDatosModel>
                    {
                        new ConfiguracionPaisDatosModel
                        {
                            Codigo = Constantes.ConfiguracionPaisDatos.RDI.DBienvenidaIntriga
                        }
                    }
                };

                var result = controller.GetPartialSectionBptModel(revistaDigitalModel);


                Assert.IsNotNull(result.ConfiguracionPaisDatos);
                Assert.AreEqual(result.ConfiguracionPaisDatos.Codigo, Constantes.ConfiguracionPaisDatos.RDI.DBienvenidaIntriga);
            }
        }
    }
}

