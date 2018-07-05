using System;
using System.Data;
using System.Data.Common;

namespace Portal.Consultoras.Data
{
    public class DAConsultora : DataAccess
    {
        public DAConsultora(int paisID)
            : base(paisID, EDbSource.Portal)
        {

        }

        public IDataReader GetConsultoraCodigo()
        {
            DbCommand command = Context.Database.GetStoredProcCommand("dbo.GetConsultoraCodigo");
            return Context.ExecuteReader(command);
        }
        public IDataReader GetConsultoraCodigoPorCodigoYRowCount(string codigo, int rowCount)
        {
            DbCommand command = Context.Database.GetStoredProcCommand("dbo.GetConsultoraPorCodigoYRowCount");
            Context.Database.AddInParameter(command, "@codigo", DbType.String, codigo);
            Context.Database.AddInParameter(command, "@rowCount", DbType.Int16, rowCount);
            return Context.ExecuteReader(command);
        }
        public IDataReader GetConsultoraById(Int64 ConsultoraID)
        {
            DbCommand command = Context.Database.GetStoredProcCommand("dbo.GetConsultoraById");
            Context.Database.AddInParameter(command, "@ConsultoraID", DbType.Int64, ConsultoraID);
            return Context.ExecuteReader(command);
        }

        public decimal GetSaldoActualConsultora(string Codigo)
        {
            DbCommand command = Context.Database.GetStoredProcCommand("dbo.GetSaldoActualConsultora");
            Context.Database.AddInParameter(command, "@Codigo", DbType.String, Codigo);
            return Convert.ToDecimal(Context.ExecuteScalar(command));
        }

        public IDataReader GetPagoEnlineaInfo(string Codigo, int CampaniaId, int ZonaId)
        {
            DbCommand command = Context.Database.GetStoredProcCommand("dbo.GetInformacionPagoConsultora");
            Context.Database.AddInParameter(command, "@Codigo", DbType.String, Codigo);
            Context.Database.AddInParameter(command, "@CampaniaId", DbType.Int64, CampaniaId);
            Context.Database.AddInParameter(command, "@ZonaId", DbType.Int64, ZonaId);
            return Context.ExecuteReader(command);
        }

        public IDataReader GetConsultoraByCodigo(string codigo, string codigoZona, string numeroDocumento)
        {
            DbCommand command = Context.Database.GetStoredProcCommand("dbo.GetConsultoraByCodigo");
            command.CommandTimeout = 0;
            if (!string.IsNullOrEmpty(codigo))
                Context.Database.AddInParameter(command, "@Codigo", DbType.String, codigo);
            if (!string.IsNullOrEmpty(codigoZona))
                Context.Database.AddInParameter(command, "@CodigoZona", DbType.String, codigoZona);
            if (!string.IsNullOrEmpty(numeroDocumento))
                Context.Database.AddInParameter(command, "@NumeroDocumento", DbType.String, numeroDocumento);
            return Context.ExecuteReader(command);
        }

        public IDataReader GetConsultoraDatos(string codigoZona, string codigoSeccion, string codigoConsultora, string nombreConsultora)
        {
            DbCommand command = Context.Database.GetStoredProcCommand("dbo.GetConsultoraDatosDD");
            Context.Database.AddInParameter(command, "@CodigoZona", DbType.String, codigoZona);
            Context.Database.AddInParameter(command, "@CodigoSeccion", DbType.String, codigoSeccion);
            Context.Database.AddInParameter(command, "@CodigoConsultora", DbType.String, codigoConsultora);
            Context.Database.AddInParameter(command, "@NombreConsultora", DbType.String, nombreConsultora);
            return Context.ExecuteReader(command);
        }

        public IDataReader GetConsultoraByCodigo(string codigo)
        {
            DbCommand command = Context.Database.GetStoredProcCommand("dbo.GetConsultoraByCodigoConsultora");
            command.CommandTimeout = 0;
            Context.Database.AddInParameter(command, "@Codigo", DbType.String, codigo);
            return Context.ExecuteReader(command);
        }
        
        public long GetConsultoraIdByCodigo(string CodigoConsultora)
        {
            DbCommand command = Context.Database.GetStoredProcCommand("dbo.GetConsultoraIdByCodigo");
            Context.Database.AddInParameter(command, "@CodigoConsultora", DbType.String, CodigoConsultora);
            return Convert.ToInt64(Context.ExecuteScalar(command));
        }

        public IDataReader GetConsultoraDatoSAC(string paisID, string codigoConsultora, string documento)
        {
            DbCommand command = Context.Database.GetStoredProcCommand("dbo.GetConsultoraDatoSAC");
            command.CommandTimeout = 0;
            if (!string.IsNullOrEmpty(paisID))
                Context.Database.AddInParameter(command, "@paisID", DbType.String, paisID);
            if (!string.IsNullOrEmpty(codigoConsultora))
                Context.Database.AddInParameter(command, "@codigoConsultora", DbType.String, codigoConsultora);
            if (!string.IsNullOrEmpty(documento))
                Context.Database.AddInParameter(command, "@documento", DbType.String, documento);
            return Context.ExecuteReader(command);
        }

        public IDataReader GetConsultoraEstadoSAC(string paisID, string codigoConsultora)
        {
            DbCommand command = Context.Database.GetStoredProcCommand("dbo.GetConsultoraEstadoSAC");
            command.CommandTimeout = 0;
            if (!string.IsNullOrEmpty(paisID))
                Context.Database.AddInParameter(command, "@paisID", DbType.String, paisID);
            if (!string.IsNullOrEmpty(codigoConsultora))
                Context.Database.AddInParameter(command, "@codigoConsultora", DbType.String, codigoConsultora);
            return Context.ExecuteReader(command);
        }

        public IDataReader GetConsultoraTop(string codigoConsultora)
        {
            DbCommand command = Context.Database.GetStoredProcCommand("dbo.GetConsultoraTop");
            command.CommandTimeout = 0;
            if (!string.IsNullOrEmpty(codigoConsultora))
                Context.Database.AddInParameter(command, "@codigoConsultora", DbType.String, codigoConsultora);

            return Context.ExecuteReader(command);
        }

        public IDataReader GetConsultoraCUVRegular(int campaniaID, string CUVRegular)
        {
            DbCommand command = Context.Database.GetStoredProcCommand("dbo.GetConsultoraCUVRegular");
            command.CommandTimeout = 0;
            Context.Database.AddInParameter(command, "@campaniaID", DbType.Int64, campaniaID);
            if (!string.IsNullOrEmpty(CUVRegular))
                Context.Database.AddInParameter(command, "@CUVRegular", DbType.String, CUVRegular);
            return Context.ExecuteReader(command);
        }

        public IDataReader GetConsultoraCUVCredito(int campaniaID, string CUVCredito)
        {
            DbCommand command = Context.Database.GetStoredProcCommand("dbo.GetConsultoraCUVCredito");
            command.CommandTimeout = 0;
            Context.Database.AddInParameter(command, "@campaniaID", DbType.Int64, campaniaID);
            if (!string.IsNullOrEmpty(CUVCredito))
                Context.Database.AddInParameter(command, "@CUVCredito", DbType.String, CUVCredito);
            return Context.ExecuteReader(command);
        }

        public IDataReader GetConsultorasPorUbigeo(int paisId, string codigoUbigeo, string campania, int marcaId, int tipoFiltroUbigeo)
        {

            DbCommand command = Context.Database.GetStoredProcCommand("dbo.GetConsultorasPorUbigeo");
            command.CommandTimeout = 0;
            Context.Database.AddInParameter(command, "@PaisId", DbType.Int32, paisId);
            Context.Database.AddInParameter(command, "@CodigoUbigeo", DbType.String, codigoUbigeo);
            Context.Database.AddInParameter(command, "@Campania", DbType.Int32, campania);
            Context.Database.AddInParameter(command, "@MarcaId", DbType.Int32, marcaId);
            Context.Database.AddInParameter(command, "@tipoFiltroUbigeo", DbType.Int32, tipoFiltroUbigeo);

            return Context.ExecuteReader(command);
        }

        public IDataReader GetConsultorasPorTerritorio(int paisId, string codigoRegion, string codigoZona, string codigoSeccion, string codigoTerritorio)
        {
            DbCommand command = Context.Database.GetStoredProcCommand("dbo.GetConsultorasPorTerritorio");
            command.CommandTimeout = 0;
            Context.Database.AddInParameter(command, "@PaisId", DbType.Int32, paisId);
            Context.Database.AddInParameter(command, "@CodigoRegion", DbType.String, codigoRegion);
            Context.Database.AddInParameter(command, "@CodigoZona", DbType.String, codigoZona);
            Context.Database.AddInParameter(command, "@CodigoSeccion", DbType.String, codigoSeccion);
            Context.Database.AddInParameter(command, "@CodigoTerritorio", DbType.String, codigoTerritorio);

            return Context.ExecuteReader(command);
        }

        public IDataReader GetConsultorasPorSeccion(int paisId, string codigoRegion, string codigoZona, string codigoSeccion)
        {
            DbCommand command = Context.Database.GetStoredProcCommand("dbo.GetConsultorasPorSeccion");
            command.CommandTimeout = 0;
            Context.Database.AddInParameter(command, "@PaisId", DbType.Int32, paisId);
            Context.Database.AddInParameter(command, "@CodigoRegion", DbType.String, codigoRegion);
            Context.Database.AddInParameter(command, "@CodigoZona", DbType.String, codigoZona);
            Context.Database.AddInParameter(command, "@CodigoSeccion", DbType.String, codigoSeccion);

            return Context.ExecuteReader(command);
        }

        public IDataReader GetConsultorasPorZona(int paisId, string codigoRegion, string codigoZona)
        {
            DbCommand command = Context.Database.GetStoredProcCommand("dbo.GetConsultorasPorZona");
            command.CommandTimeout = 0;
            Context.Database.AddInParameter(command, "@PaisId", DbType.Int32, paisId);
            Context.Database.AddInParameter(command, "@CodigoRegion", DbType.String, codigoRegion);
            Context.Database.AddInParameter(command, "@CodigoZona", DbType.String, codigoZona);

            return Context.ExecuteReader(command);
        }

        public string GetConsultoraByDocumento(string Codigo,int TipoDoc)
        {
            DbCommand command = Context.Database.GetStoredProcCommand("lideres.GetTipoDocumentoConsultora");
            Context.Database.AddInParameter(command, "@Documento", DbType.String, Codigo);
            Context.Database.AddInParameter(command, "@TipoDocumento", DbType.Int32, TipoDoc);
            return Convert.ToString(Context.ExecuteScalar(command));
        }

    }
}