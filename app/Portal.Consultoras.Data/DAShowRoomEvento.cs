using System;
using System.Collections.Generic;
using System.Data;
using System.Data.Common;
using System.Data.SqlClient;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using OpenSource.Library.DataAccess;
using Portal.Consultoras.Entities;

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
            Context.Database.AddInParameter(command, "@Imagen1", DbType.String, showRoomEvento.Imagen1);
            Context.Database.AddInParameter(command, "@Imagen2", DbType.String, showRoomEvento.Imagen2);
            Context.Database.AddInParameter(command, "@Descuento", DbType.Decimal, showRoomEvento.Descuento);
            Context.Database.AddInParameter(command, "@TextoEstrategia", DbType.String, showRoomEvento.TextoEstrategia);
            Context.Database.AddInParameter(command, "@OfertaEstrategia", DbType.Decimal, showRoomEvento.OfertaEstrategia);
            Context.Database.AddInParameter(command, "@UsuarioCreacion", DbType.String, showRoomEvento.UsuarioCreacion);

            Context.ExecuteNonQuery(command);
            return Convert.ToInt32(command.Parameters["@EventoID"].Value);
        }

        public void UpdateShowRoomEvento(BEShowRoomEvento showRoomEvento)
        {
            DbCommand command = Context.Database.GetStoredProcCommand("ShowRoom.UpdateShowRoomEvento");
            Context.Database.AddInParameter(command, "@EventoID", DbType.Int32, showRoomEvento.EventoID);
            Context.Database.AddInParameter(command, "@CampaniaID", DbType.Int32, showRoomEvento.CampaniaID);
            Context.Database.AddInParameter(command, "@Nombre", DbType.String, showRoomEvento.Nombre);
            Context.Database.AddInParameter(command, "@Imagen1", DbType.String, showRoomEvento.Imagen1);
            Context.Database.AddInParameter(command, "@Imagen2", DbType.String, showRoomEvento.Imagen2);
            Context.Database.AddInParameter(command, "@Descuento", DbType.Decimal, showRoomEvento.Descuento);
            Context.Database.AddInParameter(command, "@TextoEstrategia", DbType.String, showRoomEvento.TextoEstrategia);
            Context.Database.AddInParameter(command, "@OfertaEstrategia", DbType.Decimal, showRoomEvento.OfertaEstrategia);
            Context.Database.AddInParameter(command, "@UsuarioModificacion", DbType.String, showRoomEvento.UsuarioModificacion);

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

        public int UpdOfertaShowRoomStockMasivo(IEnumerable<BEShowRoomOferta> stockProductos)
        {
            var ofertaShowRoomReader = new GenericDataReader<BEShowRoomOferta>(stockProductos);

            var command = new SqlCommand("ShowRoom.UpdStockOfertaShowRoomMasivo");
            command.CommandType = CommandType.StoredProcedure;

            var parameter = new SqlParameter("@StockShowRoom", SqlDbType.Structured);
            parameter.TypeName = "dbo.StockProductoType";
            parameter.Value = ofertaShowRoomReader;
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

        public void UpdateShowRoomConsultoraMostrarPopup(int campaniaID, string codigoConsultora, bool mostrarPopup)
        {
            DbCommand command = Context.Database.GetStoredProcCommand("ShowRoom.UpdateShowRoomConsultoraMostrarPopup");
            Context.Database.AddInParameter(command, "@CampaniaID", DbType.Int32, campaniaID);
            Context.Database.AddInParameter(command, "@CodigoConsultora", DbType.String, codigoConsultora);
            Context.Database.AddInParameter(command, "@MostrarPopup", DbType.Boolean, mostrarPopup);

            Context.ExecuteNonQuery(command);
        }

        public IDataReader GetProductosShowRoom(int tipoOfertaSisID, int campaniaID, string codigoOferta)
        {
            DbCommand command = Context.Database.GetStoredProcCommand("ShowRoom.GetProductosShowRoom");
            Context.Database.AddInParameter(command, "@TipoOfertaSisID", DbType.Int32, tipoOfertaSisID);
            Context.Database.AddInParameter(command, "@CampaniaID", DbType.Int32, campaniaID);
            Context.Database.AddInParameter(command, "@CodigoOferta", DbType.AnsiString, codigoOferta);

            return Context.ExecuteReader(command);
        }

        public int GetOrdenPriorizacionShowRoom(int ConfiguracionOfertaID, int CampaniaID)
        {
            DbCommand command = Context.Database.GetStoredProcCommand("ShowRoom.GetPriorizacionShowRoomByTipoOferta");
            Context.Database.AddInParameter(command, "@ConfiguracionOfertaID", DbType.Int32, ConfiguracionOfertaID);
            Context.Database.AddInParameter(command, "@CampaniaID", DbType.Int32, CampaniaID);

            return int.Parse(Context.ExecuteScalar(command).ToString());
        }

        public int ValidarPriorizacionShowRoom(int ConfiguracionOfertaID, int CampaniaID, int Orden)
        {
            DbCommand command = Context.Database.GetStoredProcCommand("ShowRoom.ValidarPriorizacionShowRoomByTipoOferta");
            Context.Database.AddInParameter(command, "@ConfiguracionOfertaID", DbType.Int32, ConfiguracionOfertaID);
            Context.Database.AddInParameter(command, "@CampaniaID", DbType.Int32, CampaniaID);
            Context.Database.AddInParameter(command, "@Orden", DbType.Int32, Orden);

            return int.Parse(Context.ExecuteScalar(command).ToString());
        }

        public int InsOfertaShowRoom(BEShowRoomOferta entity)
        {
            DbCommand command = Context.Database.GetStoredProcCommand("ShowRoom.InsOfertaShowRoom");
            Context.Database.AddInParameter(command, "@CampaniaID", DbType.Int32, entity.CampaniaID);
            Context.Database.AddInParameter(command, "@CUV", DbType.AnsiString, entity.CUV);
            Context.Database.AddInParameter(command, "@TipoOfertaSisID", DbType.Int32, entity.TipoOfertaSisID);
            Context.Database.AddInParameter(command, "@ConfiguracionOfertaID", DbType.Int32, entity.ConfiguracionOfertaID);
            Context.Database.AddInParameter(command, "@Descripcion", DbType.AnsiString, entity.Descripcion);
            Context.Database.AddInParameter(command, "@PrecioOferta", DbType.Decimal, entity.PrecioOferta);
            Context.Database.AddInParameter(command, "@ImagenProducto", DbType.AnsiString, entity.ImagenProducto);
            Context.Database.AddInParameter(command, "@Orden", DbType.Int32, entity.Orden);
            Context.Database.AddInParameter(command, "@UnidadesPermitidas", DbType.Int32, entity.UnidadesPermitidas);
            Context.Database.AddInParameter(command, "@DescripcionProducto1", DbType.AnsiString, entity.DescripcionProducto1);
            Context.Database.AddInParameter(command, "@DescripcionProducto2", DbType.AnsiString, entity.DescripcionProducto2);
            Context.Database.AddInParameter(command, "@DescripcionProducto3", DbType.AnsiString, entity.DescripcionProducto3);
            Context.Database.AddInParameter(command, "@ImagenProducto1", DbType.AnsiString, entity.ImagenProducto1);
            Context.Database.AddInParameter(command, "@ImagenProducto2", DbType.AnsiString, entity.ImagenProducto2);
            Context.Database.AddInParameter(command, "@ImagenProducto3", DbType.AnsiString, entity.ImagenProducto3);
            Context.Database.AddInParameter(command, "@FlagHabilitarProducto", DbType.Byte, entity.FlagHabilitarProducto);
            Context.Database.AddInParameter(command, "@DescripcionLegal", DbType.AnsiString, entity.DescripcionLegal);
            Context.Database.AddInParameter(command, "@UsuarioRegistro", DbType.AnsiString, entity.UsuarioRegistro);

            return Context.ExecuteNonQuery(command);
        }

        public int UpdOfertaShowRoom(BEShowRoomOferta entity)
        {
            DbCommand command = Context.Database.GetStoredProcCommand("ShowRoom.UpdOfertaShowRoom");
            Context.Database.AddInParameter(command, "@TipoOfertaSisID", DbType.Int32, entity.TipoOfertaSisID);
            Context.Database.AddInParameter(command, "@CampaniaID", DbType.Int32, entity.CampaniaID);
            Context.Database.AddInParameter(command, "@CUV", DbType.AnsiString, entity.CUV);
            Context.Database.AddInParameter(command, "@Descripcion", DbType.AnsiString, entity.Descripcion);
            Context.Database.AddInParameter(command, "@ImagenProducto", DbType.AnsiString, entity.ImagenProducto);
            Context.Database.AddInParameter(command, "@UnidadesPermitidas", DbType.Int32, entity.UnidadesPermitidas);
            Context.Database.AddInParameter(command, "@DescripcionProducto1", DbType.AnsiString, entity.DescripcionProducto1);
            Context.Database.AddInParameter(command, "@DescripcionProducto2", DbType.AnsiString, entity.DescripcionProducto2);
            Context.Database.AddInParameter(command, "@DescripcionProducto3", DbType.AnsiString, entity.DescripcionProducto3);
            Context.Database.AddInParameter(command, "@ImagenProducto1", DbType.AnsiString, entity.ImagenProducto1);
            Context.Database.AddInParameter(command, "@ImagenProducto2", DbType.AnsiString, entity.ImagenProducto2);
            Context.Database.AddInParameter(command, "@ImagenProducto3", DbType.AnsiString, entity.ImagenProducto3);
            Context.Database.AddInParameter(command, "@FlagHabilitarProducto", DbType.Byte, entity.FlagHabilitarProducto);
            Context.Database.AddInParameter(command, "@Orden", DbType.Int32, entity.Orden);
            Context.Database.AddInParameter(command, "@DescripcionLegal", DbType.AnsiString, entity.DescripcionLegal);
            Context.Database.AddInParameter(command, "@UsuarioModificacion", DbType.AnsiString, entity.UsuarioModificacion);
            Context.Database.AddInParameter(command, "@PrecioOferta", DbType.Decimal, entity.PrecioOferta);

            return Context.ExecuteNonQuery(command);
        }

        public int DelOfertaShowRoom(BEShowRoomOferta entity)
        {
            DbCommand command = Context.Database.GetStoredProcCommand("ShowRoom.DelOfertaShowRoom");
            Context.Database.AddInParameter(command, "@CampaniaID", DbType.Int32, entity.CampaniaID);
            Context.Database.AddInParameter(command, "@CUV", DbType.AnsiString, entity.CUV);
            Context.Database.AddInParameter(command, "@UsuarioModificacion", DbType.AnsiString, entity.UsuarioModificacion);

            return Context.ExecuteNonQuery(command);
        }

        public int RemoverOfertaShowRoom(BEShowRoomOferta entity)
        {
            DbCommand command = Context.Database.GetStoredProcCommand("ShowRoom.RemoverOfertaShowRoom");
            Context.Database.AddInParameter(command, "@CampaniaID", DbType.Int32, entity.CampaniaID);
            Context.Database.AddInParameter(command, "@CUV", DbType.AnsiString, entity.CUV);

            return Context.ExecuteNonQuery(command);
        }

        public IDataReader GetShowRoomOfertas(int campaniaID)
        {
            DbCommand command = Context.Database.GetStoredProcCommand("ShowRoom.GetShowRoomOfertas");
            Context.Database.AddInParameter(command, "@CampaniaID", DbType.Int32, campaniaID);

            return Context.ExecuteReader(command);
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
            try
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
            catch (Exception ex)
            {
                throw ex;
            }
        }

        public int GetStockOfertaShowRoom(int campaniaID, string cuv)
        {
            DbCommand command = Context.Database.GetStoredProcCommand("ShowRoom.ValidarStockOfertaShowRoom");
            Context.Database.AddInParameter(command, "@CampaniaID", DbType.Int32, campaniaID);
            Context.Database.AddInParameter(command, "@CUV", DbType.AnsiString, cuv);

            return int.Parse(Context.ExecuteScalar(command).ToString());
        }

        public int UpdOfertaShowRoomStockAgregar(int tipoOfertaSisID, int campaniaID, string cuv, int stock)
        {
            DbCommand command = Context.Database.GetStoredProcCommand("ShowRoom.UpdStockOfertaShowRoom");
            Context.Database.AddInParameter(command, "@TipoOfertaSisID", DbType.Int32, tipoOfertaSisID);
            Context.Database.AddInParameter(command, "@CampaniaID", DbType.Int32, campaniaID);
            Context.Database.AddInParameter(command, "@CUV", DbType.AnsiString, cuv);
            Context.Database.AddInParameter(command, "@Stock", DbType.Int32, stock);

            return Context.ExecuteNonQuery(command);
        }

        public int UpdOfertaShowRoomStockActualizar(int TipoOfertaSisID, int CampaniaID, string CUV, int Stock, int Flag)
        {
            DbCommand command = Context.Database.GetStoredProcCommand("ShowRoom.UpdStockOfertaShowRoomUpd");
            Context.Database.AddInParameter(command, "@TipoOfertaSisID", DbType.Int32, TipoOfertaSisID);
            Context.Database.AddInParameter(command, "@CampaniaID", DbType.Int32, CampaniaID);
            Context.Database.AddInParameter(command, "@CUV", DbType.AnsiString, CUV);
            Context.Database.AddInParameter(command, "@Stock", DbType.Int32, Stock);
            Context.Database.AddInParameter(command, "@Flag", DbType.Int32, Flag);

            return Context.ExecuteNonQuery(command);
        }

        public int UpdOfertaShowRoomStockEliminar(int TipoOfertaSisID, int CampaniaID, string CUV, int Stock)
        {
            DbCommand command = Context.Database.GetStoredProcCommand("ShowRoom.UpdStockOfertaShowRoomDel");
            Context.Database.AddInParameter(command, "@TipoOfertaSisID", DbType.Int32, TipoOfertaSisID);
            Context.Database.AddInParameter(command, "@CampaniaID", DbType.Int32, CampaniaID);
            Context.Database.AddInParameter(command, "@CUV", DbType.AnsiString, CUV);
            Context.Database.AddInParameter(command, "@Stock", DbType.Int32, Stock);

            return Context.ExecuteNonQuery(command);
        }
    }
}
