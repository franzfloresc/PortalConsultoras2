using System;
using System.Data;
using System.Data.Common;

namespace Portal.Consultoras.Data
{
    public class DANotificaciones : DataAccess
    {
        public DANotificaciones(int paisID)
            : base(paisID, EDbSource.Portal)
        {

        }

        public IDataReader GetNotificacionesConsultora(long ConsultoraId, int indicadorBloqueoCDR, bool tienePagoEnLinea)
        {
            DbCommand command = Context.Database.GetStoredProcCommand("dbo.GetNotificacionesConsultora");
            Context.Database.AddInParameter(command, "@ConsultoraId", DbType.Int64, ConsultoraId);
            Context.Database.AddInParameter(command, "@ShowCDR", DbType.Boolean, indicadorBloqueoCDR == 0);
            Context.Database.AddInParameter(command, "@ShowPayOnline", DbType.Boolean, tienePagoEnLinea);

            return Context.ExecuteReader(command);
        }
        
        public int GetNotificacionesSinLeer(long ConsultoraId, int indicadorBloqueoCDR, bool tienePagoEnLinea)
        {
            DbCommand command = Context.Database.GetStoredProcCommand("dbo.GetNotificacionesSinLeer");
            Context.Database.AddInParameter(command, "@ConsultoraId", DbType.Int64, ConsultoraId);
            Context.Database.AddInParameter(command, "@ShowCDR", DbType.Boolean, indicadorBloqueoCDR == 0);
            Context.Database.AddInParameter(command, "@ShowPayOnline", DbType.Boolean, tienePagoEnLinea);
            object obj = Context.ExecuteScalar(command);
            int cantidad = Convert.ToInt32(obj);
            return cantidad;
        }

        public IDataReader GetNotificacionesConsultoraDetalle(long ValAutomaticaPROLLogId, int TipoOrigen)
        {
            DbCommand command = Context.Database.GetStoredProcCommand("dbo.GetNotificacionesConsultoraDetalle");
            Context.Database.AddInParameter(command, "@ValAutomaticaPROLLogId", DbType.Int64, ValAutomaticaPROLLogId);
            Context.Database.AddInParameter(command, "@TipoOrigen", DbType.Int32, TipoOrigen);

            return Context.ExecuteReader(command);
        }

        public IDataReader GetNotificacionesConsultoraDetallePedido(long ValAutomaticaPROLLogId, int TipoOrigen)
        {
            DbCommand command = Context.Database.GetStoredProcCommand("dbo.GetPedidoWebCorreoPROL");
            Context.Database.AddInParameter(command, "@ValAutomaticaPROLLogId", DbType.Int64, ValAutomaticaPROLLogId);
            Context.Database.AddInParameter(command, "@TipoOrigen", DbType.Int32, TipoOrigen);
            return Context.ExecuteReader(command);
        }

        public void UpdNotificacionesConsultoraVisualizacion(long ValAutomaticaPROLLogId, int TipoOrigen)
        {
            DbCommand command = Context.Database.GetStoredProcCommand("dbo.UpdNotificacionesConsultoraVisualizacion");
            Context.Database.AddInParameter(command, "@ValAutomaticaPROLLogId", DbType.Int64, ValAutomaticaPROLLogId);
            Context.Database.AddInParameter(command, "@TipoOrigen", DbType.Int32, TipoOrigen);
            Context.ExecuteNonQuery(command);
        }
        
        public void UpdNotificacionSolicitudClienteVisualizacion(long SolicitudClienteId)
        {
            DbCommand command = Context.Database.GetStoredProcCommand("dbo.UpdNotificacionSolicitudClienteVisualizacion");
            Context.Database.AddInParameter(command, "@SolicitudClienteId", DbType.Int64, SolicitudClienteId);
            Context.ExecuteNonQuery(command);
        }
        
        public IDataReader GetValidacionStockProductos(long ConsultoraId, long ValAutomaticaPROLLogId)
        {
            DbCommand command = Context.Database.GetStoredProcCommand("GetValidacionStockProductos");
            Context.Database.AddInParameter(command, "@ConsultoraId", DbType.Int64, ConsultoraId);
            Context.Database.AddInParameter(command, "@ValidacionStockProlId", DbType.Int64, ValAutomaticaPROLLogId);
            return Context.ExecuteReader(command);
        }

        public String GetFechaPromesaCronogramaByCampania(int CampaniaId, string CodigoConsultora, DateTime Fechafact)
        {
            DbCommand command = Context.Database.GetStoredProcCommand("GetFechaPromesaCronogramaByCampania");
            Context.Database.AddInParameter(command, "@CampaniaId", DbType.Int32, CampaniaId);
            Context.Database.AddInParameter(command, "@CodigoConsultora", DbType.AnsiString, CodigoConsultora);
            Context.Database.AddInParameter(command, "@Fechafact", DbType.Date, Fechafact);
            var result = Convert.ToString(Context.ExecuteScalar(command));

            return result;
        }
    }
}
