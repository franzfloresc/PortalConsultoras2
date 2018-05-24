using System;
using System.Data;
using System.Data.Common;

namespace Portal.Consultoras.Data
{
    public class DACronograma : DataAccess
    {
        public DACronograma(int paisID)
            : base(paisID, EDbSource.Portal)
        {

        }

        public IDataReader GetCronogramaByCampaniayZona(int CampaniaID, int ZonaID)
        {
            DbCommand command = Context.Database.GetStoredProcCommand("dbo.GetCronogramaByCampaniayZona");
            Context.Database.AddInParameter(command, "@CampaniaID", DbType.Int32, CampaniaID);
            Context.Database.AddInParameter(command, "@ZonaID", DbType.Int32, ZonaID);

            return Context.ExecuteReader(command);
        }

        public IDataReader GetCronogramaByCampania(int CampaniaID, int ZonaID, Int16 TipoCronogramaID)
        {
            DbCommand command = Context.Database.GetStoredProcCommand("dbo.GetCronogramaByCampaniaODS");
            Context.Database.AddInParameter(command, "@CampaniaID", DbType.Int32, CampaniaID);
            Context.Database.AddInParameter(command, "@ZonaID", DbType.Int32, ZonaID);
            Context.Database.AddInParameter(command, "@TipoCronogramaID", DbType.Int16, TipoCronogramaID);

            return Context.ExecuteReader(command);
        }

        public int MigrarCronogramaAnticipado(int CampaniaID, int ZonaID)
        {
            DbCommand command = Context.Database.GetStoredProcCommand("dbo.MigrarCronogramaAnticipado");
            Context.Database.AddInParameter(command, "@CampaniaID", DbType.Int32, CampaniaID);
            Context.Database.AddInParameter(command, "@ZonaID", DbType.Int32, ZonaID);

            return int.Parse(Context.ExecuteScalar(command).ToString());
        }

        public IDataReader GetLogActualizacionFacturacion()
        {
            DbCommand command = Context.Database.GetStoredProcCommand("dbo.GetLogActualizacionFacturacion");

            return Context.ExecuteReader(command);
        }

        public IDataReader UpdLogActualizacionFacturacion(string CampaniaCodigo, string Codigos, int Tipo, DateTime FechaFacturacion, DateTime FechaReFacturacion, string CodigoUsuario)
        {
            DbCommand command = Context.Database.GetStoredProcCommand("dbo.UpdLogActualizacionFacturacion");
            Context.Database.AddInParameter(command, "@CampaniaCodigo", DbType.String, CampaniaCodigo);
            Context.Database.AddInParameter(command, "@Codigos", DbType.String, Codigos);
            Context.Database.AddInParameter(command, "@Tipo", DbType.Int32, Tipo);
            Context.Database.AddInParameter(command, "@FechaFacturacion", DbType.DateTime, FechaFacturacion);
            Context.Database.AddInParameter(command, "@FechaReFacturacion", DbType.DateTime, FechaReFacturacion);
            Context.Database.AddInParameter(command, "@CodigoUsuario", DbType.String, CodigoUsuario);

            return Context.ExecuteReader(command);
        }

        public IDataReader GetZonasFechaFacturacion(DateTime fechaFacturacion)
        {
            DbCommand command = Context.Database.GetStoredProcCommand("dbo.GetZonasFechaFacturacion");
            Context.Database.AddInParameter(command, "@FechaFacturacion", DbType.DateTime, fechaFacturacion);

            return Context.ExecuteReader(command);
        }

        public bool GetCronogramaAutomaticoActivacion()
        {
            DbCommand command = Context.Database.GetStoredProcCommand("dbo.GetCronogramaAutomaticoActivacion");
            bool result = false;
            if (Context.ExecuteScalar(command) != null)
                result = Convert.ToBoolean(Context.ExecuteScalar(command));

            return result;
        }

        public int GetCampaniaFacturacionPais()
        {
            DbCommand command = Context.Database.GetStoredProcCommand("dbo.GetCampaniaFacturacionPais");
            int result = Context.ExecuteScalar(command) == null ? 0 : Convert.ToInt32(Context.ExecuteScalar(command));
            return result;
        }

        public IDataReader GetCampaniaActivaPais(DateTime fechaConsulta)
        {
            DbCommand command = Context.Database.GetStoredProcCommand("dbo.GetCampaniaActivaPais");
            Context.Database.AddInParameter(command, "@FechaFacturacion", DbType.Date, fechaConsulta);

            return Context.ExecuteReader(command);
        }

        public string GetCampaniaActualAndSiguientePais(string codigoIso)
        {
            DbCommand command = Context.Database.GetStoredProcCommand("dbo.GetCampaniaActualAndSiguientePais");
            Context.Database.AddInParameter(command, "@CodigoIso", DbType.AnsiString, codigoIso);
            var result = Context.ExecuteScalar(command) == null ? "" : Convert.ToString(Context.ExecuteScalar(command));
            return result;
        }
    }
}