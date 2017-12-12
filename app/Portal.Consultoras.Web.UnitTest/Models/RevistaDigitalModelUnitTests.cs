using System;
using System.Text;
using System.Collections.Generic;
using Microsoft.VisualStudio.TestTools.UnitTesting;
using Portal.Consultoras.Web.Models;
using Portal.Consultoras.Common;

namespace Portal.Consultoras.Web.UnitTest.Models
{
    [TestClass]
    public class RevistaDigitalModelUnitTests
    {
        [TestClass]
        public class EsSuscritaInactiva
        {
            [TestMethod]
            public void EsSuscritaInactiva_NoTieneRDC_ReturnFalse()
            {
                var rd = new RevistaDigitalModel();
                rd.TieneRDC = false;
                rd.EsSuscrita = false;
                rd.EsActiva = false;

                var result = rd.EsSuscritaInactiva();

                Assert.AreEqual(false, result);
            }

            [TestMethod]
            public void EsSuscritaInactiva_TieneRdcYEsSuscritaFalseYEsActivaFalse_ReturnFalse()
            {
                var rd = new RevistaDigitalModel();
                rd.TieneRDC = true;
                rd.EsSuscrita = false;
                rd.EsActiva = false;

                var result = rd.EsSuscritaInactiva();

                Assert.AreEqual(false, result);
            }

            [TestMethod]
            public void EsSuscritaInactiva_TieneRdcYEsSuscritaFalseYEsActivaTrue_ReturnFalse()
            {
                var rd = new RevistaDigitalModel();
                rd.TieneRDC = true;
                rd.EsSuscrita = false;
                rd.EsActiva = true;

                var result = rd.EsSuscritaInactiva();


                Assert.AreEqual(false, result);
            }

            [TestMethod]
            public void EsSuscritaInactiva_TieneRdcYEsSuscritaTrueYEsActivaFalse_ReturnTrue()
            {
                var rd = new RevistaDigitalModel();
                rd.TieneRDC = true;
                rd.EsSuscrita = true;
                rd.EsActiva = false;

                var result = rd.EsSuscritaInactiva();


                Assert.AreEqual(true, result);
            }

            [TestMethod]
            public void EsSuscritaInactiva_TieneRdcYEsSuscritaTrueYEsActivaTrue_Returnfalse()
            {
                var rd = new RevistaDigitalModel();
                rd.TieneRDC = true;
                rd.EsSuscrita = true;
                rd.EsActiva = true;

                var result = rd.EsSuscritaInactiva();


                Assert.AreEqual(false, result);
            }
        }

        [TestClass]
        public class EsSuscritaActiva
        {
            [TestMethod]
            public void EsSuscritaActiva_NoTieneRDC_ReturnFalse()
            {
                var rd = new RevistaDigitalModel();
                rd.TieneRDC = false;

                bool result = rd.EsSuscritaActiva();

                Assert.AreEqual(false, result);
            }

            [TestMethod]
            public void EsSuscritaActiva_TieneRdcYEsSuscritaFalseYEsActivaFalse_RetornaFalse()
            {
                var rd = new RevistaDigitalModel();
                rd.TieneRDC = true;
                rd.EsSuscrita = false;
                rd.EsActiva = false;
     

                bool result = rd.EsSuscritaActiva();

                Assert.AreEqual(false, result);
            }

            [TestMethod]
            public void EsSuscritaActiva_TieneRdcYEsSuscritaFalseYEsActivaTrue_RetornaFalse()
            {
                var rd = new RevistaDigitalModel();
                rd.TieneRDC = true;
                rd.EsSuscrita = false;
                rd.EsActiva = true;


                bool result = rd.EsSuscritaActiva();

                Assert.AreEqual(false, result);
            }

            [TestMethod]
            public void EsSuscritaActiva_TieneRdcYEsSuscritaTrueYEsActivaFalse_RetornaFalse()
            {
                var rd = new RevistaDigitalModel();
                rd.TieneRDC = true;
                rd.EsSuscrita = true;
                rd.EsActiva = false;


                bool result = rd.EsSuscritaActiva();

                Assert.AreEqual(false, result);
            }

            [TestMethod]
            public void EsSuscritaActiva_TieneRdcYEsSuscritaTrueYEsActivaTrue_RetornaFalse()
            {
                var rd = new RevistaDigitalModel();
                rd.TieneRDC = true;
                rd.EsSuscrita = true;
                rd.EsActiva = true;


                bool result = rd.EsSuscritaActiva();

                Assert.AreEqual(true, result);
            }
        }

        [TestClass]
        public class EsNoSuscrita
        {
            [TestMethod]
            public void EsNoSuscrita_NoTieneRDC_ReturnFalse()
            {
                var rd = new RevistaDigitalModel();
                rd.TieneRDC = false;

                bool result = rd.EsNoSuscritaInactiva();

                Assert.AreEqual(false, result);
            }

            [TestMethod]
            public void EsNoSuscrita_TieneRdcYEsSuscritaFalseYEsActivaFalse_RetornaTrue()
            {
                var rd = new RevistaDigitalModel();
                rd.TieneRDC = true;
                rd.EsSuscrita = false;
                rd.EsActiva = false;

                bool result = rd.EsNoSuscritaInactiva();

                Assert.AreEqual(true, result);
            }

            [TestMethod]
            public void EsNoSuscrita_TieneRdcYEsSuscritaFalseYEsActivaTrue_RetornaFalse()
            {
                var rd = new RevistaDigitalModel();
                rd.TieneRDC = true;
                rd.EsSuscrita = false;
                rd.EsActiva = true;

                bool result = rd.EsNoSuscritaInactiva();

                Assert.AreEqual(false, result);
            }
        } 

    }
}
