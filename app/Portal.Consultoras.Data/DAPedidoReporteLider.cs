using System.Data;
using System.Data.Common;

namespace Portal.Consultoras.Data
{
    public class DAPedidoReporteLider : DataAccess
    {
        public DAPedidoReporteLider(int paisID)
            : base(paisID, EDbSource.Portal)
        {

        }

        public IDataReader GetPedidosReporteLiderIndicador(long ConsultoraLiderID, string CodigoPais, string CodigoCampaniaActual)
        {
            DbCommand command = Context.Database.GetStoredProcCommand("dbo.OBTENER_PEDIDO_WEB_INDICADOR");
            Context.Database.AddInParameter(command, "@ConsultoraLiderID", DbType.Int64, ConsultoraLiderID);
            Context.Database.AddInParameter(command, "@CodigoPais", DbType.String, CodigoPais);
            Context.Database.AddInParameter(command, "@CodigoCampaniaActual", DbType.String, CodigoCampaniaActual);
            return Context.ExecuteReader(command);
        }

        public IDataReader GetPedidosReporteLiderPedidosValidados(long ConsultoraLiderID, string CodigoPais, string CodigoCampaniaActual)
        {
            DbCommand command = Context.Database.GetStoredProcCommand("dbo.OBTENER_PEDIDO_WEB_VALIDADOS");
            Context.Database.AddInParameter(command, "@ConsultoraLiderID", DbType.Int64, ConsultoraLiderID);
            Context.Database.AddInParameter(command, "@CodigoPais", DbType.String, CodigoPais);
            Context.Database.AddInParameter(command, "@CodigoCampaniaActual", DbType.String, CodigoCampaniaActual);
            return Context.ExecuteReader(command);
        }

        public IDataReader GetPedidosReporteLiderPedidosNoValidados(long ConsultoraLiderID, string CodigoPais, string CodigoCampaniaActual)
        {
            DbCommand command = Context.Database.GetStoredProcCommand("dbo.OBTENER_PEDIDO_WEB_NO_VALIDADOS");
            Context.Database.AddInParameter(command, "@ConsultoraLiderID", DbType.Int64, ConsultoraLiderID);
            Context.Database.AddInParameter(command, "@CodigoPais", DbType.String, CodigoPais);
            Context.Database.AddInParameter(command, "@CodigoCampaniaActual", DbType.String, CodigoCampaniaActual);
            return Context.ExecuteReader(command);
        }

        public IDataReader GetPedidosReporteLiderPedidosRechazados(long ConsultoraLiderID, string CodigoPais, string CodigoCampaniaActual)
        {
            DbCommand command = Context.Database.GetStoredProcCommand("dbo.OBTENER_PEDIDO_WEB_RECHAZADOS");
            Context.Database.AddInParameter(command, "@ConsultoraLiderID", DbType.Int64, ConsultoraLiderID);
            Context.Database.AddInParameter(command, "@CodigoPais", DbType.String, CodigoPais);
            Context.Database.AddInParameter(command, "@CodigoCampaniaActual", DbType.String, CodigoCampaniaActual);
            return Context.ExecuteReader(command);
        }

        public IDataReader GetPedidosReporteLiderPedidosFacturados(long ConsultoraLiderID, string CodigoPais, string CodigoCampaniaActual)
        {
            DbCommand command = Context.Database.GetStoredProcCommand("dbo.OBTENER_PEDIDO_WEB_FACTURADOS");
            Context.Database.AddInParameter(command, "@ConsultoraLiderID", DbType.Int64, ConsultoraLiderID);
            Context.Database.AddInParameter(command, "@CodigoPais", DbType.String, CodigoPais);
            Context.Database.AddInParameter(command, "@CodigoCampaniaActual", DbType.String, CodigoCampaniaActual);
            return Context.ExecuteReader(command);
        }
    }
}
