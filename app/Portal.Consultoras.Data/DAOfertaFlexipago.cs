using OpenSource.Library.DataAccess;
using Portal.Consultoras.Entities;
using System;
using System.Collections.Generic;
using System.Data;
using System.Data.Common;
using System.Data.SqlClient;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Portal.Consultoras.Data
{
    public class DAOfertaFlexipago : DataAccess
    {
        public DAOfertaFlexipago(int paisID)
            : base(paisID, EDbSource.Portal)
        {

        }

        public int GuardarLinksOfertaFlexipago(BEOfertaFlexipago entidad)
        {
            DbCommand command = Context.Database.GetStoredProcCommand("dbo.GuardarLinksFlexipago");
            Context.Database.AddInParameter(command, "@LinksFlexipago", DbType.AnsiString, entidad.LinksFlexipago);
            Context.Database.AddInParameter(command, "@UsuarioRegistro", DbType.AnsiString, entidad.UsuarioRegistro);

            return Context.ExecuteNonQuery(command);
        }

        public IDataReader GetLinksOfertaFlexipago()
        {
            DbCommand command = Context.Database.GetStoredProcCommand("dbo.GetLinksOfertaFlexipago");

            return Context.ExecuteReader(command);
        }

        public IDataReader GetProductosByOfertaFlexipago(int TipoOfertaSisID, int CampaniaID, string CodigoOferta, string CodigoSAP, string CUV, string CategoriaID)
        {
            DbCommand command = Context.Database.GetStoredProcCommand("dbo.GetProductosByOfertasFlexipago");
            Context.Database.AddInParameter(command, "@TipoOfertaSisID", DbType.Int32, TipoOfertaSisID);
            Context.Database.AddInParameter(command, "@CampaniaID", DbType.Int32, CampaniaID);
            Context.Database.AddInParameter(command, "@CodigoOferta", DbType.AnsiString, CodigoOferta);
            Context.Database.AddInParameter(command, "@CodigoSAP", DbType.AnsiString, CodigoSAP);
            Context.Database.AddInParameter(command, "@CUV", DbType.AnsiString, CUV);
            Context.Database.AddInParameter(command, "@CategoriaID", DbType.AnsiString, CategoriaID);

            return Context.ExecuteReader(command);
        }

        public int InsOfertaFlexipago(BEOfertaFlexipago entity)
        {
            DbCommand command = Context.Database.GetStoredProcCommand("dbo.InsOfertaFlexipago");
            Context.Database.AddInParameter(command, "@CampaniaID", DbType.Int32, entity.CampaniaID);
            Context.Database.AddInParameter(command, "@CUV", DbType.AnsiString, entity.CUV);
            Context.Database.AddInParameter(command, "@TipoOfertaSisID", DbType.Int32, entity.TipoOfertaSisID);
            Context.Database.AddInParameter(command, "@ConfiguracionOfertaID", DbType.Int32, entity.ConfiguracionOfertaID);
            Context.Database.AddInParameter(command, "@Descripcion", DbType.AnsiString, entity.Descripcion);
            Context.Database.AddInParameter(command, "@PrecioOferta", DbType.Decimal, entity.PrecioOferta);
            Context.Database.AddInParameter(command, "@ImagenProducto", DbType.AnsiString, entity.ImagenProducto);
            Context.Database.AddInParameter(command, "@Orden", DbType.Int32, entity.Orden);
            Context.Database.AddInParameter(command, "@UnidadesPermitidas", DbType.Int32, entity.UnidadesPermitidas);
            Context.Database.AddInParameter(command, "@FlagHabilitarProducto", DbType.Byte, entity.FlagHabilitarProducto);
            Context.Database.AddInParameter(command, "@DescripcionLegal", DbType.AnsiString, entity.DescripcionLegal);
            Context.Database.AddInParameter(command, "@UsuarioRegistro", DbType.AnsiString, entity.UsuarioRegistro);
            Context.Database.AddInParameter(command, "@PrecioNormal", DbType.Decimal, entity.PrecioNormal);

            return Context.ExecuteNonQuery(command);
        }

        public int UpdOfertaFlexipago(BEOfertaFlexipago entity)
        {
            DbCommand command = Context.Database.GetStoredProcCommand("dbo.UpdOfertaFlexipago");
            Context.Database.AddInParameter(command, "@TipoOfertaSisID", DbType.Int32, entity.TipoOfertaSisID);
            Context.Database.AddInParameter(command, "@CampaniaID", DbType.Int32, entity.CampaniaID);
            Context.Database.AddInParameter(command, "@CUV", DbType.AnsiString, entity.CUV);
            Context.Database.AddInParameter(command, "@Descripcion", DbType.AnsiString, entity.Descripcion);
            Context.Database.AddInParameter(command, "@ImagenProducto", DbType.AnsiString, entity.ImagenProducto);
            Context.Database.AddInParameter(command, "@UnidadesPermitidas", DbType.Int32, entity.UnidadesPermitidas);
            Context.Database.AddInParameter(command, "@FlagHabilitarProducto", DbType.Byte, entity.FlagHabilitarProducto);
            Context.Database.AddInParameter(command, "@Orden", DbType.Int32, entity.Orden);
            Context.Database.AddInParameter(command, "@DescripcionLegal", DbType.AnsiString, entity.DescripcionLegal);
            Context.Database.AddInParameter(command, "@UsuarioModificacion", DbType.AnsiString, entity.UsuarioModificacion);
            Context.Database.AddInParameter(command, "@PrecioNormal", DbType.Decimal, entity.PrecioNormal);

            return Context.ExecuteNonQuery(command);
        }

        public int DelOfertaFlexipago(BEOfertaFlexipago entity)
        {
            DbCommand command = Context.Database.GetStoredProcCommand("dbo.DelOfertaFlexipago");
            Context.Database.AddInParameter(command, "@CampaniaID", DbType.Int32, entity.CampaniaID);
            Context.Database.AddInParameter(command, "@CUV", DbType.AnsiString, entity.CUV);
            Context.Database.AddInParameter(command, "@TipoOfertaSisID", DbType.Int32, entity.TipoOfertaSisID);
            Context.Database.AddInParameter(command, "@UsuarioModificacion", DbType.AnsiString, entity.UsuarioModificacion);

            return Context.ExecuteNonQuery(command);
        }

        public int GetUnidadesPermitidasByCuvFlexipago(int CampaniaID, string CUV)
        {
            DbCommand command = Context.Database.GetStoredProcCommand("dbo.ValidarUnidadesPermitidasByCUVFlexipago");
            Context.Database.AddInParameter(command, "@CampaniaID", DbType.Int32, CampaniaID);
            Context.Database.AddInParameter(command, "@CUV", DbType.AnsiString, CUV);

            return int.Parse(Context.ExecuteScalar(command).ToString());
        }

        public int ValidarUnidadesPermitidasEnPedidoFlexipago(int CampaniaID, string CUV, long ConsultoraID)
        {
            DbCommand command = Context.Database.GetStoredProcCommand("dbo.ValidarUnidadesPermitidaPedidoFlexipago");

            Context.Database.AddInParameter(command, "@CampaniaID", DbType.Int32, CampaniaID);
            Context.Database.AddInParameter(command, "@CUV", DbType.AnsiString, CUV);
            Context.Database.AddInParameter(command, "@ConsultoraID", DbType.Int32, ConsultoraID);
            return int.Parse(Context.ExecuteScalar(command).ToString());
        }

        public int GetStockOfertaProductoFlexipago(int CampaniaID, string CUV, int TipoOfertaSisID)
        {
            DbCommand command = Context.Database.GetStoredProcCommand("dbo.ValidarStockOfertaFlexipago");
            Context.Database.AddInParameter(command, "@CampaniaID", DbType.Int32, CampaniaID);
            Context.Database.AddInParameter(command, "@CUV", DbType.AnsiString, CUV);
            Context.Database.AddInParameter(command, "@TipoOfertaSisID", DbType.Int32, TipoOfertaSisID);

            return int.Parse(Context.ExecuteScalar(command).ToString());
        }

        public int ObtenerMaximoItemsaMostrarFlexipago()
        {
            DbCommand command = Context.Database.GetStoredProcCommand("dbo.GetMaxItemsFlexipago");

            return int.Parse(Context.ExecuteScalar(command).ToString());
        }

        public int ActualizarItemsMostrarFlexipago(int Cantidad)
        {
            DbCommand command = Context.Database.GetStoredProcCommand("dbo.UpdMaxItemsFlexipago");

            Context.Database.AddInParameter(command, "@Cantidad", DbType.Int32, Cantidad);
            return Context.ExecuteNonQuery(command);
        }

        public IDataReader GetOfertaProductosPortalFlexipago(int TipoOfertaSisID, string CodigoConsultora, int CodigoCampania)
        {
            DbCommand command = Context.Database.GetStoredProcCommand("dbo.GetOfertasPortalFlexipago");
            Context.Database.AddInParameter(command, "@TipoOfertaSisID", DbType.Int32, TipoOfertaSisID);
            Context.Database.AddInParameter(command, "@CodigoCampania", DbType.Int32, CodigoCampania);
            Context.Database.AddInParameter(command, "@CodigoConsultora", DbType.AnsiString, CodigoConsultora);

            return Context.ExecuteReader(command);
        }

        public IDataReader GetCuotasAnterioresFlexipago(string CodigoConsultora, int CampaniaID)
        {
            DbCommand command = Context.Database.GetStoredProcCommand("dbo.GetCuotasAnterioresFlexipago");
            Context.Database.AddInParameter(command, "@CodigoConsultora", DbType.AnsiString, CodigoConsultora);
            Context.Database.AddInParameter(command, "@CampaniaID", DbType.Int32, CampaniaID);

            return Context.ExecuteReader(command);
        }

        public IDataReader GetLineaCreditoFlexipago(string CodigoConsultora, int CampaniaID)
        {
            DbCommand command = Context.Database.GetStoredProcCommand("dbo.GetLineaCreditoFlexipago");
            Context.Database.AddInParameter(command, "@CodigoConsultora", DbType.AnsiString, CodigoConsultora);
            Context.Database.AddInParameter(command, "@CampaniaID", DbType.Int32, CampaniaID);

            return Context.ExecuteReader(command);
        }

        public int UpdOfertaFlexipagoStockMasivo(IEnumerable<BEOfertaFlexipago> stockProductos)
        {
            var ofertaFlexipagoReader = new GenericDataReader<BEOfertaFlexipago>(stockProductos);

            var command = new SqlCommand("dbo.UpdStockOfertaFlexipagoMasivo");
            command.CommandType = CommandType.StoredProcedure;

            var parameter = new SqlParameter("@StockFlexipago", SqlDbType.Structured);
            parameter.TypeName = "dbo.StockCategoriaFlexipagoType";
            parameter.Value = ofertaFlexipagoReader;
            command.Parameters.Add(parameter);

            return Context.ExecuteNonQuery(command);
        }

        public int UpdCategoriaConsultoraMasivo(List<BEOfertaFlexipago> stockProductos)
        {
            var ofertaFlexipagoReader = new GenericDataReader<BEOfertaFlexipago>(stockProductos);

            var command = new SqlCommand("dbo.UpdConsultoraCategoriaMasivo");
            command.CommandType = CommandType.StoredProcedure;

            var parameter = new SqlParameter("@StockFlexipago", SqlDbType.Structured);
            parameter.TypeName = "dbo.StockCategoriaFlexipagoType";
            parameter.Value = ofertaFlexipagoReader;
            command.Parameters.Add(parameter);

            return Context.ExecuteNonQuery(command);
        }

        public string GetCategoriaByConsultora(int CampaniaID, string CodigoConsultora)
        {
            DbCommand command = Context.Database.GetStoredProcCommand("dbo.GetCategoriaByConsultoraFlexipago");
            Context.Database.AddInParameter(command, "@CodigoConsultora", DbType.AnsiString, CodigoConsultora);
            Context.Database.AddInParameter(command, "@CampaniaID", DbType.Int32, CampaniaID);

            return Convert.ToString(Context.ExecuteScalar(command).ToString());
        }

        public bool GetPermisoFlexipago(string CodigoConsultora, int CampaniaID)
        {
            DbCommand command = Context.Database.GetStoredProcCommand("dbo.GetPermisoFlexipago");
            Context.Database.AddInParameter(command, "@CodigoConsultora", DbType.AnsiString, CodigoConsultora);
            Context.Database.AddInParameter(command, "@CampaniaID", DbType.AnsiString, CampaniaID.ToString());            
            int result = int.Parse(Context.ExecuteScalar(command).ToString());
            return result != 0;
        }
    }
}