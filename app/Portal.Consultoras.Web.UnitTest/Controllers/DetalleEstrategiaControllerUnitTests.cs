using System;
using System.Collections.Generic;
using System.Web.Mvc;
using Microsoft.VisualStudio.TestTools.UnitTesting;
using Moq;
using MvcContrib.TestHelper;
using Portal.Consultoras.Common;
using Portal.Consultoras.Web.Controllers;
using Portal.Consultoras.Web.Models;
using Portal.Consultoras.Web.Providers;
using Portal.Consultoras.Web.UnitTest.Extensions;
using Newtonsoft.Json;
using Portal.Consultoras.Web.ServicePedido;
using System.Web.Script.Serialization;

namespace Portal.Consultoras.Web.UnitTest.Controllers
{
    [TestClass]
    public class DetalleEstrategiaControllerUnitTests 
    {
        [TestClass]
        public class Ficha : BaseViewControllerUnitTests.Ficha
        {
            [TestInitialize]
            public override void Test_Initialize()
            {
                base.Test_Initialize();
            }

            [TestCleanup]
            public override void Test_Cleanup()
            {
                base.Test_Cleanup();
            }

            protected override BaseViewController CreateController()
            {
                return new DetalleEstrategiaController(SessionManager.Object, LogManager.Object, OfertaPersonalizadaProvider.Object);
            }

            [TestMethod]
            [DataRow((string)null, DisplayName = "palanca es nula")]
            [DataRow("", DisplayName = "palanca es vacía")]
            public override void Ficha_parameterPalancaIsNotValid_RedirectsToOfertas(string palanca)
            {
                base.Ficha_parameterPalancaIsNotValid_RedirectsToOfertas(palanca);
            }

            [TestMethod]
            [DataRow(201001, DisplayName = "no es campania actual,campania = 201001")]
            [DataRow(201101, DisplayName = "no es campania actual,campania = 201001")]
            public override void Ficha_parameterCampaniaIdIsNotValid_RedirectsToOfertas(int campaniaId)
            {
                base.Ficha_parameterCampaniaIdIsNotValid_RedirectsToOfertas(campaniaId);
            }

            [TestMethod]
            [DataRow((string)null, DisplayName = "cuv es nulo")]
            [DataRow("", DisplayName = "cuv es vacía")]
            public override void Ficha_parameterCuvIsNotValid_RedirectsToOfertas(string cuv)
            {
                base.Ficha_parameterCuvIsNotValid_RedirectsToOfertas(cuv);
            }

            [TestMethod]
            [DataRow(Constantes.NombrePalanca.GuiaDeNegocioDigitalizada, DisplayName = "no tiene GuiaDeNegocioDigitalizada")]
            [DataRow(Constantes.NombrePalanca.HerramientasVenta, DisplayName = "no tiene HerramientasVenta")]
            [DataRow(Constantes.NombrePalanca.Incentivos, DisplayName = "no tiene Incentivos")]
            [DataRow(Constantes.NombrePalanca.IncentivosProgramaNuevas, DisplayName = "no tiene IncentivosProgramaNuevas")]
            [DataRow(Constantes.NombrePalanca.Lanzamiento, DisplayName = "no tiene Lanzamiento")]
            [DataRow(Constantes.NombrePalanca.LosMasVendidos, DisplayName = "no tiene LosMasVendidos")]
            [DataRow(Constantes.NombrePalanca.NotParticipaProgramaNuevas, DisplayName = "no tiene GuiaDeNegocioDigitalizada")]
            [DataRow(Constantes.NombrePalanca.OfertaDelDia, DisplayName = "no tiene OfertaDelDia")]
            [DataRow(Constantes.NombrePalanca.OfertaWeb, DisplayName = "no tiene OfertaWeb")]
            [DataRow(Constantes.NombrePalanca.OfertaParaTi, DisplayName = "no tiene OfertaParaTi")]
            [DataRow(Constantes.NombrePalanca.OfertasParaMi, DisplayName = "no tiene OfertasParaMi")]
            [DataRow(Constantes.NombrePalanca.PackAltoDesembolso, DisplayName = "no tiene PackAltoDesembolso")]
            [DataRow(Constantes.NombrePalanca.ParticipaProgramaNuevas, DisplayName = "no tiene ParticipaProgramaNuevas")]
            [DataRow(Constantes.NombrePalanca.PackNuevas, DisplayName = "no tiene PackNuevas")]
            [DataRow(Constantes.NombrePalanca.ProgramaNuevasRegalo, DisplayName = "no tiene ProgramaNuevasRegalo")]
            [DataRow(Constantes.NombrePalanca.RevistaDigital, DisplayName = "no tiene RevistaDigital")]
            [DataRow(Constantes.NombrePalanca.ShowRoom, DisplayName = "no tiene ShowRoom")]
            public override void Ficha_ConsultoraDoNotHavePalanca_RedirectsToOfertas(string nombrePalanca)
            {
                base.Ficha_ConsultoraDoNotHavePalanca_RedirectsToOfertas(nombrePalanca);
            }

            [TestMethod]
            [DataRow(Constantes.NombrePalanca.ShowRoom, Constantes.ConfiguracionPais.ShowRoom, DisplayName = "producto ShowRoom no existe en sesion")]
            [DataRow(Constantes.NombrePalanca.OfertaDelDia, Constantes.ConfiguracionPais.OfertaDelDia, DisplayName = "producto OfertaDelDia no existe en sesion")]
            [DataRow(Constantes.NombrePalanca.PackNuevas, (string)null, DisplayName = "producto PackNuevas no existe en sesion")]
            public override void Ficha_ConsultoraNoTieneProductoEnSession_RedirectsToOfertas(string nombrePalanca, string configuracionPaisCodigo)
            {
                base.Ficha_ConsultoraNoTieneProductoEnSession_RedirectsToOfertas(nombrePalanca, configuracionPaisCodigo);
            }
        }

        [TestClass]
        public class ObtenerComponentes : Base
        {
            protected DetalleEstrategiaController Controller;
            protected Mock<EstrategiaComponenteProvider> EstrategiaComponenteProvider;
            protected const int CampaniaIdActual = 201801;

            [TestInitialize]
            public override void Test_Initialize()
            {
                base.Test_Initialize();
                EstrategiaComponenteProvider = GetOfertaPersonalizadaProvider();
                Controller = CreateController();
                ConfigureUserDataWithCampaniaActual(CampaniaIdActual);
            }

            [TestCleanup]
            public override void Test_Cleanup()
            {
                base.Test_Cleanup();
                Controller = null;
                EstrategiaComponenteProvider = null;
            }

            protected virtual Mock<EstrategiaComponenteProvider> GetOfertaPersonalizadaProvider()
            {
                EstrategiaComponenteProvider = new Mock<EstrategiaComponenteProvider>
                {
                    CallBase = true
                };
                EstrategiaComponenteProvider.Setup(x => x.SessionManager).Returns(SessionManager.Object);
                return EstrategiaComponenteProvider;
            }

            protected DetalleEstrategiaController CreateController()
            {
                return new DetalleEstrategiaController(SessionManager.Object, LogManager.Object, EstrategiaComponenteProvider.Object);
            }

            protected DetalleEstrategiaController CreateController(Mock<EstrategiaComponenteProvider> EstrategiaComponenteProvider)
            {
                return new DetalleEstrategiaController(SessionManager.Object, LogManager.Object, EstrategiaComponenteProvider.Object);
            }

            protected class ObtenerComponentesResponse
            {
                public List<EstrategiaComponenteModel> componentes { get; set; }
                public bool esMultimarca { get; set; }
                public string message { get; set; }
                public bool success { get; set; }
            }


            [TestMethod]
            [DataRow(null, DisplayName = "codigoVariante nulo")]
            [DataRow("", DisplayName = "codigoVariante vacio")]
            public void ObtenerComponentes_parametersCodigoVarianteInvalido_ListaComponentesInstancia(string CodigoVariante)
            {
                var jsonResult = Controller.ObtenerComponentes("0", "", "0", CodigoVariante, "");
                var data = JsonConvert.DeserializeObject<ObtenerComponentesResponse>(JsonConvert.SerializeObject(jsonResult.Data));
                Assert.AreNotEqual(null, data.componentes);
            }

            [TestMethod]
            [DataRow(0,"0", DisplayName = "codigoVariante y paisId 0")]
            public void ObtenerComponentes_parametersCodigoPaisEstragiaIdInvalido_ListaComponentesInstancia(int PaisID, string EstrategiaId)
            {
                SessionManager.Setup(x => x.GetUserData()).Returns(new UsuarioModel() { CampaniaID = 0, NroCampanias = 0, PaisID = PaisID, CodigoISO = Constantes.CodigosISOPais.Peru });
                var jsonResult = CreateController().ObtenerComponentes(EstrategiaId, "", "0", Constantes.TipoEstrategiaSet.CompuestaVariable, "");
                var data = JsonConvert.DeserializeObject<ObtenerComponentesResponse>(JsonConvert.SerializeObject(jsonResult.Data));
                Assert.AreNotEqual(true, data.success);
            }

            [TestMethod]
            public void ObtenerComponentes_parametersEstrategiaConTonos_CompuestaVariableConUnComponente()
            {
                //SessionManager.Object,new OfertaBaseProvider(), new ConfiguracionManagerProvider()
                var mockEstrategiaComponenteProvider = new Mock<EstrategiaComponenteProvider>()
                {
                    CallBase = true
                };

                mockEstrategiaComponenteProvider
                .Setup(x => x.GetEstrategiaProducto(Constantes.PaisID.Peru, 0)).Returns(new List<BEEstrategiaProducto> {
                    new BEEstrategiaProducto {
                        Activo = 1,CUV = "30880",CUV2 = "30880",Campania = 201814,Cantidad = 1,CodigoEstrategia = "2003",Descripcion = "Máscara de pestañas color intenso y volumen, a prueba de agua",
                        Digitable = 1,EstrategiaID = 43285,EstrategiaProductoID = 251096,FactorCuadre = 3,Grupo = "1", IdMarca = 2,ImagenBulk = "PE_200087831_B.jpg",
                        ImagenProducto = "PE_200087831.jpg",NombreBulk = "Negro",NombreComercial = "Máscara HD Divina. Negro",
                        NombreMarca = "Ésika",NombreProducto = "ES PRO MASCARA HD DIVINA 8G NEGRO",Orden=6,Precio = 17.9000M,
                        PrecioValorizado = 46.0000M,SAP = "200087831",Volumen = "8 g / .28 oz."
                    },
                    new BEEstrategiaProducto {
                        Activo = 1,CUV = "30887",CUV2 = "30880",Campania = 201814,Cantidad = 1,CodigoEstrategia = "2003",Descripcion = "Máscara de pestañas color intenso y volumen, a prueba de agua",
                        Digitable = 1,EstrategiaID = 43285,EstrategiaProductoID = 251794,FactorCuadre = 3,Grupo = "1", IdMarca = 2,ImagenBulk = "PE_200087832_B.jpg",
                        ImagenProducto = "PE_200087832.jpg",NombreBulk = "Negro-marrón",NombreComercial = "Máscara HD Divina. Negro-marrón",
                        NombreMarca = "Ésika",NombreProducto = "ES PRO MASCARA HD DIVINA 8G NEGRO",Orden=2,Precio = 17.9000M,
                        PrecioValorizado = 46.0000M,SAP = "200087832",Volumen = "8 g / .28 oz."
                    },
                    new BEEstrategiaProducto {
                        Activo = 1,CUV = "31076",CUV2 = "30880",Campania = 201814,Cantidad = 1,CodigoEstrategia = "2003",Descripcion = "Máscara de pestañas color intenso y volumen, a prueba de agua",
                        Digitable = 1,EstrategiaID = 43285,EstrategiaProductoID = 251966,FactorCuadre = 3,Grupo = "1", IdMarca = 2,ImagenBulk = "PE_200091639_B.jpg",
                        ImagenProducto = "PE_200091639.jpg",NombreBulk = "Esmeralda ilusion",NombreComercial = "Máscara HD Divina. Esmeralda ilusion",
                        NombreMarca = "Ésika",NombreProducto = "ES PRO MASCARA HD DIVINA 8G ESMERALDA ILUSION",Orden=3,Precio = 17.9000M,
                        PrecioValorizado = 46.0000M,SAP = "200091639",Volumen = "8 g / .28 oz."
                    },
                    new BEEstrategiaProducto {
                        Activo = 1,CUV = "31083",CUV2 = "30880",Campania = 201814,Cantidad = 1,CodigoEstrategia = "2003",Descripcion = "Máscara de pestañas color intenso y volumen, a prueba de agua",
                        Digitable = 1,EstrategiaID = 43285,EstrategiaProductoID = 250869,FactorCuadre = 3,Grupo = "1", IdMarca = 2,ImagenBulk = "PE_200091640_B.jpg",
                        ImagenProducto = "PE_200091640.jpg",NombreBulk = "Vino divino",NombreComercial = "Máscara HD Divina. Vino divino",
                        NombreMarca = "Ésika",NombreProducto = "ES PRO MASCARA HD DIVINA 8G VINO DIVINO",Orden=5,Precio = 17.9000M,
                        PrecioValorizado = 46.0000M,SAP = "200091640",Volumen = "8 g / .28 oz."
                    },
                    new BEEstrategiaProducto {
                        Activo = 1,CUV = "31085",CUV2 = "30880",Campania = 201814,Cantidad = 1,CodigoEstrategia = "2003",Descripcion = "Máscara de pestañas color intenso y volumen, a prueba de agua",
                        Digitable = 1,EstrategiaID = 43285,EstrategiaProductoID = 250871,FactorCuadre = 3,Grupo = "1", IdMarca = 2,ImagenBulk = "PE_200091641_B.jpg",
                        ImagenProducto = "PE_200091641.jpg",NombreBulk = "Azul vibrante",NombreComercial = "Máscara HD Divina. Azul vibrante",
                        NombreMarca = "Ésika",NombreProducto = "ES PRO MASCARA HD DIVINA 8G AZUL VIBRANTE",Orden=4,Precio = 17.9000M,
                        PrecioValorizado = 46.0000M,SAP = "200091641",Volumen = "8 g / .28 oz."
                    },
                    new BEEstrategiaProducto {
                        Activo = 1,CUV = "31090",CUV2 = "30880",Campania = 201814,Cantidad = 1,CodigoEstrategia = "2003",Descripcion = "Máscara de pestañas color intenso y volumen, a prueba de agua",
                        Digitable = 1,EstrategiaID = 43285,EstrategiaProductoID = 250876,FactorCuadre = 3,Grupo = "1", IdMarca = 2,ImagenBulk = "PE_200091642_B.jpg",
                        ImagenProducto = "PE_200091642.jpg",NombreBulk = "Lila cautivante",NombreComercial = "Máscara HD Divina. Lila cautivante",
                        NombreMarca = "Ésika",NombreProducto = "ES PRO MASCARA HD DIVINA 8G LILA CAUTIVANTE",Orden=1,Precio = 17.9000M,
                        PrecioValorizado = 46.0000M,SAP = "200091642",Volumen = "8 g / .28 oz."
                    }
                });

                mockEstrategiaComponenteProvider.Setup(x => x.SessionManager).Returns(SessionManager.Object);

                var jsonResult = CreateController(mockEstrategiaComponenteProvider).ObtenerComponentes("43285", "30880", "201814", Constantes.TipoEstrategiaSet.CompuestaVariable, "007");

                //var componentes = JsonConvert.SerializeObject(jsonResult);
                var componentes = new JavaScriptSerializer().Serialize(jsonResult.Data);

                //var data = JsonConvert.DeserializeObject<ObtenerComponentesResponse>(componentes);
                var data = new JavaScriptSerializer().Deserialize<ObtenerComponentesResponse>(componentes);
                Assert.AreEqual(1, data.componentes.Count);
                Assert.AreEqual(true, (data.componentes[0].Hermanos.Count > 0));
                Assert.AreEqual(1, data.componentes[0].Cantidad);
                Assert.AreEqual(false, data.esMultimarca);
                Assert.AreEqual(true, new Func<bool>(() => 
                                                            { bool TieneImgBulk = true;
                                                                data.componentes[0].Hermanos.ForEach(x =>
                                                                {
                                                                    if (x.ImagenBulk.Trim().Equals(String.Empty))
                                                                    {
                                                                        TieneImgBulk = false;
                                                                    }
                                                                });
                                                              return TieneImgBulk;
                                                            })());

                Assert.AreEqual(true, new Func<bool>(() =>
                                                            { bool NombreImgBulk = true;
                                                                data.componentes[0].Hermanos.ForEach(x =>
                                                                {
                                                                    if (x.NombreBulk.Trim().Equals(String.Empty))
                                                                    {
                                                                        NombreImgBulk = false;
                                                                    }
                                                                });
                                                                return NombreImgBulk;
                                                            })());
            }
        }
    }
}
