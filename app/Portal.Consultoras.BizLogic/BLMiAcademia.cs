using System;
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
    public class BLMiAcademia
    {
        public void GetInformacionCursoLiderDescarga(int PaisId, string PaisISO, string FechaProceso, string Usuario)
        {
            int nroLote = 0;
            DAMiAcademia DAMiAcademia = null;

            string headerFile = null, NombreCabecera = null;

            try
            {
                var section = (DataAccessConfiguration)ConfigurationManager.GetSection("Belcorp.Configuration");
                var element = section.Countries[PaisId];

                string OrderTemplate = element.LetCursoTemplate;
                TemplateField[] headerTemplate = ParseTemplate(ConfigurationManager.AppSettings[OrderTemplate]);


                DAMiAcademia = new DAMiAcademia(PaisId);

                DataSet dsCursoLider;
                DataTable dtCursoLider;

                try
                {
                    nroLote = DAMiAcademia.InsLetCursoDescarga(FechaProceso, Usuario);
                    dsCursoLider = DAMiAcademia.GetInformacionCursoLiderDescarga(nroLote, FechaProceso);
                    dtCursoLider = dsCursoLider.Tables[0];
                }
                catch (SqlException ex)
                {
                    if (ex.Number == 50000) throw new BizLogicException("Existe una descarga de cursos de líderes en proceso.", ex);
                    else throw new BizLogicException("No es posible acceder a la información de cursos de líderes.", ex);
                }

                FtpConfigurationElement ftpElement = null;

                Guid fileGuid = Guid.NewGuid();
                string key = PaisISO + "-LET";
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
                                streamWriter.WriteLine(HeaderLine(headerTemplate, row));
                            }
                        }
                        else streamWriter.Write(string.Empty);
                    }
                }
                catch (Exception ex)
                {
                    throw new BizLogicException("No se pudo generar los archivos de descarga de pedidos.", ex);
                }

                if (headerFile != null) //Si generó algún archivo continúa
                {
                    if (ConfigurationManager.AppSettings["OrderDownloadFtpUpload"] == "1")
                    {
                        try
                        {
                            BLFileManager.FtpUploadFile(ftpElement.Address + ftpElement.Header,
                                headerFile, ftpElement.UserName, ftpElement.Password);
                        }
                        catch (Exception ex)
                        {
                            throw new BizLogicException("No se pudo subir los archivos de Cursos de Líderes al destino FTP.", ex);
                        }
                    }

                    DAMiAcademia.UpdLetCursoDescarga(nroLote, 2, string.Empty, string.Empty, NombreCabecera, System.Environment.MachineName);
                }
            }
            catch (Exception ex)
            {
                if (nroLote > 0)
                {
                    DAMiAcademia.UpdLetCursoDescarga(nroLote, 99, "Error desconocido: " + ex.Message, string.Empty, string.Empty, string.Empty);
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
                + Path.GetFileNameWithoutExtension(fileName) + "-"
                + PaisISO + "-" + FechaProceso + "-"
                + fileGuid.ToString() + Path.GetExtension(fileName);
        }

        private string HeaderLine(TemplateField[] template, DataRow row)
        {
            string line = string.Empty;
            foreach (TemplateField field in template)
            {
                string item;

                switch (field.FieldName)
                {
                    case "CODCONSULTORA": item = row["CodConsultora"].ToString(); break;
                    case "FECHAPROCESO": item = row["FechaProceso"].ToString(); break;
                    case "CAMPANIALIDER": item = row["CampaniaLider"].ToString(); break;
                    case "NIVEL": item = row["Nivel"].ToString(); break;
                    default: item = string.Empty; break;
                }

                line += item + ",";
            }
            return string.IsNullOrEmpty(line) ? line : line.Substring(0, line.Length - 1);
        }
    }
}
