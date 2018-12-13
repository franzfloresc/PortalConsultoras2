using Microsoft.VisualStudio.TestTools.UnitTesting;
using MvcContrib.TestHelper;
using Portal.Consultoras.Common;
using Portal.Consultoras.Web.Controllers;
using System;
using System.Reflection;
using System.Web.Mvc;

namespace Portal.Consultoras.Web.UnitTest.Controllers
{
    [TestClass]
    public class PedidoControllerUnitTest
    {
        private string GetJsonMessage(JsonResult response)
        {
            var data = response.Data;
            Type type = data.GetType();
            PropertyInfo property = type.GetProperty("message");
            return (string)property.GetValue(data, null);
        }
        
    }
}
