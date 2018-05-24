using Portal.Consultoras.Entities;
using System;
using System.Data;
using System.Data.Common;

namespace Portal.Consultoras.Data
{
    public class DARol : DataAccess
    {
        public DARol(int paisID)
            : base(paisID, EDbSource.Portal)
        {

        }

        public int InsRol(BERol rol)
        {
            DbCommand command = Context.Database.GetStoredProcCommand("dbo.InsRol");
            Context.Database.AddInParameter(command, "@Descripcion", DbType.AnsiString, rol.Descripcion);
            Context.Database.AddInParameter(command, "@Sistema", DbType.Boolean, rol.Sistema);

            return Context.ExecuteNonQuery(command);
        }

        public int UpdRol(BERol rol)
        {
            DbCommand command = Context.Database.GetStoredProcCommand("dbo.UpdRol");
            Context.Database.AddInParameter(command, "@RolID", DbType.Int32, rol.RolID);
            Context.Database.AddInParameter(command, "@Descripcion", DbType.AnsiString, rol.Descripcion);

            return Context.ExecuteNonQuery(command);
        }

        public int InsUsuarioRol(BEUsuarioRol BEUsuarioRol)
        {
            DbCommand command = Context.Database.GetStoredProcCommand("dbo.InsUsuarioRol");
            Context.Database.AddInParameter(command, "@CodigoUsuario", DbType.AnsiString, BEUsuarioRol.CodigoUsuario);
            Context.Database.AddInParameter(command, "@RolID", DbType.Int32, BEUsuarioRol.RolID);

            return Convert.ToInt32(Context.ExecuteScalar(command));
        }

        public int DelRol(int RolID)
        {
            DbCommand command = Context.Database.GetStoredProcCommand("dbo.DelRol");
            Context.Database.AddInParameter(command, "@RolID", DbType.Int32, RolID);

            return Convert.ToInt16(Context.ExecuteScalar(command));
        }

        public int VerifyRolByDescripcion(BERol rol)
        {
            DbCommand command = Context.Database.GetStoredProcCommand("dbo.VerifyRolByDescripcion");
            Context.Database.AddInParameter(command, "@RolID", DbType.Int32, rol.RolID);
            Context.Database.AddInParameter(command, "@Descripcion", DbType.AnsiString, rol.Descripcion);

            return Convert.ToInt32(Context.ExecuteScalar(command));
        }

        public IDataReader GetAllRols()
        {
            DbCommand command = Context.Database.GetStoredProcCommand("dbo.GetRoles");

            return Context.ExecuteReader(command);
        }

        public IDataReader GetAllRolsBySistema(int sistema)
        {
            DbCommand command = Context.Database.GetStoredProcCommand("dbo.GetRolesBySistema");
            Context.Database.AddInParameter(command, "@Sistema", DbType.Int32, sistema);

            return Context.ExecuteReader(command);
        }

    }
}