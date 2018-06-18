using Portal.Consultoras.Entities;
using System.Collections.Generic;
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
        public string ValidarMatrizCampaniaMasivo(string Cuvs, int AnioCampania)
        {
            DbCommand command = Context.Database.GetStoredProcCommand("ValidarCUVsNoExistentes");
            Context.Database.AddInParameter(command, "@CUVs", DbType.String, Cuvs);
            Context.Database.AddInParameter(command, "@AnioCampania", DbType.Int32, AnioCampania);
            return Context.ExecuteScalar(command).ToString();
        }

        public string RegistrarProductoMasivo(string data)
        {
            DbCommand command = Context.Database.GetStoredProcCommand("RegistrarProductoMasivo");
            Context.Database.AddInParameter(command, "@data", DbType.String, data);
            return Context.ExecuteScalar(command).ToString();
        }

        public void UpdProductoDescripcionMasivo(int paisID, int CampaniaCodigo, IEnumerable<BEProductoDescripcion> productos, string codigoUsuario)
        {
            //var dtCronograma = new DataTable();
            //dtCronograma.Columns.Add("CUV", typeof(string));
            //dtCronograma.Columns.Add("Descripcion", typeof(string));
            //dtCronograma.Columns.Add("PrecioProducto", typeof(int));
            //dtCronograma.Columns.Add("FactorRepeticion", typeof(string));

            //foreach (BEProductoDescripcion be in productos)
            //{
            //    dtCronograma.Rows.Add(be.CUV, be.Descripcion, be.PrecioProducto, be.FactorRepeticion);
            //}
            //dtCronograma.AcceptChanges();

            //var command = new SqlCommand("dbo.InsMatrizCampaniaMasivo");
            //command.CommandType = CommandType.StoredProcedure;

            //var parameter = new SqlParameter("@ProductoDescripcion", SqlDbType.Structured);
            //parameter.TypeName = "dbo.MatrizCampaniaMasivaType";
            //parameter.Value = dtCronograma;
            //command.Parameters.Add(parameter);

            //var parameter1 = new SqlParameter("@CampaniaID", SqlDbType.Int);
            //parameter1.Value = CampaniaCodigo;
            //command.Parameters.Add(parameter1);

            //var parameter2 = new SqlParameter("@CodigoUsuario", SqlDbType.VarChar);
            //parameter2.Value = codigoUsuario.ToString();
            //command.Parameters.Add(parameter2);

            //Context.ExecuteNonQuery(command);
        }


    }
}