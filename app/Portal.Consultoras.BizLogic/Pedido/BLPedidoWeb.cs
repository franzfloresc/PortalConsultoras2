using Portal.Consultoras.Common;
using Portal.Consultoras.Data;
using Portal.Consultoras.Data.Hana;
using Portal.Consultoras.Entities;
using Portal.Consultoras.Entities.Pedido;
using Portal.Consultoras.PublicService.Cryptography;

using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.IO;
using System.Linq;
using System.Transactions;

namespace Portal.Consultoras.BizLogic
{
    public class BLPedidoWeb : IPedidoWebBusinessLogic
    {
        public int ValidarCargadePedidos(int paisID, int TipoCronograma, int MarcaPedido, DateTime FechaFactura)
        {
            var DAPedidoWeb = new DAPedidoWeb(paisID);
            int rslt = DAPedidoWeb.ValidarCargadePedidos(TipoCronograma, MarcaPedido, FechaFactura);
            return rslt;
        }

        public IList<BEPedidoWeb> GetPedidosWebByConsultora(int paisID, long consultoraID)
        {
            var pedidoWeb = new List<BEPedidoWeb>();
            var DAPedidoWeb = new DAPedidoWeb(paisID);

            using (IDataReader reader = DAPedidoWeb.GetPedidosWebByConsultora(consultoraID))
                while (reader.Read())
                {
                    var entidad = new BEPedidoWeb(reader)
                    {
                        PaisID = paisID
                    };
                    pedidoWeb.Add(entidad);
                }

            return pedidoWeb;
        }

        public IList<BEPedidoDDWeb> GetPedidosDDWeb(BEPedidoDDWeb BEPedidoDDWeb)
        {
            var pedidoDDWeb = new List<BEPedidoDDWeb>();

            pedidoDDWeb.Add(new BEPedidoDDWeb { CampaniaID = 10010, PedidoID = 10001, NroRegistro = "000001", FechaRegistro = Convert.ToDateTime("01/01/2013 10:00:00"), CampaniaCodigo = "CM001 - 2013", Seccion = "S0001", ConsultoraCodigo = "C00001", ConsultoraNombre = "Consultora 01", ImporteTotal = 80, UsuarioResponsable = "Usuario 1", ConsultoraSaldo = 12, OrigenNombre = "DD", EstadoValidacionNombre = "SI" });
            pedidoDDWeb.Add(new BEPedidoDDWeb { CampaniaID = 10009, PedidoID = 10002, NroRegistro = "000002", FechaRegistro = Convert.ToDateTime("01/01/2013 10:00:00"), CampaniaCodigo = "CM001 - 2013", Seccion = "S0002", ConsultoraCodigo = "C00002", ConsultoraNombre = "Consultora 02", ImporteTotal = 970, UsuarioResponsable = "Usuario 2", ConsultoraSaldo = 15, OrigenNombre = "Web", EstadoValidacionNombre = "NO" });
            pedidoDDWeb.Add(new BEPedidoDDWeb { CampaniaID = 10008, PedidoID = 10003, NroRegistro = "000003", FechaRegistro = Convert.ToDateTime("02/01/2013 10:00:00"), CampaniaCodigo = "CM002 - 2013", Seccion = "S0003", ConsultoraCodigo = "C00003", ConsultoraNombre = "Consultora 03", ImporteTotal = 900, UsuarioResponsable = "Usuario 2", ConsultoraSaldo = 14, OrigenNombre = "DD", EstadoValidacionNombre = "NO" });
            pedidoDDWeb.Add(new BEPedidoDDWeb { CampaniaID = 10007, PedidoID = 10004, NroRegistro = "000004", FechaRegistro = Convert.ToDateTime("03/01/2013 10:00:00"), CampaniaCodigo = "CM001 - 2013", Seccion = "S0004", ConsultoraCodigo = "C00004", ConsultoraNombre = "Consultora 04", ImporteTotal = 870, UsuarioResponsable = "Usuario 1", ConsultoraSaldo = 0, OrigenNombre = "Web", EstadoValidacionNombre = "NO" });
            pedidoDDWeb.Add(new BEPedidoDDWeb { CampaniaID = 10006, PedidoID = 10005, NroRegistro = "000005", FechaRegistro = Convert.ToDateTime("04/01/2013 10:00:00"), CampaniaCodigo = "CM003 - 2013", Seccion = "S0005", ConsultoraCodigo = "C00005", ConsultoraNombre = "Consultora 05", ImporteTotal = 420, UsuarioResponsable = "Usuario 2", ConsultoraSaldo = 56, OrigenNombre = "DD", EstadoValidacionNombre = "SI" });
            pedidoDDWeb.Add(new BEPedidoDDWeb { CampaniaID = 10005, PedidoID = 10006, NroRegistro = "000006", FechaRegistro = Convert.ToDateTime("05/01/2013 10:00:00"), CampaniaCodigo = "CM004 - 2013", Seccion = "S0006", ConsultoraCodigo = "C00001", ConsultoraNombre = "Consultora 02", ImporteTotal = 350, UsuarioResponsable = "Usuario 1", ConsultoraSaldo = 57, OrigenNombre = "DD", EstadoValidacionNombre = "SI" });
            pedidoDDWeb.Add(new BEPedidoDDWeb { CampaniaID = 10004, PedidoID = 10007, NroRegistro = "000007", FechaRegistro = Convert.ToDateTime("05/01/2013 10:00:00"), CampaniaCodigo = "CM002 - 2013", Seccion = "S0007", ConsultoraCodigo = "C00006", ConsultoraNombre = "Consultora 04", ImporteTotal = 2000, UsuarioResponsable = "Usuario 3", ConsultoraSaldo = 23, OrigenNombre = "Web", EstadoValidacionNombre = "NO" });
            pedidoDDWeb.Add(new BEPedidoDDWeb { CampaniaID = 10003, PedidoID = 10008, NroRegistro = "000008", FechaRegistro = Convert.ToDateTime("05/01/2013 10:00:00"), CampaniaCodigo = "CM003 - 2013", Seccion = "S0006", ConsultoraCodigo = "C00005", ConsultoraNombre = "Consultora 01", ImporteTotal = 4420, UsuarioResponsable = "Usuario 1", ConsultoraSaldo = 45, OrigenNombre = "DD", EstadoValidacionNombre = "SI" });
            pedidoDDWeb.Add(new BEPedidoDDWeb { CampaniaID = 10002, PedidoID = 10009, NroRegistro = "000009", FechaRegistro = Convert.ToDateTime("07/01/2013 10:00:00"), CampaniaCodigo = "CM001 - 2013", Seccion = "S0005", ConsultoraCodigo = "C00002", ConsultoraNombre = "Consultora 03", ImporteTotal = 2230, UsuarioResponsable = "Usuario 4", ConsultoraSaldo = 89, OrigenNombre = "Web", EstadoValidacionNombre = "NO" });
            pedidoDDWeb.Add(new BEPedidoDDWeb { CampaniaID = 10001, PedidoID = 10010, NroRegistro = "000010", FechaRegistro = Convert.ToDateTime("08/01/2013 10:00:00"), CampaniaCodigo = "CM004 - 2013", Seccion = "S0004", ConsultoraCodigo = "C00004", ConsultoraNombre = "Consultora 08", ImporteTotal = 1230, UsuarioResponsable = "Usuario 5", ConsultoraSaldo = 123, OrigenNombre = "Web", EstadoValidacionNombre = "SI" });

            return pedidoDDWeb;
        }

        public string[] DescargaPedidosWeb(int paisID, DateTime fechaFacturacion, int tipoCronograma, bool marcarPedido, string usuario, string descripcionProceso)
        {
            int nroLote = 0;
            DAPedidoWeb DAPedidoWeb = null;

            DataSet dsPedidosDD = null;
            DataTable dtPedidosDD = null;
            DAPedidoDD DAPedidoDD = null;

            Exception exceptionCoDat = null;
            string headerFile = null, detailFile = null, NombreCabecera = null, NombreDetalle = null, dataConFile = null, NombreCoDat = null, ErrorCoDat = null;
            string detailFileAct = null, NombreDetalleAct = null;
            string headerFileS3 = null, detailFileS3 = null, dataConFileS3 = null;
            DateTime FechaHoraPais;
            bool incluirConsultora = ConfigurationManager.AppSettings["OrderDownloadIncludeDatosConsultora"] == "1" && tipoCronograma == 1;

            try
            {
                FechaHoraPais = new DAPedidoWeb(paisID).GetFechaHoraPais();
            }
            catch
            {
                FechaHoraPais = DateTime.Now;
            }

            bool isFox = false;
            string codigoPais = null, codigoPaisProd = null;

            try
            {
                codigoPais = new BLZonificacion().SelectPais(paisID).CodigoISO;
                codigoPaisProd = new BLZonificacion().SelectPais(paisID).CodigoISOProd;

                int TmpCronograma;
                if (tipoCronograma == 2 && marcarPedido)
                    TmpCronograma = 3;
                else
                    TmpCronograma = tipoCronograma;

                TemplateField[] headerTemplate, detailTemplate, actdatosTemplate;
                var section = (DataAccessConfiguration)ConfigurationManager.GetSection("Belcorp.Configuration");
                var element = section.Countries[paisID];

                string OrderHeaderTemplate = null;
                if (ConfigurationManager.AppSettings["HasDiffCA-PRD"].Contains(codigoPais) && TmpCronograma != 1)
                    OrderHeaderTemplate = element.OrderHeaderTemplate + "PRD";
                else
                {
                    if (codigoPais == "CO")
                    {
                        if (TmpCronograma == 2)
                            OrderHeaderTemplate = element.OrderHeaderTemplate + "DA";
                        else
                            OrderHeaderTemplate = element.OrderHeaderTemplate;
                    }
                    else
                        OrderHeaderTemplate = element.OrderHeaderTemplate;
                }

                headerTemplate = ParseTemplate(ConfigurationManager.AppSettings[OrderHeaderTemplate]);

                if (codigoPais == "CO")
                {
                    if (TmpCronograma == 2)
                        detailTemplate = ParseTemplate(ConfigurationManager.AppSettings[element.OrderDetailTemplate + "DA"]);
                    else
                        detailTemplate = ParseTemplate(ConfigurationManager.AppSettings[element.OrderDetailTemplate]);
                }
                else
                    detailTemplate = ParseTemplate(ConfigurationManager.AppSettings[element.OrderDetailTemplate]);

                DAPedidoWeb = new DAPedidoWeb(paisID);

                DataSet dsPedidosWeb;
                DataTable dtPedidosWeb;
                isFox = ConfigurationManager.AppSettings["IsFOX"].Contains(codigoPais);

                try
                {

                    DAPedidoWeb.InsPedidoDescarga(fechaFacturacion, 1, tipoCronograma, marcarPedido, usuario, out nroLote);
                    if (isFox)
                    {
                        if (ConfigurationManager.AppSettings["OrderDownloadIncludeDD"] == "1")
                        {
                            try
                            {
                                DAPedidoDD = new DAPedidoDD(paisID);

                                DAPedidoDD.GetPedidoDDByFechaFacturacionFox(codigoPais, tipoCronograma, fechaFacturacion, nroLote, new string[] { element.DDName, element.DbName });
                            }
                            catch (SqlException ex)
                            {
                                LogManager.SaveLog(ex, usuario, codigoPais);
                                throw new BizLogicException("No se pudo acceder al origen de datos de pedidos DD.", ex);
                            }
                        }
                    }

                    dsPedidosWeb = DAPedidoWeb.GetPedidoWebByFechaFacturacion(fechaFacturacion, TmpCronograma, nroLote);
                    dtPedidosWeb = dsPedidosWeb.Tables[0]; // Obtiene cabecera
                }
                catch (SqlException ex)
                {
                    if (ex.Number == 50000)
                        throw new BizLogicException("Existe una descarga de pedidos en proceso para la fecha seleccionada.", ex);
                    else
                        throw new BizLogicException("No se pudo acceder al origen de datos de pedidos Web.", ex);
                }

                if (ConfigurationManager.AppSettings["OrderDownloadIncludeDD"] == "1" && !isFox)
                {
                    try
                    {
                        DAPedidoDD = new DAPedidoDD(paisID);
                        dsPedidosDD = DAPedidoDD.GetPedidoDDByFechaFacturacion(codigoPais, tipoCronograma, fechaFacturacion, nroLote);
                        dtPedidosDD = dsPedidosDD.Tables[0];
                    }
                    catch (SqlException ex)
                    {
                        LogManager.SaveLog(ex, usuario, codigoPais);
                        throw new BizLogicException("No se pudo acceder al origen de datos de pedidos DD.", ex);
                    }
                }
                
                DataSet dsDatosConsultora = null;
                DataTable dtDatosConsultora = null;

                if (incluirConsultora)
                {
                    try
                    {
                        dsDatosConsultora = DAPedidoWeb.GetDatosConsultoraProcesoCarga(nroLote, usuario);
                        dtDatosConsultora = dsDatosConsultora.Tables[0];
                    }
                    catch (SqlException ex)
                    {
                        LogManager.SaveLog(ex, usuario, codigoPais);
                        exceptionCoDat = ex;
                        ErrorCoDat = "No se pudo acceder a la información de las Consultoras.";
                    }
                }

                TransactionOptions transactionOptions = new TransactionOptions();
                transactionOptions.IsolationLevel = System.Transactions.IsolationLevel.ReadUncommitted;
                using (TransactionScope transaction = new TransactionScope(TransactionScopeOption.Required, transactionOptions))
                {
                    this.ConfigurarDTCargaWebDD(dsPedidosWeb, dsPedidosDD, fechaFacturacion, nroLote, usuario, codigoPais);
                    DAPedidoWeb.InsLogPedidoDescargaWebDD(dsPedidosWeb, dsPedidosDD);
                    DAPedidoWeb.UpdLogPedidoDescargaWebDD(nroLote);
                    transaction.Complete();
                }


                FtpConfigurationElement ftpElement = null;
                FtpConfigurationElement ftpElementCoDat = null;
                FtpConfigurationElement ftpElementActDAt = null;

                Guid fileGuid = Guid.NewGuid();
                string key = codigoPais + "-" + (tipoCronograma == 1 ? "DR" : marcarPedido ? "DA-PRD" : "DA");
                String keyActDat = codigoPais + "-" + "ACDAT";
                var ftpSection = (FtpConfigurationSection)ConfigurationManager.GetSection("Belcorp.FtpConfiguration");

                try
                {

                    ftpElement = ftpSection.FtpConfigurations[key];
                    ftpElementActDAt = ftpSection.FtpConfigurations[keyActDat];

                    headerFileS3 = headerFile = FormatFile(codigoPais, ftpElement.Header, fechaFacturacion, fileGuid);
                    detailFileS3 = detailFile = FormatFile(codigoPais, ftpElement.Detail, fechaFacturacion, fileGuid);
                    detailFileAct = FormatFile(codigoPais, ftpElementActDAt.Detail, fechaFacturacion, fileGuid);


                    NombreCabecera = headerFile.Replace(ConfigurationManager.AppSettings["OrderDownloadPath"], "");
                    NombreDetalle = detailFile.Replace(ConfigurationManager.AppSettings["OrderDownloadPath"], "");
                    NombreDetalleAct = detailFileAct.Replace(ConfigurationManager.AppSettings["OrderDownloadPath"], "");

                    string fechaFactura = fechaFacturacion.ToString("yyyyMMdd");
                    string fechaProceso = DateTime.Now.ToString("yyyyMMdd");
                    string lote = nroLote.ToString();

                    using (var streamWriter = new StreamWriter(headerFile))
                    {
                        if (dtPedidosWeb.Rows.Count != 0 && dsPedidosWeb.Tables[1].Rows.Count > 0)
                        {
                            foreach (DataRow row in dtPedidosWeb.Rows)
                            {
                                streamWriter.WriteLine(HeaderLine(headerTemplate, row, codigoPaisProd, fechaProceso, fechaFactura, lote, "W"));
                            }

                            if (dtPedidosDD != null)
                            {
                                foreach (DataRow row in dtPedidosDD.Rows)
                                {
                                    streamWriter.WriteLine(HeaderLine(headerTemplate, row, codigoPaisProd, fechaProceso, fechaFactura, lote, "D"));
                                }
                            }
                        }
                        else
                        {
                            if (dtPedidosDD != null)
                            {
                                foreach (DataRow row in dtPedidosDD.Rows)
                                {
                                    streamWriter.WriteLine(HeaderLine(headerTemplate, row, codigoPaisProd, fechaProceso, fechaFactura, lote, "D"));
                                }
                            }
                            else
                                streamWriter.Write(string.Empty);
                        }
                    }

                    dtPedidosWeb = dsPedidosWeb.Tables[1];
                    if (dsPedidosDD != null)
                        dtPedidosDD = dsPedidosDD.Tables[1];

                    using (var streamWriter = new StreamWriter(detailFile))
                    {
                        if (dtPedidosWeb.Rows.Count != 0)
                        {
                            foreach (DataRow row in dtPedidosWeb.Rows)
                            {
                                streamWriter.WriteLine(DetailLine(detailTemplate, row, codigoPaisProd, lote));
                            }

                            if (dtPedidosDD != null)
                            {
                                foreach (DataRow row in dtPedidosDD.Rows)
                                {
                                    streamWriter.WriteLine(DetailLine(detailTemplate, row, codigoPaisProd, lote));
                                }
                            }
                        }
                        else
                        {
                            if (dtPedidosDD != null)
                            {
                                foreach (DataRow row in dtPedidosDD.Rows)
                                {
                                    streamWriter.WriteLine(DetailLine(detailTemplate, row, codigoPaisProd, lote));
                                }
                            }
                            else
                                streamWriter.Write(string.Empty);
                        }
                    }



                }
                catch (Exception ex)
                {
                    LogManager.SaveLog(ex, usuario, codigoPais);
                    throw new BizLogicException("No se pudo generar los archivos de descarga de pedidos.", ex);
                }

                if (incluirConsultora && string.IsNullOrEmpty(ErrorCoDat))
                {
                    try
                    {
                        bool descargaActDatosv2 = ConfigurationManager.AppSettings["DescargaActDatosv2"] == "1";
                        actdatosTemplate = ParseTemplate(ConfigurationManager.AppSettings[element.ActDatosTemplate], descargaActDatosv2);
                        ftpElementCoDat = ftpSection.FtpConfigurations[codigoPais + "-ACDAT"];
                        dataConFileS3 = dataConFile = FormatFile(codigoPais, ftpElementCoDat.Header, fechaFacturacion, fileGuid);

                        NombreCoDat = dataConFile.Replace(ConfigurationManager.AppSettings["OrderDownloadPath"], "");

                        using (var streamWriter = new StreamWriter(dataConFile))
                        {
                            if (dtDatosConsultora != null && dtDatosConsultora.Rows.Count != 0)
                            {
                                foreach (DataRow row in dtDatosConsultora.Rows)
                                {
                                    streamWriter.WriteLine(CoDatLine(actdatosTemplate, row, codigoPaisProd));
                                }
                            }
                            else streamWriter.Write(string.Empty);
                        }
                    }
                    catch (Exception ex)
                    {
                        LogManager.SaveLog(ex, usuario, codigoPais);
                        exceptionCoDat = ex;
                        ErrorCoDat = "No se pudo generar los archivos de datos de consultora.";
                    }
                }

                if (headerFile != null)
                {
                    if (ConfigurationManager.AppSettings["OrderDownloadCompress"] == "1")
                    {
                        string zipHeaderFile = Path.ChangeExtension(headerFile, "zip");
                        string zipDetailFile = Path.ChangeExtension(detailFile, "zip");

                        BLFileManager.CompressFile(headerFile, zipHeaderFile, ftpElement.Header);
                        BLFileManager.CompressFile(detailFile, zipDetailFile, ftpElement.Detail);
                    }

                    if (isFox)
                    {
                        string srvName = ConfigurationManager.AppSettings["GetServerName"];
                        headerFile = srvName + Path.GetFileName(headerFile);
                        detailFile = srvName + Path.GetFileName(detailFile);
                        detailFileAct = srvName + Path.GetFileName(detailFileAct);
                        if (incluirConsultora) dataConFile = srvName + Path.GetFileName(dataConFile);
                    }
                    else
                    {
                        if (ConfigurationManager.AppSettings["OrderDownloadFtpUpload"] == "1")
                        {
                            try
                            {
                                BLFileManager.FtpUploadFile(ftpElement.Address + ftpElement.Header,
                                    headerFile, ftpElement.UserName, ftpElement.Password);

                                BLFileManager.FtpUploadFile(ftpElement.Address + ftpElement.Detail,
                                    detailFile, ftpElement.UserName, ftpElement.Password);
                            }
                            catch (Exception ex)
                            {
                                LogManager.SaveLog(ex, usuario, codigoPais);
                                throw new BizLogicException("No se pudo subir los archivos de pedidos al destino FTP.", ex);
                            }

                            if (ConfigurationManager.AppSettings["OrderDownloadIncludeDatosConsultora"] == "1" && !isFox && tipoCronograma == 1)
                            {
                                if (string.IsNullOrEmpty(ErrorCoDat))
                                {
                                    try
                                    {
                                        BLFileManager.FtpUploadFile(ftpElementCoDat.Address + ftpElementCoDat.Header,
                                            dataConFile, ftpElementCoDat.UserName, ftpElementCoDat.Password);
                                    }
                                    catch (Exception ex)
                                    {
                                        LogManager.SaveLog(ex, usuario, codigoPais);
                                        exceptionCoDat = ex;
                                        ErrorCoDat = "No se pudo subir los archivos de datos de consultora al destino FTP.";
                                    }
                                }
                            }
                        }
                        detailFile = headerFile = dataConFile = null;
                        detailFileAct = null;
                    }

                    if (isFox || (dtPedidosDD != null && dtPedidosDD.Rows.Count > 0))
                    {
                        try
                        {
                            DAPedidoDD.UpdPedidoDDIndicadorEnviado(nroLote, marcarPedido, FechaHoraPais);
                        }
                        catch (Exception ex)
                        {
                            LogManager.SaveLog(ex, usuario, codigoPais);
                            throw new BizLogicException("No se pudo marcar los pedidos DD como enviados.", ex);
                        }
                    }

                    try
                    {
                        DAPedidoWeb.UpdPedidoWebIndicadorEnviado(nroLote, marcarPedido, 2, null, null, NombreCabecera, NombreDetalle, System.Environment.MachineName);
                    }
                    catch (Exception ex)
                    {
                        LogManager.SaveLog(ex, usuario, codigoPais);
                        throw new BizLogicException("No se pudo marcar los pedidos Web como enviados.", ex);
                    }

                    if (incluirConsultora && string.IsNullOrEmpty(ErrorCoDat))
                    {
                        try
                        {
                            DAPedidoWeb.UpdDatosConsultoraIndicadorEnviado(nroLote, 2, null, null, NombreCoDat, System.Environment.MachineName);
                        }
                        catch (Exception ex)
                        {
                            LogManager.SaveLog(ex, usuario, codigoPais);
                            exceptionCoDat = ex;
                            ErrorCoDat = "No se pudo marcar los datos de la consultora como enviados.";
                        }
                    }
                }
            }
            catch (Exception ex)
            {
                LogManager.SaveLog(ex, usuario, codigoPais);

                string error = "Error desconocido: " + ex.Message;
                string errorExcepcion = ErrorUtilities.GetExceptionMessage(ex);
                if (nroLote > 0)
                {
                    try { DAPedidoWeb.UpdPedidoWebIndicadorEnviado(nroLote, false, 99, error, errorExcepcion, string.Empty, string.Empty, string.Empty); }
                    catch (Exception ex2) { LogManager.SaveLog(ex2, usuario, codigoPais); }

                    if (dtPedidosDD != null && dtPedidosDD.Rows.Count > 0)
                    {
                        try { DAPedidoDD.UpdPedidoDDIndicadorEnviado(nroLote, false, FechaHoraPais); }
                        catch (Exception ex2) { LogManager.SaveLog(ex2, usuario, codigoPais); }
                    }
                }
                MailUtilities.EnviarMailProcesoDescargaExcepcion("Descarga de pedidos", codigoPais, FechaHoraPais, descripcionProceso, error, errorExcepcion);

                if (incluirConsultora)
                {
                    if (exceptionCoDat != null)
                    {
                        error = ErrorCoDat;
                        errorExcepcion = ErrorUtilities.GetExceptionMessage(exceptionCoDat);
                    }
                    if (nroLote > 0)
                    {
                        try { DAPedidoWeb.UpdDatosConsultoraIndicadorEnviado(nroLote, 99, error, errorExcepcion, string.Empty, string.Empty); }
                        catch (Exception ex2) { LogManager.SaveLog(ex2, usuario, codigoPais); }
                    }
                    MailUtilities.EnviarMailProcesoDescargaExcepcion("Actualización Datos Consultora", codigoPais, FechaHoraPais, descripcionProceso, error, errorExcepcion);
                }

                throw;
            }

            if (ConfigurationManager.AppSettings["OrderDownloadS3"] == "1")
            {
                string carpetaPais;
                try
                {
                    carpetaPais = ConfigurationManager.AppSettings["S3_Pedidos"] + codigoPais;
                    if (!string.IsNullOrEmpty(headerFileS3)) ConfigS3.SetFileS3(headerFileS3, carpetaPais, Path.GetFileName(headerFileS3), false, false, true);
                    if (!string.IsNullOrEmpty(detailFileS3)) ConfigS3.SetFileS3(detailFileS3, carpetaPais, Path.GetFileName(detailFileS3), false, false, true);
                    DAPedidoWeb.UpdPedidoDescargaGuardoS3(nroLote, true, null, null);
                }
                catch (Exception ex)
                {
                    LogManager.SaveLog(ex, usuario, codigoPais);

                    string error = "Terminado OK; pero con error al guardar backups en S3.";
                    string errorExcepcion = ErrorUtilities.GetExceptionMessage(ex);
                    try { DAPedidoWeb.UpdPedidoDescargaGuardoS3(nroLote, false, error, errorExcepcion); }
                    catch (Exception ex2) { LogManager.SaveLog(ex2, usuario, codigoPais); }
                    MailUtilities.EnviarMailProcesoDescargaExcepcion("Descarga de pedidos", codigoPais, FechaHoraPais, descripcionProceso, error, errorExcepcion);
                }

                if (ConfigurationManager.AppSettings["OrderDownloadIncludeDatosConsultora"] == "1" && !isFox && tipoCronograma == 1 &&
                    string.IsNullOrEmpty(ErrorCoDat) && !string.IsNullOrEmpty(dataConFileS3))
                {
                    try
                    {
                        carpetaPais = ConfigurationManager.AppSettings["S3_ActualizacionDatos"] + codigoPais;
                        ConfigS3.SetFileS3(dataConFileS3, carpetaPais, Path.GetFileName(dataConFileS3), false, false, true);
                        DAPedidoWeb.UpdConsultoraDescargaGuardoS3(nroLote, true, null, null);
                    }
                    catch (Exception ex)
                    {
                        LogManager.SaveLog(ex, usuario, codigoPais);

                        string error = "Terminado OK; pero con error al guardar backups en S3.";
                        string errorExcepcion = ErrorUtilities.GetExceptionMessage(ex);
                        try { DAPedidoWeb.UpdConsultoraDescargaGuardoS3(nroLote, false, error, errorExcepcion); }
                        catch (Exception ex2) { LogManager.SaveLog(ex2, usuario, codigoPais); }
                        MailUtilities.EnviarMailProcesoDescargaExcepcion("Actualización Datos Consultora", codigoPais, FechaHoraPais, descripcionProceso, error, errorExcepcion);
                    }
                }
            }

            string[] s = null;
            if (headerFile == null && detailFile == null && detailFileAct == null) s = new string[] { };
            else s = new string[] { headerFile, detailFile, detailFileAct };
            return s;
        }

        public string[] DescargaPedidosDD(int paisID, DateTime fechaFacturacion, int tipoCronograma, bool marcarPedido, string usuario)
        {
            int nroLote = 0;
            DAPedidoWeb DAPedidoWeb = null;

            DataSet dsPedidosDD = null;
            DataTable dtPedidosDD = null;
            DAPedidoDD DAPedidoDD = null;

            string headerFile = null, detailFile = null, NombreCabecera = null, NombreDetalle = null;
            string codigoPais = null, codigoPaisProd = null;

            DateTime FechaHoraPais;
            try { FechaHoraPais = new DAPedidoWeb(paisID).GetFechaHoraPais(); }
            catch { FechaHoraPais = DateTime.Now; }

            try
            {
                codigoPais = new BLZonificacion().SelectPais(paisID).CodigoISO;
                codigoPaisProd = new BLZonificacion().SelectPais(paisID).CodigoISOProd;

                TemplateField[] headerTemplate, detailTemplate;

                var section = (DataAccessConfiguration)ConfigurationManager.GetSection("Belcorp.Configuration");
                var element = section.Countries[paisID];

                string OrderHeaderTemplate = null;

                OrderHeaderTemplate = element.OrderHeaderTemplate;

                headerTemplate = ParseTemplate(ConfigurationManager.AppSettings[OrderHeaderTemplate]);
                detailTemplate = ParseTemplate(ConfigurationManager.AppSettings[element.OrderDetailTemplate]);

                DAPedidoWeb = new DAPedidoWeb(paisID);

                DataSet dsPedidosWeb = null;

                try
                {
                    DAPedidoWeb.InsPedidoDescarga(fechaFacturacion, 1, tipoCronograma, marcarPedido, usuario, out nroLote);
                }
                catch (SqlException ex)
                {
                    if (ex.Number == 50000)
                        throw new BizLogicException("Existe una descarga de pedidos en proceso para la fecha seleccionada.", ex);
                    else
                        throw new BizLogicException("No se pudo acceder al origen de datos de pedidos Web.", ex);
                }

                try
                {
                    DAPedidoDD = new DAPedidoDD(paisID);
                    dsPedidosDD = DAPedidoDD.GetPedidoDDByFechaFacturacion(codigoPais, tipoCronograma, fechaFacturacion, nroLote);
                    dtPedidosDD = dsPedidosDD.Tables[0];
                }
                catch (SqlException ex)
                {
                    throw new BizLogicException("No se pudo acceder al origen de datos de pedidos DD.", ex);
                }

                TransactionOptions transactionOptions = new TransactionOptions
                {
                    IsolationLevel = System.Transactions.IsolationLevel.ReadUncommitted
                };
                using (TransactionScope transaction = new TransactionScope(TransactionScopeOption.Required, transactionOptions))
                {
                    this.ConfigurarDTCargaWebDD(dsPedidosWeb, dsPedidosDD, fechaFacturacion, nroLote, usuario, codigoPais);
                    DAPedidoWeb.InsLogPedidoDescargaWebDD(dsPedidosWeb, dsPedidosDD);
                    DAPedidoWeb.UpdLogPedidoDescargaWebDD(nroLote);
                    transaction.Complete();
                }

                FtpConfigurationElement ftpElement = null;

                Guid fileGuid = Guid.NewGuid();
                string key = codigoPais + "-DR";
                var ftpSection = (FtpConfigurationSection)ConfigurationManager.GetSection("Belcorp.FtpConfiguration");

                try
                {
                    ftpElement = ftpSection.FtpConfigurations[key];
                    headerFile = FormatFile(codigoPais, ftpElement.Header, fechaFacturacion, fileGuid);
                    detailFile = FormatFile(codigoPais, ftpElement.Detail, fechaFacturacion, fileGuid);
                    NombreCabecera = headerFile.Replace(ConfigurationManager.AppSettings["OrderDownloadPath"], "");
                    NombreDetalle = detailFile.Replace(ConfigurationManager.AppSettings["OrderDownloadPath"], "");

                    string fechaFactura = fechaFacturacion.ToString("yyyyMMdd");
                    string fechaProceso = DateTime.Now.ToString("yyyyMMdd");
                    string lote = nroLote.ToString();

                    using (var streamWriter = new StreamWriter(headerFile))
                    {
                        if (dtPedidosDD != null)
                        {
                            foreach (DataRow row in dtPedidosDD.Rows)
                            {
                                streamWriter.WriteLine(HeaderLine(headerTemplate, row, codigoPaisProd, fechaProceso, fechaFactura, lote, "D"));
                            }
                        }
                        else
                            streamWriter.Write(string.Empty);
                    }

                    if (dsPedidosDD != null)
                        dtPedidosDD = dsPedidosDD.Tables[1];

                    using (var streamWriter = new StreamWriter(detailFile))
                    {
                        if (dtPedidosDD != null)
                        {
                            foreach (DataRow row in dtPedidosDD.Rows)
                            {
                                streamWriter.WriteLine(DetailLine(detailTemplate, row, codigoPaisProd, lote));
                            }
                        }
                        else
                            streamWriter.Write(string.Empty);

                    }

                }
                catch (Exception ex)
                {
                    throw new BizLogicException("No se pudo generar los archivos de descarga de pedidos.", ex);
                }

                if (headerFile != null) 
                {
                    if (ConfigurationManager.AppSettings["OrderDownloadCompress"] == "1")
                    {
                        string zipHeaderFile = Path.ChangeExtension(headerFile, "zip");
                        string zipDetailFile = Path.ChangeExtension(detailFile, "zip");

                        BLFileManager.CompressFile(headerFile, zipHeaderFile, ftpElement.Header);
                        BLFileManager.CompressFile(detailFile, zipDetailFile, ftpElement.Detail);
                    }

                    if (ConfigurationManager.AppSettings["OrderDownloadFtpUpload"] == "1")
                    {
                        try
                        {
                            BLFileManager.FtpUploadFile(ftpElement.Address + ftpElement.Header,
                                headerFile, ftpElement.UserName, ftpElement.Password);

                            BLFileManager.FtpUploadFile(ftpElement.Address + ftpElement.Detail,
                                detailFile, ftpElement.UserName, ftpElement.Password);
                        }
                        catch (Exception ex)
                        {
                            throw new BizLogicException("No se pudo subir los archivos de pedidos al destino FTP.", ex);
                        }
                    }
                    detailFile = headerFile = null;

                    try
                    {
                        DAPedidoDD.UpdPedidoDDIndicadorEnviadoDD(nroLote, marcarPedido, FechaHoraPais, 2, null, null, NombreCabecera, NombreDetalle, System.Environment.MachineName);
                    }
                    catch (Exception ex)
                    {
                        throw new BizLogicException("No se pudo marcar los pedidos DD como enviados.", ex);
                    }
                }
            }
            catch (Exception ex)
            {
                LogManager.SaveLog(ex, usuario, codigoPais);

                string error = "Error desconocido: " + ex.Message;
                string errorExcepcion = ErrorUtilities.GetExceptionMessage(ex);
                if (nroLote > 0 && dtPedidosDD != null && dtPedidosDD.Rows.Count > 0)
                {
                    try { DAPedidoDD.UpdPedidoDDIndicadorEnviadoDD(nroLote, false, FechaHoraPais, 99, error, errorExcepcion, string.Empty, string.Empty, string.Empty); }
                    catch (Exception ex2) { LogManager.SaveLog(ex2, usuario, codigoPais); }
                }
                MailUtilities.EnviarMailProcesoDescargaExcepcion("Descarga de pedidos", codigoPais, FechaHoraPais, Enumeradores.TipoDescargaPedidos.DigitacionDistribuidaParcial.ToString(), error, errorExcepcion);

                throw;
            }
            string[] s = null;

            if (headerFile == null && detailFile == null) 
                s = new string[] { };
            else
                s = new string[] { headerFile, detailFile }; 

            return s;
        }

        public string[] DescargaPedidosFIC(int paisID, DateTime fechaFacturacion, int tipoCronograma, string usuario)
        {
            int nroLote = 0;
            DAPedidoFIC DAPedidoFIC = null;
            string headerFile = null, detailFile = null;

            try
            {
                string codigoPais = new BLZonificacion().SelectPais(paisID).CodigoISO;
                string codigoPaisProd = new BLZonificacion().SelectPais(paisID).CodigoISOProd;

                TemplateField[] headerTemplate, detailTemplate;
                var section = (DataAccessConfiguration)ConfigurationManager.GetSection("Belcorp.Configuration");
                var element = section.Countries[paisID];                                
                headerTemplate = ParseTemplate(ConfigurationManager.AppSettings[element.OrderHeaderTemplate]);
                detailTemplate = ParseTemplate(ConfigurationManager.AppSettings[element.OrderDetailTemplate]);

                DAPedidoFIC = new DAPedidoFIC(paisID);
                DataSet dsPedidosWeb;
                DataTable dtPedidosWeb;
                try
                {
                    dsPedidosWeb = DAPedidoFIC.GetPedidoFICByFechaFacturacion(fechaFacturacion, nroLote);
                    dtPedidosWeb = dsPedidosWeb.Tables[0];
                }
                catch (SqlException ex)
                {
                    throw new BizLogicException("No se pudo acceder al origen de datos de pedidos Web.", ex);
                }

                FtpConfigurationElement ftpElement = null;                
                try
                {
                    Guid fileGuid = Guid.NewGuid();
                    string key = codigoPais + "-" + ("FIC");
                    var ftpSection = (FtpConfigurationSection)ConfigurationManager.GetSection("Belcorp.FtpConfiguration");
                    ftpElement = ftpSection.FtpConfigurations[key];

                    headerFile = FormatFile(codigoPais, ftpElement.Header, fechaFacturacion, fileGuid);
                    detailFile = FormatFile(codigoPais, ftpElement.Detail, fechaFacturacion, fileGuid);

                    string fechaFactura = fechaFacturacion.ToString("yyyyMMdd");
                    string fechaProceso = DateTime.Now.ToString("yyyyMMdd");
                    string lote = nroLote.ToString();

                    using (var streamWriter = new StreamWriter(headerFile))
                    {
                        if (dtPedidosWeb.Rows.Count != 0 && dsPedidosWeb.Tables[1].Rows.Count > 0)
                        {
                            foreach (DataRow row in dtPedidosWeb.Rows)
                            {
                                streamWriter.WriteLine(HeaderLine(headerTemplate, row, codigoPaisProd, fechaProceso, fechaFactura, lote, "W"));
                            }
                        }
                    }

                    dtPedidosWeb = dsPedidosWeb.Tables[1];
                    using (var streamWriter = new StreamWriter(detailFile))
                    {
                        if (dtPedidosWeb.Rows.Count != 0)
                        {
                            foreach (DataRow row in dtPedidosWeb.Rows)
                            {
                                streamWriter.WriteLine(DetailLine(detailTemplate, row, codigoPaisProd, lote));
                            }
                        }
                    }
                }
                catch (Exception ex)
                {
                    LogManager.SaveLog(ex, "", codigoPais);
                    throw new BizLogicException("No se pudo generar los archivos de descarga de pedidos.", ex);
                }

                if (headerFile != null)
                {
                    if (ConfigurationManager.AppSettings["OrderDownloadCompress"] == "1")
                    {
                        string zipHeaderFile = Path.ChangeExtension(headerFile, "zip");
                        string zipDetailFile = Path.ChangeExtension(detailFile, "zip");

                        BLFileManager.CompressFile(headerFile, zipHeaderFile, ftpElement.Header);
                        BLFileManager.CompressFile(detailFile, zipDetailFile, ftpElement.Detail);
                    }
                    
                    if (ConfigurationManager.AppSettings["OrderDownloadFtpUpload"] == "1")
                    {
                        try
                        {
                            BLFileManager.FtpUploadFile(ftpElement.Address + ftpElement.Header,
                                headerFile, ftpElement.UserName, ftpElement.Password);
                            BLFileManager.FtpUploadFile(ftpElement.Address + ftpElement.Detail,
                                detailFile, ftpElement.UserName, ftpElement.Password);
                        }
                        catch (Exception ex)
                        {
                            LogManager.SaveLog(ex, "", codigoPais);
                            throw new BizLogicException("No se pudo subir los archivos al destino FTP.", ex);
                        }
                    }
                    detailFile = headerFile = null;
                }
            }
            catch (Exception) { throw; }

            string[] s = null;
            if (headerFile == null && detailFile == null) s = new string[] { };
            else s = new string[] { headerFile, detailFile };
            return s;
        }

        private void ConfigurarDTCargaWebDD(DataSet dsPedidosWeb, DataSet dsPedidosDD, DateTime fechaFacturacion, int nroLote, string usuario, string codigoPais)
        {
            if (!ConfigurationManager.AppSettings["IsFOX"].Contains(codigoPais))
            {
                this.ConfigurarDTCargaHeader(dsPedidosWeb, fechaFacturacion, nroLote, "W", usuario);
                this.ConfigurarDTCargaHeader(dsPedidosDD, fechaFacturacion, nroLote, "D", usuario);
            }
            else
            {
                this.ConfigurarDTCargaHeader(dsPedidosWeb, fechaFacturacion, nroLote, string.Empty, usuario);
                this.ConfigurarDTCargaHeader(dsPedidosDD, fechaFacturacion, nroLote, string.Empty, usuario);
            }
        }

        private void ConfigurarDTCargaDetalle(DataSet dsPedidosDetalle, DateTime fechaFactura, int nroLote)
        {
            DataTable dtPedidosDetalle = null;

            if (dsPedidosDetalle != null)
            {
                dtPedidosDetalle = dsPedidosDetalle.Tables[1];

                if (dtPedidosDetalle.Rows.Count > 0)
                {
                    DataColumn col = new DataColumn("LogFechaFacturacion", typeof(System.DateTime));
                    col.DefaultValue = fechaFactura;
                    dtPedidosDetalle.Columns.Add(col);

                    col = new DataColumn("LogNroLote", typeof(System.Int32));
                    col.DefaultValue = nroLote;
                    dtPedidosDetalle.Columns.Add(col);
                }
            }
        }

        private void ConfigurarDTCargaHeader(DataSet dsPedidos, DateTime fechaFactura, int nroLote, string origen, string usuario)
        {
            DataTable dtPedidosCabecera = null;

            if (dsPedidos != null)
            {
                dtPedidosCabecera = dsPedidos.Tables[0];

                if (dtPedidosCabecera.Rows.Count != 0)
                {
                    DataColumn col = new DataColumn("LogFechaFacturacion", typeof(System.DateTime));
                    col.DefaultValue = fechaFactura;
                    dtPedidosCabecera.Columns.Add(col);

                    col = new DataColumn("LogNroLote", typeof(System.Int32));
                    col.DefaultValue = nroLote;
                    dtPedidosCabecera.Columns.Add(col);

                    col = new DataColumn("LogCantidad", typeof(System.Int32));
                    col.DefaultValue = 0;
                    dtPedidosCabecera.Columns.Add(col);

                    if (origen != string.Empty)
                    {
                        col = new DataColumn("Origen", typeof(System.String));
                        col.DefaultValue = origen;
                        dtPedidosCabecera.Columns.Add(col);
                    }

                    col = new DataColumn("LogCodigoUsuarioProceso", typeof(System.String));
                    col.DefaultValue = usuario;
                    dtPedidosCabecera.Columns.Add(col);

                    ConfigurarDTCargaDetalle(dsPedidos, fechaFactura, nroLote);
                }
            }
        }

        private string FormatFile(string codigoPais, string fileName, DateTime date, Guid fileGuid)
        {
            return ConfigurationManager.AppSettings["OrderDownloadPath"]
                + Path.GetFileNameWithoutExtension(fileName) + "-"
                + codigoPais + "-" + date.ToString("yyyyMMdd") + "-"
                + fileGuid.ToString() + Path.GetExtension(fileName);
        }

        private string HeaderLine(TemplateField[] template, DataRow row, string codigoPais, string fechaProceso, string fechaFactura, string lote, string origen)
        {            
            string line = string.Empty;
            foreach (TemplateField field in template)
            {                
                string item;
                switch (field.FieldName)
                {
                    case "PAIS": item = codigoPais; break;
                    case "CAMPANIA": item = row["CampaniaID"].ToString(); break;
                    case "CONSULTORA": item = row["CodigoConsultora"].ToString(); break;
                    case "PREIMPRESO": item = row["PedidoID"].ToString(); break;
                    case "CLIENTES": item = row["Clientes"].ToString(); break;
                    case "FECHAPROCESO": item = fechaProceso; break;
                    case "FECHAFACTURA": item = fechaFactura; break;
                    case "REGION": item = row["CodigoRegion"].ToString(); break;
                    case "ZONA":
                        if (!ConfigurationManager.AppSettings["IsSICCFOX"].Contains(codigoPais))
                            item = row["CodigoZona"].ToString();
                        else
                            item = row["CodigoZona"].ToString().Substring(0, 4);
                        break;
                    case "LOTE": item = lote; break;
                    case "ORIGEN": item = origen; break;
                    case "VALIDADO": item = row["Validado"].ToString(); break;
                    case "COMPARTAMOS": item = (DataRecord.HasColumn(row, "bitAsistenciaCompartamos") ? row["bitAsistenciaCompartamos"].ToString() : string.Empty); break;
                    case "METODOENVIO": item = (DataRecord.HasColumn(row, "chrShippingMethod") ? row["chrShippingMethod"].ToString() : string.Empty); break;
                    case "IPUSUARIO": item = (DataRecord.HasColumn(row, "IPUsuario") ? row["IPUsuario"].ToString() : string.Empty); break;
                    case "TIPOCUPON": item = (DataRecord.HasColumn(row, "TipoCupon") ? row["TipoCupon"].ToString() : string.Empty); break;
                    case "VALORCUPON": item = (DataRecord.HasColumn(row, "ValorCupon") ? row["ValorCupon"].ToString() : string.Empty); break;
                    default: item = string.Empty; break;
                }
                line += item.PadRight(field.Size);
            }
            return line;
        }
        private string DetailLine(TemplateField[] template, DataRow row, string codigoPais, string lote)
        {
            string line = string.Empty;
            foreach (TemplateField field in template)
            {
                string item;
                switch (field.FieldName)
                {
                    case "PAIS": item = codigoPais; break;
                    case "CAMPANIA": item = row["CampaniaID"].ToString(); break;
                    case "CONSULTORA": item = row["CodigoConsultora"].ToString(); break;
                    case "PREIMPRESO": item = row["PedidoID"].ToString(); break;
                    case "CODIGOVENTA": item = row["CodigoVenta"].ToString(); break;
                    case "CANTIDAD": item = row["Cantidad"].ToString(); break;
                    case "CODIGOPRODUCTO": item = row["CodigoProducto"].ToString(); break;
                    case "LOTE": item = lote; break;
                    case "ORIGENPEDIDOWEB": item = (DataRecord.HasColumn(row, "OrigenPedidoWeb") ? row["OrigenPedidoWeb"].ToString() : "0"); break;
                    default: item = string.Empty; break;
                }
                line += item.PadRight(field.Size);
            }
            return line;
        }

        private string CoDatLine(TemplateField[] template, DataRow row, string codigoPais)
        {
            string line = string.Empty;
            foreach (TemplateField field in template)
            {
                string item;

                switch (field.FieldName)
                {
                    case "PAIS": item = codigoPais; break;
                    case "CONSULTORA": item = row["CodigoConsultora"].ToString(); break;
                    case "TELEFONO":
                        item = row["Telefono"].ToString().Length > 15 ? row["Telefono"].ToString().Substring(0, 15) : row["Telefono"].ToString();
                        break;
                    case "TELEFONOTRABAJO":
                        item = row["TelefonoTrabajo"].ToString().Length > 15 ? row["TelefonoTrabajo"].ToString().Substring(0, 15) : row["TelefonoTrabajo"].ToString();
                        break;
                    case "TELEFONOMOVIL":
                        item = row["Celular"].ToString().Length > 15 ? row["Celular"].ToString().Substring(0, 15) : row["Celular"].ToString();
                        break;
                    case "CELULAR":
                        item = row["Celular"].ToString().Length > 15 ? row["Celular"].ToString().Substring(0, 15) : row["Celular"].ToString();
                        break; 
                    case "EMAIL":
                        item = row["EMail"].ToString().Length > 50 ? row["EMail"].ToString().Substring(0, 50) : row["EMail"].ToString();
                        break;
                    case "EMAILACTIVO":
                        item = Convert.ToInt32(row["EmailActivo"]).ToString();
                        break;
                    case "CAMPANIAACTIVACIONEMAIL":
                        item = row["CampaniaActivacionEmail"].ToString().Length > 6 ? row["CampaniaActivacionEmail"].ToString().Substring(0, 6) : row["CampaniaActivacionEmail"].ToString();
                        break;
                    case "LATITUD":
                        item = row["Latitud"].ToString().Length > 30 ? row["Latitud"].ToString().Substring(0, 30) : row["Latitud"].ToString();
                        break;
                    case "LONGITUD":
                        item = row["Longitud"].ToString().Length > 30 ? row["Longitud"].ToString().Substring(0, 30) : row["Longitud"].ToString();
                        break;
                    default: item = string.Empty; break;
                }

                line += item.PadRight(field.Size);
            }
            return line;
        }

        private TemplateField[] ParseTemplate(string templateText, bool descargaActDatosv2 = true)
        {
            List<string> CamposActDatosv2 = new List<string> { "TELEFONOTRABAJO", "LATITUD", "LONGITUD" };
            string[] parts = templateText.Split(';');
            var listTemplate = new List<TemplateField>();
            TemplateField templateField;

            for (int index = 0; index < parts.Length; index++)
            {
                templateField = new TemplateField(parts[index]);
                if (!descargaActDatosv2 && CamposActDatosv2.Contains(templateField.FieldName)) continue;
                listTemplate.Add(templateField);
            }
            return listTemplate.ToArray();
        }

        public BEConfiguracionCampania GetEstadoPedido(int PaisID, int CampaniaID, long ConsultoraID, int ZonaID, int RegionID)
        {
            BEConfiguracionCampania configuracion = null;

            var DAPedidoWeb = new DAPedidoWeb(PaisID);
            int Estado = 201;
            bool Modifica = false;
            bool ValidacionAbierta = false;

            var DAConfiguracionCampania = new DAConfiguracionCampania(PaisID);
            using (IDataReader reader = DAConfiguracionCampania.GetConfiguracionCampania(PaisID, ZonaID, RegionID, ConsultoraID))
                if (reader.Read()) configuracion = new BEConfiguracionCampania(reader);

            if (configuracion != null)
            {
                using (IDataReader reader = DAPedidoWeb.GetEstadoPedido(configuracion.CampaniaID, ConsultoraID))
                {
                    if (reader.Read())
                    {
                        Estado = Convert.ToInt32(reader["EstadoPedido"]);
                        Modifica = Convert.ToBoolean(reader["ModificaPedidoReservado"]);
                        ValidacionAbierta = Convert.ToBoolean(reader["ValidacionAbierta"]);
                    }
                }
            }

            if (configuracion != null)
            {
                configuracion.EstadoPedido = Estado;
                configuracion.ModificaPedidoReservado = Modifica;
                configuracion.ValidacionAbierta = ValidacionAbierta;
            }

            return configuracion;
        }

        public List<BEPedidoWebService> GetPedidoCuvMarquesina(int paisID, int CampaniaID, long ConsultoraID, string CUV)
        {
            var listaPedidoPortal = new List<BEPedidoWebService>();
            var DAPedidoWeb = new DAPedidoWeb(paisID);

            using (IDataReader reader = DAPedidoWeb.GetPedidoCuvMarquesina(CampaniaID, ConsultoraID, CUV))
                while (reader.Read())
                {
                    var cuv = new BEPedidoWebService(reader);
                    listaPedidoPortal.Add(cuv);
                }
            return listaPedidoPortal;
        }



        public int ValidarCuvMarquesina(int paisID, string CampaniaID, int Cuv)
        {
            int resultado;
            resultado = 0;
            var DAPedidoWeb = new DAPedidoWeb(paisID);
            using (IDataReader reader = DAPedidoWeb.ValidarCuvMarquesina(CampaniaID, Cuv))
                while (reader.Read())
                {
                    resultado = Convert.ToInt32(reader[0]);
                }
            return resultado;
        }
        public IList<BECuvProgramaNueva> GetCuvProgramaNueva(int paisID)
        {
            var CuvProgramaNueva = new List<BECuvProgramaNueva>();
            var DAPedidoWeb = new DAPedidoWeb(paisID);

            using (IDataReader reader = DAPedidoWeb.GetCuvProgramaNueva())
                while (reader.Read())
                {
                    var entidad = new BECuvProgramaNueva(reader);
                    CuvProgramaNueva.Add(entidad);
                }

            return CuvProgramaNueva;
        }

        #region Consulta y Bloquedo de Pedido
        public IList<BEPedidoWeb> SelectPedidosWebByFilter(BEPedidoWeb BEPedidoWeb, string Fecha, int? RegionID, int? TerritorioID)
        {
            var pedidoWeb = new List<BEPedidoWeb>();
            var DAPedidoWeb = new DAPedidoWeb(BEPedidoWeb.PaisID);

            using (IDataReader reader = DAPedidoWeb.SelectPedidosWebByFilter(BEPedidoWeb, Fecha, RegionID, TerritorioID))
                while (reader.Read())
                {
                    var entidad = new BEPedidoWeb(reader);
                    pedidoWeb.Add(entidad);
                }

            return pedidoWeb;
        }

        public void UpdBloqueoPedido(BEPedidoWeb BEPedidoWeb)
        {
            var DAPedidoWeb = new DAPedidoWeb(BEPedidoWeb.PaisID);
            DAPedidoWeb.UpdBloqueoPedido(BEPedidoWeb);
        }

        public void InsertarLogPedidoWeb(int PaisID, int CampaniaID, string CodigoConsultora, int PedidoId, string Accion, string CodigoUsuario)
        {
            new DAPedidoWeb(PaisID).InsertarLogPedidoWeb(CampaniaID, CodigoConsultora, PedidoId, Accion, CodigoUsuario);
        }

        public void UpdDesbloqueoPedido(BEPedidoWeb BEPedidoWeb)
        {
            var DAPedidoWeb = new DAPedidoWeb(BEPedidoWeb.PaisID);
            DAPedidoWeb.UpdDesbloqueoPedido(BEPedidoWeb);
        }
        #endregion

        public IList<BEPedidoDDWeb> GetPedidosWebDDNoFacturados(BEPedidoDDWeb BEPedidoDDWeb)
        {
            DAPedidoWeb DAPedidoWeb = null;
            List<BEPedidoDDWeb> lstPedidos = null;
            DAPedidoDD DAPedidoDD = null;

            try
            {
                // DD : 1
                // Web: 2
                List<BEPedidoDDWeb> lstPedidosWeb = new List<BEPedidoDDWeb>();
                if (BEPedidoDDWeb.Origen != 1)
                {
                    try
                    {
                        DAPedidoWeb = new DAPedidoWeb(BEPedidoDDWeb.paisID);
                        using (IDataReader reader = DAPedidoWeb.GetPedidosWebNoFacturados(BEPedidoDDWeb))
                            while (reader.Read())
                            {
                                var entidad = new BEPedidoDDWeb(reader);
                                lstPedidosWeb.Add(entidad);
                            }
                    }
                    catch (SqlException ex)
                    {
                        throw new BizLogicException("No se pudo acceder al origen de datos de pedidos Web.", ex);
                    }
                }

                List<BEPedidoDDWeb> lstPedidosDD = new List<BEPedidoDDWeb>();
                if (BEPedidoDDWeb.Origen != 2 && BEPedidoDDWeb.EstadoValidacion != 202)
                {
                    try
                    {
                        DAPedidoDD = new DAPedidoDD(BEPedidoDDWeb.paisID);
                        using (IDataReader reader = DAPedidoDD.GetPedidosDDNoFacturados(BEPedidoDDWeb))
                            while (reader.Read())
                            {
                                var entidad = new BEPedidoDDWeb(reader);
                                lstPedidosDD.Add(entidad);
                            }
                    }
                    catch (SqlException ex)
                    {
                        throw new BizLogicException("No se pudo acceder al origen de datos de pedidos DD.", ex);
                    }
                }

                lstPedidos = new List<BEPedidoDDWeb>();
                if (lstPedidosWeb.Count > 0)
                {
                    lstPedidosWeb.Where(x => x.EstadoValidacionNombre == "NO").Update(x => x.EstadoValidacion = 201);
                    lstPedidosWeb.Where(x => x.EstadoValidacionNombre == "SI").Update(x => x.EstadoValidacion = 202);
                    lstPedidos.AddRange((List<BEPedidoDDWeb>)lstPedidosWeb);
                }
                if (lstPedidosDD.Count > 0)
                {
                    lstPedidosDD.Update(x => x.EstadoValidacion = 201);
                    lstPedidosDD.Update(x => x.EstadoValidacionNombre = "NO");
                    lstPedidos.AddRange((List<BEPedidoDDWeb>)lstPedidosDD);
                }
            }
            catch (Exception) { throw; }

            return lstPedidos;
        }

        public IList<BEPedidoDDWebDetalle> GetPedidosWebDDNoFacturadosDetalle(int paisID, string paisISO, int CampaniaID, string Consultora, string Origen)
        {
            DAPedidoWebDetalle DAPedidoWebDetalle = new DAPedidoWebDetalle(paisID);
            List<BEPedidoDDWebDetalle> lstPedidosDetalle = null;
            DAPedidoDD DAPedidoDD = null;

            try
            {
                // DD : 1
                // Web: 2
                List<BEPedidoDDWebDetalle> lstPedidosWebDetalle = new List<BEPedidoDDWebDetalle>();
                if (Origen.Equals("Web"))
                {
                    try
                    {
                        using (IDataReader reader = DAPedidoWebDetalle.GetPedidosWebNoFacturadosDetalle(paisISO, CampaniaID, Consultora))
                            while (reader.Read())
                            {
                                var entidad = new BEPedidoDDWebDetalle(reader);
                                lstPedidosWebDetalle.Add(entidad);
                            }
                    }
                    catch (SqlException ex)
                    {
                        throw new BizLogicException("No se pudo acceder al origen de datos de pedidos Web.", ex);
                    }
                }

                List<BEPedidoDDWebDetalle> lstPedidosDDDetalle = new List<BEPedidoDDWebDetalle>();
                if (Origen.Equals("DD"))
                {
                    try
                    {
                        DAPedidoDD = new DAPedidoDD(paisID);
                        using (IDataReader reader = DAPedidoDD.GetPedidosDDNoFacturadosDetalle(paisISO, CampaniaID, Consultora))
                            while (reader.Read())
                            {
                                var entidad = new BEPedidoDDWebDetalle(reader);
                                lstPedidosDDDetalle.Add(entidad);
                            }
                    }
                    catch (SqlException ex)
                    {
                        throw new BizLogicException("No se pudo acceder al origen de datos de pedidos DD.", ex);
                    }
                }

                lstPedidosDetalle = new List<BEPedidoDDWebDetalle>();
                if (lstPedidosWebDetalle.Count > 0)
                {
                    lstPedidosDetalle.AddRange((List<BEPedidoDDWebDetalle>)lstPedidosWebDetalle);
                }

                if (lstPedidosDDDetalle.Count > 0)
                {
                    lstPedidosDetalle.AddRange((List<BEPedidoDDWebDetalle>)lstPedidosDDDetalle);
                }
            }
            catch (Exception) { throw; }

            return lstPedidosDetalle;
        }

        public IList<BEPedidoDDWeb> GetPedidosWebDDDetalleConsultora(BEPedidoDDWeb BEPedidoDDWeb)
        {
            DAPedidoWeb DAPedidoWeb = null;
            List<BEPedidoDDWeb> lstPedidos = null;
            DAPedidoDD DAPedidoDD = null;

            try
            {
                // DD : 1
                // Web: 2
                List<BEPedidoDDWeb> lstPedidosWeb = new List<BEPedidoDDWeb>();
                if (BEPedidoDDWeb.Origen != 1)
                {
                    try
                    {
                        DAPedidoWeb = new DAPedidoWeb(BEPedidoDDWeb.paisID);
                        using (IDataReader reader = DAPedidoWeb.GetPedidosWebDDDetalleConsultora(BEPedidoDDWeb))
                            while (reader.Read())
                            {
                                var entidad = new BEPedidoDDWeb(reader);
                                lstPedidosWeb.Add(entidad);
                            }
                    }
                    catch (SqlException ex)
                    {
                        throw new BizLogicException("No se pudo acceder al origen de datos de pedidos Web.", ex);
                    }
                }

                List<BEPedidoDDWeb> lstPedidosDD = new List<BEPedidoDDWeb>();
                if (BEPedidoDDWeb.Origen != 2)
                {
                    try
                    {
                        DAPedidoDD = new DAPedidoDD(BEPedidoDDWeb.paisID);
                        using (IDataReader reader = DAPedidoDD.GetPedidosWebDDDetalleConsultora(BEPedidoDDWeb))
                            while (reader.Read())
                            {
                                var entidad = new BEPedidoDDWeb(reader);
                                lstPedidosDD.Add(entidad);
                            }
                    }
                    catch (SqlException ex)
                    {
                        throw new BizLogicException("No se pudo acceder al origen de datos de pedidos DD.", ex);
                    }
                }

                lstPedidos = new List<BEPedidoDDWeb>();
                if (lstPedidosWeb.Count > 0)
                    lstPedidos.AddRange((List<BEPedidoDDWeb>)lstPedidosWeb);
                if (lstPedidosDD.Count > 0)
                    lstPedidos.AddRange((List<BEPedidoDDWeb>)lstPedidosDD);
            }
            catch (Exception) { throw; }

            return lstPedidos;
        }

        public List<BEPedidoWebService> GetPedidosPortal(int paisID, int CampaniaID, string CodigoConsultora, string ZonaCodigo, int PedidoPROL)
        {
            var listaPedidoPortal = new List<BEPedidoWebService>();
            var DAPedidoWeb = new DAPedidoWeb(paisID);

            using (IDataReader reader = DAPedidoWeb.GetPedidosPortal(CampaniaID, CodigoConsultora, ZonaCodigo, PedidoPROL))
                while (reader.Read())
                {
                    var entidad = new BEPedidoWebService(reader);
                    listaPedidoPortal.Add(entidad);
                }
            return listaPedidoPortal;
        }

        public List<BEPedidoWebService> GetPedidosPortalCaribeMX(int paisID, int CampaniaID, string CodigoConsultora, string ZonaCodigo, int PedidoPROL)
        {
            var listaPedidoPortal = new List<BEPedidoWebService>();
            var DAPedidoWeb = new DAPedidoWeb(paisID);

            using (IDataReader reader = DAPedidoWeb.GetPedidosPortalCaribeMX(CampaniaID, CodigoConsultora, ZonaCodigo, PedidoPROL))
                while (reader.Read())
                {
                    var entidad = new BEPedidoWebService(reader);
                    listaPedidoPortal.Add(entidad);
                }
            return listaPedidoPortal;
        }

        public List<BEPedidoWebService> GetPedidosPortalCaribeMXFinal(int paisID, int CampaniaID, string CodigoConsultora, string ZonaCodigo, int PedidoPROL,
            int IndicadorPedido, string SeccionCodigo, int IdEstadoActividad, int IndicadorSaldo, string NombreConsultora)
        {
            var listaPedidoPortal = new List<BEPedidoWebService>();
            var DAPedidoWeb = new DAPedidoWeb(paisID);

            using (IDataReader reader = DAPedidoWeb.GetPedidosPortalCaribeMXFinal(CampaniaID, CodigoConsultora, ZonaCodigo, PedidoPROL, IndicadorPedido, SeccionCodigo, IdEstadoActividad, IndicadorSaldo, NombreConsultora))
                while (reader.Read())
                {
                    var entidad = new BEPedidoWebService(reader);
                    listaPedidoPortal.Add(entidad);
                }
            return listaPedidoPortal;
        }

        public List<BEPedidoExtendidoWS> GetPedidosPortalExtendido(int paisID, int CampaniaID, string CodigoConsultora, string RegionCodigo, string ZonaCodigo, int PedidoPROL,
    int IndicadorPedido, string SeccionCodigo, int IdEstadoActividad, int IndicadorSaldo, string NombreConsultora)
        {
            var listaPedidoPortal = new List<BEPedidoExtendidoWS>();
            var DAPedidoWeb = new DAPedidoWeb(paisID);

            using (IDataReader reader = DAPedidoWeb.GetPedidosPortalExtendido(CampaniaID, CodigoConsultora, RegionCodigo, ZonaCodigo, PedidoPROL, IndicadorPedido, SeccionCodigo, IdEstadoActividad, IndicadorSaldo, NombreConsultora))
                while (reader.Read())
                {
                    var entidad = new BEPedidoExtendidoWS(reader);
                    listaPedidoPortal.Add(entidad);
                }
            return listaPedidoPortal;
        }

        public List<BEPedidoWebService> GetPedidosPortalDetalle(int paisID, int CampaniaID, string CodigoConsultora)
        {
            var listaPedidoPortal = new List<BEPedidoWebService>();
            var DAPedidoWeb = new DAPedidoWeb(paisID);

            using (IDataReader reader = DAPedidoWeb.GetPedidosPortalDetalle(CampaniaID, CodigoConsultora))
                while (reader.Read())
                {
                    var entidad = new BEPedidoWebService(reader);
                    listaPedidoPortal.Add(entidad);
                }
            return listaPedidoPortal;
        }

        public List<BEPedidoWebService> GetPedidosPortalDetalleCaribeMXFinal(int paisID, int CampaniaID, string CodigoConsultora)
        {
            var listaPedidoPortal = new List<BEPedidoWebService>();
            var DAPedidoWeb = new DAPedidoWeb(paisID);

            using (IDataReader reader = DAPedidoWeb.GetPedidosPortalDetalleCaribeMXFinal(CampaniaID, CodigoConsultora))
                while (reader.Read())
                {
                    var entidad = new BEPedidoWebService(reader);
                    listaPedidoPortal.Add(entidad);
                }
            return listaPedidoPortal;
        }

        public List<BEPedidoExtendidoWS> GetPedidosPortalDetalleExtendido(int paisID, int CampaniaID, string CodigoConsultora)
        {
            var listaPedidoPortal = new List<BEPedidoExtendidoWS>();
            var DAPedidoWeb = new DAPedidoWeb(paisID);

            using (IDataReader reader = DAPedidoWeb.GetPedidosPortalDetalleExtendido(CampaniaID, CodigoConsultora))
                while (reader.Read())
                {
                    var entidad = new BEPedidoExtendidoWS(reader);
                    listaPedidoPortal.Add(entidad);
                }
            return listaPedidoPortal;
        }

        public void UpdBloquedoPedidowebService(int paisID, int CampaniaID, string CodigoConsultora, bool Bloqueado, string DescripcionBloqueo)
        {
            var DAPedidoWeb = new DAPedidoWeb(paisID);
            try
            {
                DAPedidoWeb.UpdBloquedoPedidowebService(CampaniaID, CodigoConsultora, Bloqueado, DescripcionBloqueo);
            }
            catch (Exception) { throw; }
        }

        public BEConsultoraWS GetConsultoraWebService(int paisID, string CodigoConsultora)
        {
            BEConsultoraWS entidad = null;
            var DAPedidoWeb = new DAPedidoWeb(paisID);

            using (IDataReader reader = DAPedidoWeb.GetConsultoraWebService(CodigoConsultora))
                if (reader.Read())
                {
                    entidad = new BEConsultoraWS(reader);
                }
            return entidad;
        }

        public List<BEPedidoWebService> GetPedidosPortalConsolidado(int paisID, string CodigoConsultora, int CampaniaID, DateTime FechaInicial, DateTime FechaFinal)
        {
            var listaPedidoPortal = new List<BEPedidoWebService>();
            var DAPedidoWeb = new DAPedidoWeb(paisID);

            using (IDataReader reader = DAPedidoWeb.GetPedidosPortalConsolidado(CodigoConsultora, CampaniaID, FechaInicial, FechaFinal))
                while (reader.Read())
                {
                    var entidad = new BEPedidoWebService(reader);
                    listaPedidoPortal.Add(entidad);
                }
            return listaPedidoPortal;
        }

        public List<BEPedidoWebService> GetPedidosPortalConsolidadoDetalle(int paisID, string CodigoConsultora, int CampaniaID, string CodigosZonas)
        {
            var listaPedidoPortal = new List<BEPedidoWebService>();
            var DAPedidoWeb = new DAPedidoWeb(paisID);

            using (IDataReader reader = DAPedidoWeb.GetPedidosPortalConsolidadoDetalle(CodigoConsultora, CampaniaID, CodigosZonas))
                while (reader.Read())
                {
                    var entidad = new BEPedidoWebService(reader);
                    listaPedidoPortal.Add(entidad);
                }
            return listaPedidoPortal;
        }

        public int GetPedidoWebID(int paisID, int campaniaID, long consultoraID)
        {
            var DAPedidoWeb = new DAPedidoWeb(paisID);
            int PedidoID = 0;
            using (IDataReader reader = DAPedidoWeb.GetPedidoWebID(campaniaID, consultoraID))
                if (reader.Read())
                {
                    PedidoID = Convert.ToInt32(reader["PedidoID"]);
                }

            return PedidoID;
        }

        public int GetFechaNoHabilFacturacion(int paisID, string CodigoZona, DateTime Fecha)
        {
            var DAPedidoWeb = new DAPedidoWeb(paisID);
            return DAPedidoWeb.GetFechaNoHabilFacturacion(CodigoZona, Fecha);
        }

        public BEHabPedidoCabWS GetHabilitarPedidosWebService(int paisID, string CodigoPais, int CampaniaID, string CodigoConsultora)
        {
            var DAPedidoWeb = new DAPedidoWeb(paisID);
            BEHabPedidoCabWS oBEHabPedidoCabWS = null;
            using (IDataReader reader = DAPedidoWeb.GetHabilitarPedidosWebServiceCabecera(CodigoPais, CampaniaID, CodigoConsultora))
                if (reader.Read())
                {
                    oBEHabPedidoCabWS = new BEHabPedidoCabWS(reader);
                }

            if (oBEHabPedidoCabWS != null)
            {
                List<BEHabPedidoDetWS> olstHabPedidoDetWS = new List<BEHabPedidoDetWS>();
                using (IDataReader reader = DAPedidoWeb.GetHabilitarPedidosWebServiceDetalle(CampaniaID, oBEHabPedidoCabWS.PedidoId))
                    while (reader.Read())
                    {
                        olstHabPedidoDetWS.Add(new BEHabPedidoDetWS(reader));
                    }
                oBEHabPedidoCabWS.DetallePedido = olstHabPedidoDetWS;
            }

            return oBEHabPedidoCabWS;
        }

        public IList<BEPedidoDDWebDetalle> GetPedidoDDDetalle(int paisID, string paisISO, int pedidoID, int CampaniaID, string Consultora, string Origen, bool IndicadorActivo)
        {
            DAPedidoWebDetalle DAPedidoWebDetalle = new DAPedidoWebDetalle(paisID);
            List<BEPedidoDDWebDetalle> lstPedidosDetalle = null;
            DAPedidoDD DAPedidoDD = null;

            try
            {
                // DD : 1
                // Web: 2
                List<BEPedidoDDWebDetalle> lstPedidosWebDetalle = new List<BEPedidoDDWebDetalle>();
                if (Origen.Equals("Web"))
                {
                    try
                    {
                        using (IDataReader reader = DAPedidoWebDetalle.GetPedidosWebNoFacturadosDetalle(paisISO, CampaniaID, Consultora))
                            while (reader.Read())
                            {
                                var entidad = new BEPedidoDDWebDetalle(reader);
                                lstPedidosWebDetalle.Add(entidad);
                            }
                    }
                    catch (SqlException ex)
                    {
                        throw new BizLogicException("No se pudo acceder al origen de datos de pedidos Web.", ex);
                    }
                }

                List<BEPedidoDDWebDetalle> lstPedidosDDDetalle = new List<BEPedidoDDWebDetalle>();
                if (Origen.Equals("DD"))
                {
                    try
                    {
                        DAPedidoDD = new DAPedidoDD(paisID);
                        using (IDataReader reader = DAPedidoDD.GetPedidoDDDetalle(pedidoID, CampaniaID, IndicadorActivo))
                            while (reader.Read())
                            {
                                var entidad = new BEPedidoDDWebDetalle(reader);
                                lstPedidosDDDetalle.Add(entidad);
                            }
                    }
                    catch (SqlException ex)
                    {
                        throw new BizLogicException("No se pudo acceder al origen de datos de pedidos DD.", ex);
                    }
                }

                lstPedidosDetalle = new List<BEPedidoDDWebDetalle>();
                if (lstPedidosWebDetalle.Count > 0)
                {
                    lstPedidosDetalle.AddRange((List<BEPedidoDDWebDetalle>)lstPedidosWebDetalle);
                }

                if (lstPedidosDDDetalle.Count > 0)
                {
                    lstPedidosDetalle.AddRange((List<BEPedidoDDWebDetalle>)lstPedidosDDDetalle);
                }
            }
            catch (Exception) { throw; }

            return lstPedidosDetalle;
        }

        public bool ExistsPedidoWebByCampaniaConsultora(int paisID, int campaniaID, long consultoraID)
        {
            DAPedidoWeb daPedidoWeb = new DAPedidoWeb(paisID);
            using (IDataReader reader = daPedidoWeb.GetPedidoWebByCampaniaConsultora(campaniaID, consultoraID))
            {
                if (reader.Read()) return true;
            }
            return false;
        }

        public BEPedidoWeb GetPedidoWebByCampaniaConsultora(int paisID, int campaniaID, long consultoraID)
        {
            BEPedidoWeb bePedidoWeb = null;
            DAPedidoWeb daPedidoWeb = new DAPedidoWeb(paisID);

            using (IDataReader reader = daPedidoWeb.GetPedidoWebByCampaniaConsultora(campaniaID, consultoraID))
                while (reader.Read())
                {
                    bePedidoWeb = new BEPedidoWeb(reader);
                }
            return bePedidoWeb;
        }

        public BEPedidoWeb GetResumenPedidoWebByCampaniaConsultora(int paisID, int campaniaID, long consultoraID)
        {
            BEPedidoWeb bePedidoWeb = null;
            DAPedidoWeb daPedidoWeb = new DAPedidoWeb(paisID);

            using (IDataReader reader = daPedidoWeb.GetResumenPedidoWebByCampaniaConsultora(campaniaID, consultoraID))
            {
                if (reader.Read()) bePedidoWeb = new BEPedidoWeb(reader);
            }
            return bePedidoWeb;
        }

        public List<BEPedidoWebService> GetPedidoConsolidado(int paisID, int CampaniaID, string CodigoConsultora, string ZonaCodigo, int PedidoPROL, string Origen, int IndicadorPedido, int IdEstadoActividad, int IndicadorSaldo, string SeccionCodigo, string NombreConsultora)
        {
            var listaPedidoPortal = new List<BEPedidoWebService>();
            var DAPedidoWeb = new DAPedidoWeb(paisID);

            using (IDataReader reader = DAPedidoWeb.GetPedidoConsolidado(CampaniaID, CodigoConsultora, ZonaCodigo, PedidoPROL, Origen, IndicadorPedido, IdEstadoActividad, IndicadorSaldo, SeccionCodigo, NombreConsultora))
                while (reader.Read())
                {
                    var entidad = new BEPedidoWebService(reader);
                    listaPedidoPortal.Add(entidad);
                }
            return listaPedidoPortal;
        }

        public List<BEPedidoWebService> GetPedidoDetalleConsolidado(int paisID, int CampaniaID, string CodigoConsultora, string origen)
        {
            var listaPedidoPortal = new List<BEPedidoWebService>();
            var DAPedidoWeb = new DAPedidoWeb(paisID);

            using (IDataReader reader = DAPedidoWeb.GetPedidosDetalleConsolidado(CampaniaID, CodigoConsultora, origen))
                while (reader.Read())
                {
                    var entidad = new BEPedidoWebService(reader);
                    listaPedidoPortal.Add(entidad);
                }
            return listaPedidoPortal;
        }

        public int ValidarDesactivaRevistaGana(int paisID, int campaniaID, string codigoZona)
        {
            var DAPedidoWeb = new DAPedidoWeb(paisID);
            int rslt = DAPedidoWeb.ValidarDesactivaRevistaGana(campaniaID, codigoZona);
            return rslt;
        }

        public BECUVCredito ValidarCUVCreditoPorCUVRegular(int paisID, string codigoConsultora, string cuv, int campaniaID)
        {
            BEConsultoraTop beConsultoraTop = null;
            BEConsultoraCUV beConsultoraCUVRegular = null;
            BEConsultoraCUV beConsultoraCUVCredito = null;
            BLConsultora blConsultora = new BLConsultora();
            BECUVCredito beCUVCredito = new BECUVCredito();

            List<int> listaPais = ListaPaisValidoCUVCredito();

            if (listaPais.Contains(paisID))
            {

                beConsultoraTop = blConsultora.GetConsultoraTop(paisID, codigoConsultora);
                beConsultoraCUVRegular = blConsultora.GetConsultoraCUVRegular(paisID, campaniaID, cuv);
                beConsultoraCUVCredito = blConsultora.GetConsultoraCUVCredito(paisID, campaniaID, cuv);

                if (beConsultoraTop.EsTop && !string.IsNullOrEmpty(beConsultoraCUVRegular.CUVCredito))
                {
                    beCUVCredito.CuvCredito = beConsultoraCUVRegular.CUVCredito;
                    beCUVCredito.IdMensaje = 1;
                }
                if (!beConsultoraTop.EsTop && !string.IsNullOrEmpty(beConsultoraCUVCredito.CUVRegular))
                {
                    beCUVCredito.CuvRegular = beConsultoraCUVCredito.CUVRegular;
                    beCUVCredito.IdMensaje = 2;
                }
            }

            return beCUVCredito;
        }

        public List<int> ListaPaisValidoCUVCredito()
        {
            List<int> listaPais = new List<int>
                {
                    (int) Enumeradores.TypeDocPais.PR,
                    (int) Enumeradores.TypeDocPais.DO,
                    (int) Enumeradores.TypeDocPais.EC
                };

            return listaPais;
        }

        public void UpdateMontosPedidoWeb(BEPedidoWeb bePedidoWeb)
        {
            var DAPedidoWeb = new DAPedidoWeb(bePedidoWeb.PaisID);
            DAPedidoWeb.UpdateMontosPedidoWeb(bePedidoWeb);
        }

        public BEPedidoWeb GetPedidosWebByConsultoraCampania(int paisID, int consultoraID, int campaniaID)
        {
            var pedidoWeb = new BEPedidoWeb();
            var DAPedidoWeb = new DAPedidoWeb(paisID);

            using (IDataReader reader = DAPedidoWeb.GetPedidosWebByConsultoraCampania(consultoraID, campaniaID))
                if (reader.Read())
                {
                    pedidoWeb = new BEPedidoWeb(reader)
                    {
                        PaisID = paisID
                    };
                }
            return pedidoWeb;
        }

        public List<BEPedidoWeb> GetPedidosFacturados(int paisId, string codigoConsultora)
        {
            var listaPedidosFacturados = new List<BEPedidoWeb>();
            var DAPedidoWeb = new DAPedidoWeb(paisId);

            using (IDataReader reader = DAPedidoWeb.GetPedidosFacturados(codigoConsultora))
                while (reader.Read())
                {
                    var entidad = new BEPedidoWeb(reader);
                    listaPedidosFacturados.Add(entidad);
                }
            return listaPedidosFacturados;
        }

        public List<BEPedidoWeb> GetPedidosIngresadoFacturado(int paisID, int consultoraID, int campaniaID, string codigoConsultora, int top)
        {
            var listaPedidosFacturados = new List<BEPedidoWeb>();

            var BLPais = new BLPais();

            var DAPedidoWeb = new DAPedidoWeb(paisID);

            if (!BLPais.EsPaisHana(paisID))
            {
                using (IDataReader reader = DAPedidoWeb.GetPedidosIngresadoFacturado(consultoraID, campaniaID, top))
                    while (reader.Read())
                    {
                        var entidad = new BEPedidoWeb(reader);
                        listaPedidosFacturados.Add(entidad);
                    }
            }
            else
            {
                var DAPHedidoWeb = new DAHPedido();

                var listaPedidosHana = DAPHedidoWeb.GetPedidosIngresadoFacturado(paisID, codigoConsultora);
                var listaPedidoIngresado = new List<BEPedidoWeb>();
                using (IDataReader reader = DAPedidoWeb.GetPedidosIngresado(consultoraID, campaniaID))
                    while (reader.Read())
                    {
                        var entidad = new BEPedidoWeb(reader);
                        listaPedidoIngresado.Add(entidad);
                    }

                var campaniaMinima = Common.Util.ObtenerCampaniaPasada(campaniaID, 4);

                var listaPedidosHanaFinales = listaPedidosHana.Where(p => p.CampaniaID >= campaniaMinima && p.EstadoPedidoDesc.ToUpper() == "FACTURADO").ToList();

                var listaAgrupada = new List<BEPedidoWeb>();
                listaAgrupada.AddRange(listaPedidosHanaFinales);
                listaAgrupada.AddRange(listaPedidoIngresado);
                listaAgrupada = listaAgrupada.OrderByDescending(p => p.CampaniaID).ToList();

                var listaMostrar = new List<BEPedidoWeb>();
                foreach (var bePedidoWeb in listaAgrupada)
                {
                    if (bePedidoWeb.EstadoPedidoDesc == "INGRESADO")
                    {
                        var bePedidoWebFacturado = listaAgrupada.FirstOrDefault(p => p.CampaniaID == bePedidoWeb.CampaniaID && p.EstadoPedidoDesc != "INGRESADO");
                        if (bePedidoWebFacturado == null)
                        {
                            listaMostrar.Add(bePedidoWeb);
                        }
                    }
                    else
                    {
                        listaMostrar.Add(bePedidoWeb);
                    }
                }

                listaPedidosFacturados = listaMostrar;
            }


            return listaPedidosFacturados;
        }

        public List<BEPedidoWeb> GetPedidosIngresadoFacturadoWebMobile(int paisID, int consultoraID, int campaniaID, int clienteID, int top, string codigoConsultora)
        {
            var listaResultado = new List<BEPedidoWeb>();

            var BLPais = new BLPais();

            var DAPedidoWeb = new DAPedidoWeb(paisID);
            var DAPHedidoWeb = new DAHPedido();

            var listaPedidoIngresado = new List<BEPedidoWeb>();
            var listaPedidoFacturado = new List<BEPedidoWeb>();
            var listaPedido = new List<BEPedidoWeb>();

            if (!BLPais.EsPaisHana(paisID))
            {
                using (IDataReader reader = DAPedidoWeb.GetPedidosIngresadoFacturadoWebMobile(consultoraID, campaniaID, clienteID, top))
                {
                    while (reader.Read())
                    {
                        var entidad = new BEPedidoWeb(reader);
                        listaResultado.Add(entidad);
                    }
                }
            }
            else
            {
                listaPedidoFacturado = DAPHedidoWeb.GetPedidosIngresadoFacturado(paisID, codigoConsultora);

                using (IDataReader reader = DAPedidoWeb.GetPedidosIngresado(consultoraID, campaniaID))
                {
                    while (reader.Read())
                    {
                        var entidad = new BEPedidoWeb(reader);
                        listaPedidoIngresado.Add(entidad);
                    }
                }

                listaPedido.AddRange(listaPedidoIngresado.OrderByDescending(p => p.CampaniaID).Take(top));
                listaPedido.AddRange(listaPedidoFacturado.OrderByDescending(p => p.CampaniaID).Take(top));

                var listaPedidoAgrupada = (from tbl in listaPedido
                                            group tbl by tbl.CampaniaID into grp
                                            select new 
                                            {
                                                CampaniaID = grp.Key,
                                                Cantidad = grp.Count()
                                            }).Where(x=>x.Cantidad > 1);

                var listaPedidoEliminar = (from tblPedido in listaPedido
                                           join tblGroup in listaPedidoAgrupada
                                           on tblPedido.CampaniaID equals tblGroup.CampaniaID
                                           where tblPedido.EstadoPedidoDesc == "INGRESADO"
                                           select tblPedido).ToList();

                listaPedidoEliminar.ForEach(itemPedido =>
                {
                    listaPedido.Remove(itemPedido);
                });

                listaPedido = listaPedido.Take(top).ToList();
            }

            return listaResultado;
        }

        public void InsLogOfertaFinal(int PaisID, BEOfertaFinalConsultoraLog entidad)
        {
             new DAPedidoWeb(PaisID).InsLogOfertaFinal(entidad);
        }

        public void InsLogOfertaFinalBulk(int PaisID, List<BEOfertaFinalConsultoraLog> lista)
        {
            var DAPedidoWeb = new DAPedidoWeb(PaisID);

            if (lista.Any())
            {
                foreach (var item in lista)
                {
                    if (item != null)
                        DAPedidoWeb.InsLogOfertaFinal(item);
                }
            }
        }

        public void ActualizarIndicadorGPRPedidosRechazados(int PaisID, long ProcesoID)
        {
            DAPedidoWeb DAPedidoWeb = new DAPedidoWeb(PaisID);
            DAPedidoWeb.ActualizarIndicadorGPRPedidosRechazados(ProcesoID);
        }

        public void ActualizarIndicadorGPRPedidosFacturados(int PaisID, long ProcesoID)
        {
            DAPedidoWeb DAPedidoWeb = new DAPedidoWeb(PaisID);
            DAPedidoWeb.ActualizarIndicadorGPRPedidosFacturados(ProcesoID);
        }
        public List<BEPedidoWeb> GetPedidosFacturadoSegunDias(int paisID, int campaniaID, long consultoraID, int maxDias)
        {
            var listaPedidosFacturados = new List<BEPedidoWeb>();

            var BLPais = new BLPais();

            var DAPedidoWeb = new DAPedidoWeb(paisID);
            using (IDataReader reader = DAPedidoWeb.GetPedidosFacturadoSegunDias(campaniaID, consultoraID, maxDias))
                while (reader.Read())
                {
                    var entidad = new BEPedidoWeb(reader);
                    var listaDetalle = new List<BEPedidoWebDetalle>();

                    using (IDataReader readerDetalle = DAPedidoWeb.GetPedidosFacturadoDetalle(entidad.PedidoID))
                    {
                        while (readerDetalle.Read())
                        {
                            var detalle = new BEPedidoWebDetalle(readerDetalle);
                            detalle.PedidoID = entidad.PedidoID;
                            listaDetalle.Add(detalle);
                        }
                    }

                    entidad.olstBEPedidoWebDetalle = listaDetalle;

                    listaPedidosFacturados.Add(entidad);
                }

            return listaPedidosFacturados;
        }

        public BEPedidoDescarga ObtenerUltimaDescargaPedido(int PaisID)
        {
            BEPedidoDescarga PedidoDescarga = new BEPedidoDescarga();
            DAPedidoWeb DAPedidoWeb = new DAPedidoWeb(PaisID);

            using (IDataReader reader = DAPedidoWeb.ObtenerUltimaDescargaPedido())
                while (reader.Read())
                {
                    PedidoDescarga = new BEPedidoDescarga(reader);
                }
            return PedidoDescarga;
        }

        public void DeshacerUltimaDescargaPedido(int PaisID)
        {
            DAPedidoWeb DAPedidoWeb = new DAPedidoWeb(PaisID);
            DAPedidoWeb.DesmarcarUltimaDescargaPedido();
        }
        public BEPedidoDescarga ObtenerUltimaDescargaExitosa(int PaisID)
        {
            BEPedidoDescarga PedidoDescarga = new BEPedidoDescarga();
            DAPedidoWeb DAPedidoWeb = new DAPedidoWeb(PaisID);
            using (IDataReader reader = DAPedidoWeb.ObtenerUltimaDescargaExitosa())
            {
                while (reader.Read())
                {
                    PedidoDescarga = new BEPedidoDescarga(reader);
                }
            }
            return PedidoDescarga;
        }

        public BEValidacionModificacionPedido ValidacionModificarPedido(int paisID, long consultoraID, int campania, bool usuarioPrueba, int aceptacionConsultoraDA, bool validarGPR = true, bool validarReservado = true, bool validarHorario = true, bool validarFacturado = true)
        {
            BEUsuario usuario = null;
            using (IDataReader reader = (new DAConfiguracionCampania(paisID)).GetConfiguracionByUsuarioAndCampania(paisID, consultoraID, campania, usuarioPrueba, aceptacionConsultoraDA))
            {
                if (reader.Read()) usuario = new BEUsuario(reader, true);
            }

            BEConfiguracionCampania configuracion = null;
            using (IDataReader reader = new DAPedidoWeb(paisID).GetEstadoPedido(campania, usuarioPrueba ? usuario.ConsultoraAsociadaID : usuario.ConsultoraID))
            {
                if (reader.Read()) configuracion = new BEConfiguracionCampania(reader);
            }

            if (configuracion != null)
            {
                if (validarGPR && configuracion.IndicadorGPRSB == 1) {
                    return new BEValidacionModificacionPedido {
                        MotivoPedidoLock = Enumeradores.MotivoPedidoLock.GPR,
                        Mensaje = string.Format("En este momento nos encontramos facturando tu pedido de C-{0}, inténtalo más tarde", campania.Substring(4, 2))
                    };
                }
                if (validarReservado && configuracion.EstadoPedido == Constantes.EstadoPedido.Procesado && !configuracion.ModificaPedidoReservado && !configuracion.ValidacionAbierta)
                {
                    return new BEValidacionModificacionPedido
                    {
                        MotivoPedidoLock = Enumeradores.MotivoPedidoLock.Reservado,
                        Mensaje = "Ya tienes un pedido reservado para esta campaña."
                    };
                }
                if (validarFacturado && configuracion.IndicadorEnviado)
                {
                    return new BEValidacionModificacionPedido
                    {
                        MotivoPedidoLock = Enumeradores.MotivoPedidoLock.Facturado,
                        Mensaje = "Estamos facturando tu pedido."
                    };
                }
            }
            if(validarHorario)
            {
                string mensajeHorarioRestringido = this.ValidarHorarioRestringido(usuario, campania);
                if(!string.IsNullOrEmpty(mensajeHorarioRestringido))
                {
                    return new BEValidacionModificacionPedido
                    {
                        MotivoPedidoLock = Enumeradores.MotivoPedidoLock.HorarioRestringido,
                        Mensaje = mensajeHorarioRestringido
                    };
                }
            }
            return new BEValidacionModificacionPedido { MotivoPedidoLock = Enumeradores.MotivoPedidoLock.Ninguno };
        }

        private string ValidarHorarioRestringido(BEUsuario usuario, int campania)
        {
            DateTime FechaHoraActual = DateTime.Now.AddHours(usuario.ZonaHoraria);
            if (!usuario.HabilitarRestriccionHoraria) return null;
            if (FechaHoraActual <= usuario.FechaInicioFacturacion || usuario.FechaFinFacturacion.AddDays(1) <= FechaHoraActual) return null;
            
            TimeSpan horaActual = new TimeSpan(FechaHoraActual.Hour, FechaHoraActual.Minute, 0);
            TimeSpan horaAdicional = TimeSpan.Parse(usuario.HorasDuracionRestriccion.ToString() + ":00");

            bool enHorarioRestringido = false;
            if (usuario.EsZonaDemAnti != 0) enHorarioRestringido = (horaActual > usuario.HoraCierreZonaDemAnti);
            else enHorarioRestringido = (usuario.HoraCierreZonaNormal < horaActual && horaActual < usuario.HoraCierreZonaNormal + horaAdicional);
            if (!enHorarioRestringido) return null;

            TimeSpan horaCierre = usuario.EsZonaDemAnti != 0 ? usuario.HoraCierreZonaDemAnti : usuario.HoraCierreZonaNormal;
            return string.Format("En este momento nos encontramos facturando tu pedido de C-{0}. Todos los códigos ingresados hasta las {1} horas han sido registrados en el sistema. Gracias!", campania.Substring(4, 2), horaCierre.ToString(@"hh\:mm"));
        }
        
        public int InsIndicadorPedidoAutentico(int paisID, BEIndicadorPedidoAutentico entidad)
        {
            var DAPedidoWeb = new DAPedidoWeb(paisID);
            entidad.IndicadorToken = AESAlgorithm.Decrypt(entidad.IndicadorToken);
            return DAPedidoWeb.InsIndicadorPedidoAutentico(entidad);
        }

        public int UpdIndicadorPedidoAutentico(int paisID, BEIndicadorPedidoAutentico entidad)
        {
            var DAPedidoWeb = new DAPedidoWeb(paisID);
            return DAPedidoWeb.UpdIndicadorPedidoAutentico(entidad);
        }

        public void DelIndicadorPedidoAutentico(int paisID, BEIndicadorPedidoAutentico entidad)
        {
            var DAPedidoWeb = new DAPedidoWeb(paisID);
            DAPedidoWeb.UpdIndicadorPedidoAutentico(entidad);
        }

        public string GetTokenIndicadorPedidoAutentico(int paisID, string paisISO, string codigoRegion, string codigoZona)
        {
            var DAPedidoWeb = new DAPedidoWeb(paisID);
            return DAPedidoWeb.GetTokenIndicadorPedidoAutentico(paisISO, codigoRegion, codigoZona);
        }

        public BEConsultoraResumen GetResumen(int paisId, int codigoConsultora, int codigoCampania)
        {
            var resumen = new BEConsultoraResumen();
            var DAConsultora = new DAPedidoWeb(paisId);
            using (IDataReader reader = DAConsultora.GetResumenPorCampania(codigoConsultora, codigoCampania))
            {
                do
                {
                    while (reader.Read())
                    {
                        resumen.Build(reader);
                    }

                } while (reader.NextResult());
            }

            return resumen;
        }
        public BEConsultoraRegaloProgramaNuevas GetConsultoraRegaloProgramaNuevas(int paisID, int campaniaId, string codigoConsultora, string codigoRegion, string codigoZona)
        {
            BEConsultoraRegaloProgramaNuevas entidad = null;
            DAPedidoWeb DAPedidoWeb = new DAPedidoWeb(paisID);

            using (IDataReader reader = DAPedidoWeb.GetConsultoraRegaloProgramaNuevas(campaniaId, codigoConsultora, codigoRegion, codigoZona))
            {
                while (reader.Read())
                {
                    entidad = new BEConsultoraRegaloProgramaNuevas(reader);
                }
            }
            return entidad;
        }

        #region MisPedidos
        public List<BEMisPedidosCampania> GetMisPedidosByCampania(int paisID, long ConsultoraID, int CampaniaID, int ClienteID, int Top)
        {
            var pedidos = new List<BEMisPedidosCampania>();

            using (IDataReader reader = new DAPedidoWeb(paisID).GetMisPedidosByCampania(ConsultoraID, CampaniaID, ClienteID, Top))
            {
                pedidos = reader.MapToCollection<BEMisPedidosCampania>();
            }

            return pedidos;
        }
        public List<BEMisPedidosIngresados> GetMisPedidosIngresados(int paisID, long ConsultoraID, int CampaniaID, int ClienteID, string NombreConsultora)
        {
            var pedidos = new List<BEMisPedidosIngresados>();
            var detallepedidos = new List<BEMisPedidosIngresadosDetalle>();

            using (IDataReader reader = new DAPedidoWeb(paisID).GetMisPedidosIngresados(ConsultoraID, CampaniaID, ClienteID, NombreConsultora))
            {
                pedidos = reader.MapToCollection<BEMisPedidosIngresados>();

                if (reader.NextResult()) detallepedidos = reader.MapToCollection<BEMisPedidosIngresadosDetalle>();

                foreach (var pedido in pedidos)
                {
                    pedido.Detalle = detallepedidos.Where(x => x.ClienteID == pedido.ClienteID).ToList();
                }
            }

            return pedidos;
        }
        public List<BEMisPedidosFacturados> GetMisPedidosFacturados(int paisID, long ConsultoraID, int CampaniaID, int ClienteID, string NombreConsultora)
        {
            var pedidos = new List<BEMisPedidosFacturados>();
            var detallepedidos = new List<BEMisPedidosFacturadosDetalle>();

            using (IDataReader reader = new DAPedidoWeb(paisID).GetMisPedidosFacturados(ConsultoraID, CampaniaID, ClienteID, NombreConsultora))
            {
                pedidos = reader.MapToCollection<BEMisPedidosFacturados>();

                if (reader.NextResult()) detallepedidos = reader.MapToCollection<BEMisPedidosFacturadosDetalle>();

                foreach (var pedido in pedidos)
                {
                    pedido.Detalle = detallepedidos.Where(x => x.ClienteID == pedido.ClienteID).ToList();
                }
            }

            return pedidos;
        }
        #endregion

        #region ProductosPrecargados
        public int GetFlagProductosPrecargados(int paisID, string CodigoConsultora, int CampaniaID)
        {
            var DAPedidoWeb = new DAPedidoWeb(paisID);
            return DAPedidoWeb.GetFlagProductosPrecargados(CodigoConsultora, CampaniaID);
        }
        
        public void UpdateMostradoProductosPrecargados(int paisID, int CampaniaID, long ConsultoraID, string IPUsuario)
        {
            var DAPedidoWeb = new DAPedidoWeb(paisID);
            DAPedidoWeb.UpdateMostradoProductosPrecargados(CampaniaID, ConsultoraID, IPUsuario);
        }        
        #endregion

        #region Certificado Digital
        public bool TieneCampaniaConsecutivas(int paisId, int campaniaId, int cantidadCampaniaConsecutiva, long consultoraId)
        {
            var DAPedidoWeb = new DAPedidoWeb(paisId);
            return DAPedidoWeb.TieneCampaniaConsecutivas(campaniaId, cantidadCampaniaConsecutiva, consultoraId);
        }

        public BEMiCertificado ObtenerCertificadoDigital(int paisId, int campaniaId, long consultoraId, Int16 tipoCert)
        {
            BEMiCertificado entidad = null;
            DAPedidoWeb DAPedidoWeb = new DAPedidoWeb(paisId);

            using (IDataReader reader = DAPedidoWeb.ObtenerCertificadoDigital(campaniaId, consultoraId, tipoCert))
            {
                while (reader.Read())
                {
                    entidad = new BEMiCertificado(reader);
                }
            }
            return entidad;
        }

        #endregion
    }

    internal class TemplateField
    {
        private string fieldName;
        private int size;

        public TemplateField(string fieldInfo)
        {
            string[] parts = fieldInfo.Split(',');
            fieldName = parts[0].ToUpper();
            size = int.Parse(parts[1]);
        }

        public string FieldName
        {
            get { return fieldName; }
        }

        public int Size
        {
            get { return size; }
        }
    }
}