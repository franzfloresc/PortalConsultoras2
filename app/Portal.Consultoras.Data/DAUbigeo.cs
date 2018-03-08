namespace Portal.Consultoras.Data
{
    using System.Data;
    using System.Data.Common;

    public class DAUbigeo : DataAccess
    {
        public DAUbigeo(int paisID)
            : base(paisID, EDbSource.Digitacion)
        { }

        public DAUbigeo(int paisID, int idPortal)
            : base(paisID, EDbSource.Portal)
        { }

        public IDataReader GetUbigeoPorCodigoTerritorio(string codigozona, string codigoTerritorio)
        {
            DbCommand command = Context.Database.GetStoredProcCommand("dbo.GetUbigeoPorCodigoTerritorio");
            Context.Database.AddInParameter(command, "@CodigoZona", DbType.String, codigozona);
            Context.Database.AddInParameter(command, "@CodigoTerritorio", DbType.String, codigoTerritorio);
            return Context.ExecuteReader(command);
        }

        public IDataReader GetUbigeoPorCodigoUbigeo(string codigoUbigeo)
        {
            DbCommand command = Context.Database.GetStoredProcCommand("dbo.GetUbigeoPorCodigoUbigeo");
            Context.Database.AddInParameter(command, "@CodigoUbigeo", DbType.String, codigoUbigeo);
            return Context.ExecuteReader(command);
        }

        public IDataReader GetUbigeosPorNivel(int nivel, string CodigoPadre)
        {
            DbCommand command = Context.Database.GetStoredProcCommand("GetUbigeosNivel");
            Context.Database.AddInParameter(command, "@Nivel", DbType.Int32, nivel);
            Context.Database.AddInParameter(command, "@CodigoPadre", DbType.String, CodigoPadre);
            return Context.ExecuteReader(command);

        }

        public IDataReader GetUbigeosPorPais()
        {
            DbCommand command = Context.Database.GetStoredProcCommand("dbo.GetUbigeosPorPais");
            return Context.ExecuteReader(command);
        }

    }
}