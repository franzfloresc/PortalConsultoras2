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
using System.Net;
using System.Web.Script.Serialization;

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

            try
            {

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


            }
            catch (Exception ex)
            {
                LogManager.SaveLog(ex, consultoraID, paisID);
                pedidoWeb = new List<BEPedidoWeb>();
            }

            return pedidoWeb;
        }

        public IList<BEPedidoDDWeb> GetPedidosDDWeb(BEPedidoDDWeb BEPedidoDDWeb)
        {
            var pedidoDdWeb = new List<BEPedidoDDWeb>
            {
                new BEPedidoDDWeb
                {
                    CampaniaID = 10010,
                    PedidoID = 10001,
                    NroRegistro = "000001",
                    FechaRegistro = Convert.ToDateTime("01/01/2013 10:00:00"),
                    CampaniaCodigo = "CM001 - 2013",
                    Seccion = "S0001",
                    ConsultoraCodigo = "C00001",
                    ConsultoraNombre = "Consultora 01",
                    ImporteTotal = 80,
                    UsuarioResponsable = "Usuario 1",
                    ConsultoraSaldo = 12,
                    OrigenNombre = "DD",
                    EstadoValidacionNombre = "SI"
                },
                new BEPedidoDDWeb
                {
                    CampaniaID = 10009,
                    PedidoID = 10002,
                    NroRegistro = "000002",
                    FechaRegistro = Convert.ToDateTime("01/01/2013 10:00:00"),
                    CampaniaCodigo = "CM001 - 2013",
                    Seccion = "S0002",
                    ConsultoraCodigo = "C00002",
                    ConsultoraNombre = "Consultora 02",
                    ImporteTotal = 970,
                    UsuarioResponsable = "Usuario 2",
                    ConsultoraSaldo = 15,
                    OrigenNombre = "Web",
                    EstadoValidacionNombre = "NO"
                },
                new BEPedidoDDWeb
                {
                    CampaniaID = 10008,
                    PedidoID = 10003,
                    NroRegistro = "000003",
                    FechaRegistro = Convert.ToDateTime("02/01/2013 10:00:00"),
                    CampaniaCodigo = "CM002 - 2013",
                    Seccion = "S0003",
                    ConsultoraCodigo = "C00003",
                    ConsultoraNombre = "Consultora 03",
                    ImporteTotal = 900,
                    UsuarioResponsable = "Usuario 2",
                    ConsultoraSaldo = 14,
                    OrigenNombre = "DD",
                    EstadoValidacionNombre = "NO"
                },
                new BEPedidoDDWeb
                {
                    CampaniaID = 10007,
                    PedidoID = 10004,
                    NroRegistro = "000004",
                    FechaRegistro = Convert.ToDateTime("03/01/2013 10:00:00"),
                    CampaniaCodigo = "CM001 - 2013",
                    Seccion = "S0004",
                    ConsultoraCodigo = "C00004",
                    ConsultoraNombre = "Consultora 04",
                    ImporteTotal = 870,
                    UsuarioResponsable = "Usuario 1",
                    ConsultoraSaldo = 0,
                    OrigenNombre = "Web",
                    EstadoValidacionNombre = "NO"
                },
                new BEPedidoDDWeb
                {
                    CampaniaID = 10006,
                    PedidoID = 10005,
                    NroRegistro = "000005",
                    FechaRegistro = Convert.ToDateTime("04/01/2013 10:00:00"),
                    CampaniaCodigo = "CM003 - 2013",
                    Seccion = "S0005",
                    ConsultoraCodigo = "C00005",
                    ConsultoraNombre = "Consultora 05",
                    ImporteTotal = 420,
                    UsuarioResponsable = "Usuario 2",
                    ConsultoraSaldo = 56,
                    OrigenNombre = "DD",
                    EstadoValidacionNombre = "SI"
                },
                new BEPedidoDDWeb
                {
                    CampaniaID = 10005,
                    PedidoID = 10006,
                    NroRegistro = "000006",
                    FechaRegistro = Convert.ToDateTime("05/01/2013 10:00:00"),
                    CampaniaCodigo = "CM004 - 2013",
                    Seccion = "S0006",
                    ConsultoraCodigo = "C00001",
                    ConsultoraNombre = "Consultora 02",
                    ImporteTotal = 350,
                    UsuarioResponsable = "Usuario 1",
                    ConsultoraSaldo = 57,
                    OrigenNombre = "DD",
                    EstadoValidacionNombre = "SI"
                },
                new BEPedidoDDWeb
                {
                    CampaniaID = 10004,
                    PedidoID = 10007,
                    NroRegistro = "000007",
                    FechaRegistro = Convert.ToDateTime("05/01/2013 10:00:00"),
                    CampaniaCodigo = "CM002 - 2013",
                    Seccion = "S0007",
                    ConsultoraCodigo = "C00006",
                    ConsultoraNombre = "Consultora 04",
                    ImporteTotal = 2000,
                    UsuarioResponsable = "Usuario 3",
                    ConsultoraSaldo = 23,
                    OrigenNombre = "Web",
                    EstadoValidacionNombre = "NO"
                },
                new BEPedidoDDWeb
                {
                    CampaniaID = 10003,
                    PedidoID = 10008,
                    NroRegistro = "000008",
                    FechaRegistro = Convert.ToDateTime("05/01/2013 10:00:00"),
                    CampaniaCodigo = "CM003 - 2013",
                    Seccion = "S0006",
                    ConsultoraCodigo = "C00005",
                    ConsultoraNombre = "Consultora 01",
                    ImporteTotal = 4420,
                    UsuarioResponsable = "Usuario 1",
                    ConsultoraSaldo = 45,
                    OrigenNombre = "DD",
                    EstadoValidacionNombre = "SI"
                },
                new BEPedidoDDWeb
                {
                    CampaniaID = 10002,
                    PedidoID = 10009,
                    NroRegistro = "000009",
                    FechaRegistro = Convert.ToDateTime("07/01/2013 10:00:00"),
                    CampaniaCodigo = "CM001 - 2013",
                    Seccion = "S0005",
                    ConsultoraCodigo = "C00002",
                    ConsultoraNombre = "Consultora 03",
                    ImporteTotal = 2230,
                    UsuarioResponsable = "Usuario 4",
                    ConsultoraSaldo = 89,
                    OrigenNombre = "Web",
                    EstadoValidacionNombre = "NO"
                },
                new BEPedidoDDWeb
                {
                    CampaniaID = 10001,
                    PedidoID = 10010,
                    NroRegistro = "000010",
                    FechaRegistro = Convert.ToDateTime("08/01/2013 10:00:00"),
                    CampaniaCodigo = "CM004 - 2013",
                    Seccion = "S0004",
                    ConsultoraCodigo = "C00004",
                    ConsultoraNombre = "Consultora 08",
                    ImporteTotal = 1230,
                    UsuarioResponsable = "Usuario 5",
                    ConsultoraSaldo = 123,
                    OrigenNombre = "Web",
                    EstadoValidacionNombre = "SI"
                }
            };


            return pedidoDdWeb;
        }

        public string[] DescargaPedidosWeb(int paisID, DateTime fechaFacturacion, int tipoCronograma, bool marcarPedido, string usuario, string descripcionProceso)
        {
            int nroLote = 0;
            DAPedidoWeb daPedidoWeb = null;
            DAPedidoDD daPedidoDd = null;
            DataSet dsPedidosWeb = null, dsPedidosDd = null;
            DataTable dtPedidosWeb = null, dtPedidosDd = null, dtDatosConsultora = null;

            FtpConfigurationElement ftpElement;
            FtpConfigurationElement ftpElementCoDat = null;

            Exception exceptionCoDat = null;
            string headerFile, detailFile;
            string dataConFile = null, nombreCoDat = null, errorCoDat = null;
            string detailFileAct, nombreDetalleAct = null;
            string headerFileS3, detailFileS3, dataConFileS3 = null;
            string nombreCabecera, nombreDetalle;
            bool incluirConsultora = ConfigurationManager.AppSettings["OrderDownloadIncludeDatosConsultora"] == "1" && tipoCronograma == 1;

            DateTime fechaHoraPais;
            try { fechaHoraPais = new DAPedidoWeb(paisID).GetFechaHoraPais(); }
            catch { fechaHoraPais = DateTime.Now; }
            
            string codigoPais = null;
            try
            {
                codigoPais = new BLZonificacion().SelectPais(paisID).CodigoISO;
                var codigoPaisProd = new BLZonificacion().SelectPais(paisID).CodigoISOProd;

                int tmpCronograma = (tipoCronograma == 2 && marcarPedido) ? 3 : tipoCronograma;                
                var section = (DataAccessConfiguration)ConfigurationManager.GetSection("Belcorp.Configuration");
                var element = section.Countries[paisID];

                string postfixHeaderTemplate =
                    (ConfigurationManager.AppSettings["HasDiffCA-PRD"].Contains(codigoPais) && tmpCronograma != 1) ? "PRD" :
                    (codigoPais == Constantes.CodigosISOPais.Colombia && tmpCronograma == 2) ? "DA" : "";
                string postfixDetailTemplate = (codigoPais == Constantes.CodigosISOPais.Colombia && tmpCronograma == 2) ? "DA" : "";

                var headerTemplate = ParseTemplate(ConfigurationManager.AppSettings[element.OrderHeaderTemplate + postfixHeaderTemplate]);
                var detailTemplate = ParseTemplate(ConfigurationManager.AppSettings[element.OrderDetailTemplate + postfixDetailTemplate]);

                daPedidoWeb = new DAPedidoWeb(paisID);
                
                try
                {
                    daPedidoWeb.InsPedidoDescarga(fechaFacturacion, 1, tipoCronograma, marcarPedido, usuario, out nroLote);
                    dsPedidosWeb = daPedidoWeb.GetPedidoWebByFechaFacturacion(fechaFacturacion, tmpCronograma, nroLote);
                    dtPedidosWeb = dsPedidosWeb.Tables[0]; // Obtiene cabecera
                }
                catch (SqlException ex)
                {
                    if (ex.Number == 50000) throw new BizLogicException("Existe una descarga de pedidos en proceso para la fecha seleccionada.", ex);
                    else throw new BizLogicException("No se pudo acceder al origen de datos de pedidos Web.", ex);
                }

                if (ConfigurationManager.AppSettings["OrderDownloadIncludeDD"] == "1")
                {
                    try
                    {
                        daPedidoDd = new DAPedidoDD(paisID);
                        dsPedidosDd = daPedidoDd.GetPedidoDDByFechaFacturacion(codigoPais, tipoCronograma, fechaFacturacion, nroLote);
                        dtPedidosDd = dsPedidosDd.Tables[0];
                    }
                    catch (SqlException ex)
                    {
                        LogManager.SaveLog(ex, usuario, codigoPais);
                        throw new BizLogicException("No se pudo acceder al origen de datos de pedidos DD.", ex);
                    }
                }
                
                if (incluirConsultora)
                {
                    try
                    {
                        var dsDatosConsultora = daPedidoWeb.GetDatosConsultoraProcesoCarga(nroLote, usuario);
                        dtDatosConsultora = dsDatosConsultora.Tables[0];
                    }
                    catch (SqlException ex)
                    {
                        LogManager.SaveLog(ex, usuario, codigoPais);
                        exceptionCoDat = ex;
                        errorCoDat = "No se pudo acceder a la información de las Consultoras.";
                    }
                }

                TransactionOptions transactionOptions = new TransactionOptions { IsolationLevel = System.Transactions.IsolationLevel.ReadUncommitted };
                using (TransactionScope transaction = new TransactionScope(TransactionScopeOption.Required, transactionOptions))
                {
                    this.ConfigurarDTCargaWebDD(dsPedidosWeb, dsPedidosDd, fechaFacturacion, nroLote, usuario, codigoPais);
                    daPedidoWeb.InsLogPedidoDescargaWebDD(dsPedidosWeb, dsPedidosDd);
                    daPedidoWeb.UpdLogPedidoDescargaWebDD(nroLote);
                    transaction.Complete();
                }

                Guid fileGuid = Guid.NewGuid();
                string key = codigoPais + "-" + (tipoCronograma == 1 ? "DR" : marcarPedido ? "DA-PRD" : "DA");
                String keyActDat = codigoPais + "-" + "ACDAT";
                var ftpSection = (FtpConfigurationSection)ConfigurationManager.GetSection("Belcorp.FtpConfiguration");

                try
                {
                    ftpElement = ftpSection.FtpConfigurations[key];
                    var ftpElementActDAt = ftpSection.FtpConfigurations[keyActDat];

                    headerFileS3 = headerFile = FormatFile(codigoPais, ftpElement.Header, fechaFacturacion, fileGuid);
                    detailFileS3 = detailFile = FormatFile(codigoPais, ftpElement.Detail, fechaFacturacion, fileGuid);
                    detailFileAct = FormatFile(codigoPais, ftpElementActDAt.Detail, fechaFacturacion, fileGuid);
                    
                    nombreCabecera = headerFile.Replace(ConfigurationManager.AppSettings["OrderDownloadPath"], "");
                    nombreDetalle = detailFile.Replace(ConfigurationManager.AppSettings["OrderDownloadPath"], "");
                    nombreDetalleAct = detailFileAct.Replace(ConfigurationManager.AppSettings["OrderDownloadPath"], "");

                    string fechaFactura = fechaFacturacion.ToString("yyyyMMdd");
                    string fechaProceso = DateTime.Now.ToString("yyyyMMdd");
                    string lote = nroLote.ToString();

                    using (var streamWriter = new StreamWriter(headerFile))
                    {
                        bool vacio = true;
                        if (dtPedidosWeb.Rows.Count > 0 && dsPedidosWeb.Tables[1].Rows.Count > 0)
                        {
                            vacio = false;
                            foreach (DataRow row in dtPedidosWeb.Rows)
                            {
                                streamWriter.WriteLine(HeaderLine(headerTemplate, row, codigoPaisProd, fechaProceso, fechaFactura, lote, "W"));
                            }
                        }
                        if (dtPedidosDd != null && dtPedidosDd.Rows.Count > 0)
                        {
                            vacio = false;
                            foreach (DataRow row in dtPedidosDd.Rows)
                            {
                                streamWriter.WriteLine(HeaderLine(headerTemplate, row, codigoPaisProd, fechaProceso, fechaFactura, lote, "D"));
                            }
                        }

                        if(vacio) streamWriter.Write(string.Empty);
                    }

                    dtPedidosWeb = dsPedidosWeb.Tables[1];
                    if (dsPedidosDd != null) dtPedidosDd = dsPedidosDd.Tables[1];

                    using (var streamWriter = new StreamWriter(detailFile))
                    {
                        bool vacio = true;
                        if (dtPedidosWeb.Rows.Count > 0)
                        {
                            vacio = false;
                            foreach (DataRow row in dtPedidosWeb.Rows)
                            {
                                streamWriter.WriteLine(DetailLine(detailTemplate, row, codigoPaisProd, lote));
                            }
                        }
                        if (dtPedidosDd != null && dtPedidosDd.Rows.Count > 0)
                        {
                            vacio = false;
                            foreach (DataRow row in dtPedidosDd.Rows)
                            {
                                streamWriter.WriteLine(DetailLine(detailTemplate, row, codigoPaisProd, lote));
                            }
                        }

                        if(vacio) streamWriter.Write(string.Empty);
                    }
                }
                catch (Exception ex)
                {
                    LogManager.SaveLog(ex, usuario, codigoPais);
                    throw new BizLogicException("No se pudo generar los archivos de descarga de pedidos.", ex);
                }

                if (incluirConsultora && string.IsNullOrEmpty(errorCoDat))
                {
                    try
                    {
                        bool descargaActDatosv2 = ConfigurationManager.AppSettings["DescargaActDatosv2"] == "1";
                        var actdatosTemplate = ParseTemplate(ConfigurationManager.AppSettings[element.ActDatosTemplate], descargaActDatosv2);
                        ftpElementCoDat = ftpSection.FtpConfigurations[codigoPais + "-ACDAT"];
                        dataConFileS3 = dataConFile = FormatFile(codigoPais, ftpElementCoDat.Header, fechaFacturacion, fileGuid);
                        nombreCoDat = dataConFile.Replace(ConfigurationManager.AppSettings["OrderDownloadPath"], "");

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
                        errorCoDat = "No se pudo generar los archivos de datos de consultora.";
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
                                        
                    if (ConfigurationManager.AppSettings["OrderDownloadFtpUpload"] == "1")
                    {
                        try
                        {
                            BLFileManager.FtpUploadFile(ftpElement.Address + ftpElement.Header, headerFile, ftpElement.UserName, ftpElement.Password);
                            BLFileManager.FtpUploadFile(ftpElement.Address + ftpElement.Detail, detailFile, ftpElement.UserName, ftpElement.Password);
                        }
                        catch (Exception ex)
                        {
                            LogManager.SaveLog(ex, usuario, codigoPais);
                            throw new BizLogicException("No se pudo subir los archivos de pedidos al destino FTP.", ex);
                        }

                        if (ConfigurationManager.AppSettings["OrderDownloadIncludeDatosConsultora"] == "1" && tipoCronograma == 1 && string.IsNullOrEmpty(errorCoDat))
                        {
                            try
                            {
                                BLFileManager.FtpUploadFile(ftpElementCoDat.Address + ftpElementCoDat.Header, dataConFile, ftpElementCoDat.UserName, ftpElementCoDat.Password);
                            }
                            catch (Exception ex)
                            {
                                LogManager.SaveLog(ex, usuario, codigoPais);
                                exceptionCoDat = ex;
                                errorCoDat = "No se pudo subir los archivos de datos de consultora al destino FTP.";
                            }
                        }
                    }
                    detailFile = headerFile = dataConFile = null;
                    detailFileAct = null;

                    if (dtPedidosDd != null && dtPedidosDd.Rows.Count > 0)
                    {
                        try
                        {
                            daPedidoDd.UpdPedidoDDIndicadorEnviado(nroLote, marcarPedido, fechaHoraPais);
                        }
                        catch (Exception ex)
                        {
                            LogManager.SaveLog(ex, usuario, codigoPais);
                            throw new BizLogicException("No se pudo marcar los pedidos DD como enviados.", ex);
                        }
                    }

                    try
                    {
                        daPedidoWeb.UpdCuponPedidoWebEnviado(nroLote, marcarPedido);
                    }
                    catch (Exception ex)
                    {
                        LogManager.SaveLog(ex, usuario, codigoPais);
                        throw new BizLogicException("No se pudo marcar los cupones de los pedidos web.", ex);
                    }

                    try
                    {
                        daPedidoWeb.UpdPedidoWebIndicadorEnviado(nroLote, marcarPedido, 2, null, null, nombreCabecera, nombreDetalle, System.Environment.MachineName);
                    }
                    catch (Exception ex)
                    {
                        LogManager.SaveLog(ex, usuario, codigoPais);
                        throw new BizLogicException("No se pudo marcar los pedidos Web como enviados.", ex);
                    }

                    if (incluirConsultora && string.IsNullOrEmpty(errorCoDat))
                    {
                        try
                        {
                            daPedidoWeb.UpdDatosConsultoraIndicadorEnviado(nroLote, 2, null, null, nombreCoDat, System.Environment.MachineName);
                        }
                        catch (Exception ex)
                        {
                            LogManager.SaveLog(ex, usuario, codigoPais);
                            exceptionCoDat = ex;
                            errorCoDat = "No se pudo marcar los datos de la consultora como enviados.";
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
                    try { daPedidoWeb.UpdPedidoWebIndicadorEnviado(nroLote, false, 99, error, errorExcepcion, string.Empty, string.Empty, string.Empty); }
                    catch (Exception ex2) { LogManager.SaveLog(ex2, usuario, codigoPais); }

                    if (dtPedidosDd != null && dtPedidosDd.Rows.Count > 0)
                    {
                        try { daPedidoDd.UpdPedidoDDIndicadorEnviado(nroLote, false, fechaHoraPais); }
                        catch (Exception ex2) { LogManager.SaveLog(ex2, usuario, codigoPais); }
                    }
                }
                MailUtilities.EnviarMailProcesoDescargaExcepcion("Descarga de pedidos", codigoPais, fechaHoraPais, descripcionProceso, error, errorExcepcion);

                if (incluirConsultora)
                {
                    if (exceptionCoDat != null)
                    {
                        error = errorCoDat;
                        errorExcepcion = ErrorUtilities.GetExceptionMessage(exceptionCoDat);
                    }
                    if (nroLote > 0)
                    {
                        try { daPedidoWeb.UpdDatosConsultoraIndicadorEnviado(nroLote, 99, error, errorExcepcion, string.Empty, string.Empty); }
                        catch (Exception ex2) { LogManager.SaveLog(ex2, usuario, codigoPais); }
                    }
                    MailUtilities.EnviarMailProcesoDescargaExcepcion("Actualización Datos Consultora", codigoPais, fechaHoraPais, descripcionProceso, error, errorExcepcion);
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
                    daPedidoWeb.UpdPedidoDescargaGuardoS3(nroLote, true, null, null);
                }
                catch (Exception ex)
                {
                    LogManager.SaveLog(ex, usuario, codigoPais);

                    string error = "Terminado OK; pero con error al guardar backups en S3.";
                    string errorExcepcion = ErrorUtilities.GetExceptionMessage(ex);
                    try { daPedidoWeb.UpdPedidoDescargaGuardoS3(nroLote, false, error, errorExcepcion); }
                    catch (Exception ex2) { LogManager.SaveLog(ex2, usuario, codigoPais); }
                    MailUtilities.EnviarMailProcesoDescargaExcepcion("Descarga de pedidos", codigoPais, fechaHoraPais, descripcionProceso, error, errorExcepcion);
                }

                if (ConfigurationManager.AppSettings["OrderDownloadIncludeDatosConsultora"] == "1" && tipoCronograma == 1 &&
                    string.IsNullOrEmpty(errorCoDat) && !string.IsNullOrEmpty(dataConFileS3))
                {
                    try
                    {
                        carpetaPais = ConfigurationManager.AppSettings["S3_ActualizacionDatos"] + codigoPais;
                        ConfigS3.SetFileS3(dataConFileS3, carpetaPais, Path.GetFileName(dataConFileS3), false, false, true);
                        daPedidoWeb.UpdConsultoraDescargaGuardoS3(nroLote, true, null, null);
                    }
                    catch (Exception ex)
                    {
                        LogManager.SaveLog(ex, usuario, codigoPais);

                        string error = "Terminado OK; pero con error al guardar backups en S3.";
                        string errorExcepcion = ErrorUtilities.GetExceptionMessage(ex);
                        try { daPedidoWeb.UpdConsultoraDescargaGuardoS3(nroLote, false, error, errorExcepcion); }
                        catch (Exception ex2) { LogManager.SaveLog(ex2, usuario, codigoPais); }
                        MailUtilities.EnviarMailProcesoDescargaExcepcion("Actualización Datos Consultora", codigoPais, fechaHoraPais, descripcionProceso, error, errorExcepcion);
                    }
                }
            }

            string[] s;
            if (headerFile == null && detailFile == null && detailFileAct == null) s = new string[] { };
            else s = new string[] { headerFile, detailFile, detailFileAct };
            return s;
        }

        public string[] DescargaPedidosDD(int paisID, DateTime fechaFacturacion, int tipoCronograma, bool marcarPedido, string usuario)
        {
            int nroLote = 0;

            DataTable dtPedidosDd = null;
            DAPedidoDD daPedidoDd = null;

            string headerFile, detailFile;
            string codigoPais = null;

            DateTime fechaHoraPais;
            try { fechaHoraPais = new DAPedidoWeb(paisID).GetFechaHoraPais(); }
            catch { fechaHoraPais = DateTime.Now; }

            try
            {
                codigoPais = new BLZonificacion().SelectPais(paisID).CodigoISO;
                var codigoPaisProd = new BLZonificacion().SelectPais(paisID).CodigoISOProd;

                var section = (DataAccessConfiguration)ConfigurationManager.GetSection("Belcorp.Configuration");
                var element = section.Countries[paisID];

                var orderHeaderTemplate = element.OrderHeaderTemplate;

                var headerTemplate = ParseTemplate(ConfigurationManager.AppSettings[orderHeaderTemplate]);
                var detailTemplate = ParseTemplate(ConfigurationManager.AppSettings[element.OrderDetailTemplate]);

                var daPedidoWeb = new DAPedidoWeb(paisID);

                DataSet dsPedidosWeb = null;

                try
                {
                    daPedidoWeb.InsPedidoDescarga(fechaFacturacion, 1, tipoCronograma, marcarPedido, usuario, out nroLote);
                }
                catch (SqlException ex)
                {
                    if (ex.Number == 50000)
                        throw new BizLogicException("Existe una descarga de pedidos en proceso para la fecha seleccionada.", ex);
                    else
                        throw new BizLogicException("No se pudo acceder al origen de datos de pedidos Web.", ex);
                }

                DataSet dsPedidosDd = null;
                try
                {
                    daPedidoDd = new DAPedidoDD(paisID);
                    dsPedidosDd = daPedidoDd.GetPedidoDDByFechaFacturacion(codigoPais, tipoCronograma, fechaFacturacion, nroLote);
                    dtPedidosDd = dsPedidosDd.Tables[0];
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
                    this.ConfigurarDTCargaWebDD(dsPedidosWeb, dsPedidosDd, fechaFacturacion, nroLote, usuario, codigoPais);
                    daPedidoWeb.InsLogPedidoDescargaWebDD(dsPedidosWeb, dsPedidosDd);
                    daPedidoWeb.UpdLogPedidoDescargaWebDD(nroLote);
                    transaction.Complete();
                }

                FtpConfigurationElement ftpElement;

                Guid fileGuid = Guid.NewGuid();
                string key = codigoPais + "-DR";
                var ftpSection = (FtpConfigurationSection)ConfigurationManager.GetSection("Belcorp.FtpConfiguration");

                string nombreCabecera;
                string nombreDetalle;
                try
                {
                    ftpElement = ftpSection.FtpConfigurations[key];
                    headerFile = FormatFile(codigoPais, ftpElement.Header, fechaFacturacion, fileGuid);
                    detailFile = FormatFile(codigoPais, ftpElement.Detail, fechaFacturacion, fileGuid);
                    nombreCabecera = headerFile.Replace(ConfigurationManager.AppSettings["OrderDownloadPath"], "");
                    nombreDetalle = detailFile.Replace(ConfigurationManager.AppSettings["OrderDownloadPath"], "");

                    string fechaFactura = fechaFacturacion.ToString("yyyyMMdd");
                    string fechaProceso = DateTime.Now.ToString("yyyyMMdd");
                    string lote = nroLote.ToString();

                    using (var streamWriter = new StreamWriter(headerFile))
                    {
                        if (dtPedidosDd != null)
                        {
                            foreach (DataRow row in dtPedidosDd.Rows)
                            {
                                streamWriter.WriteLine(HeaderLine(headerTemplate, row, codigoPaisProd, fechaProceso, fechaFactura, lote, "D"));
                            }
                        }
                        else
                            streamWriter.Write(string.Empty);
                    }

                    if (dsPedidosDd != null)
                        dtPedidosDd = dsPedidosDd.Tables[1];

                    using (var streamWriter = new StreamWriter(detailFile))
                    {
                        if (dtPedidosDd != null)
                        {
                            foreach (DataRow row in dtPedidosDd.Rows)
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
                        daPedidoDd.UpdPedidoDDIndicadorEnviadoDD(nroLote, marcarPedido, fechaHoraPais, 2, null, null, nombreCabecera, nombreDetalle, System.Environment.MachineName);
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
                if (nroLote > 0 && dtPedidosDd != null && dtPedidosDd.Rows.Count > 0)
                {
                    try { daPedidoDd.UpdPedidoDDIndicadorEnviadoDD(nroLote, false, fechaHoraPais, 99, error, errorExcepcion, string.Empty, string.Empty, string.Empty); }
                    catch (Exception ex2) { LogManager.SaveLog(ex2, usuario, codigoPais); }
                }
                MailUtilities.EnviarMailProcesoDescargaExcepcion("Descarga de pedidos", codigoPais, fechaHoraPais, Enumeradores.TipoDescargaPedidos.DigitacionDistribuidaParcial.ToString(), error, errorExcepcion);

                throw;
            }
            string[] s;

            if (headerFile == null && detailFile == null)
                s = new string[] { };
            else
                s = new string[] { headerFile, detailFile };

            return s;
        }

        public string[] DescargaPedidosFIC(int paisID, DateTime fechaFacturacion, int tipoCronograma, string usuario)
        {
            int nroLote = 0;
            string headerFile, detailFile;

            try
            {
                string codigoPais = new BLZonificacion().SelectPais(paisID).CodigoISO;
                string codigoPaisProd = new BLZonificacion().SelectPais(paisID).CodigoISOProd;

                var section = (DataAccessConfiguration)ConfigurationManager.GetSection("Belcorp.Configuration");
                var element = section.Countries[paisID];
                var headerTemplate = ParseTemplate(ConfigurationManager.AppSettings[element.OrderHeaderTemplate]);
                var detailTemplate = ParseTemplate(ConfigurationManager.AppSettings[element.OrderDetailTemplate]);

                var daPedidoFic = new DAPedidoFIC(paisID);
                DataSet dsPedidosWeb;
                DataTable dtPedidosWeb;
                try
                {
                    dsPedidosWeb = daPedidoFic.GetPedidoFICByFechaFacturacion(fechaFacturacion, nroLote);
                    dtPedidosWeb = dsPedidosWeb.Tables[0];
                }
                catch (SqlException ex)
                {
                    throw new BizLogicException("No se pudo acceder al origen de datos de pedidos Web.", ex);
                }

                FtpConfigurationElement ftpElement;
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

            string[] s;
            if (headerFile == null && detailFile == null) s = new string[] { };
            else s = new string[] { headerFile, detailFile };
            return s;
        }

        private void ConfigurarDTCargaWebDD(DataSet dsPedidosWeb, DataSet dsPedidosDD, DateTime fechaFacturacion, int nroLote, string usuario, string codigoPais)
        {
            this.ConfigurarDTCargaHeader(dsPedidosWeb, fechaFacturacion, nroLote, "W", usuario);
            this.ConfigurarDTCargaHeader(dsPedidosDD, fechaFacturacion, nroLote, "D", usuario);
        }

        private void ConfigurarDTCargaDetalle(DataSet dsPedidosDetalle, DateTime fechaFactura, int nroLote)
        {
            if (dsPedidosDetalle == null) return;

            var dtPedidosDetalle = dsPedidosDetalle.Tables[1];
            if (dtPedidosDetalle.Rows.Count == 0) return;

            AddDTColumn(dtPedidosDetalle, "LogFechaFacturacion", fechaFactura);
            AddDTColumn(dtPedidosDetalle, "LogNroLote", nroLote);
        }

        private void ConfigurarDTCargaHeader(DataSet dsPedidos, DateTime fechaFactura, int nroLote, string origen, string usuario)
        {
            if (dsPedidos == null) return;

            var dtPedidosCabecera = dsPedidos.Tables[0];
            if (dtPedidosCabecera.Rows.Count == 0) return;

            AddDTColumn(dtPedidosCabecera, "LogFechaFacturacion", fechaFactura);
            AddDTColumn(dtPedidosCabecera, "LogNroLote", nroLote);
            AddDTColumn(dtPedidosCabecera, "LogCantidad", 0);
            AddDTColumn(dtPedidosCabecera, "LogCodigoUsuarioProceso", usuario);
            if (origen != string.Empty) AddDTColumn(dtPedidosCabecera, "Origen", origen);
            if(!DataRecord.HasColumn(dtPedidosCabecera, "VersionProl")) AddDTColumn<byte>(dtPedidosCabecera, "VersionProl", 2);

            ConfigurarDTCargaDetalle(dsPedidos, fechaFactura, nroLote);
        }

        private void AddDTColumn<T>(DataTable dt, string columnName, T defaultValue)
        {
            dt.Columns.Add(new DataColumn(columnName, typeof(T)) { DefaultValue = defaultValue });
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
                        item = !ConfigurationManager.AppSettings["IsSICCFOX"].Contains(codigoPais)
                            ? row["CodigoZona"].ToString()
                            : row["CodigoZona"].ToString().Substring(0, 4);
                        break;
                    case "LOTE": item = lote; break;
                    case "ORIGEN": item = origen; break;
                    case "VALIDADO": item = row["Validado"].ToString(); break;
                    case "COMPARTAMOS": item = (DataRecord.HasColumn(row, "bitAsistenciaCompartamos") ? row["bitAsistenciaCompartamos"].ToString() : string.Empty); break;
                    case "METODOENVIO": item = (DataRecord.HasColumn(row, "chrShippingMethod") ? row["chrShippingMethod"].ToString() : string.Empty); break;
                    case "IPUSUARIO": item = (DataRecord.HasColumn(row, "IPUsuario") ? row["IPUsuario"].ToString() : string.Empty); break;
                    case "TIPOCUPON": item = (DataRecord.HasColumn(row, "TipoCupon") ? row["TipoCupon"].ToString() : string.Empty); break;
                    case "VALORCUPON": item = (DataRecord.HasColumn(row, "ValorCupon") ? row["ValorCupon"].ToString() : string.Empty); break;
                    case "PEDIDOSAPID": item = (DataRecord.HasColumn(row, "PedidoSapId") ? row["PedidoSapId"].ToString() : string.Empty); break;
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
            List<string> camposActDatosv2 = new List<string> { "TELEFONOTRABAJO", "LATITUD", "LONGITUD" };
            string[] parts = templateText.Split(';');
            var listTemplate = new List<TemplateField>();

            for (int index = 0; index < parts.Length; index++)
            {
                var templateField = new TemplateField(parts[index]);
                if (!descargaActDatosv2 && camposActDatosv2.Contains(templateField.FieldName)) continue;
                listTemplate.Add(templateField);
            }
            return listTemplate.ToArray();
        }

        public BEConfiguracionCampania GetEstadoPedido(int PaisID, int CampaniaID, long ConsultoraID, int ZonaID, int RegionID)
        {
            BEConfiguracionCampania configuracion = null;

            var daPedidoWeb = new DAPedidoWeb(PaisID);
            int estado = 201;
            bool modifica = false;
            bool validacionAbierta = false;

            var daConfiguracionCampania = new DAConfiguracionCampania(PaisID);
            using (IDataReader reader = daConfiguracionCampania.GetConfiguracionCampania(PaisID, ZonaID, RegionID, ConsultoraID))
                if (reader.Read())
                {
                    configuracion = new BEConfiguracionCampania(reader);
                }

            if (configuracion != null)
            {
                using (IDataReader reader = daPedidoWeb.GetEstadoPedido(configuracion.CampaniaID, ConsultoraID))
                {
                    if (reader.Read())
                    {
                        estado = Convert.ToInt32(reader["EstadoPedido"]);
                        modifica = Convert.ToBoolean(reader["ModificaPedidoReservado"]);
                        validacionAbierta = Convert.ToBoolean(reader["ValidacionAbierta"]);
                    }
                }
            }

            if (configuracion != null)
            {
                configuracion.EstadoPedido = estado;
                configuracion.ModificaPedidoReservado = modifica;
                configuracion.ValidacionAbierta = validacionAbierta;
            }

            return configuracion;
        }

        public List<BEPedidoWebService> GetPedidoCuvMarquesina(int paisID, int CampaniaID, long ConsultoraID, string CUV)
        {
            var listaPedidoPortal = new List<BEPedidoWebService>();
            var daPedidoWeb = new DAPedidoWeb(paisID);

            using (IDataReader reader = daPedidoWeb.GetPedidoCuvMarquesina(CampaniaID, ConsultoraID, CUV))
                while (reader.Read())
                {
                    var cuv = new BEPedidoWebService(reader);
                    listaPedidoPortal.Add(cuv);
                }
            return listaPedidoPortal;
        }


        public int ValidarCuvMarquesina(int paisID, string CampaniaID, int Cuv)
        {
            var resultado = 0;
            var daPedidoWeb = new DAPedidoWeb(paisID);
            using (IDataReader reader = daPedidoWeb.ValidarCuvMarquesina(CampaniaID, Cuv))
                while (reader.Read())
                {
                    resultado = Convert.ToInt32(reader[0]);
                }
            return resultado;
        }

        public IList<BECuvProgramaNueva> GetCuvProgramaNueva(int paisID)
        {
            var cuvProgramaNueva = new List<BECuvProgramaNueva>();
            var daPedidoWeb = new DAPedidoWeb(paisID);

            using (IDataReader reader = daPedidoWeb.GetCuvProgramaNueva())
                while (reader.Read())
                {
                    var entidad = new BECuvProgramaNueva(reader);
                    cuvProgramaNueva.Add(entidad);
                }

            return cuvProgramaNueva;
        }

        #region Consulta y Bloquedo de Pedido
        public IList<BEPedidoWeb> SelectPedidosWebByFilter(BEPedidoWeb BEPedidoWeb, string Fecha, int? RegionID, int? TerritorioID)
        {
            var pedidoWeb = new List<BEPedidoWeb>();
            var daPedidoWeb = new DAPedidoWeb(BEPedidoWeb.PaisID);

            using (IDataReader reader = daPedidoWeb.SelectPedidosWebByFilter(BEPedidoWeb, Fecha, RegionID, TerritorioID))
                while (reader.Read())
                {
                    var entidad = new BEPedidoWeb(reader);
                    pedidoWeb.Add(entidad);
                }

            return pedidoWeb;
        }

        public void UpdBloqueoPedido(BEPedidoWeb BEPedidoWeb)
        {
            var daPedidoWeb = new DAPedidoWeb(BEPedidoWeb.PaisID);
            daPedidoWeb.UpdBloqueoPedido(BEPedidoWeb);
        }

        public void InsertarLogPedidoWeb(int PaisID, int CampaniaID, string CodigoConsultora, int PedidoId, string Accion, string CodigoUsuario)
        {
            new DAPedidoWeb(PaisID).InsertarLogPedidoWeb(CampaniaID, CodigoConsultora, PedidoId, Accion, CodigoUsuario);
        }

        public void UpdDesbloqueoPedido(BEPedidoWeb BEPedidoWeb)
        {
            var daPedidoWeb = new DAPedidoWeb(BEPedidoWeb.PaisID);
            daPedidoWeb.UpdDesbloqueoPedido(BEPedidoWeb);
        }
        #endregion

        public IList<BEPedidoDDWeb> GetPedidosWebDDNoFacturados(BEPedidoDDWeb BEPedidoDDWeb)
        {
            List<BEPedidoDDWeb> lstPedidos;

            try
            {
                // DD : 1
                // Web: 2
                List<BEPedidoDDWeb> lstPedidosWeb = new List<BEPedidoDDWeb>();
                if (BEPedidoDDWeb.Origen != 1)
                {
                    try
                    {
                        var daPedidoWeb = new DAPedidoWeb(BEPedidoDDWeb.paisID);
                        using (IDataReader reader = daPedidoWeb.GetPedidosWebNoFacturados(BEPedidoDDWeb))
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

                List<BEPedidoDDWeb> lstPedidosDd = new List<BEPedidoDDWeb>();
                if (BEPedidoDDWeb.Origen != 2 && BEPedidoDDWeb.EstadoValidacion != 202)
                {
                    try
                    {
                        var daPedidoDd = new DAPedidoDD(BEPedidoDDWeb.paisID);
                        using (IDataReader reader = daPedidoDd.GetPedidosDDNoFacturados(BEPedidoDDWeb))
                            while (reader.Read())
                            {
                                var entidad = new BEPedidoDDWeb(reader);
                                lstPedidosDd.Add(entidad);
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
                    lstPedidos.AddRange(lstPedidosWeb);
                }
                if (lstPedidosDd.Count > 0)
                {
                    lstPedidosDd.Update(x => x.EstadoValidacion = 201);
                    lstPedidosDd.Update(x => x.EstadoValidacionNombre = "NO");
                    lstPedidos.AddRange(lstPedidosDd);
                }
            }
            catch (Exception) { throw; }

            return lstPedidos;
        }

        public IList<BEPedidoDDWebDetalle> GetPedidosWebDDNoFacturadosDetalle(int paisID, string paisISO, int CampaniaID, string Consultora, string Origen)
        {
            DAPedidoWebDetalle daPedidoWebDetalle = new DAPedidoWebDetalle(paisID);
            List<BEPedidoDDWebDetalle> lstPedidosDetalle;

            try
            {
                // DD : 1
                // Web: 2
                List<BEPedidoDDWebDetalle> lstPedidosWebDetalle = new List<BEPedidoDDWebDetalle>();
                if (Origen.Equals("Web"))
                {
                    try
                    {
                        using (IDataReader reader = daPedidoWebDetalle.GetPedidosWebNoFacturadosDetalle(paisISO, CampaniaID, Consultora))
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

                List<BEPedidoDDWebDetalle> lstPedidosDdDetalle = new List<BEPedidoDDWebDetalle>();
                if (Origen.Equals("DD"))
                {
                    try
                    {
                        var daPedidoDd = new DAPedidoDD(paisID);
                        using (IDataReader reader = daPedidoDd.GetPedidosDDNoFacturadosDetalle(paisISO, CampaniaID, Consultora))
                            while (reader.Read())
                            {
                                var entidad = new BEPedidoDDWebDetalle(reader);
                                lstPedidosDdDetalle.Add(entidad);
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
                    lstPedidosDetalle.AddRange(lstPedidosWebDetalle);
                }

                if (lstPedidosDdDetalle.Count > 0)
                {
                    lstPedidosDetalle.AddRange(lstPedidosDdDetalle);
                }
            }
            catch (Exception) { throw; }

            return lstPedidosDetalle;
        }

        public IList<BEPedidoDDWeb> GetPedidosWebDDDetalleConsultora(BEPedidoDDWeb BEPedidoDDWeb)
        {
            List<BEPedidoDDWeb> lstPedidos;

            try
            {
                // DD : 1
                // Web: 2
                List<BEPedidoDDWeb> lstPedidosWeb = new List<BEPedidoDDWeb>();
                if (BEPedidoDDWeb.Origen != 1)
                {
                    try
                    {
                        var daPedidoWeb = new DAPedidoWeb(BEPedidoDDWeb.paisID);
                        using (IDataReader reader = daPedidoWeb.GetPedidosWebDDDetalleConsultora(BEPedidoDDWeb))
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

                List<BEPedidoDDWeb> lstPedidosDd = new List<BEPedidoDDWeb>();
                if (BEPedidoDDWeb.Origen != 2)
                {
                    try
                    {
                        var daPedidoDd = new DAPedidoDD(BEPedidoDDWeb.paisID);
                        using (IDataReader reader = daPedidoDd.GetPedidosWebDDDetalleConsultora(BEPedidoDDWeb))
                            while (reader.Read())
                            {
                                var entidad = new BEPedidoDDWeb(reader);
                                lstPedidosDd.Add(entidad);
                            }
                    }
                    catch (SqlException ex)
                    {
                        throw new BizLogicException("No se pudo acceder al origen de datos de pedidos DD.", ex);
                    }
                }

                lstPedidos = new List<BEPedidoDDWeb>();
                if (lstPedidosWeb.Count > 0)
                    lstPedidos.AddRange(lstPedidosWeb);
                if (lstPedidosDd.Count > 0)
                    lstPedidos.AddRange(lstPedidosDd);
            }
            catch (Exception) { throw; }

            return lstPedidos;
        }

        public List<BEPedidoWebService> GetPedidosPortal(int paisID, int CampaniaID, string CodigoConsultora, string ZonaCodigo, int PedidoPROL)
        {
            var listaPedidoPortal = new List<BEPedidoWebService>();
            var daPedidoWeb = new DAPedidoWeb(paisID);

            using (IDataReader reader = daPedidoWeb.GetPedidosPortal(CampaniaID, CodigoConsultora, ZonaCodigo, PedidoPROL))
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
            var daPedidoWeb = new DAPedidoWeb(paisID);

            using (IDataReader reader = daPedidoWeb.GetPedidosPortalCaribeMX(CampaniaID, CodigoConsultora, ZonaCodigo, PedidoPROL))
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
            var daPedidoWeb = new DAPedidoWeb(paisID);

            using (IDataReader reader = daPedidoWeb.GetPedidosPortalCaribeMXFinal(CampaniaID, CodigoConsultora, ZonaCodigo, PedidoPROL, IndicadorPedido, SeccionCodigo, IdEstadoActividad, IndicadorSaldo, NombreConsultora))
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
            var daPedidoWeb = new DAPedidoWeb(paisID);

            using (IDataReader reader = daPedidoWeb.GetPedidosPortalExtendido(CampaniaID, CodigoConsultora, RegionCodigo, ZonaCodigo, PedidoPROL, IndicadorPedido, SeccionCodigo, IdEstadoActividad, IndicadorSaldo, NombreConsultora))
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
            var daPedidoWeb = new DAPedidoWeb(paisID);

            using (IDataReader reader = daPedidoWeb.GetPedidosPortalDetalle(CampaniaID, CodigoConsultora))
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
            var daPedidoWeb = new DAPedidoWeb(paisID);

            using (IDataReader reader = daPedidoWeb.GetPedidosPortalDetalleCaribeMXFinal(CampaniaID, CodigoConsultora))
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
            var daPedidoWeb = new DAPedidoWeb(paisID);

            using (IDataReader reader = daPedidoWeb.GetPedidosPortalDetalleExtendido(CampaniaID, CodigoConsultora))
                while (reader.Read())
                {
                    var entidad = new BEPedidoExtendidoWS(reader);
                    listaPedidoPortal.Add(entidad);
                }
            return listaPedidoPortal;
        }

        public void UpdBloquedoPedidowebService(int paisID, int CampaniaID, string CodigoConsultora, bool Bloqueado, string DescripcionBloqueo)
        {
            var daPedidoWeb = new DAPedidoWeb(paisID);
            try
            {
                daPedidoWeb.UpdBloquedoPedidowebService(CampaniaID, CodigoConsultora, Bloqueado, DescripcionBloqueo);
            }
            catch (Exception) { throw; }
        }

        public BEConsultoraWS GetConsultoraWebService(int paisID, string CodigoConsultora)
        {
            BEConsultoraWS entidad = null;
            var daPedidoWeb = new DAPedidoWeb(paisID);

            using (IDataReader reader = daPedidoWeb.GetConsultoraWebService(CodigoConsultora))
                if (reader.Read())
                {
                    entidad = new BEConsultoraWS(reader);
                }
            return entidad;
        }

        public List<BEPedidoWebService> GetPedidosPortalConsolidado(int paisID, string CodigoConsultora, int CampaniaID, DateTime FechaInicial, DateTime FechaFinal)
        {
            var listaPedidoPortal = new List<BEPedidoWebService>();
            var daPedidoWeb = new DAPedidoWeb(paisID);

            using (IDataReader reader = daPedidoWeb.GetPedidosPortalConsolidado(CodigoConsultora, CampaniaID, FechaInicial, FechaFinal))
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
            var daPedidoWeb = new DAPedidoWeb(paisID);

            using (IDataReader reader = daPedidoWeb.GetPedidosPortalConsolidadoDetalle(CodigoConsultora, CampaniaID, CodigosZonas))
                while (reader.Read())
                {
                    var entidad = new BEPedidoWebService(reader);
                    listaPedidoPortal.Add(entidad);
                }
            return listaPedidoPortal;
        }

        public int GetPedidoWebID(int paisID, int campaniaID, long consultoraID)
        {
            var daPedidoWeb = new DAPedidoWeb(paisID);
            int pedidoId = 0;
            using (IDataReader reader = daPedidoWeb.GetPedidoWebID(campaniaID, consultoraID))
                if (reader.Read())
                {
                    pedidoId = Convert.ToInt32(reader["PedidoID"]);
                }

            return pedidoId;
        }

        public long GetPedidoSapId(int paisID, int campaniaID, int pedidoID)
        {
            var daPedidoWeb = new DAPedidoWeb(paisID);
            using (IDataReader reader = daPedidoWeb.GetPedidoSapId(campaniaID, pedidoID))
            {
                if (reader.Read())
                {
                    return Convert.ToInt64(reader["PedidoSapId"]);
                }
            }
            return 0;
        }

        public void ClearPedidoSapId(int paisID, int campaniaID, int pedidoID)
        {
            var daPedidoWeb = new DAPedidoWeb(paisID);
            daPedidoWeb.ClearPedidoSapId(campaniaID, pedidoID);
        }

        public int GetFechaNoHabilFacturacion(int paisID, string CodigoZona, DateTime Fecha)
        {
            var daPedidoWeb = new DAPedidoWeb(paisID);
            return daPedidoWeb.GetFechaNoHabilFacturacion(CodigoZona, Fecha);
        }

        public BEHabPedidoCabWS GetHabilitarPedidosWebService(int paisID, string CodigoPais, int CampaniaID, string CodigoConsultora)
        {
            var daPedidoWeb = new DAPedidoWeb(paisID);
            BEHabPedidoCabWS obeHabPedidoCabWs = null;
            using (IDataReader reader = daPedidoWeb.GetHabilitarPedidosWebServiceCabecera(CodigoPais, CampaniaID, CodigoConsultora))
                if (reader.Read())
                {
                    obeHabPedidoCabWs = new BEHabPedidoCabWS(reader);
                }

            if (obeHabPedidoCabWs != null)
            {
                List<BEHabPedidoDetWS> olstHabPedidoDetWs = new List<BEHabPedidoDetWS>();
                using (IDataReader reader = daPedidoWeb.GetHabilitarPedidosWebServiceDetalle(CampaniaID, obeHabPedidoCabWs.PedidoId))
                    while (reader.Read())
                    {
                        olstHabPedidoDetWs.Add(new BEHabPedidoDetWS(reader));
                    }
                obeHabPedidoCabWs.DetallePedido = olstHabPedidoDetWs;
            }

            return obeHabPedidoCabWs;
        }

        public IList<BEPedidoDDWebDetalle> GetPedidoDDDetalle(int paisID, string paisISO, int pedidoID, int CampaniaID, string Consultora, string Origen, bool IndicadorActivo)
        {
            DAPedidoWebDetalle daPedidoWebDetalle = new DAPedidoWebDetalle(paisID);
            List<BEPedidoDDWebDetalle> lstPedidosDetalle;

            try
            {
                // DD : 1
                // Web: 2
                List<BEPedidoDDWebDetalle> lstPedidosWebDetalle = new List<BEPedidoDDWebDetalle>();
                if (Origen.Equals("Web"))
                {
                    try
                    {
                        using (IDataReader reader = daPedidoWebDetalle.GetPedidosWebNoFacturadosDetalle(paisISO, CampaniaID, Consultora))
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

                List<BEPedidoDDWebDetalle> lstPedidosDdDetalle = new List<BEPedidoDDWebDetalle>();
                if (Origen.Equals("DD"))
                {
                    try
                    {
                        var daPedidoDd = new DAPedidoDD(paisID);
                        using (IDataReader reader = daPedidoDd.GetPedidoDDDetalle(pedidoID, CampaniaID, IndicadorActivo))
                            while (reader.Read())
                            {
                                var entidad = new BEPedidoDDWebDetalle(reader);
                                lstPedidosDdDetalle.Add(entidad);
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
                    lstPedidosDetalle.AddRange(lstPedidosWebDetalle);
                }

                if (lstPedidosDdDetalle.Count > 0)
                {
                    lstPedidosDetalle.AddRange(lstPedidosDdDetalle);
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
            var daPedidoWeb = new DAPedidoWeb(paisID);

            using (IDataReader reader = daPedidoWeb.GetPedidoConsolidado(CampaniaID, CodigoConsultora, ZonaCodigo, PedidoPROL, Origen, IndicadorPedido, IdEstadoActividad, IndicadorSaldo, SeccionCodigo, NombreConsultora))
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
            var daPedidoWeb = new DAPedidoWeb(paisID);

            using (IDataReader reader = daPedidoWeb.GetPedidosDetalleConsolidado(CampaniaID, CodigoConsultora, origen))
                while (reader.Read())
                {
                    var entidad = new BEPedidoWebService(reader);
                    listaPedidoPortal.Add(entidad);
                }
            return listaPedidoPortal;
        }

        public int ValidarDesactivaRevistaGana(int paisID, int campaniaID, string codigoZona)
        {
            return new DAPedidoWeb(paisID).ValidarDesactivaRevistaGana(campaniaID, codigoZona);
        }

        public BECUVCredito ValidarCUVCreditoPorCUVRegular(int paisID, string codigoConsultora, string cuv, int campaniaID)
        {
            BECUVCredito beCuvCredito = new BECUVCredito();

            List<int> listaPais = ListaPaisValidoCUVCredito();

            if (listaPais.Contains(paisID))
            {
                BLConsultora blConsultora = new BLConsultora();

                var beConsultoraTop = blConsultora.GetConsultoraTop(paisID, codigoConsultora);
                var beConsultoraCuvRegular = blConsultora.GetConsultoraCUVRegular(paisID, campaniaID, cuv);
                var beConsultoraCuvCredito = blConsultora.GetConsultoraCUVCredito(paisID, campaniaID, cuv);

                if (beConsultoraTop.EsTop && !string.IsNullOrEmpty(beConsultoraCuvRegular.CUVCredito))
                {
                    beCuvCredito.CuvCredito = beConsultoraCuvRegular.CUVCredito;
                    beCuvCredito.IdMensaje = 1;
                }
                if (!beConsultoraTop.EsTop && !string.IsNullOrEmpty(beConsultoraCuvCredito.CUVRegular))
                {
                    beCuvCredito.CuvRegular = beConsultoraCuvCredito.CUVRegular;
                    beCuvCredito.IdMensaje = 2;
                }
            }

            return beCuvCredito;
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
            var daPedidoWeb = new DAPedidoWeb(bePedidoWeb.PaisID);
            daPedidoWeb.UpdateMontosPedidoWeb(bePedidoWeb);
        }

        public BEPedidoWeb GetPedidosWebByConsultoraCampania(int paisID, int consultoraID, int campaniaID)
        {
            var pedidoWeb = new BEPedidoWeb();
            var daPedidoWeb = new DAPedidoWeb(paisID);

            using (IDataReader reader = daPedidoWeb.GetPedidosWebByConsultoraCampania(consultoraID, campaniaID))
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
            var daPedidoWeb = new DAPedidoWeb(paisId);

            using (IDataReader reader = daPedidoWeb.GetPedidosFacturados(codigoConsultora))
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

            var blPais = new BLPais();

            var daPedidoWeb = new DAPedidoWeb(paisID);

            if (!blPais.EsPaisHana(paisID))
            {
                using (IDataReader reader = daPedidoWeb.GetPedidosIngresadoFacturado(consultoraID, campaniaID, top))
                    while (reader.Read())
                    {
                        var entidad = new BEPedidoWeb(reader);
                        listaPedidosFacturados.Add(entidad);
                    }
            }
            else
            {
                var dapHedidoWeb = new DAHPedido();

                var listaPedidosHana = dapHedidoWeb.GetPedidosIngresadoFacturado(paisID, codigoConsultora);
                var listaPedidoIngresado = new List<BEPedidoWeb>();
                using (IDataReader reader = daPedidoWeb.GetPedidosIngresado(consultoraID, campaniaID))
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

            var blPais = new BLPais();

            var daPedidoWeb = new DAPedidoWeb(paisID);
            var dapHedidoWeb = new DAHPedido();

            var listaPedidoIngresado = new List<BEPedidoWeb>();
            var listaPedido = new List<BEPedidoWeb>();

            if (!blPais.EsPaisHana(paisID))
            {
                using (IDataReader reader = daPedidoWeb.GetPedidosIngresadoFacturadoWebMobile(consultoraID, campaniaID, clienteID, top))
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
                var listaPedidoFacturado = dapHedidoWeb.GetPedidosIngresadoFacturado(paisID, codigoConsultora);

                using (IDataReader reader = daPedidoWeb.GetPedidosIngresado(consultoraID, campaniaID))
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
                                           }).Where(x => x.Cantidad > 1);

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

        public List<BEPedidoWeb> GetPedidosIngresadoFacturadoApp(int paisID, int consultoraID, int campaniaID, string codigoConsultora,  int usuarioPrueba, string  consultoraAsociada, int top )
        {
            List<BEPedidoWeb> listaPedidosFacturados = new List<BEPedidoWeb>();
            listaPedidosFacturados = GetPedidosIngresadoFacturado(paisID, consultoraID, campaniaID, codigoConsultora, top);
            

            if (listaPedidosFacturados.Count > 0)
            {
                listaPedidosFacturados.Update(x =>
                {
                    x.RutaPaqueteDocumentario = ObtenerRutaPaqueteDocumentario(usuarioPrueba == 1 ? consultoraAsociada : codigoConsultora, x.CampaniaID.ToString(), x.NumeroPedido.ToString(), Common.Util.GetPaisISO(paisID));
                    x.ImporteTotal = x.ImporteTotal - x.DescuentoProl;
                    x.ImporteCredito = x.ImporteTotal - x.Flete;
                });

            }

            return listaPedidosFacturados;
        }
        private string ObtenerRutaPaqueteDocumentario(string codigoConsultora, string campania, string numeroPedido, string paisIso) {
            string errorMessage = string.Empty;
            string url = string.Empty;
            try
            {
                var input = new
                {
                    Pais = paisIso,
                    Tipo = "1",
                    CodigoConsultora = codigoConsultora,
                    Campana = campania,
                    NumeroPedido = numeroPedido
                };

                var urlService = ConfigurationManager.AppSettings["WS_RV_PDF_NEW"];
                var wrapper = ConsumirServicio<DEWrapperPDF>(input, urlService);
                var result = (wrapper ?? new DEWrapperPDF()).GET_URLResult;

                if (result != null) {
                    if (result.errorCode != "00000" && result.errorMessage != "OK") errorMessage = result.errorMessage;
                    if (string.IsNullOrEmpty(errorMessage) && result.objeto != null) {
                        if(result.objeto.Count > 0) url = result.objeto[0].url;
                    }
                }

            }
            catch (Exception ex)
            {
                LogManager.SaveLog(ex, codigoConsultora, paisIso);
                throw new BizLogicException("No se pudo obtener la ruta de paquete documentario.", ex);
            }

            return url;
        }

        private T ConsumirServicio<T>(object input, string metodo)
        {
            JavaScriptSerializer serializer = new JavaScriptSerializer();

            WebRequest request = WebRequest.Create(metodo);
            request.Method = "POST";
            request.ContentType = "application/json; charset=utf-8";

            string inputJson = serializer.Serialize(input);
            using (StreamWriter writer = new StreamWriter(request.GetRequestStream()))
            {
                writer.Write(inputJson);
            }

            string outputJson;
            using (StreamReader reader = new StreamReader(request.GetResponse().GetResponseStream()))
            {
                outputJson = reader.ReadToEnd();
            }
            return serializer.Deserialize<T>(outputJson);
        }

        public void InsLogOfertaFinal(int PaisID, BEOfertaFinalConsultoraLog entidad)
        {
            new DAPedidoWeb(PaisID).InsLogOfertaFinal(entidad);
        }

        public void InsLogOfertaFinalBulk(int PaisID, List<BEOfertaFinalConsultoraLog> lista)
        {
            var daPedidoWeb = new DAPedidoWeb(PaisID);

            if (lista.Any())
            {
                foreach (var item in lista)
                {
                    if (item != null)
                        daPedidoWeb.InsLogOfertaFinal(item);
                }
            }
        }

        public void ActualizarIndicadorGPRPedidosRechazados(int PaisID, long ProcesoID)
        {
            DAPedidoWeb daPedidoWeb = new DAPedidoWeb(PaisID);
            daPedidoWeb.ActualizarIndicadorGPRPedidosRechazados(ProcesoID);
        }

        public void ActualizarIndicadorGPRPedidosFacturados(int PaisID, long ProcesoID)
        {
            DAPedidoWeb daPedidoWeb = new DAPedidoWeb(PaisID);
            daPedidoWeb.ActualizarIndicadorGPRPedidosFacturados(ProcesoID);
        }
        public List<BEPedidoWeb> GetPedidosFacturadoSegunDias(int paisID, int campaniaID, long consultoraID, int maxDias)
        {
            var listaPedidosFacturados = new List<BEPedidoWeb>();

            var daPedidoWeb = new DAPedidoWeb(paisID);
            using (IDataReader reader = daPedidoWeb.GetPedidosFacturadoSegunDias(campaniaID, consultoraID, maxDias))
                while (reader.Read())
                {
                    var entidad = new BEPedidoWeb(reader);
                    var listaDetalle = new List<BEPedidoWebDetalle>();

                    using (IDataReader readerDetalle = daPedidoWeb.GetPedidosFacturadoDetalle(entidad.PedidoID))
                    {
                        while (readerDetalle.Read())
                        {
                            var detalle = new BEPedidoWebDetalle(readerDetalle) { PedidoID = entidad.PedidoID };
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
            BEPedidoDescarga pedidoDescarga = new BEPedidoDescarga();
            DAPedidoWeb daPedidoWeb = new DAPedidoWeb(PaisID);

            using (IDataReader reader = daPedidoWeb.ObtenerUltimaDescargaPedido())
                while (reader.Read())
                {
                    pedidoDescarga = new BEPedidoDescarga(reader);
                }
            return pedidoDescarga;
        }

        public void DeshacerUltimaDescargaPedido(int PaisID)
        {
            DAPedidoWeb daPedidoWeb = new DAPedidoWeb(PaisID);
            daPedidoWeb.DesmarcarUltimaDescargaPedido();
        }
        public BEPedidoDescarga ObtenerUltimaDescargaExitosa(int PaisID)
        {
            BEPedidoDescarga pedidoDescarga = new BEPedidoDescarga();
            DAPedidoWeb daPedidoWeb = new DAPedidoWeb(PaisID);
            using (IDataReader reader = daPedidoWeb.ObtenerUltimaDescargaExitosa())
            {
                while (reader.Read())
                {
                    pedidoDescarga = new BEPedidoDescarga(reader);
                }
            }
            return pedidoDescarga;
        }

        public BEValidacionModificacionPedido ValidacionModificarPedido(int paisID, long consultoraID, int campania, bool usuarioPrueba, int aceptacionConsultoraDA, bool validarGPR = true, bool validarReservado = true, bool validarHorario = true, bool validarFacturado = true)
        {
            BEUsuario usuario = null;
            BEConfiguracionCampania configuracion = null;

            try
            {
                using (var reader = (new DAConfiguracionCampania(paisID)).GetConfiguracionByUsuarioAndCampania(paisID, consultoraID, campania, usuarioPrueba, aceptacionConsultoraDA))
                {
                    if (reader.Read()) usuario = new BEUsuario(reader, true, true);
                }

                if (usuario != null)
                {
                    using (var reader = new DAPedidoWeb(paisID).GetEstadoPedido(campania, usuarioPrueba ? usuario.ConsultoraAsociadaID : usuario.ConsultoraID))
                    {
                          configuracion =  reader.MapToObject<BEConfiguracionCampania>(true); 
                    }
                }
            
                if (configuracion != null)
                {
                    if (validarGPR && configuracion.IndicadorGPRSB == 1)
                    {
                        return new BEValidacionModificacionPedido
                        {
                            MotivoPedidoLock = Enumeradores.MotivoPedidoLock.GPR,
                            Mensaje = string.Format("En este momento nos encontramos facturando tu pedido de C-{0}, inténtalo más tarde", campania.Substring(4, 2))
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
                    if (validarReservado && configuracion.EstadoPedido == Constantes.EstadoPedido.Procesado && !configuracion.ModificaPedidoReservado && !configuracion.ValidacionAbierta)
                    {
                        return new BEValidacionModificacionPedido
                        {
                            MotivoPedidoLock = Enumeradores.MotivoPedidoLock.Reservado,
                            Mensaje = "Ya tienes un pedido reservado para esta campaña."
                        };
                    }
                }
                if (validarHorario)
                {
                    var mensajeHorarioRestringido = this.ValidarHorarioRestringido(usuario, campania);

                    if (!string.IsNullOrEmpty(mensajeHorarioRestringido))
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
            catch (Exception ex)
            {
                LogManager.SaveLog(ex, consultoraID, paisID);
                throw new BizLogicException("Error en BLPedidoWeb.ValidacionModificarPedido", ex);
            }
        }

        private string ValidarHorarioRestringido(BEUsuario usuario, int campania)
        {
            var fechaHoraActual = DateTime.Now.AddHours(usuario.ZonaHoraria);
            if (!usuario.HabilitarRestriccionHoraria) return null;
            if (fechaHoraActual <= usuario.FechaInicioFacturacion || usuario.FechaFinFacturacion.AddDays(1) <= fechaHoraActual) return null;

            var horaActual = new TimeSpan(fechaHoraActual.Hour, fechaHoraActual.Minute, 0);
            var horaAdicional = TimeSpan.Parse(usuario.HorasDuracionRestriccion.ToString() + ":00");

            var enHorarioRestringido = false;
            if (usuario.EsZonaDemAnti != 0) enHorarioRestringido = (horaActual > usuario.HoraCierreZonaDemAnti);
            else enHorarioRestringido = (usuario.HoraCierreZonaNormal < horaActual && horaActual < usuario.HoraCierreZonaNormal + horaAdicional);
            if (!enHorarioRestringido) return null;

            var horaCierre = usuario.EsZonaDemAnti != 0 ? usuario.HoraCierreZonaDemAnti : usuario.HoraCierreZonaNormal;
            return string.Format("En este momento nos encontramos facturando tu pedido de C-{0}. Todos los códigos ingresados hasta las {1} horas han sido registrados en el sistema. Gracias!", campania.Substring(4, 2), horaCierre.ToString(@"hh\:mm"));
        }

        public int InsIndicadorPedidoAutentico(int paisID, BEIndicadorPedidoAutentico entidad)
        {
            var daPedidoWeb = new DAPedidoWeb(paisID);
            entidad.IndicadorToken = AESAlgorithm.Decrypt(entidad.IndicadorToken);
            return daPedidoWeb.InsIndicadorPedidoAutentico(entidad);
        }

        public int UpdIndicadorPedidoAutentico(int paisID, BEIndicadorPedidoAutentico entidad)
        {
            var daPedidoWeb = new DAPedidoWeb(paisID);
            return daPedidoWeb.UpdIndicadorPedidoAutentico(entidad);
        }

        public void DelIndicadorPedidoAutentico(int paisID, BEIndicadorPedidoAutentico entidad)
        {
            var daPedidoWeb = new DAPedidoWeb(paisID);
            daPedidoWeb.UpdIndicadorPedidoAutentico(entidad);
        }

        public string GetTokenIndicadorPedidoAutentico(int paisID, string paisISO, string codigoRegion, string codigoZona)
        {
            var daPedidoWeb = new DAPedidoWeb(paisID);
            return daPedidoWeb.GetTokenIndicadorPedidoAutentico(paisISO, codigoRegion, codigoZona);
        }

        public BEConsultoraResumen GetResumen(int paisId, int codigoConsultora, int codigoCampania)
        {
            var resumen = new BEConsultoraResumen();
            var daConsultora = new DAPedidoWeb(paisId);
            using (IDataReader reader = daConsultora.GetResumenPorCampania(codigoConsultora, codigoCampania))
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

        #region MisPedidos
        public List<BEMisPedidosCampania> GetMisPedidosByCampania(int paisID, long ConsultoraID, int CampaniaID, int ClienteID, int Top)
        {
            List<BEMisPedidosCampania> pedidos;

            using (IDataReader reader = new DAPedidoWeb(paisID).GetMisPedidosByCampania(ConsultoraID, CampaniaID, ClienteID, Top))
            {
                pedidos = reader.MapToCollection<BEMisPedidosCampania>();
            }

            return pedidos;
        }
        public List<BEMisPedidosIngresados> GetMisPedidosIngresados(int paisID, long ConsultoraID, int CampaniaID, int ClienteID, string NombreConsultora)
        {
            List<BEMisPedidosIngresados> pedidos;
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
            List<BEMisPedidosFacturados> pedidos;
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
            var daPedidoWeb = new DAPedidoWeb(paisID);
            return daPedidoWeb.GetFlagProductosPrecargados(CodigoConsultora, CampaniaID);
        }

        public void UpdateMostradoProductosPrecargados(int paisID, int CampaniaID, long ConsultoraID, string IPUsuario)
        {
            var daPedidoWeb = new DAPedidoWeb(paisID);
            daPedidoWeb.UpdateMostradoProductosPrecargados(CampaniaID, ConsultoraID, IPUsuario);
        }
        #endregion

        #region Certificado Digital
        public bool TieneCampaniaConsecutivas(int paisId, int campaniaId, int cantidadCampaniaConsecutiva, long consultoraId)
        {
            var daPedidoWeb = new DAPedidoWeb(paisId);
            return daPedidoWeb.TieneCampaniaConsecutivas(campaniaId, cantidadCampaniaConsecutiva, consultoraId);
        }

        public BEMiCertificado ObtenerCertificadoDigital(int paisId, int campaniaId, long consultoraId, Int16 tipoCert)
        {
            BEMiCertificado entidad = null;
            DAPedidoWeb daPedidoWeb = new DAPedidoWeb(paisId);

            using (IDataReader reader = daPedidoWeb.ObtenerCertificadoDigital(campaniaId, consultoraId, tipoCert))
            {
                while (reader.Read())
                {
                    entidad = new BEMiCertificado(reader);
                }
            }
            return entidad;
        }

        #endregion

        public void DescargaPedidosCliente(int paisID, int nroLote, string codigoUsuario)
        {
            var lstPedidos = new List<BEDescargaPedidoCliente>();

            try
            {
                //Obtener la informacion de pedidos del ultimo lote generado
                using (var reader = new DAPedidoWeb(paisID).DescargaPedidosCliente(nroLote))
                {
                    lstPedidos = reader.MapToCollection<BEDescargaPedidoCliente>();
                };
                if (!lstPedidos.Any()) throw new BizLogicException("No existen pedidos para generar el archivo");

                //Configuracion nombre archivo
                var codigoPais = Common.Util.GetPaisISO(paisID);
                var fechaFacturacion = lstPedidos.FirstOrDefault().FechaFacturacion;
                var fileGuid = Guid.NewGuid();

                var ftpSection = (FtpConfigurationSection)ConfigurationManager.GetSection("Belcorp.FtpConfiguration");
                var key = string.Format("{0}-{1}", codigoPais, "DR");
                var ftpElement = ftpSection.FtpConfigurations[key];

                //Generar el archivo txt
                var section = (DataAccessConfiguration)ConfigurationManager.GetSection("Belcorp.Configuration");
                var element = section.Countries[paisID];
                var clienteTemplate = ParseTemplate(WebConfig.GetByTagName(element.OrderClienteTemplate));
                var clientFile = FormatFile(codigoPais, ftpElement.Client, fechaFacturacion, fileGuid);

                using (var streamWriter = new StreamWriter(clientFile))
                {
                    foreach (var pedido in lstPedidos)
                    {
                        streamWriter.WriteLine(ClienteLine(clienteTemplate, pedido));
                    }
                }

                //Envío FTP
                if (WebConfig.OrderDownloadFtpUpload == "1")
                {
                    try
                    {
                        var ftpAddressFileName = string.Concat(ftpElement.Address, ftpElement.Client);
                        BLFileManager.FtpUploadFile(ftpAddressFileName, clientFile, ftpElement.UserName, ftpElement.Password);
                    }
                    catch (Exception ex)
                    {
                        LogManager.SaveLog(ex, codigoUsuario, codigoPais);
                        throw new BizLogicException("No se pudo subir los archivos de pedidos al destino FTP.", ex);
                    }
                }

                //Envío S3
                if (WebConfig.OrderDownloadS3 == "1")
                {
                    try
                    {
                        var carpetaPais = string.Concat(WebConfig.S3_Pedidos, codigoPais);
                        if (!string.IsNullOrEmpty(clientFile)) ConfigS3.SetFileS3(clientFile, carpetaPais, Path.GetFileName(clientFile), false, false, true);
                    }
                    catch (Exception ex)
                    {
                        LogManager.SaveLog(ex, codigoUsuario, codigoPais);
                        throw new BizLogicException("No se pudo subir los archivos de pedidos al destino S3.", ex);
                    }
                }
            }
            catch(BizLogicException ex)
            {
                throw ex;
            }
            catch (Exception ex)
            {
                LogManager.SaveLog(ex, codigoUsuario, paisID);
                throw ex;
            }
        }

        private string ClienteLine(TemplateField[] template, BEDescargaPedidoCliente row)
        {
            var line = string.Empty;
            var item = string.Empty;

            foreach (var field in template)
            {
                switch (field.FieldName)
                {
                    case "PAISISO": item = row.PaisISO; break;
                    case "CAMPANIAID": item = row.CampaniaID.ToString(); break;
                    case "CODIGOCONSULTORA": item = row.CodigoConsultora; break;
                    case "FECHAFACTURACION": item = row.FechaFacturacion.ToString("ddMMyyyy"); break;
                    case "CUV": item = row.CUV; break;
                    case "CANTIDAD": item = row.Cantidad.ToString(); break;
                    case "CODIGOCLIENTE": item = row.CodigoCliente.ToString(); break;
                    default: item = string.Empty; break;
                }

                line = string.Concat(line, item.PadRight(field.Size));
            }

            return line;
        }
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