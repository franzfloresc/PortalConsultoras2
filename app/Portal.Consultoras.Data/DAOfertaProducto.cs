using OpenSource.Library.DataAccess;
using Portal.Consultoras.Common;
using Portal.Consultoras.Entities;
using System;
using System.Collections.Generic;
using System.Data;
using System.Data.Common;
using System.Data.SqlClient;
using System.Text;

namespace Portal.Consultoras.Data
{
    public class DAOfertaProducto : DataAccess
    {
        public DAOfertaProducto(int paisID)
            : base(paisID, EDbSource.Portal)
        {

        }

        public IDataReader GetTipoOfertasAdministracion(int TipoOfertaSisID)
        {
            DbCommand command = Context.Database.GetStoredProcCommand("dbo.GetTipoOfertasPortal");
            Context.Database.AddInParameter(command, "@TipoOfertaSisID", DbType.Int32, TipoOfertaSisID);

            return Context.ExecuteReader(command);
        }

        public IDataReader GetProductosByTipoOferta(int TipoOfertaSisID, int CampaniaID, string CodigoOferta)
        {
            DbCommand command = Context.Database.GetStoredProcCommand("dbo.GetProductoOfertasAdministracion");
            Context.Database.AddInParameter(command, "@TipoOfertaSisID", DbType.Int32, TipoOfertaSisID);
            Context.Database.AddInParameter(command, "@CampaniaID", DbType.Int32, CampaniaID);
            Context.Database.AddInParameter(command, "@CodigoOferta", DbType.AnsiString, CodigoOferta);

            return Context.ExecuteReader(command);
        }

        public IDataReader GetProductosOfertaByCUVCampania(int TipoOfertaSisID, int CampaniaID, string CUV)
        {
            DbCommand command = Context.Database.GetStoredProcCommand("dbo.GetProductoOfertaByTipo");
            Context.Database.AddInParameter(command, "@TipoOfertaSisID", DbType.Int32, TipoOfertaSisID);
            Context.Database.AddInParameter(command, "@CampaniaID", DbType.Int32, CampaniaID);
            Context.Database.AddInParameter(command, "@CUV", DbType.AnsiString, CUV);

            return Context.ExecuteReader(command);
        }

        public int InsOfertaProducto(BEOfertaProducto entity)
        {
            DbCommand command = Context.Database.GetStoredProcCommand("dbo.InsOfertaProducto");
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

            return Context.ExecuteNonQuery(command);
        }

        public int UpdOfertaProducto(BEOfertaProducto entity)
        {
            DbCommand command = Context.Database.GetStoredProcCommand("dbo.UpdOfertaProducto");
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

            return Context.ExecuteNonQuery(command);
        }

        public int DelOfertaProducto(BEOfertaProducto entity)
        {
            DbCommand command = Context.Database.GetStoredProcCommand("dbo.DelOfertaProducto");
            Context.Database.AddInParameter(command, "@CampaniaID", DbType.Int32, entity.CampaniaID);
            Context.Database.AddInParameter(command, "@CUV", DbType.AnsiString, entity.CUV);
            Context.Database.AddInParameter(command, "@UsuarioModificacion", DbType.AnsiString, entity.UsuarioModificacion);

            return Context.ExecuteNonQuery(command);
        }


        public int InsAdministracionStockMinimo(BEAdministracionOfertaProducto entity)
        {
            DbCommand command = Context.Database.GetStoredProcCommand("dbo.InsAdministracionStockMinimo");
            Context.Database.AddInParameter(command, "@Correos", DbType.AnsiString, entity.Correos);
            Context.Database.AddInParameter(command, "@StockMinimo", DbType.Int32, entity.StockMinimo);
            Context.Database.AddInParameter(command, "@UsuarioRegistro", DbType.AnsiString, entity.UsuarioRegistro);

            return Context.ExecuteNonQuery(command);
        }

        public int UpdAdministracionStockMinimo(BEAdministracionOfertaProducto entity)
        {
            DbCommand command = Context.Database.GetStoredProcCommand("dbo.UpdAdministracionStockMinimo");
            Context.Database.AddInParameter(command, "@Correos", DbType.AnsiString, entity.Correos);
            Context.Database.AddInParameter(command, "@StockMinimo", DbType.Int32, entity.StockMinimo);
            Context.Database.AddInParameter(command, "@UsuarioModificacion", DbType.AnsiString, entity.UsuarioModificacion);

            return Context.ExecuteNonQuery(command);
        }

        public int UpdOfertaProductoStockMasivo(IEnumerable<BEOfertaProducto> stockProductos)
        {
            var ofertaProductosReader = new GenericDataReader<BEOfertaProducto>(stockProductos);

            var command = new SqlCommand("dbo.UpdStockOfertaProductoMasivo");
            command.CommandType = CommandType.StoredProcedure;

            var parameter = new SqlParameter("@StockProducto", SqlDbType.Structured);
            parameter.TypeName = "dbo.StockProductoType";
            parameter.Value = ofertaProductosReader;
            command.Parameters.Add(parameter);

            return Context.ExecuteNonQuery(command);
        }

        public int InsStockCargaLog(BEStockCargaLog entity)
        {
            DbCommand command = Context.Database.GetStoredProcCommand("dbo.InsStockCargaLog");
            Context.Database.AddInParameter(command, "@TipoOfertaSisID", DbType.AnsiString, entity.TipoOfertaSisID);
            Context.Database.AddInParameter(command, "@CantidadRegistros", DbType.Int32, entity.CantidadRegistros);
            Context.Database.AddInParameter(command, "@UsuarioRegistro", DbType.AnsiString, entity.UsuarioRegistro);

            return Context.ExecuteNonQuery(command);
        }


        public int UpdOfertaProductoStockEliminar(int TipoOfertaSisID, int CampaniaID, string CUV, int Stock)
        {
            DbCommand command = Context.Database.GetStoredProcCommand("dbo.UpdStockOfertaProductoDel");
            Context.Database.AddInParameter(command, "@TipoOfertaSisID", DbType.Int32, TipoOfertaSisID);
            Context.Database.AddInParameter(command, "@CampaniaID", DbType.Int32, CampaniaID);
            Context.Database.AddInParameter(command, "@CUV", DbType.AnsiString, CUV);
            Context.Database.AddInParameter(command, "@Stock", DbType.Int32, Stock);

            return Context.ExecuteNonQuery(command);
        }

        public int UpdOfertaProductoStockAgregar(int TipoOfertaSisID, int CampaniaID, string CUV, int Stock)
        {
            DbCommand command = Context.Database.GetStoredProcCommand("dbo.UpdStockOfertaProducto");
            Context.Database.AddInParameter(command, "@TipoOfertaSisID", DbType.Int32, TipoOfertaSisID);
            Context.Database.AddInParameter(command, "@CampaniaID", DbType.Int32, CampaniaID);
            Context.Database.AddInParameter(command, "@CUV", DbType.AnsiString, CUV);
            Context.Database.AddInParameter(command, "@Stock", DbType.Int32, Stock);

            return Context.ExecuteNonQuery(command);
        }

        public int UpdOfertaProductoStockActualizar(int TipoOfertaSisID, int CampaniaID, string CUV, int Stock, int Flag)
        {
            DbCommand command = Context.Database.GetStoredProcCommand("dbo.UpdStockOfertaProductoUpd");
            Context.Database.AddInParameter(command, "@TipoOfertaSisID", DbType.Int32, TipoOfertaSisID);
            Context.Database.AddInParameter(command, "@CampaniaID", DbType.Int32, CampaniaID);
            Context.Database.AddInParameter(command, "@CUV", DbType.AnsiString, CUV);
            Context.Database.AddInParameter(command, "@Stock", DbType.Int32, Stock);
            Context.Database.AddInParameter(command, "@Flag", DbType.Int32, Flag);

            return Context.ExecuteNonQuery(command);
        }

        public IDataReader GetDatosAdmStockMinimoCorreos()
        {
            DbCommand command = Context.Database.GetStoredProcCommand("dbo.GetAdmStockMinimoCorreos");
            return Context.ExecuteReader(command);
        }

        public int GetOrdenPriorizacion(int ConfiguracionOfertaID, int CampaniaID)
        {
            DbCommand command = Context.Database.GetStoredProcCommand("dbo.GetPriorizacionByTipoOferta");
            Context.Database.AddInParameter(command, "@ConfiguracionOfertaID", DbType.Int32, ConfiguracionOfertaID);
            Context.Database.AddInParameter(command, "@CampaniaID", DbType.Int32, CampaniaID);

            return int.Parse(Context.ExecuteScalar(command).ToString());
        }

        public int ValidarPriorizacion(int ConfiguracionOfertaID, int CampaniaID, int Orden)
        {
            DbCommand command = Context.Database.GetStoredProcCommand("dbo.ValidarPriorizacionByTipoOferta");
            Context.Database.AddInParameter(command, "@ConfiguracionOfertaID", DbType.Int32, ConfiguracionOfertaID);
            Context.Database.AddInParameter(command, "@CampaniaID", DbType.Int32, CampaniaID);
            Context.Database.AddInParameter(command, "@Orden", DbType.Int32, Orden);

            return int.Parse(Context.ExecuteScalar(command).ToString());
        }

        public int InsMatrizComercial(BEMatrizComercial entity)
        {
            DbCommand command = Context.Database.GetStoredProcCommand("dbo.InsMatrizComercial");
            Context.Database.AddInParameter(command, "@CodigoSAP", DbType.AnsiString, entity.CodigoSAP);
            Context.Database.AddInParameter(command, "@DescripcionOriginal", DbType.AnsiString, entity.DescripcionOriginal);
            Context.Database.AddInParameter(command, "@Descripcion", DbType.AnsiString, entity.Descripcion);
            Context.Database.AddInParameter(command, "@UsuarioRegistro", DbType.AnsiString, entity.UsuarioRegistro);

            return Convert.ToInt32(Context.ExecuteScalar(command));
        }

        public int InsMatrizComercialImagen(BEMatrizComercialImagen entity)
        {
            DbCommand command = Context.Database.GetStoredProcCommand("dbo.InsMatrizComercialImagen");
            Context.Database.AddInParameter(command, "@IdMatrizComercial", DbType.AnsiString, entity.IdMatrizComercial);
            Context.Database.AddInParameter(command, "@Foto", DbType.AnsiString, entity.Foto);
            Context.Database.AddInParameter(command, "@UsuarioRegistro", DbType.AnsiString, entity.UsuarioRegistro);
            Context.Database.AddInParameter(command, "@NemoTecnico", DbType.AnsiString, entity.NemoTecnico);
            Context.Database.AddInParameter(command, "@DescripcionComercial", DbType.AnsiString, entity.DescripcionComercial);

            return Convert.ToInt32(Context.ExecuteScalar(command));
        }

        public int UpdMatrizComercial(BEMatrizComercial entity)
        {
            DbCommand command = Context.Database.GetStoredProcCommand("dbo.UpdMatrizComercial");
            Context.Database.AddInParameter(command, "@CodigoSAP", DbType.AnsiString, entity.CodigoSAP);
            Context.Database.AddInParameter(command, "@Descripcion", DbType.AnsiString, entity.Descripcion);
            Context.Database.AddInParameter(command, "@UsuarioModificacion", DbType.AnsiString, entity.UsuarioModificacion);

            return Context.ExecuteNonQuery(command);
        }

        public int UpdMatrizComercialImagen(BEMatrizComercialImagen entity)
        {
            DbCommand command = Context.Database.GetStoredProcCommand("dbo.UpdMatrizComercialImagen");
            Context.Database.AddInParameter(command, "@IdMatrizComercialImagen", DbType.AnsiString, entity.IdMatrizComercialImagen);
            Context.Database.AddInParameter(command, "@Foto", DbType.AnsiString, entity.Foto);
            Context.Database.AddInParameter(command, "@UsuarioModificacion", DbType.AnsiString, entity.UsuarioModificacion);
            Context.Database.AddInParameter(command, "@NemoTecnico", DbType.AnsiString, entity.NemoTecnico);
            Context.Database.AddInParameter(command, "@DescripcionComercial", DbType.AnsiString, entity.DescripcionComercial);

            return Context.ExecuteNonQuery(command);
        }

        public int UpdMatrizComercialNemotecnico(BEMatrizComercialImagen entity)
        {
            DbCommand command = Context.Database.GetStoredProcCommand("dbo.UpdMatrizComercialNemotecnico");
            Context.Database.AddInParameter(command, "@IdMatrizComercialImagen", DbType.AnsiString, entity.IdMatrizComercialImagen);
            Context.Database.AddInParameter(command, "@UsuarioModificacion", DbType.AnsiString, entity.UsuarioModificacion);
            Context.Database.AddInParameter(command, "@NemoTecnico", DbType.AnsiString, entity.NemoTecnico);

            return Context.ExecuteNonQuery(command);
        }

        public int UpdMatrizComercialDescripcionComercial(BEMatrizComercialImagen entity)
        {
            DbCommand command = Context.Database.GetStoredProcCommand("dbo.UpdMatrizComercialDescripcionComercial");
            Context.Database.AddInParameter(command, "@IdMatrizComercialImagen", DbType.AnsiString, entity.IdMatrizComercialImagen);
            Context.Database.AddInParameter(command, "@UsuarioModificacion", DbType.AnsiString, entity.UsuarioModificacion);
            Context.Database.AddInParameter(command, "@DescripcionComercial", DbType.AnsiString, entity.DescripcionComercial);

            return Context.ExecuteNonQuery(command);
        }

        public IDataReader GetMatrizComercialByCodigoSAP(string codigoSAP)
        {
            DbCommand command = Context.Database.GetStoredProcCommand("dbo.GetMatrizComercialByCodigoSAP");
            Context.Database.AddInParameter(command, "@CodigoSAP", DbType.AnsiString, codigoSAP);

            return Context.ExecuteReader(command);
        }

        public IDataReader GetMatrizComercialImagenByIdMatrizImagen(int idMatrizImagen, int numeroPagina, int registros)
        {
            DbCommand command = Context.Database.GetStoredProcCommand("dbo.GetImagenesByIdMatrizImagen");
            Context.Database.AddInParameter(command, "@IdMatrizComercial", DbType.AnsiString, idMatrizImagen);
            Context.Database.AddInParameter(command, "@NumeroPagina", DbType.Int32, numeroPagina);
            Context.Database.AddInParameter(command, "@Registros", DbType.Int32, registros);

            return Context.ExecuteReader(command);
        }

        public IDataReader GetMatrizComercialImagenByCodigoSap(string codigoSap, int numeroPagina, int registros)
        {
            DbCommand command = Context.Database.GetStoredProcCommand("dbo.GetMatrizImagenesByCodigoSap");
            Context.Database.AddInParameter(command, "@CodigoSap", DbType.AnsiString, codigoSap);
            Context.Database.AddInParameter(command, "@NumeroPagina", DbType.Int32, numeroPagina);
            Context.Database.AddInParameter(command, "@Registros", DbType.Int32, registros);

            return Context.ExecuteReader(command);
        }

        public IDataReader GetMatrizComercialByCampaniaAndCUV(int campania, string cuv)
        {
            DbCommand command = Context.Database.GetStoredProcCommand("dbo.GetMatrizComercialByCampaniaAndCUV");
            Context.Database.AddInParameter(command, "@CampaniaID", DbType.Int32, campania);
            Context.Database.AddInParameter(command, "@CUV", DbType.AnsiString, cuv);

            return Context.ExecuteReader(command);
        }

        public IDataReader GetImagenesByCodigoSAP(string codigoSAP)
        {
            DbCommand command = Context.Database.GetStoredProcCommand("dbo.GetImagenesByCodigoSAP");
            Context.Database.AddInParameter(command, "@CodigoSAP", DbType.AnsiString, codigoSAP);

            return Context.ExecuteReader(command);
        }

        public IDataReader GetImagenByNemotecnico(int idMatrizImagen, string cuv2, string codigoSAP, int estrategiaID, int campaniaID, int tipoEstrategiaID, string nemotecnico, int tipoBusqueda, int numeroPagina, int registros)
        {
            StringBuilder query = new StringBuilder();

            query.Append("SELECT *,COUNT(*) OVER() AS TotalRegistros FROM (");

            if (!String.IsNullOrEmpty(cuv2))
            {
                query.Append("SELECT isnull(IdMatrizComercialImagen,0) IdMatrizComercialImagen, ");
                query.Append("mci.IdMatrizComercial, isnull(mci.Foto, '''') Foto, mci.NemoTecnico, mci.FechaRegistro ");
                query.Append("FROM dbo.Estrategia e ");
                query.Append("INNER JOIN ods.productocomercial pc on e.cuv2 = pc.cuv ");
                query.Append("INNER JOIN MatrizComercial mc ON mc.CodigoSAP = pc.CodigoProducto ");
                query.Append("INNER JOIN ods.Campania c ON c.CampaniaID = pc.CampaniaID AND c.codigo = e.campaniaID ");
                query.Append("INNER JOIN MatrizComercialImagen mci on mci.IdMatrizComercial = mc.IdMatrizComercial ");
                query.Append(String.Format(" WHERE (({0} = 0) OR (e.EstrategiaID = {0} )) ", estrategiaID));
                query.Append(String.Format(" AND (({0} = '')  OR (e.CUV2 = {0})) ", cuv2));
                query.Append(String.Format(" AND (({0} = 0) OR (e.CampaniaID = {0})) ", campaniaID));
                query.Append(String.Format(" AND (({0} = 0) OR (e.TipoEstrategiaID = {0})) ", tipoEstrategiaID));

            }
            else if (!String.IsNullOrEmpty(codigoSAP))
            {
                query.Append("SELECT isnull(IdMatrizComercialImagen,0)IdMatrizComercialImagen, ");
                query.Append("mc.IdMatrizComercial, isnull(Foto,'''') Foto, mci.NemoTecnico, mci.FechaRegistro FROM MatrizComercial mc ");
                query.Append("left join MatrizComercialImagen mci on mci.idMatrizComercial=mc.idMatrizComercial ");
                query.Append(String.Format("where mc.CodigoSAP = '{0}'", codigoSAP));
            }
            else
            {
                query.Append("SELECT isnull(IdMatrizComercialImagen, 0) IdMatrizComercialImagen,");
                query.Append(" IdMatrizComercial, isnull(Foto, '''') Foto, NemoTecnico, FechaRegistro FROM MatrizComercialImagen ");
                query.Append(String.Format(" WHERE (({0} = 0) OR idMatrizComercial = {0}) ", idMatrizImagen));
            }

            String[] nemotecnicoItems = nemotecnico.Split('&');

            foreach (String nemotecnicoItem in nemotecnicoItems)
            {
                query.Append(String.Format(" AND Nemotecnico like '%{0}%' ", nemotecnicoItem));
            }

            if (tipoBusqueda.Equals(Constantes.TipoBusqueda.Exacta))
            {
                query.Append(String.Format("AND LEN(Nemotecnico) ={0}", nemotecnico.Length));
            }

            query.Append(" ) as T order by FechaRegistro desc");
            query.Append(String.Format(" OFFSET({0} - 1) * {1} ROWS", numeroPagina, registros));
            query.Append(String.Format(" FETCH NEXT {0} ROWS ONLY; ", registros));

            DbCommand command = Context.Database.GetStoredProcCommand("dbo.GetImagenesByNemotecnico");
            Context.Database.AddInParameter(command, "@NemoTecnico", DbType.AnsiString, query.ToString());

            return Context.ExecuteReader(command);
        }

        public int UpdMatrizComercialDescripcionMasivo(IEnumerable<BEMatrizComercial> lstmatriz, string UsuarioRegistro)
        {
            var descripProductosReader = new GenericDataReader<BEMatrizComercial>(lstmatriz);

            var command = new SqlCommand("dbo.UpdMatrizComercialDescripcionMasivo");
            command.CommandType = CommandType.StoredProcedure;

            var parameter1 = new SqlParameter("@DescProductos", SqlDbType.Structured);
            parameter1.TypeName = "dbo.DescripcionProductoType";
            parameter1.Value = descripProductosReader;
            command.Parameters.Add(parameter1);

            var parameter2 = new SqlParameter("@UsuarioRegistro", SqlDbType.VarChar);
            parameter2.Value = UsuarioRegistro;
            command.Parameters.Add(parameter2);

            return Context.ExecuteNonQuery(command);
        }

        public IDataReader GetOfertaProductosPortal(int TipoOfertaSisID, int DuplaConsultora, int CodigoCampania)
        {
            DbCommand command = Context.Database.GetStoredProcCommand("dbo.GetOfertasPortal");
            Context.Database.AddInParameter(command, "@TipoOfertaSisID", DbType.Int32, TipoOfertaSisID);
            Context.Database.AddInParameter(command, "@DuplaConsultora", DbType.Int32, DuplaConsultora);
            Context.Database.AddInParameter(command, "@CodigoCampania", DbType.Int32, CodigoCampania);

            return Context.ExecuteReader(command);
        }

        public IDataReader GetOfertaProductosPortal2(int TipoOfertaSisID, int DuplaConsultora, int CodigoCampania, int Offset, int CantidadRegistros)
        {
            DbCommand command = Context.Database.GetStoredProcCommand("dbo.GetOfertasPortal_2_SB2");
            Context.Database.AddInParameter(command, "@TipoOfertaSisID", DbType.Int32, TipoOfertaSisID);
            Context.Database.AddInParameter(command, "@DuplaConsultora", DbType.Int32, DuplaConsultora);
            Context.Database.AddInParameter(command, "@CodigoCampania", DbType.Int32, CodigoCampania);
            Context.Database.AddInParameter(command, "@Offset", DbType.Int32, Offset);
            Context.Database.AddInParameter(command, "@CantidadRegistros", DbType.Int32, CantidadRegistros);

            return Context.ExecuteReader(command);
        }

        public int InsPedidoWebOferta(BEPedidoWeb pedidoweb)
        {
            DbCommand command = Context.Database.GetStoredProcCommand("dbo.InsPedidoWebOferta");
            Context.Database.AddInParameter(command, "@CampaniaID", DbType.Int32, pedidoweb.CampaniaID);
            Context.Database.AddInParameter(command, "@ConsultoraID", DbType.Int32, pedidoweb.ConsultoraID);
            Context.Database.AddInParameter(command, "@PaisID", DbType.Byte, pedidoweb.PaisID);
            Context.Database.AddOutParameter(command, "@PedidoID", DbType.Int32, pedidoweb.PedidoID);
            Context.Database.AddInParameter(command, "@CodigoUsuarioCreacion", DbType.String, pedidoweb.CodigoUsuarioCreacion);

            Context.ExecuteNonQuery(command);
            return Convert.ToInt32(command.Parameters["@PedidoID"].Value);
        }

        public int UpdPedidoWebTotalesOferta(long ConsultoraID, int CampaniaID, string CodigoUsuario)
        {
            DbCommand command = Context.Database.GetStoredProcCommand("dbo.UpdPedidoWebTotalesOferta");
            Context.Database.AddInParameter(command, "@ConsultoraID", DbType.Int32, ConsultoraID);
            Context.Database.AddInParameter(command, "@CampaniaID", DbType.Int32, CampaniaID);
            Context.Database.AddInParameter(command, "@CodigoUsuarioModificacion", DbType.String, CodigoUsuario);

            return Context.ExecuteNonQuery(command);
        }

        public int InsPedidoWebDetalleOferta(BEPedidoWebDetalle pedidowebdetalle)
        {
            DbCommand command = Context.Database.GetStoredProcCommand("dbo.InsPedidoWebDetalleOferta_SB2");
            Context.Database.AddInParameter(command, "@CampaniaID", DbType.Int32, pedidowebdetalle.CampaniaID);
            Context.Database.AddInParameter(command, "@ConsultoraID", DbType.Int32, pedidowebdetalle.ConsultoraID);
            Context.Database.AddInParameter(command, "@MarcaID", DbType.Byte, pedidowebdetalle.MarcaID);
            Context.Database.AddInParameter(command, "@Cantidad", DbType.Int32, pedidowebdetalle.Cantidad);
            Context.Database.AddInParameter(command, "@PrecioUnidad", DbType.Decimal, pedidowebdetalle.PrecioUnidad);
            Context.Database.AddInParameter(command, "@CUV", DbType.AnsiString, pedidowebdetalle.CUV);
            Context.Database.AddInParameter(command, "@ConfiguracionOfertaID", DbType.Int32, pedidowebdetalle.ConfiguracionOfertaID);
            Context.Database.AddInParameter(command, "@TipoOfertaSisID", DbType.Int32, pedidowebdetalle.TipoOfertaSisID);
            Context.Database.AddInParameter(command, "@PaisID", DbType.Int32, pedidowebdetalle.PaisID);
            Context.Database.AddInParameter(command, "@IPUsuario", DbType.AnsiString, pedidowebdetalle.IPUsuario);
            Context.Database.AddInParameter(command, "@CodigoUsuarioCreacion", DbType.String, pedidowebdetalle.CodigoUsuarioCreacion);

            Context.Database.AddInParameter(command, "@OrigenPedidoWeb", DbType.Int32, pedidowebdetalle.OrigenPedidoWeb);
            Context.Database.AddInParameter(command, "@EsCompraPorCompra", DbType.Boolean, pedidowebdetalle.EsCompraPorCompra);
            Context.Database.AddInParameter(command, "@TipoEstrategiaID", DbType.Int32, pedidowebdetalle.TipoEstrategiaID);

            return Context.ExecuteNonQuery(command);
        }

        public int UpdPedidoWebOferta(BEPedidoWebDetalle pedidowebdetalle)
        {
            DbCommand command = Context.Database.GetStoredProcCommand("dbo.UpdPedidoWebDetalleOferta");

            Context.Database.AddInParameter(command, "@ConsultoraID", DbType.Int32, pedidowebdetalle.ConsultoraID);
            Context.Database.AddInParameter(command, "@CampaniaID", DbType.Int32, pedidowebdetalle.CampaniaID);
            Context.Database.AddInParameter(command, "@CUV", DbType.AnsiString, pedidowebdetalle.CUV);
            Context.Database.AddInParameter(command, "@Cantidad", DbType.Int32, pedidowebdetalle.Cantidad);
            Context.Database.AddInParameter(command, "@CantidadAnterior", DbType.Int32, pedidowebdetalle.CantidadAnterior);
            Context.Database.AddInParameter(command, "@PrecioUnidad", DbType.Decimal, pedidowebdetalle.PrecioUnidad);
            Context.Database.AddInParameter(command, "@TipoOfertaSisID", DbType.Int32, pedidowebdetalle.TipoOfertaSisID);
            Context.Database.AddInParameter(command, "@CodigoUsuarioModificacion", DbType.String, pedidowebdetalle.CodigoUsuarioModificacion);

            Context.Database.AddInParameter(command, "@OrigenPedidoWeb", DbType.Int16, pedidowebdetalle.OrigenPedidoWeb);

            return Context.ExecuteNonQuery(command);
        }

        public int GetStockOfertaProductoLiquidacion(int CampaniaID, string CUV)
        {
            DbCommand command = Context.Database.GetStoredProcCommand("dbo.ValidarStockOfertaLiquidacion");
            Context.Database.AddInParameter(command, "@CampaniaID", DbType.Int32, CampaniaID);
            Context.Database.AddInParameter(command, "@CUV", DbType.AnsiString, CUV);

            return int.Parse(Context.ExecuteScalar(command).ToString());
        }

        public int GetUnidadesPermitidasByCuv(int CampaniaID, string CUV)
        {
            DbCommand command = Context.Database.GetStoredProcCommand("dbo.ValidarUnidadesPermitidasByCUV");
            Context.Database.AddInParameter(command, "@CampaniaID", DbType.Int32, CampaniaID);
            Context.Database.AddInParameter(command, "@CUV", DbType.AnsiString, CUV);

            return int.Parse(Context.ExecuteScalar(command).ToString());
        }

        #region Configuracion Oferta

        public int InsConfiguracionOferta(BEConfiguracionOferta entidad)
        {
            DbCommand command = Context.Database.GetStoredProcCommand("dbo.InsConfiguracionOferta");

            Context.Database.AddInParameter(command, "@TipoOfertaSisID", DbType.Int32, entidad.TipoOfertaSisID);
            Context.Database.AddInParameter(command, "@CodigoOferta", DbType.AnsiString, entidad.CodigoOferta);
            Context.Database.AddInParameter(command, "@Descripcion", DbType.AnsiString, entidad.Descripcion);
            return Context.ExecuteNonQuery(command);
        }

        public int UpdConfiguracionOferta(BEConfiguracionOferta entidad)
        {
            DbCommand command = Context.Database.GetStoredProcCommand("dbo.UpdConfiguracionOferta");

            Context.Database.AddInParameter(command, "@ConfiguracionOfertaID", DbType.Int32, entidad.ConfiguracionOfertaID);
            Context.Database.AddInParameter(command, "@TipoOfertaSisID", DbType.Int32, entidad.TipoOfertaSisID);
            Context.Database.AddInParameter(command, "@CodigoOferta", DbType.AnsiString, entidad.CodigoOferta);
            Context.Database.AddInParameter(command, "@Descripcion", DbType.AnsiString, entidad.Descripcion);
            return Context.ExecuteNonQuery(command);
        }

        public int DelConfiguracionOferta(int ConfiguracionOfertaID)
        {
            DbCommand command = Context.Database.GetStoredProcCommand("dbo.DelConfiguracionOferta");

            Context.Database.AddInParameter(command, "@ConfiguracionOfertaID", DbType.Int32, ConfiguracionOfertaID);
            return Context.ExecuteNonQuery(command);
        }

        public IDataReader GetConfiguracionOfertaAdministracion(int TipoOfertaSisID)
        {
            DbCommand command = Context.Database.GetStoredProcCommand("dbo.GetConfiguracionOferta");
            Context.Database.AddInParameter(command, "@TipoOfertaSisID", DbType.Int32, TipoOfertaSisID);

            return Context.ExecuteReader(command);
        }

        public int ValidarCodigoOfertaAdministracion(string CodigoOferta)
        {
            DbCommand command = Context.Database.GetStoredProcCommand("dbo.ValidarCodigoOfertaAdministracion");
            Context.Database.AddInParameter(command, "@CodigoOferta", DbType.AnsiString, CodigoOferta);

            return int.Parse(Context.ExecuteScalar(command).ToString());
        }

        public int ActualizarItemsMostrarLiquidacion(int Cantidad)
        {
            DbCommand command = Context.Database.GetStoredProcCommand("dbo.UpdMaxItemsLiquidacion");

            Context.Database.AddInParameter(command, "@Cantidad", DbType.Int32, Cantidad);
            return Context.ExecuteNonQuery(command);
        }

        public int ObtenerMaximoItemsaMostrarLiquidacion()
        {
            DbCommand command = Context.Database.GetStoredProcCommand("dbo.GetMaxItemsLiquidacion");

            return int.Parse(Context.ExecuteScalar(command).ToString());
        }

        public int ValidarUnidadesPermitidasEnPedido(int CampaniaID, string CUV, long ConsultoraID)
        {
            DbCommand command = Context.Database.GetStoredProcCommand("dbo.ValidarUnidadesPermitidaPedido");

            Context.Database.AddInParameter(command, "@CampaniaID", DbType.Int32, CampaniaID);
            Context.Database.AddInParameter(command, "@CUV", DbType.AnsiString, CUV);
            Context.Database.AddInParameter(command, "@ConsultoraID", DbType.Int32, ConsultoraID);
            return int.Parse(Context.ExecuteScalar(command).ToString());
        }
        #endregion

        public int ValidarUnidadesPermitidasEnPedidoZA(int CampaniaID, string CUV, long ConsultoraID, int TipoOfertaSisID)
        {
            DbCommand command = Context.Database.GetStoredProcCommand("dbo.ValidarUnidadesPermitidaPedidoZA");

            Context.Database.AddInParameter(command, "@CampaniaID", DbType.Int32, CampaniaID);
            Context.Database.AddInParameter(command, "@CUV", DbType.AnsiString, CUV);
            Context.Database.AddInParameter(command, "@ConsultoraID", DbType.Int32, ConsultoraID);
            Context.Database.AddInParameter(command, "@tipoOfertaSisID", DbType.Int32, TipoOfertaSisID);
            return int.Parse(Context.ExecuteScalar(command).ToString());
        }
        public int GetUnidadesPermitidasByCuvZA(int CampaniaID, string CUV, int TipoOfertaSisID)
        {
            DbCommand command = Context.Database.GetStoredProcCommand("dbo.ValidarUnidadesPermitidasByCUVZA");
            Context.Database.AddInParameter(command, "@CampaniaID", DbType.Int32, CampaniaID);
            Context.Database.AddInParameter(command, "@CUV", DbType.AnsiString, CUV);
            Context.Database.AddInParameter(command, "@tipoOfertaSisID", DbType.Int32, TipoOfertaSisID);
            return int.Parse(Context.ExecuteScalar(command).ToString());
        }
        public int ObtenerMaximoItemsaMostrarZA()
        {
            DbCommand command = Context.Database.GetStoredProcCommand("dbo.GetMaxItemsZA");
            return int.Parse(Context.ExecuteScalar(command).ToString());
        }
        public int ActualizarItemsMostrarZA(int Cantidad)
        {
            DbCommand command = Context.Database.GetStoredProcCommand("dbo.UpdMaxItemsZA");

            Context.Database.AddInParameter(command, "@Cantidad", DbType.Int32, Cantidad);
            return Context.ExecuteNonQuery(command);
        }
        public IDataReader GetDatosAdmStockMinimoCorreosZA(int TipoOfertaSisID)
        {
            DbCommand command = Context.Database.GetStoredProcCommand("dbo.GetAdmStockMinimoCorreosZA");
            Context.Database.AddInParameter(command, "@tipoOfertaSisID", DbType.Int32, TipoOfertaSisID);
            return Context.ExecuteReader(command);
        }
        public int InsAdministracionStockMinimoZA(BEAdministracionOfertaProducto entity)
        {
            DbCommand command = Context.Database.GetStoredProcCommand("dbo.InsAdministracionStockMinimoZA");
            Context.Database.AddInParameter(command, "@Correos", DbType.AnsiString, entity.Correos);
            Context.Database.AddInParameter(command, "@StockMinimo", DbType.Int32, entity.StockMinimo);
            Context.Database.AddInParameter(command, "@UsuarioRegistro", DbType.AnsiString, entity.UsuarioRegistro);
            Context.Database.AddInParameter(command, "@tipoOfertaSisID", DbType.Int32, entity.OfertaAdmID);
            return Context.ExecuteNonQuery(command);
        }
        public int UpdAdministracionStockMinimoZA(BEAdministracionOfertaProducto entity)
        {
            DbCommand command = Context.Database.GetStoredProcCommand("dbo.UpdAdministracionStockMinimoZA");
            Context.Database.AddInParameter(command, "@Correos", DbType.AnsiString, entity.Correos);
            Context.Database.AddInParameter(command, "@StockMinimo", DbType.Int32, entity.StockMinimo);
            Context.Database.AddInParameter(command, "@UsuarioModificacion", DbType.AnsiString, entity.UsuarioModificacion);
            Context.Database.AddInParameter(command, "@tipoOfertaSisID", DbType.Int32, entity.OfertaAdmID);
            return Context.ExecuteNonQuery(command);
        }

        public int EliminarTallaColor(BEOfertaProducto entidad)
        {
            int result;
            using (DbCommand command = Context.Database.GetStoredProcCommand("dbo.EliminarTallaColorLiquidacion"))
            {
                Context.Database.AddInParameter(command, "@ID", DbType.Int32, entidad.ID);

                result = Context.ExecuteNonQuery(command);
            }
            return result;
        }
        public int InsertTallaColorCUV(BEOfertaProducto entidad)
        {
            int result;
            using (DbCommand command = Context.Database.GetStoredProcCommand("dbo.InsertarTallaColorLiquidacion"))
            {
                Context.Database.AddInParameter(command, "@ID", DbType.Int32, entidad.ID);
                Context.Database.AddInParameter(command, "@CampaniaID", DbType.Int32, entidad.CampaniaID);
                Context.Database.AddInParameter(command, "@CUV", DbType.String, entidad.CUV);
                Context.Database.AddInParameter(command, "@Tipo", DbType.String, entidad.Tipo);
                Context.Database.AddInParameter(command, "@Descripcion", DbType.String, entidad.DescripcionTallaColor);
                Context.Database.AddInParameter(command, "@UsuarioRegistro", DbType.String, entidad.UsuarioRegistro);
                Context.Database.AddInParameter(command, "@UsuarioModificacion", DbType.String, entidad.UsuarioModificacion);
                Context.Database.AddInParameter(command, "@CUVPadre", DbType.String, entidad.CUVPadre);
                Context.Database.AddInParameter(command, "@DescripcionCUV", DbType.String, entidad.DescripcionCUV);

                result = Context.ExecuteNonQuery(command);
            }
            return result;
        }
        public IDataReader GetTallaColor(BEOfertaProducto entidad)
        {
            using (DbCommand command = Context.Database.GetStoredProcCommand("dbo.ListarTallaColorLiquidacion"))
            {
                Context.Database.AddInParameter(command, "@CUV", DbType.String, entidad.CUV);
                Context.Database.AddInParameter(command, "@CampaniaID", DbType.Int32, entidad.CampaniaID);
                return Context.ExecuteReader(command);
            }
        }
        public IDataReader ConsultarLiquidacionByCUV(BEOfertaProducto entidad)
        {
            using (DbCommand command = Context.Database.GetStoredProcCommand("dbo.ConsultarLiquidacionByCUV"))
            {
                Context.Database.AddInParameter(command, "@CampaniaID", DbType.Int32, entidad.CampaniaID);
                Context.Database.AddInParameter(command, "@CUV", DbType.String, entidad.CUV);
                return Context.ExecuteReader(command);
            }
        }
        public int CantidadPedidoByConsultora(BEOfertaProducto entidad)
        {
            int result;
            using (DbCommand command = Context.Database.GetStoredProcCommand("dbo.CantidadPedidoByConsultora"))
            {
                Context.Database.AddInParameter(command, "@CampaniaID", DbType.Int32, entidad.CampaniaID);
                Context.Database.AddInParameter(command, "@CUV", DbType.String, entidad.CUV);
                Context.Database.AddInParameter(command, "@ConsultoraID", DbType.String, entidad.ConsultoraID);

                result = Convert.ToInt32(Context.ExecuteScalar(command).ToString());
            }
            return result;
        }

        public int RemoverOfertaLiquidacion(BEOfertaProducto entity)
        {
            DbCommand command = Context.Database.GetStoredProcCommand("dbo.RemoverOfertaLiquidacion");
            Context.Database.AddInParameter(command, "@CampaniaID", DbType.Int32, entity.CampaniaID);
            Context.Database.AddInParameter(command, "@CUV", DbType.AnsiString, entity.CUV);

            return Context.ExecuteNonQuery(command);
        }
    }
}