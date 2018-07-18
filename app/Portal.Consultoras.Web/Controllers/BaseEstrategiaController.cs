using Portal.Consultoras.Web.LogManager;
using Portal.Consultoras.Web.Models;
using Portal.Consultoras.Web.SessionManager;

namespace Portal.Consultoras.Web.Controllers
{
    public class BaseEstrategiaController : BaseController
    {
        public BaseEstrategiaController() : base() { }
        public BaseEstrategiaController(ISessionManager sessionManager) : base(sessionManager) { }
        public BaseEstrategiaController(ISessionManager sessionManager, ILogManager logManager) : base(sessionManager, logManager) { }
        public RevistaDigitalModel RevistaDigital
        {
            get
            {
                return revistaDigital;
            }
            set
            {
                revistaDigital = value;
            }
        }
    }
}