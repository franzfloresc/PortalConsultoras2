using Portal.Consultoras.Entities;
using System.Data;
using System.Data.Common;

namespace Portal.Consultoras.Data
{
    public class DAEtiqueta : DataAccess
    {

        public DAEtiqueta(int paisID)
            : base(paisID, EDbSource.Portal)
        {
        }

        public IDataReader GetEtiquetas(BEEtiqueta entidad)
        {
            using (DbCommand command = Context.Database.GetStoredProcCommand("dbo.ListarEtiquetas"))
            {
                Context.Database.AddInParameter(command, "@Estado", DbType.Int32, entidad.Estado);
                return Context.ExecuteReader(command);
            }
        }

        public int Insert(BEEtiqueta entidad)
        {
            int result;
            using (DbCommand command = Context.Database.GetStoredProcCommand("dbo.RegistrarEtiqueta"))
            {
                Context.Database.AddInParameter(command, "@EtiquetaID", DbType.Int32, entidad.EtiquetaID);
                Context.Database.AddInParameter(command, "@Descripcion", DbType.String, entidad.Descripcion);
                Context.Database.AddInParameter(command, "@UsuarioCreacion", DbType.String, entidad.UsuarioCreacion);
                Context.Database.AddInParameter(command, "@UsuarioModificacion", DbType.String, entidad.UsuarioModificacion);
                Context.Database.AddInParameter(command, "@Estado", DbType.Int32, entidad.Estado);
                result = Context.ExecuteNonQuery(command);
            }
            return result;
        }

    }
}