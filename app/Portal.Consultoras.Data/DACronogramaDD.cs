using System;
using System.Data;
using System.Data.Common;

namespace Portal.Consultoras.Data
{
    public class DACronogramaDD : DataAccess
    {
        public DACronogramaDD(int paisID)
            : base(paisID, EDbSource.Digitacion)
        {

        }

        public void UpdCronogramaDD(string CampaniaCodigo, string Codigos, int Tipo, DateTime FechaFacturacion, DateTime FechaFinFacturacion, DateTime FechaReFacturacion, string CodigoUsuario)
        {
            DbCommand command = Context.Database.GetStoredProcCommand("dbo.UpdLogActualizacionFacturacionDD");
            Context.Database.AddInParameter(command, "@CampaniaCodigo", DbType.String, CampaniaCodigo);
            Context.Database.AddInParameter(command, "@Codigos", DbType.String, Codigos);
            Context.Database.AddInParameter(command, "@Tipo", DbType.Int32, Tipo);
            Context.Database.AddInParameter(command, "@FechaFacturacion", DbType.DateTime, FechaFacturacion);
            Context.Database.AddInParameter(command, "@FechaReFacturacion", DbType.DateTime, FechaReFacturacion);
            Context.Database.AddInParameter(command, "@CodigoUsuario", DbType.String, CodigoUsuario);

            Context.ExecuteNonQuery(command);
        }

        public IDataReader UpdCronogramaDemandaAnticipadaDD(string CampaniaCodigo, string ZonaCodigo, DateTime FechaFacturacion, DateTime FechaReFacturacion)
        {
            DbCommand command = Context.Database.GetStoredProcCommand("dbo.UpdCronogramaDemandaAnticipada");
            Context.Database.AddInParameter(command, "@CampaniaCodigo", DbType.String, CampaniaCodigo);
            Context.Database.AddInParameter(command, "@ZonaCodigo", DbType.String, ZonaCodigo);
            Context.Database.AddInParameter(command, "@FechaFacturacion", DbType.DateTime, FechaFacturacion);
            Context.Database.AddInParameter(command, "@FechaReFacturacion", DbType.DateTime, FechaReFacturacion);

            return Context.ExecuteReader(command);
        }

        public IDataReader InsCronogramaDemandaAnticipadaDD(string CampaniaCodigo, string ZonaCodigo, DateTime FechaFacturacion, DateTime FechaReFacturacion)
        {
            DbCommand command = Context.Database.GetStoredProcCommand("dbo.InsCronogramaDemandaAnticipada");
            Context.Database.AddInParameter(command, "@CampaniaCodigo", DbType.String, CampaniaCodigo);
            Context.Database.AddInParameter(command, "@ZonaCodigo", DbType.String, ZonaCodigo);
            Context.Database.AddInParameter(command, "@FechaFacturacion", DbType.DateTime, FechaFacturacion);
            Context.Database.AddInParameter(command, "@FechaReFacturacion", DbType.DateTime, FechaReFacturacion);

            return Context.ExecuteReader(command);
        }

        public IDataReader DelCronogramaDemandaAnticipadaDD(string ZonaCodigo)
        {
            DbCommand command = Context.Database.GetStoredProcCommand("dbo.DelCronogramaDemandaAnticipada");
            Context.Database.AddInParameter(command, "@ZonaCodigo", DbType.String, ZonaCodigo);

            return Context.ExecuteReader(command);
        }
    }
}