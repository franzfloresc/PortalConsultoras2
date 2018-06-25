using Microsoft.VisualStudio.TestTools.UnitTesting;
using Moq;
using Portal.Consultoras.Web.Models;
using Portal.Consultoras.Web.Models.Estrategia.ShowRoom;
using Portal.Consultoras.Web.Providers;
using Portal.Consultoras.Web.SessionManager;
using System.Collections.Generic;
using Portal.Consultoras.Web.ServiceOferta;
using Portal.Consultoras.Web.SessionManager.ShowRoom;

namespace Portal.Consultoras.Web.UnitTest.Providers
{
    [TestClass]
    public class ShowRoomProviderTests
    {
        private const short Pl50Key = 98;
        private const string ImageUrlCode = "bar_in_img";
        private const string RedirectCode = "bar_in_url";
        private const string EnabledCode = "bar_in_act";
        private const string NoUrlAllowed = "bar_in_no";

        private ShowRoomProvider _showRoomProvider;
        private Mock<TablaLogicaProvider> _tablaLogicaProvider = new Mock<TablaLogicaProvider>();


        private List<TablaLogicaDatosModel> _tablaLogicaModels = new List<TablaLogicaDatosModel>()
        {
            new TablaLogicaDatosModel
            {
                Codigo = ImageUrlCode,
                Valor = "http://via.placeholder.com/1600x150"
            },
            new TablaLogicaDatosModel
            {
                Codigo = RedirectCode,
                Valor = "/showRoom"
            },
            new TablaLogicaDatosModel
            {
                Codigo = EnabledCode,
                Valor = "true"
            },
            new TablaLogicaDatosModel
            {
                Codigo = NoUrlAllowed,
                Valor = "/ofertas"
            },
        };

        [TestInitialize]
        public void Initialize()
        {
            _tablaLogicaProvider.Setup(t => t.ObtenerConfiguracion(It.IsAny<int>(), Pl50Key)).Returns(_tablaLogicaModels);
            _showRoomProvider = new ShowRoomProvider(_tablaLogicaProvider.Object);

        }

        [TestMethod]
        public void BannerInferior_DebeEstarActivoSiTieneShowRoomYBarraActivo()
        {
            _tablaLogicaModels.ForEach(t =>
            {
                if (t.Codigo == EnabledCode)
                    t.Valor = "true";
            });

            Mock<ISessionManager> _sessionProvider = new Mock<ISessionManager>();
            _sessionProvider.Setup(t => t.GetEsShowRoom()).Returns(true);
            _sessionProvider.Setup(t => t.ShowRoom).Returns(new ShowRoomSessionTest());
            _sessionProvider.Object.ShowRoom.BannerInferiorConfiguracion = null;

            var data = _showRoomProvider.EvaluarBannerConfiguracion(1, _sessionProvider.Object);

            Assert.IsTrue(data.Activo);
        }

        [TestMethod]
        public void BannerInferior_DebeEstarInactivoSiShowRoomInactivo()
        {
            _tablaLogicaModels.ForEach(t =>
            {
                if (t.Codigo == EnabledCode)
                    t.Valor = "true";
            });

            Mock<ISessionManager> _sessionProvider = new Mock<ISessionManager>();
            _sessionProvider.Setup(t => t.ShowRoom).Returns(new ShowRoomSessionTest());
            _sessionProvider.Setup(t => t.GetEsShowRoom()).Returns(false);
            _sessionProvider.Object.ShowRoom.BannerInferiorConfiguracion = null;

            var data = _showRoomProvider.EvaluarBannerConfiguracion(1, _sessionProvider.Object);

            Assert.IsFalse(data.Activo);
        }

        [TestMethod]
        public void BannerInferior_DebeEstarInactivo()
        {
            _tablaLogicaModels.ForEach(t =>
            {
                if (t.Codigo == EnabledCode)
                    t.Valor = "false";
            });

            Mock<ISessionManager> _sessionProvider = new Mock<ISessionManager>();
            _sessionProvider.Setup(t => t.GetEsShowRoom()).Returns(true);
            _sessionProvider.Setup(t => t.ShowRoom).Returns(new ShowRoomSessionTest());
            _sessionProvider.Object.ShowRoom.BannerInferiorConfiguracion = null;

            var data = _showRoomProvider.EvaluarBannerConfiguracion(1, _sessionProvider.Object);

            Assert.IsFalse(data.Activo);
        }

        class ShowRoomSessionTest : IShowRoom
        {
            private static IBannerInferiorConfiguracion bannerInferiorConfiguracion;
            public IBannerInferiorConfiguracion BannerInferiorConfiguracion
            {
                get
                {
                    return bannerInferiorConfiguracion;
                }
                set
                {
                    bannerInferiorConfiguracion = value;
                }
            }

            public List<EstrategiaPedidoModel> Ofertas { get; set; }
            public List<EstrategiaPedidoModel> OfertasSubCampania { get; set; }
            public List<EstrategiaPedidoModel> OfertasPerdio { get; set; }
            public List<EstrategiaPedidoModel> OfertasCompraPorCompra { get; set; }
        }

    }
}
