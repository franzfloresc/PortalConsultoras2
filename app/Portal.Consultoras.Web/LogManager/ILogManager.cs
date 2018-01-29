using System;

namespace Portal.Consultoras.Web.LogManager
{
    public interface ILogManager
    {
        void LogErrorWebServicesBusWrap(Exception exception, string usuario, string pais, string adicional);
    }
}
