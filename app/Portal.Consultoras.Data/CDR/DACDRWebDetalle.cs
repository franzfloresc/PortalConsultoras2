using Portal.Consultoras.Entities.CDR;
using System;
using System.Data;
using System.Data.Common;

namespace Portal.Consultoras.Data.CDR
{
    public class DACDRWebDetalle : DataAccess
    {
        public DACDRWebDetalle(int paisID)
            : base(paisID, EDbSource.Portal)
        {

        }

        public int InsCDRWebDetalle(BECDRWebDetalle entity)
        {
            DbCommand command = Context.Database.GetStoredProcCommand("dbo.InsCDRWebDetalle");
            Context.Database.AddInParameter(command, "CDRWebDetalleID", DbType.Int32, entity.CDRWebDetalleID);
            Context.Database.AddInParameter(command, "CDRWebID", DbType.Int32, entity.CDRWebID);
            Context.Database.AddInParameter(command, "CodigoOperacion", DbType.String, entity.CodigoOperacion);
            Context.Database.AddInParameter(command, "CodigoReclamo", DbType.String, entity.CodigoReclamo);
            Context.Database.AddInParameter(command, "CUV", DbType.String, entity.CUV);
            Context.Database.AddInParameter(command, "Cantidad", DbType.Int32, entity.Cantidad);
            Context.Database.AddInParameter(command, "CUV2", DbType.String, entity.CUV2);
            Context.Database.AddInParameter(command, "Cantidad2", DbType.Int32, entity.Cantidad2);
            Context.Database.AddOutParameter(command, "RetornoID", DbType.Int32, 10);

            Context.ExecuteNonQuery(command);

            return Convert.ToInt32(command.Parameters["@RetornoID"].Value);
        }

        public int DelCDRWebDetalle(BECDRWebDetalle entity)
        {
            DbCommand command = Context.Database.GetStoredProcCommand("dbo.DelCDRWebDetalle");
            Context.Database.AddInParameter(command, "CDRWebDetalleID", DbType.Int32, entity.CDRWebDetalleID);

            var result = Context.ExecuteNonQuery(command);

            return result;
        }

        public IDataReader GetCDRWebDetalle(BECDRWebDetalle entity, int pedidoId)
        {
            DbCommand command = Context.Database.GetStoredProcCommand("dbo.GetCDRWebDetalle");
            Context.Database.AddInParameter(command, "CDRWebID", DbType.Int32, entity.CDRWebID);
            Context.Database.AddInParameter(command, "PedidoID", DbType.String, pedidoId);

            return Context.ExecuteReader(command);
        }


        public IDataReader GetCDRWebDetalleLog(BELogCDRWeb entity)
        {
            DbCommand command = Context.Database.GetStoredProcCommand("dbo.GetCDRWebDetalleLog");
            Context.Database.AddInParameter(command, "LogCDRWebID", DbType.Int32, entity.LogCDRWebId);

            return Context.ExecuteReader(command);
        }

        public int UpdCdrWebDetalleCantidadObservado(BECDRWebDetalle entity)
        {
            DbCommand command = Context.Database.GetStoredProcCommand("dbo.UpdCdrWebDetalleCantidadObservado");
            Context.Database.AddInParameter(command, "CDRWebDetalleID", DbType.Int32, entity.CDRWebDetalleID);
            Context.Database.AddInParameter(command, "Cantidad", DbType.Int32, entity.Cantidad);

            int result = Context.ExecuteNonQuery(command);

            return result;
        }
        //HD-3412 EINCA
        public int ValCUVEnProcesoReclamo(int pedidoId, string cuv)
        {
            DbCommand command = Context.Database.GetStoredProcCommand("dbo.ValidarCUVEnProcesoReclamo");
            Context.Database.AddInParameter(command, "@PedidoID", DbType.Int32, pedidoId);
            Context.Database.AddInParameter(command, "@CUV", DbType.AnsiString, cuv);
            Context.Database.AddOutParameter(command, "@Resultado", DbType.Boolean, 1);
            Context.ExecuteNonQuery(command);
            return Convert.ToInt32(command.Parameters["@Resultado"].Value);
        }
    }
}