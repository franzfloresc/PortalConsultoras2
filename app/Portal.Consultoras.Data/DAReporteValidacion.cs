﻿using System;
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

        public IDataReader GetReporteValidacion(int campaniaID)
        {
            DbCommand command = Context.Database.GetStoredProcCommand("dbo.GetReporteValidacion");
            Context.Database.AddInParameter(command, "@CampaniaID", DbType.Int32, campaniaID);

            return Context.ExecuteReader(command);
        }

        public IDataReader GetReporteValidacionODD(int campaniaID)
        {
            DbCommand command = Context.Database.GetStoredProcCommand("dbo.GetReporteValidacionODD");
            Context.Database.AddInParameter(command, "@CampaniaID", DbType.Int32, campaniaID);

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

        [Obsolete("Migrado PL50-50")]
        public IDataReader GetReporteValidacionSROferta(int campaniaID)
        {
            DbCommand command = Context.Database.GetStoredProcCommand("dbo.GetReporteValidacionShowRoomOferta");
            Context.Database.AddInParameter(command, "@campania", DbType.Int32, campaniaID);

            return Context.ExecuteReader(command);
        }

        [Obsolete("Migrado PL50-50")]
        public IDataReader GetReporteValidacionSRComponentes(int campaniaID)
        {
            DbCommand command = Context.Database.GetStoredProcCommand("dbo.GetReporteValidacionShowRoomComponentes");
            Context.Database.AddInParameter(command, "@campania", DbType.Int32, campaniaID);

            return Context.ExecuteReader(command);
        }
    }
}