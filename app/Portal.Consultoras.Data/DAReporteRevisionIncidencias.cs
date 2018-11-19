using System;
using System.Data;
using System.Data.Common;

namespace Portal.Consultoras.Data
{
    public class DAReporteRevisionIncidencias : DataAccess
    {
        public DAReporteRevisionIncidencias(int paisID)
            : base(paisID, EDbSource.Portal)
        {
        }

        public IDataReader GetReporteCuvResumido(int campaniaID, string cuv)
        {
            DbCommand command = Context.Database.GetStoredProcCommand("dbo.GetReporteCuvResumido");
            Context.Database.AddInParameter(command, "@CampaniaID", DbType.Int32, campaniaID);
            Context.Database.AddInParameter(command, "@Cuv", DbType.String, cuv);
            return Context.ExecuteReader(command);
        }

        public IDataReader GetReporteCuvDetallado(int campaniaID, string cuv)
        {
            try
            {
                DbCommand command = Context.Database.GetStoredProcCommand("dbo.GetReporteCuvDetallado");
                Context.Database.AddInParameter(command, "@CampaniaID", DbType.Int32, campaniaID);
                Context.Database.AddInParameter(command, "@Cuv", DbType.String, cuv);
                return Context.ExecuteReader(command);
            }
            catch (Exception ex)
            {
                throw new Exception(Common.LogManager.GetMensajeError(ex));
            }
        }

        public IDataReader GetReporteMovimientosPedido(int campaniaID, string codigoConsultora)
        {
            DbCommand command = Context.Database.GetStoredProcCommand("dbo.GetReporteMovimientosPedido");
            Context.Database.AddInParameter(command, "@CampaniaID", DbType.Int32, campaniaID);
            Context.Database.AddInParameter(command, "@CodigoConsultora", DbType.String, codigoConsultora);
            return Context.ExecuteReader(command);
        }

        public IDataReader GetReporteEstrategiasPorConsultora(int campaniaID, string codigoConsultora, int palanca, DateTime fechaConsulta)
        {
            DbCommand command = Context.Database.GetStoredProcCommand("dbo.GetReporteEstrategiasPorConsultora");
            Context.Database.AddInParameter(command, "@CampaniaID", DbType.Int32, campaniaID);
            Context.Database.AddInParameter(command, "@CodigoConsultora", DbType.String, codigoConsultora);
            Context.Database.AddInParameter(command, "@Palanca", DbType.Int32, palanca);
            Context.Database.AddInParameter(command, "@FechaConsulta", DbType.Date, fechaConsulta);
            return Context.ExecuteReader(command);
        }
    }
}
