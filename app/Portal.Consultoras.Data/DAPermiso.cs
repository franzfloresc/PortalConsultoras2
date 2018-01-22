using Portal.Consultoras.Entities;
using System;
using System.Data;
using System.Data.Common;

namespace Portal.Consultoras.Data
{
    public class DAPermiso : DataAccess
    {
        public DAPermiso(int paisID)
            : base(paisID, EDbSource.Portal)
        {

        }

        public IDataReader GetPermisosByRol(int RolID)
        {
            DbCommand command = Context.Database.GetStoredProcCommand("dbo.GetPermisosByRol_SB2");
            Context.Database.AddInParameter(command, "@RolID", DbType.Int32, RolID);

            return Context.ExecuteReader(command);
        }

        public IDataReader GetAllPermisosCheckByRol(int RolID)
        {
            DbCommand command = Context.Database.GetStoredProcCommand("dbo.GetPermisosCheckByRol");
            Context.Database.AddInParameter(command, "@RolID", DbType.Int32, RolID);

            return Context.ExecuteReader(command);
        }

        public int InsPermisosByRolMasiv(int RolID, string Permisos)
        {
            DbCommand command = Context.Database.GetStoredProcCommand("dbo.InsPermisosByRolMasiv");
            Context.Database.AddInParameter(command, "@Permisos", DbType.AnsiString, Permisos);
            Context.Database.AddInParameter(command, "@RolID", DbType.Int32, RolID);

            return Context.ExecuteNonQuery(command);
        }

        public int Insert(BEPermiso entidad)
        {
            DbCommand command = Context.Database.GetStoredProcCommand("dbo.InsPermisos");
            Context.Database.AddInParameter(command, "@Descripcion", DbType.AnsiString, entidad.Descripcion);
            Context.Database.AddInParameter(command, "@IdPadre", DbType.Int16, entidad.IdPadre);
            Context.Database.AddInParameter(command, "@OrdenItem", DbType.Int16, entidad.OrdenItem);
            Context.Database.AddInParameter(command, "@UrlItem", DbType.AnsiString, entidad.UrlItem);
            Context.Database.AddInParameter(command, "@PaginaNueva", DbType.Byte, entidad.PaginaNueva);
            Context.Database.AddInParameter(command, "@Posicion", DbType.AnsiString, entidad.Posicion);
            var tempResult = Context.ExecuteScalar(command);
            return tempResult == null ? 0 : Convert.ToInt32(tempResult);
        }

        public int Update(BEPermiso entidad)
        {
            DbCommand command = Context.Database.GetStoredProcCommand("dbo.UpdPermisos");
            Context.Database.AddInParameter(command, "@PermisoID", DbType.Int16, entidad.PermisoID);
            Context.Database.AddInParameter(command, "@Descripcion", DbType.AnsiString, entidad.Descripcion);
            Context.Database.AddInParameter(command, "@IdPadre", DbType.Int16, entidad.IdPadre);
            Context.Database.AddInParameter(command, "@OrdenItem", DbType.Int16, entidad.OrdenItem);
            Context.Database.AddInParameter(command, "@UrlItem", DbType.AnsiString, entidad.UrlItem);
            Context.Database.AddInParameter(command, "@PaginaNueva", DbType.Byte, entidad.PaginaNueva);
            Context.Database.AddInParameter(command, "@Posicion", DbType.AnsiString, entidad.Posicion);
            return Context.ExecuteNonQuery(command);
        }

        public int Delete(int permisoID)
        {
            DbCommand command = Context.Database.GetStoredProcCommand("dbo.DelPermisos");
            Context.Database.AddInParameter(command, "@PermisoID", DbType.Int16, permisoID);

            return Context.ExecuteNonQuery(command);
        }

        public IDataReader GetPermisosByRolConsulta(int rolID, string posicion)
        {
            DbCommand command = Context.Database.GetStoredProcCommand("dbo.GetPermisosByRolConsulta");
            Context.Database.AddInParameter(command, "@RolID", DbType.Int32, rolID);
            Context.Database.AddInParameter(command, "@Posicion", DbType.String, posicion);

            return Context.ExecuteReader(command);
        }

        public IDataReader GetPermisosPadreBySistema(int sistema)
        {
            DbCommand command = Context.Database.GetStoredProcCommand("dbo.GetPermisosPadreBySistema");
            Context.Database.AddInParameter(command, "@Sistema", DbType.Int32, sistema);

            return Context.ExecuteReader(command);
        }

    }
}
