using System.Data;
using System.Data.Common;

namespace Portal.Consultoras.Data
{
    public class DAConsultoraOnline : DataAccess
    {
        public DAConsultoraOnline(int paisID)
            : base(paisID, EDbSource.Portal)
        {
        }

        public IDataReader GetSolicitudesPedido(long ConsultoraId, int Campania)
        {
            DbCommand command = Context.Database.GetStoredProcCommand("dbo.GetSolicitudesPedido_SB2");
            Context.Database.AddInParameter(command, "@ConsultoraId", DbType.Int64, ConsultoraId);
            Context.Database.AddInParameter(command, "@Campania", DbType.Int32, Campania);

            return Context.ExecuteReader(command);
        }

        public IDataReader GetSolicitudesPedidoDetalle(long PedidoID)
        {
            DbCommand command = Context.Database.GetStoredProcCommand("dbo.GetSolicitudesPedidoDetalle_SB2");
            Context.Database.AddInParameter(command, "@SolicitudClienteID", DbType.Int64, PedidoID);

            return Context.ExecuteReader(command);
        }

        public IDataReader GetMisPedidosClienteOnline(long ConsultoraId, int Campania)
        {
            DbCommand command = Context.Database.GetStoredProcCommand("dbo.GetMisPedidosClienteOnline_SB2");
            Context.Database.AddInParameter(command, "@ConsultoraId", DbType.Int64, ConsultoraId);
            Context.Database.AddInParameter(command, "@Campania", DbType.Int32, Campania);
            return Context.ExecuteReader(command);
        }

        public IDataReader GetPedidoClienteOnlineBySolicitudClienteId(long solicitudClienteId)
        {
            DbCommand command = Context.Database.GetStoredProcCommand("dbo.GetPedidoClienteOnlineBySolicitudClienteId_SB2");
            Context.Database.AddInParameter(command, "@SolicitudClienteId", DbType.Int64, solicitudClienteId);
            return Context.ExecuteReader(command);
        }
		
		public IDataReader GetCantidadPedidosConsultoraOnline(long ConsultoraId)
        {
            DbCommand command = Context.Database.GetStoredProcCommand("dbo.GetCantidadPedidosConsultoraOnline");
            Context.Database.AddInParameter(command, "@ConsultoraId", DbType.Int64, ConsultoraId);

            return Context.ExecuteReader(command);
        }

        public IDataReader GetValidarCUVSolicitudPedido(int Campania, string InputCUV, int RegionID, int ZonaID, string CodigoRegion, string CodigoZona)
        {
            DbCommand command = Context.Database.GetStoredProcCommand("dbo.GetValidarCUVSolicitudPedido_SB2");
            Context.Database.AddInParameter(command, "@CampaniaID", DbType.Int32, Campania);
            Context.Database.AddInParameter(command, "@InputCUVS", DbType.String, InputCUV);
            Context.Database.AddInParameter(command, "@RegionID", DbType.Int32, RegionID);
            Context.Database.AddInParameter(command, "@ZonaID", DbType.Int32, ZonaID);
            Context.Database.AddInParameter(command, "@CodigoRegion", DbType.String, CodigoRegion);
            Context.Database.AddInParameter(command, "@CodigoZona", DbType.String, CodigoZona);

            return Context.ExecuteReader(command);
        }
        
        public IDataReader GetCantidadSolicitudesPedido(long ConsultoraId, int Campania)
        {
            DbCommand command = Context.Database.GetStoredProcCommand("dbo.GetCantidadSolicitudesPedido_SB2");
            Context.Database.AddInParameter(command, "@ConsultoraId", DbType.Int64, ConsultoraId);
            Context.Database.AddInParameter(command, "@Campania", DbType.Int32, Campania);

            return Context.ExecuteReader(command);
        }

        public IDataReader GetSaldoHorasSolicitudesPedido(long ConsultoraId, int Campania)
        {
            DbCommand command = Context.Database.GetStoredProcCommand("dbo.GetSaldoHorasSolicitudesPedido_SB2");
            Context.Database.AddInParameter(command, "@ConsultoraId", DbType.Int64, ConsultoraId);
            Context.Database.AddInParameter(command, "@Campania", DbType.Int32, Campania);

            return Context.ExecuteReader(command);
        }
        public IDataReader GetProductoByCampaniaByConsultoraId(int campaniaId, long consultoraId)
        {
            DbCommand command = Context.Database.GetStoredProcCommand("dbo.GetSolicitudesPedidoDetalleByCampaniaByConsultoraId");
            Context.Database.AddInParameter(command, "@CampaniaID", DbType.Int32, campaniaId);
            Context.Database.AddInParameter(command, "@ConsultoraID", DbType.Int64, consultoraId);

            return Context.ExecuteReader(command);
        }

        #region AppCatalogo

        public IDataReader GetPedidosClienteAppCatalogo(string DispositivoID, int Campania)
        {
            DbCommand command = Context.Database.GetStoredProcCommand("AppCatalogos.GetMisPedidosCliente");
            Context.Database.AddInParameter(command, "@CodigoDispositivo", DbType.String, DispositivoID);
            Context.Database.AddInParameter(command, "@Campania", DbType.Int32, Campania);

            return Context.ExecuteReader(command);
        }

        public IDataReader GetPedidosConsultoraAppCatalogo(long ConsultoraId, int Campania)
        {
            DbCommand command = Context.Database.GetStoredProcCommand("AppCatalogos.GetMisPedidosConsultora");
            Context.Database.AddInParameter(command, "@ConsultoraId", DbType.Int64, ConsultoraId);
            Context.Database.AddInParameter(command, "@Campania", DbType.Int32, Campania);

            return Context.ExecuteReader(command);
        }

        public IDataReader GetDetallePedidoAppCatalogo(long PedidoId)
        {
            DbCommand command = Context.Database.GetStoredProcCommand("AppCatalogos.GetSolicitudesPedidoDetalle");
            Context.Database.AddInParameter(command, "@SolicitudClienteID", DbType.Int64, PedidoId);

            return Context.ExecuteReader(command);
        }

        #endregion
    }
}
