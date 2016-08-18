using System;
using System.Configuration;
using System.IO;

namespace Portal.Consultoras.Common
{
    public class LogManager
    {
        public static void SaveLog(Exception exception, string codigoUsuario, string paisISO)
        {
            try
            {
                string directory = AppDomain.CurrentDomain.BaseDirectory + "Log";
                if (!Directory.Exists(directory)) Directory.CreateDirectory(directory);

                StreamWriter stream = new StreamWriter(directory + "\\Log_" + DateTime.Now.ToString("yyyy-MM-dd") + ".txt", true);
                stream.WriteLine(DateTime.Now + " Pais: " + paisISO + ", Codigo Usuario: " + codigoUsuario);
                stream.WriteLine("================================================================================");
                stream.WriteLine("- " + exception.Message +"(" + exception.StackTrace + ").");

                Exception innerException = exception.InnerException;
                while (innerException != null)
                {
                    stream.WriteLine("- " + innerException.Message);
                    innerException = innerException.InnerException;
                }

                stream.WriteLine(string.Empty);
                stream.Flush();
                stream.Close();
            }
            catch (Exception) { }
        }
    }
}