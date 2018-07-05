using Portal.Consultoras.Entities;
using System.Data;
using System.Data.Common;

namespace Portal.Consultoras.Data
{
    public class DATipoEstrategia : DataAccess
    {
        public DATipoEstrategia(int paisID)
            : base(paisID, EDbSource.Portal)
        {
        }

        public IDataReader GetTipoEstrategia(BETipoEstrategia entidad)
        {
            using (var command = Context.Database.GetStoredProcCommand("dbo.ListarTipoEstrategia_SB2"))
            {
                Context.Database.AddInParameter(command, "@TipoEstrategiaID", DbType.Int32, entidad.TipoEstrategiaID);
                return Context.ExecuteReader(command);
            }
        }

        public int Insert(BETipoEstrategia entidad)
        {
            int result;
            using (DbCommand command = Context.Database.GetStoredProcCommand("dbo.InsertarTipoEstrategia_SB2"))
            {
                Context.Database.AddInParameter(command, "@TipoEstrategiaID", DbType.Int32, entidad.TipoEstrategiaID);
                Context.Database.AddInParameter(command, "@DescripcionEstrategia", DbType.String, entidad.DescripcionEstrategia);
                Context.Database.AddInParameter(command, "@ImagenEstrategia", DbType.String, entidad.ImagenEstrategia);
                Context.Database.AddInParameter(command, "@Orden", DbType.Int32, entidad.Orden);
                Context.Database.AddInParameter(command, "@FlagActivo", DbType.Int32, entidad.FlagActivo);
                Context.Database.AddInParameter(command, "@UsuarioRegistro", DbType.String, entidad.UsuarioRegistro);
                Context.Database.AddInParameter(command, "@UsuarioModificacion", DbType.String, entidad.UsuarioModificacion);
                Context.Database.AddInParameter(command, "@OfertaID", DbType.String, entidad.OfertaID);
                Context.Database.AddInParameter(command, "@FlagNueva", DbType.String, entidad.FlagNueva);
                Context.Database.AddInParameter(command, "@FlagRecoPerfil", DbType.String, entidad.FlagRecoPerfil);
                Context.Database.AddInParameter(command, "@FlagRecoProduc", DbType.String, entidad.FlagRecoProduc);
                Context.Database.AddInParameter(command, "@CodigoPrograma", DbType.String, entidad.CodigoPrograma);
                Context.Database.AddInParameter(command, "@FlagMostrarImg", DbType.Int32, entidad.FlagMostrarImg);
                Context.Database.AddInParameter(command, "@MostrarImgOfertaIndependiente", DbType.Boolean, entidad.MostrarImgOfertaIndependiente);
                Context.Database.AddInParameter(command, "@ImagenOfertaIndependiente", DbType.String, entidad.ImagenOfertaIndependiente);
                Context.Database.AddInParameter(command, "@Codigo", DbType.String, entidad.Codigo);
                Context.Database.AddInParameter(command, "@FlagValidarImagen", DbType.Int32, entidad.FlagValidarImagen);
                Context.Database.AddInParameter(command, "@PesoMaximoImagen", DbType.Int32, entidad.PesoMaximoImagen);
                result = Context.ExecuteNonQuery(command);
            }
            return result;
        }

        public int Delete(BETipoEstrategia entidad)
        {
            int result;
            using (DbCommand command = Context.Database.GetStoredProcCommand("dbo.EliminarTipoEstrategia"))
            {
                Context.Database.AddInParameter(command, "@TipoEstrategiaID", DbType.Int32, entidad.TipoEstrategiaID);
                result = Context.ExecuteNonQuery(command);
            }
            return result;
        }
    }
}