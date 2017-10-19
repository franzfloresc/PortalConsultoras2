using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Portal.Consultoras.Web.LogManager
{
    public interface ILogManager
    {
        void LogErrorWebServicesBusWrap(Exception exception, string usuario, string pais, string adicional);
    }
}
