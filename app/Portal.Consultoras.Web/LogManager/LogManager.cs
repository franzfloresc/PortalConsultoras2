﻿using Portal.Consultoras.Web.CustomFilters;
using System;
using System.Configuration;
using System.IO;
using System.ServiceModel;

namespace Portal.Consultoras.Web.LogManager
{
    public class LogManager:ILogManager
    {
        private static ILogManager _instance;

        public static ILogManager Instance
        {
            get
            {
                if (_instance == null)
                    _instance = new LogManager();

                return _instance;
            }
        }

        private static string pathFile = ConfigurationManager.AppSettings["LogPath"].ToString() + "SB2\\";

        public static void LogErrorWebServicesPortal(FaultException exception, string usuario, string pais)
        {
            Common.LogManager.SaveLog(new Common.LogError
            {
                Exception = exception,
                CodigoUsuario = usuario,
                IsoPais = pais,
                Origen = "ServidorWeb",
                Titulo = "Seguimiento de Errores Servicio Portal"
            }, pathFile);
        }

        public static void LogErrorWebServicesBus(Exception exception, string usuario, string pais, string adicional = "")
        {
            Common.LogManager.SaveLog(new Common.LogError
            {
                Exception = exception,
                CodigoUsuario = usuario ?? "",
                IsoPais = pais,
                InformacionAdicional = adicional,
                Origen = "ServidorWeb",
                Titulo = "Seguimiento de Errores Web Portal"
            }, pathFile);
        }
        public void LogErrorWebServicesBusWrap(Exception exception, string usuario, string pais, string adicional = "")
        {
            LogManager.LogErrorWebServicesBus(exception, usuario, pais, adicional);
        }

        public static void LogActions(ErrorsLog model)
        {
            if (!Directory.Exists(pathFile))
                Directory.CreateDirectory(pathFile);

            string path = string.Format("{0}Log_{1}.portal", pathFile, DateTime.Now.ToString("yyyy-MM-dd"));

            using (StreamWriter oStream = new StreamWriter(path, true))
            {
                oStream.WriteLine(":::::::::::::: Seguimiento de Errores Web Portal Controladores ::::::::::::::");
                oStream.WriteLine("Fecha y Hora: " + model.FechaHora + " ==> Controller: " + model.Controller + " - Action: " + model.Action);
                oStream.WriteLine(string.Empty);
            }
        }
    }
}