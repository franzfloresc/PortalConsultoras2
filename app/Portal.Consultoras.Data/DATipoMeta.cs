namespace Portal.Consultoras.Data
{
    using System.Data;
    using System.Data.Common;

    public class DATipoMeta : DataAccess
    {
        public DATipoMeta(int paisID)
            : base(paisID, EDbSource.Digitacion)
        { }

        public IDataReader GetTipoMeta()
        {
            DbCommand command = Context.Database.GetStoredProcCommand("dbo.GetTipoMeta");
            return Context.ExecuteReader(command);
        }

        public IDataReader GetTipoMetaPorCodigo(string codigoMeta)
        {
            DbCommand command = Context.Database.GetStoredProcCommand("dbo.GetTipoMetaPorCodigo");
            Context.Database.AddInParameter(command, "@CodigoMeta", DbType.String, codigoMeta);
            return Context.ExecuteReader(command);
        }
    }
}