using System;
using System.Collections.Generic;
using Microsoft.VisualStudio.TestTools.UnitTesting;
using Portal.Consultoras.Web.Controllers;
using Portal.Consultoras.Web.Models;
using Moq;
using Portal.Consultoras.Web.LogManager;
using Portal.Consultoras.Web.SessionManager;
using Portal.Consultoras.Web.ServicePedido;

namespace Portal.Consultoras.Web.UnitTest.Controllers
{
    [TestClass]
    public class GestionContenidoControllerUnitTest
    {
        [TestClass]
        public class GetResumenCampania
        {
            //public class GestionContenidoController_WhenSoloCantidadIsTrue : GestionContenidoController
            //{
            //    public GestionContenidoController_WhenSoloCantidadIsTrue()
            //    {
            //        userData = new UsuarioModel();
            //    }

            //    public override BEPedidoWeb ObtenerPedidoWeb()
            //    {
            //        return new BEPedidoWeb();
            //    }

            //    public override List<BEPedidoWebDetalle> ObtenerPedidoWebDetalle()
            //    {
            //        return new List<BEPedidoWebDetalle>();
            //    }
            //}

            //[TestMethod]
            //public void GetResumenCampania_WhenSoloCantidadIsTrue_DoNotReturnUltimosTresPedidos()
            //{
            //    var controller = new GestionContenidoController_WhenSoloCantidadIsTrue();

            //    var result = (ResumenCampaniaModel)controller.GetResumenCampania(true).Data;

            //    Assert.IsNotNull(result);
            //    Assert.AreEqual(0,result.ultimosTresPedidos.Count);
            //}

            //public class GestionContenidoController_WhenSoloCantidadIsFalse : GestionContenidoController
            //{
            //    public GestionContenidoController_WhenSoloCantidadIsFalse()
            //    {
            //        userData = new UsuarioModel();
            //    }

            //    public override BEPedidoWeb ObtenerPedidoWeb()
            //    {
            //        return new BEPedidoWeb();
            //    }

            //    public override List<BEPedidoWebDetalle> ObtenerPedidoWebDetalle()
            //    {
            //        return new List<BEPedidoWebDetalle>(){
            //            new BEPedidoWebDetalle(){ Cantidad = 1},
            //            new BEPedidoWebDetalle(){ Cantidad = 2},
            //            new BEPedidoWebDetalle(){ Cantidad = 3},
            //            new BEPedidoWebDetalle(){ Cantidad = 4},
            //        };
            //    }
            //}

            //[TestMethod]
            //public void GetResumenCampania_WhenSoloCantidadIsFalse_ReturnUltimosPedidos()
            //{
            //    var controller = new GestionContenidoController_WhenSoloCantidadIsFalse();

            //    var result = (ResumenCampaniaModel)controller.GetResumenCampania(false).Data;

            //    Assert.IsNotNull(result);
            //    Assert.AreEqual(3, result.ultimosTresPedidos.Count);
            //    Assert.AreEqual(1, result.ultimosTresPedidos[0].Cantidad);
            //    Assert.AreEqual(2, result.ultimosTresPedidos[1].Cantidad);
            //    Assert.AreEqual(3, result.ultimosTresPedidos[2].Cantidad);
            //}
        }

    }
}
