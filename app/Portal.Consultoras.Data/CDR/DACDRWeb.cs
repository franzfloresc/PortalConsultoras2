using Portal.Consultoras.Entities.CDR;
using System;
using System.Data;
using System.Data.Common;

namespace Portal.Consultoras.Data.CDR
{ 
    public class DACDRWeb : DataAccess
    {
        public DACDRWeb(int paisID)
            : base(paisID, EDbSource.Portal)
        {

        }

        public int InsCDRWeb(BECDRWeb entity)
        {
            DbCommand command = Context.Database.GetStoredProcCommand("dbo.InsCDRWeb");
            Context.Database.AddInParameter(command, "CDRWebID", DbType.Int32, entity.CDRWebID);
            Context.Database.AddInParameter(command, "PedidoID", DbType.Int32, entity.PedidoID);
            Context.Database.AddInParameter(command, "CampaniaID", DbType.Int32, entity.CampaniaID);
            Context.Database.AddInParameter(command, "ConsultoraID", DbType.Int32, entity.ConsultoraID);
            Context.Database.AddInParameter(command, "FechaRegistro", DbType.DateTime, entity.FechaRegistro);
            Context.Database.AddInParameter(command, "Estado", DbType.Int32, entity.Estado);
            Context.Database.AddInParameter(command, "FechaCulminado", DbType.DateTime, entity.FechaCulminado);
            Context.Database.AddInParameter(command, "Importe", DbType.Decimal, entity.Importe);
            Context.Database.AddOutParameter(command, "RetornoID", DbType.Int32, 10);

            Context.ExecuteNonQuery(command);

            return Convert.ToInt32(command.Parameters["@RetornoID"].Value);
        }

        public int DelCDRWeb(BECDRWeb entity)
        {
            DbCommand command = Context.Database.GetStoredProcCommand("dbo.DelCDRWeb");
            Context.Database.AddInParameter(command, "CDRWebID", DbType.Int32, entity.CDRWebID);
            Context.Database.AddOutParameter(command, "RetornoID", DbType.Int32, 10);

            Context.ExecuteNonQuery(command);

            return Convert.ToInt32(command.Parameters["@RetornoID"].Value);
        }

        public IDataReader GetCDRWeb(BECDRWeb entity)
        {
            DbCommand command = Context.Database.GetStoredProcCommand("dbo.GetCDRWeb");
            Context.Database.AddInParameter(command, "ConsultoraID", DbType.Int32, entity.ConsultoraID);

            return Context.ExecuteReader(command);
        }
    }
}
