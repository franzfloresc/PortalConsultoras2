using System;
using System.Web.Mvc;
using Microsoft.VisualStudio.TestTools.UnitTesting;
using MvcContrib.TestHelper;
using Portal.Consultoras.Common;
using Portal.Consultoras.Web.Controllers;
using Portal.Consultoras.Web.Models;
using Portal.Consultoras.Web.UnitTest.Extensions;

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
    }
}
