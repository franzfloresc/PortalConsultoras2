using System;
using System.IO;
using System.Text;
using System.Web;

namespace Portal.Consultoras.Common
{
    public static class ErrorUtilities
    {
        public static void AddLog(Exception ex)
        {
            var log = getLog(ex);
            ErrorUtilities.AddLogFile(log);
        }

        private static void AddLogFile(Log log)
        {
            string path = Path.Combine(HttpRuntime.AppDomainAppPath, "Log");
            string fileName = string.Format("{0}.txt", DateTime.Now.ToFileFormattedStringDate());
            StreamWriter sw;

            if (!Directory.Exists(path))
            {
                Directory.CreateDirectory(path);
            }

            if (!File.Exists(Path.Combine(path, fileName)))
            {
                sw = new StreamWriter(Path.Combine(path, fileName), true, Encoding.UTF8);
                sw.WriteLine(string.Format("{0}\t{1}\t{2}\t{3}\t{4}",
                    "IdUser", "Exception", "StackTrace", "LogDate", "DbEntityException"));
                sw.Close();
                sw.Dispose();
            }

            // Add log
            sw = new StreamWriter(Path.Combine(path, fileName), true, Encoding.UTF8);
            sw.WriteLine(string.Format("{0}\t{1}\t{2}\t{3}\t",
                    log.Exception, log.StackTrace, log.LogDate.Value.ToFullFormattedStringDate(), log.DBEntityException));
            sw.Close();
            sw.Dispose();
        }
        private static Log getLog(Exception ex)
        {
            var log = new Log();

            while (ex.InnerException != null)
            {
                ex = ex.InnerException;
            }

            var exception = ex.Message;
            var stackTrace = ex.StackTrace;

            log.Exception = exception;
            log.StackTrace = stackTrace;
            log.LogDate = DateTime.Now;

            return log;
        }

        public static void EscribirLog(string mensaje)
        {
            string path = Path.Combine(HttpRuntime.AppDomainAppPath, "Log");
            string fileName = string.Format("{0}.txt", DateTime.Now.ToFileFormattedStringDate());

            var sw = new StreamWriter(Path.Combine(path, fileName), true, Encoding.UTF8);
            sw.WriteLine("FECHA Y HORA:" + DateTime.Now);
            sw.WriteLine("MENSAJE: " + mensaje);
            sw.WriteLine(Environment.NewLine);
            sw.Close();
        }

        public static string GetExceptionMessage(Exception exception)
        {
            var txtBuil = new StringBuilder();
            string separadorExcepciones = string.Empty;
            while (exception != null)
            {
                txtBuil.Append(separadorExcepciones + exception.Message + "(" + exception.StackTrace + ").");
                separadorExcepciones = Environment.NewLine + Environment.NewLine;
                exception = exception.InnerException;
            }
            return txtBuil.ToString();
        }
    }

    public class Log
    {
        public string Exception { get; set; }
        public string StackTrace { get; set; }
        public DateTime? LogDate { get; set; }
        public string IdUser { get; set; }
        public string DBEntityException { get; set; }
    }
}