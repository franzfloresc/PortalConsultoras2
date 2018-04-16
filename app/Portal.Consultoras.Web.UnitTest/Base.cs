using Microsoft.VisualStudio.TestTools.UnitTesting;
using Moq;
using Portal.Consultoras.Web.SessionManager;
using Portal.Consultoras.Web.LogManager;

namespace Portal.Consultoras.Web.UnitTest
{
    [TestClass]
    public class Base
    {
        protected Mock<ISessionManager> sessionManager;
        protected Mock<ILogManager> logManager;

        [TestInitialize]
        public void Test_Initialize()
        {
            sessionManager = new Mock<ISessionManager>();
            logManager = new Mock<ILogManager>();
        }

        [TestCleanup]
        public void Test_Cleanup()
        {
            sessionManager = null;
            logManager = null;
        }
    }
}
