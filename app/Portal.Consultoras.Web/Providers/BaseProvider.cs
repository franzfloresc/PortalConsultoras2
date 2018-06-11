using Portal.Consultoras.Common;
using Portal.Consultoras.Web.Models;
using Portal.Consultoras.Web.SessionManager;
using System;
using System.Collections.Generic;
using System.Configuration;
using System.Linq;

namespace Portal.Consultoras.Web.Providers
{
    public class BaseProvider
    {
        private readonly ISessionManager sessionManager = SessionManager.SessionManager.Instance;

    }

}