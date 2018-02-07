using Portal.Consultoras.Entities;
using System.Data;
using System.Data.Common;

namespace Portal.Consultoras.Data
{
    public class DAProductoDescripcion : DataAccess
    {
        public DAProductoDescripcion(int paisID)
            : base(paisID, EDbSource.Portal)
        {

        }

        public IDataReader GetProductoDescripcionByCUVandCampania(string CUV, int CampaniaID)
        {
            DbCommand command = Context.Database.GetStoredProcCommand("dbo.GetProductoDescripcionByCUVandCampania");
            Context.Database.AddInParameter(command, "@CampaniaID", DbType.Int32, CampaniaID);
            Context.Database.AddInParameter(command, "@CUV", DbType.String, CUV);

            return Context.ExecuteReader(command);
        }

        public int UpdProductoDescripcion(BEProductoDescripcion producto, string codigoUsuario)
        {
            DbCommand command = Context.Database.GetStoredProcCommand("dbo.UpdProductoDescripcion");
            Context.Database.AddInParameter(command, "@CampaniaID", DbType.Int32, producto.CampaniaID);
            Context.Database.AddInParameter(command, "@CUV", DbType.String, producto.CUV);
            Context.Database.AddInParameter(command, "@Descripcion", DbType.String, producto.Descripcion);
            Context.Database.AddInParameter(command, "@PrecioProducto", DbType.Decimal, producto.PrecioProducto);
            Context.Database.AddInParameter(command, "@FactorRepeticion", DbType.Int16, producto.FactorRepeticion);
            Context.Database.AddInParameter(command, "@CodigoUsuario", DbType.String, codigoUsuario);
            Context.Database.AddInParameter(command, "@RegaloDescripcion", DbType.String, producto.RegaloDescripcion);
            Context.Database.AddInParameter(command, "@RegaloImagenUrl", DbType.String, producto.RegaloImagenUrl);

            return Context.ExecuteNonQuery(command);
        }

        public IDataReader GetProductosByCampaniaCuv(int anioCampania, string codigoVenta)
        {
            DbCommand command = Context.Database.GetStoredProcCommand("dbo.GetProductosByCampaniaCuv");
            Context.Database.AddInParameter(command, "@AnoCampana", DbType.Int32, anioCampania);
            Context.Database.AddInParameter(command, "@CodigoVenta", DbType.String, codigoVenta);

            return Context.ExecuteReader(command);
        }

        public IDataReader GetProductoByCampaniaCuv(int anioCampania, string codigoZona, string codigoVenta)
        {
            DbCommand command = Context.Database.GetStoredProcCommand("dbo.GetProductoByCampaniaCuv");
            Context.Database.AddInParameter(command, "@AnoCampana", DbType.Int32, anioCampania);
            Context.Database.AddInParameter(command, "@CodigoZona", DbType.String, codigoZona);
            Context.Database.AddInParameter(command, "@CodigoVenta", DbType.String, codigoVenta);

            return Context.ExecuteReader(command);
        }
    }
}
