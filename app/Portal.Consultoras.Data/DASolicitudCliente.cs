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
    public class DASolicitudCliente : DataAccess
    {
        public DASolicitudCliente(int paisID)
            : base(paisID, EDbSource.Portal)
        {
        }

        public IDataReader InsertarSolicitudCliente(BEEntradaSolicitudCliente entidadSolicitud,
            IEnumerable<BESolicitudClienteDetalle> entidadSolicitudDetalle)
        {
            IList<BESolicitudClienteDetalleStoreParameter> entidadSolicitudDetalleStoreParameter = new List<BESolicitudClienteDetalleStoreParameter>();
            entidadSolicitudDetalle.ToList().ForEach(x => { entidadSolicitudDetalleStoreParameter.Add(new BESolicitudClienteDetalleStoreParameter(x)); });

            var detalleSolicitud = new GenericDataReader<BESolicitudClienteDetalleStoreParameter>(entidadSolicitudDetalleStoreParameter);
            var command = new SqlCommand("dbo.RegistrarSolicitudCliente");
            command.CommandType = CommandType.StoredProcedure;

            if (entidadSolicitud.CodigoConsultora == null)
                command.Parameters.Add("@CodigoConsultora", SqlDbType.VarChar, 30).Value = DBNull.Value;
            else
                command.Parameters.Add("@CodigoConsultora", SqlDbType.VarChar, 30).Value = entidadSolicitud.CodigoConsultora;

            if (entidadSolicitud.ConsultoraID == 0)
                command.Parameters.Add("@ConsultoraID", SqlDbType.BigInt).Value = DBNull.Value;
            else
                command.Parameters.Add("@ConsultoraID", SqlDbType.BigInt).Value = entidadSolicitud.ConsultoraID;

            if (string.IsNullOrEmpty(entidadSolicitud.CodigoUbigeo))
                command.Parameters.Add("@CodigoUbigeo", SqlDbType.VarChar, 40).Value = DBNull.Value;
            else
                command.Parameters.Add("@CodigoUbigeo", SqlDbType.VarChar, 40).Value = entidadSolicitud.CodigoUbigeo;

            if (entidadSolicitud.NombreCompleto == null)
                command.Parameters.Add("@NombreCompleto", SqlDbType.VarChar, 110).Value = DBNull.Value;
            else
                command.Parameters.Add("@NombreCompleto", SqlDbType.VarChar, 110).Value = entidadSolicitud.NombreCompleto;

            if (entidadSolicitud.Email == null)
                command.Parameters.Add("@Email", SqlDbType.VarChar, 110).Value = DBNull.Value;
            else
                command.Parameters.Add("@Email", SqlDbType.VarChar, 110).Value = entidadSolicitud.Email;

            if (entidadSolicitud.Telefono == null)
                command.Parameters.Add("@Telefono", SqlDbType.VarChar, 110).Value = DBNull.Value;
            else
                command.Parameters.Add("@Telefono", SqlDbType.VarChar, 110).Value = entidadSolicitud.Telefono;

            if (entidadSolicitud.Mensaje == null)
                command.Parameters.Add("@Mensaje", SqlDbType.VarChar, 810).Value = DBNull.Value;
            else
                command.Parameters.Add("@Mensaje", SqlDbType.VarChar, 810).Value = entidadSolicitud.Mensaje;

            if (entidadSolicitud.Campania == null)
                command.Parameters.Add("@Campania", SqlDbType.VarChar, 10).Value = DBNull.Value;
            else
                command.Parameters.Add("@Campania", SqlDbType.VarChar, 10).Value = entidadSolicitud.Campania;

            if (entidadSolicitud.MarcaID == 0)
                command.Parameters.Add("@MarcaID", SqlDbType.Int).Value = DBNull.Value;
            else
                command.Parameters.Add("@MarcaID", SqlDbType.Int).Value = entidadSolicitud.MarcaID;

            command.Parameters.Add("@NumIteracion", SqlDbType.Int).Value = 1;

            if (entidadSolicitud.Direccion == null)
                command.Parameters.Add("@Direccion", SqlDbType.VarChar, 800).Value = DBNull.Value;
            else
                command.Parameters.Add("@Direccion", SqlDbType.VarChar, 800).Value = entidadSolicitud.Direccion;
            var paramSolicitudDetalle = new SqlParameter("@SolicitudDetalle", SqlDbType.Structured);
            paramSolicitudDetalle.TypeName = "dbo.SolicitudDetalleType";
            paramSolicitudDetalle.Value = detalleSolicitud;
            command.Parameters.Add(paramSolicitudDetalle);

            return Context.ExecuteReader(command);
        }


        public IDataReader InsertarSolicitudClienteAppCliente(BESolicitudClienteAppCatalogo entidadSolicitud)
        {
            var command = new SqlCommand("dbo.RegistrarSolicitudClienteAppCatalogo");
            command.CommandType = CommandType.StoredProcedure;

            command.Parameters.Add("@CodigoConsultora", SqlDbType.VarChar, 30).Value = entidadSolicitud.CodigoConsultora;
            if (entidadSolicitud.ConsultoraID == 0) command.Parameters.Add("@ConsultoraID", SqlDbType.BigInt).Value = DBNull.Value;
            else command.Parameters.Add("@ConsultoraID", SqlDbType.BigInt).Value = entidadSolicitud.ConsultoraID;
            command.Parameters.Add("@CodigoUbigeo", SqlDbType.VarChar, 40).Value = entidadSolicitud.CodigoUbigeo;
            command.Parameters.Add("@NombreCompleto", SqlDbType.VarChar, 110).Value = entidadSolicitud.NombreCompleto;
            command.Parameters.Add("@Email", SqlDbType.VarChar, 110).Value = entidadSolicitud.Email;
            command.Parameters.Add("@Telefono", SqlDbType.VarChar, 110).Value = entidadSolicitud.Telefono;
            command.Parameters.Add("@Mensaje", SqlDbType.VarChar, 810).Value = entidadSolicitud.Mensaje;
            command.Parameters.Add("@Campania", SqlDbType.VarChar, 10).Value = entidadSolicitud.Campania;
            command.Parameters.Add("@Direccion", SqlDbType.VarChar, 800).Value = entidadSolicitud.Direccion;
            command.Parameters.Add("@FlagConsultora", SqlDbType.Bit).Value = (entidadSolicitud.FlagConsultora == 1);
            command.Parameters.Add("@FlagMedio", SqlDbType.VarChar, 10).Value = entidadSolicitud.FlagMedio;
            command.Parameters.Add("@NumIteracion", SqlDbType.Int).Value = 1;

            command.Parameters.Add("@CodigoDispositivo", SqlDbType.VarChar, 50).Value = entidadSolicitud.CodigoDispositivo;
            command.Parameters.Add("@SODispositivo", SqlDbType.VarChar, 20).Value = entidadSolicitud.SODispositivo;
            command.Parameters.Add("@TipoUsuario", SqlDbType.Int).Value = entidadSolicitud.TipoUsuario;
            command.Parameters.Add("@UsuarioAppID", SqlDbType.BigInt).Value = entidadSolicitud.UsuarioAppID;

            List<DESolicitudClienteDetalleAppCatalogo> listDeDetalleSolicitud = new List<DESolicitudClienteDetalleAppCatalogo>();
            if (entidadSolicitud.DetalleSolicitud != null) entidadSolicitud.DetalleSolicitud.ToList().ForEach(x => listDeDetalleSolicitud.Add(new DESolicitudClienteDetalleAppCatalogo(x)));
            var detalleSolicitud = new GenericDataReader<DESolicitudClienteDetalleAppCatalogo>(listDeDetalleSolicitud);

            var paramSolicitudDetalle = new SqlParameter("@SolicitudDetalle", SqlDbType.Structured);
            paramSolicitudDetalle.TypeName = "dbo.SolicitudDetalleAppCatalogoType";
            paramSolicitudDetalle.Value = detalleSolicitud;
            command.Parameters.Add(paramSolicitudDetalle);

            return Context.ExecuteReader(command);
        }

        public IDataReader GetSolicitudClienteBySolicitudId(long solicitudClienteId)
        {
            DbCommand command = Context.Database.GetStoredProcCommand("dbo.GetSolicitudClienteBySolicitudId");
            Context.Database.AddInParameter(command, "@SolicitudId", DbType.Int64, solicitudClienteId);

            return Context.ExecuteReader(command);
        }

        public IDataReader GetSolicitudClienteWithoutMarcaBySolicitudId(long solicitudClienteId)
        {
            DbCommand command = Context.Database.GetStoredProcCommand("dbo.GetSolicitudClienteWithoutMarcaBySolicitudId");
            Context.Database.AddInParameter(command, "@SolicitudId", DbType.Int64, solicitudClienteId);

            return Context.ExecuteReader(command);
        }

        public IDataReader GetSolicitudClienteDetalleBySolicitudId(long solicitudClienteId)
        {
            DbCommand command = Context.Database.GetStoredProcCommand("dbo.GetSolicitudClienteDetalleBySolicitudId");
            Context.Database.AddInParameter(command, "@SolicitudId", DbType.Int64, solicitudClienteId);

            return Context.ExecuteReader(command);
        }

        public IDataReader GetConsultoraSolicitudCliente(int ConsultoraID, string Codigo, int MarcaID)
        {
            DbCommand command = Context.Database.GetStoredProcCommand("dbo.SP_GetConsultoraMailSolicitudCliente");
            Context.Database.AddInParameter(command, "@ConsultoraID", DbType.Int64, ConsultoraID);
            Context.Database.AddInParameter(command, "@CodigoConsultora", DbType.String, Codigo);
            Context.Database.AddInParameter(command, "@MarcaID", DbType.String, MarcaID);

            return Context.ExecuteReader(command);
        }

        public void UpdSolicitudCliente(long solicitudClienteId, string estado, string mensajeaCliente, string usuarioModificacion)
        {
            DbCommand command = Context.Database.GetStoredProcCommand("dbo.UpdSolicitudClienteConsultora");
            Context.Database.AddInParameter(command, "@SolicitudId", DbType.Int64, solicitudClienteId);
            Context.Database.AddInParameter(command, "@Estado", DbType.String, estado);
            Context.Database.AddInParameter(command, "@MensajeaCliente", DbType.String, mensajeaCliente);
            Context.Database.AddInParameter(command, "@UsuarioModificacion", DbType.String, usuarioModificacion);

            Context.ExecuteReader(command);
        }


        public void UpdSolicitudClienteDetalle(long solicitudClienteDetalleId, int tipoAtencion, int pedidoWebID, int pedidoWebDetalleID)
        {
            DbCommand command = Context.Database.GetStoredProcCommand("dbo.UpdSolicitudClienteDetalle_SB2");
            Context.Database.AddInParameter(command, "@SolicitudDetalleId", DbType.Int64, solicitudClienteDetalleId);
            Context.Database.AddInParameter(command, "@TipoAtencion", DbType.Int32, tipoAtencion);
            Context.Database.AddInParameter(command, "@PedidoWebID", DbType.Int32, pedidoWebID);
            Context.Database.AddInParameter(command, "@PedidoWebDetalleID", DbType.Int32, pedidoWebDetalleID);

            Context.ExecuteReader(command);
        }

        public void RechazarSolicitudCliente(long solicitudId, bool definitivo, int opcionRechazo, string razonMotivoRechazo)
        {
            DbCommand command = Context.Database.GetStoredProcCommand("dbo.UpdRechazarSolicitud");
            Context.Database.AddInParameter(command, "@SolicitudId", DbType.Int64, solicitudId);
            Context.Database.AddInParameter(command, "@Definitivo", DbType.Boolean, definitivo);
            Context.Database.AddInParameter(command, "@MotivoSolicitudId", DbType.Int32, opcionRechazo);
            Context.Database.AddInParameter(command, "@RazonMotivoSolicitud", DbType.String, razonMotivoRechazo);

            Context.ExecuteReader(command);
        }

        public IDataReader ReasignarSolicitudCliente(long solicitudId, string codigoUbigeo, string campania, int paisId, int marcaId, int opcionRechazo, string razonMotivoRechazo)
        {
            DbCommand command = Context.Database.GetStoredProcCommand("dbo.ReasignarSolicitudCliente");
            Context.Database.AddInParameter(command, "@SolicitudId", DbType.Int64, solicitudId);
            Context.Database.AddInParameter(command, "@CodigoUbigeo", DbType.String, codigoUbigeo);
            Context.Database.AddInParameter(command, "@CampaniaID", DbType.String, campania);
            Context.Database.AddInParameter(command, "@PaisID", DbType.Int32, paisId);
            Context.Database.AddInParameter(command, "@MarcaId", DbType.Int32, marcaId);
            Context.Database.AddInParameter(command, "@MotivoSolicitudId", DbType.Int32, opcionRechazo);
            Context.Database.AddInParameter(command, "@RazonMotivoSolicitud", DbType.String, razonMotivoRechazo);

            return Context.ExecuteReader(command);
        }

        public void CancelarSolicitudCliente(long solicitudId, int opcionCancelacion, string razonMotivoCancelacion)
        {
            DbCommand command = Context.Database.GetStoredProcCommand("dbo.CancelarSolicitudCliente_SB2");
            Context.Database.AddInParameter(command, "@SolicitudId", DbType.Int64, solicitudId);
            Context.Database.AddInParameter(command, "@MotivoSolicitudId", DbType.Int32, opcionCancelacion);
            Context.Database.AddInParameter(command, "@RazonMotivoSolicitud", DbType.String, razonMotivoCancelacion);

            Context.ExecuteReader(command);
        }

        public IDataReader GetMotivosRechazo()
        {
            DbCommand command = Context.Database.GetStoredProcCommand("dbo.GetMotivosRechazo_SB2");
            return Context.ExecuteReader(command);
        }

        public int EnviarSolicitudClienteaGZ(BESolicitudCliente entidadSolicitudCliente)
        {
            DbCommand command = Context.Database.GetStoredProcCommand("dbo.EnviarSolicitudaGerenteZona");
            Context.Database.AddInParameter(command, "@SolicitudClienteID", DbType.Int64, entidadSolicitudCliente.SolicitudClienteID);
            Context.Database.AddInParameter(command, "@NombreGZ", DbType.String, entidadSolicitudCliente.NombreGZ);
            Context.Database.AddInParameter(command, "@EmailGZ", DbType.String, entidadSolicitudCliente.EmailGZ);
            Context.Database.AddInParameter(command, "@MensajeaGZ", DbType.String, entidadSolicitudCliente.MensajeaGZ);
            Context.Database.AddInParameter(command, "@UsuarioModifica", DbType.String, entidadSolicitudCliente.UsuarioModificacion);

            return Context.ExecuteNonQuery(command);
        }
        public IDataReader BuscarSolicitudAnuladasRechazadas(BESolicitudCliente entidadSolicitudCliente)
        {
            DbCommand command = Context.Database.GetStoredProcCommand("dbo.BuscarSolicitudesAnuladasRechazadas");
            Context.Database.AddInParameter(command, "@CampaniaID", DbType.String, entidadSolicitudCliente.Campania);
            if (entidadSolicitudCliente.EstadoSolicitudClienteId == 0 || entidadSolicitudCliente.EstadoSolicitudClienteId == -1)
            {
                Context.Database.AddInParameter(command, "@Estado", DbType.String, DBNull.Value);
            }
            else
            {
                Context.Database.AddInParameter(command, "@Estado", DbType.String, entidadSolicitudCliente.EstadoSolicitudClienteId);
            }

            return Context.ExecuteReader(command);
        }
        public IDataReader CabeceraSolicitudAnuladasRechazadas(BESolicitudCliente entidadSolicitudCliente)
        {
            DbCommand command = Context.Database.GetStoredProcCommand("dbo.ObtenerCabeceraSolicitudesRechazas");
            Context.Database.AddInParameter(command, "@SolicitudClienteID", DbType.Int64, entidadSolicitudCliente.SolicitudClienteID);

            return Context.ExecuteReader(command);
        }
        public IDataReader DetalleSolicitudAnuladasRechazadas(BESolicitudCliente entidadSolicitudCliente)
        {
            DbCommand command = Context.Database.GetStoredProcCommand("dbo.ObtenerDetalleSolicitudesRechazas");
            Context.Database.AddInParameter(command, "@SolicitudClienteID", DbType.Int64, entidadSolicitudCliente.SolicitudClienteID);

            return Context.ExecuteReader(command);
        }

        public IDataReader GetEstadoSolicitudCliente()
        {
            DbCommand command = Context.Database.GetStoredProcCommand("dbo.GetEstadoSolicitudCliente");
            return Context.ExecuteReader(command);
        }

        public IDataReader ReporteAfiliados(DateTime FechaInicio, DateTime FechaFin)
        {
            DbCommand command = Context.Database.GetStoredProcCommand("dbo.GetReporteAfiliados");
            if (FechaInicio == default(DateTime))
                Context.Database.AddInParameter(command, "@FechaInicio", DbType.DateTime, DBNull.Value);
            else
                Context.Database.AddInParameter(command, "@FechaInicio", DbType.DateTime, FechaInicio);

            if (FechaFin == default(DateTime))
                Context.Database.AddInParameter(command, "@FechaFin", DbType.DateTime, DBNull.Value);
            else
                Context.Database.AddInParameter(command, "@FechaFin", DbType.DateTime, FechaFin);

            return Context.ExecuteReader(command);
        }

        public IDataReader ReportePedidos(DateTime FechaInicio, DateTime FechaFin, int estado, string marca, string campania)
        {
            DbCommand command = Context.Database.GetStoredProcCommand("dbo.GetReportePedidos");
            if (FechaInicio == default(DateTime))
                Context.Database.AddInParameter(command, "@FechaInicio", DbType.DateTime, DBNull.Value);
            else
                Context.Database.AddInParameter(command, "@FechaInicio", DbType.DateTime, FechaInicio);

            if (FechaFin == default(DateTime))
                Context.Database.AddInParameter(command, "@FechaFin", DbType.DateTime, DBNull.Value);
            else
                Context.Database.AddInParameter(command, "@FechaFin", DbType.DateTime, FechaFin);


            if (estado == 0 || estado == -1)
                Context.Database.AddInParameter(command, "@estado", DbType.Int16, DBNull.Value);
            else
                Context.Database.AddInParameter(command, "@estado", DbType.Int16, estado);


            if (string.IsNullOrEmpty(marca))
                Context.Database.AddInParameter(command, "@marca", DbType.String, DBNull.Value);
            else
                Context.Database.AddInParameter(command, "@marca", DbType.String, marca);


            if (string.IsNullOrEmpty(campania))
                Context.Database.AddInParameter(command, "@campania", DbType.String, DBNull.Value);
            else
                Context.Database.AddInParameter(command, "@campania", DbType.String, campania);

            return Context.ExecuteReader(command);
        }

    }
}