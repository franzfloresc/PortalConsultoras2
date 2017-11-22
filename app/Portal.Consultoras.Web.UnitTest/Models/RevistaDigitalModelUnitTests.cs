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

                var result = rd.EsSuscritaInactiva();

                Assert.AreEqual(false, result);
            }

            [TestMethod]
            public void EsSuscritaInactiva_TieneRDCSuscripcionActualTieneEstadoSinRegistro_ReturnFalse()
            {
                var rd = new RevistaDigitalModel();
                rd.TieneRDC = true;
                rd.SuscripcionModel = new RevistaDigitalSuscripcionModel {  EstadoRegistro = Constantes.EstadoRDSuscripcion.SinRegistroDB};

                var result = rd.EsSuscritaInactiva();

                Assert.AreEqual(false, result);
            }

            [TestMethod]
            public void EsSuscritaInactiva_TieneRDCYSuscripcionActualTieneEstadoActivoYSuscripcionAnt1TieneEstadoSinRegistroYSuscripcionAnt2TieneEstadoSinRegistro_ReturnTrue()
            {
                var rd = new RevistaDigitalModel();
                rd.TieneRDC = true;
                rd.SuscripcionModel = new RevistaDigitalSuscripcionModel { EstadoRegistro = Constantes.EstadoRDSuscripcion.Activo };
                rd.SuscripcionAnterior1Model = new RevistaDigitalSuscripcionModel { EstadoRegistro = Constantes.EstadoRDSuscripcion.SinRegistroDB };
                rd.SuscripcionAnterior2Model = new RevistaDigitalSuscripcionModel { EstadoRegistro = Constantes.EstadoRDSuscripcion.SinRegistroDB };

                var result = rd.EsSuscritaInactiva();


                Assert.AreEqual(true, result);
            }

            [TestMethod]
            public void EsSuscritaInactiva_TieneRDCYSuscripcionActualTieneEstadoActivoYSuscripcionAnt1TieneEstadoActivoYSuscripcionAnt2TieneEstadoSinRegistro_ReturnTrue()
            {
                var rd = new RevistaDigitalModel();
                rd.TieneRDC = true;
                rd.SuscripcionModel = new RevistaDigitalSuscripcionModel { EstadoRegistro = Constantes.EstadoRDSuscripcion.Activo };
                rd.SuscripcionAnterior1Model = new RevistaDigitalSuscripcionModel { EstadoRegistro = Constantes.EstadoRDSuscripcion.Activo };
                rd.SuscripcionAnterior2Model = new RevistaDigitalSuscripcionModel { EstadoRegistro = Constantes.EstadoRDSuscripcion.SinRegistroDB };

                var result = rd.EsSuscritaInactiva();


                Assert.AreEqual(true, result);
            }

            [TestMethod]
            public void EsSuscritaInactiva_TieneRDCYSuscripcionActualTieneEstadoActivoYSuscripcionAnt1TieneEstadoActivoYSuscripcionAnt2TieneEstadoActivo_ReturnFalse()
            {
                var rd = new RevistaDigitalModel();
                rd.TieneRDC = true;
                rd.SuscripcionModel = new RevistaDigitalSuscripcionModel { EstadoRegistro = Constantes.EstadoRDSuscripcion.Activo };
                rd.SuscripcionAnterior1Model = new RevistaDigitalSuscripcionModel { EstadoRegistro = Constantes.EstadoRDSuscripcion.Activo };
                rd.SuscripcionAnterior2Model = new RevistaDigitalSuscripcionModel { EstadoRegistro = Constantes.EstadoRDSuscripcion.Activo };

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
            public void EsSuscritaActiva_TieneRDCYSuscripcionAnterior2TieneEstadoDiferenteActivo_RetornaFalse()
            {
                var rd = new RevistaDigitalModel();
                rd.TieneRDC = true;
                rd.SuscripcionModel = new RevistaDigitalSuscripcionModel { EstadoRegistro = Constantes.EstadoRDSuscripcion.Activo };
                rd.SuscripcionAnterior2Model = new RevistaDigitalSuscripcionModel { EstadoRegistro = Constantes.EstadoRDSuscripcion.Desactivo };

                bool result = rd.EsSuscritaActiva();

                Assert.AreEqual(false, result);
            }

            [TestMethod]
            public void EsSuscritaActiva_TieneRDCYSuscripcionAnterior2TieneEstadoActivo_RetornaTrue()
            {
                var rd = new RevistaDigitalModel();
                rd.TieneRDC = true;
                rd.SuscripcionModel = new RevistaDigitalSuscripcionModel { EstadoRegistro = Constantes.EstadoRDSuscripcion.Activo };
                rd.SuscripcionAnterior2Model = new RevistaDigitalSuscripcionModel { EstadoRegistro = Constantes.EstadoRDSuscripcion.Activo };

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
            public void EsNoSuscrita_TieneRDCYSuscripcionAnterior2TieneEstadoActivo_RetornaFalse()
            {
                var rd = new RevistaDigitalModel();
                rd.TieneRDC = true;
                rd.SuscripcionModel = new RevistaDigitalSuscripcionModel { EstadoRegistro = Constantes.EstadoRDSuscripcion.Desactivo };
                rd.SuscripcionAnterior2Model = new RevistaDigitalSuscripcionModel { EstadoRegistro = Constantes.EstadoRDSuscripcion.Activo };

                bool result = rd.EsNoSuscritaInactiva();

                Assert.AreEqual(false, result);
            }

            [TestMethod]
            public void EsNoSuscrita_TieneRDCYSuscripcionAnterior2TieneEstadoInactivo_RetornaTrue()
            {
                var rd = new RevistaDigitalModel();
                rd.TieneRDC = true;
                rd.SuscripcionModel = new RevistaDigitalSuscripcionModel { EstadoRegistro = Constantes.EstadoRDSuscripcion.Desactivo };
                rd.SuscripcionAnterior2Model = new RevistaDigitalSuscripcionModel { EstadoRegistro = Constantes.EstadoRDSuscripcion.Desactivo };

                bool result = rd.EsNoSuscritaInactiva();

                Assert.AreEqual(true, result);
            }
        } 

    }
}
