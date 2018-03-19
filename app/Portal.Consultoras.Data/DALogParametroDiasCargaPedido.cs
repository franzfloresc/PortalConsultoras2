using Portal.Consultoras.Entities;
using System.Data;
using System.Data.Common;

namespace Portal.Consultoras.Data
{
    public class DALogParametroDiasCargaPedido : DataAccess
    {
        public DALogParametroDiasCargaPedido(int paisID)
            : base(paisID, EDbSource.Portal)
        {

        }

        public IDataReader GetLogParametroDiasCargaPedido(int paisID)
        {
            DbCommand command = Context.Database.GetStoredProcCommand("dbo.GetLogParametroDiasCargaPedido");
            return Context.ExecuteReader(command);
        }

        public int InsLogParametroDiasCargaPedido(string CodigoUsuario, BELogParametroDiasCargaPedido entidad)
        {
            DbCommand command = Context.Database.GetStoredProcCommand("dbo.InsLogParametroDiasCargaPedido");
            Context.Database.AddInParameter(command, "@CodigoUsuario", DbType.String, CodigoUsuario);
            Context.Database.AddInParameter(command, "@CodigosRegionZona", DbType.String, entidad.CodigosRegionZona);
            Context.Database.AddInParameter(command, "@DiasParametroCargaAnterior", DbType.Int16, entidad.DiasParametroCargaAnterior);
            Context.Database.AddInParameter(command, "@DiasParametroCargaActual", DbType.Int16, entidad.DiasParametroCargaActual);

            return Context.ExecuteNonQuery(command);
        }
    }
}