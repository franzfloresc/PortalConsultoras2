using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.IO;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using Portal.Consultoras.Data;
using Portal.Consultoras.Entities;

namespace Portal.Consultoras.BizLogic
{
    public class BLReporteIntegradoWebDD
    {
        public BEInformacion GetReporteIntegradoWebDD(int PaisID, string PaisISO, int CampaniaIDInicio, int CampaniaIDFin)
        {
            BEInformacion oBEInformacion = new BEInformacion();
            string PrefijoDetalle = string.Empty;
            try
            {
                DAReporteIntegradoWebDD oDAReporteIntegradoWebDD = new DAReporteIntegradoWebDD(PaisID);
                PrefijoDetalle = "Error de Base de Datos: ";
                DateTime FechaHoraPais = new DAPedidoWeb(PaisID).GetFechaHoraPais();
                DataSet dsPedidosWeb = oDAReporteIntegradoWebDD.GetReporteIntegradoWebDD(CampaniaIDInicio, CampaniaIDFin);
                DataTable dtPedidosWeb = dsPedidosWeb.Tables[0];

                FtpConfigurationElement ftpElement = null;

                string key = PaisISO + "-RIWD";
                var ftpSection = (FtpConfigurationSection)ConfigurationManager.GetSection("Belcorp.FtpConfiguration");
                ftpElement = ftpSection.FtpConfigurations[key];

                string File = FormatFile(ftpElement.Header, FechaHoraPais);
                string Nombre = File.Replace(ConfigurationManager.AppSettings["OrderDownloadPath"], "");

                PrefijoDetalle = "Error al Generar el Archivo: ";
                using (var streamWriter = new StreamWriter(File))
                {
                    if (dtPedidosWeb != null && dtPedidosWeb.Rows.Count != 0)
                    {
                        foreach (DataRow row in dtPedidosWeb.Rows)
                        {
                            streamWriter.WriteLine(FormatLine(row));
                        }
                    }
                    else
                    {
                        streamWriter.Write(string.Empty);
                    }
                }
                PrefijoDetalle = "Error al Cargar el Archivo en el FTP: ";

                if (ConfigurationManager.AppSettings["OrderDownloadFtpUpload"] == "1")
                {
                    BLFileManager.FtpUploadFile(ftpElement.Address + Nombre,
                                                File, ftpElement.UserName, ftpElement.Password);
                }

                oBEInformacion.CodigoInformacion = 0;
                oBEInformacion.DetalleInformacion = Nombre;

            }
            catch (Exception ex)
            { 
                oBEInformacion.CodigoInformacion = 1;
                oBEInformacion.DetalleInformacion = PrefijoDetalle + ex.Message;
            }

            return oBEInformacion;
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
        private string FormatFile(string fileName, DateTime date)
        {
            return ConfigurationManager.AppSettings["OrderDownloadPath"]
                + Path.GetFileNameWithoutExtension(fileName)
                + date.ToString("ddMMyyhhmmss") 
                + Path.GetExtension(fileName);
        }
        private string FormatLine(DataRow row)
        {
            string Line = string.Empty;

            foreach (var item in row.ItemArray)
            {
                Line += Convert.ToString(item) + ";";
            }

            return Line.Substring(0, Line.Length - 1);
        }
    }
}
