using System;
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
    public class DAPedidoDD : DataAccess
    {
        public DAPedidoDD(int paisID)
            : base(paisID, EDbSource.Digitacion)
        {
        }

        public DataSet GetPedidoDDByFechaFacturacion(string codigoPais, int zonaGrupo, DateTime fechaFacturacion, int nroLote)
        {
            DbCommand command = Context.Database.GetStoredProcCommand("dbo.ESE_INT_OUT_DD_TRX_PEDIDO_SELECT");
            command.CommandTimeout = 600;
            Context.Database.AddInParameter(command, "@chrPrefijoPais", DbType.AnsiString, codigoPais);
            Context.Database.AddInParameter(command, "@intSEQIDZonaGrupo", DbType.Int32, zonaGrupo);
            Context.Database.AddInParameter(command, "@datFechaFacturacion", DbType.DateTime, fechaFacturacion);
            Context.Database.AddInParameter(command, "@intNroLote", DbType.Int32, nroLote);

            return Context.ExecuteDataSet(command);
        }

        public void GetPedidoDDByFechaFacturacionFox(string codigoPais, int zonaGrupo, DateTime fechaFacturacion, int nroLote, string[] DatabaseName)
        {
            using (SqlConnection con = new SqlConnection(ConfigurationManager.ConnectionStrings[DatabaseName[0]].ConnectionString))
            {
                con.Open();

                SqlCommand command = new SqlCommand("dbo.ESE_INT_OUT_DD_TRX_PEDIDO_SELECT", con);
                command.CommandType = CommandType.StoredProcedure;
                command.Parameters.Add("@chrPrefijoPais", SqlDbType.VarChar).Value = codigoPais;
                command.Parameters.Add("@intSEQIDZonaGrupo", SqlDbType.Int).Value = zonaGrupo;
                command.Parameters.Add("@datFechaFacturacion", SqlDbType.DateTime).Value = fechaFacturacion;
                command.Parameters.Add("@intNroLote", SqlDbType.Int).Value = nroLote;
                command.CommandTimeout = 300;
                SqlDataReader reader = command.ExecuteReader();

                using (SqlConnection con2 = new SqlConnection(ConfigurationManager.ConnectionStrings[DatabaseName[1]].ConnectionString))
                {
                    con2.Open();

                    SqlBulkCopy oSqlBulkCopy_Cabecera = new SqlBulkCopy(con2);
                    oSqlBulkCopy_Cabecera.DestinationTableName = "TmpCabeceraDD";

                    // Escribimos los datos en la tabla destino.
                    oSqlBulkCopy_Cabecera.WriteToServer(reader);

                    // Cerrar SqlBulkCopy y liberar memoria.
                    oSqlBulkCopy_Cabecera.Close();

                    // Obtiene el segundo select del DataReader
                    reader.NextResult();

                    SqlBulkCopy oSqlBulkCopy_Detalle = new SqlBulkCopy(con2);
                    oSqlBulkCopy_Detalle.DestinationTableName = "TmpDetalleDD";

                    // Escribimos los datos en la tabla destino.
                    oSqlBulkCopy_Detalle.WriteToServer(reader);

                    // Cerrar SqlBulkCopy y liberar memoria.
                    oSqlBulkCopy_Detalle.Close();
                }
            }
        }

        public DataSet UpdPedidoDDIndicadorEnviado(int nroLote, bool firmarPedido, DateTime FechaHoraPais)
        {
            DbCommand command = Context.Database.GetStoredProcCommand("dbo.ESE_INT_OUT_DD_TRX_PEDIDO_FIRMAR");
            command.CommandTimeout = 0;
            Context.Database.AddInParameter(command, "@intNroLote", DbType.Int32, nroLote);
            Context.Database.AddInParameter(command, "@bitFirmarPedido", DbType.Boolean, firmarPedido);
            Context.Database.AddInParameter(command, "@datFechaHoraPais", DbType.DateTime, FechaHoraPais);
            return Context.ExecuteDataSet(command);
        }

        public DataSet UpdPedidoDDIndicadorEnviadoDD(int nroLote, bool firmarPedido, DateTime FechaHoraPais, byte Estado, string Mensaje, string mensajeExcepcion, string NombreArchivoCabecera, string NombreArchivoDetalle, string NombreServer)
        {
            DbCommand command = Context.Database.GetStoredProcCommand("dbo.ESE_INT_OUT_DD_TRX_PEDIDO_FIRMAR_DD");
            command.CommandTimeout = 0;
            Context.Database.AddInParameter(command, "@intNroLote", DbType.Int32, nroLote);
            Context.Database.AddInParameter(command, "@bitFirmarPedido", DbType.Boolean, firmarPedido);
            Context.Database.AddInParameter(command, "@datFechaHoraPais", DbType.DateTime, FechaHoraPais);
            Context.Database.AddInParameter(command, "@Estado", DbType.Byte, Estado);
            Context.Database.AddInParameter(command, "@Mensaje", DbType.String, Mensaje);
            Context.Database.AddInParameter(command, "@MensajeExcepcion", DbType.String, mensajeExcepcion);
            Context.Database.AddInParameter(command, "@NombreArchivoCabecera", DbType.String, NombreArchivoCabecera);
            Context.Database.AddInParameter(command, "@NombreArchivoDetalle", DbType.String, NombreArchivoDetalle);
            Context.Database.AddInParameter(command, "@NombreServer", DbType.String, NombreServer);
            return Context.ExecuteDataSet(command);
        }

        public IDataReader GetPedidosDDNoFacturados(BEPedidoDDWeb BEPedidoDDWeb)
        {
            DbCommand command = Context.Database.GetStoredProcCommand("dbo.GetPedidoDDNoFacturado");
            command.CommandTimeout = 600;

            Context.Database.AddInParameter(command, "@chrPrefijoPais", DbType.AnsiString, BEPedidoDDWeb.paisISO);
            Context.Database.AddInParameter(command, "@CampaniaID", DbType.AnsiString, BEPedidoDDWeb.CampaniaID.ToString());
            Context.Database.AddInParameter(command, "@RegionCodigo", DbType.AnsiString, BEPedidoDDWeb.RegionCodigo);
            Context.Database.AddInParameter(command, "@ZonaCodigo", DbType.AnsiString, BEPedidoDDWeb.ZonaCodigo);
            Context.Database.AddInParameter(command, "@CodigoConsultora", DbType.AnsiString, BEPedidoDDWeb.ConsultoraCodigo);
            Context.Database.AddInParameter(command, "@FechaRegistroInicio", DbType.Date, BEPedidoDDWeb.FechaRegistroInicio);
            Context.Database.AddInParameter(command, "@FechaRegistroFin", DbType.Date, BEPedidoDDWeb.FechaRegistroFin);

            return Context.ExecuteReader(command);
        }

        public IDataReader GetPedidosDDNoFacturadosDetalle(string paisISO, int CampaniaID, string Consultora)
        {
            DbCommand command = Context.Database.GetStoredProcCommand("dbo.GetPedidoDDNoFacturadoDetalle");
            Context.Database.AddInParameter(command, "@PaisID", DbType.AnsiString, paisISO);
            Context.Database.AddInParameter(command, "@CampaniaID", DbType.Int32, CampaniaID);
            Context.Database.AddInParameter(command, "@CodigoConsultora", DbType.AnsiString, Consultora);

            return Context.ExecuteReader(command);
        }

        public IDataReader GetPedidosWebDDDetalleConsultora(BEPedidoDDWeb BEPedidoDDWeb)
        {
            DbCommand command = Context.Database.GetStoredProcCommand("dbo.GetPedidosDDDetalleConsultora");
            Context.Database.AddInParameter(command, "@chrPrefijoPais", DbType.AnsiString, BEPedidoDDWeb.paisISO);
            Context.Database.AddInParameter(command, "@CampaniaID", DbType.AnsiString, BEPedidoDDWeb.CampaniaID.ToString());
            Context.Database.AddInParameter(command, "@RegionCodigo", DbType.AnsiString, BEPedidoDDWeb.RegionCodigo);
            Context.Database.AddInParameter(command, "@ZonaCodigo", DbType.AnsiString, BEPedidoDDWeb.ZonaCodigo);
            Context.Database.AddInParameter(command, "@CodigoConsultora", DbType.AnsiString, BEPedidoDDWeb.ConsultoraCodigo);
            Context.Database.AddInParameter(command, "@FechaRegistroInicio", DbType.Date, BEPedidoDDWeb.FechaRegistroInicio);
            Context.Database.AddInParameter(command, "@FechaRegistroFin", DbType.Date, BEPedidoDDWeb.FechaRegistroFin);

            return Context.ExecuteReader(command);
        }

        public IDataReader GetPedidoDDDetalle(int pedidoID, int CampaniaID, bool IndicadorActivo)
        {
            DbCommand command = Context.Database.GetStoredProcCommand("dbo.GetPedidoDDDetalle");
            Context.Database.AddInParameter(command, "@PedidoID", DbType.Int32, pedidoID);
            Context.Database.AddInParameter(command, "@CampaniaID", DbType.Int32, CampaniaID);
            Context.Database.AddInParameter(command, "@IndicadorActivo", DbType.Boolean, IndicadorActivo);
            return Context.ExecuteReader(command);
        }
        public IDataReader GetPedidoDDByCampaniaConsultora(int campaniaID, long consultoraID)
        {
            DbCommand command = Context.Database.GetStoredProcCommand("dbo.GetPedidoDDByCampaniaConsultora");
            Context.Database.AddInParameter(command, "@CampaniaID", DbType.Int32, campaniaID);
            Context.Database.AddInParameter(command, "@ConsultoraID", DbType.Int32, consultoraID);
            return Context.ExecuteReader(command);
        }

        public int InsPedidoDD(BEPedidoDD bePedidoDD)
        {
            DbCommand command = Context.Database.GetStoredProcCommand("dbo.InsPedidoDD");
            Context.Database.AddOutParameter(command, "@PedidoID", DbType.Int32, bePedidoDD.PedidoID);
            Context.Database.AddInParameter(command, "@PaisID", DbType.Byte, bePedidoDD.PaisID);
            Context.Database.AddInParameter(command, "@CampaniaID", DbType.Int32, bePedidoDD.CampaniaID);
            Context.Database.AddInParameter(command, "@ConsultoraID", DbType.Int64, bePedidoDD.ConsultoraID);
            Context.Database.AddInParameter(command, "@NumeroClientes", DbType.Int32, bePedidoDD.NumeroClientes);
            Context.Database.AddInParameter(command, "@IndicadorEnviado", DbType.Boolean, bePedidoDD.IndicadorEnviado);
            Context.Database.AddInParameter(command, "@IPUsuario", DbType.AnsiString, bePedidoDD.IPUsuario);
            Context.Database.AddInParameter(command, "@CodigoUsuarioCreacion", DbType.String, bePedidoDD.CodigoUsuarioCreacion);

            Context.ExecuteNonQuery(command);
            return Convert.ToInt32(command.Parameters["@PedidoID"].Value);
        }

        public void UpdPedidoDD(BEPedidoDD bePedidoDD)
        {
            DbCommand command = Context.Database.GetStoredProcCommand("dbo.UpdPedidoDD");
            Context.Database.AddInParameter(command, "@PedidoID", DbType.Int32, bePedidoDD.PedidoID);
            Context.Database.AddInParameter(command, "@CampaniaID", DbType.Int32, bePedidoDD.CampaniaID);
            Context.Database.AddInParameter(command, "@NumeroClientes", DbType.Int32, bePedidoDD.NumeroClientes);
            Context.Database.AddInParameter(command, "@IndicadorEnviado", DbType.Boolean, bePedidoDD.IndicadorEnviado);
            Context.Database.AddInParameter(command, "@IndicadorActivo", DbType.Boolean, bePedidoDD.IndicadorActivo);
            Context.Database.AddInParameter(command, "@IPUsuario", DbType.AnsiString, bePedidoDD.IPUsuario);
            Context.Database.AddInParameter(command, "@CodigoUsuarioModificacion", DbType.String, bePedidoDD.CodigoUsuarioModificacion);

            Context.ExecuteNonQuery(command);
        }

        public void UpdIndicadoEnviado(BEPedidoDD bePedidoDD)
        {
            DbCommand command = Context.Database.GetStoredProcCommand("dbo.UpdPedidoDDIndicadoEnviado");
            Context.Database.AddInParameter(command, "@PedidoID", DbType.Int32, bePedidoDD.PedidoID);
            Context.Database.AddInParameter(command, "@CampaniaID", DbType.Int32, bePedidoDD.CampaniaID);
            Context.Database.AddInParameter(command, "@IndicadorEnviado", DbType.Boolean, bePedidoDD.IndicadorEnviado);
            Context.Database.AddInParameter(command, "@CodigoUsuarioModificacion", DbType.String, bePedidoDD.CodigoUsuarioModificacion);

            Context.ExecuteNonQuery(command);
        }

        public IDataReader GetPedidosIngresados(string codigoUsuario, DateTime fechaIngreso, string codigoConsultora, int campaniaID, string codigoZona, bool indicadorActivo)
        {
            DbCommand command = Context.Database.GetStoredProcCommand("dbo.ReportePedidosIngresados");
            command.CommandTimeout = 600;

            if (!string.IsNullOrEmpty(codigoUsuario))
                Context.Database.AddInParameter(command, "@CodigoUsuario", DbType.AnsiString, codigoUsuario);
            if (fechaIngreso != DateTime.MinValue)
                Context.Database.AddInParameter(command, "@FechaIngreso", DbType.DateTime, fechaIngreso);
            if (!string.IsNullOrEmpty(codigoConsultora))
                Context.Database.AddInParameter(command, "@CodigoConsultora", DbType.AnsiString, codigoConsultora);
            if (campaniaID > 0)
                Context.Database.AddInParameter(command, "@CampaniaID", DbType.Int32, campaniaID);
            if (!string.IsNullOrEmpty(codigoZona))
                Context.Database.AddInParameter(command, "@CodigoZona", DbType.AnsiString, codigoZona);
            Context.Database.AddInParameter(command, "@IndicadorActivo", DbType.Boolean, indicadorActivo);

            return Context.ExecuteReader(command);
        }

        public void AnularPedido(int campaniaID, int pedidoID)
        {
            DbCommand command = Context.Database.GetStoredProcCommand("dbo.AnularPedidoDD");
            Context.Database.AddInParameter(command, "@CampaniaID", DbType.Int32, campaniaID);
            Context.Database.AddInParameter(command, "@PedidoID", DbType.Int32, pedidoID);
            Context.ExecuteNonQuery(command);
        }

        public bool VerificarAsistenciaCompartamos(int campaniaID, long consultoraID)
        {
            DbCommand command = Context.Database.GetStoredProcCommand("dbo.VerificarAsistenciaCompartamos");
            Context.Database.AddInParameter(command, "@CampaniaID", DbType.Int32, campaniaID);
            Context.Database.AddInParameter(command, "@ConsultoraID", DbType.Int32, consultoraID);

            return Convert.ToBoolean(Context.ExecuteScalar(command));
        }
        
        public IDataReader ValidarCuvDescargado(int anioCampania, string codigoVenta, string codigoConsultora)
        {
            DbCommand command = Context.Database.GetStoredProcCommand("dbo.ValidarCampaniaCUVDescargado");
            Context.Database.AddInParameter(command, "@CampaniaID", DbType.String, anioCampania);
            Context.Database.AddInParameter(command, "@CodigoVenta", DbType.String, codigoVenta);
            Context.Database.AddInParameter(command, "@CodigoConsultora", DbType.String, codigoConsultora);
            return Context.ExecuteReader(command);
        }

        public void RegistrarAsistenciaCompartamos(BEAsistenciaCompartamos beAsistenciaCompartamos)
        {
            DbCommand command = Context.Database.GetStoredProcCommand("dbo.RegistrarAsistenciaCompartamos");
            Context.Database.AddInParameter(command, "@CampaniaID", DbType.Int32, beAsistenciaCompartamos.CampaniaID);
            Context.Database.AddInParameter(command, "@ConsultoraID", DbType.Int32, beAsistenciaCompartamos.ConsultoraID);
            Context.Database.AddInParameter(command, "@IndicadorAsistencia", DbType.Int32, beAsistenciaCompartamos.IndicadorAsistencia);
            Context.Database.AddInParameter(command, "@CodigoUsuarioCreacion", DbType.String, beAsistenciaCompartamos.CodigoUsuarioCreacion);
            Context.Database.AddInParameter(command, "@CodigoUsuarioModificacion", DbType.String, beAsistenciaCompartamos.CodigoUsuarioModificacion);

            Context.ExecuteNonQuery(command);
        }

        public IDataReader GetPedidoDDByCampaniaConsultoraHabilitarPedido(int campaniaID, long consultoraID)
        {
            DbCommand command = Context.Database.GetStoredProcCommand("dbo.GetPedidoDDByCampaniaConsultoraHabilitarPedido");
            Context.Database.AddInParameter(command, "@CampaniaID", DbType.Int32, campaniaID);
            Context.Database.AddInParameter(command, "@ConsultoraID", DbType.Int32, consultoraID);
            return Context.ExecuteReader(command);
        }

    }
}