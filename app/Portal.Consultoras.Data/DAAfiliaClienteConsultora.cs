using System;
using System.Collections.Generic;
using System.Data;
using System.Data.Common;
using System.Data.SqlClient;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Portal.Consultoras.Data
{
    //R2319 - JLCS
    public class DAAfiliaClienteConsultora : DataAccess
    {
        public DAAfiliaClienteConsultora(int paisID)
            : base(paisID, EDbSource.Portal)
        {

        }

        //R2319 - JLCS
        public IDataReader GetAfiliaClienteConsultoraByConsultora(string ConsultoraID)
        {
            DbCommand command = Context.Database.GetStoredProcCommand("dbo.GetAfiliaClienteConsultoraByConsultora");
            Context.Database.AddInParameter(command, "@CodigoConsultora", DbType.AnsiString, ConsultoraID);

            return Context.ExecuteReader(command);
        }

        //R2319 - JLCS
        public int InsAfiliaClienteConsultora(long ConsultoraID)
        {
            var command = new SqlCommand("dbo.InsAfiliaClienteConsultora");
            command.CommandType = CommandType.StoredProcedure;

            SqlParameter parameter;

            parameter = new SqlParameter("@ConsultoraID", SqlDbType.BigInt);
            parameter.Value = ConsultoraID;
            command.Parameters.Add(parameter);

            return Context.ExecuteNonQuery(command);
        }

        //R2319 - JLCS
        public int UpdAfiliaClienteConsultora(long ConsultoraID, bool EsAfiliacion)
        {
            DbCommand command = Context.Database.GetStoredProcCommand("dbo.UpdAfiliaClienteConsultora");
            Context.Database.AddInParameter(command, "@ConsultoraID", DbType.Int64, ConsultoraID);
            Context.Database.AddInParameter(command, "@Afiliacion", DbType.Boolean, EsAfiliacion);

            return Context.ExecuteNonQuery(command);
        }

        public int UpdAfiliaClienteConsultora(long ConsultoraID, bool EsAfiliacion, int MotivoDesafiliacionID)
        {
            DbCommand command = Context.Database.GetStoredProcCommand("dbo.UpdAfiliaClienteConsultora");
            Context.Database.AddInParameter(command, "@ConsultoraID", DbType.Int64, ConsultoraID);
            Context.Database.AddInParameter(command, "@Afiliacion", DbType.Boolean, EsAfiliacion);
            Context.Database.AddInParameter(command, "@MotivoDesafiliacionID", DbType.Int32, MotivoDesafiliacionID);

            return Context.ExecuteNonQuery(command);
        }
    }
}
