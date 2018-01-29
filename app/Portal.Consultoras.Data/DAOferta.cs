using Portal.Consultoras.Entities;
using System.Data;
using System.Data.Common;

namespace Portal.Consultoras.Data
{
    public class DAOferta : DataAccess
    {
        public DAOferta(int paisID)
            : base(paisID, EDbSource.Portal)
        {
        }

        public IDataReader GetOferta(BEOferta entidad)
        {
                using (DbCommand command = Context.Database.GetStoredProcCommand("dbo.ListarOferta"))
                {
                    Context.Database.AddInParameter(command, "@TipoEstrategiaID", DbType.Int32, entidad.TipoEstrategiaID);
                    return Context.ExecuteReader(command);
                }
            }

        public int Insert(BEOferta entidad)
        {
                int result;
                using (DbCommand command = Context.Database.GetStoredProcCommand("dbo.InsertarOferta"))
                {
                    Context.Database.AddInParameter(command, "@OfertaID", DbType.Int32, entidad.OfertaID);
                    Context.Database.AddInParameter(command, "@CodigoOferta", DbType.String, entidad.CodigoOferta);
                    Context.Database.AddInParameter(command, "@DescripcionOferta", DbType.String, entidad.DescripcionOferta);
                    Context.Database.AddInParameter(command, "@UsuarioRegistro", DbType.String, entidad.UsuarioRegistro);
                    Context.Database.AddInParameter(command, "@UsuarioModificacion", DbType.String, entidad.UsuarioModificacion);
                    Context.Database.AddInParameter(command, "@CodigoPrograma", DbType.String, entidad.CodigoPrograma);
                    result = Context.ExecuteNonQuery(command);
                }
                return result;
            }

        public int Delete(BEOferta entidad)
        {
                int result;
                using (DbCommand command = Context.Database.GetStoredProcCommand("dbo.EliminarOferta"))
                {
                    Context.Database.AddInParameter(command, "@OfertaID", DbType.Int32, entidad.OfertaID);
                    result = Context.ExecuteNonQuery(command);
                }
                return result;
            }

    }
}
