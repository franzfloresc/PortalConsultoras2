﻿using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.IO;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Transactions;
using Portal.Consultoras.Data;

namespace Portal.Consultoras.BizLogic
{
    public class BLConsultoraDigitales
    {

        public void GetConsultoraDigitalesDescarga(int PaisId, string PaisISO, string FechaProceso, string Usuario)
        {
            int nroLote = 0;
            DAConsultoraDigitales DAConsultoraDigitales = new DAConsultoraDigitales(PaisId);

            string headerFile = null, NombreCabecera = null; string NombreArchivo = null;

            try
            {
                var section = (DataAccessConfiguration)ConfigurationManager.GetSection("Belcorp.Configuration");
                var element = section.Countries[PaisId];

                string OrderTemplate = element.ConsDigTemplate;
                TemplateField[] headerTemplate = ParseTemplate(ConfigurationManager.AppSettings[OrderTemplate]);
                
                DataSet dsCursoLider;
                DataTable dtCursoLider;

                try
                {
                    nroLote = DAConsultoraDigitales.InsConsultoraDigitales(FechaProceso, Usuario);
                    dsCursoLider = DAConsultoraDigitales.GetConsultoraDigitalesDescarga();
                    dtCursoLider = dsCursoLider.Tables[0];
                }
                catch (SqlException ex)
                {
                    if (ex.Number == 50000)
                        throw new BizLogicException("Existe una descarga de consultoras digitales en proceso.", ex);
                    else
                        throw new BizLogicException("No es posible acceder a la información de consultoras digitales.", ex);
                }

                FtpConfigurationElement ftpElement = null;

                Guid fileGuid = Guid.NewGuid();
                string key = PaisISO + "-CONSDIG";
                var ftpSection = (FtpConfigurationSection)ConfigurationManager.GetSection("Belcorp.FtpConfiguration");

                try
                {
                    ftpElement = ftpSection.FtpConfigurations[key];
                    headerFile = FormatFile(PaisISO, ftpElement.Header, FechaProceso, fileGuid);
                    NombreCabecera = headerFile.Replace(ConfigurationManager.AppSettings["OrderDownloadPath"], "");

                    using (var streamWriter = new StreamWriter(headerFile))
                    {
                        if (dtCursoLider.Rows.Count != 0)
                        {
                            foreach (DataRow row in dtCursoLider.Rows)
                            {
                                streamWriter.WriteLine(HeaderLine(headerTemplate, row, PaisISO));
                            }
                        }
                        else
                        {
                            streamWriter.Write(string.Empty);
                        }
                    }
                }
                catch (Exception ex)
                {
                    throw new BizLogicException("No se pudo generar el archivo de descarga de consultora digitales.", ex);
                }

                if (headerFile != null) //Si generó algún archivo continúa
                {
                    if (ConfigurationManager.AppSettings["OrderDownloadFtpUpload"] == "1")
                    {
                        try
                        {
                            NombreArchivo = Path.GetFileNameWithoutExtension(ftpElement.Header) + ""
                                            + FechaProceso + ""
                                            + PaisISO + ""
                                            + Path.GetExtension(ftpElement.Header);

                            BLFileManager.FtpUploadFile(ftpElement.Address + NombreArchivo,
                                headerFile, ftpElement.UserName, ftpElement.Password);
                            
                        }
                        catch (Exception ex)
                        {
                            throw new BizLogicException("No se pudo subir el archivo de consultoras digitales al destino FTP.", ex);
                        }
                    }

                    DAConsultoraDigitales.UpdConsultoraDigitales(nroLote, 2, string.Empty, string.Empty, NombreCabecera, System.Environment.MachineName);

                }
            }
            catch (Exception ex)
            {
                if (nroLote > 0)
                {
                    DAConsultoraDigitales.UpdConsultoraDigitales(nroLote, 99, "Error desconocido: " + ex.Message, string.Empty, string.Empty, string.Empty);
                }
                throw;
            }
        }

        private TemplateField[] ParseTemplate(string templateText)
        {
            string[] parts = templateText.Split(';');
            var template = new TemplateField[parts.Length];
            for (int index = 0; index < parts.Length; index++)
            {
                template[index] = new TemplateField(parts[index]);
            }
            return template;
        }

        private string FormatFile(string PaisISO, string fileName, string FechaProceso, Guid fileGuid)
        {
             return ConfigurationManager.AppSettings["OrderDownloadPath"]
                 + Path.GetFileNameWithoutExtension(fileName) + ""
                 + FechaProceso + ""
                 + PaisISO + ""
                 + Path.GetExtension(fileName);
        }

        private string HeaderLine(TemplateField[] template, DataRow row, string PaisISO)
        {
            string line = string.Empty;
            foreach (TemplateField field in template)
            {
                string item;

                switch (field.FieldName)
                {
                    case "CODCONSULTORA": item = row["CodigoConsultora"].ToString(); break;
                    default: item = string.Empty; break;
                }

                line += item + ",";
            }
            return string.IsNullOrEmpty(line) ? line : line.Substring(0, line.Length - 1);
        }




    }
}
