using System.IO;
using Spire.Xls;

namespace Portal.Consultoras.Common.Excel
{
    public class ExcelProtection
    {
        /// <summary>
        /// Protege con password un archivo excel.
        /// </summary>
        /// <param name="excelStream">Stream del archivo excel</param>
        /// <param name="password">password a utilizar</param>
        /// <returns>stream del excel protegido</returns>
        public MemoryStream Secure(Stream excelStream, string password)
        {
            var wb = new Workbook();
            wb.LoadFromStream(excelStream);

            wb.Protect(password, true, true);
            var mem = new MemoryStream();
            wb.SaveToStream(mem);

            return mem;
        }
    }
}
