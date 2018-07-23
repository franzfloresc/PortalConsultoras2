using Microsoft.VisualStudio.TestTools.UnitTesting;
using Moq;
using MvcContrib.TestHelper;
using Portal.Consultoras.Common;
using Portal.Consultoras.Web.Controllers;
using Portal.Consultoras.Web.Models;
using System;
using System.Reflection;
using System.Web.Mvc;
using Portal.Consultoras.Web.LogManager;
using Portal.Consultoras.Web.SessionManager;
using Portal.Consultoras.Web.ServiceOferta;
using System.Collections.Generic;
using Portal.Consultoras.Web.Models.AutoMapper;

namespace Portal.Consultoras.Web.UnitTest.Controllers
{
    [TestClass]
    public class RevistaDigitalControllerUnitTest
    {
        RevistaDigitalController controller;

        [TestClass]
        public class RDObtenerProductos : Base
        {
            [ClassInitialize()]
            public static void Class_Initialize(TestContext context)
            {
                AutoMapperConfiguration.Configure();
            }

            class RevistaDigitalControllerStub001 : RevistaDigitalController
            {
                public RevistaDigitalControllerStub001(ISessionManager sessionManager, ILogManager logManager) 
                    : base(sessionManager, logManager)
                {
                    userData = new UsuarioModel
                    {
                        CampaniaID=201808,
                        NroCampanias=18
                    };
                }

                //protected override List<BEEstrategia> ConsultarEstrategiasPorTipo(string tipo, int campaniaId = 0)
                //{
                //    var estrategias =new List<BEEstrategia>();

                //    if (campaniaId == 201808 && tipo == Constantes.TipoEstrategiaCodigo.OfertaParaTi)
                //    {
                //        estrategias.Add(new BEEstrategia
                //        {
                //            EstrategiaID = 1,
                //            CampaniaID= 201808,
                //            CodigoEstrategia = "2001",
                //            CodigoTipoEstrategia = Constantes.TipoEstrategiaCodigo.OfertaParaTi,
                //            DescripcionCUV2=string.Empty,
                //            EstrategiaDetalle = new BEEstrategiaDetalle { },
                //            TipoEstrategia = new BETipoEstrategia { Codigo = Constantes.TipoEstrategiaCodigo.OfertaParaTi }
                //        });
                //        estrategias.Add(new BEEstrategia
                //        {
                //            EstrategiaID = 2,
                //            CampaniaID = 201808,
                //            CodigoEstrategia = "2001",
                //            CodigoTipoEstrategia = Constantes.TipoEstrategiaCodigo.OfertaParaTi,
                //            DescripcionCUV2 = string.Empty,
                //            EstrategiaDetalle = new BEEstrategiaDetalle { },
                //            TipoEstrategia = new BETipoEstrategia { Codigo = Constantes.TipoEstrategiaCodigo.OfertaParaTi }
                //        });
                //    }

                //    if (campaniaId == 201808 && tipo == Constantes.TipoEstrategiaCodigo.RevistaDigital)
                //    {
                //        estrategias.Add(new BEEstrategia
                //        {
                //            EstrategiaID = 11,
                //            CampaniaID = 201808,
                //            CodigoEstrategia = "2001",
                //            CodigoTipoEstrategia = Constantes.TipoEstrategiaCodigo.OfertasParaMi,
                //            DescripcionCUV2 = string.Empty,
                //            EstrategiaDetalle = new BEEstrategiaDetalle { },
                //            TipoEstrategia = new BETipoEstrategia { Codigo = Constantes.TipoEstrategiaCodigo.OfertasParaMi },
                //            FlagRevista = Constantes.FlagRevista.Valor0
                //        });
                //        estrategias.Add(new BEEstrategia
                //        {
                //            EstrategiaID = 12,
                //            CampaniaID = 201808,
                //            CodigoEstrategia = "2001",
                //            CodigoTipoEstrategia = Constantes.TipoEstrategiaCodigo.PackAltoDesembolso,
                //            DescripcionCUV2 = string.Empty,
                //            EstrategiaDetalle = new BEEstrategiaDetalle { },
                //            TipoEstrategia = new BETipoEstrategia { Codigo = Constantes.TipoEstrategiaCodigo.PackAltoDesembolso },
                //            FlagRevista = Constantes.FlagRevista.Valor0
                //        });
                //        estrategias.Add(new BEEstrategia
                //        {
                //            EstrategiaID = 17,
                //            CampaniaID = 201808,
                //            CodigoEstrategia = "2001",
                //            CodigoTipoEstrategia = Constantes.TipoEstrategiaCodigo.OfertasParaMi,
                //            DescripcionCUV2 = string.Empty,
                //            EstrategiaDetalle = new BEEstrategiaDetalle { },
                //            TipoEstrategia = new BETipoEstrategia { Codigo = Constantes.TipoEstrategiaCodigo.OfertasParaMi },
                //            FlagRevista = Constantes.FlagRevista.Valor1
                //        });
                //        estrategias.Add(new BEEstrategia
                //        {
                //            EstrategiaID = 18,
                //            CampaniaID = 201808,
                //            CodigoEstrategia = "2001",
                //            CodigoTipoEstrategia = Constantes.TipoEstrategiaCodigo.PackAltoDesembolso,
                //            DescripcionCUV2 = string.Empty,
                //            EstrategiaDetalle = new BEEstrategiaDetalle { },
                //            TipoEstrategia = new BETipoEstrategia { Codigo = Constantes.TipoEstrategiaCodigo.PackAltoDesembolso },
                //            FlagRevista = Constantes.FlagRevista.Valor1
                //        });
                //        estrategias.Add(new BEEstrategia
                //        {
                //            EstrategiaID = 13,
                //            CampaniaID = 201808,
                //            CodigoEstrategia = "2001",
                //            CodigoTipoEstrategia = Constantes.TipoEstrategiaCodigo.OfertasParaMi,
                //            DescripcionCUV2 = string.Empty,
                //            EstrategiaDetalle = new BEEstrategiaDetalle { },
                //            TipoEstrategia = new BETipoEstrategia { Codigo = Constantes.TipoEstrategiaCodigo.OfertasParaMi },
                //            FlagRevista = Constantes.FlagRevista.Valor2
                //        });
                //        estrategias.Add(new BEEstrategia
                //        {
                //            EstrategiaID = 14,
                //            CampaniaID = 201808,
                //            CodigoEstrategia = "2001",
                //            CodigoTipoEstrategia = Constantes.TipoEstrategiaCodigo.PackAltoDesembolso,
                //            DescripcionCUV2 = string.Empty,
                //            EstrategiaDetalle = new BEEstrategiaDetalle { },
                //            TipoEstrategia = new BETipoEstrategia { Codigo = Constantes.TipoEstrategiaCodigo.PackAltoDesembolso },
                //            FlagRevista = Constantes.FlagRevista.Valor2
                //        });
                //    }

                //    if (campaniaId == 201808 && tipo == Constantes.TipoEstrategiaCodigo.Lanzamiento)
                //    {
                //        estrategias.Add(new BEEstrategia
                //        {
                //            EstrategiaID = 21,
                //            CampaniaID = 201808,
                //            CodigoEstrategia = "2001",
                //            CodigoTipoEstrategia = Constantes.TipoEstrategiaCodigo.Lanzamiento,
                //            DescripcionCUV2 = string.Empty,
                //            EstrategiaDetalle = new BEEstrategiaDetalle { },
                //            TipoEstrategia = new BETipoEstrategia { Codigo = Constantes.TipoEstrategiaCodigo.Lanzamiento }
                //        });
                //        estrategias.Add(new BEEstrategia
                //        {
                //            EstrategiaID = 22,
                //            CampaniaID = 201808,
                //            CodigoEstrategia = "2001",
                //            CodigoTipoEstrategia = Constantes.TipoEstrategiaCodigo.Lanzamiento,
                //            DescripcionCUV2 = string.Empty,
                //            EstrategiaDetalle = new BEEstrategiaDetalle { },
                //            TipoEstrategia = new BETipoEstrategia { Codigo = Constantes.TipoEstrategiaCodigo.Lanzamiento }
                //        });
                //    }

                //    return estrategias;
                //}
            }

            RevistaDigitalController controller;

            private RevistaDigitalController GetRevistaController()
            {
                return new RevistaDigitalControllerStub001(sessionManager.Object, logManager.Object);
            }

            [TestInitialize]
            public override void Test_Initialize()
            {
                base.Test_Initialize();
                controller = GetRevistaController();
            }

            [TestCleanup]
            public override void Test_Cleanup()
            {
                base.Test_Cleanup();
                controller = null;
            }

            //[TestMethod]
            //public void RDObtenerProductos_BusquedaProductoModelEsNulo_EscribeEnLog()
            //{
            //    //Act

            //    //Arrange
            //    controller.RDObtenerProductos(null);

            //    //Assert
            //    logManager.Verify(x => x.LogErrorWebServicesBusWrap(
            //        It.Is<Exception>(e => e.Message.Contains("model no puede ser nulo")),
            //        It.IsAny<string>(),
            //        It.IsAny<string>(),
            //        It.Is<string>(str => str.Contains("RevistaDigitalController.RDObtenerProductos"))
            //        ));
            //}

            //[TestMethod]
            //public void RDObtenerProductos_NoTieneRevistaDigital_DevuelveListaEnBlanco()
            //{
            //    //Act
            //    controller.RevistaDigital = new RevistaDigitalModel { TieneRDC = false };

            //    //Arrange
            //    dynamic result = controller.RDObtenerProductos(new BusquedaProductoModel { }).Data;

            //    //Assert
            //    Assert.AreEqual(false, result.success, "success");
            //    Assert.AreEqual(string.Empty, result.message, "message");
            //    Assert.AreEqual(0, result.lista.Count, "lista");
            //    Assert.AreEqual(0, result.cantidadTotal, "cantidadTotal");
            //    Assert.AreEqual(0, result.cantidad, "cantidad");
            //}

            //[TestMethod]
            //public void RDObtenerProductos_TieneRevistaDigitalReducidaYNotieneActivoMdo_DevuelveListaEstrategiasOpt()
            //{
            //    //Arrange
            //    controller.RevistaDigital = new RevistaDigitalModel { TieneRDC = true, TieneRDCR = true, ActivoMdo = false };
            //    var busquedaProductoModel = new BusquedaProductoModel { CampaniaID = 201808, IsMobile = false };

            //    //Act
            //    dynamic result = controller.RDObtenerProductos(busquedaProductoModel).Data;

            //    //Assert
            //    Assert.AreEqual(true, result.success, "success");
            //    Assert.AreEqual(2, result.lista.Count, "lista : Opt");
            //    Assert.AreEqual(6, result.listaPerdio.Count, "listPerdio : OPM + PAD (Todos los Flags)");
            //    Assert.AreEqual(2, result.cantidadTotal, "cantidadTotal");
            //    Assert.AreEqual(2, result.cantidad, "cantidad");
            //    Assert.AreEqual(201808, result.campaniaId, "campaniaId");
            //}

            //[TestMethod]
            //public void RDObtenerProductos_TieneRevistaDigitalReducidaYTieneActivoMdo_DevuelveListaEstrategiasRevistaDigitalConFlag0()
            //{
            //    //Arrange
            //    controller.RevistaDigital = new RevistaDigitalModel { TieneRDC = true, TieneRDCR = true, ActivoMdo = true };
            //    var busquedaProductoModel = new BusquedaProductoModel { CampaniaID = 201808, IsMobile = false };

            //    //Act
            //    dynamic result = controller.RDObtenerProductos(busquedaProductoModel).Data;

            //    //Assert
            //    Assert.AreEqual(true, result.success, "success");
            //    Assert.AreEqual(2, result.lista.Count, "lista : OPM + PAD (Flag 0)");
            //    Assert.AreEqual(4, result.listaPerdio.Count, "listPerdio : OPM + PAD (Flag 1 y 2)");
            //    Assert.AreEqual(2, result.cantidadTotal, "cantidadTotal");
            //    Assert.AreEqual(2, result.cantidad, "cantidad");
            //    Assert.AreEqual(201808, result.campaniaId, "campaniaId");
            //}

            //[TestMethod]
            //public void RDObtenerProductos_TieneRevistaDigitalCompletaYEsNoActivaYNotieneActivoMdo_DevuelveListaEstrategiasRevistaDigital()
            //{
            //    //Arrange
            //    controller.RevistaDigital = new RevistaDigitalModel { TieneRDC = true, EsActiva=false, ActivoMdo = false };
            //    var busquedaProductoModel = new BusquedaProductoModel { CampaniaID = 201808, IsMobile = false };

            //    //Act
            //    dynamic result = controller.RDObtenerProductos(busquedaProductoModel).Data;

            //    //Assert
            //    Assert.AreEqual(true, result.success, "success");
            //    Assert.AreEqual(2, result.lista.Count, "lista : OPT");
            //    Assert.AreEqual(6, result.listaPerdio.Count, "listPerdio: OPM + PAD (Flag 0,1,2)");
            //    Assert.AreEqual(2, result.cantidadTotal, "cantidadTotal");
            //    Assert.AreEqual(2, result.cantidad, "cantidad");
            //    Assert.AreEqual(201808, result.campaniaId, "campaniaId");
            //}

            //[TestMethod]
            //public void RDObtenerProductos_TieneRevistaDigitalCompletaYEsNoActivaYTieneActivoMdo_DevuelveListaEstrategiasRevistaDigital()
            //{
            //    //Arrange
            //    controller.RevistaDigital = new RevistaDigitalModel { TieneRDC = true, EsActiva = false, ActivoMdo = true };
            //    var busquedaProductoModel = new BusquedaProductoModel { CampaniaID = 201808, IsMobile = false };

            //    //Act
            //    dynamic result = controller.RDObtenerProductos(busquedaProductoModel).Data;

            //    //Assert
            //    Assert.AreEqual(true, result.success, "success");
            //    Assert.AreEqual(2, result.lista.Count, "lista : PM + PAD (Flag 0)");
            //    Assert.AreEqual(4, result.listaPerdio.Count, "listPerdio: OPM + PAD (Flag 1,2)");
            //    Assert.AreEqual(2, result.cantidadTotal, "cantidadTotal");
            //    Assert.AreEqual(2, result.cantidad, "cantidad");
            //    Assert.AreEqual(201808, result.campaniaId, "campaniaId");
            //}

            //[TestMethod]
            //public void RDObtenerProductos_TieneRevistaDigitalCompletaYEsActivaYNoTieneActivoMdo_DevuelveListaEstrategiasRevistaDigital()
            //{
            //    //Arrange
            //    controller.RevistaDigital = new RevistaDigitalModel { TieneRDC = true, EsActiva = true, ActivoMdo = false };
            //    var busquedaProductoModel = new BusquedaProductoModel { CampaniaID = 201808, IsMobile = false };

            //    //Act
            //    dynamic result = controller.RDObtenerProductos(busquedaProductoModel).Data;

            //    //Assert
            //    Assert.AreEqual(true, result.success, "success");
            //    Assert.AreEqual(6, result.lista.Count, "lista : PM + PAD (Todos)");
            //    Assert.AreEqual(0, result.listaPerdio.Count, "listPerdio");
            //    Assert.AreEqual(6, result.cantidadTotal, "cantidadTotal");
            //    Assert.AreEqual(6, result.cantidad, "cantidad");
            //    Assert.AreEqual(201808, result.campaniaId, "campaniaId");
            //}

            //[TestMethod]
            //public void RDObtenerProductos_TieneRevistaDigitalCompletaYEsActivaYTieneActivoMdo_DevuelveListaEstrategiasRevistaDigital()
            //{
            //    //Arrange
            //    controller.RevistaDigital = new RevistaDigitalModel { TieneRDC = true, EsActiva = true, ActivoMdo = true };
            //    var busquedaProductoModel = new BusquedaProductoModel { CampaniaID = 201808, IsMobile = false };

            //    //Act
            //    dynamic result = controller.RDObtenerProductos(busquedaProductoModel).Data;

            //    //Assert
            //    Assert.AreEqual(true, result.success, "success");
            //    Assert.AreEqual(6, result.lista.Count, "lista : PM + PAD (Todos)");
            //    Assert.AreEqual(0, result.listaPerdio.Count, "listPerdio");
            //    Assert.AreEqual(6, result.cantidadTotal, "cantidadTotal");
            //    Assert.AreEqual(6, result.cantidad, "cantidad");
            //    Assert.AreEqual(201808, result.campaniaId, "campaniaId");
            //}
        }
    }
}
