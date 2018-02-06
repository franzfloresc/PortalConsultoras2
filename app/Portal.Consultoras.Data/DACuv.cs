using OpenSource.Library.DataAccess;
using Portal.Consultoras.Entities;
using System;
using System.Collections.Generic;
using System.Data;
using System.Data.Common;
using System.Data.SqlClient;

namespace Portal.Consultoras.Data
{
    public class DACuv : DataAccess
    {
        public DACuv(int paisID)
            : base(paisID, EDbSource.Portal)
        {

        }

        #region Cuv_Automatico
        public int InsCuvAutomatico(IEnumerable<BECUVAutomatico> cuvautomatico)
        {
            var productosFaltantesReader = new GenericDataReader<BECUVAutomatico>(cuvautomatico);

            var command = new SqlCommand("dbo.InsCuvAutomatico");
            command.CommandType = CommandType.StoredProcedure;

            var parameter = new SqlParameter("@CuvAutomaticos", SqlDbType.Structured);
            parameter.TypeName = "dbo.CuvAutomaticoType";
            parameter.Value = productosFaltantesReader;
            command.Parameters.Add(parameter);

            return Context.ExecuteNonQuery(command);
        }
        public IDataReader GetProductoCuvAutomatico(BECUVAutomatico cuvautomatico, string ColumnaOrden, string Ordenamiento, int PaginaActual, int FlagPaginacion, int RegistrosPorPagina)
        {
            DbCommand command = Context.Database.GetStoredProcCommand("dbo.GetProductoCuvAutomatico");
            Context.Database.AddInParameter(command, "@CampaniaID", DbType.Int32, cuvautomatico.CampaniaID);
            Context.Database.AddInParameter(command, "@columnaOrder", DbType.AnsiString, ColumnaOrden);
            Context.Database.AddInParameter(command, "@tipoOrden", DbType.AnsiString, Ordenamiento);
            Context.Database.AddInParameter(command, "@PaginaActual", DbType.Int32, PaginaActual);
            Context.Database.AddInParameter(command, "@FlagPaginacion", DbType.Boolean, FlagPaginacion);
            Context.Database.AddInParameter(command, "@RegistrosPorPagina", DbType.Int32, RegistrosPorPagina);

            return Context.ExecuteReader(command);
        }

        public int DelCUVAutomatico(BECUVAutomatico prod, out bool Deleted)
        {
            DbCommand command = Context.Database.GetStoredProcCommand("dbo.DelCuvAutomatico");
            Context.Database.AddInParameter(command, "@CampaniaID", DbType.AnsiString, prod.CampaniaID);
            Context.Database.AddInParameter(command, "@CUV", DbType.AnsiString, prod.CUV);
            Context.Database.AddOutParameter(command, "@Deleted", DbType.Boolean, 1);
            int result = Context.ExecuteNonQuery(command);
            Deleted = Convert.ToBoolean(command.Parameters["@Deleted"].Value);
            return result;
        }

        public int GetProductoCUVsAutomaticosToInsert(BEPedidoWeb pedidoweb)
        {
            DbCommand command = Context.Database.GetStoredProcCommand("dbo.GetProductoCUVsAutomaticosToInsert");
            Context.Database.AddInParameter(command, "@CampaniaID", DbType.Int32, pedidoweb.CampaniaID);
            Context.Database.AddInParameter(command, "@ConsultoraID", DbType.Int32, pedidoweb.ConsultoraID);
            Context.Database.AddInParameter(command, "@PaisID", DbType.Byte, pedidoweb.PaisID);
            Context.Database.AddInParameter(command, "@IPUsuario", DbType.AnsiString, pedidoweb.IPUsuario);
            Context.Database.AddInParameter(command, "@CodigoUsuarioCreacion", DbType.String, pedidoweb.CodigoUsuarioCreacion);

            int result = Context.ExecuteNonQuery(command);
            return result;
        }


        #endregion

        #region OfertaFIC

        public int InsOfertaFIC(IEnumerable<BEOfertaFIC> ofertaFIC)
        {
            var productosFaltantesReader = new GenericDataReader<BEOfertaFIC>(ofertaFIC);

            var command = new SqlCommand("dbo.InsOfertaFIC");
            command.CommandType = CommandType.StoredProcedure;

            var parameter = new SqlParameter("@OfertaFIC", SqlDbType.Structured);
            parameter.TypeName = "OfertaFICType";
            parameter.Value = productosFaltantesReader;
            command.Parameters.Add(parameter);

            return Context.ExecuteNonQuery(command);
        }
        public IDataReader GetProductoOfertaFIC(BEOfertaFIC cuvautomatico, string ColumnaOrden, string Ordenamiento, int PaginaActual, int FlagPaginacion, int RegistrosPorPagina)
        {
            DbCommand command = Context.Database.GetStoredProcCommand("dbo.GetProductoOfertaFIC");
            Context.Database.AddInParameter(command, "@CampaniaID", DbType.Int32, cuvautomatico.CampaniaID);
            Context.Database.AddInParameter(command, "@columnaOrder", DbType.AnsiString, ColumnaOrden);
            Context.Database.AddInParameter(command, "@tipoOrden", DbType.AnsiString, Ordenamiento);
            Context.Database.AddInParameter(command, "@PaginaActual", DbType.Int32, PaginaActual);
            Context.Database.AddInParameter(command, "@FlagPaginacion", DbType.Boolean, FlagPaginacion);
            Context.Database.AddInParameter(command, "@RegistrosPorPagina", DbType.Int32, RegistrosPorPagina);

            return Context.ExecuteReader(command);
        }
        public int DelOfertaFIC(BEOfertaFIC prod, out bool Deleted)
        {
            DbCommand command = Context.Database.GetStoredProcCommand("dbo.DelOfertaFIC");
            Context.Database.AddInParameter(command, "@CampaniaID", DbType.AnsiString, prod.CampaniaID);
            Context.Database.AddInParameter(command, "@CUV", DbType.AnsiString, prod.CUV);
            Context.Database.AddOutParameter(command, "@Deleted", DbType.Boolean, 1);
            int result = Context.ExecuteNonQuery(command);
            Deleted = Convert.ToBoolean(command.Parameters["@Deleted"].Value);
            return result;
        }
        public int GetOfertaFICToInsert(BEPedidoWeb pedidoweb)
        {
            DbCommand command = Context.Database.GetStoredProcCommand("dbo.ObtenerOfertaFIC_InsertarPedido");
            Context.Database.AddInParameter(command, "@CampaniaID", DbType.Int32, pedidoweb.CampaniaID);
            Context.Database.AddInParameter(command, "@ConsultoraID", DbType.Int32, pedidoweb.ConsultoraID);
            Context.Database.AddInParameter(command, "@PaisID", DbType.Byte, pedidoweb.PaisID);
            Context.Database.AddInParameter(command, "@IPUsuario", DbType.AnsiString, pedidoweb.IPUsuario);
            Context.Database.AddInParameter(command, "@CodigoUsuarioCreacion", DbType.String, pedidoweb.CodigoUsuarioCreacion);

            int result = Context.ExecuteNonQuery(command);
            return result;
        }

        #endregion
    }
}
