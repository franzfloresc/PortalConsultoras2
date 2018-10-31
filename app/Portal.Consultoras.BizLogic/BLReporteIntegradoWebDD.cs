using Portal.Consultoras.Data;
using Portal.Consultoras.Entities;
using System;
using System.Configuration;
using System.Data;
using System.IO;
using System.Text;

namespace Portal.Consultoras.BizLogic
{
    public class BLReporteIntegradoWebDD
    {
        public BEInformacion GetReporteIntegradoWebDD(int PaisID, string PaisISO, int CampaniaIDInicio, int CampaniaIDFin)
        {
            BEInformacion obeInformacion = new BEInformacion();
            string prefijoDetalle = string.Empty;
            try
            {
                DAReporteIntegradoWebDD odaReporteIntegradoWebDd = new DAReporteIntegradoWebDD(PaisID);
                prefijoDetalle = "Error de Base de Datos: ";
                DateTime fechaHoraPais = new DAPedidoWeb(PaisID).GetFechaHoraPais();
                DataSet dsPedidosWeb = odaReporteIntegradoWebDd.GetReporteIntegradoWebDD(CampaniaIDInicio, CampaniaIDFin);
                DataTable dtPedidosWeb = dsPedidosWeb.Tables[0];

                string key = PaisISO + "-RIWD";
                var ftpSection = (FtpConfigurationSection)ConfigurationManager.GetSection("Belcorp.FtpConfiguration");
                var ftpElement = ftpSection.FtpConfigurations[key];

                string file = FormatFile(ftpElement.Header, fechaHoraPais);
                string nombre = file.Replace(ConfigurationManager.AppSettings["OrderDownloadPath"], "");

                prefijoDetalle = "Error al Generar el Archivo: ";
                using (var streamWriter = new StreamWriter(file))
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
                prefijoDetalle = "Error al Cargar el Archivo en el FTP: ";

                if (ConfigurationManager.AppSettings["OrderDownloadFtpUpload"] == "1")
                {
                    BLFileManager.FtpUploadFile(ftpElement.Address + nombre,
                                                file, ftpElement.UserName, ftpElement.Password);
                }

                obeInformacion.CodigoInformacion = 0;
                obeInformacion.DetalleInformacion = nombre;

            }
            catch (Exception ex)
            {
                obeInformacion.CodigoInformacion = 1;
                obeInformacion.DetalleInformacion = prefijoDetalle + ex.Message;
            }

            return obeInformacion;
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
            var txtBuil = new StringBuilder();
            foreach (var item in row.ItemArray)
            {
                txtBuil.Append(Convert.ToString(item) + ";");
            }
            string line = txtBuil.ToString();
            return string.IsNullOrEmpty(line) ? line : line.Substring(0, line.Length - 1);
        }
    }
}
