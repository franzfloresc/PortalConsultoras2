using Portal.Consultoras.Entities;
using System;
using System.Data;
using System.Data.Common;
namespace Portal.Consultoras.Data
{
    public class DAConsultoraFicticia : DataAccess
    {
        public DAConsultoraFicticia(int paisID)
            : base(paisID, EDbSource.Portal)
        {

        }

        public int InsConsultoraFicticia(BEConsultoraFicticia consultora)
        {
            DbCommand command = Context.Database.GetStoredProcCommand("dbo.InsConsultoraFicticia");
            Context.Database.AddInParameter(command, "@PaisID", DbType.AnsiString, consultora.PaisID);
            Context.Database.AddInParameter(command, "@CodigoUsuario", DbType.AnsiString, consultora.CodigoUsuario);
            Context.Database.AddInParameter(command, "@CodigoConsultora", DbType.AnsiString, consultora.CodigoConsultora);
            Context.Database.AddInParameter(command, "@Clave", DbType.AnsiString, consultora.ActualizarClave);
            int result = Convert.ToInt32(Context.ExecuteScalar(command));
            return result;
        }

        public IDataReader GetConsultoraFicticia(int PaisID, string CodigoUsuario, string NombreCompleto)
        {
            DbCommand command = Context.Database.GetStoredProcCommand("dbo.GetConsultoraFicticia");
            Context.Database.AddInParameter(command, "@PaisID", DbType.AnsiString, PaisID);
            Context.Database.AddInParameter(command, "@CodigoUsuario", DbType.AnsiString, CodigoUsuario);
            Context.Database.AddInParameter(command, "@NombreCompleto", DbType.AnsiString, NombreCompleto);
            return Context.ExecuteReader(command);
        }

        public int DelConsultoraFicticia(string CodigoUsuario)
        {
            DbCommand command = Context.Database.GetStoredProcCommand("dbo.DelConsultoraFicticia");
            Context.Database.AddInParameter(command, "@CodigoUsuario", DbType.AnsiString, CodigoUsuario);

            int result = Context.ExecuteNonQuery(command);
            return result;
        }

        public int UpdConsultoraFicticia(string CodigoUsuario, string CodigoConsultora, Int64 ConsultoraID, string Clave)
        {
            DbCommand command = Context.Database.GetStoredProcCommand("dbo.UpdConsultoraFicticia");
            Context.Database.AddInParameter(command, "@CodigoUsuario", DbType.AnsiString, CodigoUsuario);
            Context.Database.AddInParameter(command, "@CodigoConsultora", DbType.AnsiString, CodigoConsultora);
            Context.Database.AddInParameter(command, "@ConsultoraID", DbType.AnsiString, ConsultoraID);
            Context.Database.AddInParameter(command, "@Clave", DbType.AnsiString, Clave);

            int result = Context.ExecuteNonQuery(command);
            return result;
        }

        public string GetCodigoConsultoraAsociada(string CodigoUsuario)
        {
            DbCommand command = Context.Database.GetStoredProcCommand("dbo.GetCodigoConsultoraAsociada");
            Context.Database.AddInParameter(command, "@CodigoUsuario", DbType.AnsiString, CodigoUsuario);

            string result = Context.ExecuteScalar(command).ToString();
            return result;
        }

        public string GetNombreConsultoraAsociada(string CodigoUsuario)
        {
            DbCommand command = Context.Database.GetStoredProcCommand("dbo.GetNombreConsultoraAsociada");
            Context.Database.AddInParameter(command, "@CodigoUsuario", DbType.AnsiString, CodigoUsuario);

            string result = Context.ExecuteScalar(command).ToString();
            return result;
        }
    }
}