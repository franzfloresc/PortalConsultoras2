using System.Data;

namespace Portal.Consultoras.Data
{
    public class DARolPermiso : DataAccess
    {
        public DARolPermiso()
        {

        }
        public DARolPermiso(int paisId): base(paisId, EDbSource.Portal)
        {

        }
        public int Insertar(int rolId,int permisoId,bool activo,bool mostrar)
        {
            int result;
            using (var storedProcCommand = Context.Database.GetStoredProcCommand("InsertRolPermiso"))
            {
                Context.Database.AddInParameter(storedProcCommand, "@RolID", DbType.Int16, rolId);
                Context.Database.AddInParameter(storedProcCommand, "@PermisoID", DbType.Int16, permisoId);
                Context.Database.AddInParameter(storedProcCommand, "@Activo", DbType.Boolean, activo);
                Context.Database.AddInParameter(storedProcCommand, "@Mostrar", DbType.Boolean, mostrar);
                result = Context.Database.ExecuteNonQuery(storedProcCommand);
            }
            return result;
        }
        public int EliminarByIdPermiso(int permisoId,int rolId)
        {
            int result;
            using (var storedProcCommand = Context.Database.GetStoredProcCommand("DeleteRolPermiso"))
            {
                Context.Database.AddInParameter(storedProcCommand, "@PermisoID", DbType.Int16, permisoId);
                Context.Database.AddInParameter(storedProcCommand, "@RolID", DbType.Int16, rolId);
                result= Context.Database.ExecuteNonQuery(storedProcCommand);
            }
            return result;
        }
    }
}
