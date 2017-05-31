﻿using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Data;
using System.Data.Common;
using OpenSource.Library.DataAccess;
using Portal.Consultoras.Entities;
using System.Data.SqlClient;
using System.Configuration;

namespace Portal.Consultoras.Data
{
    public class DAPedidoWeb : DataAccess
    {
        public DAPedidoWeb(int paisID)
            : base(paisID, EDbSource.Portal)
        {

        }

        public IDataReader GetPedidosWebByConsultora(long ConsultoraID)
        {
            DbCommand command = Context.Database.GetStoredProcCommand("dbo.GetPedidosWebByConsultora");
            Context.Database.AddInParameter(command, "@ConsultoraID", DbType.Int64, ConsultoraID);

            return Context.ExecuteReader(command);
        }

        public IDataReader GetPedidosDDWeb(BEPedidoDDWeb BEPedidoDDWeb)
        {
            DbCommand command = Context.Database.GetStoredProcCommand("dbo.GetPedidosDDWeb");
            Context.Database.AddInParameter(command, "@CampaniaCodigo", DbType.String, BEPedidoDDWeb.CampaniaCodigo);
            Context.Database.AddInParameter(command, "@ConsultoraCodigo", DbType.String, BEPedidoDDWeb.ConsultoraCodigo);
            Context.Database.AddInParameter(command, "@ZonaID", DbType.Int32, BEPedidoDDWeb.ZonaID);
            Context.Database.AddInParameter(command, "@Origen", DbType.Int32, BEPedidoDDWeb.Origen);
            Context.Database.AddInParameter(command, "@EstadoValidacion", DbType.Int32, BEPedidoDDWeb.EstadoValidacion);

            return Context.ExecuteReader(command);
        }

        public int InsPedidoWeb(BEPedidoWeb pedidoweb)
        {
            DbCommand command = Context.Database.GetStoredProcCommand("dbo.InsPedidoWeb");
            Context.Database.AddInParameter(command, "@CampaniaID", DbType.Int32, pedidoweb.CampaniaID);
            Context.Database.AddInParameter(command, "@ConsultoraID", DbType.Int32, pedidoweb.ConsultoraID);
            Context.Database.AddInParameter(command, "@PaisID", DbType.Byte, pedidoweb.PaisID);
            Context.Database.AddInParameter(command, "@IPUsuario", DbType.AnsiString, pedidoweb.IPUsuario);
            Context.Database.AddOutParameter(command, "@PedidoID", DbType.Int32, pedidoweb.PedidoID);
            Context.Database.AddInParameter(command, "@CodigoUsuarioCreacion", DbType.String, pedidoweb.CodigoUsuarioCreacion);         

            Context.ExecuteNonQuery(command);
            return Convert.ToInt32(command.Parameters["@PedidoID"].Value);
        }
        /*GR2089*/
        public int InsertarLogPedidoWeb(int CampaniaID, string CodigoConsultora, int PedidoID, string Accion, string CodigoUsuario)
        {
            DbCommand command = Context.Database.GetStoredProcCommand("dbo.InsertarLogPedidoWeb");
            Context.Database.AddInParameter(command, "@CampaniaID", DbType.Int32, CampaniaID);
            Context.Database.AddInParameter(command, "@CodigoConsultora", DbType.String, CodigoConsultora);
            Context.Database.AddInParameter(command, "@PedidoId", DbType.Int32, PedidoID);
            Context.Database.AddInParameter(command, "@Accion", DbType.String, Accion);
            Context.Database.AddInParameter(command, "@CodigoUsuario", DbType.String, CodigoUsuario);

            int result = Context.ExecuteNonQuery(command);
            return result;
        }

        public int UpdPedidoWebByEstado(int CampaniaID, int PedidoID, short EstadoPedido, bool ModificaPedidoReservado, string codigoUsuario, decimal MontoTotalProl, decimal descuentoProl)
        {
            DbCommand command = Context.Database.GetStoredProcCommand("dbo.UpdPedidoWebByEstado");
            Context.Database.AddInParameter(command, "@CampaniaID", DbType.Int32, CampaniaID);
            Context.Database.AddInParameter(command, "@PedidoID", DbType.Int32, PedidoID);
            Context.Database.AddInParameter(command, "@EstadoPedido", DbType.Int16, EstadoPedido);
            Context.Database.AddInParameter(command, "@ModificaPedidoReservado", DbType.Boolean, ModificaPedidoReservado);
            Context.Database.AddInParameter(command, "@CodigoUsuarioModificacion", DbType.String, codigoUsuario);
            Context.Database.AddInParameter(command, "@MontoTotalProl", DbType.Decimal, MontoTotalProl);
            Context.Database.AddInParameter(command, "@DescuentoProl", DbType.Decimal, descuentoProl);

            int result = Context.ExecuteNonQuery(command);
            return result;
        }

        public int UpdPedidoWebDesReserva(int CampaniaID, int PedidoID, short EstadoPedido, bool ModificaPedidoReservado, string codigoUsuario, bool ValidacionAbierta)
        {
            DbCommand command = Context.Database.GetStoredProcCommand("dbo.UpdPedidoWebDesReserva");
            Context.Database.AddInParameter(command, "@CampaniaID", DbType.Int32, CampaniaID);
            Context.Database.AddInParameter(command, "@PedidoID", DbType.Int32, PedidoID);
            Context.Database.AddInParameter(command, "@EstadoPedido", DbType.Int16, EstadoPedido);
            Context.Database.AddInParameter(command, "@ModificaPedidoReservado", DbType.Boolean, ModificaPedidoReservado);
            Context.Database.AddInParameter(command, "@CodigoUsuarioModificacion", DbType.String, codigoUsuario);
            Context.Database.AddInParameter(command, "@ValidacionAbierta", DbType.Boolean, ValidacionAbierta);
            int result = Context.ExecuteNonQuery(command);
            return result;
        }

        public int UpdPedidoWebByEstadoConTotales(int CampaniaID, int PedidoID, short EstadoPedido, bool ModificaPedidoReservado, int Clientes, decimal TotalPedido, string codigoUsuario)
        {
            DbCommand command = Context.Database.GetStoredProcCommand("dbo.UpdPedidoWebGeneral");
            Context.Database.AddInParameter(command, "@CampaniaID", DbType.Int32, CampaniaID);
            Context.Database.AddInParameter(command, "@PedidoID", DbType.Int32, PedidoID);
            Context.Database.AddInParameter(command, "@EstadoPedido", DbType.Int16, EstadoPedido);
            Context.Database.AddInParameter(command, "@ModificaPedidoReservado", DbType.Boolean, ModificaPedidoReservado);
            Context.Database.AddInParameter(command, "@Clientes", DbType.Int16, Clientes);
            Context.Database.AddInParameter(command, "@TotalPedido", DbType.Decimal, TotalPedido);
            Context.Database.AddInParameter(command, "@CodigoUsuarioModificacion", DbType.String, codigoUsuario);
            int result = Context.ExecuteNonQuery(command);
            return result;
        }

        public int InsPedidoDescarga(DateTime FechaFactura, byte Estado, int tipoCronograma, bool marcarPedido, string usuario, out int NroLote)
        {
            DbCommand command = Context.Database.GetStoredProcCommand("dbo.InsPedidoDescarga");
            Context.Database.AddInParameter(command, "@FechaFactura", DbType.Date, FechaFactura);
            Context.Database.AddInParameter(command, "@Estado", DbType.Byte, Estado);
            Context.Database.AddInParameter(command, "@TipoCronograma", DbType.Int32, tipoCronograma);
            Context.Database.AddInParameter(command, "@MarcaPedido", DbType.Boolean, marcarPedido);
            Context.Database.AddInParameter(command, "@Usuario", DbType.AnsiString, usuario);
            Context.Database.AddOutParameter(command, "@NroLote", DbType.Int32, 4);

            int result = Context.ExecuteNonQuery(command);
            NroLote = Convert.ToInt32(command.Parameters["@NroLote"].Value);
            return result;
        }

        private void InsLogPedidoDescargaDetalle(DataSet dsPedidos)
        {
            DataTable dtPedidosDetalle = null;

            if (dsPedidos != null)
            {
                dtPedidosDetalle = dsPedidos.Tables[1];

                if (dtPedidosDetalle.Rows.Count > 0)
                {
                    //Ingresamos el log del detalle
                    SqlBulkCopy oSqlBulkCopy_Detalle = new SqlBulkCopy(Context.Database.ConnectionString);
                    oSqlBulkCopy_Detalle.DestinationTableName = "LogCargaPedidoDetalle";

                    oSqlBulkCopy_Detalle.ColumnMappings.Add("LogFechaFacturacion", "FechaFacturacion");
                    oSqlBulkCopy_Detalle.ColumnMappings.Add("LogNroLote", "NroLote");
                    oSqlBulkCopy_Detalle.ColumnMappings.Add("PedidoID", "PedidoID");
                    oSqlBulkCopy_Detalle.ColumnMappings.Add("CodigoVenta", "CUV");
                    oSqlBulkCopy_Detalle.ColumnMappings.Add("Cantidad", "Cantidad");

                    oSqlBulkCopy_Detalle.WriteToServer(dtPedidosDetalle);
                    oSqlBulkCopy_Detalle.Close();
                }
            }
        }

        private void InsLogPedidoDescarga(DataSet dsPedidos)
        {
            DataTable dtPedidosCabecera = null;

            if (dsPedidos != null)
            {
                dtPedidosCabecera = dsPedidos.Tables[0];

                if (dtPedidosCabecera.Rows.Count != 0)
                {
                    //Ingresamos el log de la cabecera
                    SqlBulkCopy oSqlBulkCopy_Cabecera = new SqlBulkCopy(Context.Database.ConnectionString);
                    oSqlBulkCopy_Cabecera.DestinationTableName = "LogCargaPedido";

                    oSqlBulkCopy_Cabecera.ColumnMappings.Add("LogFechaFacturacion", "FechaFacturacion");
                    oSqlBulkCopy_Cabecera.ColumnMappings.Add("LogNroLote", "NroLote");
                    oSqlBulkCopy_Cabecera.ColumnMappings.Add("PedidoID", "PedidoID");
                    oSqlBulkCopy_Cabecera.ColumnMappings.Add("LogCantidad", "Cantidad");
                    oSqlBulkCopy_Cabecera.ColumnMappings.Add("Origen", "Origen");
                    oSqlBulkCopy_Cabecera.ColumnMappings.Add("LogCodigoUsuarioProceso", "CodigoUsuarioProceso");

                    oSqlBulkCopy_Cabecera.WriteToServer(dtPedidosCabecera);
                    oSqlBulkCopy_Cabecera.Close();

                    InsLogPedidoDescargaDetalle(dsPedidos);
                }
            }
        }

        public void InsLogPedidoDescargaWebDD(DataSet dsPedidosWeb, DataSet dsPedidosDD)
        {
            this.InsLogPedidoDescarga(dsPedidosWeb);
            this.InsLogPedidoDescarga(dsPedidosDD);
        }

        public int UpdLogPedidoDescargaWebDD(int nroLote)
        {
            DbCommand command = Context.Database.GetStoredProcCommand("dbo.UpdLogCargaPedidoCantidadDetalle");
            Context.Database.AddInParameter(command, "@nroLote", DbType.Int32, nroLote);
            return Context.ExecuteNonQuery(command);
        }


        public DataSet GetPedidoWebByFechaFacturacion(DateTime FechaFacturacion, int TipoCronograma, int NroLote)
        {
            DbCommand command = Context.Database.GetStoredProcCommand("dbo.GetPedidoWebByFechaFacturacion_SB2");
            Context.Database.AddInParameter(command, "@FechaFacturacion", DbType.Date, FechaFacturacion);
            Context.Database.AddInParameter(command, "@TipoCronograma", DbType.Int32, TipoCronograma);
            Context.Database.AddInParameter(command, "@NroLote", DbType.Int32, NroLote);

            return Context.ExecuteDataSet(command);
        }

        public int UpdPedidoWebIndicadorEnviado(int NroLote, bool FirmarPedido, byte Estado, string Mensaje, string mensajeExcepcion, string NombreArchivoCabecera, string NombreArchivoDetalle, string NombreServer)
        {
            DbCommand command = Context.Database.GetStoredProcCommand("dbo.UpdPedidoWebIndicadorEnviado");
            Context.Database.AddInParameter(command, "@NroLote", DbType.Int32, NroLote);
            Context.Database.AddInParameter(command, "@FirmarPedido", DbType.Boolean, FirmarPedido);
            Context.Database.AddInParameter(command, "@Estado", DbType.Byte, Estado);
            Context.Database.AddInParameter(command, "@Mensaje", DbType.String, Mensaje);
            Context.Database.AddInParameter(command, "@MensajeExcepcion", DbType.String, mensajeExcepcion);
            Context.Database.AddInParameter(command, "@NombreArchivoCabecera", DbType.String, NombreArchivoCabecera);
            Context.Database.AddInParameter(command, "@NombreArchivoDetalle", DbType.String, NombreArchivoDetalle);
            Context.Database.AddInParameter(command, "@NombreServer", DbType.String, NombreServer);

            return Context.ExecuteNonQuery(command);
        }

        public int UpdPedidoDescargaGuardoS3(int nroLote, bool guardoS3, string mensaje, string mensajeExcepcion)
        {
            DbCommand command = Context.Database.GetStoredProcCommand("dbo.UpdPedidoDescargaGuardoS3");
            Context.Database.AddInParameter(command, "@NroLote", DbType.Int32, nroLote);
            Context.Database.AddInParameter(command, "@GuardoS3", DbType.Boolean, guardoS3);
            Context.Database.AddInParameter(command, "@Mensaje", DbType.String, mensaje);
            Context.Database.AddInParameter(command, "@MensajeExcepcion", DbType.String, mensajeExcepcion);

            return Context.ExecuteNonQuery(command);
        }

        public IDataReader GetEstadoPedido(int CampaniaID, long ConsultoraID)
        {
            DbCommand command = Context.Database.GetStoredProcCommand("dbo.GetEstadoPedido");
            Context.Database.AddInParameter(command, "@CampaniaID", DbType.Int32, CampaniaID);
            Context.Database.AddInParameter(command, "@ConsultoraID", DbType.Int64, ConsultoraID);

            return Context.ExecuteReader(command);
        }

        public IDataReader GetPedidoCuvMarquesina(int CampaniaID, long ConsultoraID, string Cuv)
        {
            DbCommand command = Context.Database.GetStoredProcCommand("dbo.GetPedidoCUVmarquesina_SB2");
            Context.Database.AddInParameter(command, "@CampaniaID", DbType.Int32, CampaniaID);
            Context.Database.AddInParameter(command, "@ConsultoraID", DbType.Int64, ConsultoraID);
            Context.Database.AddInParameter(command, "@CUV", DbType.String, Cuv);

            return Context.ExecuteReader(command);
        }


        public IDataReader ValidarCuvMarquesina(string CampaniaID, int Cuv)
        {
            DbCommand command = Context.Database.GetStoredProcCommand("dbo.ValidarCampaniaCUVMarquesina");
            Context.Database.AddInParameter(command, "@CampaniaID", DbType.String, CampaniaID);
            Context.Database.AddInParameter(command, "@CUV", DbType.Int32, Cuv);
            return Context.ExecuteReader(command);
        }

        public IDataReader SelectPedidosWebByFilter(BEPedidoWeb BEPedidoWeb, string Fecha, int? RegionID, int? TerritorioID)
        {
            DbCommand command = Context.Database.GetStoredProcCommand("dbo.GetConsultaPedidoByFilters");
            Context.Database.AddInParameter(command, "@CodigoZona", DbType.AnsiString, BEPedidoWeb.CodigoZona);
            Context.Database.AddInParameter(command, "@CodigoConsultora", DbType.AnsiString, BEPedidoWeb.CodigoConsultora);
            Context.Database.AddInParameter(command, "@RegionID", DbType.Int32, RegionID);
            Context.Database.AddInParameter(command, "@CampaniaID", DbType.Int32, BEPedidoWeb.CampaniaID);
            Context.Database.AddInParameter(command, "@Fecha", DbType.AnsiString, Fecha);
            Context.Database.AddInParameter(command, "@TerritorioID", DbType.Int32, TerritorioID);
            Context.Database.AddInParameter(command, "@EstadoPedido", DbType.Int16, BEPedidoWeb.EstadoPedido);
            Context.Database.AddInParameter(command, "@Bloqueado", DbType.Int16, BEPedidoWeb.Bloqueado);

            return Context.ExecuteReader(command);
        }

        public int UpdBloqueoPedido(BEPedidoWeb BEPedidoWeb)
        {
            DbCommand command = Context.Database.GetStoredProcCommand("dbo.UpdBloquedoPedido");
            Context.Database.AddInParameter(command, "@PedidoID", DbType.Int32, BEPedidoWeb.PedidoID);
            Context.Database.AddInParameter(command, "@CampaniaID", DbType.Int32, BEPedidoWeb.CampaniaID);
            Context.Database.AddInParameter(command, "@DescripcionBloqueo", DbType.AnsiString, BEPedidoWeb.DescripcionBloqueo);
            Context.Database.AddInParameter(command, "@CodigoUsuarioModificacion", DbType.String, BEPedidoWeb.CodigoUsuarioModificacion);

            return Context.ExecuteNonQuery(command);
        }

        public int UpdDesbloqueoPedido(BEPedidoWeb BEPedidoWeb)
        {
            DbCommand command = Context.Database.GetStoredProcCommand("dbo.UpdDesbloquedoPedido");
            Context.Database.AddInParameter(command, "@PedidoID", DbType.Int32, BEPedidoWeb.PedidoID);
            Context.Database.AddInParameter(command, "@CampaniaID", DbType.Int32, BEPedidoWeb.CampaniaID);
            Context.Database.AddInParameter(command, "@CodigoUsuarioModificacion", DbType.String, BEPedidoWeb.CodigoUsuarioModificacion);

            return Context.ExecuteNonQuery(command);
        }

        public int UpdPedidoWebTotales(int CampaniaID, int PedidoID, int Clientes, decimal ImporteTotal, string codigoUsuario)
        {
            DbCommand command = Context.Database.GetStoredProcCommand("dbo.UpdPedidoWebTotales");
            Context.Database.AddInParameter(command, "@CampaniaID", DbType.Int32, CampaniaID);
            Context.Database.AddInParameter(command, "@PedidoID", DbType.Int32, PedidoID);
            Context.Database.AddInParameter(command, "@Clientes", DbType.Int16, Clientes);
            Context.Database.AddInParameter(command, "@ImporteTotal", DbType.Decimal, ImporteTotal);
            Context.Database.AddInParameter(command, "@CodigoUsuarioModificacion", DbType.String, codigoUsuario);
            int result = Context.ExecuteNonQuery(command);
            return result;
        }

        public int ValidarCargadePedidos(int TipoCronograma, int MarcaPedido, DateTime FechaFactura)
        {
            DbCommand command = Context.Database.GetStoredProcCommand("dbo.ValidarCargadePedido");
            Context.Database.AddInParameter(command, "@TipoCronograma", DbType.Int32, TipoCronograma);
            Context.Database.AddInParameter(command, "@MarcaPedido", DbType.Int32, MarcaPedido);
            Context.Database.AddInParameter(command, "@FechaFactura", DbType.DateTime, FechaFactura);
            int result = int.Parse(Context.ExecuteScalar(command).ToString());
            return result;
        }

        public IDataReader GetPedidosWebNoFacturados(BEPedidoDDWeb BEPedidoDDWeb)
        {
            DbCommand command = Context.Database.GetStoredProcCommand("dbo.GetPedidoWebNoFacturado");
            Context.Database.AddInParameter(command, "@PaisID", DbType.Int32, BEPedidoDDWeb.paisID);
            Context.Database.AddInParameter(command, "@CampaniaID", DbType.Int32, BEPedidoDDWeb.CampaniaID);
            Context.Database.AddInParameter(command, "@RegionCodigo", DbType.AnsiString, BEPedidoDDWeb.RegionCodigo);
            Context.Database.AddInParameter(command, "@ZonaCodigo", DbType.AnsiString, BEPedidoDDWeb.ZonaCodigo);
            Context.Database.AddInParameter(command, "@CodigoConsultora", DbType.AnsiString, BEPedidoDDWeb.ConsultoraCodigo);
            Context.Database.AddInParameter(command, "@EstadoPedido", DbType.AnsiString, BEPedidoDDWeb.EstadoValidacion);
            Context.Database.AddInParameter(command, "@EsRechazado", DbType.AnsiString, BEPedidoDDWeb.EsRechazado);

            return Context.ExecuteReader(command);
        }

        public IDataReader GetCuvProgramaNueva()
        {
            DbCommand command = Context.Database.GetStoredProcCommand("dbo.GetCuvProgramaNueva");

            return Context.ExecuteReader(command);
        }

        public IDataReader GetPedidosPortal(int CampaniaID, string CodigoConsultora, string ZonaCodigo, int PedidoPROL)
        {
            DbCommand command = Context.Database.GetStoredProcCommand("dbo.GetPedidosWebService");

            Context.Database.AddInParameter(command, "@CampaniaID", DbType.Int32, CampaniaID);
            Context.Database.AddInParameter(command, "@CodigoConsultora", DbType.AnsiString, CodigoConsultora);
            Context.Database.AddInParameter(command, "@ZonaCodigo", DbType.AnsiString, ZonaCodigo);
            Context.Database.AddInParameter(command, "@PedidoPROL", DbType.AnsiString, PedidoPROL);

            return Context.ExecuteReader(command);
        }

        public IDataReader GetPedidosPortalCaribeMX(int CampaniaID, string CodigoConsultora, string ZonaCodigo, int PedidoPROL)
        {
            DbCommand command = Context.Database.GetStoredProcCommand("dbo.GetPedidosWebServiceGeneral");

            Context.Database.AddInParameter(command, "@CampaniaID", DbType.Int32, CampaniaID);
            Context.Database.AddInParameter(command, "@CodigoConsultora", DbType.AnsiString, CodigoConsultora);
            Context.Database.AddInParameter(command, "@ZonaCodigo", DbType.AnsiString, ZonaCodigo);
            Context.Database.AddInParameter(command, "@PedidoPROL", DbType.AnsiString, PedidoPROL);

            return Context.ExecuteReader(command);
        }

        public IDataReader GetPedidosPortalCaribeMXFinal(int CampaniaID, string CodigoConsultora, string ZonaCodigo, int PedidoPROL,
            int IndicadorPedido, string SeccionCodigo, int IdEstadoActividad, int IndicadorSaldo, string NombreConsultora)
        {
            DbCommand command = Context.Database.GetStoredProcCommand("dbo.GetPedidosWebServiceGeneralFinal");

            Context.Database.AddInParameter(command, "@CampaniaID", DbType.Int32, CampaniaID);
            Context.Database.AddInParameter(command, "@CodigoConsultora", DbType.AnsiString, CodigoConsultora);
            Context.Database.AddInParameter(command, "@ZonaCodigo", DbType.AnsiString, ZonaCodigo);
            Context.Database.AddInParameter(command, "@PedidoPROL", DbType.AnsiString, PedidoPROL);
            Context.Database.AddInParameter(command, "@IndicadorPedido", DbType.Int32, IndicadorPedido);
            Context.Database.AddInParameter(command, "@SeccionCodigo", DbType.AnsiString, SeccionCodigo);
            Context.Database.AddInParameter(command, "@IdEstadoActividad", DbType.Int32, IdEstadoActividad);
            Context.Database.AddInParameter(command, "@IndicadorSaldo", DbType.Int32, IndicadorSaldo);
            Context.Database.AddInParameter(command, "@NombreConsultora", DbType.AnsiString, NombreConsultora);

            return Context.ExecuteReader(command);
        }

        public IDataReader GetPedidosPortalExtendido(int CampaniaID, string CodigoConsultora, string RegionCodigo, string ZonaCodigo, int PedidoPROL,
        int IndicadorPedido, string SeccionCodigo, int IdEstadoActividad, int IndicadorSaldo, string NombreConsultora)
        {
            DbCommand command = Context.Database.GetStoredProcCommand("dbo.GetPedidosWebServiceExtendido");

            Context.Database.AddInParameter(command, "@CampaniaID", DbType.Int32, CampaniaID);
            Context.Database.AddInParameter(command, "@CodigoConsultora", DbType.AnsiString, CodigoConsultora);
            Context.Database.AddInParameter(command, "@RegionCodigo", DbType.AnsiString, RegionCodigo);
            Context.Database.AddInParameter(command, "@ZonaCodigo", DbType.AnsiString, ZonaCodigo);
            Context.Database.AddInParameter(command, "@PedidoPROL", DbType.AnsiString, PedidoPROL);
            Context.Database.AddInParameter(command, "@IndicadorPedido", DbType.Int32, IndicadorPedido);
            Context.Database.AddInParameter(command, "@SeccionCodigo", DbType.AnsiString, SeccionCodigo);
            Context.Database.AddInParameter(command, "@IdEstadoActividad", DbType.Int32, IdEstadoActividad);
            Context.Database.AddInParameter(command, "@IndicadorSaldo", DbType.Int32, IndicadorSaldo);
            Context.Database.AddInParameter(command, "@NombreConsultora", DbType.AnsiString, NombreConsultora);

            return Context.ExecuteReader(command);
        }

        public IDataReader GetPedidosPortalDetalle(int CampaniaID, string CodigoConsultora)
        {
            DbCommand command = Context.Database.GetStoredProcCommand("dbo.GetPedidosWebServiceDetalle");
            Context.Database.AddInParameter(command, "@CampaniaID", DbType.Int32, CampaniaID);
            Context.Database.AddInParameter(command, "@CodigoConsultora", DbType.AnsiString, CodigoConsultora);

            return Context.ExecuteReader(command);
        }

        public IDataReader GetPedidosPortalDetalleCaribeMXFinal(int CampaniaID, string CodigoConsultora)
        {
            DbCommand command = Context.Database.GetStoredProcCommand("dbo.GetPedidosWebServiceDetalleFinal");
            Context.Database.AddInParameter(command, "@CampaniaID", DbType.Int32, CampaniaID);
            Context.Database.AddInParameter(command, "@CodigoConsultora", DbType.AnsiString, CodigoConsultora);

            return Context.ExecuteReader(command);
        }

        public IDataReader GetPedidosPortalDetalleExtendido(int CampaniaID, string CodigoConsultora)
        {
            DbCommand command = Context.Database.GetStoredProcCommand("dbo.GetPedidosWebServiceDetalleExtendido");
            Context.Database.AddInParameter(command, "@CampaniaID", DbType.Int32, CampaniaID);
            Context.Database.AddInParameter(command, "@CodigoConsultora", DbType.AnsiString, CodigoConsultora);

            return Context.ExecuteReader(command);
        }

        public int UpdBloquedoPedidowebService(int CampaniaID, string CodigoConsultora, bool Bloqueado, string DescripcionBloqueo)
        {
            DbCommand command = Context.Database.GetStoredProcCommand("dbo.UpdBloquedoPedidowebService");
            Context.Database.AddInParameter(command, "@CampaniaID", DbType.Int32, CampaniaID);
            Context.Database.AddInParameter(command, "@CodigoConsultora", DbType.AnsiString, CodigoConsultora);
            Context.Database.AddInParameter(command, "@Bloqueado", DbType.Boolean, Bloqueado);
            Context.Database.AddInParameter(command, "@DescripcionBloqueo", DbType.AnsiString, DescripcionBloqueo);
            int result = Context.ExecuteNonQuery(command);
            return result;
        }

        public IDataReader GetConsultoraWebService(string CodigoConsultora)
        {
            DbCommand command = Context.Database.GetStoredProcCommand("dbo.GetConsultoraWebService");
            Context.Database.AddInParameter(command, "@CodigoConsultora", DbType.AnsiString, CodigoConsultora);
            return Context.ExecuteReader(command);
        }

        public int UpdPedidoWebByEstadoConTotalesMasivo(int CampaniaID, int PedidoID, short EstadoPedido, bool ModificaPedidoReservado, int Clientes, decimal TotalPedido, string CodigoUsuario)
        {
            DbCommand command = Context.Database.GetStoredProcCommand("dbo.UpdPedidoWebMasivo");
            Context.Database.AddInParameter(command, "@CampaniaID", DbType.Int32, CampaniaID);
            Context.Database.AddInParameter(command, "@PedidoID", DbType.Int32, PedidoID);
            Context.Database.AddInParameter(command, "@EstadoPedido", DbType.Int16, EstadoPedido);
            Context.Database.AddInParameter(command, "@ModificaPedidoReservado", DbType.Boolean, ModificaPedidoReservado);
            Context.Database.AddInParameter(command, "@Clientes", DbType.Int16, Clientes);
            Context.Database.AddInParameter(command, "@TotalPedido", DbType.Decimal, TotalPedido);
            Context.Database.AddInParameter(command, "@CodigoUsuarioModificacion", DbType.String, CodigoUsuario);
            int result = Context.ExecuteNonQuery(command);
            return result;
        }

        public IDataReader GetPedidosWebDDDetalleConsultora(BEPedidoDDWeb BEPedidoDDWeb)
        {
            DbCommand command = Context.Database.GetStoredProcCommand("dbo.GetPedidosWebDetalleConsultora");
            Context.Database.AddInParameter(command, "@CampaniaID", DbType.Int32, BEPedidoDDWeb.CampaniaID);
            Context.Database.AddInParameter(command, "@RegionCodigo", DbType.AnsiString, BEPedidoDDWeb.RegionCodigo);
            Context.Database.AddInParameter(command, "@ZonaCodigo", DbType.AnsiString, BEPedidoDDWeb.ZonaCodigo);
            Context.Database.AddInParameter(command, "@CodigoConsultora", DbType.AnsiString, BEPedidoDDWeb.ConsultoraCodigo);
            Context.Database.AddInParameter(command, "@EstadoPedido", DbType.AnsiString, BEPedidoDDWeb.EstadoValidacion);

            return Context.ExecuteReader(command);
        }

        public IDataReader GetPedidosPortalConsolidado(string CodigoConsultora, int CampaniaID, DateTime FechaInicial, DateTime FechaFinal)
        {
            DbCommand command = Context.Database.GetStoredProcCommand("dbo.GetPedidosWebServiceConsolidado");

            Context.Database.AddInParameter(command, "@CodigoConsultora", DbType.AnsiString, CodigoConsultora);
            Context.Database.AddInParameter(command, "@CampaniaID", DbType.Int32, CampaniaID);
            Context.Database.AddInParameter(command, "@FechaInicial", DbType.Date, FechaInicial);
            Context.Database.AddInParameter(command, "@FechaFinal", DbType.Date, FechaFinal);

            return Context.ExecuteReader(command);
        }

        public IDataReader GetPedidosPortalConsolidadoDetalle(string CodigoConsultora, int CampaniaID, string CodigosZonas)
        {
            DbCommand command = Context.Database.GetStoredProcCommand("dbo.GetPedidosWebServiceConsolidadoDetalle");

            Context.Database.AddInParameter(command, "@CodigoConsultora", DbType.AnsiString, CodigoConsultora);
            Context.Database.AddInParameter(command, "@CampaniaID", DbType.Int32, CampaniaID);
            Context.Database.AddInParameter(command, "@CodigosZonas", DbType.AnsiString, CodigosZonas);

            return Context.ExecuteReader(command);
        }

        public IDataReader GetPedidoWebID(int CampaniaID, long ConsultoraID)
        {
            DbCommand command = Context.Database.GetStoredProcCommand("dbo.GetPedidoWebID");
            Context.Database.AddInParameter(command, "@CampaniaID", DbType.Int32, CampaniaID);
            Context.Database.AddInParameter(command, "@ConsultoraID", DbType.Int64, ConsultoraID);

            return Context.ExecuteReader(command);
        }

        public DateTime GetFechaHoraPais()
        {
            DbCommand command = Context.Database.GetStoredProcCommand("dbo.GetFechaHoraPais");
            DateTime result = Convert.ToDateTime(Context.ExecuteScalar(command));
            return result;
        }

        public int GetFechaNoHabilFacturacion(string CodigoZona, DateTime Fecha)
        {
            DbCommand command = Context.Database.GetStoredProcCommand("dbo.GetFechaNoHabilFacturacion");
            Context.Database.AddInParameter(command, "@CodigoZona", DbType.AnsiString, CodigoZona);
            Context.Database.AddInParameter(command, "@Fecha", DbType.DateTime, Fecha);

            return Convert.ToInt32(Context.ExecuteScalar(command));
        }

        public DataSet GetDatosConsultoraProcesoCarga(int NroLote, string Usuario)
        {
            DbCommand command = Context.Database.GetStoredProcCommand("dbo.GetDatosConsultoraProcesoCarga");
            Context.Database.AddInParameter(command, "@NroLote", DbType.Int32, NroLote);
            Context.Database.AddInParameter(command, "@CodigoUsuario", DbType.String, Usuario);
            return Context.ExecuteDataSet(command);
        }

        public int UpdDatosConsultoraIndicadorEnviado(int NroLote, byte Estado, string Mensaje, string mensajeExcepcion, string NombreArchivo, string NombreServer)
        {
            DbCommand command = Context.Database.GetStoredProcCommand("dbo.UpdDatosConsultoraIndicadorEnviado");
            Context.Database.AddInParameter(command, "@NroLote", DbType.Int32, NroLote);
            Context.Database.AddInParameter(command, "@Estado", DbType.Byte, Estado);
            Context.Database.AddInParameter(command, "@Mensaje", DbType.String, Mensaje);
            Context.Database.AddInParameter(command, "@MensajeExcepcion", DbType.String, mensajeExcepcion);
            Context.Database.AddInParameter(command, "@NombreArchivo", DbType.String, NombreArchivo);
            Context.Database.AddInParameter(command, "@NombreServer", DbType.String, NombreServer);

            return Context.ExecuteNonQuery(command);
        }

        public int UpdConsultoraDescargaGuardoS3(int nroLote, bool guardoS3, string mensaje, string mensajeExcepcion)
        {
            DbCommand command = Context.Database.GetStoredProcCommand("dbo.UpdConsultoraDescargaGuardoS3");
            Context.Database.AddInParameter(command, "@NroLote", DbType.Int32, nroLote);
            Context.Database.AddInParameter(command, "@GuardoS3", DbType.Boolean, guardoS3);
            Context.Database.AddInParameter(command, "@Mensaje", DbType.String, mensaje);
            Context.Database.AddInParameter(command, "@MensajeExcepcion", DbType.String, mensajeExcepcion);

            return Context.ExecuteNonQuery(command);
        }

        public IDataReader GetHabilitarPedidosWebServiceCabecera(string CodigoPais, int CampaniaID, string CodigoConsultora)
        {
            DbCommand command = Context.Database.GetStoredProcCommand("dbo.GetHabilitarPedidosWebServiceCabecera");

            Context.Database.AddInParameter(command, "@CodigoPais", DbType.AnsiString, CodigoPais);
            Context.Database.AddInParameter(command, "@CampaniaID", DbType.Int32, CampaniaID);
            Context.Database.AddInParameter(command, "@CodigoConsultora", DbType.AnsiString, CodigoConsultora);

            return Context.ExecuteReader(command);
        }

        public IDataReader GetHabilitarPedidosWebServiceDetalle(int CampaniaID, int PedidoId)
        {
            DbCommand command = Context.Database.GetStoredProcCommand("dbo.GetHabilitarPedidosWebServiceDetalle");

            Context.Database.AddInParameter(command, "@CampaniaID", DbType.Int32, CampaniaID);
            Context.Database.AddInParameter(command, "@PedidoId", DbType.Int32, PedidoId);

            return Context.ExecuteReader(command);
        }

        public IDataReader GetPedidoWebByCampaniaConsultora(int campaniaID, long consultoraID)
        {
            DbCommand command = Context.Database.GetStoredProcCommand("dbo.GetPedidoWebByCampaniaConsultora_SB2");
            Context.Database.AddInParameter(command, "@CampaniaID", DbType.Int32, campaniaID);
            Context.Database.AddInParameter(command, "@ConsultoraID", DbType.Int32, consultoraID);
            return Context.ExecuteReader(command);
        }

        public IDataReader GetPedidoConsolidado(int CampaniaID, string CodigoConsultora, string ZonaCodigo, int PedidoPROL, string Origen, int IndicadorPedido, int IdEstadoActividad, int IndicadorSaldo, string SeccionCodigo, string NombreConsultora)
        {
            DbCommand command = Context.Database.GetStoredProcCommand("dbo.GetPedidosConsolidadoWS");

            Context.Database.AddInParameter(command, "@CampaniaID", DbType.Int32, CampaniaID);
            Context.Database.AddInParameter(command, "@CodigoConsultora", DbType.AnsiString, CodigoConsultora);
            Context.Database.AddInParameter(command, "@ZonaCodigo", DbType.AnsiString, ZonaCodigo);
            Context.Database.AddInParameter(command, "@PedidoPROL", DbType.AnsiString, PedidoPROL);
            Context.Database.AddInParameter(command, "@Origen", DbType.AnsiString, Origen);
            Context.Database.AddInParameter(command, "@IndicadorPedido", DbType.AnsiString, IndicadorPedido);
            Context.Database.AddInParameter(command, "@SeccionCodigo", DbType.AnsiString, SeccionCodigo);
            Context.Database.AddInParameter(command, "@IdEstadoActividad", DbType.AnsiString, IdEstadoActividad);
            Context.Database.AddInParameter(command, "@IndicadorSaldo", DbType.AnsiString, IndicadorSaldo);
            Context.Database.AddInParameter(command, "@NombreConsultora", DbType.AnsiString, NombreConsultora);

            return Context.ExecuteReader(command);
        }

        public IDataReader GetPedidosDetalleConsolidado(int CampaniaID, string CodigoConsultora, string Origen)
        {
            DbCommand command = Context.Database.GetStoredProcCommand("dbo.GetPedidosDetalleWS");
            Context.Database.AddInParameter(command, "@CampaniaID", DbType.Int32, CampaniaID);
            Context.Database.AddInParameter(command, "@CodigoConsultora", DbType.AnsiString, CodigoConsultora);
            Context.Database.AddInParameter(command, "@Origen", DbType.AnsiString, Origen);

            return Context.ExecuteReader(command);
        }

        //R2154
        public int ValidarDesactivaRevistaGana(int campaniaID, string codigoZona)
        {
            DbCommand command = Context.Database.GetStoredProcCommand("dbo.ValidarDesactivaRevistaGana");
            Context.Database.AddInParameter(command, "@CampaniaID", DbType.Int32, campaniaID);
            Context.Database.AddInParameter(command, "@Codigo", DbType.AnsiString, codigoZona);
            int result = Convert.ToInt32(Context.ExecuteScalar(command));
            return result;
        }

        public void UpdateMontosPedidoWeb(BEPedidoWeb bePedidoWeb)
        {
            DbCommand command = Context.Database.GetStoredProcCommand("dbo.UpdateMontosPedidoWeb_SB2");
            Context.Database.AddInParameter(command, "@CampaniaID", DbType.Int32, bePedidoWeb.CampaniaID);
            Context.Database.AddInParameter(command, "@ConsultoraID", DbType.Int32, bePedidoWeb.ConsultoraID);
            Context.Database.AddInParameter(command, "@MontoAhorroCatalogo", DbType.Decimal, bePedidoWeb.MontoAhorroCatalogo);
            Context.Database.AddInParameter(command, "@MontoAhorroRevista", DbType.Decimal, bePedidoWeb.MontoAhorroRevista);
            Context.Database.AddInParameter(command, "@MontoDescuento", DbType.Decimal, bePedidoWeb.DescuentoProl);
            Context.Database.AddInParameter(command, "@MontoEscala", DbType.Decimal, bePedidoWeb.MontoEscala);

            Context.ExecuteNonQuery(command);
        }

        public IDataReader GetPedidosWebByConsultoraCampania(int consultoraID, int campaniaID)
        {
            DbCommand command = Context.Database.GetStoredProcCommand("dbo.GetPedidosWebByConsultoraCampania_SB2");
            Context.Database.AddInParameter(command, "@ConsultoraID", DbType.Int32, consultoraID);
            Context.Database.AddInParameter(command, "@CampaniaID", DbType.Int32, campaniaID);

            return Context.ExecuteReader(command);
        }

        public IDataReader GetPedidosFacturados(string codigoConsultora)
        {
            DbCommand command = Context.Database.GetStoredProcCommand("dbo.GetPedidosFacturados_SB2");
            Context.Database.AddInParameter(command, "@CodigoConsultora", DbType.String, codigoConsultora);

            return Context.ExecuteReader(command);
        }
        
        public IDataReader GetPedidosIngresadoFacturado(int consultoraID, int campaniaID)
        {
            DbCommand command = Context.Database.GetStoredProcCommand("dbo.GetPedidosIngresadoFacturado_SB2");
            Context.Database.AddInParameter(command, "@ConsultoraID", DbType.Int32, consultoraID);
            Context.Database.AddInParameter(command, "@CampaniaID", DbType.Int32, campaniaID);

            return Context.ExecuteReader(command);
        }

        public IDataReader GetPedidosIngresado(int consultoraID, int campaniaID)
        {
            DbCommand command = Context.Database.GetStoredProcCommand("dbo.GetPedidosIngresado_SB2");
            Context.Database.AddInParameter(command, "@ConsultoraID", DbType.Int32, consultoraID);
            Context.Database.AddInParameter(command, "@CampaniaID", DbType.Int32, campaniaID);

            return Context.ExecuteReader(command);
        }

        public void InsLogOfertaFinal(int CampaniaID, string CodigoConsultora, string CUV, int cantidad, string tipoOfertaFinal, decimal GAP, int tipoRegistro)
        {
            DbCommand command = Context.Database.GetStoredProcCommand("dbo.registrarLogOfertaFinal_SB2");
            Context.Database.AddInParameter(command, "@CampaniaID", DbType.Int32, CampaniaID);
            Context.Database.AddInParameter(command, "@CodigoConsultora", DbType.String, CodigoConsultora);
            Context.Database.AddInParameter(command, "@CUV", DbType.String, CUV);
            Context.Database.AddInParameter(command, "@Cantidad", DbType.Int32, cantidad);
            Context.Database.AddInParameter(command, "@TipoOfertaFinal", DbType.String, tipoOfertaFinal);
            Context.Database.AddInParameter(command, "@GAP", DbType.Decimal, GAP);
            Context.Database.AddInParameter(command, "@TipoRegistro", DbType.Int32, tipoRegistro);

            Context.ExecuteNonQuery(command);
        }

        public void ActualizarIndicadorGPRPedidosRechazados(long ProcesoID)
        {
            DbCommand command = Context.Database.GetStoredProcCommand("GPR.ActualizarIndicadorGPRPedidosRechazados");
            Context.Database.AddInParameter(command, "@ProcesoValidacionPedidoRechazadoId", DbType.Int32, ProcesoID);
            Context.ExecuteNonQuery(command);
        }

        public void ActualizarIndicadorGPRPedidosFacturados(long ProcesoID)
        {
            DbCommand command = Context.Database.GetStoredProcCommand("GPR.ActualizarIndicadorGPRPedidosFacturados");
            Context.Database.AddInParameter(command, "@ProcesoValidacionPedidoRechazadoId", DbType.Int32, ProcesoID);
            Context.ExecuteNonQuery(command);
        }

        public IDataReader GetPedidosFacturadoSegunDias(int campaniaID, long consultoraID, int maxDias)
        {
            DbCommand command = Context.Database.GetStoredProcCommand("dbo.GetPedidosFacturadoSegunDias_SB2");
            Context.Database.AddInParameter(command, "@ConsultoraID", DbType.Int32, consultoraID);
            Context.Database.AddInParameter(command, "@CampaniaID", DbType.Int32, campaniaID);
            Context.Database.AddInParameter(command, "@maxDias", DbType.Int32, maxDias);

            return Context.ExecuteReader(command);
        }            
        /*EPD-1025*/
        public IDataReader ObtenerUltimaDescargaPedido()
        {
            DbCommand command = Context.Database.GetStoredProcCommand("dbo.ObtenerUltimaDescargaPedido");
            return Context.ExecuteReader(command);
        }
        public IDataReader DesmarcarUltimaDescargaPedido()
        {
            DbCommand command = Context.Database.GetStoredProcCommand("dbo.DesmarcarUltimaDescargaPedido");            
            return Context.ExecuteReader(command);
        }
        /*EPD-1025*/

        public IDataReader ObtenerUltimaDescargaExitosa() {
            DbCommand Command = Context.Database.GetStoredProcCommand("dbo.ObtenerUltimaDescargaExitosa");
            return Context.ExecuteReader(Command);
        }

        public IDataReader GetPedidosFacturadoDetalle(int pedidoID)
        {
            DbCommand command = Context.Database.GetStoredProcCommand("dbo.GetPedidosFacturadoDetalle_SB2");
            Context.Database.AddInParameter(command, "@PedidoID", DbType.Int32, pedidoID);

            return Context.ExecuteReader(command);
        }

        /*EPD-2248*/
        public int InsIndicadorPedidoAutentico(BEIndicadorPedidoAutentico entidad)
        {
            DbCommand command = Context.Database.GetStoredProcCommand("dbo.InsIndicadorPedidoAutentico");
            Context.Database.AddInParameter(command, "@PedidoID", DbType.Int32, entidad.PedidoID);
            Context.Database.AddInParameter(command, "@CampaniaID", DbType.Int32, entidad.CampaniaID);
            Context.Database.AddInParameter(command, "@PedidoDetalleID", DbType.Int32, entidad.PedidoDetalleID);
            Context.Database.AddInParameter(command, "@IndicadorIPUsuario", DbType.AnsiString, entidad.IndicadorIPUsuario);
            Context.Database.AddInParameter(command, "@IndicadorFingerprint", DbType.AnsiString, entidad.IndicadorFingerprint);
            Context.Database.AddInParameter(command, "@IndicadorToken", DbType.AnsiString, entidad.IndicadorToken);

            return Convert.ToInt32(Context.ExecuteScalar(command));
        }

        public int UpdIndicadorPedidoAutentico(BEIndicadorPedidoAutentico entidad)
        {
            DbCommand command = Context.Database.GetStoredProcCommand("dbo.UpdIndicadorPedidoAutentico");
            Context.Database.AddInParameter(command, "@PedidoID", DbType.Int32, entidad.PedidoID);
            Context.Database.AddInParameter(command, "@CampaniaID", DbType.Int32, entidad.CampaniaID);
            Context.Database.AddInParameter(command, "@PedidoDetalleID", DbType.Int32, entidad.PedidoDetalleID);
            Context.Database.AddInParameter(command, "@IndicadorIPUsuario", DbType.AnsiString, entidad.IndicadorIPUsuario);
            Context.Database.AddInParameter(command, "@IndicadorFingerprint", DbType.AnsiString, entidad.IndicadorFingerprint);
            Context.Database.AddInParameter(command, "@IndicadorToken", DbType.AnsiString, entidad.IndicadorToken);

            return Convert.ToInt32(Context.ExecuteNonQuery(command));
        }

        public void DelIndicadorPedidoAutentico(BEIndicadorPedidoAutentico entidad)
        {
            DbCommand command = Context.Database.GetStoredProcCommand("dbo.DelIndicadorPedidoAutentico");
            Context.Database.AddInParameter(command, "@PedidoID", DbType.Int32, entidad.PedidoID);
            Context.Database.AddInParameter(command, "@CampaniaID", DbType.Int32, entidad.CampaniaID);
            Context.Database.AddInParameter(command, "@PedidoDetalleID", DbType.Int32, entidad.PedidoDetalleID);

            Context.ExecuteScalar(command);
        }

        public string GetTokenIndicadorPedidoAutentico(string paisISO, string codigoRegion, string codigoZona)
        {
            DbCommand command = Context.Database.GetStoredProcCommand("dbo.GetTokenIndicadorPedidoAutentico");
            Context.Database.AddInParameter(command, "@ISOPais", DbType.AnsiString, paisISO);
            Context.Database.AddInParameter(command, "@CodigoRegion", DbType.AnsiString, codigoRegion);
            Context.Database.AddInParameter(command, "@CodigoZona", DbType.AnsiString, codigoZona);

            return Convert.ToString(Context.ExecuteScalar(command));
        }
        /*EPD-2248*/

        public IDataReader GetConsultoraRegaloProgramaNuevas(int campaniaId, string codigoConsultora, string codigoRegion, string codigoZona)
        {
            DbCommand command = Context.Database.GetStoredProcCommand("dbo.GetConsultoraRegaloProgramaNuevas");
            Context.Database.AddInParameter(command, "@CampaniaId", DbType.Int32, campaniaId);
            Context.Database.AddInParameter(command, "@CodigoConsultora", DbType.AnsiString, codigoConsultora);
            Context.Database.AddInParameter(command, "@CodigoRegion", DbType.AnsiString, codigoRegion);
            Context.Database.AddInParameter(command, "@CodigoZona", DbType.AnsiString, codigoZona);
            return Context.ExecuteReader(command);
        }
        
    }
}
