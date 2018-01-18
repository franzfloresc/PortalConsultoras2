using Portal.Consultoras.Common;
using System.IO;
using System.Web;

namespace Portal.Consultoras.Web.CustomHelpers
{
    public class UploadHelper
    {
        public void UploadFile(HttpRequestBase request, string fileName)
        {
            Stream inputStream = request.InputStream;
            byte[] fileBytes = ReadFully(inputStream);
            var path = Path.Combine(Globals.RutaTemporales, fileName);
            System.IO.File.WriteAllBytes(path, fileBytes);
            if (!System.IO.File.Exists(Globals.RutaTemporales))
                System.IO.Directory.CreateDirectory(Globals.RutaTemporales);
        }

        private byte[] ReadFully(Stream input)
        {
            byte[] buffer = new byte[16 * 1024];
            using (MemoryStream ms = new MemoryStream())
            {
                int read;
                while ((read = input.Read(buffer, 0, buffer.Length)) > 0)
                {
                    ms.Write(buffer, 0, read);
                }
                return ms.ToArray();
            }
        }
    }
}