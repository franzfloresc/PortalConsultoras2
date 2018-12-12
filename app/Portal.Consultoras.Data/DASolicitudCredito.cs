namespace Portal.Consultoras.Data
{
    using Entities;
    using Portal.Consultoras.Common;
    using System;
    using System.Data;
    using System.Data.Common;

    public class DASolicitudCredito : DataAccess
    {
        public DASolicitudCredito(int paisID)
            : base(paisID, EDbSource.Digitacion)
        {
        }

        public IDataReader GetSolicitudCreditos(BESolicitudCredito objSolicitud)
        {
            DbCommand command = Context.Database.GetStoredProcCommand("dbo.GetSolicitudesCreditos");
            Context.Database.AddInParameter(command, "@vchCodigoZona", DbType.AnsiString, objSolicitud.CodigoZona);
            Context.Database.AddInParameter(command, "@vchCodigoTerritorio", DbType.AnsiString, objSolicitud.CodigoTerritorio);
            Context.Database.AddInParameter(command, "@vchNumeroDocumento", DbType.AnsiString, objSolicitud.NumeroDocumento);
            Context.Database.AddInParameter(command, "@datSysFechaCreacion", DbType.DateTime, objSolicitud.FechaCreacion);
            Context.Database.AddInParameter(command, "@intSEQProcesoOUT", DbType.Int32, objSolicitud.CodigoLote);

            if (objSolicitud.PaisID == Constantes.PaisID.PuertoRico || objSolicitud.PaisID == Constantes.PaisID.RepublicaDominicana)
            {
                Context.Database.AddInParameter(command, "@TipoSolicitud", DbType.String, objSolicitud.TipoSolicitud);
                Context.Database.AddInParameter(command, "@CodigoConsultora", DbType.String, objSolicitud.CodigoConsultora);
            }
            return Context.ExecuteReader(command);
        }

        public IDataReader GetDetalleSolicitud(int SolicitudID)
        {
            DbCommand command = Context.Database.GetStoredProcCommand("dbo.GetDetalleSolicitudCredito");
            Context.Database.AddInParameter(command, "@intSecuencialSolicitud", DbType.Int32, SolicitudID);

            return Context.ExecuteReader(command);
        }

        public IDataReader GetTipoSolicitud(string nroSecuencial)
        {
            DbCommand command = Context.Database.GetStoredProcCommand("dbo.GetTipoSolicitud");
            Context.Database.AddInParameter(command, "@intSecuenciaTabla", DbType.AnsiString, nroSecuencial);

            return Context.ExecuteReader(command);
        }

        public IDataReader GetTipoLocalidades()
        {
            DbCommand command = Context.Database.GetStoredProcCommand("dbo.ESE_SeleccionarPueblos");

            return Context.ExecuteReader(command);
        }

        public IDataReader GetTerritoriosByZonaDD(string CodigoZona)
        {
            DbCommand command = Context.Database.GetStoredProcCommand("dbo.GetTerritoriosByCodigoZona");
            Context.Database.AddInParameter(command, "@chrCodigoZona", DbType.AnsiString, CodigoZona);

            return Context.ExecuteReader(command);
        }

        public IDataReader ValidarSolicitudPendiente(string numeroDocumento)
        {
            DbCommand command = Context.Database.GetStoredProcCommand("dbo.ValidarSolicitudPendiente");
            Context.Database.AddInParameter(command, "@NumeroDocumento", DbType.String, numeroDocumento);

            return Context.ExecuteReader(command);
        }

        public int InsertarSolicitudCredito(BESolicitudCredito beSolicitudCredito)
        {
            DbCommand command = Context.Database.GetStoredProcCommand("dbo.InsertarSolicitudCredito");
            Context.Database.AddOutParameter(command, "@SolicitudCreditoID", DbType.Int32, beSolicitudCredito.SolicitudCreditoID);
            Context.Database.AddInParameter(command, "@PaisID", DbType.Byte, beSolicitudCredito.PaisID);
            Context.Database.AddInParameter(command, "@TipoSolicitud", DbType.String, beSolicitudCredito.TipoSolicitud ?? "");
            Context.Database.AddInParameter(command, "@FuenteIngreso", DbType.String, beSolicitudCredito.FuenteIngreso ?? "");
            Context.Database.AddInParameter(command, "@CodigoZona", DbType.String, beSolicitudCredito.CodigoZona ?? "");
            Context.Database.AddInParameter(command, "@CodigoTerritorio", DbType.String, beSolicitudCredito.CodigoTerritorio ?? "");
            Context.Database.AddInParameter(command, "@TipoContacto", DbType.Int32, beSolicitudCredito.TipoContacto);
            Context.Database.AddInParameter(command, "@CampaniaID", DbType.Int32, beSolicitudCredito.CampaniaID);
            Context.Database.AddInParameter(command, "@CodigoConsultoraRecomienda", DbType.String, beSolicitudCredito.CodigoConsultoraRecomienda ?? "");
            Context.Database.AddInParameter(command, "@NombreConsultoraRecomienda", DbType.String, beSolicitudCredito.NombreConsultoraRecomienda ?? "");
            Context.Database.AddInParameter(command, "@CodigoConsultora", DbType.String, beSolicitudCredito.CodigoConsultora ?? "");
            Context.Database.AddInParameter(command, "@CodigoPremio", DbType.String, beSolicitudCredito.CodigoPremio ?? "");
            Context.Database.AddInParameter(command, "@ApellidoPaterno", DbType.String, beSolicitudCredito.ApellidoPaterno ?? "");
            Context.Database.AddInParameter(command, "@ApellidoMaterno", DbType.String, beSolicitudCredito.ApellidoMaterno ?? "");
            Context.Database.AddInParameter(command, "@PrimerNombre", DbType.String, beSolicitudCredito.PrimerNombre ?? "");
            Context.Database.AddInParameter(command, "@SegundoNombre", DbType.String, beSolicitudCredito.SegundoNombre ?? "");
            Context.Database.AddInParameter(command, "@TipoDocumento", DbType.String, beSolicitudCredito.TipoDocumento ?? "");
            Context.Database.AddInParameter(command, "@NumeroDocumento", DbType.String, beSolicitudCredito.NumeroDocumento ?? "");
            Context.Database.AddInParameter(command, "@Sexo", DbType.String, beSolicitudCredito.Sexo ?? "");
            Context.Database.AddInParameter(command, "@FechaNacimiento", DbType.DateTime, beSolicitudCredito.FechaNacimiento);
            Context.Database.AddInParameter(command, "@EstadoCivil", DbType.String, beSolicitudCredito.EstadoCivil ?? "");
            Context.Database.AddInParameter(command, "@NivelEducativo", DbType.String, beSolicitudCredito.NivelEducativo ?? "");
            Context.Database.AddInParameter(command, "@CodigoOtrasMarcas", DbType.Int32, beSolicitudCredito.CodigoOtrasMarcas);
            Context.Database.AddInParameter(command, "@TipoNacionalidad", DbType.String, beSolicitudCredito.TipoNacionalidad ?? "");
            Context.Database.AddInParameter(command, "@Telefono", DbType.String, beSolicitudCredito.Telefono ?? "");
            Context.Database.AddInParameter(command, "@Celular", DbType.String, beSolicitudCredito.Celular ?? "");
            Context.Database.AddInParameter(command, "@CorreoElectronico", DbType.String, beSolicitudCredito.CorreoElectronico ?? "");
            Context.Database.AddInParameter(command, "@Direccion", DbType.String, beSolicitudCredito.Direccion ?? "");
            Context.Database.AddInParameter(command, "@Referencia", DbType.String, beSolicitudCredito.Referencia ?? "");
            Context.Database.AddInParameter(command, "@CodigoUbigeo", DbType.String, beSolicitudCredito.CodigoUbigeo ?? "");
            Context.Database.AddInParameter(command, "@Ciudad", DbType.String, beSolicitudCredito.Ciudad ?? "");
            Context.Database.AddInParameter(command, "@TipoVia", DbType.String, beSolicitudCredito.TipoVia ?? "");
            Context.Database.AddInParameter(command, "@PoblacionVilla", DbType.String, beSolicitudCredito.PoblacionVilla ?? "");
            Context.Database.AddInParameter(command, "@CodigoPostal", DbType.String, beSolicitudCredito.CodigoPostal ?? "");
            Context.Database.AddInParameter(command, "@DireccionEntrega", DbType.String, beSolicitudCredito.DireccionEntrega ?? "");
            Context.Database.AddInParameter(command, "@ReferenciaEntrega", DbType.String, beSolicitudCredito.ReferenciaEntrega ?? "");
            Context.Database.AddInParameter(command, "@TelefonoEntrega", DbType.String, beSolicitudCredito.TelefonoEntrega ?? "");
            Context.Database.AddInParameter(command, "@CelularEntrega", DbType.String, beSolicitudCredito.CelularEntrega ?? "");
            Context.Database.AddInParameter(command, "@ObservacionEntrega", DbType.String, beSolicitudCredito.ObservacionEntrega ?? "");
            Context.Database.AddInParameter(command, "@ApellidoFamiliar", DbType.String, beSolicitudCredito.ApellidoFamiliar ?? "");
            Context.Database.AddInParameter(command, "@NombreFamiliar", DbType.String, beSolicitudCredito.NombreFamiliar ?? "");
            Context.Database.AddInParameter(command, "@DireccionFamiliar", DbType.String, beSolicitudCredito.DireccionFamiliar ?? "");
            Context.Database.AddInParameter(command, "@TelefonoFamiliar", DbType.String, beSolicitudCredito.TelefonoFamiliar ?? "");
            Context.Database.AddInParameter(command, "@CelularFamiliar", DbType.String, beSolicitudCredito.CelularFamiliar ?? "");
            Context.Database.AddInParameter(command, "@TipoVinculoFamiliar", DbType.Int32, beSolicitudCredito.TipoVinculoFamiliar);
            Context.Database.AddInParameter(command, "@ApellidoNoFamiliar", DbType.String, beSolicitudCredito.ApellidoNoFamiliar ?? "");
            Context.Database.AddInParameter(command, "@NombreNoFamiliar", DbType.String, beSolicitudCredito.NombreNoFamiliar ?? "");
            Context.Database.AddInParameter(command, "@DireccionNoFamiliar", DbType.String, beSolicitudCredito.DireccionNoFamiliar ?? "");
            Context.Database.AddInParameter(command, "@TelefonoNoFamiliar", DbType.String, beSolicitudCredito.TelefonoNoFamiliar ?? "");
            Context.Database.AddInParameter(command, "@CelularNoFamiliar", DbType.String, beSolicitudCredito.CelularNoFamiliar ?? "");
            Context.Database.AddInParameter(command, "@TipoVinculoNoFamiliar", DbType.Int32, beSolicitudCredito.TipoVinculoNoFamiliar);
            Context.Database.AddInParameter(command, "@ApellidoPaternoAval", DbType.String, beSolicitudCredito.ApellidoPaternoAval ?? "");
            Context.Database.AddInParameter(command, "@ApellidoMaternoAval", DbType.String, beSolicitudCredito.ApellidoMaternoAval ?? "");
            Context.Database.AddInParameter(command, "@PrimerNombreAval", DbType.String, beSolicitudCredito.PrimerNombreAval ?? "");
            Context.Database.AddInParameter(command, "@SegundoNombreAval", DbType.String, beSolicitudCredito.SegundoNombreAval ?? "");
            Context.Database.AddInParameter(command, "@DireccionAval", DbType.String, beSolicitudCredito.DireccionAval ?? "");
            Context.Database.AddInParameter(command, "@TelefonoAval", DbType.String, beSolicitudCredito.TelefonoAval ?? "");
            Context.Database.AddInParameter(command, "@CelularAval", DbType.String, beSolicitudCredito.CelularAval ?? "");
            Context.Database.AddInParameter(command, "@TipoDocumentoAval", DbType.String, beSolicitudCredito.TipoDocumentoAval ?? "");
            Context.Database.AddInParameter(command, "@NumeroDocumentoAval", DbType.String, beSolicitudCredito.NumeroDocumentoAval ?? "");
            Context.Database.AddInParameter(command, "@TipoVinculoAval", DbType.Int32, beSolicitudCredito.TipoVinculoAval);
            Context.Database.AddInParameter(command, "@MontoMeta", DbType.Decimal, beSolicitudCredito.MontoMeta);
            Context.Database.AddInParameter(command, "@TipoMeta", DbType.String, beSolicitudCredito.TipoMeta ?? "");
            Context.Database.AddInParameter(command, "@DescripcionMeta", DbType.String, beSolicitudCredito.DescripcionMeta ?? "");
            Context.Database.AddInParameter(command, "@UsuarioCreacion", DbType.String, beSolicitudCredito.UsuarioCreacion ?? "");

            Context.ExecuteNonQuery(command);
            return Convert.ToInt32(command.Parameters["@SolicitudCreditoID"].Value);
        }

        public IDataReader GetCiudades(string codigoRegion)
        {
            DbCommand command = Context.Database.GetStoredProcCommand("dbo.GetCiudad");
            Context.Database.AddInParameter(command, "@CodigoRegion", DbType.String, codigoRegion);

            return Context.ExecuteReader(command);
        }

        public IDataReader ObtenerInfoActDatos(string codigoConsultora)
        {
            DbCommand command = Context.Database.GetStoredProcCommand("dbo.ObtenerInfoActDatos");
            Context.Database.AddInParameter(command, "@CodigoConsultora", DbType.String, codigoConsultora);

            return Context.ExecuteReader(command);
        }

        public IDataReader BuscarSolicitudCredito(int paisID, string codigoZona, string codigoTerritorio, DateTime? fechaInicioSolicitud, DateTime? fechaFinSolicitud, string numeroDocumento, int estadoSolicitud, string TipoSolicitud, string CodigoConsultora)
        {
            DbCommand command = Context.Database.GetStoredProcCommand("dbo.BuscarSolicitudCredito");

            if (string.IsNullOrEmpty(codigoZona))
                Context.Database.AddInParameter(command, "@CodigoZona", DbType.String, DBNull.Value);
            else
                Context.Database.AddInParameter(command, "@CodigoZona", DbType.String, codigoZona);
            if (string.IsNullOrEmpty(codigoTerritorio))
                Context.Database.AddInParameter(command, "@CodigoTerritorio", DbType.String, DBNull.Value);
            else
                Context.Database.AddInParameter(command, "@CodigoTerritorio", DbType.String, codigoTerritorio);

            if (fechaInicioSolicitud == null)
                Context.Database.AddInParameter(command, "@FechaInicio", DbType.DateTime, DBNull.Value);
            else
                Context.Database.AddInParameter(command, "@FechaInicio", DbType.DateTime, fechaInicioSolicitud);

            if (fechaFinSolicitud == null)
                Context.Database.AddInParameter(command, "@FechaFin", DbType.DateTime, DBNull.Value);
            else
                Context.Database.AddInParameter(command, "@FechaFin", DbType.DateTime, fechaFinSolicitud);

            if (string.IsNullOrEmpty(numeroDocumento))
                Context.Database.AddInParameter(command, "@NumeroDocumento", DbType.String, DBNull.Value);
            else
                Context.Database.AddInParameter(command, "@NumeroDocumento", DbType.String, numeroDocumento);

            if (estadoSolicitud == -1)
                Context.Database.AddInParameter(command, "@CodigoLote", DbType.Int32, DBNull.Value);
            else
                Context.Database.AddInParameter(command, "@CodigoLote", DbType.Int32, estadoSolicitud);

            if (paisID == Constantes.PaisID.PuertoRico || paisID == Constantes.PaisID.RepublicaDominicana)
            {
                if (string.IsNullOrEmpty(TipoSolicitud))
                    Context.Database.AddInParameter(command, "@TipoSolicitud", DbType.String, DBNull.Value);
                else
                    Context.Database.AddInParameter(command, "@TipoSolicitud", DbType.String, TipoSolicitud);

                if (string.IsNullOrEmpty(CodigoConsultora))
                    Context.Database.AddInParameter(command, "@CodigoConsultora", DbType.String, DBNull.Value);
                else
                    Context.Database.AddInParameter(command, "@CodigoConsultora", DbType.String, CodigoConsultora);
            }

            return Context.ExecuteReader(command);
        }

        public IDataReader BuscarSolicitudCreditoPorID(int solicitudCreditoID)
        {
            DbCommand command = Context.Database.GetStoredProcCommand("dbo.BuscarSolicitudCreditoPorID");
            Context.Database.AddInParameter(command, "@SolicitudCreditoID", DbType.Int32, solicitudCreditoID);

            return Context.ExecuteReader(command);
        }

        public DataSet GetSolucitudesNoEnviadas(int numeroLote)
        {
            DbCommand command = Context.Database.GetStoredProcCommand("dbo.ProcesoCargaSolicitudes");
            command.CommandTimeout = 0;

            Context.Database.AddInParameter(command, "@NumeroLote", DbType.Int32, numeroLote);

            return Context.ExecuteDataSet(command);
        }

        public int InsSolicitudDescarga(string codigoUsuario)
        {
            DbCommand command = Context.Database.GetStoredProcCommand("dbo.InsSolicitudCreditoDescarga");
            Context.Database.AddOutParameter(command, "@NumeroLote", DbType.Int32, 4);
            Context.Database.AddInParameter(command, "@CodigoUsuario", DbType.String, codigoUsuario);

            Context.ExecuteNonQuery(command);

            var numeroLote = Convert.ToInt32(command.Parameters["@NumeroLote"].Value);

            return numeroLote;
        }

        public void UpdSolicitudDescarga(int numeroLote, int estado, string mensaje, string mensajeExcepcion, string nombreArchivoIns, string nombreArchivoUpd, string nombreServidor)
        {
            DbCommand command = Context.Database.GetStoredProcCommand("dbo.UpdSolicitudCreditoDescarga");
            Context.Database.AddInParameter(command, "@NumeroLote", DbType.Int32, numeroLote);
            Context.Database.AddInParameter(command, "@Estado", DbType.Int32, estado);
            Context.Database.AddInParameter(command, "@Mensaje", DbType.String, mensaje);
            Context.Database.AddInParameter(command, "@MensajeExcepcion", DbType.String, mensajeExcepcion);
            Context.Database.AddInParameter(command, "@NombreArchivoIns", DbType.String, nombreArchivoIns);
            Context.Database.AddInParameter(command, "@NombreArchivoUpd", DbType.String, nombreArchivoUpd);
            Context.Database.AddInParameter(command, "@NombreServer", DbType.String, nombreServidor);

            Context.ExecuteNonQuery(command);
        }

        public int UpdSolicitudCreditoDescargaGuardoS3(int numeroLote, bool guardoS3, string mensaje, string mensajeExcepcion)
        {
            DbCommand command = Context.Database.GetStoredProcCommand("dbo.UpdSolicitudCreditoDescargaGuardoS3");
            Context.Database.AddInParameter(command, "@NumeroLote", DbType.Int32, numeroLote);
            Context.Database.AddInParameter(command, "@GuardoS3", DbType.Boolean, guardoS3);
            Context.Database.AddInParameter(command, "@Mensaje", DbType.String, mensaje);
            Context.Database.AddInParameter(command, "@MensajeExcepcion", DbType.String, mensajeExcepcion);

            return Context.ExecuteNonQuery(command);
        }

        public void UpdSolicitudNumeroLote(int numeroLote)
        {
            DbCommand command = Context.Database.GetStoredProcCommand("dbo.UpdSolicitudCreditoNumeroLote");
            command.CommandTimeout = 0;

            Context.Database.AddInParameter(command, "@NumeroLote", DbType.Int32, numeroLote);

            Context.ExecuteNonQuery(command);
        }

        public int InsFlexipagoDescarga(string codigoUsuario)
        {
            DbCommand command = Context.Database.GetStoredProcCommand("dbo.InsFlexipagoDescarga");
            Context.Database.AddOutParameter(command, "@NumeroLote", DbType.Int32, 4);
            Context.Database.AddInParameter(command, "@CodigoUsuario", DbType.String, codigoUsuario);

            Context.ExecuteNonQuery(command);

            var numeroLote = Convert.ToInt32(command.Parameters["@NumeroLote"].Value);

            return numeroLote;
        }

        public DataSet GetFlexipagoNoEnviadas(int numeroLoteConsuFlex)
        {
            DbCommand command = Context.Database.GetStoredProcCommand("dbo.ProcesoCargaFlexipago");
            command.CommandTimeout = 0;

            Context.Database.AddInParameter(command, "@NumeroLote", DbType.Int32, numeroLoteConsuFlex);

            return Context.ExecuteDataSet(command);
        }

        public void UpdFlexipagoNumeroLote(int numeroLoteConsuFlex)
        {
            DbCommand command = Context.Database.GetStoredProcCommand("dbo.UpdFlexipagoNumeroLote");
            command.CommandTimeout = 0;

            Context.Database.AddInParameter(command, "@NumeroLote", DbType.Int32, numeroLoteConsuFlex);

            Context.ExecuteNonQuery(command);
        }

        public void UpdFlexipagoDescarga(int numeroLoteConsuFlex, int estado, string mensaje, string mensajeExcepcion, string nombreArchivoConsuFlex, string nombreServidor)
        {
            DbCommand command = Context.Database.GetStoredProcCommand("dbo.UpdFlexipagoDescarga");
            Context.Database.AddInParameter(command, "@NumeroLote", DbType.Int32, numeroLoteConsuFlex);
            Context.Database.AddInParameter(command, "@Estado", DbType.Int32, estado);
            Context.Database.AddInParameter(command, "@Mensaje", DbType.String, mensaje);
            Context.Database.AddInParameter(command, "@MensajeExcepcion", DbType.String, mensajeExcepcion);
            Context.Database.AddInParameter(command, "@NombreArchivoConsuFlex", DbType.String, nombreArchivoConsuFlex);
            Context.Database.AddInParameter(command, "@NombreServer", DbType.String, nombreServidor);

            Context.ExecuteNonQuery(command);
        }

        public int UpdFlexipagoInsDesDescargaGuardoS3(int numeroLote, bool guardoS3, string mensaje, string mensajeExcepcion)
        {
            DbCommand command = Context.Database.GetStoredProcCommand("dbo.UpdFlexipagoInsDesDescargaGuardoS3");
            Context.Database.AddInParameter(command, "@NumeroLote", DbType.Int32, numeroLote);
            Context.Database.AddInParameter(command, "@GuardoS3", DbType.Boolean, guardoS3);
            Context.Database.AddInParameter(command, "@Mensaje", DbType.String, mensaje);
            Context.Database.AddInParameter(command, "@MensajeExcepcion", DbType.String, mensajeExcepcion);

            return Context.ExecuteNonQuery(command);
        }

        public IDataReader ListarColoniasByTerritorio(string codigo)
        {
            DbCommand command = Context.Database.GetStoredProcCommand("dbo.ListarColoniasByTerritorio");
            Context.Database.AddInParameter(command, "@CodigoTerritorio", DbType.AnsiString, codigo);

            return Context.ExecuteReader(command);
        }
        public int InsertarSolicitudCreditoMX(BESolicitudCredito beSolicitudCredito)
        {
            DbCommand command = Context.Database.GetStoredProcCommand("dbo.InsertarSolicitudCredito");

            // Datos generales
            Context.Database.AddOutParameter(command, "@SolicitudCreditoID", DbType.Int32, beSolicitudCredito.SolicitudCreditoID);
            Context.Database.AddInParameter(command, "@PaisID", DbType.Byte, beSolicitudCredito.PaisID);
            Context.Database.AddInParameter(command, "@TipoSolicitud", DbType.String, beSolicitudCredito.TipoSolicitud ?? "");
            Context.Database.AddInParameter(command, "@FuenteIngreso", DbType.String, beSolicitudCredito.FuenteIngreso ?? "");
            Context.Database.AddInParameter(command, "@CampaniaID", DbType.Int32, beSolicitudCredito.CampaniaID);
            Context.Database.AddInParameter(command, "@CodigoConsultora", DbType.String, beSolicitudCredito.CodigoConsultora ?? "");

            // Datos de la inscripción
            Context.Database.AddInParameter(command, "@CodigoZona", DbType.String, beSolicitudCredito.CodigoZona ?? "");
            Context.Database.AddInParameter(command, "@CodigoTerritorio", DbType.String, beSolicitudCredito.CodigoTerritorio ?? "");
            Context.Database.AddInParameter(command, "@TipoContacto", DbType.Int32, beSolicitudCredito.TipoContacto);
            Context.Database.AddInParameter(command, "@CodigoConsultoraRecomienda", DbType.String, beSolicitudCredito.CodigoConsultoraRecomienda ?? "");
            Context.Database.AddInParameter(command, "@NombreConsultoraRecomienda", DbType.String, beSolicitudCredito.NombreConsultoraRecomienda ?? "");

            // Datos Personales de la solicitante
            Context.Database.AddInParameter(command, "@ApellidoPaterno", DbType.String, beSolicitudCredito.ApellidoPaterno ?? "");
            Context.Database.AddInParameter(command, "@ApellidoMaterno", DbType.String, beSolicitudCredito.ApellidoMaterno ?? "");
            Context.Database.AddInParameter(command, "@Nombres", DbType.String, beSolicitudCredito.PrimerNombre ?? "");
            Context.Database.AddInParameter(command, "@FechaNacimiento", DbType.DateTime, beSolicitudCredito.FechaNacimiento);
            Context.Database.AddInParameter(command, "@NumeroRFC", DbType.String, beSolicitudCredito.NumeroRFC ?? "");
            Context.Database.AddInParameter(command, "@EstadoCivil", DbType.String, beSolicitudCredito.EstadoCivil ?? "");
            Context.Database.AddInParameter(command, "@NivelEducativo", DbType.String, beSolicitudCredito.NivelEducativo ?? "");
            Context.Database.AddInParameter(command, "@CodigoOtrasMarcas", DbType.Int32, beSolicitudCredito.CodigoOtrasMarcas);

            // Datos del contacto
            Context.Database.AddInParameter(command, "@Telefono", DbType.String, beSolicitudCredito.Telefono ?? "");
            Context.Database.AddInParameter(command, "@Celular", DbType.String, beSolicitudCredito.Celular ?? "");
            Context.Database.AddInParameter(command, "@CorreoElectronico", DbType.String, beSolicitudCredito.CorreoElectronico ?? "");

            // Dirección de la Solicitante
            Context.Database.AddInParameter(command, "@Direccion", DbType.String, beSolicitudCredito.Direccion ?? "");
            Context.Database.AddInParameter(command, "@Referencia", DbType.String, beSolicitudCredito.Referencia ?? "");
            Context.Database.AddInParameter(command, "@Estado", DbType.String, beSolicitudCredito.Ciudad ?? "");
            Context.Database.AddInParameter(command, "@Municipio", DbType.String, beSolicitudCredito.TipoVia ?? "");
            Context.Database.AddInParameter(command, "@Localidad", DbType.String, beSolicitudCredito.PoblacionVilla ?? "");
            Context.Database.AddInParameter(command, "@Colonia", DbType.String, beSolicitudCredito.Colonia ?? "");
            Context.Database.AddInParameter(command, "@CodigoPostal", DbType.String, beSolicitudCredito.CodigoPostal ?? "");
            Context.Database.AddInParameter(command, "@CodigoUbigeo", DbType.String, beSolicitudCredito.CodigoUbigeo ?? "");

            // Referencia Familiar
            Context.Database.AddInParameter(command, "@NombreFamiliar", DbType.String, beSolicitudCredito.NombreFamiliar ?? "");
            Context.Database.AddInParameter(command, "@DireccionFamiliar", DbType.String, beSolicitudCredito.DireccionFamiliar ?? "");
            Context.Database.AddInParameter(command, "@TelefonoFamiliar", DbType.String, beSolicitudCredito.TelefonoFamiliar ?? "");
            Context.Database.AddInParameter(command, "@CelularFamiliar", DbType.String, beSolicitudCredito.CelularFamiliar ?? "");
            Context.Database.AddInParameter(command, "@TipoVinculoFamiliar", DbType.Int32, beSolicitudCredito.TipoVinculoFamiliar);

            // Referencia No Familiar
            Context.Database.AddInParameter(command, "@NombreNoFamiliar", DbType.String, beSolicitudCredito.NombreNoFamiliar ?? "");
            Context.Database.AddInParameter(command, "@DireccionNoFamiliar", DbType.String, beSolicitudCredito.DireccionNoFamiliar ?? "");
            Context.Database.AddInParameter(command, "@TelefonoNoFamiliar", DbType.String, beSolicitudCredito.TelefonoNoFamiliar ?? "");
            Context.Database.AddInParameter(command, "@CelularNoFamiliar", DbType.String, beSolicitudCredito.CelularNoFamiliar ?? "");
            Context.Database.AddInParameter(command, "@TipoVinculoNoFamiliar", DbType.Int32, beSolicitudCredito.TipoVinculoNoFamiliar);

            // Datos de sistema
            Context.Database.AddInParameter(command, "@UsuarioCreacion", DbType.String, beSolicitudCredito.UsuarioCreacion ?? "");

            Context.ExecuteNonQuery(command);
            return Convert.ToInt32(command.Parameters["@SolicitudCreditoID"].Value);
        }
        public string ValidarNumeroRFC(string numeroRFC)
        {
            DbCommand command = Context.Database.GetStoredProcCommand("dbo.ValidarNumeroRFC");
            command.CommandTimeout = 0;

            Context.Database.AddInParameter(command, "@NumeroRFC", DbType.AnsiString, numeroRFC);

            return Context.ExecuteScalar(command).ToString();
        }

        public DateTime GetFechaHoraPais()
        {
            DbCommand command = Context.Database.GetStoredProcCommand("dbo.GetFechaHoraPais");
            DateTime result = Convert.ToDateTime(Context.ExecuteScalar(command));
            return result;
        }

        public DataSet ReporteSolidCreditDia(string codigoRegion, DateTime? fechaInicioSolicitud, DateTime? fechaFinSolicitud)
        {
            DbCommand command = Context.Database.GetStoredProcCommand("dbo.RepSolidCreditoDetalleDia");

            if (string.IsNullOrEmpty(codigoRegion))
                Context.Database.AddInParameter(command, "@CodigoRegion", DbType.String, DBNull.Value);
            else
                Context.Database.AddInParameter(command, "@codigoRegion", DbType.String, codigoRegion);
            if (fechaInicioSolicitud == null)
                Context.Database.AddInParameter(command, "@FechaInicio", DbType.DateTime, DBNull.Value);
            else
                Context.Database.AddInParameter(command, "@FechaInicio", DbType.DateTime, fechaInicioSolicitud);

            if (fechaFinSolicitud == null)
                Context.Database.AddInParameter(command, "@FechaFin", DbType.DateTime, DBNull.Value);
            else
                Context.Database.AddInParameter(command, "@FechaFin", DbType.DateTime, fechaFinSolicitud);

            return Context.ExecuteDataSet(command);
        }

    }
}