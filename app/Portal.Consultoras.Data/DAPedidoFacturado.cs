using System;
using System.Data;
using System.Data.Common;

namespace Portal.Consultoras.Data
{
    public class DAPedidoFacturado : DataAccess
    {
        public DAPedidoFacturado(int paisID)
            : base(paisID, EDbSource.Portal)
        {

        }

        public IDataReader GetPedidosFacturadosCabecera(string CodigoConsultora)
        {
            DbCommand command = Context.Database.GetStoredProcCommand("dbo.GetPedidosFacturadosCabecera");
            Context.Database.AddInParameter(command, "@CodigoConsultora", DbType.AnsiString, CodigoConsultora);
            return Context.ExecuteReader(command);
        }

        public IDataReader GetPedidosFacturadosDetalle(string Campania, string Region, string Zona, string CodigoConsultora, int pedidoId)
        {
            DbCommand command = Context.Database.GetStoredProcCommand("dbo.GetPedidosFacturadosDetalle");
            Context.Database.AddInParameter(command, "@Campania", DbType.AnsiString, Campania);
            Context.Database.AddInParameter(command, "@Region", DbType.AnsiString, Region);
            Context.Database.AddInParameter(command, "@Zona", DbType.AnsiString, Zona);
            Context.Database.AddInParameter(command, "@CodigoConsultora", DbType.AnsiString, CodigoConsultora);
            Context.Database.AddInParameter(command, "@PedidoID", DbType.Int32, pedidoId);
            return Context.ExecuteReader(command);
        }

        public IDataReader GetPedidosFacturadosDetalleMobile(int CampaniaID, long ConsultoraID, short ClienteID)
        {
            DbCommand command = Context.Database.GetStoredProcCommand("dbo.GetPedidosFacturadosDetalleMobile");
            Context.Database.AddInParameter(command, "@CampaniaID", DbType.Int32, CampaniaID);
            Context.Database.AddInParameter(command, "@ConsultoraID", DbType.Int64, ConsultoraID);
            Context.Database.AddInParameter(command, "@ClienteID", DbType.Int16, ClienteID);

            return Context.ExecuteReader(command);
        }

        public int UpdateClientePedidoFacturado(int codigoPedido, int ClienteID)
        {
            DbCommand command = Context.Database.GetStoredProcCommand("dbo.UpdateClientePedidoFacturado");
            Context.Database.AddInParameter(command, "@CodigoPedido", DbType.Int32, codigoPedido);
            Context.Database.AddInParameter(command, "@ClienteID", DbType.Int32, ClienteID);

            return Convert.ToInt32(Context.ExecuteNonQuery(command));
        }
    }
}
