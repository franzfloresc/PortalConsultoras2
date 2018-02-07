using System;
using System.Data;
using System.Data.Common;

namespace Portal.Consultoras.Data
{
    public class DAUsuarioOP : DataAccess
    {
        public DAUsuarioOP(int paisID)
            : base(paisID, EDbSource.OnPremise)
        {

        }

        public int UpdActualizarDatos(string CodigoUsuario, string Email, string Celular, string Telefono)
        {
            DbCommand command = Context.Database.GetStoredProcCommand("dbo.UpdActualizarDatos");
            Context.Database.AddInParameter(command, "@CodigoUsuario", DbType.AnsiString, CodigoUsuario);
            Context.Database.AddInParameter(command, "@Email", DbType.AnsiString, Email);
            Context.Database.AddInParameter(command, "@Celular", DbType.AnsiString, Celular);
            Context.Database.AddInParameter(command, "@Telefono", DbType.AnsiString, Telefono);

            return Convert.ToInt32(Context.ExecuteScalar(command));
        }
    }
}
