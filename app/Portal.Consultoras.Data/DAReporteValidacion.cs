using System;
using System.Data;
using System.Data.Common;

namespace Portal.Consultoras.Data
{
    public class DAReporteValidacion : DataAccess
    {
        public DAReporteValidacion(int paisID)
            : base(paisID, EDbSource.Portal)
        {
        }

        public IDataReader GetReporteValidacionUnificado(int campaniaID, int tipoEstrategia)
        {
            DbCommand command = Context.Database.GetStoredProcCommand("dbo.GetReporteValidacionUnificado");
            Context.Database.AddInParameter(command, "@CampaniaID", DbType.Int32, campaniaID);
            Context.Database.AddInParameter(command, "@TipoEstrategia", DbType.Int32, tipoEstrategia);
            return Context.ExecuteReader(command);
        }
   

        public IDataReader GetReporteValidacionSRCampania(int campaniaID)
        {
            DbCommand command = Context.Database.GetStoredProcCommand("dbo.GetReporteValidacionShowRoomCampania");
            Context.Database.AddInParameter(command, "@campania", DbType.Int32, campaniaID);

            return Context.ExecuteReader(command);
        }

        public IDataReader GetReporteValidacionSRPersonalizacion(int campaniaID)
        {
            DbCommand command = Context.Database.GetStoredProcCommand("dbo.GetReporteValidacionShowRoomPersonalizacion");
            Context.Database.AddInParameter(command, "@campania", DbType.Int32, campaniaID);

            return Context.ExecuteReader(command);
        }

        public IDataReader GetReporteValidacionSROferta(int campaniaID)
        {
            DbCommand command = Context.Database.GetStoredProcCommand("dbo.GetReporteValidacionShowRoomOfertaV2");
            Context.Database.AddInParameter(command, "@campania", DbType.Int32, campaniaID);
            return Context.ExecuteReader(command);
        }

        public IDataReader GetReporteValidacionSRComponentes(int campaniaID)
        {
            DbCommand command = Context.Database.GetStoredProcCommand("dbo.GetReporteValidacionShowRoomComponentesV2");
            Context.Database.AddInParameter(command, "@campania", DbType.Int32, campaniaID);
            return Context.ExecuteReader(command);
        }
    }
}