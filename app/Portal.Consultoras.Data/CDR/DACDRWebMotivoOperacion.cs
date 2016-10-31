﻿using Portal.Consultoras.Entities.CDR;
using System;
using System.Data;
using System.Data.Common;

namespace Portal.Consultoras.Data.CDR
{
    public class DACDRWebMotivoOperacion: DataAccess
    {
        public DACDRWebMotivoOperacion(int paisID)
            : base(paisID, EDbSource.Portal)
        {

        }

        public int InsCDRWebMotivoOperacion(BECDRWebMotivoOperacion entity)
        {
            DbCommand command = Context.Database.GetStoredProcCommand("dbo.InsCDRWebMotivoOperacion");
            Context.Database.AddInParameter(command, "OperacionCDRID", DbType.Int32, entity.OperacionCDRID);
            Context.Database.AddInParameter(command, "MotivoCDRID", DbType.Int32, entity.MotivoCDRID);
            Context.Database.AddInParameter(command, "Prioridad", DbType.Int32, entity.Prioridad);
            Context.Database.AddInParameter(command, "Estado", DbType.Int32, entity.Estado);
            Context.Database.AddInParameter(command, "RetornoID", DbType.Int32, 10);

            Context.ExecuteNonQuery(command);

            return Convert.ToInt32(command.Parameters["@RetornoID"].Value);
        }

        public int DelCDRWebMotivoOperacion(BECDRWebMotivoOperacion entity)
        {
            DbCommand command = Context.Database.GetStoredProcCommand("dbo.DelCDRWebMotivoOperacion");
            Context.Database.AddInParameter(command, "OperacionCDRID", DbType.Int32, entity.OperacionCDRID);
            Context.Database.AddInParameter(command, "MotivoCDRID", DbType.Int32, entity.MotivoCDRID);
            Context.Database.AddInParameter(command, "RetornoID", DbType.Int32, 10);

            Context.ExecuteNonQuery(command);

            return Convert.ToInt32(command.Parameters["@RetornoID"].Value);
        }

        public IDataReader GetCDRWebMotivoOperacion(BECDRWebMotivoOperacion entity)
        {
            DbCommand command = Context.Database.GetStoredProcCommand("dbo.GetCDRWebMotivoOperacion");
            Context.Database.AddInParameter(command, "OperacionCDRID", DbType.Int32, entity.OperacionCDRID);
            Context.Database.AddInParameter(command, "MotivoCDRID", DbType.Int32, entity.MotivoCDRID);

            return Context.ExecuteReader(command);
        }
    }
}
