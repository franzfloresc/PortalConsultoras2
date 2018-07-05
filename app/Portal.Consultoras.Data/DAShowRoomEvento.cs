using OpenSource.Library.DataAccess;
using Portal.Consultoras.Entities;
using Portal.Consultoras.Entities.ShowRoom;
using System;
using System.Collections.Generic;
using System.Data;
using System.Data.Common;
using System.Data.SqlClient;

namespace Portal.Consultoras.Data
{
    public class DAShowRoomEvento : DataAccess
    {
        public DAShowRoomEvento(int paisID)
            : base(paisID, EDbSource.Portal)
        {

        }

        public IDataReader GetShowRoomEventoByCampaniaID(int campaniaID)
        {
            using (DbCommand command = Context.Database.GetStoredProcCommand("ShowRoom.GetShowRoomEventoByCampaniaID"))
            {
                Context.Database.AddInParameter(command, "@CampaniaID", DbType.Int32, campaniaID);
                return Context.ExecuteReader(command);
            }
        }

        public int InsertShowRoomEvento(BEShowRoomEvento showRoomEvento)
        {
            DbCommand command = Context.Database.GetStoredProcCommand("ShowRoom.InsertShowRoomEvento");
            Context.Database.AddOutParameter(command, "@EventoID", DbType.Int32, 4);
            Context.Database.AddInParameter(command, "@CampaniaID", DbType.Int32, showRoomEvento.CampaniaID);
            Context.Database.AddInParameter(command, "@Nombre", DbType.String, showRoomEvento.Nombre);
            Context.Database.AddInParameter(command, "@Tema", DbType.String, showRoomEvento.Tema);
            Context.Database.AddInParameter(command, "@DiasAntes", DbType.Int32, showRoomEvento.DiasAntes);
            Context.Database.AddInParameter(command, "@DiasDespues", DbType.Int32, showRoomEvento.DiasDespues);
            Context.Database.AddInParameter(command, "@NumeroPerfiles", DbType.Int32, showRoomEvento.NumeroPerfiles);
            Context.Database.AddInParameter(command, "@UsuarioCreacion", DbType.String, showRoomEvento.UsuarioCreacion);
            Context.Database.AddInParameter(command, "@TieneCategoria", DbType.Boolean, showRoomEvento.TieneCategoria);
            Context.Database.AddInParameter(command, "@TieneCompraXcompra", DbType.Boolean, showRoomEvento.TieneCompraXcompra);
            Context.Database.AddInParameter(command, "@TieneSubCampania", DbType.Boolean, showRoomEvento.TieneSubCampania);
            Context.Database.AddInParameter(command, "@TienePersonalizacion", DbType.Boolean, showRoomEvento.TienePersonalizacion);

            Context.ExecuteNonQuery(command);

            return Convert.ToInt32(command.Parameters["@EventoID"].Value);
        }

        public void InsertarShowRoomPerfil(int numeroPerfiles, string formatoPerfiles, int eventoId)
        {
            DbCommand command = Context.Database.GetStoredProcCommand("ShowRoom.InsertarShowRoomPerfil");
            Context.Database.AddInParameter(command, "@NumeroPerfiles", DbType.Int32, numeroPerfiles);
            Context.Database.AddInParameter(command, "@FormatoPerfiles", DbType.String, formatoPerfiles);
            Context.Database.AddInParameter(command, "@EventoID", DbType.Int32, eventoId);

            Context.ExecuteNonQuery(command);
        }

        public void UpdateShowRoomEvento(BEShowRoomEvento showRoomEvento)
        {
            DbCommand command = Context.Database.GetStoredProcCommand("ShowRoom.UpdateShowRoomEvento");
            Context.Database.AddInParameter(command, "@EventoID", DbType.Int32, showRoomEvento.EventoID);
            Context.Database.AddInParameter(command, "@CampaniaID", DbType.Int32, showRoomEvento.CampaniaID);
            Context.Database.AddInParameter(command, "@Nombre", DbType.String, showRoomEvento.Nombre);
            Context.Database.AddInParameter(command, "@Tema", DbType.String, showRoomEvento.Tema);
            Context.Database.AddInParameter(command, "@DiasAntes", DbType.Int32, showRoomEvento.DiasAntes);
            Context.Database.AddInParameter(command, "@DiasDespues", DbType.Int32, showRoomEvento.DiasDespues);
            Context.Database.AddInParameter(command, "@NumeroPerfiles", DbType.Int32, showRoomEvento.NumeroPerfiles);
            Context.Database.AddInParameter(command, "@UsuarioModificacion", DbType.String, showRoomEvento.UsuarioModificacion);
            Context.Database.AddInParameter(command, "@Estado", DbType.Int32, showRoomEvento.Estado);
            Context.Database.AddInParameter(command, "@TieneCategoria", DbType.Boolean, showRoomEvento.TieneCategoria);
            Context.Database.AddInParameter(command, "@TieneCompraXcompra", DbType.Boolean, showRoomEvento.TieneCompraXcompra);
            Context.Database.AddInParameter(command, "@TieneSubCampania", DbType.Boolean, showRoomEvento.TieneSubCampania);
            Context.Database.AddInParameter(command, "@TienePersonalizacion", DbType.Boolean, showRoomEvento.TienePersonalizacion);

            Context.ExecuteNonQuery(command);
        }

        public int CargarMasivaConsultora(List<BEShowRoomEventoConsultora> listaConsultora)
        {
            var listaConsultoraReader = new GenericDataReader<BEShowRoomEventoConsultora>(listaConsultora);

            var command = new SqlCommand("ShowRoom.InsertShowRoomCargarMasivaConsultora");
            command.CommandType = CommandType.StoredProcedure;

            var parameter1 = new SqlParameter("@EventoConsultora", SqlDbType.Structured);
            parameter1.TypeName = "ShowRoom.EventoConsultoraType";
            parameter1.Value = listaConsultoraReader;
            command.Parameters.Add(parameter1);

            return Context.ExecuteNonQuery(command);
        }

        [Obsolete("Migrado PL50-50")]
        public int UpdOfertaShowRoomStockMasivo(IEnumerable<BEShowRoomOferta> stockProductos)
        {
            var ofertaShowRoomReader = new GenericDataReader<BEShowRoomOferta>(stockProductos);

            var command = new SqlCommand("ShowRoom.UpdStockOfertaShowRoomMasivo");
            command.CommandType = CommandType.StoredProcedure;

            var parameter = new SqlParameter("@StockPrecioOfertaShowRoom", SqlDbType.Structured);
            parameter.TypeName = "ShowRoom.StockPrecioOfertaShowRoomType";
            parameter.Value = ofertaShowRoomReader;
            command.Parameters.Add(parameter);

            return Context.ExecuteNonQuery(command);
        }

        [Obsolete("Migrado PL50-50")]
        public int CargarMasivaDescripcionSets(int campaniaID, string usuarioCreacion, List<BEShowRoomOfertaDetalle> listaShowRoomOfertaDetalle, string nombreArchivoCargado, string nombreArchivoGuardado)
        {
            var ofertaShowRoomReader = new GenericDataReader<BEShowRoomOfertaDetalle>(listaShowRoomOfertaDetalle);

            var command = new SqlCommand("ShowRoom.InsertCargaMasivaOfertaDetalle");
            command.CommandType = CommandType.StoredProcedure;

            var parameter = new SqlParameter("@OfertaShowRoomDetalle", SqlDbType.Structured);
            parameter.TypeName = "ShowRoom.OfertaShowRoomDetalleType";
            parameter.Value = ofertaShowRoomReader;
            command.Parameters.Add(parameter);

            parameter = new SqlParameter("@CampaniaID", SqlDbType.Int);
            parameter.Value = campaniaID;
            command.Parameters.Add(parameter);

            parameter = new SqlParameter("@UsuarioCreacion", SqlDbType.VarChar, 50);
            parameter.Value = usuarioCreacion;
            command.Parameters.Add(parameter);

            parameter = new SqlParameter("@NombreArchivoCargado", SqlDbType.VarChar, 150);
            parameter.Value = nombreArchivoCargado;
            command.Parameters.Add(parameter);

            parameter = new SqlParameter("@NombreArchivoGuardado", SqlDbType.VarChar, 150);
            parameter.Value = nombreArchivoGuardado;
            command.Parameters.Add(parameter);

            return Context.ExecuteNonQuery(command);
        }

        public int CargarProductoCpc(int eventoId, string usuarioCreacion, List<BEShowRoomCompraPorCompra> listaShowRoomCompraPorCompra)
        {
            var ofertaShowRoomReader = new GenericDataReader<BEShowRoomCompraPorCompra>(listaShowRoomCompraPorCompra);

            var command = new SqlCommand("ShowRoom.InsertCargarProductoCpc");
            command.CommandType = CommandType.StoredProcedure;

            var parameter = new SqlParameter("@OfertaShowRoomCompraPorCompra", SqlDbType.Structured);
            parameter.TypeName = "ShowRoom.OfertaShowRoomCompraPorCompraType";
            parameter.Value = ofertaShowRoomReader;
            command.Parameters.Add(parameter);

            parameter = new SqlParameter("@EventoID", SqlDbType.Int);
            parameter.Value = eventoId;
            command.Parameters.Add(parameter);

            parameter = new SqlParameter("@UsuarioCreacion", SqlDbType.VarChar, 50);
            parameter.Value = usuarioCreacion;
            command.Parameters.Add(parameter);


            return Context.ExecuteNonQuery(command);
        }

        public IDataReader GetShowRoomConsultora(int campaniaID, string codigoConsultora)
        {
            using (DbCommand command = Context.Database.GetStoredProcCommand("ShowRoom.GetShowRoomConsultora"))
            {
                Context.Database.AddInParameter(command, "@CampaniaID", DbType.Int32, campaniaID);
                Context.Database.AddInParameter(command, "@CodigoConsultora", DbType.String, codigoConsultora);
                return Context.ExecuteReader(command);
            }
        }

        public IDataReader GetShowRoomConsultoraPersonalizacion(int campaniaID, string codigoConsultora)
        {
            using (DbCommand command = Context.Database.GetStoredProcCommand("ShowRoom.GetShowRoomConsultoraPersonalizada"))
            {
                Context.Database.AddInParameter(command, "@CampaniaID", DbType.Int32, campaniaID);
                Context.Database.AddInParameter(command, "@CodigoConsultora", DbType.String, codigoConsultora);
                return Context.ExecuteReader(command);
            }
        }

        public void UpdateShowRoomConsultoraMostrarPopup(int campaniaID, string codigoConsultora, bool mostrarPopup)
        {
            DbCommand command = Context.Database.GetStoredProcCommand("ShowRoom.UpdateShowRoomConsultoraMostrarPopup");
            Context.Database.AddInParameter(command, "@CampaniaID", DbType.Int32, campaniaID);
            Context.Database.AddInParameter(command, "@CodigoConsultora", DbType.String, codigoConsultora);
            Context.Database.AddInParameter(command, "@MostrarPopup", DbType.Boolean, mostrarPopup);

            Context.ExecuteNonQuery(command);
        }

        [Obsolete("Migrado PL50-50")]
        public IDataReader GetProductosShowRoom(int campaniaID)
        {
            DbCommand command = Context.Database.GetStoredProcCommand("ShowRoom.GetProductosShowRoom");
            Context.Database.AddInParameter(command, "@CampaniaID", DbType.Int32, campaniaID);

            return Context.ExecuteReader(command);
        }

        [Obsolete("Migrado PL50-50")]
        public int GetOrdenPriorizacionShowRoom(int ConfiguracionOfertaID, int CampaniaID)
        {
            DbCommand command = Context.Database.GetStoredProcCommand("ShowRoom.GetPriorizacionShowRoomByTipoOferta");
            Context.Database.AddInParameter(command, "@ConfiguracionOfertaID", DbType.Int32, ConfiguracionOfertaID);
            Context.Database.AddInParameter(command, "@CampaniaID", DbType.Int32, CampaniaID);

            return int.Parse(Context.ExecuteScalar(command).ToString());
        }

        [Obsolete("Migrado PL50-50")]
        public int ValidarPriorizacionShowRoom(int ConfiguracionOfertaID, int CampaniaID, int Orden)
        {
            DbCommand command = Context.Database.GetStoredProcCommand("ShowRoom.ValidarPriorizacionShowRoomByTipoOferta");
            Context.Database.AddInParameter(command, "@ConfiguracionOfertaID", DbType.Int32, ConfiguracionOfertaID);
            Context.Database.AddInParameter(command, "@CampaniaID", DbType.Int32, CampaniaID);
            Context.Database.AddInParameter(command, "@Orden", DbType.Int32, Orden);

            return int.Parse(Context.ExecuteScalar(command).ToString());
        }

        [Obsolete("Migrado PL50-50")]
        public int ValidadStockOfertaShowRoom(BEShowRoomOferta entity)
        {
            DbCommand command = Context.Database.GetStoredProcCommand("ShowRoom.UpdOfertaShowRoomValidaStock");
            Context.Database.AddInParameter(command, "@CampaniaID", DbType.Int32, entity.CampaniaID);
            Context.Database.AddInParameter(command, "@CUV", DbType.AnsiString, entity.CUV);
            Context.Database.AddInParameter(command, "@CantidadIncrementa", DbType.Int32, entity.CantidadIncrementa);
            Context.Database.AddOutParameter(command, "@StockResultado", DbType.Int32, entity.StockResultado);
            Context.ExecuteNonQuery(command);
            return Convert.ToInt32(command.Parameters["@StockResultado"].Value);
        }

        [Obsolete("Migrado PL50-50")]
        public int InsOfertaShowRoom(BEShowRoomOferta entity)
        {
            DbCommand command = Context.Database.GetStoredProcCommand("ShowRoom.InsOfertaShowRoom");
            Context.Database.AddInParameter(command, "@CampaniaID", DbType.Int32, entity.CampaniaID);
            Context.Database.AddInParameter(command, "@CUV", DbType.AnsiString, entity.CUV);
            Context.Database.AddInParameter(command, "@TipoOfertaSisID", DbType.Int32, entity.TipoOfertaSisID);
            Context.Database.AddInParameter(command, "@ConfiguracionOfertaID", DbType.Int32, entity.ConfiguracionOfertaID);
            Context.Database.AddInParameter(command, "@Descripcion", DbType.AnsiString, entity.Descripcion);
            Context.Database.AddInParameter(command, "@PrecioValorizado", DbType.Decimal, entity.PrecioValorizado);
            Context.Database.AddInParameter(command, "@ImagenProducto", DbType.AnsiString, entity.ImagenProducto);
            Context.Database.AddInParameter(command, "@Orden", DbType.Int32, entity.Orden);
            Context.Database.AddInParameter(command, "@UnidadesPermitidas", DbType.Int32, entity.UnidadesPermitidas);
            Context.Database.AddInParameter(command, "@FlagHabilitarProducto", DbType.Byte, entity.FlagHabilitarProducto);
            Context.Database.AddInParameter(command, "@DescripcionLegal", DbType.AnsiString, entity.DescripcionLegal);
            Context.Database.AddInParameter(command, "@UsuarioRegistro", DbType.AnsiString, entity.UsuarioRegistro);
            Context.Database.AddInParameter(command, "@ImagenMini", DbType.AnsiString, entity.ImagenMini);
            Context.Database.AddInParameter(command, "@PrecioOferta", DbType.Decimal, entity.PrecioOferta);
            Context.Database.AddInParameter(command, "@EsSubCampania", DbType.Boolean, entity.EsSubCampania);

            return Context.ExecuteNonQuery(command);
        }

        [Obsolete("Migrado PL50-50")]
        public int UpdOfertaShowRoom(BEShowRoomOferta entity)
        {
            DbCommand command = Context.Database.GetStoredProcCommand("ShowRoom.UpdOfertaShowRoom");
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
            Context.Database.AddInParameter(command, "@PrecioValorizado", DbType.Decimal, entity.PrecioValorizado);
            Context.Database.AddInParameter(command, "@ImagenMini", DbType.AnsiString, entity.ImagenMini);
            Context.Database.AddInParameter(command, "@Incrementa", DbType.Int32, entity.Incrementa);
            Context.Database.AddInParameter(command, "@CantidadIncrementa", DbType.Int32, entity.CantidadIncrementa);
            Context.Database.AddInParameter(command, "@FlagAgotado", DbType.Int32, entity.FlagAgotado);
            Context.Database.AddInParameter(command, "@PrecioOferta", DbType.Decimal, entity.PrecioOferta);
            Context.Database.AddInParameter(command, "@EsSubCampania", DbType.Boolean, entity.EsSubCampania);

            return Context.ExecuteNonQuery(command);
        }

        [Obsolete("Migrado PL50-50")]
        public int DelOfertaShowRoom(BEShowRoomOferta entity)
        {
            DbCommand command = Context.Database.GetStoredProcCommand("ShowRoom.DelOfertaShowRoom");
            Context.Database.AddInParameter(command, "@CampaniaID", DbType.Int32, entity.CampaniaID);
            Context.Database.AddInParameter(command, "@CUV", DbType.AnsiString, entity.CUV);
            Context.Database.AddInParameter(command, "@UsuarioModificacion", DbType.AnsiString, entity.UsuarioModificacion);

            return Context.ExecuteNonQuery(command);
        }

        [Obsolete("Migrado PL50-50")]
        public int InsOrUpdOfertaShowRoom(BEShowRoomOferta entity)
        {
            DbCommand command = Context.Database.GetStoredProcCommand("ShowRoom.InsOrUpdOfertaShowRoom");
            Context.Database.AddInParameter(command, "@CampaniaID", DbType.Int32, entity.CampaniaID);
            Context.Database.AddInParameter(command, "@CUV", DbType.AnsiString, entity.CUV);
            Context.Database.AddInParameter(command, "@TipoOfertaSisID", DbType.Int32, entity.TipoOfertaSisID);
            Context.Database.AddInParameter(command, "@ConfiguracionOfertaID", DbType.Int32, entity.ConfiguracionOfertaID);
            Context.Database.AddInParameter(command, "@Descripcion", DbType.AnsiString, entity.Descripcion);
            Context.Database.AddInParameter(command, "@PrecioValorizado", DbType.Decimal, entity.PrecioValorizado);
            Context.Database.AddInParameter(command, "@ImagenProducto", DbType.AnsiString, entity.ImagenProducto);
            Context.Database.AddInParameter(command, "@Orden", DbType.Int32, entity.Orden);
            Context.Database.AddInParameter(command, "@UnidadesPermitidas", DbType.Int32, entity.UnidadesPermitidas);
            Context.Database.AddInParameter(command, "@FlagHabilitarProducto", DbType.Byte, entity.FlagHabilitarProducto);
            Context.Database.AddInParameter(command, "@DescripcionLegal", DbType.AnsiString, entity.DescripcionLegal);
            Context.Database.AddInParameter(command, "@Usuario", DbType.AnsiString, entity.UsuarioRegistro);
            Context.Database.AddInParameter(command, "@ImagenMini", DbType.AnsiString, entity.ImagenMini);
            Context.Database.AddInParameter(command, "@PrecioOferta", DbType.Decimal, entity.PrecioOferta);
            Context.Database.AddInParameter(command, "@EsSubCampania", DbType.Boolean, entity.EsSubCampania);

            return Context.ExecuteNonQuery(command);
        }

        [Obsolete("Migrado PL50-50")]
        public int RemoverOfertaShowRoom(BEShowRoomOferta entity)
        {
            DbCommand command = Context.Database.GetStoredProcCommand("ShowRoom.RemoverOfertaShowRoom");
            Context.Database.AddInParameter(command, "@CampaniaID", DbType.Int32, entity.CampaniaID);
            Context.Database.AddInParameter(command, "@CUV", DbType.AnsiString, entity.CUV);

            return Context.ExecuteNonQuery(command);
        }

        public int GetUnidadesPermitidasByCuvShowRoom(int CampaniaID, string CUV)
        {
            DbCommand command = Context.Database.GetStoredProcCommand("ShowRoom.ValidarUnidadesPermitidasByCUVShowRoom");
            Context.Database.AddInParameter(command, "@CampaniaID", DbType.Int32, CampaniaID);
            Context.Database.AddInParameter(command, "@CUV", DbType.AnsiString, CUV);

            return int.Parse(Context.ExecuteScalar(command).ToString());
        }

        public int ValidarUnidadesPermitidasEnPedidoShowRoom(int CampaniaID, string CUV, long ConsultoraID)
        {
            DbCommand command = Context.Database.GetStoredProcCommand("ShowRoom.ValidarUnidadesPermitidaPedidoShowRoom");

            Context.Database.AddInParameter(command, "@CampaniaID", DbType.Int32, CampaniaID);
            Context.Database.AddInParameter(command, "@CUV", DbType.AnsiString, CUV);
            Context.Database.AddInParameter(command, "@ConsultoraID", DbType.Int32, ConsultoraID);
            return int.Parse(Context.ExecuteScalar(command).ToString());
        }

        public int CantidadPedidoByConsultoraShowRoom(BEOfertaProducto entidad)
        {
            int result;
            using (DbCommand command = Context.Database.GetStoredProcCommand("ShowRoom.CantidadPedidoByConsultoraShowRoom"))
            {
                Context.Database.AddInParameter(command, "@CampaniaID", DbType.Int32, entidad.CampaniaID);
                Context.Database.AddInParameter(command, "@CUV", DbType.String, entidad.CUV);
                Context.Database.AddInParameter(command, "@ConsultoraID", DbType.String, entidad.ConsultoraID);

                result = Convert.ToInt32(Context.ExecuteScalar(command).ToString());
            }
            return result;
        }

        public int GetStockOfertaShowRoom(int campaniaID, string cuv)
        {
            DbCommand command = Context.Database.GetStoredProcCommand("ShowRoom.ValidarStockOfertaShowRoom");
            Context.Database.AddInParameter(command, "@CampaniaID", DbType.Int32, campaniaID);
            Context.Database.AddInParameter(command, "@CUV", DbType.AnsiString, cuv);

            return int.Parse(Context.ExecuteScalar(command).ToString());
        }

        public int UpdOfertaShowRoomStockAgregar(int campaniaID, string cuv, int stock)
        {
            DbCommand command = Context.Database.GetStoredProcCommand("ShowRoom.UpdStockOfertaShowRoom");
            Context.Database.AddInParameter(command, "@CampaniaID", DbType.Int32, campaniaID);
            Context.Database.AddInParameter(command, "@CUV", DbType.AnsiString, cuv);
            Context.Database.AddInParameter(command, "@Stock", DbType.Int32, stock);

            return Context.ExecuteNonQuery(command);
        }

        public int UpdOfertaShowRoomStockActualizar(int CampaniaID, string CUV, int Stock, int Flag)
        {
            DbCommand command = Context.Database.GetStoredProcCommand("ShowRoom.UpdStockOfertaShowRoomUpd");
            Context.Database.AddInParameter(command, "@CampaniaID", DbType.Int32, CampaniaID);
            Context.Database.AddInParameter(command, "@CUV", DbType.AnsiString, CUV);
            Context.Database.AddInParameter(command, "@Stock", DbType.Int32, Stock);
            Context.Database.AddInParameter(command, "@Flag", DbType.Int32, Flag);

            return Context.ExecuteNonQuery(command);
        }

        public int UpdOfertaShowRoomStockEliminar(int CampaniaID, string CUV, int Stock)
        {
            DbCommand command = Context.Database.GetStoredProcCommand("ShowRoom.UpdStockOfertaShowRoomDel");
            Context.Database.AddInParameter(command, "@CampaniaID", DbType.Int32, CampaniaID);
            Context.Database.AddInParameter(command, "@CUV", DbType.AnsiString, CUV);
            Context.Database.AddInParameter(command, "@Stock", DbType.Int32, Stock);

            return Context.ExecuteNonQuery(command);
        }

        public int DeshabilitarShowRoomEvento(BEShowRoomEvento beShowRoomEvento)
        {
            DbCommand command = Context.Database.GetStoredProcCommand("ShowRoom.DeshabilitarShowRoomEvento");
            Context.Database.AddInParameter(command, "@EventoID", DbType.Int32, beShowRoomEvento.EventoID);
            Context.Database.AddInParameter(command, "@CampaniaID", DbType.Int32, beShowRoomEvento.CampaniaID);
            Context.Database.AddInParameter(command, "@UsuarioModificacion", DbType.String, beShowRoomEvento.UsuarioModificacion);

            return Context.ExecuteNonQuery(command);
        }

        public int EliminarShowRoomEvento(BEShowRoomEvento beShowRoomEvento)
        {
            DbCommand command = Context.Database.GetStoredProcCommand("ShowRoom.EliminarShowRoomEvento");
            Context.Database.AddInParameter(command, "@EventoID", DbType.Int32, beShowRoomEvento.EventoID);
            Context.Database.AddInParameter(command, "@CampaniaID", DbType.Int32, beShowRoomEvento.CampaniaID);

            return Context.ExecuteNonQuery(command);
        }

        public void EliminarShowRoomPerfiles(int eventoId)
        {
            DbCommand command = Context.Database.GetStoredProcCommand("ShowRoom.EliminarShowRoomPerfiles");
            Context.Database.AddInParameter(command, "@EventoID", DbType.Int32, eventoId);
            Context.ExecuteNonQuery(command);
        }

        public int GuardarImagenShowRoom(int eventoId, string nombreImagenFinal, int tipo, string usuarioModificacion)
        {
            DbCommand command = Context.Database.GetStoredProcCommand("ShowRoom.GuardarImagenShowRoom");
            Context.Database.AddInParameter(command, "@EventoID", DbType.Int32, eventoId);
            Context.Database.AddInParameter(command, "@NombreImagenFinal", DbType.String, nombreImagenFinal);
            Context.Database.AddInParameter(command, "@Tipo", DbType.Int32, tipo);
            Context.Database.AddInParameter(command, "@UsuarioModificacion", DbType.String, usuarioModificacion);

            return Context.ExecuteNonQuery(command);
        }

        public IDataReader GetProductosShowRoomDetalle(int campaniaId, string cuv)
        {
            DbCommand command = Context.Database.GetStoredProcCommand("ShowRoom.GetProductosShowRoomDetalle");
            Context.Database.AddInParameter(command, "@CampaniaID", DbType.Int32, campaniaId);
            Context.Database.AddInParameter(command, "@CUV", DbType.AnsiString, cuv);

            return Context.ExecuteReader(command);
        }

        [Obsolete("Migrado PL50-50")]
        public int InsOfertaShowRoomDetalle(BEShowRoomOfertaDetalle entity)
        {
            DbCommand command = Context.Database.GetStoredProcCommand("ShowRoom.InsOfertaShowRoomDetalle");
            Context.Database.AddInParameter(command, "@CampaniaID", DbType.Int32, entity.CampaniaID);
            Context.Database.AddInParameter(command, "@CUV", DbType.AnsiString, entity.CUV);
            Context.Database.AddInParameter(command, "@NombreProducto", DbType.AnsiString, entity.NombreProducto);
            Context.Database.AddInParameter(command, "@Descripcion1", DbType.AnsiString, entity.Descripcion1);
            Context.Database.AddInParameter(command, "@Descripcion2", DbType.AnsiString, entity.Descripcion2);
            Context.Database.AddInParameter(command, "@Descripcion3", DbType.AnsiString, entity.Descripcion3);
            Context.Database.AddInParameter(command, "@Imagen", DbType.AnsiString, entity.Imagen);
            Context.Database.AddInParameter(command, "@UsuarioCreacion", DbType.AnsiString, entity.UsuarioCreacion);
            Context.Database.AddInParameter(command, "@MarcaProducto", DbType.AnsiString, entity.MarcaProducto);

            return Context.ExecuteNonQuery(command);
        }

        [Obsolete("Migrado PL50-50")]
        public int UpdOfertaShowRoomDetalle(BEShowRoomOfertaDetalle entity)
        {
            DbCommand command = Context.Database.GetStoredProcCommand("ShowRoom.UpdOfertaShowRoomDetalle");
            Context.Database.AddInParameter(command, "@OfertaShowRoomDetalleID", DbType.Int32, entity.OfertaShowRoomDetalleID);
            Context.Database.AddInParameter(command, "@CampaniaID", DbType.Int32, entity.CampaniaID);
            Context.Database.AddInParameter(command, "@CUV", DbType.AnsiString, entity.CUV);
            Context.Database.AddInParameter(command, "@NombreProducto", DbType.AnsiString, entity.NombreProducto);
            Context.Database.AddInParameter(command, "@Descripcion1", DbType.AnsiString, entity.Descripcion1);
            Context.Database.AddInParameter(command, "@Descripcion2", DbType.AnsiString, entity.Descripcion2);
            Context.Database.AddInParameter(command, "@Descripcion3", DbType.AnsiString, entity.Descripcion3);
            Context.Database.AddInParameter(command, "@Imagen", DbType.AnsiString, entity.Imagen);
            Context.Database.AddInParameter(command, "@UsuarioModificacion", DbType.AnsiString, entity.UsuarioModificacion);
            Context.Database.AddInParameter(command, "@MarcaProducto", DbType.AnsiString, entity.MarcaProducto);

            return Context.ExecuteNonQuery(command);
        }

        [Obsolete("Migrado PL50-50")]
        public int EliminarOfertaShowRoomDetalle(BEShowRoomOfertaDetalle entity)
        {
            DbCommand command = Context.Database.GetStoredProcCommand("ShowRoom.EliminarOfertaShowRoomDetalle");
            Context.Database.AddInParameter(command, "@OfertaShowRoomDetalleID", DbType.Int32, entity.OfertaShowRoomDetalleID);
            Context.Database.AddInParameter(command, "@CampaniaID", DbType.Int32, entity.CampaniaID);
            Context.Database.AddInParameter(command, "@CUV", DbType.AnsiString, entity.CUV);

            return Context.ExecuteNonQuery(command);
        }

        [Obsolete("Migrado PL50-50")]
        public int EliminarOfertaShowRoomDetalleAll(int campaniaID, string cuv)
        {
            DbCommand command = Context.Database.GetStoredProcCommand("ShowRoom.EliminarOfertaShowRoomDetalleAll");
            Context.Database.AddInParameter(command, "@CampaniaID", DbType.Int32, campaniaID);
            Context.Database.AddInParameter(command, "@CUV", DbType.AnsiString, cuv);

            return Context.ExecuteNonQuery(command);
        }

        public int EliminarEstrategiaProductoAll(int estrategiaID, string usuario)
        {
            DbCommand command = Context.Database.GetStoredProcCommand("dbo.DeleteEstrategiaProductoAll");
            Context.Database.AddInParameter(command, "@EstrategiaID", DbType.Int32, estrategiaID);
            Context.Database.AddInParameter(command, "@UsuarioModificacion", DbType.String, usuario);

            return Context.ExecuteNonQuery(command);
        }


        public IDataReader GetShowRoomPerfiles(int eventoId)
        {
            DbCommand command = Context.Database.GetStoredProcCommand("ShowRoom.GetShowRoomPerfiles");
            Context.Database.AddInParameter(command, "@EventoID", DbType.Int32, eventoId);

            return Context.ExecuteReader(command);
        }

        [Obsolete("Migrado PL50-50")]
        public IDataReader GetShowRoomPerfilOfertaCuvs(BEShowRoomPerfilOferta beShowRoomPerfilOferta)
        {
            DbCommand command = Context.Database.GetStoredProcCommand("ShowRoom.GetShowRoomPerfilOfertaCuvs");
            Context.Database.AddInParameter(command, "@EventoID", DbType.Int32, beShowRoomPerfilOferta.EventoID);
            Context.Database.AddInParameter(command, "@PerfilID", DbType.Int32, beShowRoomPerfilOferta.PerfilID);
            Context.Database.AddInParameter(command, "@CampaniaID", DbType.Int32, beShowRoomPerfilOferta.CampaniaID);

            return Context.ExecuteReader(command);
        }

        public void GuardarPerfilOfertaShowRoom(int perfilId, int eventoId, int campaniaId, string cadenaCuv)
        {
            DbCommand command = Context.Database.GetStoredProcCommand("ShowRoom.GuardarPerfilOfertaShowRoom");
            Context.Database.AddInParameter(command, "@PerfilID", DbType.Int32, perfilId);
            Context.Database.AddInParameter(command, "@EventoID", DbType.Int32, eventoId);
            Context.Database.AddInParameter(command, "@CampaniaID", DbType.Int32, campaniaId);
            Context.Database.AddInParameter(command, "@CadenaCuv", DbType.String, cadenaCuv);
            Context.ExecuteNonQuery(command);
        }

        public IDataReader GetShowRoomOfertasConsultoraPersonalizada(int campaniaID, string codigoConsultora)
        {
            DbCommand command = Context.Database.GetStoredProcCommand("ShowRoom.GetShowRoomOfertasConsultoraPersonalizada");
            Context.Database.AddInParameter(command, "@CampaniaID", DbType.Int32, campaniaID);
            Context.Database.AddInParameter(command, "@CodigoConsultora", DbType.String, codigoConsultora);

            return Context.ExecuteReader(command);
        }

        public IDataReader GetShowRoomOfertaById(int ofertaShowRoomID)
        {
            DbCommand command = Context.Database.GetStoredProcCommand("ShowRoom.GetShowRoomOfertaById");
            Context.Database.AddInParameter(command, "@OfertaShowRoomID", DbType.Int32, ofertaShowRoomID);

            return Context.ExecuteReader(command);
        }

        public IDataReader GetShowRoomNivel()
        {
            DbCommand command = Context.Database.GetStoredProcCommand("ShowRoom.GetShowRoomNivel");

            return Context.ExecuteReader(command);
        }

        public IDataReader GetShowRoomPersonalizacion()
        {
            DbCommand command = Context.Database.GetStoredProcCommand("ShowRoom.GetShowRoomPersonalizacion");

            return Context.ExecuteReader(command);
        }

        public IDataReader GetShowRoomPersonalizacionNivel(int eventoId, int nivelId, int categoriaId)
        {
            DbCommand command = Context.Database.GetStoredProcCommand("ShowRoom.GetShowRoomPersonalizacionNivel");

            Context.Database.AddInParameter(command, "@EventoId", DbType.Int32, eventoId);
            Context.Database.AddInParameter(command, "@NivelId", DbType.Int32, nivelId);
            Context.Database.AddInParameter(command, "@CategoriaId", DbType.Int32, categoriaId);

            return Context.ExecuteReader(command);
        }

        public int InsertShowRoomPersonalizacionNivel(BEShowRoomPersonalizacionNivel entity)
        {
            DbCommand command = Context.Database.GetStoredProcCommand("ShowRoom.InsertShowRoomPersonalizacionNivel");
            Context.Database.AddInParameter(command, "@EventoID", DbType.Int32, entity.EventoID);
            Context.Database.AddInParameter(command, "@PersonalizacionId", DbType.Int32, entity.PersonalizacionId);
            Context.Database.AddInParameter(command, "@NivelId", DbType.Int32, entity.NivelId);
            Context.Database.AddInParameter(command, "@CategoriaId", DbType.Int32, entity.CategoriaId);
            Context.Database.AddInParameter(command, "@Valor", DbType.String, entity.Valor);

            return Context.ExecuteNonQuery(command);
        }

        public int UpdateShowRoomPersonalizacionNivel(BEShowRoomPersonalizacionNivel entity)
        {
            DbCommand command = Context.Database.GetStoredProcCommand("ShowRoom.UpdateShowRoomPersonalizacionNivel");
            Context.Database.AddInParameter(command, "@PersonalizacionNivelId", DbType.Int32, entity.PersonalizacionNivelId);
            Context.Database.AddInParameter(command, "@Valor", DbType.String, entity.Valor);

            return Context.ExecuteNonQuery(command);
        }

        public IDataReader GetShowRoomCategorias(int eventoId)
        {
            DbCommand command = Context.Database.GetStoredProcCommand("ShowRoom.GetShowRoomCategorias");
            Context.Database.AddInParameter(command, "@EventoId", DbType.Int32, eventoId);

            return Context.ExecuteReader(command);
        }

        public IDataReader GetShowRoomCategoriaById(int categoriaId)
        {
            DbCommand command = Context.Database.GetStoredProcCommand("ShowRoom.GetShowRoomCategoriaById");
            Context.Database.AddInParameter(command, "@CategoriaId", DbType.Int32, categoriaId);

            return Context.ExecuteReader(command);
        }

        public void UpdateShowRoomDescripcionCategoria(BEShowRoomCategoria categoria)
        {
            DbCommand command = Context.Database.GetStoredProcCommand("ShowRoom.UpdateShowRoomDescripcionCategoria");
            Context.Database.AddInParameter(command, "@CategoriaId", DbType.Int32, categoria.CategoriaId);
            Context.Database.AddInParameter(command, "@Descripcion", DbType.String, categoria.Descripcion);

            Context.ExecuteNonQuery(command);
        }

        public void DeleteShowRoomCategoriaByEvento(int eventoId)
        {
            DbCommand command = Context.Database.GetStoredProcCommand("ShowRoom.DeleteShowRoomCategoriaByEvento");
            Context.Database.AddInParameter(command, "@EventoId", DbType.Int32, eventoId);

            Context.ExecuteNonQuery(command);
        }

        public void InsertShowRoomCategoria(BEShowRoomCategoria categoria)
        {
            DbCommand command = Context.Database.GetStoredProcCommand("ShowRoom.InsertShowRoomCategoria");
            Context.Database.AddInParameter(command, "@EventoId", DbType.Int32, categoria.EventoID);
            Context.Database.AddInParameter(command, "@Codigo", DbType.String, categoria.Codigo);
            Context.Database.AddInParameter(command, "@Descripcion", DbType.String, categoria.Descripcion);

            Context.ExecuteNonQuery(command);
        }

        public IDataReader GetProductosCompraPorCompra(int EventoID, int CampaniaID)
        {
            DbCommand command = Context.Database.GetStoredProcCommand("ShowRoom.GetShowRoomCompraPorCompra");
            Context.Database.AddInParameter(command, "@EventoID", DbType.Int32, EventoID);
            Context.Database.AddInParameter(command, "@CampaniaID", DbType.Int32, CampaniaID);
            return Context.ExecuteReader(command);
        }

        public int UpdUpdEventoConsultoraPopup(BEShowRoomEventoConsultora entity, string tipo)
        {
            DbCommand command = Context.Database.GetStoredProcCommand("ShowRoom.UpdEventoConsultoraPopup");
            Context.Database.AddInParameter(command, "@Tipo", DbType.String, tipo);
            Context.Database.AddInParameter(command, "@CampaniaID", DbType.Int32, entity.CampaniaID);
            Context.Database.AddInParameter(command, "@CodigoConsultora", DbType.String, entity.CodigoConsultora);
            Context.Database.AddInParameter(command, "@EventoID", DbType.Int32, entity.EventoID);
            Context.Database.AddInParameter(command, "@EventoConsultoraID", DbType.Int32, entity.EventoConsultoraID);
            return Context.ExecuteNonQuery(command);
        }

        public int ShowRoomProgramarAviso(BEShowRoomEventoConsultora entity)
        {
            DbCommand command = Context.Database.GetStoredProcCommand("ShowRoom.UpdateEventoConsultoraProgramarAviso");
            Context.Database.AddInParameter(command, "@CampaniaID", DbType.Int32, entity.CampaniaID);
            Context.Database.AddInParameter(command, "@CodigoConsultora", DbType.String, entity.CodigoConsultora);
            Context.Database.AddInParameter(command, "@Suscripcion", DbType.Boolean, entity.Suscripcion);
            Context.Database.AddInParameter(command, "@CorreoEnvioAviso", DbType.String, entity.CorreoEnvioAviso);
            return Context.ExecuteNonQuery(command);
        }

        public int ShowRoomEventoConsultoraEmailRecibido(BEShowRoomEventoConsultora entity)
        {
            DbCommand command = Context.Database.GetStoredProcCommand("ShowRoom.EventoConsultoraEmailRecibido");
            Context.Database.AddInParameter(command, "@CampaniaID", DbType.Int32, entity.CampaniaID);
            Context.Database.AddInParameter(command, "@CodigoConsultora", DbType.String, entity.CodigoConsultora);
            return Context.ExecuteNonQuery(command);
        }

        public bool GetEventoConsultoraRecibido(string CodigoConsultora, int CampaniaID)
        {
            DbCommand command = Context.Database.GetStoredProcCommand("ShowRoom.GetEventoConsultoraRecibido");
            Context.Database.AddInParameter(command, "@CodigoConsultora", DbType.String, CodigoConsultora);
            Context.Database.AddInParameter(command, "@CampaniaID", DbType.Int32, CampaniaID);

            return (bool)Context.ExecuteScalar(command);
        }

        public IDataReader GetShowRoomTipoOferta()
        {
            DbCommand command = Context.Database.GetStoredProcCommand("ShowRoom.GetShowRoomTipoOferta");
            return Context.ExecuteReader(command);
        }

        public int ExisteShowRoomTipoOferta(BEShowRoomTipoOferta entity)
        {
            DbCommand command = Context.Database.GetStoredProcCommand("ShowRoom.ExisteShowRoomTipoOferta");
            Context.Database.AddInParameter(command, "@TipoOfertaID", DbType.Int32, entity.TipoOfertaID);
            Context.Database.AddInParameter(command, "@Codigo", DbType.String, entity.Codigo);
            Context.Database.AddInParameter(command, "@Descripcion", DbType.String, entity.Descripcion);

            return (int)Context.ExecuteScalar(command);
        }

        public int InsertShowRoomTipoOferta(BEShowRoomTipoOferta entity)
        {
            DbCommand command = Context.Database.GetStoredProcCommand("ShowRoom.InsertShowRoomTipoOferta");
            Context.Database.AddInParameter(command, "@Codigo", DbType.String, entity.Codigo);
            Context.Database.AddInParameter(command, "@Descripcion", DbType.String, entity.Descripcion);
            Context.Database.AddInParameter(command, "@UsuarioCreacion", DbType.String, entity.UsuarioCreacion);

            return Context.ExecuteNonQuery(command);
        }

        public int UpdateShowRoomTipoOferta(BEShowRoomTipoOferta entity)
        {
            DbCommand command = Context.Database.GetStoredProcCommand("ShowRoom.UpdateShowRoomTipoOferta");
            Context.Database.AddInParameter(command, "@TipoOfertaID", DbType.Int32, entity.TipoOfertaID);
            Context.Database.AddInParameter(command, "@Codigo", DbType.String, entity.Codigo);
            Context.Database.AddInParameter(command, "@Descripcion", DbType.String, entity.Descripcion);
            Context.Database.AddInParameter(command, "@UsuarioModificacion", DbType.String, entity.UsuarioCreacion);

            return Context.ExecuteNonQuery(command);
        }

        public void HabilitarShowRoomTipoOferta(BEShowRoomTipoOferta entity)
        {
            DbCommand command = Context.Database.GetStoredProcCommand("ShowRoom.HabilitarShowRoomTipoOferta");
            Context.Database.AddInParameter(command, "@TipoOfertaID", DbType.Int32, entity.TipoOfertaID);
            Context.Database.AddInParameter(command, "@Activo", DbType.String, entity.Activo);

            Context.ExecuteNonQuery(command);
        }
    }
}