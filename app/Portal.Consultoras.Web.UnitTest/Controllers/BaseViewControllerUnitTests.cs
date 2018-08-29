using System;
using System.Web.Mvc;
using Microsoft.VisualStudio.TestTools.UnitTesting;
using Portal.Consultoras.Web.Controllers;
using Portal.Consultoras.Web.UnitTest.Extensions;

namespace Portal.Consultoras.Web.UnitTest.Controllers
{
    public class BaseViewControllerUnitTests
    {
        public abstract class Ficha : Base
        {
            protected virtual BaseViewController GetController()
            {
                return new BaseViewController();
            }

            protected virtual string ControllerNaneExpected()
            {
                return "Ofertas";
            }

            protected virtual string ActionNameExpected()
            {
                return "Index";
            }

            protected virtual string AreaNameExpected()
            {
                return "";
            }

            public virtual void Ficha_parameterPalancaIsNotValid_RedirectsToOfertas()
            {
                // Arrange
                var controller = GetController();

                // Act
                var actualResult = controller.Ficha(null, 0, null, null) as RedirectToRouteResult;

                // Assert
                Assert.AreEqual(ControllerNaneExpected(), actualResult.GetControllerName());
                Assert.AreEqual(ActionNameExpected(), actualResult.GetActionName());
                Assert.AreEqual(AreaNameExpected(), actualResult.GetAreaName());
            }
        }
    }
}
