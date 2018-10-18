using System.IO;

namespace Portal.Consultoras.Data.Hana
{
    public static class Util
    {
        public static string ObtenerJsonServicioHana(string url)
        {
            System.Net.WebRequest wr = System.Net.WebRequest.Create(url);
            wr.Method = "GET";

            wr.ContentType = "application/x-www-form-urlencoded";

            // Obtiene la respuesta
            System.Net.WebResponse response = wr.GetResponse();
            // Stream con el contenido recibido del servidor
            var newStream = response.GetResponseStream();
            if (newStream != null)
            {
                StreamReader reader = new StreamReader(newStream);
                // Leemos el contenido
                string responseFromServer = reader.ReadToEnd();
                reader.Close();
                newStream.Close();
                response.Close();

                return responseFromServer;
            }

            return "";
        }
    }
}