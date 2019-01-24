using System.IO;
using Portal.Consultoras.Common.Excel;
using Portal.Consultoras.Web.Providers;

namespace Portal.Consultoras.Web.Infraestructure.Excel
{
    public class ExcelProtectionProcessor
    {
        public const int TablaLogicaId = 151;
        public const int TablaLogicaDatosId = 15101;
        public TablaLogicaProvider DataProvider { get; set; }
        public int PaisId { get; set; }

        public bool IsRequiredProtection()
        {
            var items = DataProvider.ObtenerParametrosTablaLogica(PaisId, TablaLogicaId);
            var value = DataProvider.ObtenerValorDesdeLista(items, TablaLogicaDatosId);

            return value == "1";
        }

        public MemoryStream Secure(Stream excel, string password)
        {
            var protector = new ExcelProtection();

            return protector.Secure(excel, password);
        }
    }
}