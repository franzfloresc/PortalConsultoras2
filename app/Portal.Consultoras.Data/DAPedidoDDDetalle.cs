namespace Portal.Consultoras.Data
{
    using Portal.Consultoras.Entities;
    using System.Data;
    using System.Data.Common;

    public class DAPedidoDDDetalle : DataAccess
    {
        public DAPedidoDDDetalle(int paisID)
            : base(paisID, EDbSource.Digitacion)
        { }

        public IDataReader GetPedidoDDDetalleByPedidoID(int campaniaID, int pedidoID)
        {
            DbCommand command = Context.Database.GetStoredProcCommand("dbo.GetPedidoDDDetalleByPedidoID");
            Context.Database.AddInParameter(command, "@CampaniaID", DbType.Int32, campaniaID);
            Context.Database.AddInParameter(command, "@PedidoID", DbType.Int32, pedidoID);
            return Context.ExecuteReader(command);
        }

        public void InsPedidoDetalleDD(BEPedidoDDDetalle bePedidoDDDetalle)
        {
            DbCommand command = Context.Database.GetStoredProcCommand("dbo.InsPedidoDDDetalle");
            Context.Database.AddInParameter(command, "@PedidoID", DbType.Int32, bePedidoDDDetalle.PedidoID);
            Context.Database.AddInParameter(command, "@CampaniaID", DbType.Int32, bePedidoDDDetalle.CampaniaID);
            Context.Database.AddInParameter(command, "@ConsultoraID", DbType.Int64, bePedidoDDDetalle.ConsultoraID);
            Context.Database.AddInParameter(command, "@Cantidad", DbType.Int32, bePedidoDDDetalle.Cantidad);
            Context.Database.AddInParameter(command, "@CUV", DbType.String, bePedidoDDDetalle.CUV);
            Context.Database.AddInParameter(command, "@CodigoUsuarioCreacion", DbType.String, bePedidoDDDetalle.CodigoUsuarioCreacion);

            Context.ExecuteNonQuery(command);
        }

        public void UpdPedidoDetalleDD(BEPedidoDDDetalle bePedidoDDDetalle)
        {
            DbCommand command = Context.Database.GetStoredProcCommand("dbo.UpdPedidoDDDetalle");
            Context.Database.AddInParameter(command, "@PedidoID", DbType.Int32, bePedidoDDDetalle.PedidoID);
            Context.Database.AddInParameter(command, "@CampaniaID", DbType.Int32, bePedidoDDDetalle.CampaniaID);
            Context.Database.AddInParameter(command, "@PedidoDetalleID", DbType.Int32, bePedidoDDDetalle.PedidoDetalleID);
            Context.Database.AddInParameter(command, "@ConsultoraID", DbType.Int64, bePedidoDDDetalle.ConsultoraID);
            Context.Database.AddInParameter(command, "@CUV", DbType.String, bePedidoDDDetalle.CUV);
            Context.Database.AddInParameter(command, "@Cantidad", DbType.Int32, bePedidoDDDetalle.Cantidad);
            Context.Database.AddInParameter(command, "@IndicadorActivo", DbType.Boolean, bePedidoDDDetalle.IndicadorActivo);
            Context.Database.AddInParameter(command, "@CodigoUsuarioModificacion", DbType.String, bePedidoDDDetalle.CodigoUsuarioModificacion);

            Context.ExecuteNonQuery(command);
        }

        public void DelPedidoDetalleDD(BEPedidoDDDetalle bePedidoDDDetalle)
        {
            DbCommand command = Context.Database.GetStoredProcCommand("dbo.DelPedidoDDDetalle");
            Context.Database.AddInParameter(command, "@PedidoID", DbType.Int32, bePedidoDDDetalle.PedidoID);
            Context.Database.AddInParameter(command, "@CampaniaID", DbType.Int32, bePedidoDDDetalle.CampaniaID);
            Context.Database.AddInParameter(command, "@PedidoDetalleID", DbType.Int32, bePedidoDDDetalle.PedidoDetalleID);
            Context.Database.AddInParameter(command, "@CodigoUsuarioModificacion", DbType.String, bePedidoDDDetalle.CodigoUsuarioModificacion);

            Context.ExecuteNonQuery(command);
        }
    }
}