using Portal.Consultoras.Entities.CDR;
using System;
using System.Data;
using System.Data.Common;

namespace Portal.Consultoras.Data.CDR
{
    public class DACDRWebDescripcion : DataAccess
    {
        public DACDRWebDescripcion(int paisID)
            : base(paisID, EDbSource.Portal)
        {

        }

        public int InsCDRWebDescripcion(BECDRWebDescripcion entity)
        {
            DbCommand command = Context.Database.GetStoredProcCommand("dbo.InsCDRWebDescripcion");
            Context.Database.AddInParameter(command, "CDRWebDescripcionID", DbType.Int32, entity.CDRWebDescripcionID);
            Context.Database.AddInParameter(command, "CodigoSSIC", DbType.Int32, entity.CodigoSSIC);
            Context.Database.AddInParameter(command, "Tipo", DbType.Int32, entity.Tipo);
            Context.Database.AddInParameter(command, "Descripcion", DbType.Int32, entity.Descripcion);
            Context.Database.AddInParameter(command, "RetornoID", DbType.Int32, 10);

            Context.ExecuteNonQuery(command);

            return Convert.ToInt32(command.Parameters["@RetornoID"].Value);
        }

        public int DelCDRWebDescripcion(BECDRWebDescripcion entity)
        {
            DbCommand command = Context.Database.GetStoredProcCommand("dbo.DelCDRWebDescripcion");
            Context.Database.AddInParameter(command, "CDRWebDescripcionID", DbType.Int32, entity.CDRWebDescripcionID);
            Context.Database.AddInParameter(command, "RetornoID", DbType.Int32, 10);

            Context.ExecuteNonQuery(command);

            return Convert.ToInt32(command.Parameters["@RetornoID"].Value);
        }

        public IDataReader GetCDRWebDescripcion(BECDRWebDescripcion entity)
        {
            DbCommand command = Context.Database.GetStoredProcCommand("dbo.GetCDRWebDescripcion");
            Context.Database.AddInParameter(command, "CDRWebDescripcionID", DbType.Int32, entity.CDRWebDescripcionID);
            Context.Database.AddInParameter(command, "CodigoSSIC", DbType.Int32, entity.CodigoSSIC);
            Context.Database.AddInParameter(command, "Tipo", DbType.Int32, entity.Tipo);

            return Context.ExecuteReader(command);
        }
    }
}