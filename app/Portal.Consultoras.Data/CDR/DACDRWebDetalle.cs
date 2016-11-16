﻿using Portal.Consultoras.Entities.CDR;
using System;
using System.Data;
using System.Data.Common;

namespace Portal.Consultoras.Data.CDR
{
    public class DACDRWebDetalle  : DataAccess
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
            //Context.Database.AddInParameter(command, "FechaRegistro", DbType.DateTime, entity.FechaRegistro);
            //Context.Database.AddInParameter(command, "Estado", DbType.Int32, entity.Estado);
            //Context.Database.AddInParameter(command, "MotivoRechazo", DbType.String, entity.MotivoRechazo);
            //Context.Database.AddInParameter(command, "Observacion", DbType.String, entity.Observacion);
            Context.Database.AddOutParameter(command, "RetornoID", DbType.Int32, 10);

            Context.ExecuteNonQuery(command);

            return Convert.ToInt32(command.Parameters["@RetornoID"].Value);
        }

        public int DelCDRWebDetalle(BECDRWebDetalle entity)
        {
            int result;

            DbCommand command = Context.Database.GetStoredProcCommand("dbo.DelCDRWebDetalle");
            Context.Database.AddInParameter(command, "CDRWebDetalleID", DbType.Int32, entity.CDRWebDetalleID);

            result = Context.ExecuteNonQuery(command);

            return result;
        }

        public IDataReader GetCDRWebDetalle(BECDRWebDetalle entity, int pedidoId)
        {
            DbCommand command = Context.Database.GetStoredProcCommand("dbo.GetCDRWebDetalle");
            Context.Database.AddInParameter(command, "CDRWebID", DbType.Int32, entity.CDRWebID);
            Context.Database.AddInParameter(command, "PedidoID", DbType.String, pedidoId);

            return Context.ExecuteReader(command);
        }
    }
}
