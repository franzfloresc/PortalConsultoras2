using Microsoft.VisualStudio.TestTools.UnitTesting;
using Moq;
using MvcContrib.TestHelper;
using Portal.Consultoras.Common;
using Portal.Consultoras.Web.Controllers;
using Portal.Consultoras.Web.Models;
using System;
using System.Reflection;
using System.Web.Mvc;
using Portal.Consultoras.Web.LogManager;
using Portal.Consultoras.Web.SessionManager;
using Portal.Consultoras.Web.ServiceOferta;
using System.Collections.Generic;
using Portal.Consultoras.Web.Models.AutoMapper;

namespace Portal.Consultoras.Web.UnitTest.Controllers
{
    [TestClass]
    public class RevistaDigitalControllerUnitTest
    {
        RevistaDigitalController controller;

        [TestClass]
        public class RDObtenerProductos : Base
        {
            [ClassInitialize()]
            public static void Class_Initialize(TestContext context)
            {
                AutoMapperConfiguration.Configure();
            }

            class RevistaDigitalControllerStub001 : RevistaDigitalController
            {
                public RevistaDigitalControllerStub001(ISessionManager sessionManager, ILogManager logManager) 
                    : base(sessionManager, logManager)
                {
                    //
                }

            }

            RevistaDigitalController controller;

            private RevistaDigitalController GetRevistaController()
            {
                return new RevistaDigitalControllerStub001(SessionManager.Object, LogManager.Object);
            }

            [TestInitialize]
            public override void Test_Initialize()
            {
                base.Test_Initialize();
                controller = GetRevistaController();
            }

            [TestCleanup]
            public override void Test_Cleanup()
            {
                base.Test_Cleanup();
                controller = null;
            }
            
        }
    }
}
