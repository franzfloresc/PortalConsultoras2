using System;
using System.Text;
using System.Collections.Generic;
using Microsoft.VisualStudio.TestTools.UnitTesting;
using Portal.Consultoras.Web.Controllers;
using Portal.Consultoras.Web.Models;

namespace Portal.Consultoras.Web.UnitTest.Controllers
{
    /// <summary>
    /// Summary description for BaseShowRoomControllerUnitTest
    /// </summary>
    [TestClass]
    public class BaseShowRoomControllerUnitTest
    {
        [TestClass]
        public class GetOfertaConDetalle : Base
        {

            class BaseRevistaDigitalController_EsSociaEmprsariaYTieneSEExpGanamasYEsNoSuscrita : BaseShowRoomController
            {
                public BaseRevistaDigitalController_EsSociaEmprsariaYTieneSEExpGanamasYEsNoSuscrita(bool esActiva)
                {
                    userData = new UsuarioModel
                    {
                        esConsultoraLider = true,
                        Sobrenombre = "vvilelaj",
                        CampaniaID = 201809,
                        NroCampanias = 18,
                        PaisID = 10
                    };
                    revistaDigital = new RevistaDigitalModel
                    {
                        TieneRDC = true,
                        SociaEmpresariaExperienciaGanaMas = true,
                        EsSuscrita = false,
                        //
                        EsActiva = esActiva,
                        SociaEmpresariaSuscritaActivaCancelarSuscripcion = true,
                        SociaEmpresariaSuscritaNoActivaCancelarSuscripcion = true,
                    };
                }
            }

            [DataRow(1,"Primer CUV")]
            [DataTestMethod]
            public void GetOfertaConDetallePrueba_PruebaTonos(int idOferta)
            {
                var controller = new BaseRevistaDigitalController_EsSociaEmprsariaYTieneSEExpGanamasYEsNoSuscrita(true);
                var ShowRoomOfertaModel = controller.GetOfertaConDetallePrueba(idOferta);
                Assert.IsNotNull(ShowRoomOfertaModel);
            }
        }
    }
}
