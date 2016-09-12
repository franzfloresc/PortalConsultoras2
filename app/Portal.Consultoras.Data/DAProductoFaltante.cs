using Portal.Consultoras.Entities;
using System;
using System.Collections.Generic;
using System.Data;
using System.Data.Common;
using System.Data.SqlClient;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using OpenSource.Library.DataAccess;

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

        //R1957
        private DataTable productoTabla(BEProductoFaltante[] students)
        {
            DataTable dt = new DataTable();
            dt.Columns.Add("CampaniaID", typeof(string));
            dt.Columns.Add("CUV", typeof(string));
            dt.Columns.Add("ZonaID", typeof(string));
            dt.Columns.Add("Zona", typeof(string));
            dt.Columns.Add("FaltanteUltimoMinuto", typeof(string));
            dt.Columns["CampaniaID"].ColumnMapping = MappingType.Attribute;

            foreach (BEProductoFaltante s in students)
            {
                dt.Rows.Add(s.CampaniaID, s.CUV, s.ZonaID, s.Zona, s.FaltanteUltimoMinuto);
            }
            return dt;

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

        //R1957
        public int DelProductoFaltante2(List<BEProductoFaltante> prod, out int deleted,int flag,int pais ,int campania,int zona,string cuv,string e_producto,DateTime fecha)
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

        //R1957
        public IDataReader GetProductoFaltanteByEntity(BEProductoFaltante productofaltante, string ColumnaOrden, string Ordenamiento, int PaginaActual, int FlagPaginacion, int RegistrosPorPagina,int pais)
        {
            DbCommand command = Context.Database.GetStoredProcCommand("dbo.GetProductoFaltanteByEntity");
            Context.Database.AddInParameter(command, "@CampaniaID", DbType.Int32, productofaltante.CampaniaID);
            Context.Database.AddInParameter(command, "@Zona", DbType.AnsiString, productofaltante.Zona);
            Context.Database.AddInParameter(command, "@CUV", DbType.AnsiString, productofaltante.CUV);
            Context.Database.AddInParameter(command, "@Descripcion", DbType.AnsiString, productofaltante.Descripcion);
            //R2283
            Context.Database.AddInParameter(command, "@fecha", DbType.AnsiString, productofaltante.Fecha);
            Context.Database.AddInParameter(command, "@columnaOrder", DbType.AnsiString, ColumnaOrden);
            Context.Database.AddInParameter(command, "@tipoOrden", DbType.AnsiString, Ordenamiento);
            Context.Database.AddInParameter(command, "@PaginaActual", DbType.Int32, PaginaActual);
            Context.Database.AddInParameter(command, "@FlagPaginacion", DbType.Boolean, FlagPaginacion);
            Context.Database.AddInParameter(command, "@RegistrosPorPagina", DbType.Int32, RegistrosPorPagina);

            return Context.ExecuteReader(command);
        }

        public IDataReader GetProductoFaltanteByCampaniaAndZonaID(int CampaniaID, int ZonaID)
        {
            DbCommand command = Context.Database.GetStoredProcCommand("dbo.GetProductoFaltanteByCampaniaAndZonaID");
            Context.Database.AddInParameter(command, "@CampaniaID", DbType.Int32, CampaniaID);
            Context.Database.AddInParameter(command, "@ZonaID", DbType.Int32, ZonaID);

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

        /* 1957 - Inicio */
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
        /* 1957 - Fin */
    }
}
