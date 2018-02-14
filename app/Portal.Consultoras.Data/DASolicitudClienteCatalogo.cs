using System;
using System.Data;
using System.Data.Common;

namespace Portal.Consultoras.Data
{
    public class DASolicitudClienteCatalogo : DataAccess
    {
        public DASolicitudClienteCatalogo(int paisID)
            : base(paisID, EDbSource.Portal)
        {

        }

        public int InsSolicitudClienteCatalogo(string codigoConsultora, string asuntoNotificacion,
            string detalleNotificacion, string campania, string correoCliente, string nombreCliente,
            DateTime fechaRegistro, string telefono, string direccionCliente, bool parametroEsDocumento)
        {
            int result;
            using (DbCommand command = Context.Database.GetStoredProcCommand("dbo.InsSolicitudClienteCatalogo"))
            {
                Context.Database.AddInParameter(command, "@CodigoConsultora", DbType.String, codigoConsultora);
                Context.Database.AddInParameter(command, "@AsuntoNotificacion", DbType.String, asuntoNotificacion);
                Context.Database.AddInParameter(command, "@DetalleNotificacion", DbType.String, detalleNotificacion);
                Context.Database.AddInParameter(command, "@Campania", DbType.String, campania);
                Context.Database.AddInParameter(command, "@CorreoCliente", DbType.String, correoCliente);
                Context.Database.AddInParameter(command, "@NombreCliente", DbType.String, nombreCliente);
                Context.Database.AddInParameter(command, "@FechaRegistro", DbType.DateTime, fechaRegistro);
                Context.Database.AddInParameter(command, "@TelefonoCliente", DbType.String, telefono);
                Context.Database.AddInParameter(command, "@DireccionCliente", DbType.String, direccionCliente);
                Context.Database.AddInParameter(command, "@ParametroEsDocumento", DbType.Boolean, parametroEsDocumento);

                result = Int32.Parse(Context.ExecuteScalar(command).ToString());
            }

            return result;
        }

        public void UpdNotificacionSolicitudClienteCatalogoVisualizacion(long SolicitudClienteCatalogoId)
        {
            DbCommand command = Context.Database.GetStoredProcCommand("dbo.UpdNotificacionSolicitudClienteCatalogoVisualizacion");
            Context.Database.AddInParameter(command, "@SolicitudClienteCatalogoId", DbType.Int64, SolicitudClienteCatalogoId);
            Context.ExecuteNonQuery(command);
        }

        public IDataReader ObtenerDetalleNotificacionCatalogo(long SolicitudClienteCatalogoId)
        {
            DbCommand command = Context.Database.GetStoredProcCommand("dbo.ObtenerDetalleNotificacionCatalogo");
            Context.Database.AddInParameter(command, "@SolicitudClienteCatalogoId", DbType.Int64, SolicitudClienteCatalogoId);

            return Context.ExecuteReader(command);
        }
    }
}
