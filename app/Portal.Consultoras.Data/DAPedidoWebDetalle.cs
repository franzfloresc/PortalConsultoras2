using OpenSource.Library.DataAccess;
using Portal.Consultoras.Entities;
using System;
using System.Collections.Generic;
using System.Data;
using System.Data.Common;
using System.Data.SqlClient;
using System.Linq;

namespace Portal.Consultoras.Data
{
    public class DAPedidoWebDetalle : DataAccess
    {
        public DAPedidoWebDetalle(int paisID)
            : base(paisID, EDbSource.Portal)
        {

        }

        public IDataReader GetClientesByCampania(int CampaniaID, long ConsultoraID)
        {
            DbCommand command = Context.Database.GetStoredProcCommand("dbo.GetClientesByCampania");
            Context.Database.AddInParameter(command, "@CampaniaID", DbType.Int32, CampaniaID);
            Context.Database.AddInParameter(command, "@ConsultoraID", DbType.Int64, ConsultoraID);

            return Context.ExecuteReader(command);
        }

        public IDataReader GetClientesByCampaniaByClienteID(int CampaniaID, long ConsultoraID, string ClienteID)
        {
            DbCommand command = Context.Database.GetStoredProcCommand("dbo.GetClientesByCampaniaByClienteID");
            Context.Database.AddInParameter(command, "@CampaniaID", DbType.Int32, CampaniaID);
            Context.Database.AddInParameter(command, "@ConsultoraID", DbType.Int64, ConsultoraID);
            Context.Database.AddInParameter(command, "@ClienteID", DbType.String, ClienteID);

            return Context.ExecuteReader(command);
        }

        public IDataReader GetPedidoWebDetalleByCliente(int CampaniaID, long ConsultoraID, int ClienteID)
        {
            DbCommand command = Context.Database.GetStoredProcCommand("dbo.GetPedidoWebDetalleByCliente");
            Context.Database.AddInParameter(command, "@CampaniaID", DbType.Int32, CampaniaID);
            Context.Database.AddInParameter(command, "@ConsultoraID", DbType.Int64, ConsultoraID);
            Context.Database.AddInParameter(command, "@ClienteID", DbType.Int32, ClienteID);

            return Context.ExecuteReader(command);
        }

        public BEPedidoWebDetalle InsPedidoWebDetalle(BEPedidoWebDetalle pedidowebdetalle)
        {
            DbCommand command = Context.Database.GetStoredProcCommand("dbo.InsPedidoWebDetalle_SB2");
            Context.Database.AddInParameter(command, "@CampaniaID", DbType.Int32, pedidowebdetalle.CampaniaID);
            Context.Database.AddInParameter(command, "@ConsultoraID", DbType.Int32, pedidowebdetalle.ConsultoraID);
            Context.Database.AddInParameter(command, "@MarcaID", DbType.Byte, pedidowebdetalle.MarcaID);
            Context.Database.AddInParameter(command, "@ClienteID", DbType.Int16, pedidowebdetalle.ClienteID == 0 ? (short?)null : pedidowebdetalle.ClienteID);
            Context.Database.AddInParameter(command, "@Cantidad", DbType.Int32, pedidowebdetalle.Cantidad);
            Context.Database.AddInParameter(command, "@PrecioUnidad", DbType.Decimal, pedidowebdetalle.PrecioUnidad);
            Context.Database.AddInParameter(command, "@CUV", DbType.AnsiString, pedidowebdetalle.CUV);
            Context.Database.AddInParameter(command, "@PedidoID", DbType.Int32, pedidowebdetalle.PedidoID);
            Context.Database.AddInParameter(command, "@OfertaWeb", DbType.Boolean, pedidowebdetalle.OfertaWeb);
            Context.Database.AddInParameter(command, "@ConfiguracionOfertaID", DbType.Int32, pedidowebdetalle.ConfiguracionOfertaID);
            Context.Database.AddInParameter(command, "@TipoEstrategiaID", DbType.Int32, pedidowebdetalle.TipoEstrategiaID);
            Context.Database.AddInParameter(command, "@TipoOfertaSisID", DbType.Int32, pedidowebdetalle.TipoOfertaSisID);
            Context.Database.AddInParameter(command, "@CodigoUsuarioCreacion", DbType.String, pedidowebdetalle.CodigoUsuarioCreacion);
            Context.Database.AddInParameter(command, "@SubTipoOfertaSisID", DbType.Int16, pedidowebdetalle.SubTipoOfertaSisID);
            Context.Database.AddInParameter(command, "@EsSugerido", DbType.Boolean, pedidowebdetalle.EsSugerido);
            Context.Database.AddInParameter(command, "@EsKitNueva", DbType.Boolean, pedidowebdetalle.EsKitNueva);
            Context.Database.AddInParameter(command, "@OrigenPedidoWeb", DbType.Int16, pedidowebdetalle.OrigenPedidoWeb);
            Context.Database.AddOutParameter(command, "@PedidoDetalleID", DbType.Int16, 2);

            Context.ExecuteNonQuery(command);

            pedidowebdetalle.PedidoDetalleID = Convert.ToInt16(command.Parameters["@PedidoDetalleID"].Value);
            return pedidowebdetalle;
        }

        public int DelPedidoWebDetalle(int CampaniaID, int PedidoID, short PedidoDetalleID, int TipoOfertaSisID, string Mensaje)
        {
            DbCommand command = Context.Database.GetStoredProcCommand("dbo.DelPedidoWebDetalle");
            Context.Database.AddInParameter(command, "@CampaniaID", DbType.Int32, CampaniaID);
            Context.Database.AddInParameter(command, "@PedidoID", DbType.Int32, PedidoID);
            Context.Database.AddInParameter(command, "@PedidoDetalleID", DbType.Int16, PedidoDetalleID);
            Context.Database.AddInParameter(command, "@MensajeErrorPROL", DbType.String, Mensaje);

            int result = Context.ExecuteNonQuery(command);
            return result;
        }

        public short DelPedidoWebDetalleByCUV(int CampaniaID, int PedidoID, string CUV)
        {
            DbCommand command = Context.Database.GetStoredProcCommand("dbo.DelPedidoWebDetalleByCUV");
            Context.Database.AddInParameter(command, "@CampaniaID", DbType.Int32, CampaniaID);
            Context.Database.AddInParameter(command, "@PedidoID", DbType.Int32, PedidoID);
            Context.Database.AddInParameter(command, "@CUV", DbType.AnsiString, CUV);
            Context.Database.AddOutParameter(command, "@Deleted", DbType.Int16, 2);

            Context.ExecuteNonQuery(command);
            short deleted = Convert.ToInt16(command.Parameters["@Deleted"].Value);
            return deleted;
        }

        public IDataReader GetPedidoWebDetalleByPK(int CampaniaID, int PedidoID, short PedidoDetalleID)
        {
            DbCommand command = Context.Database.GetStoredProcCommand("dbo.GetPedidoWebDetalleByPK");
            Context.Database.AddInParameter(command, "@CampaniaID", DbType.Int32, CampaniaID);
            Context.Database.AddInParameter(command, "@PedidoID", DbType.Int32, PedidoID);
            Context.Database.AddInParameter(command, "@PedidoDetalleID", DbType.Int16, PedidoDetalleID);

            return Context.ExecuteReader(command);
        }

        public IDataReader GetPedidoWebDetalleByPedidoAndCUV(int CampaniaID, int PedidoID, string CUV)
        {
            DbCommand command = Context.Database.GetStoredProcCommand("dbo.GetPedidoWebDetalleByPedidoAndCUV");
            Context.Database.AddInParameter(command, "@CampaniaID", DbType.Int32, CampaniaID);
            Context.Database.AddInParameter(command, "@PedidoID", DbType.Int32, PedidoID);
            Context.Database.AddInParameter(command, "@CUV", DbType.AnsiString, CUV);

            return Context.ExecuteReader(command);
        }

        public IDataReader GetPedidoWebDetalleByCampania(BEPedidoWebDetalleParametros bePedidoWebDetalleParametros)
         {
            DbCommand command = Context.Database.GetStoredProcCommand("dbo.GetPedidoWebDetalleByCampania");
            Context.Database.AddInParameter(command, "@CampaniaID", DbType.Int32, bePedidoWebDetalleParametros.CampaniaId);
            Context.Database.AddInParameter(command, "@ConsultoraID", DbType.Int64, bePedidoWebDetalleParametros.ConsultoraId);
            Context.Database.AddInParameter(command, "@CodigoPrograma", DbType.String, bePedidoWebDetalleParametros.CodigoPrograma);
            Context.Database.AddInParameter(command, "@NumeroPedido", DbType.Int32, bePedidoWebDetalleParametros.NumeroPedido);
            Context.Database.AddInParameter(command, "@AgruparSet", DbType.Boolean, bePedidoWebDetalleParametros.AgruparSet);
            return Context.ExecuteReader(command);
        }

        public IDataReader GetPedidoWebDetalleByPedidoValidado(int CampaniaID, long ConsultoraID)
        {
            DbCommand command = Context.Database.GetStoredProcCommand("dbo.GetPedidoWebDetalleByPedidoValidado");
            Context.Database.AddInParameter(command, "@CampaniaID", DbType.Int32, CampaniaID);
            Context.Database.AddInParameter(command, "@ConsultoraID", DbType.Int64, ConsultoraID);

            return Context.ExecuteReader(command);
        }

        public IDataReader GetPedidoWebDetalleByOfertaWeb(int CampaniaID, long ConsultoraID, bool OfertaWeb)
        {
            DbCommand command = Context.Database.GetStoredProcCommand("dbo.GetPedidoWebDetalleByOfertaWeb");
            Context.Database.AddInParameter(command, "@CampaniaID", DbType.Int32, CampaniaID);
            Context.Database.AddInParameter(command, "@ConsultoraID", DbType.Int64, ConsultoraID);
            Context.Database.AddInParameter(command, "@OfertaWeb", DbType.Boolean, OfertaWeb);

            return Context.ExecuteReader(command);
        }

        public IDataReader GetPedidosDDWebDetalleByCampaniaPedido(int CampaniaID, int PedidoID)
        {
            DbCommand command = Context.Database.GetStoredProcCommand("dbo.GetPedidosDDWebDetalle");
            Context.Database.AddInParameter(command, "@CampaniaID", DbType.Int32, CampaniaID);
            Context.Database.AddInParameter(command, "@PedidoID", DbType.Int32, PedidoID);

            return Context.ExecuteReader(command);
        }

        public string InsPedidoWebDetallePROL(BEPedidoWebDetalle pedidowebdetalle)
        {
            DbCommand command = Context.Database.GetStoredProcCommand("dbo.InsPedidoWebDetallePROL");
            Context.Database.AddInParameter(command, "@CampaniaID", DbType.Int32, pedidowebdetalle.CampaniaID);
            Context.Database.AddInParameter(command, "@ConsultoraID", DbType.Int32, pedidowebdetalle.ConsultoraID);
            Context.Database.AddInParameter(command, "@MarcaID", DbType.Byte, pedidowebdetalle.MarcaID);
            Context.Database.AddInParameter(command, "@ClienteID", DbType.Int16, pedidowebdetalle.ClienteID == 0 ? (short?)null : pedidowebdetalle.ClienteID);
            Context.Database.AddInParameter(command, "@Cantidad", DbType.Int32, pedidowebdetalle.Cantidad);
            Context.Database.AddInParameter(command, "@PrecioUnidad", DbType.Decimal, pedidowebdetalle.PrecioUnidad);
            Context.Database.AddInParameter(command, "@CUV", DbType.AnsiString, pedidowebdetalle.CUV);
            Context.Database.AddInParameter(command, "@PedidoID", DbType.Int32, pedidowebdetalle.PedidoID);
            Context.Database.AddInParameter(command, "@OfertaWeb", DbType.Boolean, pedidowebdetalle.OfertaWeb);
            Context.Database.AddInParameter(command, "@PedidoDetalleID", DbType.Int16, pedidowebdetalle.PedidoDetalleID);
            Context.Database.AddInParameter(command, "@CUVPadre", DbType.AnsiString, pedidowebdetalle.CUVPadre);
            Context.Database.AddInParameter(command, "@CodigoUsuarioCreacion", DbType.String, pedidowebdetalle.CodigoUsuarioCreacion);

            Context.ExecuteNonQuery(command);
            return string.Empty;
        }

        public IDataReader SelectDetalleBloqueoPedidoByPedidoId(int PedidoID)
        {
            DbCommand command = Context.Database.GetStoredProcCommand("dbo.GetDetalleBloqueoPedidoById");
            Context.Database.AddInParameter(command, "@PedidoID", DbType.Int32, PedidoID);

            return Context.ExecuteReader(command);
        }

        public int UpdPedidoWebDetalle(BEPedidoWebDetalle pedidowebdetalle)
        {
            DbCommand command = Context.Database.GetStoredProcCommand("dbo.UpdPedidoWebDetalle_SB2");
            Context.Database.AddInParameter(command, "@CampaniaID", DbType.Int32, pedidowebdetalle.CampaniaID);
            Context.Database.AddInParameter(command, "@PedidoID", DbType.Int32, pedidowebdetalle.PedidoID);
            Context.Database.AddInParameter(command, "@PedidoDetalleID", DbType.Int16, pedidowebdetalle.PedidoDetalleID);
            Context.Database.AddInParameter(command, "@Cantidad", DbType.Int32, pedidowebdetalle.Cantidad);
            Context.Database.AddInParameter(command, "@PrecioUnidad", DbType.Decimal, pedidowebdetalle.PrecioUnidad);
            Context.Database.AddInParameter(command, "@ClienteID", DbType.Int16, pedidowebdetalle.ClienteID == 0 ? (short?)null : pedidowebdetalle.ClienteID);
            Context.Database.AddInParameter(command, "@CodigoUsuarioModificacion", DbType.String, pedidowebdetalle.CodigoUsuarioModificacion);
            Context.Database.AddInParameter(command, "@EsSugerido", DbType.Boolean, pedidowebdetalle.EsSugerido);
            Context.Database.AddInParameter(command, "@OrdenPedidoWD", DbType.Int32, pedidowebdetalle.OrdenPedidoWD);
            Context.Database.AddInParameter(command, "@OrigenPedidoWeb", DbType.Int16, pedidowebdetalle.OrigenPedidoWeb);
            Context.Database.AddInParameter(command, "@TipoEstrategiaID", DbType.Int32, pedidowebdetalle.TipoEstrategiaID);

            int result = Context.ExecuteNonQuery(command);

            return result;
        }

        public int UpdListBackOrderPedidoWebDetalle(int campaniaID, int pedidoID, List<BEPedidoWebDetalle> listPedidoWebDetalle)
        {
            DbCommand command = Context.Database.GetStoredProcCommand("dbo.UpdListBackOrderPedidoWebDetalle");
            Context.Database.AddInParameter(command, "@CampaniaID", DbType.Int32, campaniaID);
            Context.Database.AddInParameter(command, "@PedidoID", DbType.Int32, pedidoID);

            var parListPedidoWebDetalleObs = new SqlParameter("@ListPedidoDetalleID", SqlDbType.Structured);
            parListPedidoWebDetalleObs.TypeName = "dbo.IdSmallintType";
            parListPedidoWebDetalleObs.Value = new GenericDataReader<DENativeId<short>>(
                listPedidoWebDetalle.Select(detalle => new DENativeId<short> { Id = detalle.PedidoDetalleID }).ToList()
            );
            command.Parameters.Add(parListPedidoWebDetalleObs);

            return Context.ExecuteNonQuery(command);
        }

        public int AceptarBackOrderPedidoWebDetalle(BEPedidoWebDetalle pedidowebdetalle)
        {
            DbCommand command = Context.Database.GetStoredProcCommand("dbo.AceptarBackOrderPedidoWebDetalle");
            Context.Database.AddInParameter(command, "@CampaniaID", DbType.Int32, pedidowebdetalle.CampaniaID);
            Context.Database.AddInParameter(command, "@PedidoID", DbType.Int32, pedidowebdetalle.PedidoID);
            Context.Database.AddInParameter(command, "@PedidoDetalleID", DbType.Int16, pedidowebdetalle.PedidoDetalleID);
            int result = Context.ExecuteNonQuery(command);

            return result;
        }

        public int QuitarBackOrderPedidoWebDetalle(BEPedidoWebDetalle pedidowebdetalle)
        {
            DbCommand command = Context.Database.GetStoredProcCommand("dbo.QuitarBackOrderPedidoWebDetalle");
            Context.Database.AddInParameter(command, "@CampaniaID", DbType.Int32, pedidowebdetalle.CampaniaID);
            Context.Database.AddInParameter(command, "@PedidoID", DbType.Int32, pedidowebdetalle.PedidoID);
            Context.Database.AddInParameter(command, "@PedidoDetalleID", DbType.Int16, pedidowebdetalle.PedidoDetalleID);
            int result = Context.ExecuteNonQuery(command);

            return result;
        }

        public void DelPedidoWebDetalleDesglosePedido(int CampaniaID, int PedidoID)
        {
            DbCommand command = Context.Database.GetStoredProcCommand("dbo.DelPedidoWebDetalleDesglosePedido");
            Context.Database.AddInParameter(command, "@CampaniaID", DbType.Int32, CampaniaID);
            Context.Database.AddInParameter(command, "@PedidoID", DbType.Int32, PedidoID);

            Context.ExecuteNonQuery(command);
        }

        public IDataReader GetPedidosWebNoFacturadosDetalle(string paisISO, int CampaniaID, string Consultora)
        {
            DbCommand command = Context.Database.GetStoredProcCommand("dbo.GetPedidoWebNoFacturadoDetalle");
            Context.Database.AddInParameter(command, "@PaisID", DbType.AnsiString, paisISO);
            Context.Database.AddInParameter(command, "@CampaniaID", DbType.Int32, CampaniaID);
            Context.Database.AddInParameter(command, "@CodigoConsultora", DbType.AnsiString, Consultora);

            return Context.ExecuteReader(command);
        }

        public int DelPedidoWebDetalleMasivo(int CampaniaID, int PedidoID)
        {
            DbCommand command = Context.Database.GetStoredProcCommand("dbo.DelPedidoWebDetalleMasivo_SB2");
            Context.Database.AddInParameter(command, "@CampaniaID", DbType.Int32, CampaniaID);
            Context.Database.AddInParameter(command, "@PedidoID", DbType.Int32, PedidoID);

            int result = Context.ExecuteNonQuery(command);
            return result;
        }

        public int DelPedidoWebDetallePackNueva(long ConsultoraID, int PedidoID)
        {
            DbCommand command = Context.Database.GetStoredProcCommand("dbo.DelPedidoWebDetallePackNueva_SB2");
            Context.Database.AddInParameter(command, "@ConsultoraID", DbType.Int64, ConsultoraID);
            Context.Database.AddInParameter(command, "@PedidoID", DbType.Int32, PedidoID);

            int result = Context.ExecuteNonQuery(command);
            return result;
        }

        public IDataReader GetPedidoWebDetalleByPedidoID(int campaniaID, int pedidoID)
        {
            DbCommand command = Context.Database.GetStoredProcCommand("dbo.GetPedidoWebDetalleByPedidoID");
            Context.Database.AddInParameter(command, "@CampaniaID", DbType.Int32, campaniaID);
            Context.Database.AddInParameter(command, "@PedidoID", DbType.Int32, pedidoID);
            return Context.ExecuteReader(command);
        }

        public string InsPedidoWebAccionesPROL(BEPedidoWebDetalle oBEPedidoWebDetalle, int Tipo, int Accion)
        {
            DbCommand command = Context.Database.GetStoredProcCommand("dbo.InsPedidoWebAccionesPROL");
            Context.Database.AddInParameter(command, "@CampaniaID", DbType.Int32, oBEPedidoWebDetalle.CampaniaID);
            Context.Database.AddInParameter(command, "@PedidoID", DbType.Int32, oBEPedidoWebDetalle.PedidoID);
            Context.Database.AddInParameter(command, "@PedidoDetalleID", DbType.Int16, oBEPedidoWebDetalle.PedidoDetalleID);
            Context.Database.AddInParameter(command, "@ConsultoraID", DbType.Int32, oBEPedidoWebDetalle.ConsultoraID);
            Context.Database.AddInParameter(command, "@CUV", DbType.AnsiString, oBEPedidoWebDetalle.CUV);
            Context.Database.AddInParameter(command, "@Cantidad", DbType.Int32, oBEPedidoWebDetalle.Cantidad);
            Context.Database.AddInParameter(command, "@PrecioUnidad", DbType.Decimal, oBEPedidoWebDetalle.PrecioUnidad);
            Context.Database.AddInParameter(command, "@Tipo", DbType.Int32, Tipo);
            Context.Database.AddInParameter(command, "@Accion", DbType.Int32, Accion);
            Context.Database.AddInParameter(command, "@MensajePROL", DbType.String, oBEPedidoWebDetalle.Mensaje.Replace("<br/>", ""));

            Context.ExecuteNonQuery(command);
            return string.Empty;
        }

        public void UpdListPedidoWebDetalleObsPROL(List<BEPedidoWebDetalle> listPedidoWebDetalle)
        {
            DbCommand command = Context.Database.GetStoredProcCommand("dbo.UpdListPedidoWebDetalleObsPROL");

            var parListPedidoWebDetalleObs = new SqlParameter("@PedidoWebDetalleObs", SqlDbType.Structured);
            parListPedidoWebDetalleObs.TypeName = "dbo.PedidoWebDetalleObsType";
            parListPedidoWebDetalleObs.Value = new GenericDataReader<DEPedidoWebDetalleObs>(
                listPedidoWebDetalle.Select(detalle => new DEPedidoWebDetalleObs
                {
                    CampaniaID = detalle.CampaniaID,
                    PedidoID = detalle.PedidoID,
                    PedidoDetalleID = detalle.PedidoDetalleID,
                    ObservacionPROL = detalle.ObservacionPROL
                }
            ).ToList());
            command.Parameters.Add(parListPedidoWebDetalleObs);

            Context.ExecuteNonQuery(command);
        }

        /// <summary>
        /// Lista los pedidos facturados del cliente
        /// </summary>
        /// <param name="codigoCampania">Codigo de campaña</param>
        /// <param name="consultoraId">Consultora Id</param>
        /// <param name="clienteId">Cliente Id</param>
        /// <returns></returns>
        public IDataReader ClientePedidoFacturadoListar(int codigoCampania, long consultoraId, short clienteId)
        {
            DbCommand command = Context.Database.GetStoredProcCommand("dbo.ConsultoraCliente_ObtenerPedidoFacturado");

            command.CommandType = CommandType.StoredProcedure;

            Context.Database.AddInParameter(command, "@campaniaID", DbType.Int32, codigoCampania);
            Context.Database.AddInParameter(command, "@consultoraId", DbType.Int64, consultoraId);
            Context.Database.AddInParameter(command, "@clienteId", DbType.Int16, clienteId);

            return Context.ExecuteReader(command);
        }

        /// <summary>
        /// Actualizar el precio del CUV del pedido web facturado
        /// </summary>
        /// <param name="PedidoWebFacturadoID">Id de tabla</param>
        /// <param name="PrecioUnidad">Precio del CUV</param>
        /// <param name="ImporteTotal">Importe total del CUV</param>
        /// <returns></returns>
        public int UpdPedidoWebFacturado(long PedidoWebFacturadoID, decimal PrecioUnidad, decimal ImporteTotal)
        {
            DbCommand command = Context.Database.GetStoredProcCommand("dbo.UpdPedidoWebFacturado");
            Context.Database.AddInParameter(command, "@PedidoWebFacturadoID", DbType.Int64, PedidoWebFacturadoID);
            Context.Database.AddInParameter(command, "@PrecioUnidad", DbType.Decimal, PrecioUnidad);
            Context.Database.AddInParameter(command, "@ImporteTotal", DbType.Decimal, ImporteTotal);

            return Context.ExecuteNonQuery(command);
        }

        public bool InsertPedidoWebSet(int Campaniaid, int PedidoID, int CantidadSet, string CuvSet, long ConsultoraId, string CodigoUsuario, string CuvsStringList,int EstrategiaId)
        {
            DbCommand command = Context.Database.GetStoredProcCommand("dbo.InsertPedidoWebSet");
            Context.Database.AddInParameter(command, "@Campaniaid", DbType.Int32, Campaniaid);
            Context.Database.AddInParameter(command, "@PedidoID", DbType.Int64, PedidoID);
            Context.Database.AddInParameter(command, "@CantidadSet", DbType.Int32, CantidadSet);
            Context.Database.AddInParameter(command, "@CuvSet", DbType.String, CuvSet);
            Context.Database.AddInParameter(command, "@EstrategiaID", DbType.Int32, EstrategiaId);
            
            Context.Database.AddInParameter(command, "@ConsultoraId", DbType.Int64, ConsultoraId);
            Context.Database.AddInParameter(command, "@CodigoUsuario", DbType.String, CodigoUsuario);
            Context.Database.AddInParameter(command, "@CuvsStringList", DbType.String, CuvsStringList);
            return Convert.ToInt32(Context.ExecuteScalar(command)) > 0;
        }

        public bool UpdCantidadPedidoWebSet(int SetId, int Cantidad)
        {
            DbCommand command = Context.Database.GetStoredProcCommand("dbo.UpdCantidadPedidoWebSet");
            Context.Database.AddInParameter(command, "@SetId", DbType.Int32, SetId);
            Context.Database.AddInParameter(command, "@Cantidad", DbType.Int32, Cantidad);
            return Convert.ToInt32(Context.ExecuteNonQuery(command))>0;
        }

        public IDataReader GetPedidoWebSetDetalle(int campania, long consultoraId)
        {
            DbCommand command = Context.Database.GetStoredProcCommand("dbo.GetPedidoWebSetDetalle");
            Context.Database.AddInParameter(command, "@Campania", DbType.Int32, campania);
            Context.Database.AddInParameter(command, "@ConsultoraId", DbType.Int32, consultoraId);
            return Context.ExecuteReader(command);
        }

        public IDataReader ObtenerCuvSetDetalle(int campaniaID, long consultoraID, int pedidoID, string ListaSet)
        {
            DbCommand command = Context.Database.GetStoredProcCommand("dbo.ObtenerCuvSetDetalle");
            Context.Database.AddInParameter(command, "@CampaniaID", DbType.Int32, campaniaID);
            Context.Database.AddInParameter(command, "@ConsultoraId", DbType.Int32, consultoraID);
            Context.Database.AddInParameter(command, "@PedidoId", DbType.Int32, pedidoID);
            Context.Database.AddInParameter(command, "@ListaSet", DbType.String, ListaSet);
            return Context.ExecuteReader(command);
        }

        public void UpdateImporteTotalPedidoWeb(int campaniaId, long consultoraId, decimal importe)
        {
            DbCommand command = Context.Database.GetStoredProcCommand("dbo.UpdateImporteTotalPedidoWeb");
            Context.Database.AddInParameter(command, "@CampaniaId", DbType.Int32, campaniaId);
            Context.Database.AddInParameter(command, "@ConsultoraId", DbType.Int64, consultoraId);
            Context.Database.AddInParameter(command, "@Importe", DbType.Decimal, importe);

            Context.ExecuteNonQuery(command);
        }





    }
}