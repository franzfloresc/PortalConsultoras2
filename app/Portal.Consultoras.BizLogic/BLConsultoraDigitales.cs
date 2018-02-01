using Portal.Consultoras.Data;
using System;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.IO;

namespace Portal.Consultoras.BizLogic
{
    public class BLConsultoraDigitales
    {

        public void GetConsultoraDigitalesDescarga(int PaisId, string PaisISO, string FechaProceso, string Usuario)
        {
            int nroLote = 0;
            DAConsultoraDigitales daConsultoraDigitales = new DAConsultoraDigitales(PaisId);

            try
            {
                var section = (DataAccessConfiguration)ConfigurationManager.GetSection("Belcorp.Configuration");
                var element = section.Countries[PaisId];

                string orderTemplate = element.ConsDigTemplate;
                TemplateField[] headerTemplate = ParseTemplate(ConfigurationManager.AppSettings[orderTemplate]);

                DataTable dtCursoLider;

                try
                {
                    nroLote = daConsultoraDigitales.InsConsultoraDigitales(FechaProceso, Usuario);
                    var dsCursoLider = daConsultoraDigitales.GetConsultoraDigitalesDescarga();
                    dtCursoLider = dsCursoLider.Tables[0];
                }
                catch (SqlException ex)
                {
                    if (ex.Number == 50000)
                        throw new BizLogicException("Existe una descarga de consultoras digitales en proceso.", ex);

                    throw new BizLogicException("No es posible acceder a la información de consultoras digitales.", ex);
                }

                FtpConfigurationElement ftpElement;

                Guid fileGuid = Guid.NewGuid();
                string key = PaisISO + "-CONSDIG";
                var ftpSection = (FtpConfigurationSection)ConfigurationManager.GetSection("Belcorp.FtpConfiguration");

                string headerFile;
                string nombreCabecera;
                try
                {
                    ftpElement = ftpSection.FtpConfigurations[key];
                    headerFile = FormatFile(PaisISO, ftpElement.Header, FechaProceso, fileGuid);
                    nombreCabecera = headerFile.Replace(ConfigurationManager.AppSettings["OrderDownloadPath"], "");

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
                            var nombreArchivo = Path.GetFileNameWithoutExtension(ftpElement.Header) + ""
                                                                                                       + FechaProceso + ""
                                                                                                       + PaisISO + ""
                                                                                                       + Path.GetExtension(ftpElement.Header);

                            BLFileManager.FtpUploadFile(ftpElement.Address + nombreArchivo,
                                headerFile, ftpElement.UserName, ftpElement.Password);
                        }
                        catch (Exception ex)
                        {
                            throw new BizLogicException("No se pudo subir el archivo de consultoras digitales al destino FTP.", ex);
                        }
                    }

                    daConsultoraDigitales.UpdConsultoraDigitales(nroLote, 2, string.Empty, string.Empty, nombreCabecera, System.Environment.MachineName);

                }
            }
            catch (Exception ex)
            {
                if (nroLote > 0)
                {
                    daConsultoraDigitales.UpdConsultoraDigitales(nroLote, 99, "Error desconocido: " + ex.Message, string.Empty, string.Empty, string.Empty);
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
