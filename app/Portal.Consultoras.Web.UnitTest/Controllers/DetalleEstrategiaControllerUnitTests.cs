using Microsoft.VisualStudio.TestTools.UnitTesting;
using Moq;
using Newtonsoft.Json;
using Portal.Consultoras.Common;
using Portal.Consultoras.Web.Controllers;
using Portal.Consultoras.Web.Models;
using Portal.Consultoras.Web.Models.DetalleEstrategia;
using Portal.Consultoras.Web.Providers;
using Portal.Consultoras.Web.ServicePedido;
using Portal.Consultoras.Web.UnitTest.Extensions;
using System;
using System.Collections.Generic;
using System.Web.Mvc;
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
                return new DetalleEstrategiaController(SessionManager.Object, LogManager.Object, OfertaPersonalizadaProvider.Object, OfertaViewProvider.Object);
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

            [TestMethod]
            public override void Ficha_PalancaOptYConsultoraNoTieneRevistaDigital_BreadCrumOfertasReturnsOfertasDigitales()
            {
                base.Ficha_PalancaOptYConsultoraNoTieneRevistaDigital_BreadCrumOfertasReturnsOfertasDigitales();
            }

            [TestMethod]
            public override void Ficha_PalancaOpmYConsultoraNoTieneRevistaDigital_BreadCrumOfertasReturnsOfertasDigitales()
            {
                base.Ficha_PalancaOpmYConsultoraNoTieneRevistaDigital_BreadCrumOfertasReturnsOfertasDigitales();
            }

            [TestMethod]
            public override void Ficha_PalancaOptYConsultoraTieneRevistaDigital_BreadCrumOfertasReturnsGanaMas()
            {
                base.Ficha_PalancaOptYConsultoraTieneRevistaDigital_BreadCrumOfertasReturnsGanaMas();
            }

            [TestMethod]
            public override void Ficha_PalancaOpmYConsultoraTieneRevistaDigital_BreadCrumOfertasReturnsGanaMas()
            {
                base.Ficha_PalancaOpmYConsultoraTieneRevistaDigital_BreadCrumOfertasReturnsGanaMas();
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
            [DataRow(0, "0", DisplayName = "codigoVariante y paisId 0")]
            public void ObtenerComponentes_parametersCodigoPaisEstragiaIdInvalido_ListaComponentesInstancia(int PaisID, string EstrategiaId)
            {
                SessionManager.Setup(x => x.GetUserData()).Returns(new UsuarioModel() { CampaniaID = 0, NroCampanias = 0, PaisID = PaisID, CodigoISO = Constantes.CodigosISOPais.Peru });
                var jsonResult = CreateController().ObtenerComponentes(EstrategiaId, "", "0", Constantes.TipoEstrategiaSet.CompuestaVariable, "");
                var data = JsonConvert.DeserializeObject<ObtenerComponentesResponse>(JsonConvert.SerializeObject(jsonResult.Data));
                Assert.AreNotEqual(true, data.success);
            }

            [TestMethod]
            public void ObtenerComponentes_CompuestaVariable_UnComponenteNoMultimarca()
            {
                var mockEstrategiaComponenteProvider = new Mock<EstrategiaComponenteProvider>()
                {
                    CallBase = true
                };

                mockEstrategiaComponenteProvider
                .Setup(x => x.GetEstrategiaProducto(Constantes.PaisID.Peru, 43285))
                .Returns(DataHandlerExtensions.GetDataTesting<List<BEEstrategiaProducto>>("2003UnComponenteNMData"));

                mockEstrategiaComponenteProvider.Setup(x => x.SessionManager).Returns(SessionManager.Object);

                var jsonResult = CreateController(mockEstrategiaComponenteProvider).ObtenerComponentes("43285", "30880", "201814", Constantes.TipoEstrategiaSet.CompuestaVariable, "007");

                //var componentes = JsonConvert.SerializeObject(jsonResult);
                var componentes = new JavaScriptSerializer().Serialize(jsonResult.Data);

                //var data = JsonConvert.DeserializeObject<ObtenerComponentesResponse>(componentes);
                var data = new JavaScriptSerializer().Deserialize<ObtenerComponentesResponse>(componentes);
                Assert.AreEqual(1, data.componentes.Count);
                Assert.AreEqual(true, (data.componentes[0].FactorCuadre > 1));
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

            [TestMethod]
            public void ObtenerComponentes_CompuestaVariable_MultiComponenteNoMultimarca()
            {
                var mockEstrategiaComponenteProvider = new Mock<EstrategiaComponenteProvider>()
                {
                    CallBase = true
                };

                mockEstrategiaComponenteProvider
                .Setup(x => x.GetEstrategiaProducto(Constantes.PaisID.Peru, 43512))
                .Returns(DataHandlerExtensions.GetDataTesting<List<BEEstrategiaProducto>>("2003MultiComponenteNMData"));

                mockEstrategiaComponenteProvider.Setup(x => x.SessionManager).Returns(SessionManager.Object);

                var jsonResult = CreateController(mockEstrategiaComponenteProvider).ObtenerComponentes("43512", "31667", "201814", Constantes.TipoEstrategiaSet.CompuestaVariable, "010");
                
                var componentes = new JavaScriptSerializer().Serialize(jsonResult.Data);
                var data = new JavaScriptSerializer().Deserialize<ObtenerComponentesResponse>(componentes);

                Assert.AreEqual(true, (data.componentes.Count>1));
                Assert.AreEqual(true, new Func<bool>(() =>
                {
                    bool TodosTienenTonos = true;
                    data.componentes.ForEach(y => {
                        if(y.Hermanos == null || y.Hermanos.Count == 0)
                        {
                            TodosTienenTonos = false;
                        }
                    });
                    return TodosTienenTonos;
                })());
                Assert.AreEqual(true, new Func<bool>(() =>
                {
                    bool TodosTienenCantidadUno = true;
                    data.componentes.ForEach(y => {
                        if(!(y.Cantidad == 1 && y.FactorCuadre > 0))
                        {
                            TodosTienenCantidadUno = false;
                        }
                    });
                    return TodosTienenCantidadUno;
                })());
                Assert.AreEqual(false, data.esMultimarca);
                Assert.AreEqual(true, new Func<bool>(() =>
                {
                    bool TodosTienenImgBulk = true;
                    data.componentes.ForEach(y => {
                        y.Hermanos.ForEach(x =>
                        {
                            if (x.ImagenBulk.Trim().Equals(String.Empty))
                            {
                                TodosTienenImgBulk = false;
                            }
                        });
                    });
                    return TodosTienenImgBulk;
                })());
                Assert.AreEqual(true, new Func<bool>(() =>
                {
                    bool TodosTienenNombreImgBulk = true;
                    data.componentes.ForEach(y =>
                    {
                        y.Hermanos.ForEach(x =>
                        {
                            if (x.NombreBulk.Trim().Equals(String.Empty))
                            {
                                TodosTienenNombreImgBulk = false;
                            }
                        });
                    });
                    return TodosTienenNombreImgBulk;
                })());
            }

            [TestMethod]
            public void ObtenerComponentes_CompuestaVariable_MultiComponenteMixtoNoMultimarca()
            {
                var mockEstrategiaComponenteProvider = new Mock<EstrategiaComponenteProvider>()
                {
                    CallBase = true
                };

                mockEstrategiaComponenteProvider
                .Setup(x => x.GetEstrategiaProducto(Constantes.PaisID.Peru, 43485))
                .Returns(DataHandlerExtensions.GetDataTesting<List<BEEstrategiaProducto>>("2003MultiComponenteMixtoNMData"));

                mockEstrategiaComponenteProvider.Setup(x => x.SessionManager).Returns(SessionManager.Object);

                var jsonResult = CreateController(mockEstrategiaComponenteProvider).ObtenerComponentes("43485", "31801", "201814", Constantes.TipoEstrategiaSet.CompuestaVariable, "010");

                var componentes = new JavaScriptSerializer().Serialize(jsonResult.Data);
                var data = new JavaScriptSerializer().Deserialize<ObtenerComponentesResponse>(componentes);

                Assert.AreEqual(true, (data.componentes.Count > 1));
                Assert.AreEqual(false, new Func<bool>(() =>
                {
                    bool TodosTienenTonos = true;
                    data.componentes.ForEach(y => {
                        if (y.Hermanos == null || y.Hermanos.Count == 0)
                        {
                            TodosTienenTonos = false;
                        }
                    });
                    return TodosTienenTonos;
                })());
                Assert.AreEqual(false, new Func<bool>(() =>
                {
                    bool TodosTienenCantidadUno = true;
                    data.componentes.ForEach(y => {
                        if (!(y.Cantidad == 1 && y.FactorCuadre > 0))
                        {
                            TodosTienenCantidadUno = false;
                        }
                    });
                    return TodosTienenCantidadUno;
                })());
                Assert.AreEqual(false, data.esMultimarca);
                Assert.AreEqual(true, new Func<bool>(() =>
                {
                    bool TodosTienenImgBulk = true;
                    data.componentes.ForEach(y => {
                        y.Hermanos.ForEach(x =>
                        {
                            if (x.ImagenBulk.Trim().Equals(String.Empty))
                            {
                                TodosTienenImgBulk = false;
                            }
                        });
                    });
                    return TodosTienenImgBulk;
                })());
                Assert.AreEqual(true, new Func<bool>(() =>
                {
                    bool TodosTienenNombreImgBulk = true;
                    data.componentes.ForEach(y =>
                    {
                        y.Hermanos.ForEach(x =>
                        {
                            if (x.NombreBulk.Trim().Equals(String.Empty))
                            {
                                TodosTienenNombreImgBulk = false;
                            }
                        });
                    });
                    return TodosTienenNombreImgBulk;
                })());
            }

            [TestMethod]
            public void ObtenerComponentes_IndividualConTonos_UnComponenteNoMultimarca()
            {
                var mockEstrategiaComponenteProvider = new Mock<EstrategiaComponenteProvider>()
                {
                    CallBase = true
                };

                mockEstrategiaComponenteProvider
                .Setup(x => x.GetEstrategiaProducto(Constantes.PaisID.Peru, 43510))
                .Returns(DataHandlerExtensions.GetDataTesting<List<BEEstrategiaProducto>>("2001UnComponenteNMData"));

                mockEstrategiaComponenteProvider.Setup(x => x.SessionManager).Returns(SessionManager.Object);

                var jsonResult = CreateController(mockEstrategiaComponenteProvider).ObtenerComponentes("43510", "31675", "201814", Constantes.TipoEstrategiaSet.CompuestaVariable, "010");

                var componentes = new JavaScriptSerializer().Serialize(jsonResult.Data);
                var data = new JavaScriptSerializer().Deserialize<ObtenerComponentesResponse>(componentes);

                Assert.AreEqual(true, (data.componentes.Count == 1));
                Assert.AreEqual(true, new Func<bool>(() =>
                {
                    bool TodosTienenTonos = true;
                    data.componentes.ForEach(y => {
                        if (y.Hermanos == null || y.Hermanos.Count == 0)
                        {
                            TodosTienenTonos = false;
                        }
                    });
                    return TodosTienenTonos;
                })());
                Assert.AreEqual(true, new Func<bool>(() =>
                {
                    bool TodosTienenCantidadUno = true;
                    data.componentes.ForEach(y => {
                        if (!(y.Cantidad == 1 && y.FactorCuadre > 0))
                        {
                            TodosTienenCantidadUno = false;
                        }
                    });
                    return TodosTienenCantidadUno;
                })());
                Assert.AreEqual(false, data.esMultimarca);
                Assert.AreEqual(true, new Func<bool>(() =>
                {
                    bool TodosTienenImgBulk = true;
                    data.componentes.ForEach(y => {
                        y.Hermanos.ForEach(x =>
                        {
                            if (x.ImagenBulk.Trim().Equals(String.Empty))
                            {
                                TodosTienenImgBulk = false;
                            }
                        });
                    });
                    return TodosTienenImgBulk;
                })());
                Assert.AreEqual(true, new Func<bool>(() =>
                {
                    bool TodosTienenNombreImgBulk = true;
                    data.componentes.ForEach(y =>
                    {
                        y.Hermanos.ForEach(x =>
                        {
                            if (x.NombreBulk.Trim().Equals(String.Empty))
                            {
                                TodosTienenNombreImgBulk = false;
                            }
                        });
                    });
                    return TodosTienenNombreImgBulk;
                })());
            }

            [TestMethod]
            public void ObtenerComponentes_CompuestaFija_MultiComponenteMultiMarca()
            {
                var mockEstrategiaComponenteProvider = new Mock<EstrategiaComponenteProvider>()
                {
                    CallBase = true
                };

                mockEstrategiaComponenteProvider
                .Setup(x => x.GetEstrategiaProducto(Constantes.PaisID.Peru, 28103))
                .Returns(DataHandlerExtensions.GetDataTesting<List<BEEstrategiaProducto>>("2002MultiComponenteMMData"));

                mockEstrategiaComponenteProvider.Setup(x => x.SessionManager).Returns(SessionManager.Object);

                var jsonResult = CreateController(mockEstrategiaComponenteProvider).ObtenerComponentes("28103", "32082", "201814", Constantes.TipoEstrategiaSet.CompuestaFija, "007");

                var componentes = new JavaScriptSerializer().Serialize(jsonResult.Data);
                var data = new JavaScriptSerializer().Deserialize<ObtenerComponentesResponse>(componentes);

                Assert.AreEqual(true, (data.componentes.Count > 1));
                Assert.AreEqual(false, new Func<bool>(() =>
                {
                    bool TodosTienenTonos = true;
                    data.componentes.ForEach(y => {
                        if (y.Hermanos == null || y.Hermanos.Count == 0)
                        {
                            TodosTienenTonos = false;
                        }
                    });
                    return TodosTienenTonos;
                })());
                Assert.AreEqual(true, data.esMultimarca);
            }

            [TestMethod]
            public void ObtenerComponentes_CompuestaVariable_MultiComponenteMixtoMM()
            {
                var mockEstrategiaComponenteProvider = new Mock<EstrategiaComponenteProvider>()
                {
                    CallBase = true
                };

                mockEstrategiaComponenteProvider
                .Setup(x => x.GetEstrategiaProducto(Constantes.PaisID.Peru, 37334))
                .Returns(DataHandlerExtensions.GetDataTesting<List<BEEstrategiaProducto>>("2003MultiComponenteMixtoMMData"));

                mockEstrategiaComponenteProvider.Setup(x => x.SessionManager).Returns(SessionManager.Object);

                var jsonResult = CreateController(mockEstrategiaComponenteProvider).ObtenerComponentes("37334", "31802", "201814", Constantes.TipoEstrategiaSet.CompuestaVariable, "007");

                var componentes = new JavaScriptSerializer().Serialize(jsonResult.Data);
                var data = new JavaScriptSerializer().Deserialize<ObtenerComponentesResponse>(componentes);

                Assert.AreEqual(true, (data.componentes.Count > 1));
                Assert.AreEqual(false, new Func<bool>(() =>
                {
                    bool TodosTienenTonos = true;
                    data.componentes.ForEach(y => {
                        if (y.Hermanos == null || y.Hermanos.Count == 0)
                        {
                            TodosTienenTonos = false;
                        }
                    });
                    return TodosTienenTonos;
                })());
                Assert.AreEqual(false, new Func<bool>(() =>
                {
                    bool TodosTienenCantidadUno = true;
                    data.componentes.ForEach(y => {
                        if (!(y.Cantidad == 1 && y.FactorCuadre > 0))
                        {
                            TodosTienenCantidadUno = false;
                        }
                    });
                    return TodosTienenCantidadUno;
                })());
                Assert.AreEqual(true, data.esMultimarca);
                Assert.AreEqual(true, new Func<bool>(() =>
                {
                    bool TodosTienenImgBulk = true;
                    data.componentes.ForEach(y => {
                        y.Hermanos.ForEach(x =>
                        {
                            if (x.ImagenBulk.Trim().Equals(String.Empty))
                            {
                                TodosTienenImgBulk = false;
                            }
                        });
                    });
                    return TodosTienenImgBulk;
                })());
                Assert.AreEqual(true, new Func<bool>(() =>
                {
                    bool TodosTienenNombreImgBulk = true;
                    data.componentes.ForEach(y =>
                    {
                        y.Hermanos.ForEach(x =>
                        {
                            if (x.NombreBulk.Trim().Equals(String.Empty))
                            {
                                TodosTienenNombreImgBulk = false;
                            }
                        });
                    });
                    return TodosTienenNombreImgBulk;
                })());
            }
        }
    }
}
