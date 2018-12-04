﻿using System;
using System.Web.Mvc;
using Microsoft.VisualStudio.TestTools.UnitTesting;
using MvcContrib.TestHelper;
using Portal.Consultoras.Common;
using Portal.Consultoras.Web.Controllers;
using Portal.Consultoras.Web.LogManager;
using Portal.Consultoras.Web.Providers;
using Portal.Consultoras.Web.SessionManager;
using Portal.Consultoras.Web.UnitTest.Controllers;
using Portal.Consultoras.Web.UnitTest.Extensions;
using DetalleEstrategiaController = Portal.Consultoras.Web.Areas.Mobile.Controllers.DetalleEstrategiaController;

namespace Portal.Consultoras.Web.UnitTest.Areas.Mobile.Controllers
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

            private class DetalleEstrategiaMobileController : DetalleEstrategiaController
            {
                //public DetalleEstrategiaMobileController() : base()
                //{

                //}

                //public DetalleEstrategiaMobileController(ISessionManager sesionManager) : base(sesionManager)
                //{

                //}

                //public DetalleEstrategiaMobileController(ISessionManager sesionManager, ILogManager logManager) : base(sesionManager, logManager)
                //{

                //}

                public DetalleEstrategiaMobileController(ISessionManager sesionManager, ILogManager logManager, OfertaPersonalizadaProvider ofertaPersonalizadaProvider, OfertaViewProvider ofertaViewProvider)
                    : base(sesionManager, logManager, ofertaPersonalizadaProvider,ofertaViewProvider)
                {
                }

                public override bool IsMobile()
                {
                    return true;
                }
            }

            protected override BaseViewController CreateController()
            {
                return new DetalleEstrategiaMobileController(SessionManager.Object, LogManager.Object, OfertaPersonalizadaProvider.Object, OfertaViewProvider.Object);
            }

            [TestCleanup]
            public override void Test_Cleanup()
            {
                base.Test_Cleanup();
            }

            [TestMethod]
            [DataRow((string)null, DisplayName = "palanca es nula")]
            [DataRow("", DisplayName = "palanca es vacía")]
            public override void Ficha_parameterPalancaIsNotValid_RedirectsToOfertas(string palanca)
            {
                base.Ficha_parameterPalancaIsNotValid_RedirectsToOfertas(palanca);
            }

            protected override string AreaNameExpected()
            {
                return "Mobile";
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
    }
}