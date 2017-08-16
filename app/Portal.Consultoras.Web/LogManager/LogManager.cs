using Portal.Consultoras.Web.CustomFilters;
using System;
using System.Configuration;
using System.IO;
using System.ServiceModel;

namespace Portal.Consultoras.Web.LogManager
{
    public class LogManager
    {
        private static string sPathFile = ConfigurationManager.AppSettings["LogPath"].ToString() + "SB2\\";

        public static void LogErrorWebServicesPortal(FaultException faulException, string usuario, string pais)
        {
            if (!Directory.Exists(sPathFile))
                Directory.CreateDirectory(sPathFile);

            string path = string.Format("{0}Log_{1}.portal", sPathFile, DateTime.Now.ToString("yyyy-MM-dd"));

            using (StreamWriter oStream = new StreamWriter(path, true))
            {
                oStream.WriteLine(":::::::::::::: Seguimiento de Errores Servicio Portal ::::::::::::::");
                oStream.WriteLine(DateTime.Now + " ==> País: " + pais + " - Usuario: " + usuario);
                oStream.WriteLine("Error message: " + faulException.Message);
                oStream.WriteLine("StackTrace: " + faulException.StackTrace);
                oStream.WriteLine(string.Empty);
            }
        }

        public static void LogErrorWebServicesBus(Exception exception, string usuario, string pais, string adicional = "")
        {
            if (!Directory.Exists(sPathFile))
                Directory.CreateDirectory(sPathFile);

            string path = string.Format("{0}Log_{1}.portal", sPathFile, DateTime.Now.ToString("yyyy-MM-dd"));

            using (StreamWriter oStream = new StreamWriter(path, true))
            {
                oStream.WriteLine(":::::::::::::: Seguimiento de Errores Web Portal ::::::::::::::");
                oStream.WriteLine(DateTime.Now + " ==> País: " + pais + " - Usuario: " + usuario);
                oStream.WriteLine("Error message: " + exception.Message);
                oStream.WriteLine("StackTrace: " + exception.StackTrace);
                if (string.IsNullOrEmpty(adicional)) oStream.WriteLine("Adicional: " + adicional);
                oStream.WriteLine(string.Empty);
            }
        }

        public static void LogActions(ErrorsLog model)
        {
            if (!Directory.Exists(sPathFile))
                Directory.CreateDirectory(sPathFile);

            string path = string.Format("{0}Log_{1}.portal", sPathFile, DateTime.Now.ToString("yyyy-MM-dd"));

            using (StreamWriter oStream = new StreamWriter(path, true))
            {
                oStream.WriteLine(":::::::::::::: Seguimiento de Errores Web Portal Controladores ::::::::::::::");
                oStream.WriteLine("Fecha y Hora: " + model.FechaHora + " ==> Controller: " + model.Controller + " - Action: " + model.Action);
                oStream.WriteLine(string.Empty);
            }
        }
    }
}