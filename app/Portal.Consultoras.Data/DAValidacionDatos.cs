using System;
using System.Data;
using System.Data.Common;
using Portal.Consultoras.Entities;

namespace Portal.Consultoras.Data
{
    public class DAValidacionDatos : DataAccess
    {
        public DAValidacionDatos(int paisId)
            : base(paisId, EDbSource.Portal)
        {
        }

        public IDataReader GetValidacionDatosByTipoEnvioAndUsuario(string tipoEnvio, string codigoUsuario)
        {
            DbCommand command = Context.Database.GetStoredProcCommand("dbo.GetValidacionDatosByTipoEnvioAndUsuario");
            Context.Database.AddInParameter(command, "@CodigoUsuario", DbType.AnsiString, codigoUsuario);
            Context.Database.AddInParameter(command, "@TipoEnvio", DbType.AnsiString, tipoEnvio);

            return Context.ExecuteReader(command);
        }

        public int InsValidacionDatos(BEValidacionDatos validacion)
        {
            DbCommand command = Context.Database.GetStoredProcCommand("dbo.InsValidacionDatos");
            Context.Database.AddInParameter(command, "@TipoEnvio", DbType.AnsiString, validacion.TipoEnvio);
            Context.Database.AddInParameter(command, "@DatoAntiguo", DbType.AnsiString, validacion.DatoAntiguo);
            Context.Database.AddInParameter(command, "@DatoNuevo", DbType.AnsiString, validacion.DatoNuevo);
            Context.Database.AddInParameter(command, "@CodigoUsuario", DbType.AnsiString, validacion.CodigoUsuario);
            Context.Database.AddInParameter(command, "@Estado", DbType.AnsiString, validacion.Estado);
            Context.Database.AddInParameter(command, "@UsuarioCreacion", DbType.AnsiString, validacion.UsuarioCreacion);

            return Convert.ToInt32(Context.ExecuteScalar(command));
        }

        public void UpdValidacionDatos(BEValidacionDatos validacion)
        {
            DbCommand command = Context.Database.GetStoredProcCommand("dbo.UpdValidacionDatos");
            Context.Database.AddInParameter(command, "@ValidacionId", DbType.Int64, validacion.ValidacionId);
            Context.Database.AddInParameter(command, "@DatoAntiguo", DbType.AnsiString, validacion.DatoAntiguo);
            Context.Database.AddInParameter(command, "@DatoNuevo", DbType.AnsiString, validacion.DatoNuevo);
            Context.Database.AddInParameter(command, "@Estado", DbType.AnsiString, validacion.Estado);
            Context.Database.AddInParameter(command, "@CampaniaActivacionEmail", DbType.Int32, validacion.CampaniaActivacionEmail);
            Context.Database.AddInParameter(command, "@UsuarioModificacion", DbType.AnsiString, validacion.UsuarioModificacion);

            Context.ExecuteNonQuery(command);
        }

        public int DelValidacionDatos(string codigoUsuario, string tipoEnvio)
        {
            DbCommand command = Context.Database.GetStoredProcCommand("dbo.DelValidacionDatos");
            Context.Database.AddInParameter(command, "@CodigoUsuario", DbType.AnsiString, codigoUsuario);
            Context.Database.AddInParameter(command, "@TipoEnvio", DbType.AnsiString, tipoEnvio);

            return Context.ExecuteNonQuery(command);
        }
    }
}
