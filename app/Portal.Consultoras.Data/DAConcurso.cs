using System.Data;
using System.Data.Common;

namespace Portal.Consultoras.Data
{
    public class DAConcurso : DataAccess
    {
        public DAConcurso(int paisID)
            : base(paisID, EDbSource.Portal)
        {

        }

        public IDataReader ObtenerConcursosXConsultora(string CodigoCampania, string CodigoConsultora, string CodigoRegion, string CodigoZona)
        {
            DbCommand command = Context.Database.GetStoredProcCommand("dbo.ObtenerConcursosXConsultora");
            Context.Database.AddInParameter(command, "@CODIGOCAMPANIA", DbType.String, CodigoCampania);
            Context.Database.AddInParameter(command, "@CODIGOCONSULTORA", DbType.String, CodigoConsultora);
            Context.Database.AddInParameter(command, "@CODIGOREGION", DbType.String, CodigoRegion);
            Context.Database.AddInParameter(command, "@CODIGOZONA", DbType.String, CodigoZona);
            return Context.ExecuteReader(command);
        }

        public void ActualizarInsertarPuntosConcurso(string CodigoConsultora, string CodigoCampania, string CodigoConcursos, string PuntosConcurso, string PuntosExigidosConcurso)
        {
            DbCommand command = Context.Database.GetStoredProcCommand("dbo.ActualizarInsertarPuntosConcurso_Prol3");
            Context.Database.AddInParameter(command, "@CodigoConsultora", DbType.AnsiString, CodigoConsultora);
            Context.Database.AddInParameter(command, "@CodigoCampania", DbType.String, CodigoCampania);
            Context.Database.AddInParameter(command, "@CodigoConcurso", DbType.String, CodigoConcursos);
            Context.Database.AddInParameter(command, "@PuntosConcurso", DbType.String, PuntosConcurso);
            Context.Database.AddInParameter(command, "@PuntosExigidosConcurso", DbType.String, PuntosExigidosConcurso);
            Context.ExecuteNonQuery(command);
        }

        public IDataReader ObtenerPuntosXConsultoraConcurso(string CodigoCampania, string CodigoConsultora)
        {
            DbCommand command = Context.Database.GetStoredProcCommand("dbo.ObtenerPuntosXConsultoraConcurso");
            Context.Database.AddInParameter(command, "@CodigoConsultora", DbType.String, CodigoConsultora);
            Context.Database.AddInParameter(command, "@CodigoCampania", DbType.String, CodigoCampania);
            return Context.ExecuteReader(command);
        }

        public void GenerarConcursoVigente(string CodigoConsultora, string CodigoCampania)
        {
            DbCommand command = Context.Database.GetStoredProcCommand("dbo.GenerarConcursoVigente");
            Context.Database.AddInParameter(command, "@CodigoConsultora", DbType.AnsiString, CodigoConsultora);
            Context.Database.AddInParameter(command, "@CodigoCampania", DbType.String, CodigoCampania);
            Context.ExecuteNonQuery(command);
        }

        public IDataReader ObtenerIncentivosConsultora(string CodigoConsultora, int CodigoCampania)
        {
            DbCommand command = Context.Database.GetStoredProcCommand("dbo.ObtenerIncentivosConsultora");
            Context.Database.AddInParameter(command, "@CodigoConsultora", DbType.String, CodigoConsultora);
            Context.Database.AddInParameter(command, "@CodigoCampania", DbType.Int32, CodigoCampania);
            return Context.ExecuteReader(command);
        }

        public IDataReader ObtenerIncentivosHistorico(string CodigoConsultora, int CodigoCampania)
        {
            DbCommand command = Context.Database.GetStoredProcCommand("dbo.ObtenerIncentivosHistorico");
            Context.Database.AddInParameter(command, "@CodigoConsultora", DbType.String, CodigoConsultora);
            Context.Database.AddInParameter(command, "@CodigoCampania", DbType.Int32, CodigoCampania);
            return Context.ExecuteReader(command);
        }

        public IDataReader ObtenerProgramaNuevasXConsultora(string CodigoConsultora, int CodigoCampania, string CodigoRegion, string CodigoZona)
        {
            DbCommand command = Context.Database.GetStoredProcCommand("dbo.ObtenerProgramaNuevasXConsultora");
            Context.Database.AddInParameter(command, "@CodigoConsultora", DbType.String, CodigoConsultora);
            Context.Database.AddInParameter(command, "@CodigoCampania", DbType.Int32, CodigoCampania);
            Context.Database.AddInParameter(command, "@CodigoRegion", DbType.String, CodigoRegion);
            Context.Database.AddInParameter(command, "@CodigoZona", DbType.String, CodigoZona);
            return Context.ExecuteReader(command);
        }

        public IDataReader ObtenerIncentivosProgramaNuevasConsultora(string CodigoConsultora, int CodigoCampania, long ConsultoraID)
        {
            using (var command = Context.Database.GetStoredProcCommand("dbo.ObtenerIncentivosProgramaNuevasConsultora"))
            {
                Context.Database.AddInParameter(command, "@CodigoConsultora", DbType.String, CodigoConsultora);
                Context.Database.AddInParameter(command, "@CodigoCampania", DbType.Int32, CodigoCampania);
                Context.Database.AddInParameter(command, "@ConsultoraID", DbType.Int64, ConsultoraID);
                return Context.ExecuteReader(command);
            }
        }

        public IDataReader ObtenerIncentivosConsultoraEstrategia(string CodigoConsultora, int CodigoCampania)
        {
            DbCommand command = Context.Database.GetStoredProcCommand("dbo.ObtenerIncentivosConsultoraEstrategia");
            Context.Database.AddInParameter(command, "@CodigoConsultora", DbType.String, CodigoConsultora);
            Context.Database.AddInParameter(command, "@CodigoCampania", DbType.Int32, CodigoCampania);
            return Context.ExecuteReader(command);
        }
    }
}