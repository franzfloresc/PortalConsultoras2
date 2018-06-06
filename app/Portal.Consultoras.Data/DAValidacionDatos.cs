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

        public DataSet GetByUsuarioTipoEnvio(string codigoUsuario, string tipoEnvio)
        {
            DbCommand command = Context.Database.GetStoredProcCommand("dbo.GetValidacionDatos");
            Context.Database.AddInParameter(command, "@CodigoUsuario", DbType.AnsiString, codigoUsuario);
            Context.Database.AddInParameter(command, "@TipoEnvio", DbType.AnsiString, tipoEnvio);

            return Context.ExecuteDataSet(command);
        }

        public int InsValidacionDatos(BEValidacionDatos validacion)
        {
            DbCommand command = Context.Database.GetStoredProcCommand("dbo.InsValidacionDatos");
            Context.Database.AddInParameter(command, "@TipoEnvio", DbType.AnsiString, validacion.TipoEnvio);
            Context.Database.AddInParameter(command, "@DatoAntiguo", DbType.AnsiString, validacion.DatoAntiguo);
            Context.Database.AddInParameter(command, "@DatoNuevo", DbType.AnsiString, validacion.DatoNuevo);
            Context.Database.AddInParameter(command, "@CodigoUsuario", DbType.AnsiString, validacion.CodigoUsuario);
            Context.Database.AddInParameter(command, "@Estado", DbType.AnsiString, validacion.Estado);
            Context.Database.AddInParameter(command, "@CampaniaActivacion", DbType.Int32, validacion.CampaniaActivacion);
            Context.Database.AddInParameter(command, "@FechaCreacion", DbType.DateTime, validacion.FechaCreacion);
            Context.Database.AddInParameter(command, "@UsuarioCreacion", DbType.AnsiString, validacion.UsuarioCreacion);

            return Convert.ToInt32(Context.ExecuteScalar(command));
        }

        public void UpdValidacionDatos(BEValidacionDatos validacion)
        {
            DbCommand command = Context.Database.GetStoredProcCommand("dbo.UpdValidacionDatos");
            Context.Database.AddInParameter(command, "@TipoEnvio", DbType.AnsiString, validacion.TipoEnvio);
            Context.Database.AddInParameter(command, "@DatoAntiguo", DbType.AnsiString, validacion.DatoAntiguo);
            Context.Database.AddInParameter(command, "@DatoNuevo", DbType.AnsiString, validacion.DatoNuevo);
            Context.Database.AddInParameter(command, "@CodigoUsuario", DbType.AnsiString, validacion.CodigoUsuario);
            Context.Database.AddInParameter(command, "@Estado", DbType.AnsiString, validacion.Estado);
            Context.Database.AddInParameter(command, "@CampaniaActivacion", DbType.Int32, validacion.CampaniaActivacion);
            Context.Database.AddInParameter(command, "@FechaCreacion", DbType.DateTime, validacion.UsuarioModificacion);
            Context.Database.AddInParameter(command, "@UsuarioCreacion", DbType.AnsiString, validacion.FechaModificacion);

            Context.ExecuteNonQuery(command);
        }

        public int DelValidacionDatos(string codigoUsuario)
        {
            DbCommand command = Context.Database.GetStoredProcCommand("dbo.DelValidacionDatos");
            Context.Database.AddInParameter(command, "@CodigoUsuario", DbType.Int32, codigoUsuario);

            return Context.ExecuteNonQuery(command);
        }
    }
}
