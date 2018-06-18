namespace Portal.Consultoras.BizLogic
{
    using Common;
    using Data;
    using Entities;
    using System;
    using System.Collections.Generic;
    using System.Configuration;
    using System.Data;
    using System.Data.SqlClient;
    using System.IO;
    using System.Text;
    using System.Transactions;

    public class BLSolicitudCredito
    {
        public IList<BESolicitudCredito> GetSolicitudCreditos(BESolicitudCredito objSolicitud)
        {
            var solicitudes = new List<BESolicitudCredito>();
            var daSolicitud = new DASolicitudCredito(objSolicitud.PaisID);

            using (IDataReader reader = daSolicitud.GetSolicitudCreditos(objSolicitud))
            {
                var columns = ((IDataRecord)reader).GetAllNames();

                while (reader.Read())
                {
                    var solicitud = new BESolicitudCredito(reader, columns);
                    solicitudes.Add(solicitud);
                }
            }
            return solicitudes;
        }

        public BESolicitudCredito ValidarSolicitudPendiente(int paisID, string numeroDocumento)
        {
            BESolicitudCredito beSolicitudCredito = new BESolicitudCredito();
            DASolicitudCredito daSolicitudCredito = new DASolicitudCredito(paisID);

            using (IDataReader reader = daSolicitudCredito.ValidarSolicitudPendiente(numeroDocumento))
            {
                var columns = ((IDataRecord)reader).GetAllNames();

                if (reader.Read())
                {
                    beSolicitudCredito = new BESolicitudCredito(reader, columns);
                }
            }

            return beSolicitudCredito;
        }

        public int InsertarSolicitudCredito(int paisID, BESolicitudCredito beSolicitudCredito)
        {
            int resultado;

            try
            {
                DASolicitudCredito daSolicitudCredito = new DASolicitudCredito(paisID);
                if (paisID == 9) // Mexico
                {
                    resultado = daSolicitudCredito.InsertarSolicitudCreditoMX(beSolicitudCredito);
                }
                else
                {
                    resultado = daSolicitudCredito.InsertarSolicitudCredito(beSolicitudCredito);
                }
            }
            catch (Exception ex)
            {
                throw new Exception(ex.Message, ex);
            }

            return resultado;
        }

        public IList<BECiudad> GetCiudades(int paisID, string codigoRegion)
        {
            var ciudades = new List<BECiudad>();
            DASolicitudCredito daSolicitudCredito = new DASolicitudCredito(paisID);

            using (IDataReader reader = daSolicitudCredito.GetCiudades(codigoRegion))
                while (reader.Read())
                {
                    var ciudad = new BECiudad(reader);
                    ciudades.Add(ciudad);
                }
            return ciudades;
        }

        public BESolicitudCredito ObtenerInfoActDatos(int paisID, string codigoConsultora)
        {
            BESolicitudCredito beSolicitudCredito = new BESolicitudCredito();
            DASolicitudCredito daSolicitudCredito = new DASolicitudCredito(paisID);

            using (IDataReader reader = daSolicitudCredito.ObtenerInfoActDatos(codigoConsultora))
            {
                var columns = ((IDataRecord)reader).GetAllNames();

                if (reader.Read())
                {
                    beSolicitudCredito = new BESolicitudCredito(reader, columns);
                }
            }

            return beSolicitudCredito;
        }

        public IList<BESolicitudCredito> BuscarSolicitudCredito(int paisID, string codigoZona, string codigoTerritorio, DateTime? fechaInicioSolicitud, DateTime? fechaFinSolicitud, string numeroDocumento, int estadoSolicitud, string TipoSolicitud, string CodigoConsultora)
        {
            var solicitudes = new List<BESolicitudCredito>();
            DASolicitudCredito daSolicitudCredito = new DASolicitudCredito(paisID);
            using (IDataReader reader = daSolicitudCredito.BuscarSolicitudCredito(paisID, codigoZona, codigoTerritorio, fechaInicioSolicitud, fechaFinSolicitud, numeroDocumento, estadoSolicitud, TipoSolicitud, CodigoConsultora))
            {
                var columns = ((IDataRecord)reader).GetAllNames();

                while (reader.Read())
                {
                    var solicitud = new BESolicitudCredito(reader, columns);
                    solicitudes.Add(solicitud);
                }
            }
            return solicitudes;
        }

        public BESolicitudCredito BuscarSolicitudCreditoPorID(int paisID, int solicitudCreditoID)
        {
            BESolicitudCredito beSolicitudCredito = new BESolicitudCredito();
            DASolicitudCredito daSolicitudCredito = new DASolicitudCredito(paisID);

            using (IDataReader reader = daSolicitudCredito.BuscarSolicitudCreditoPorID(solicitudCreditoID))
            {
                var columns = ((IDataRecord)reader).GetAllNames();

                if (reader.Read())
                {
                    beSolicitudCredito = new BESolicitudCredito(reader, columns);
                }
            }

            return beSolicitudCredito;
        }

        public string[] DescargaSolicitudes(int paisID, string codigoUsuario)
        {
            var numeroLote = 0;
            var numeroLoteConsuFlex = 0;

            var fechaProceso = DateTime.Now;
            var daSolicitud = new DASolicitudCredito(paisID);

            var blZonificacion = new BLZonificacion();
            var bePais = blZonificacion.SelectPais(paisID);
            var codigoPais = bePais.CodigoISO;
            var isFox = ConfigurationManager.AppSettings.Get("IsFOX").Contains(codigoPais);

            string pathFileSolCredito = string.Empty, pathFileSolCreditoS3 = string.Empty;
            string pathFileSolActualizacion = string.Empty, pathFileSolActualizacionS3 = string.Empty;
            string pathFileConsuFlexS3 = string.Empty;
            string fileSolCredito = string.Empty;
            string fileSolActualizacion = string.Empty;
            string fileConsuFlex = string.Empty;

            bool paisConSolicitudCredito = ConfigurationManager.AppSettings.Get("PaisesConSolicitudCredito").Contains(codigoPais);
            bool paisConFlexipago = ConfigurationManager.AppSettings.Get("PaisesConFlexipago").Contains(codigoPais);

            try
            {
                #region Solicitud Credito

                if (paisConSolicitudCredito)
                {
                    try
                    {
                        numeroLote = daSolicitud.InsSolicitudDescarga(codigoUsuario);
                    }
                    catch (SqlException ex)
                    {
                        if (ex.Number == 50000)
                            throw new BizLogicException("Existe una descarga de solicitudes en proceso actualmente.", ex);

                        throw new BizLogicException("Error durante la Inicio del proceso descarga Solicitudes.", ex);
                    }

                    var sectionConfiguration = (DataAccessConfiguration)ConfigurationManager.GetSection("Belcorp.Configuration");
                    var elementConfiguration = sectionConfiguration.Countries[paisID];

                    TemplateField[] solicitudTemplate = ParseTemplate(ConfigurationManager.AppSettings[elementConfiguration.SolCreditoTemplate]);
                    TemplateField[] actualizacionTemplate = ParseTemplate(ConfigurationManager.AppSettings[elementConfiguration.SolActualizacionTemplate]);

                    DataTable dtSolCredito;
                    DataTable dtSolActualziacion;
                    try
                    {
                        var ds = daSolicitud.GetSolucitudesNoEnviadas(numeroLote);

                        if (ds.Tables.Count == 2)
                        {
                            dtSolCredito = ds.Tables[0];
                            dtSolActualziacion = ds.Tables[1];
                        }
                        else
                        {
                            dtSolCredito = new DataTable();
                            dtSolActualziacion = new DataTable();
                        }
                    }
                    catch (SqlException ex)
                    {
                        throw new BizLogicException("No se pudo obtener el set de datos con las Solicitudes.", ex);
                    }

                    var keySolCredito = string.Format("{0}-SOLCRE", codigoPais);
                    var keySolActualizacion = string.Format("{0}-SOLACT", codigoPais);

                    var ftpSection = (FtpConfigurationSection)ConfigurationManager.GetSection("Belcorp.FtpConfiguration");

                    FtpConfigurationElement ftpElementSolCredito = ftpSection.FtpConfigurations[keySolCredito];
                    FtpConfigurationElement ftpElementSolActualizacion = ftpSection.FtpConfigurations[keySolActualizacion];

                    var fileGuid = Guid.NewGuid();
                    fileSolCredito = FormatFile(codigoPais, ftpElementSolCredito.Header, fechaProceso, fileGuid);
                    fileSolActualizacion = FormatFile(codigoPais, ftpElementSolActualizacion.Header, fechaProceso, fileGuid);

                    var path = ConfigurationManager.AppSettings.Get("OrderDownloadPath");
                    pathFileSolCreditoS3 = pathFileSolCredito = path + fileSolCredito;
                    pathFileSolActualizacionS3 = pathFileSolActualizacion = path + fileSolActualizacion;

                    try
                    {
                        using (var streamWriter = new StreamWriter(pathFileSolCredito, true, Encoding.GetEncoding(1252)))
                        {
                            if (dtSolCredito.Rows.Count > 0)
                            {
                                foreach (DataRow row in dtSolCredito.Rows)
                                {
                                    streamWriter.WriteLine(BuildLine(solicitudTemplate, row));
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
                        throw new BizLogicException("No se pudo generar el archivo para la descarga de Solicitudes de Crédito.", ex);
                    }

                    try
                    {
                        using (var streamWriter = new StreamWriter(pathFileSolActualizacion, true, Encoding.GetEncoding(1252)))
                        {
                            if (dtSolActualziacion.Rows.Count > 0)
                            {
                                foreach (DataRow row in dtSolActualziacion.Rows)
                                {
                                    streamWriter.WriteLine(BuildLine(actualizacionTemplate, row));
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
                        throw new BizLogicException("No se pudo generar el archivo para la descarga de Solicitudes de Actualización.", ex);
                    }

                    if (isFox)
                    {
                        var nombreServidor = ConfigurationManager.AppSettings["GetServerName"];
                        pathFileSolCredito = nombreServidor + Path.GetFileName(pathFileSolCredito);
                        pathFileSolActualizacion = nombreServidor + Path.GetFileName(pathFileSolActualizacion);
                    }
                    else
                    {
                        if (ConfigurationManager.AppSettings["OrderDownloadFtpUpload"] == "1")
                        {
                            try
                            {
                                BLFileManager.FtpUploadFile(ftpElementSolCredito.Address + ftpElementSolCredito.Header, pathFileSolCredito, ftpElementSolCredito.UserName, ftpElementSolCredito.Password);

                                BLFileManager.FtpUploadFile(ftpElementSolActualizacion.Address + ftpElementSolActualizacion.Header, pathFileSolActualizacion, ftpElementSolActualizacion.UserName, ftpElementSolActualizacion.Password);
                            }
                            catch (Exception ex)
                            {
                                throw new BizLogicException("No se pudo subir los archivos de solicitudes al destino FTP.", ex);
                            }
                        }
                        pathFileSolCredito = string.Empty;
                        pathFileSolActualizacion = string.Empty;
                    }
                }

                #endregion

                #region Flexipago

                if (paisConFlexipago)
                {
                    try
                    {
                        numeroLoteConsuFlex = daSolicitud.InsFlexipagoDescarga(codigoUsuario);
                    }
                    catch (SqlException ex)
                    {
                        if (ex.Number == 50000)
                            throw new BizLogicException("Existe una descarga de flexipago en proceso actualmente.", ex);

                        throw new BizLogicException("Error durante el Inicio del proceso descarga Flexipago.", ex);
                    }

                    var sectionConfiguration = (DataAccessConfiguration)ConfigurationManager.GetSection("Belcorp.Configuration");
                    var elementConfiguration = sectionConfiguration.Countries[paisID];

                    TemplateField[] consuFlexTemplate = ParseTemplate(ConfigurationManager.AppSettings[elementConfiguration.ConsuFlexTemplate]);
                    DataTable dtConsuFlex;

                    try
                    {
                        DataSet ds = daSolicitud.GetFlexipagoNoEnviadas(numeroLoteConsuFlex);

                        dtConsuFlex = ds.Tables.Count == 1 ? ds.Tables[0] : new DataTable();
                    }
                    catch (SqlException ex)
                    {
                        throw new BizLogicException("No se pudo obtener el set de datos con las Consultoras de Flexipago.", ex);
                    }

                    var keyConsuFlex = string.Format("{0}-CONSUFLEX", codigoPais);
                    var ftpSection = (FtpConfigurationSection)ConfigurationManager.GetSection("Belcorp.FtpConfiguration");

                    FtpConfigurationElement ftpElementConsuFlex = ftpSection.FtpConfigurations[keyConsuFlex];

                    var fileGuid = Guid.NewGuid();
                    fileConsuFlex = FormatFile(codigoPais, ftpElementConsuFlex.Header, fechaProceso, fileGuid);

                    var path = ConfigurationManager.AppSettings.Get("OrderDownloadPath");
                    string pathFileConsuFlex;
                    pathFileConsuFlexS3 = pathFileConsuFlex = path + fileConsuFlex;

                    try
                    {
                        using (var streamWriter = new StreamWriter(pathFileConsuFlex, true, Encoding.GetEncoding(1252)))
                        {
                            if (dtConsuFlex.Rows.Count > 0)
                            {
                                foreach (DataRow row in dtConsuFlex.Rows)
                                {
                                    streamWriter.WriteLine(BuildLine(consuFlexTemplate, row));
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
                        throw new BizLogicException("No se pudo generar el archivo para la descarga de Flexipago.", ex);
                    }

                    if (ConfigurationManager.AppSettings["OrderDownloadFtpUpload"] == "1")
                    {
                        try
                        {
                            BLFileManager.FtpUploadFile(ftpElementConsuFlex.Address + ftpElementConsuFlex.Header, pathFileConsuFlex, ftpElementConsuFlex.UserName, ftpElementConsuFlex.Password);
                        }
                        catch (Exception ex)
                        {
                            throw new BizLogicException("No se pudo subir los archivos de solicitudes al destino FTP.", ex);
                        }
                    }
                }

                #endregion

                TransactionOptions transactionOptions = new TransactionOptions
                {
                    IsolationLevel = System.Transactions.IsolationLevel.ReadUncommitted
                };
                using (TransactionScope transaction = new TransactionScope(TransactionScopeOption.Required, transactionOptions))
                {
                    if (paisConSolicitudCredito)
                    {
                        daSolicitud.UpdSolicitudNumeroLote(numeroLote);
                        daSolicitud.UpdSolicitudDescarga(numeroLote, 2, "Terminado Ok.", string.Empty, fileSolCredito, fileSolActualizacion, Environment.MachineName);
                    }
                    if (paisConFlexipago)
                    {
                        daSolicitud.UpdFlexipagoNumeroLote(numeroLoteConsuFlex);
                        daSolicitud.UpdFlexipagoDescarga(numeroLoteConsuFlex, 2, "Terminado Ok.", string.Empty, fileConsuFlex, Environment.MachineName);
                    }
                    transaction.Complete();
                }
            }
            catch (Exception ex)
            {
                if (paisConSolicitudCredito && numeroLote > 0)
                {
                    string error = ex is BizLogicException ? ex.Message : "Error desconocido.";
                    string errorExcepcion = ErrorUtilities.GetExceptionMessage(ex);
                    daSolicitud.UpdSolicitudDescarga(numeroLote, 99, error, errorExcepcion, string.Empty, string.Empty, string.Empty);
                    MailUtilities.EnviarMailProcesoDescargaExcepcion("Solicitud de Crédito", codigoPais, fechaProceso, "Único", error, errorExcepcion);
                }

                if (paisConFlexipago && numeroLoteConsuFlex > 0)
                {
                    string error = ex is BizLogicException ? ex.Message : "Error desconocido.";
                    string errorExcepcion = ErrorUtilities.GetExceptionMessage(ex);
                    daSolicitud.UpdFlexipagoDescarga(numeroLoteConsuFlex, 99, error, errorExcepcion, string.Empty, string.Empty);
                    MailUtilities.EnviarMailProcesoDescargaExcepcion("Flexipago", codigoPais, fechaProceso, "Único", error, errorExcepcion);
                }
                throw;
            }

            if (ConfigurationManager.AppSettings["OrderDownloadS3"] == "1")
            {
                string carpetaPais = ConfigurationManager.AppSettings["S3_SolicitudCredito"] + codigoPais;
                if (paisConSolicitudCredito)
                {
                    try
                    {
                        if (!string.IsNullOrEmpty(pathFileSolCreditoS3)) ConfigS3.SetFileS3(pathFileSolCreditoS3, carpetaPais, Path.GetFileName(pathFileSolCreditoS3), false, false, true);
                        if (!string.IsNullOrEmpty(pathFileSolActualizacionS3)) ConfigS3.SetFileS3(pathFileSolActualizacionS3, carpetaPais, Path.GetFileName(pathFileSolActualizacionS3), false, false, true);
                        daSolicitud.UpdSolicitudCreditoDescargaGuardoS3(numeroLote, true, null, null);
                    }
                    catch (Exception ex)
                    {
                        string error = "Terminado OK; pero con error al guardar backups en S3.";
                        string errorExcepcion = ErrorUtilities.GetExceptionMessage(ex);
                        try { daSolicitud.UpdSolicitudCreditoDescargaGuardoS3(numeroLote, false, error, errorExcepcion); }
                        catch (Exception ex2) { LogManager.SaveLog(ex2, codigoUsuario, codigoPais); }
                        MailUtilities.EnviarMailProcesoDescargaExcepcion("Solicitud de Crédito", codigoPais, fechaProceso, "Único", error, errorExcepcion);
                    }
                }

                if (paisConFlexipago)
                {
                    try
                    {
                        if (!string.IsNullOrEmpty(pathFileConsuFlexS3)) ConfigS3.SetFileS3(pathFileConsuFlexS3, carpetaPais, Path.GetFileName(pathFileConsuFlexS3), false, false, true);
                        daSolicitud.UpdFlexipagoInsDesDescargaGuardoS3(numeroLote, true, null, null);
                    }
                    catch (Exception ex)
                    {
                        string error = "Terminado OK; pero con error al guardar backups en S3.";
                        string errorExcepcion = ErrorUtilities.GetExceptionMessage(ex);
                        try { daSolicitud.UpdFlexipagoInsDesDescargaGuardoS3(numeroLote, false, error, errorExcepcion); }
                        catch (Exception ex2) { LogManager.SaveLog(ex2, codigoUsuario, codigoPais); }
                        MailUtilities.EnviarMailProcesoDescargaExcepcion("Flexipago", codigoPais, fechaProceso, "Único", error, errorExcepcion);
                    }
                }
            }

            string[] s;
            if (string.IsNullOrEmpty(pathFileSolCredito) && string.IsNullOrEmpty(pathFileSolActualizacion)) s = new string[] { };
            else s = new string[] { pathFileSolCredito, pathFileSolActualizacion };
            return s;
        }

        private static TemplateField[] ParseTemplate(string templateText)
        {
            var parts = templateText.Split(';');
            var template = new TemplateField[parts.Length];
            for (var index = 0; index < parts.Length; index++)
            {
                template[index] = new TemplateField(parts[index]);
            }
            return template;
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

        private static string BuildLine(IEnumerable<TemplateField> template, DataRow row)
        {
            var txtBuil = new StringBuilder();
            foreach (var field in template)
            {
                var item = string.Empty;

                if (row.Table.Columns.Contains(field.FieldName))
                {
                    if (row[field.FieldName] != DBNull.Value)
                    {
                        if (row[field.FieldName].ToString().Length > field.Size)
                        {
                            row[field.FieldName] = row[field.FieldName].ToString().Substring(0, field.Size);
                        }
                        item = row[field.FieldName].ToString();
                    }
                }

                txtBuil.Append(item.PadRight(field.Size));
            }
            return txtBuil.ToString();
        }

        public List<BETablaLogicaDatos> ListarColoniasByTerritorio(int paisID, string codigo)
        {
            var daSolicitud = new DASolicitudCredito(paisID);

            using (IDataReader reader = daSolicitud.ListarColoniasByTerritorio(codigo))
            {
                return reader.MapToCollection<BETablaLogicaDatos>();
            }
        }

        public string ValidarNumeroRFC(int paisID, string numeroRFC)
        {
            var daSolicitud = new DASolicitudCredito(paisID);
            return daSolicitud.ValidarNumeroRFC(numeroRFC);
        }

        public DateTime GetFechaHoraPais(int paisID)
        {
            DateTime fechaHoraPais;
            try
            {
                fechaHoraPais = new DASolicitudCredito(paisID).GetFechaHoraPais();
            }
            catch
            {
                fechaHoraPais = DateTime.Now;
            }
            return fechaHoraPais;
        }

        public DataTable ReporteSolidCreditDia(int paisID, string codigoRegion, DateTime? fechaInicioSolicitud, DateTime? fechaFinSolicitud)
        {
            DASolicitudCredito daSolicitudCredito = new DASolicitudCredito(paisID);
            DataTable dtRepRegion = new DataTable();
            DataSet dsRepRegion = daSolicitudCredito.ReporteSolidCreditDia(codigoRegion, fechaInicioSolicitud, fechaFinSolicitud);

            try
            {
                if (dsRepRegion.Tables.Count != 0) dtRepRegion = dsRepRegion.Tables[0];
            }
            catch (SqlException ex)
            {
                throw new BizLogicException("No se pudo obtener el set de datos con las Solicitudes.", ex);
            }

            return dtRepRegion;
        }
    }
}
