﻿using Portal.Consultoras.Web.CustomFilters;
using System;
using System.Configuration;
using System.IO;
using System.ServiceModel;

namespace Portal.Consultoras.Web.LogManager
{
    public class LogManager : ILogManager
    {
        private static ILogManager instance;
        public static ILogManager Instance
        {
            get
            {
                if (instance == null)
                    instance = new LogManager();

                return instance;
            }
        }

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

        public static void LogErrorWebServicesBus(Exception expException, string Usuario, string Pais, string Paso = "")
        {
            if (!Directory.Exists(sPathFile))
                Directory.CreateDirectory(sPathFile);

            string p = sPathFile + "Log_" + DateTime.Now.Year.ToString() + "-" + DateTime.Now.Month.ToString().PadLeft(2, '0') + "-" + DateTime.Now.Day.ToString().PadLeft(2, '0') + ".portal";
            using (StreamWriter sw = File.AppendText(p))
            {
                sw.WriteLine(":::::::::::::: Seguimiento de Errores ::::::::::::::");
                sw.WriteLine("País : " + Pais + " ==> " + DateTime.Now + " - " + Usuario + " - Error : " + expException.Message + "(" + expException.StackTrace + ") - Paso : " + Paso + ".");
                sw.WriteLine(string.Empty);
            }
        }

        public virtual void LogErrorWebServicesBus2(Exception exception, string usuario, string pais, string paso)
        {
            LogErrorWebServicesBus2(exception, usuario, pais, paso);
        }
    }
}