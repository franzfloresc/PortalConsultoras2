using Microsoft.VisualStudio.TestTools.UnitTesting;
using Moq;
using Portal.Consultoras.Web.SessionManager;
using Portal.Consultoras.Web.LogManager;

namespace Portal.Consultoras.Web.UnitTest
{
    [TestClass]
    public class Base
    {
        private Mock<ISessionManager> _sessionManager;
        private Mock<ILogManager> _logManager;

        protected Mock<ISessionManager> SessionManager
        {
            get { return _sessionManager; }
        }

        protected Mock<ILogManager> LogManager
        {
            get { return _logManager; }
        }

        [TestInitialize]
        public virtual void Test_Initialize()
        {
            _sessionManager = new Mock<ISessionManager>();
            _logManager = new Mock<ILogManager>();
        }

        [TestCleanup]
        public virtual void Test_Cleanup()
        {
            _sessionManager = null;
            _logManager = null;
        }
    }
}
