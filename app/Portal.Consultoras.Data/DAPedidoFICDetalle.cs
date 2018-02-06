using Portal.Consultoras.Entities;
using System;
using System.Data;
using System.Data.Common;

namespace Portal.Consultoras.Data
{
    public class DAPedidoFICDetalle : DataAccess
    {
        public DAPedidoFICDetalle(int paisID)
            : base(paisID, EDbSource.Portal)
        {

        }

        public IDataReader GetClientesByCampania(int CampaniaID, long ConsultoraID)
        {
            DbCommand command = Context.Database.GetStoredProcCommand("dbo.GetClientesByCampania");
            Context.Database.AddInParameter(command, "@CampaniaID", DbType.Int32, CampaniaID);
            Context.Database.AddInParameter(command, "@ConsultoraID", DbType.Int64, ConsultoraID);

            return Context.ExecuteReader(command);
        }

        public IDataReader GetPedidoWebDetalleByCliente(int CampaniaID, long ConsultoraID, int ClienteID)
        {
            DbCommand command = Context.Database.GetStoredProcCommand("dbo.GetPedidoWebDetalleByCliente");
            Context.Database.AddInParameter(command, "@CampaniaID", DbType.Int32, CampaniaID);
            Context.Database.AddInParameter(command, "@ConsultoraID", DbType.Int64, ConsultoraID);
            Context.Database.AddInParameter(command, "@ClienteID", DbType.Int32, ClienteID);

            return Context.ExecuteReader(command);
        }       

        public IDataReader GetPedidoWebDetalleByPedidoValidado(int CampaniaID, long ConsultoraID)
        {
            DbCommand command = Context.Database.GetStoredProcCommand("dbo.GetPedidoWebDetalleByPedidoValidado");
            Context.Database.AddInParameter(command, "@CampaniaID", DbType.Int32, CampaniaID);
            Context.Database.AddInParameter(command, "@ConsultoraID", DbType.Int64, ConsultoraID);

            return Context.ExecuteReader(command);
        }

        public IDataReader GetPedidoWebDetalleByOfertaWeb(int CampaniaID, long ConsultoraID, bool OfertaWeb)
        {
            DbCommand command = Context.Database.GetStoredProcCommand("dbo.GetPedidoWebDetalleByOfertaWeb");
            Context.Database.AddInParameter(command, "@CampaniaID", DbType.Int32, CampaniaID);
            Context.Database.AddInParameter(command, "@ConsultoraID", DbType.Int64, ConsultoraID);
            Context.Database.AddInParameter(command, "@OfertaWeb", DbType.Boolean, OfertaWeb);

            return Context.ExecuteReader(command);
        }

        public IDataReader GetPedidosDDWebDetalleByCampaniaPedido(int CampaniaID, int PedidoID)
        {
            DbCommand command = Context.Database.GetStoredProcCommand("dbo.GetPedidosDDWebDetalle");
            Context.Database.AddInParameter(command, "@CampaniaID", DbType.Int32, CampaniaID);
            Context.Database.AddInParameter(command, "@PedidoID", DbType.Int32, PedidoID);

            return Context.ExecuteReader(command);
        }

        public string InsPedidoWebDetallePROL(BEPedidoWebDetalle pedidowebdetalle)
        {
            DbCommand command = Context.Database.GetStoredProcCommand("dbo.InsPedidoWebDetallePROL");
            Context.Database.AddInParameter(command, "@CampaniaID", DbType.Int32, pedidowebdetalle.CampaniaID);
            Context.Database.AddInParameter(command, "@ConsultoraID", DbType.Int32, pedidowebdetalle.ConsultoraID);
            Context.Database.AddInParameter(command, "@MarcaID", DbType.Byte, pedidowebdetalle.MarcaID);
            Context.Database.AddInParameter(command, "@ClienteID", DbType.Int16, pedidowebdetalle.ClienteID == 0 ? (short?)null : pedidowebdetalle.ClienteID);
            Context.Database.AddInParameter(command, "@Cantidad", DbType.Int32, pedidowebdetalle.Cantidad);
            Context.Database.AddInParameter(command, "@PrecioUnidad", DbType.Decimal, pedidowebdetalle.PrecioUnidad);
            Context.Database.AddInParameter(command, "@CUV", DbType.AnsiString, pedidowebdetalle.CUV);
            Context.Database.AddInParameter(command, "@PedidoID", DbType.Int32, pedidowebdetalle.PedidoID);
            Context.Database.AddInParameter(command, "@OfertaWeb", DbType.Boolean, pedidowebdetalle.OfertaWeb);
            Context.Database.AddInParameter(command, "@PedidoDetalleID", DbType.Int16, pedidowebdetalle.PedidoDetalleID);
            Context.Database.AddInParameter(command, "@CUVPadre", DbType.AnsiString, pedidowebdetalle.CUVPadre);

            Context.ExecuteNonQuery(command);
            return string.Empty;
        }

        public IDataReader SelectDetalleBloqueoPedidoByPedidoId(int PedidoID)
        {
            DbCommand command = Context.Database.GetStoredProcCommand("dbo.GetDetalleBloqueoPedidoById");
            Context.Database.AddInParameter(command, "@PedidoID", DbType.Int32, PedidoID);

            return Context.ExecuteReader(command);
        }

        public void DelPedidoWebDetalleDesglosePedido(int CampaniaID, int PedidoID)
        {
            DbCommand command = Context.Database.GetStoredProcCommand("dbo.DelPedidoWebDetalleDesglosePedido");
            Context.Database.AddInParameter(command, "@CampaniaID", DbType.Int32, CampaniaID);
            Context.Database.AddInParameter(command, "@PedidoID", DbType.Int32, PedidoID);

            Context.ExecuteNonQuery(command);
        }

        public IDataReader GetPedidosWebNoFacturadosDetalle(string paisISO, int CampaniaID, string Consultora)
        {
            DbCommand command = Context.Database.GetStoredProcCommand("dbo.GetPedidoWebNoFacturadoDetalle");
            Context.Database.AddInParameter(command, "@PaisID", DbType.AnsiString, paisISO);
            Context.Database.AddInParameter(command, "@CampaniaID", DbType.Int32, CampaniaID);
            Context.Database.AddInParameter(command, "@CodigoConsultora", DbType.AnsiString, Consultora);

            return Context.ExecuteReader(command);
        }

        public IDataReader GetPedidoFICDetalleByCampania(int CampaniaID, long ConsultoraID)
        {
            DbCommand command = Context.Database.GetStoredProcCommand("dbo.GetPedidoFICDetalleByCampania");
            Context.Database.AddInParameter(command, "@CampaniaID", DbType.Int32, CampaniaID);
            Context.Database.AddInParameter(command, "@ConsultoraID", DbType.Int64, ConsultoraID);

            return Context.ExecuteReader(command);
        }

        public BEPedidoFICDetalle InsPedidoFICDetalle(BEPedidoFICDetalle pedidoficdetalle)
        {
            DbCommand command = Context.Database.GetStoredProcCommand("dbo.InsPedidoFICDetalle");
            Context.Database.AddInParameter(command, "@CampaniaID", DbType.Int32, pedidoficdetalle.CampaniaID);
            Context.Database.AddInParameter(command, "@ConsultoraID", DbType.Int32, pedidoficdetalle.ConsultoraID);
            Context.Database.AddInParameter(command, "@MarcaID", DbType.Byte, pedidoficdetalle.MarcaID);
            Context.Database.AddInParameter(command, "@ClienteID", DbType.Int16, pedidoficdetalle.ClienteID == 0 ? (short?)null : pedidoficdetalle.ClienteID);
            Context.Database.AddInParameter(command, "@Cantidad", DbType.Int32, pedidoficdetalle.Cantidad);
            Context.Database.AddInParameter(command, "@PrecioUnidad", DbType.Decimal, pedidoficdetalle.PrecioUnidad);
            Context.Database.AddInParameter(command, "@CUV", DbType.AnsiString, pedidoficdetalle.CUV);
            Context.Database.AddInParameter(command, "@PedidoID", DbType.Int32, pedidoficdetalle.PedidoID);
            Context.Database.AddInParameter(command, "@OfertaWeb", DbType.Boolean, pedidoficdetalle.OfertaWeb);
            Context.Database.AddInParameter(command, "@ConfiguracionOfertaID", DbType.Int32, pedidoficdetalle.ConfiguracionOfertaID);
            Context.Database.AddInParameter(command, "@TipoOfertaSisID", DbType.Int32, pedidoficdetalle.TipoOfertaSisID);
            Context.Database.AddOutParameter(command, "@PedidoDetalleID", DbType.Int16, 2);

            Context.ExecuteNonQuery(command);
            pedidoficdetalle.PedidoDetalleID = Convert.ToInt16(command.Parameters["@PedidoDetalleID"].Value);
            return pedidoficdetalle;
        }

        public int UpdPedidoFICDetalle(BEPedidoFICDetalle pedidoficdetalle)
        {
            DbCommand command = Context.Database.GetStoredProcCommand("dbo.UpdPedidoFICDetalle");
            Context.Database.AddInParameter(command, "@CampaniaID", DbType.Int32, pedidoficdetalle.CampaniaID);
            Context.Database.AddInParameter(command, "@PedidoID", DbType.Int32, pedidoficdetalle.PedidoID);
            Context.Database.AddInParameter(command, "@PedidoDetalleID", DbType.Int16, pedidoficdetalle.PedidoDetalleID);
            Context.Database.AddInParameter(command, "@Cantidad", DbType.Int32, pedidoficdetalle.Cantidad);
            Context.Database.AddInParameter(command, "@PrecioUnidad", DbType.Decimal, pedidoficdetalle.PrecioUnidad);
            Context.Database.AddInParameter(command, "@ClienteID", DbType.Int16, pedidoficdetalle.ClienteID == 0 ? (short?)null : pedidoficdetalle.ClienteID);

            int result = Context.ExecuteNonQuery(command);
            return result;
        }

        public int DelPedidoFICDetalle(int CampaniaID, int PedidoID, short PedidoDetalleID, int TipoOfertaSisID)
        {
            DbCommand command = Context.Database.GetStoredProcCommand("dbo.DelPedidoFICDetalle");
            Context.Database.AddInParameter(command, "@CampaniaID", DbType.Int32, CampaniaID);
            Context.Database.AddInParameter(command, "@PedidoID", DbType.Int32, PedidoID);
            Context.Database.AddInParameter(command, "@PedidoDetalleID", DbType.Int16, PedidoDetalleID);

            int result = Context.ExecuteNonQuery(command);
            return result;
        } 

        public short DelPedidoFICDetalleByCUV(int CampaniaID, int PedidoID, string CUV)
        {
            DbCommand command = Context.Database.GetStoredProcCommand("dbo.DelPedidoFICDetalleByCUV");
            Context.Database.AddInParameter(command, "@CampaniaID", DbType.Int32, CampaniaID);
            Context.Database.AddInParameter(command, "@PedidoID", DbType.Int32, PedidoID);
            Context.Database.AddInParameter(command, "@CUV", DbType.AnsiString, CUV);
            Context.Database.AddOutParameter(command, "@Deleted", DbType.Int16, 2);

            Context.ExecuteNonQuery(command);
            short deleted = Convert.ToInt16(command.Parameters["@Deleted"].Value);
            return deleted;
        }

        public int DelPedidoFICDetalleMasivo(int CampaniaID, int PedidoID)
        {
            DbCommand command = Context.Database.GetStoredProcCommand("dbo.DelPedidoFICDetalleMasivo");
            Context.Database.AddInParameter(command, "@CampaniaID", DbType.Int32, CampaniaID);
            Context.Database.AddInParameter(command, "@PedidoID", DbType.Int32, PedidoID);

            int result = Context.ExecuteNonQuery(command);
            return result;
        }
    }
}
