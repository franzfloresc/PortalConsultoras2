using System;
using System.Collections.Generic;
using System.Data;
using System.Data.Common;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Portal.Consultoras.Data
{
    public class DAConsultoraOnline : DataAccess
    {
        public DAConsultoraOnline(int paisID)
            : base(paisID, EDbSource.Portal)
        {
        }

        //public IDataReader GetMisPedidosConsultoraOnlineCab(long ConsultoraId)
        public IDataReader GetSolicitudesPedido(long ConsultoraId, int Campania)
        {
            //DbCommand command = Context.Database.GetStoredProcCommand("dbo.GetNotificacionesConsultoraOnline");
            DbCommand command = Context.Database.GetStoredProcCommand("dbo.GetSolicitudesPedido_SB2");
            Context.Database.AddInParameter(command, "@ConsultoraId", DbType.Int64, ConsultoraId);
            Context.Database.AddInParameter(command, "@Campania", DbType.Int32, Campania);

            return Context.ExecuteReader(command);
        }

        public IDataReader GetSolicitudesPedidoDetalle(int PedidoID)
        {
            DbCommand command = Context.Database.GetStoredProcCommand("dbo.GetSolicitudesPedidoDetalle_SB2");
            Context.Database.AddInParameter(command, "@SolicitudClienteID", DbType.Int32, PedidoID);

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
    }
}
