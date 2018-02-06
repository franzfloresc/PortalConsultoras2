using Portal.Consultoras.Entities;
using System;
using System.Data;
using System.Data.Common;
using System.Data.SqlClient;

namespace Portal.Consultoras.Data
{
    public class DAPedidoFIC : DataAccess
    {
        public DAPedidoFIC(int paisID)
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
        
        public int UpdPedidoWebByEstado(int CampaniaID, int PedidoID, short EstadoPedido, bool ModificaPedidoReservado)
        {
            DbCommand command = Context.Database.GetStoredProcCommand("dbo.UpdPedidoWebByEstado");
            Context.Database.AddInParameter(command, "@CampaniaID", DbType.Int32, CampaniaID);
            Context.Database.AddInParameter(command, "@PedidoID", DbType.Int32, PedidoID);
            Context.Database.AddInParameter(command, "@EstadoPedido", DbType.Int16, EstadoPedido);
            Context.Database.AddInParameter(command, "@ModificaPedidoReservado", DbType.Boolean, ModificaPedidoReservado);
            int result = Context.ExecuteNonQuery(command);
            return result;
        }

        public int UpdPedidoWebByEstadoConTotales(int CampaniaID, int PedidoID, short EstadoPedido, bool ModificaPedidoReservado, int Clientes, decimal TotalPedido)
        {
            DbCommand command = Context.Database.GetStoredProcCommand("dbo.UpdPedidoWebGeneral");
            Context.Database.AddInParameter(command, "@CampaniaID", DbType.Int32, CampaniaID);
            Context.Database.AddInParameter(command, "@PedidoID", DbType.Int32, PedidoID);
            Context.Database.AddInParameter(command, "@EstadoPedido", DbType.Int16, EstadoPedido);
            Context.Database.AddInParameter(command, "@ModificaPedidoReservado", DbType.Boolean, ModificaPedidoReservado);
            Context.Database.AddInParameter(command, "@Clientes", DbType.Int16, Clientes);
            Context.Database.AddInParameter(command, "@TotalPedido", DbType.Decimal, TotalPedido);
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

        public int UpdPedidoWebIndicadorEnviado(int NroLote, bool FirmarPedido, byte Estado, string Mensaje, string NombreArchivoCabecera, string NombreArchivoDetalle, string NombreServer)
        {
            DbCommand command = Context.Database.GetStoredProcCommand("dbo.UpdPedidoWebIndicadorEnviado");
            Context.Database.AddInParameter(command, "@NroLote", DbType.Int32, NroLote);
            Context.Database.AddInParameter(command, "@FirmarPedido", DbType.Boolean, FirmarPedido);
            Context.Database.AddInParameter(command, "@Estado", DbType.Byte, Estado);
            Context.Database.AddInParameter(command, "@Mensaje", DbType.String, Mensaje);
            Context.Database.AddInParameter(command, "@NombreArchivoCabecera", DbType.String, NombreArchivoCabecera);
            Context.Database.AddInParameter(command, "@NombreArchivoDetalle", DbType.String, NombreArchivoDetalle);
            Context.Database.AddInParameter(command, "@NombreServer", DbType.String, NombreServer);

            return Context.ExecuteNonQuery(command);
        }

        public IDataReader GetEstadoPedido(int CampaniaID, long ConsultoraID)
        {
            DbCommand command = Context.Database.GetStoredProcCommand("dbo.GetEstadoPedido");
            Context.Database.AddInParameter(command, "@CampaniaID", DbType.Int32, CampaniaID);
            Context.Database.AddInParameter(command, "@ConsultoraID", DbType.Int64, ConsultoraID);

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

            return Context.ExecuteNonQuery(command);
        }

        public int UpdDesbloqueoPedido(BEPedidoWeb BEPedidoWeb)
        {
            DbCommand command = Context.Database.GetStoredProcCommand("dbo.UpdDesbloquedoPedido");
            Context.Database.AddInParameter(command, "@PedidoID", DbType.Int32, BEPedidoWeb.PedidoID);
            Context.Database.AddInParameter(command, "@CampaniaID", DbType.Int32, BEPedidoWeb.CampaniaID);

            return Context.ExecuteNonQuery(command);
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

        public int UpdPedidoWebByEstadoConTotalesMasivo(int CampaniaID, int PedidoID, short EstadoPedido, bool ModificaPedidoReservado, int Clientes, decimal TotalPedido)
        {
            DbCommand command = Context.Database.GetStoredProcCommand("dbo.UpdPedidoWebMasivo");
            Context.Database.AddInParameter(command, "@CampaniaID", DbType.Int32, CampaniaID);
            Context.Database.AddInParameter(command, "@PedidoID", DbType.Int32, PedidoID);
            Context.Database.AddInParameter(command, "@EstadoPedido", DbType.Int16, EstadoPedido);
            Context.Database.AddInParameter(command, "@ModificaPedidoReservado", DbType.Boolean, ModificaPedidoReservado);
            Context.Database.AddInParameter(command, "@Clientes", DbType.Int16, Clientes);
            Context.Database.AddInParameter(command, "@TotalPedido", DbType.Decimal, TotalPedido);
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

        public int InsPedidoFIC(BEPedidoFIC pedidoweb)
        {
            DbCommand command = Context.Database.GetStoredProcCommand("dbo.InsPedidoFIC");
            Context.Database.AddInParameter(command, "@CampaniaID", DbType.Int32, pedidoweb.CampaniaID);
            Context.Database.AddInParameter(command, "@ConsultoraID", DbType.Int32, pedidoweb.ConsultoraID);
            Context.Database.AddInParameter(command, "@PaisID", DbType.Byte, pedidoweb.PaisID);
            Context.Database.AddInParameter(command, "@IPUsuario", DbType.AnsiString, pedidoweb.IPUsuario);
            Context.Database.AddOutParameter(command, "@PedidoID", DbType.Int32, pedidoweb.PedidoID);

            Context.ExecuteNonQuery(command);
            return Convert.ToInt32(command.Parameters["@PedidoID"].Value);
        }

        public int UpdPedidoFICTotales(int CampaniaID, int PedidoID, int Clientes, decimal ImporteTotal)
        {
            DbCommand command = Context.Database.GetStoredProcCommand("dbo.UpdPedidoFICTotales");
            Context.Database.AddInParameter(command, "@CampaniaID", DbType.Int32, CampaniaID);
            Context.Database.AddInParameter(command, "@PedidoID", DbType.Int32, PedidoID);
            Context.Database.AddInParameter(command, "@Clientes", DbType.Int16, Clientes);
            Context.Database.AddInParameter(command, "@ImporteTotal", DbType.Decimal, ImporteTotal);
            int result = Context.ExecuteNonQuery(command);
            return result;
        }

        public int UpdPedidoFICByEstadoConTotalesMasivo(int CampaniaID, int PedidoID, short EstadoPedido, bool ModificaPedidoReservado, int Clientes, decimal TotalPedido)
        {
            DbCommand command = Context.Database.GetStoredProcCommand("dbo.UpdPedidoFICMasivo");
            Context.Database.AddInParameter(command, "@CampaniaID", DbType.Int32, CampaniaID);
            Context.Database.AddInParameter(command, "@PedidoID", DbType.Int32, PedidoID);
            Context.Database.AddInParameter(command, "@EstadoPedido", DbType.Int16, EstadoPedido);
            Context.Database.AddInParameter(command, "@ModificaPedidoReservado", DbType.Boolean, ModificaPedidoReservado);
            Context.Database.AddInParameter(command, "@Clientes", DbType.Int16, Clientes);
            Context.Database.AddInParameter(command, "@TotalPedido", DbType.Decimal, TotalPedido);
            int result = Context.ExecuteNonQuery(command);
            return result;
        }

        public void InsTempServiceProl(DataTable ServicePROL)
        {
            var command = new SqlCommand("dbo.InsTempServiceProl");
            command.CommandType = CommandType.StoredProcedure;

            var parameter = new SqlParameter("@ServicePROL", SqlDbType.Structured);
            parameter.TypeName = "dbo.ServicePROLFICType";
            parameter.Value = ServicePROL;
            command.Parameters.Add(parameter);

            Context.ExecuteNonQuery(command);
        }

        public IDataReader GetReportePedidoFIC(string CodigoCampania, string CodigoRegion, string CodigoZona, string CodigoConsultora)
        {
            DbCommand command = Context.Database.GetStoredProcCommand("dbo.GetReportePedidoFIC");

            Context.Database.AddInParameter(command, "@CodigoCampania", DbType.AnsiString, CodigoCampania);
            Context.Database.AddInParameter(command, "@CodigoRegion", DbType.AnsiString, CodigoRegion);
            Context.Database.AddInParameter(command, "@CodigoZona", DbType.AnsiString, CodigoZona);
            Context.Database.AddInParameter(command, "@CodigoConsultora", DbType.AnsiString, CodigoConsultora);

            return Context.ExecuteReader(command);
        }

        public DataSet GetPedidoFICByFechaFacturacion(DateTime FechaFacturacion, int NroLote)
        {
            DbCommand command = Context.Database.GetStoredProcCommand("dbo.GetPedidoFICByFechaFacturacion");
            Context.Database.AddInParameter(command, "@FechaFacturacion", DbType.Date, FechaFacturacion);
            Context.Database.AddInParameter(command, "@NroLote", DbType.Int32, NroLote);

            return Context.ExecuteDataSet(command);
        }
    }
}
