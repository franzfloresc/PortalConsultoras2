using OpenSource.Library.DataAccess;
using Portal.Consultoras.Entities;
using System;
using System.Collections.Generic;
using System.Data;
using System.Data.Common;
using System.Data.SqlClient;

namespace Portal.Consultoras.Data
{
    public class DAProductoFaltante : DataAccess
    {
        public DAProductoFaltante(int paisID)
            : base(paisID, EDbSource.Portal)
        {

        }

        public int InsProductoFaltante(IEnumerable<BEProductoFaltante> productosFaltantes, bool FaltanteUltimoMinuto)
        {
            var productosFaltantesReader = new GenericDataReader<BEProductoFaltante>(productosFaltantes);

            var command = new SqlCommand("dbo.InsProductoFaltante");
            command.CommandType = CommandType.StoredProcedure;

            var parameter = new SqlParameter("@ProductosFaltantes", SqlDbType.Structured);
            parameter.TypeName = "dbo.ProductoFaltanteType";
            parameter.Value = productosFaltantesReader;
            command.Parameters.Add(parameter);
            var parameter2 = new SqlParameter("@FaltanteUltimoMinuto", SqlDbType.Bit);
            parameter2.Value = FaltanteUltimoMinuto;
            command.Parameters.Add(parameter2);

            return Context.ExecuteNonQuery(command);
        }

        public string InsProductoFaltanteMasivo(int paisID, IEnumerable<BEProductoFaltante> productosFaltantes, bool FaltanteUltimoMinuto)
        {
            var productosFaltantesReader = new GenericDataReader<BEProductoFaltante>(productosFaltantes);

            var command = new SqlCommand("dbo.InsProductoFaltanteMasivo");
            command.CommandType = CommandType.StoredProcedure;

            var parameter = new SqlParameter("@ProductosFaltantes", SqlDbType.Structured);
            parameter.TypeName = "dbo.ProductoFaltanteType";
            parameter.Value = productosFaltantesReader;
            command.Parameters.Add(parameter);
            var parameter2 = new SqlParameter("@PaisID", SqlDbType.Int);
            parameter2.Value = paisID;
            command.Parameters.Add(parameter2);
            var parameter3 = new SqlParameter("@FaltanteUltimoMinuto", SqlDbType.Bit);
            parameter3.Value = FaltanteUltimoMinuto;
            command.Parameters.Add(parameter3);

            return Convert.ToString(Context.ExecuteScalar(command));
        }

        public int DelProductoFaltante(BEProductoFaltante prod, out bool Deleted)
        {
            DbCommand command = Context.Database.GetStoredProcCommand("dbo.DelProductoFaltante");
            Context.Database.AddInParameter(command, "@CampaniaID", DbType.Int32, prod.CampaniaID);
            Context.Database.AddInParameter(command, "@CUV", DbType.AnsiString, prod.CUV);
            Context.Database.AddInParameter(command, "@ZonaID", DbType.Int32, prod.ZonaID);
            Context.Database.AddOutParameter(command, "@Deleted", DbType.Boolean, 1);

            int result = Context.ExecuteNonQuery(command);
            Deleted = Convert.ToBoolean(command.Parameters["@Deleted"].Value);
            return result;
        }

        public int DelProductoFaltante2(List<BEProductoFaltante> prod, out int deleted, int flag, int pais, int campania, int zona, string cuv, string e_producto, DateTime fecha)
        {
            var listTablaTempType = new List<BETablaTemType>();

            foreach (var item in prod)
            {
                var tablaTemType = new BETablaTemType();
                tablaTemType.CampaniaID = item.CampaniaID;
                tablaTemType.CUV = item.CUV;
                tablaTemType.ZonaID = item.ZonaID;

                listTablaTempType.Add(tablaTemType);
            }

            var productosFaltantesReader = new GenericDataReader<BETablaTemType>(listTablaTempType);

            var command = new SqlCommand("dbo.DelProductoFaltante");
            command.CommandType = CommandType.StoredProcedure;
            var parameter = new SqlParameter("@tabla", SqlDbType.Structured);
            parameter.TypeName = "dbo.tablaTem";
            parameter.Value = productosFaltantesReader;
            command.Parameters.Add(parameter);
            var parameter2 = new SqlParameter("@Deleted", SqlDbType.Int);
            parameter2.Direction = ParameterDirection.Output;
            parameter2.Value = 0;
            command.Parameters.Add(parameter2);

            Context.ExecuteNonQuery(command);
            deleted = Convert.ToInt32(command.Parameters["@Deleted"].Value);
            return deleted;
        }

        public IDataReader GetProductoFaltanteByEntity(BEProductoFaltante productofaltante, string ColumnaOrden, string Ordenamiento, int PaginaActual, int FlagPaginacion, int RegistrosPorPagina, int pais)
        {
            DbCommand command = Context.Database.GetStoredProcCommand("dbo.GetProductoFaltanteByEntity");
            Context.Database.AddInParameter(command, "@CampaniaID", DbType.Int32, productofaltante.CampaniaID);
            Context.Database.AddInParameter(command, "@Zona", DbType.AnsiString, productofaltante.Zona);
            Context.Database.AddInParameter(command, "@CUV", DbType.AnsiString, productofaltante.CUV);
            Context.Database.AddInParameter(command, "@Descripcion", DbType.AnsiString, productofaltante.Descripcion);
            Context.Database.AddInParameter(command, "@fecha", DbType.AnsiString, productofaltante.Fecha);
            Context.Database.AddInParameter(command, "@columnaOrder", DbType.AnsiString, ColumnaOrden);
            Context.Database.AddInParameter(command, "@tipoOrden", DbType.AnsiString, Ordenamiento);
            Context.Database.AddInParameter(command, "@PaginaActual", DbType.Int32, PaginaActual);
            Context.Database.AddInParameter(command, "@FlagPaginacion", DbType.Boolean, FlagPaginacion);
            Context.Database.AddInParameter(command, "@RegistrosPorPagina", DbType.Int32, RegistrosPorPagina);

            return Context.ExecuteReader(command);
        }

        public IDataReader GetProductoFaltanteByCampaniaAndZonaID(int CampaniaID, int ZonaID, string cuv, string descripcion, string codCategoria, string codCatalogoRevista) 
        {
            DbCommand command = Context.Database.GetStoredProcCommand("dbo.GetProductoFaltanteByCampaniaAndZonaID");
            Context.Database.AddInParameter(command, "@CampaniaID", DbType.Int32, CampaniaID);
            Context.Database.AddInParameter(command, "@ZonaID", DbType.Int32, ZonaID);
            Context.Database.AddInParameter(command, "@CUV", DbType.String, cuv);
            Context.Database.AddInParameter(command, "@DescripcionProducto", DbType.String, descripcion);

            Context.Database.AddInParameter(command, "@CodCategoria", DbType.String, codCategoria);
            Context.Database.AddInParameter(command, "@CodCatalogo", DbType.String, codCatalogoRevista);

            return Context.ExecuteReader(command);
        }

        public IDataReader GetOnlyProductoFaltante(List<BEProductoFaltante> faltantesAnunciados, int campaniaId, int zonaId, string cuv, string descripcion)
        {
            DbCommand command = Context.Database.GetStoredProcCommand("dbo.GetOnlyProductoFaltante");

            var productosFaltantesReader = new GenericDataReader<BEProductoFaltante>(faltantesAnunciados);
            var parameter = new SqlParameter("@FaltantesAnunciados", SqlDbType.Structured);
            parameter.TypeName = "dbo.ProductoFaltanteType";
            parameter.Value = productosFaltantesReader;
            command.Parameters.Add(parameter);

            Context.Database.AddInParameter(command, "@CampaniaID", DbType.Int32, campaniaId);
            Context.Database.AddInParameter(command, "@ZonaID", DbType.Int32, zonaId);
            Context.Database.AddInParameter(command, "@CUV", DbType.String, cuv);
            Context.Database.AddInParameter(command, "@DescripcionProducto", DbType.String, descripcion);

            return Context.ExecuteReader(command);
        }

        public void InsLogIngresoFAD(int CampaniaId, long ConsultoraId, string CUV, int Cantidad, decimal PrecioUnidad, int ZonaId)
        {
            DbCommand command = Context.Database.GetStoredProcCommand("InsLogIngresoFAD");
            Context.Database.AddInParameter(command, "@CampaniaId", DbType.Int32, CampaniaId);
            Context.Database.AddInParameter(command, "@ConsultoraId", DbType.Int64, ConsultoraId);
            Context.Database.AddInParameter(command, "@CUV", DbType.AnsiString, CUV);
            Context.Database.AddInParameter(command, "@Cantidad", DbType.Int32, Cantidad);
            Context.Database.AddInParameter(command, "@PrecioUnidad", DbType.Decimal, PrecioUnidad);
            Context.Database.AddInParameter(command, "@ZonaId", DbType.Int32, ZonaId);

            Context.ExecuteNonQuery(command);
        }

        public int DelProductoFaltanteMasivo(int campaniaID, string zona, string cuv, string fecha, string descripcion)
        {
            DbCommand command = Context.Database.GetStoredProcCommand("dbo.DelProductoFaltanteMasivo");
            Context.Database.AddInParameter(command, "@CampaniaID", DbType.Int32, campaniaID);
            Context.Database.AddInParameter(command, "@Zona", DbType.AnsiString, zona);
            Context.Database.AddInParameter(command, "@CUV", DbType.AnsiString, cuv);
            Context.Database.AddInParameter(command, "@Fecha", DbType.AnsiString, fecha);
            Context.Database.AddInParameter(command, "@Descripcion", DbType.AnsiString, descripcion);

            return Convert.ToInt32(Context.ExecuteScalar(command).ToString());
        }

    }
}