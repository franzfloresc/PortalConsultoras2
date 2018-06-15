using Portal.Consultoras.Entities;
using System.Data;
using System.Data.Common;

namespace Portal.Consultoras.Data
{
    public class DAProductoSugerido : DataAccess
    {
        public DAProductoSugerido(int paisID)
            : base(paisID, EDbSource.Portal)
        {

        }

        public IDataReader GetPaginateProductoSugerido(int campaniaID, string cuvAgotado, string cuvSugerido)
        {
            DbCommand command = Context.Database.GetStoredProcCommand("dbo.GetPaginateProductoSugerido_SB2");
            Context.Database.AddInParameter(command, "@CampaniaID", DbType.Int32, campaniaID);
            Context.Database.AddInParameter(command, "@CuvAgotado", DbType.String, cuvAgotado);
            Context.Database.AddInParameter(command, "@CuvSugerido", DbType.String, cuvSugerido);

            return Context.ExecuteReader(command);
        }

        public string InsProductoSugerido(BEProductoSugerido entity)
        {
            DbCommand command = Context.Database.GetStoredProcCommand("dbo.InsProductoSugerido_SB2");
            Context.Database.AddOutParameter(command, "Return", DbType.String, 10000);
            Context.Database.AddInParameter(command, "ProductoSugeridoID", DbType.Int32, entity.ProductoSugeridoID);
            Context.Database.AddInParameter(command, "CampaniaID", DbType.String, entity.CampaniaID);
            Context.Database.AddInParameter(command, "CUV", DbType.String, entity.CUV);
            Context.Database.AddInParameter(command, "CUVSugerido", DbType.String, entity.CUVSugerido);
            Context.Database.AddInParameter(command, "Orden", DbType.Int32, entity.Orden);
            Context.Database.AddInParameter(command, "ImagenProducto", DbType.String, entity.ImagenProducto);
            Context.Database.AddInParameter(command, "Estado", DbType.Int32, entity.Estado);
            Context.Database.AddInParameter(command, "UsuarioRegistro", DbType.String, entity.UsuarioRegistro);
            Context.Database.AddInParameter(command, "MostrarAgotado", DbType.Int32, entity.MostrarAgotado);

            Context.ExecuteNonQuery(command);
            var id = (string)Context.Database.GetParameterValue(command, "Return");
            return id;
        }

        public string UpdProductoSugerido(BEProductoSugerido entity)
        {
            DbCommand command = Context.Database.GetStoredProcCommand("dbo.UpdProductoSugerido_SB2");
            Context.Database.AddOutParameter(command, "Return", DbType.String, 10000);
            Context.Database.AddInParameter(command, "ProductoSugeridoID", DbType.Int32, entity.ProductoSugeridoID);
            Context.Database.AddInParameter(command, "CampaniaID", DbType.String, entity.CampaniaID);
            Context.Database.AddInParameter(command, "CUV", DbType.String, entity.CUV);
            Context.Database.AddInParameter(command, "CUVSugerido", DbType.String, entity.CUVSugerido);
            Context.Database.AddInParameter(command, "Orden", DbType.Int32, entity.Orden);
            Context.Database.AddInParameter(command, "ImagenProducto", DbType.String, entity.ImagenProducto);
            Context.Database.AddInParameter(command, "Estado", DbType.Int32, entity.Estado);
            Context.Database.AddInParameter(command, "UsuarioModificacion", DbType.String, entity.UsuarioModificacion);
            Context.Database.AddInParameter(command, "MostrarAgotado", DbType.Int32, entity.MostrarAgotado);

            Context.ExecuteNonQuery(command);
            var id = (string)Context.Database.GetParameterValue(command, "Return");
            return id;
        }

        public string DelProductoSugerido(BEProductoSugerido entity)
        {
            DbCommand command = Context.Database.GetStoredProcCommand("dbo.DelProductoSugerido_SB2");
            Context.Database.AddOutParameter(command, "Return", DbType.String, 10000);
            Context.Database.AddInParameter(command, "ProductoSugeridoID", DbType.Int32, entity.ProductoSugeridoID);
            Context.Database.AddInParameter(command, "UsuarioModificacion", DbType.AnsiString, entity.UsuarioModificacion);

            Context.ExecuteNonQuery(command);
            var id = (string)Context.Database.GetParameterValue(command, "Return");
            return id;
        }
    }
}