//using Microsoft.VisualStudio.TestTools.UnitTesting;
//using Moq;
//using MvcContrib.TestHelper;
//using Portal.Consultoras.Common;
//using Portal.Consultoras.Web.Areas.Mobile.Models;
//using Portal.Consultoras.Web.Controllers;
//using Portal.Consultoras.Web.Models;
//using Portal.Consultoras.Web.SessionManager;
//using Portal.Consultoras.Web.UnitTest.Attributes;
//using System;
//using System.Collections.Generic;
//using System.Linq;
//using Portal.Consultoras.Web.ServiceSeguridad;
//using Portal.Consultoras.Web.Models.Layout;
//using Portal.Consultoras.Web.ServiceSAC;
//using Portal.Consultoras.Web.LogManager;
//using System.Web.Mvc;

//namespace Portal.Consultoras.Web.UnitTest.Controllers
//{
//    [TestClass]
//    public class BaseRevistaDigitalControllerUnitTests
//    {
//        [TestClass]
//        public class IndexModel :Base
//        {
//            class BaseRevistaDigitalController_NoEsSociaEmpresaria : BaseRevistaDigitalController
//            {
//                public BaseRevistaDigitalController_NoEsSociaEmpresaria(bool esSuscrita, bool sociaEmpresariaExperienciaGanaMas)
//                {
//                    userData = new UsuarioModel
//                    {
//                        esConsultoraLider = false,
//                        Sobrenombre = "vvilelaj",
//                        CampaniaID = 201805,
//                        NroCampanias = 18
//                    };
//                    revistaDigital = new RevistaDigitalModel
//                    {
//                        TieneRDC = true,
//                        EsSuscrita = esSuscrita,
//                        SociaEmpresariaExperienciaGanaMas = sociaEmpresariaExperienciaGanaMas
//                    };
//                }
//            }
//            [DataRow(false,false, DisplayName = "No Suscrita, No Experiencia Socia Empresaria")]
//            [DataRow(false, true, DisplayName = "No Suscrita, Experiencia Socia Empresaria")]
//            [DataRow(true, false, DisplayName = "Suscrita, No Experiencia Socia Empresaria")]
//            [DataRow(true, true, DisplayName = "Suscrita, Experiencia Socia Empresaria")]
//            [DataTestMethod]
//            public void IndexModel_NoEsSociaEmpresaria_RetornaViewTemplateInformativoYMostrarCancerlarSuscripcionVerdadero(bool esSuscrita, bool sociaEmpresariaExperienciaGanaMas)
//            {
//                var controller = new BaseRevistaDigitalController_NoEsSociaEmpresaria(esSuscrita, sociaEmpresariaExperienciaGanaMas);

//                var result = controller.IndexModel() as ViewResult;

//                Assert.AreEqual("template-informativa", result.ViewName);
//                //
//                var model = result.Model as RevistaDigitalInformativoModel;
//                Assert.IsNotNull(model);
//                Assert.AreEqual(true, model.MostrarCancelarSuscripcion);
//            }

//            class BaseRevistaDigitalController_EsSociaEmpresariaYNoTieneSociaEmpresariaExperienciaGanaMas : BaseRevistaDigitalController
//            {
//                public BaseRevistaDigitalController_EsSociaEmpresariaYNoTieneSociaEmpresariaExperienciaGanaMas(bool esSuscrita, bool esActiva)
//                {
//                    userData = new UsuarioModel
//                    {
//                        esConsultoraLider = true,
//                        Sobrenombre = "vvilelaj",
//                        CampaniaID = 201805,
//                        NroCampanias = 18
//                    };
//                    revistaDigital = new RevistaDigitalModel
//                    {
//                        TieneRDC = true,
//                        EsSuscrita = esSuscrita,
//                        EsActiva = esActiva,
//                        SociaEmpresariaExperienciaGanaMas = false
//                    };
//                }
//            }
//            [DataRow(false, false, DisplayName = "No Suscrita, No Activa")]
//            [DataRow(false, true, DisplayName = "No Suscrita, Activa")]
//            [DataRow(true, false, DisplayName = "Suscrita, No Activa")]
//            [DataRow(true, true, DisplayName = "Suscrita, Activa")]
//            [DataTestMethod]
//            public void IndexModel_EsSociaEmpresariaYNoTieneSociaEmpresariaExperienciaGanaMas_RetornaViewTemplateInformativoYMostrarCancerlarSuscripcionVerdadero(bool esSuscrita, bool esActiva)
//            {
//                var controller = new BaseRevistaDigitalController_EsSociaEmpresariaYNoTieneSociaEmpresariaExperienciaGanaMas(esSuscrita, esActiva);

//                var result = controller.IndexModel() as ViewResult;

//                Assert.AreEqual("template-informativa", result.ViewName);
//                //
//                var model = result.Model as RevistaDigitalInformativoModel;
//                Assert.IsNotNull(model);
//                Assert.AreEqual(true, model.MostrarCancelarSuscripcion);
//            }

//            class BaseRevistaDigitalController_EsSociaEmprsariaYTieneSEExpGanamasYEsNoSuscrita : BaseRevistaDigitalController
//            {
//                public BaseRevistaDigitalController_EsSociaEmprsariaYTieneSEExpGanamasYEsNoSuscrita(bool esActiva)
//                {
//                    userData = new UsuarioModel
//                    {
//                        esConsultoraLider = true,
//                        Sobrenombre = "vvilelaj",
//                        CampaniaID = 201805,
//                        NroCampanias = 18
//                    };
//                    revistaDigital = new RevistaDigitalModel
//                    {
//                        TieneRDC = true,
//                        SociaEmpresariaExperienciaGanaMas = true,
//                        EsSuscrita = false,
//                        //
//                        EsActiva = esActiva,
//                        SociaEmpresariaSuscritaActivaCancelarSuscripcion = true,
//                        SociaEmpresariaSuscritaNoActivaCancelarSuscripcion = true,
//                    };
//                }
//            }
//            [DataRow(false, DisplayName = "No Activa")]
//            [DataRow(true,DisplayName = "Activa")]
//            [DataTestMethod]
//            public void IndexModel_EsSociaEmprsariaYTieneSEExpGanamasYEsNoSuscrita_RetornaViewTemplateInformativoYMostrarCancerlarSuscripcionFalso(bool esActiva)
//            {
//                var controller = new BaseRevistaDigitalController_EsSociaEmprsariaYTieneSEExpGanamasYEsNoSuscrita(esActiva);

//                var result = controller.IndexModel() as ViewResult;

//                Assert.AreEqual("template-informativa", result.ViewName);
//                var model = result.Model as RevistaDigitalInformativoModel;
//                Assert.IsNotNull(model);
//                Assert.AreEqual(true, model.MostrarCancelarSuscripcion);
//            }

//            class BaseRevistaDigitalController_EsSociaEmprsariaYTieneSEExpGanamasYEsSuscritaYSocEmprPuedeCancelar : BaseRevistaDigitalController
//            {
//                public BaseRevistaDigitalController_EsSociaEmprsariaYTieneSEExpGanamasYEsSuscritaYSocEmprPuedeCancelar(bool esActiva)
//                {
//                    userData = new UsuarioModel
//                    {
//                        esConsultoraLider = true,
//                        Sobrenombre = "vvilelaj",
//                        CampaniaID = 201805,
//                        NroCampanias = 18
//                    };
//                    revistaDigital = new RevistaDigitalModel
//                    {
//                        TieneRDC = true,
//                        SociaEmpresariaExperienciaGanaMas = true,
//                        EsSuscrita = true,
//                        //
//                        EsActiva = esActiva,
//                        SociaEmpresariaSuscritaActivaCancelarSuscripcion = true,
//                        SociaEmpresariaSuscritaNoActivaCancelarSuscripcion = true,
//                    };
//                }
//            }
//            [DataRow(false, DisplayName = "No Activa")]
//            [DataRow(true, DisplayName = "Activa")]
//            [DataTestMethod]
//            public void IndexModel_EsSociaEmpresariaYTieneSEExpGanamasYEsSuscritaYSocEmprPuedeCancelar_RetornaViewTemplateInformativoYMostrarCancerlarSuscripcionVerdadero(
//                bool esActiva)
//            {
//                var controller = new BaseRevistaDigitalController_EsSociaEmprsariaYTieneSEExpGanamasYEsSuscritaYSocEmprPuedeCancelar(esActiva);

//                var result = controller.IndexModel() as ViewResult;

//                Assert.AreEqual("template-informativa", result.ViewName);
//                var model = result.Model as RevistaDigitalInformativoModel;
//                Assert.IsNotNull(model);
//                Assert.AreEqual(true, model.MostrarCancelarSuscripcion);
//            }

//            class BaseRevistaDigitalController_EsSociaEmprsariaYTieneSEExpGanamasYEsSuscritaYSocEmprNoPuedeCancelar : BaseRevistaDigitalController
//            {
//                public BaseRevistaDigitalController_EsSociaEmprsariaYTieneSEExpGanamasYEsSuscritaYSocEmprNoPuedeCancelar(bool esActiva)
//                {
//                    userData = new UsuarioModel
//                    {
//                        esConsultoraLider = true,
//                        Sobrenombre = "vvilelaj",
//                        CampaniaID = 201805,
//                        NroCampanias = 18
//                    };
//                    revistaDigital = new RevistaDigitalModel
//                    {
//                        TieneRDC = true,
//                        SociaEmpresariaExperienciaGanaMas = true,
//                        EsSuscrita = true,
//                        //
//                        EsActiva = esActiva,
//                        SociaEmpresariaSuscritaActivaCancelarSuscripcion = false,
//                        SociaEmpresariaSuscritaNoActivaCancelarSuscripcion = false,
//                    };
//                }
//            }
//            [DataRow(false, DisplayName = "No Activa")]
//            [DataRow(true, DisplayName = "Activa")]
//            [DataTestMethod]
//            public void IndexModel_EsSociaEmprsariaYTieneSEExpGanamasYEsSuscritaYSocEmprNoPuedeCancelar_RetornaViewTemplateInformativoYMostrarCancerlarSuscripcionFalso(
//                bool esActiva)
//            {
//                var controller = new BaseRevistaDigitalController_EsSociaEmprsariaYTieneSEExpGanamasYEsSuscritaYSocEmprNoPuedeCancelar(esActiva);

//                var result = controller.IndexModel() as ViewResult;

//                Assert.AreEqual("template-informativa", result.ViewName);
//                var model = result.Model as RevistaDigitalInformativoModel;
//                Assert.IsNotNull(model);
//                Assert.AreEqual(false, model.MostrarCancelarSuscripcion);
//            }
//        }
//    }
//}