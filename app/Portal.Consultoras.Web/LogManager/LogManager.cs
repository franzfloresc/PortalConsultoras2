using Portal.Consultoras.Web.CustomFilters;
using System;
using System.Collections.Generic;
using System.Configuration;
using System.IO;
using System.Linq;
using System.ServiceModel;
using System.Web;

namespace Portal.Consultoras.Web.LogManager
{
    public class LogManager
    {
        private static string sPathFile = ConfigurationManager.AppSettings["LogPath"].ToString() + "SB2\\";

        public static void LogActions(ErrorsLog model)
        {
            if (!Directory.Exists(sPathFile))
                Directory.CreateDirectory(sPathFile);

            StreamWriter oStream = new StreamWriter(sPathFile + "Log_" + DateTime.Now.Year.ToString() + "-" + DateTime.Now.Month.ToString().PadLeft(2, '0').ToString() + "-" + DateTime.Now.Day.ToString().PadLeft(2, '0').ToString() + ".portal", true);
            oStream.WriteLine(":::::::::::::: Seguimiento de Controladoras ::::::::::::::");
            oStream.WriteLine("Controladora :" + model.Controller + " - Action : " + model.Action + " - Fecha y Hora :" + model.FechaHora);
            oStream.WriteLine(string.Empty);
            oStream.Flush();
            oStream.Close();
        }

        public static void LogErrorWebServicesPortal(FaultException faulException, string Usuario, string Pais)
        {
            if (!Directory.Exists(sPathFile))
                Directory.CreateDirectory(sPathFile);

            StreamWriter oStream = new StreamWriter(sPathFile + "Log_" + DateTime.Now.Year.ToString() + "-" + DateTime.Now.Month.ToString().PadLeft(2, '0').ToString() + "-" + DateTime.Now.Day.ToString().PadLeft(2, '0').ToString() + ".portal", true);
            oStream.WriteLine(":::::::::::::: Seguimiento de Errores Web Services Portal ::::::::::::::");
            oStream.WriteLine(DateTime.Now + "- " + Usuario + " - Error : " + faulException.Message + "(" + faulException.StackTrace + ").");
            oStream.WriteLine(string.Empty);
            oStream.Flush();
            oStream.Close();
        }

        public static void LogErrorWebServicesBus(Exception expException, string Usuario, string Pais)
        {
            if (!Directory.Exists(sPathFile))
                Directory.CreateDirectory(sPathFile);

            /* PCABRERA GR-2139 - INICIO */

            /*
            StreamWriter oStream = new StreamWriter(sPathFile + "Log_" + DateTime.Now.Year.ToString() + "-" + DateTime.Now.Month.ToString().PadLeft(2, '0').ToString() + "-" + DateTime.Now.Day.ToString().PadLeft(2, '0').ToString() + ".portal", true);
            oStream.WriteLine(":::::::::::::: Seguimiento de Errores ::::::::::::::");
            oStream.WriteLine("País :" + Pais + "==>" + DateTime.Now + "- " + Usuario + " - Error : " + expException.Message + "(" + expException.StackTrace + ").");
            oStream.WriteLine(string.Empty);
            oStream.Flush();
            oStream.Close();            
             * */

            string p = sPathFile + "Log_" + DateTime.Now.Year.ToString() + "-" + DateTime.Now.Month.ToString().PadLeft(2, '0') + "-" + DateTime.Now.Day.ToString().PadLeft(2, '0') + ".portal";
            using (StreamWriter sw = File.AppendText(p))
            {
                sw.WriteLine(":::::::::::::: Seguimiento de Errores ::::::::::::::");
                sw.WriteLine("País :" + Pais + "==>" + DateTime.Now + "- " + Usuario + " - Error : " + expException.Message + "(" + expException.StackTrace + ").");
                sw.WriteLine(string.Empty);
            }
            /* PCABRERA GR-2139 - FIN */
        }
    }
}