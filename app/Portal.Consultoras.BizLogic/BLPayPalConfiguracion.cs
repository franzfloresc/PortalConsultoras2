using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Data;
using Portal.Consultoras.Entities;
using Portal.Consultoras.Data;
using System.IO;
using System.Transactions;
using System.Configuration;
using System.Data.SqlClient;
using System.Net;
using Portal.Consultoras.Common;

namespace Portal.Consultoras.BizLogic
{
    public class BLPayPalConfiguracion
    {
        public IList<BEPayPalConfiguracion> GetConfiguracionPayPal(int paisID)
        {
            var configuracionPayPal = new List<BEPayPalConfiguracion>();
            var DAConfigPayPal = new DAPayPalConfiguracion(paisID);

            using (IDataReader reader = DAConfigPayPal.GetConfiguracionPayPal())
                while (reader.Read())
                {
                    var cronograma = new BEPayPalConfiguracion(reader);
                    configuracionPayPal.Add(cronograma);
                }

            return configuracionPayPal;
        }

        public int InsDatosPago(int paisID, string chrCodigoConsultora, string chrCodigoTerritorio, decimal montoAbono, string chrNumeroTarjeta, DateTime datFechaTransaccion, Int16 estado)
        {
            var DAPayPalPagos = new DAPayPalPagos(paisID);
            return DAPayPalPagos.InsDatosPago(chrCodigoConsultora, chrCodigoTerritorio, montoAbono, chrNumeroTarjeta, datFechaTransaccion, estado);
        }

        public int InsAbonoPago(int paisID, string chrCodigoPais, string chrCodigoConsultora, decimal mnyMontoAbono, string chrCodigoAutorizacionBanco, string chrCodigoTransaccion, int chrResultado)
        {
            var DAPayPalPagos = new DAPayPalPagos(paisID);
            return DAPayPalPagos.InsAbonoPago(chrCodigoPais, chrCodigoConsultora, mnyMontoAbono, chrCodigoAutorizacionBanco, chrCodigoTransaccion, chrResultado);
        }

        public bool ExistePagoPendiente(int paisID, decimal mnyMontoAbono, string chrNumeroTarjeta, DateTime datFecha)
        {
            bool rslt = false;
            var DAConfigPayPal = new DAPayPalPagos(paisID);

            using (IDataReader reader = DAConfigPayPal.ValidarPagoExistente(mnyMontoAbono, chrNumeroTarjeta, datFecha))
                while (reader.Read())
                {
                    rslt = true;
                }

            return rslt;
        }

        public IList<BEPayPalConfiguracion> GetReporteAbonos(int paisID, string chrCodigoPais, string chrCodigoConsultora, int intDia, int intMes, int intAnho, string chrRETCodigoTransaccion)
        {
            var configuracionPayPal = new List<BEPayPalConfiguracion>();
            var DAConfigPayPal = new DAPayPalPagos(paisID);

            using (IDataReader reader = DAConfigPayPal.GetReporteAbonos(chrCodigoPais, chrCodigoConsultora, intDia, intMes, intAnho, chrRETCodigoTransaccion))
                while (reader.Read())
                {
                    var cronograma = new BEPayPalConfiguracion(reader, 1);
                    configuracionPayPal.Add(cronograma);
                }

            return configuracionPayPal;
        }

        public string[] DescargaPaypal(int paisID, string codigoUsuario, DateTime fechaEjecucion)
        {
            var numeroLote = 0;
            var fechaProceso = DateTime.Now;
            var daPaypalPagos = new DAPayPalPagos(paisID);

            var blZonificacion = new BLZonificacion();
            var bePais = blZonificacion.SelectPais(paisID);
            var codigoPais = bePais.CodigoISO;

            string pathFilePaypal = string.Empty, filePaypal = string.Empty;
            string s = null, r = null;

            try
            {
                try
                {
                    numeroLote = daPaypalPagos.InsPaypalDescarga(codigoUsuario);
                }
                catch (SqlException ex)
                {
                    if (ex.Number == 50000)
                        throw new BizLogicException("Existe una descarga de paypal en proceso actualmente.", ex);

                    throw new BizLogicException("Error durante la Inicio del proceso descarga Paypal.", ex);
                }

                DataTable dtPaypal;

                try
                {
                    var ds = daPaypalPagos.GetPagoPaypalNoEnviadas(numeroLote, fechaEjecucion);

                    if (ds.Tables.Count == 1)
                    {
                        dtPaypal = ds.Tables[0];
                    }
                    else
                    {
                        dtPaypal = new DataTable();
                    }
                }
                catch (SqlException ex)
                {
                    throw new BizLogicException("No se pudo obtener el set de datos con las descargas de Paypal.", ex);
                }

                var keyPaypal = string.Format("{0}-PAYPAL", codigoPais);

                var ftpSection = (FtpConfigurationSection)ConfigurationManager.GetSection("Belcorp.FtpConfiguration");
                FtpConfigurationElement ftpElementPaypal = ftpSection.FtpConfigurations[keyPaypal];

                var fileGuid = Guid.NewGuid();
                filePaypal = FormatFile(codigoPais, ftpElementPaypal.Header, fechaProceso, fileGuid);

                var path = ConfigurationManager.AppSettings.Get("OrderDownloadPath");
                pathFilePaypal = path + filePaypal;

                try
                {
                    using (var streamWriter = new StreamWriter(pathFilePaypal, true, Encoding.GetEncoding(1252)))
                    {
                        if (dtPaypal.Rows.Count > 0)
                        {
                            foreach (DataRow row in dtPaypal.Rows)
                            {
                                streamWriter.WriteLine(BuildLine(row));
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
                    throw new BizLogicException("No se pudo generar el archivo para la descarga de Paypal.", ex);
                }

                try
                {
                    string fileName = Path.GetFileName(pathFilePaypal);
                    if (!string.IsNullOrEmpty(fileName))
                    {
                        r = fileName;
                        string carpetaPais = ConfigurationManager.AppSettings["S3_PagoEnLinea"] + codigoPais;
                        ConfigS3.SetFileS3(pathFilePaypal, carpetaPais, fileName, false, false, true);
                        s = ConfigS3.GetUrlFileS3WithAuthentication(carpetaPais, fileName, "");
                    }
                }
                catch (Exception ex) { throw new BizLogicException("No se pudo subir los archivos de Paypal al S3.", ex); }

                TransactionOptions transactionOptions = new TransactionOptions();
                transactionOptions.IsolationLevel = System.Transactions.IsolationLevel.ReadUncommitted;
                using (TransactionScope transaction = new TransactionScope(TransactionScopeOption.Required, transactionOptions))
                {
                    daPaypalPagos.UpdPaypalPasarelaPago(numeroLote);
                    daPaypalPagos.UpdPaypalDescarga(numeroLote, 2, "Terminado Ok.",null, filePaypal, Environment.MachineName);

                    transaction.Complete();
                }
            }
            catch (Exception ex)
            {
                if (numeroLote > 0)
                {
                    string message = "Error desconocido.", messageException = null;
                    if (ex is BizLogicException)
                    {
                        message = ex.Message;
                        if(ex.InnerException != null) messageException = ex.InnerException.Message + "(" + ex.InnerException.StackTrace + ")";
                    }
                    daPaypalPagos.UpdPaypalDescarga(numeroLote, 99, message, messageException, string.Empty, Environment.MachineName);
                }

                throw;
            }

            return new string[] { s, r };
        }

        private static string FormatFile(string codigoPais, string fileName, DateTime date, Guid fileGuid)
        {
            return string.Format("{0}-{1}-{2}-{3}{4}",
                Path.GetFileNameWithoutExtension(fileName),
                codigoPais,
                date.ToString("yyyyMMdd"),
                fileGuid,
                Path.GetExtension(fileName));
        }

        private static string BuildLine(DataRow row)
        {
            var line = string.Empty;

            if (row.Table.Columns.Contains("REGISTROS"))
            {
                if (row["REGISTROS"] != DBNull.Value)
                {
                    line = row["REGISTROS"].ToString();
                }
            }

            return line;
        }

    }
}
